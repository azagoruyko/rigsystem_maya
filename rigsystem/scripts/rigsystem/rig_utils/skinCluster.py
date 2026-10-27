import json

import maya.api.OpenMaya as om
import maya.api.OpenMayaAnim as oma
import maya.cmds as cmds
import pymel.core as pm

def getMObject(nodeName):
    """Return an MObject for the given dependency node name."""
    sel = om.MSelectionList()
    sel.add(nodeName)
    return sel.getDependNode(0)

def getMDagPath(nodeName):
    """Return an MDagPath for the given DAG node name."""
    sel = om.MSelectionList()
    sel.add(nodeName)
    return sel.getDagPath(0)

def duplicateSkinMesh(srcSkinMesh):
    """Duplicate a skinned mesh and copy its skin weights."""
    destSkinMesh = pm.duplicate(srcSkinMesh, n=srcSkinMesh + "_copy", rc=True)[0]
    srcSkin = SkinClusterHelper(srcSkinMesh)
    pm.skinCluster(destSkinMesh, srcSkin.getInfluences(), tsb=True)
    destSkin = SkinClusterHelper(destSkinMesh)
    destSkin.setSkinWeights(srcSkin.getSkinWeights())
    destSkin.setDqWeights(srcSkin.getDqWeights())
    destSkin.setSkinningMethod(srcSkin.getSkinningMethod())
    return destSkinMesh


def moveSkinToParentBones():
    """Move selected joints' skin weights to their parent joints."""
    joints = pm.ls(sl=True, type="joint")
    if not joints:
        pm.warning("Select joints to move skin weights from.")
        return

    joints.sort(key=lambda joint: len(joint.getAllParents()), reverse=True)
    skinClusters = {}

    for joint in joints:
        parent = joint.getParent()
        if not isinstance(parent, pm.nodetypes.Joint):
            pm.warning("Joint '{}' has no joint parent. Skipping.".format(joint.name()))
            continue

        for skinCluster in set(joint.listConnections(type="skinCluster")):
            skinClusters.setdefault(skinCluster.name(), []).append(joint)

    for skinClusterName, skinJoints in skinClusters.items():
        helper = SkinClusterHelper(skinClusterName)
        skinJoints = [joint for joint in skinJoints
                      if helper.getInfluencePhysicalIndex(joint) is not None]
        if not skinJoints:
            continue

        missingParents = list({joint.getParent() for joint in skinJoints
                               if helper.getInfluencePhysicalIndex(joint.getParent()) is None})
        if missingParents:
            pm.skinCluster(skinClusterName, e=True, ai=missingParents, wt=0)
            helper = SkinClusterHelper(skinClusterName)

        weights = helper.getSkinWeights()
        for joint in skinJoints:
            childIndex = helper.getInfluencePhysicalIndex(joint)
            parentIndex = helper.getInfluencePhysicalIndex(joint.getParent())
            weights.mergeInfluences(childIndex, parentIndex)

        helper.setSkinWeights(weights)
        pm.skinCluster(skinClusterName, e=True, ri=skinJoints)


def getAllComponents(dagPath):
    """Returns a valid, populated MObject component for any geometry type.
    
    Guarantees no NULL pointer errors in both setWeights and getBlendWeights.
    """
    # Ensure we are operating on the Shape node, not the Transform node
    localDag = om.MDagPath(dagPath)
    if localDag.hasFn(om.MFn.kTransform):
        localDag.extendToShape()
        
    apiType = localDag.apiType()
    
    # Initialize the single indexed component function set
    compFn = om.MFnSingleIndexedComponent()
    
    # 1. Polygon Mesh
    if apiType == om.MFn.kMesh:
        meshFn = om.MFnMesh(localDag)
        components = compFn.create(om.MFn.kMeshVertComponent)
        compFn.addElements(range(meshFn.numVertices))
        return components
        
    # 2. NURBS Curve
    elif apiType == om.MFn.kNurbsCurve:
        curveFn = om.MFnNurbsCurve(localDag)
        components = compFn.create(om.MFn.kCurveCVComponent)
        compFn.addElements(range(curveFn.numCVs))
        return components
        
    # 3. NURBS Surface
    elif apiType == om.MFn.kNurbsSurface:
        surfFn = om.MFnNurbsSurface(localDag)
        compFn = om.MFnDoubleIndexedComponent()
        components = compFn.create(om.MFn.kSurfaceCVComponent)
        
        # Add elements for all U and V coordinate combinations
        for u in range(surfFn.numCVsInU):
            for v in range(surfFn.numCVsInV):
                compFn.addElement(u, v)
        return components
        
    # 4. Lattice
    elif apiType == om.MFn.kLattice:
        latticeFn = om.MFnLattice(localDag)
        s, t, u = latticeFn.getDivisions()
        components = compFn.create(om.MFn.kLatticeComponent)
        compFn.addElements(range(s * t * u))
        return components
        
    # Fallback to empty MObject if geometry is unrecognized
    else:
        return om.MObject()


class SkinWeights:
    def __init__(self, weights, numInf):
        """Store flat skin weights and influence count."""
        self.weights = weights
        self._numInf = numInf
        self._numVertices = int(len(weights) / self._numInf)

    def numInfluences(self):
        """Return number of influences per vertex."""
        return self._numInf

    def numVertices(self):
        """Return number of vertices represented in this data."""
        return self._numVertices

    def copy(self):
        """Return a shallow copy of this SkinWeights object."""
        return SkinWeights(self.weights[:], self._numInf)

    def getVertexWeight(self, vertexId, infId):
        """Return weight value for one vertex-influence pair."""
        return self.weights[vertexId * self._numInf + infId]

    def setVertexWeight(self, vertexId, infId, weight):
        """Set weight value for one vertex-influence pair."""
        self.weights[vertexId * self._numInf + infId] = weight

    def getVertexWeights(self, vertexId):
        """Return all influence weights for a vertex."""
        return self.weights[vertexId * self._numInf:(vertexId + 1) * self._numInf]

    def setVertexWeights(self, vertexId, weights):
        """Set all influence weights for a vertex."""
        assert len(weights) == self._numInf, "Number of weights must match number of influences"
        for i, w in enumerate(weights):
            self.weights[vertexId * self._numInf + i] = w

    def getInfluenceWeights(self, infId):
        """Return all vertex weights for one influence."""
        return list(self.weights)[infId::self._numInf]

    def setInfluenceWeights(self, infId, weights):
        """Set all vertex weights for one influence."""
        assert len(weights) == self._numVertices, "Number of weights must match number of vertices"
        for i, w in enumerate(weights):
            self.weights[i * self._numInf + infId] = w

    def clearInfluenceWeights(self, infId):
        """Zero all weights for one influence."""
        for i in range(self._numVertices):
            self.weights[i * self._numInf + infId] = 0

    def clearWeights(self):
        """Zero all stored skin weights."""
        self.weights = [0] * len(self.weights)

    def mergeInfluences(self, srcInfId, destInfId):
        """Accumulate source influence weights into destination influence."""
        for i in range(self._numVertices):
            self.weights[i * self._numInf + destInfId] += self.weights[i * self._numInf + srcInfId]
            self.weights[i * self._numInf + srcInfId] = 0

    def merge(self, otherSkinWeights, alpha=1.0):
        """Add weighted values from another SkinWeights instance."""
        assert self._numInf == otherSkinWeights._numInf, "Number of influences must match"
        assert self._numVertices == otherSkinWeights._numVertices, "Number of vertices must match"

        alphaWeights = [1.0] * len(self.weights)
        if type(alpha) in [int, float]:
            alphaWeights = [alpha] * len(self.weights)
        elif type(alpha) == list:
            assert len(alpha) == len(self.weights), "Number of weights must match number of influences"
            alphaWeights = alpha

        for i in range(len(self.weights)):
            self.weights[i] += alphaWeights[i] * otherSkinWeights.weights[i]

    def getUnusedInfluences(self, threshold=1e-4):
        """Return influence indices whose total weight is below threshold."""
        return [i for i in range(self._numInf) if sum(self.getInfluenceWeights(i)) < threshold]

    def normalize(self):
        """Normalize vertex weights so each vertex sums to one."""
        for i in range(self._numVertices):
            total = sum(self.getVertexWeights(i))
            if total > 1e-4:
                for j in range(self._numInf):
                    self.weights[i * self._numInf + j] /= total

    def getAffectedIndices(self, infId):
        """Return vertex indices affected by the given influence."""
        return [i for i in range(self._numVertices) if self.getVertexWeight(i, infId) > 1e-4]

    def pruneSmallWeights(self, threshold=1e-3):
        """Zero weights below the provided threshold."""
        for i in range(self._numVertices):
            for j in range(self._numInf):
                if self.weights[i * self._numInf + j] < threshold:
                    self.weights[i * self._numInf + j] = 0

    def setMaxInfluence(self, maxInf):
        """Clamp each vertex to at most maxInf active influences."""        
        for vtxId in range(self._numVertices):
            base = vtxId * self._numInf
            vtxWeights = self.weights[base:base + self._numInf]

            # Indices sorted by weight descending - keep only the top maxInf
            ranked = sorted(range(self._numInf), key=lambda j: vtxWeights[j], reverse=True)
            keepSet = set(ranked[:maxInf])

            for j in range(self._numInf):
                if j not in keepSet:
                    self.weights[base + j] = 0.0

            # Renormalize the surviving weights
            total = sum(self.weights[base + j] for j in keepSet)
            if total > 1e-4:
                for j in keepSet:
                    self.weights[base + j] /= total

class SkinWeightsUndoStack:
    _cache = {} # per skinCluster
    isUndoing = False

    @classmethod
    def push(cls, skinName, skinWeights, dqWeights=None):
        if cls.isUndoing:
            return
        if skinName not in cls._cache:
            cls._cache[skinName] = []
        cls._cache[skinName].append((skinWeights, dqWeights))

    @classmethod
    def canUndo(cls, skinName):
        return skinName in cls._cache and len(cls._cache[skinName]) > 0

    @classmethod
    def undo(cls, skinName):
        if skinName in cls._cache:
            cls._is_undoing = True
            skinHelper = SkinClusterHelper(skinName)
            weights, dqWeights = cls._cache[skinName].pop()
            skinHelper.setSkinWeights(weights)
            if dqWeights is not None:
                skinHelper.setDqWeights(dqWeights)
            cls._is_undoing = False

class SkinClusterHelper:
    def __init__(self, obj):
        """Wrap MFnSkinCluster access for a mesh or skinCluster node."""
        if pm.objectType(obj) == "skinCluster":
            self._skinFn = oma.MFnSkinCluster(getMObject(obj))
            outGeom = pm.PyNode(obj).getOutputGeometry()[0]
            self._objDagPath = getMDagPath(outGeom.getParent().name())
        else:
            self._objDagPath = getMDagPath(str(obj))
            self._skinFn = oma.MFnSkinCluster(getMObject(pm.mel.eval("findRelatedSkinCluster " + obj)))

    def mesh(self):
        """Return the mesh path name associated with the skin cluster."""
        return self._objDagPath.partialPathName()

    def node(self):
        """Return the skinCluster node name."""
        return self._skinFn.name()

    def getInfluenceLogicalIndex(self, inf):
        """Return logical influence index for the given influence."""
        infDagPath = getMDagPath(str(inf))
        if infDagPath in self._skinFn.influenceObjects():
            return self._skinFn.indexForInfluenceObject(infDagPath)

    def getInfluencePhysicalIndex(self, inf):
        """Return physical influence index for the given influence."""
        infDagPath = getMDagPath(str(inf))
        for i, infNode in enumerate(self._skinFn.influenceObjects()):
            if infNode == infDagPath:
                return i

    def getInfluences(self):
        """Return influence names used by this skin cluster."""
        return [inf.partialPathName() for inf in self._skinFn.influenceObjects()]

    def getSkinWeights(self):
        """Return full skin weights wrapped as SkinWeights."""
        weights, numInf = self._skinFn.getWeights(self._objDagPath, om.MObject())
        return SkinWeights(weights, numInf)

    def getInfluenceWeights(self, inf):
        """Return vertex weights for one influence."""
        return self.getSkinWeights().getInfluenceWeights(self.getInfluencePhysicalIndex(inf))

    def setInfluenceWeights(self, inf, weights):
        """Set vertex weights for one influence."""
        skinWeights = self.getSkinWeights()
        skinWeights.setInfluenceWeights(self.getInfluencePhysicalIndex(inf), weights)
        self.setSkinWeights(skinWeights)

    def clearInfluenceWeights(self, inf):
        """Clear all weights for one influence."""
        skinWeights = self.getSkinWeights()
        skinWeights.clearInfluenceWeights(self.getInfluencePhysicalIndex(inf))
        self.setSkinWeights(skinWeights)

    def setSkinWeights(self, skinWeights):
        """Write SkinWeights data back to the skin cluster."""
        SkinWeightsUndoStack.push(self._skinFn.name(), self.getSkinWeights(), self.getDqWeights())

        components = getAllComponents(self._objDagPath)

        influences = om.MIntArray(range(len(self._skinFn.influenceObjects())))
        weights = om.MDoubleArray(skinWeights.weights)
        self._skinFn.setWeights(self._objDagPath, components, influences, weights)

    def getDqWeights(self):
        """Return dual quaternion weights for all vertices."""
        components = getAllComponents(self._objDagPath)
        return list(self._skinFn.getBlendWeights(self._objDagPath, components))

    def setDqWeights(self, dqWeights):
        """Set dual quaternion weights for all vertices."""
        SkinWeightsUndoStack.push(self._skinFn.name(), self.getSkinWeights(), self.getDqWeights())
        components = getAllComponents(self._objDagPath)
        mDqWeights = om.MDoubleArray(dqWeights)
        self._skinFn.setBlendWeights(self._objDagPath, components, mDqWeights)

    def clearDqWeights(self):
        """Zero all stored dual quaternion weights."""
        count = om.MItGeometry(self._objDagPath).count
        self.setDqWeights([0.0] * count)

    def fillDqWeights(self, value):
        """Fill all dual quaternion weights with a constant value."""
        assert 0.0 <= value <= 1.0, "Dual quaternion weight must be between 0.0 and 1.0"
        count = om.MItGeometry(self._objDagPath).count
        self.setDqWeights([value] * count)

    def getSkinningMethod(self):
        """Return skinning method attribute (0=Linear, 1=Dual Quaternion, 2=Weight Blended)."""
        return cmds.getAttr(self.node() + ".skinningMethod")

    def setSkinningMethod(self, method):
        """Set skinning method attribute (0=Linear, 1=Dual Quaternion, 2=Weight Blended)."""
        assert method in [0, 1, 2], "Skinning method must be 0 (Linear), 1 (Dual Quaternion), or 2 (Weight Blended)"
        cmds.setAttr(self.node() + ".skinningMethod", method)

    def getUnusedInfluences(self):
        """Return influence names with no significant contribution."""
        skinWeights = self.getSkinWeights()
        influences = self.getInfluences()
        return [influences[idx] for idx in skinWeights.getUnusedInfluences()]

    def updateBindMatrices(self):
        """Update bindPreMatrix values from current influence matrices."""
        node = pm.PyNode(self.node())
        for inf in self.getInfluences():
            idx = self.getInfluenceLogicalIndex(inf)
            node.bindPreMatrix[idx].set(node.matrix[idx].get().inverse())

    def gotoBindPose(self):
        """Move influences to stored bind pose matrices."""
        bindPreMatrix = pm.PyNode(self.node()).bindPreMatrix
        for j in sorted(self.getInfluences(), key=lambda n: len(pm.PyNode(n).getAllParents())):
            idx = self.getInfluenceLogicalIndex(j)
            m = bindPreMatrix[idx].get().inverse()
            pm.xform(j, ws=True, m=m)

    def toJson(self):
        """Return skin weights as a JSON-serializable mapping."""
        skinWeights = self.getSkinWeights()
        influences = self.getInfluences()
        numInfs = len(influences)

        cmds.progressWindow(title="Exporting Skin Weights", progress=0, status="Preparing...", isInterruptable=True)

        weights = {}
        try:
            for i, inf in enumerate(influences):
                if cmds.progressWindow(query=True, isCancelled=True):
                    break
                progressPercent = int((i / float(numInfs)) * 100)
                cmds.progressWindow(edit=True, progress=progressPercent, status="Exporting influence: {}".format(inf))

                weights[inf] = skinWeights.getInfluenceWeights(self.getInfluencePhysicalIndex(inf))
        finally:
            cmds.progressWindow(endProgress=True)

        dqWeights = self.getDqWeights() if self.getSkinningMethod() == 2 else []

        return {"weights": weights, "skinningMethod": self.getSkinningMethod(), "dqWeights": dqWeights}
        
    def fromJson(self, data):
        """Apply weights from a JSON-style influence mapping."""
        # Cache current state for undo
        SkinWeightsUndoStack.push(self._skinFn.name(), self.getSkinWeights(), self.getDqWeights())
        
        # Suspend push to undo stack during inner calls
        isUndoing = SkinWeightsUndoStack.isUndoing
        SkinWeightsUndoStack.isUndoing = True

        items = list(data["weights"].items())
        numItems = len(items)

        cmds.progressWindow(title="Importing Skin Weights", progress=0, status="Preparing...", isInterruptable=True)

        try:
            skinWeights = self.getSkinWeights()
            skinWeights.clearWeights()

            for i, (inf, weights) in enumerate(items):
                if cmds.progressWindow(query=True, isCancelled=True):
                    break
                progressPercent = int((i / float(numItems)) * 100)
                cmds.progressWindow(edit=True, progress=progressPercent, status="Importing influence: {}".format(inf))

                if inf in self.getInfluences():
                    skinWeights.setInfluenceWeights(self.getInfluencePhysicalIndex(inf), weights)

            self.setSkinWeights(skinWeights)

            self.setSkinningMethod(data["skinningMethod"])
            if self.getSkinningMethod() == 2 and "dqWeights" in data:
                self.setDqWeights(data["dqWeights"])
        finally:
            cmds.progressWindow(endProgress=True)
            SkinWeightsUndoStack.isUndoing = isUndoing

    def saveToFile(self, filePath):
        """Save skin weights to a JSON file."""
        with open(filePath, "w") as f:
            json.dump(self.toJson(), f)

    def loadFromFile(self, filePath):
        """Load skin weights from a JSON file."""
        with open(filePath, "r") as f:
            weights = json.load(f)
        self.fromJson(weights)
