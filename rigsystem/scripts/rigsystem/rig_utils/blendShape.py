import pymel.core as pm
import maya.api.OpenMaya as om
import maya.cmds as cmds
import json
import re

def getSelectedIndices():
    vtxExpr = re.compile(r"\[(\d+)]")
    indices = set()
    for v in cmds.ls(sl=True, fl=True, type="float3"):
        r = re.search(vtxExpr, v)
        if r:
            indices.add(int(r.group(1)))
    return indices

def getMDagPath(nodeName):
    """Return an MDagPath for the given DAG node name."""
    sel = om.MSelectionList()
    sel.add(nodeName)
    return sel.getDagPath(0)

class BlendShapeHelper(object):
    def __init__(self, blendShape):
        """Initialize helper around an existing blendShape node."""
        self.node = pm.PyNode(blendShape)

    @staticmethod
    def create(geo, name=None):
        """Create a blendShape on geometry and return helper instance."""
        blend = pm.blendShape(geo)[0]
        if name:
            blend.rename(name)
        return BlendShapeHelper(blend)

    def findAvailableBlendTargetIndex(self):
        """Return first free target index in the blendShape weights."""
        idx = 0
        while self.node.w[idx].exists():
            idx += 1
        return idx

    def getTargetName(self, targetIndex):
        """Return alias name for a target index."""
        return pm.aliasAttr(self.node.w[targetIndex], q=True)
    
    def setTargetName(self, targetIndex, name):
        """Set alias name for a target index."""
        pm.aliasAttr(self.node.w[targetIndex], name)

    def getTargets(self):
        """Return mapping of target index to alias name."""
        return {aw.index(): pm.aliasAttr(aw, q=True) for aw in self.node.w}

    def findTarget(self, name):
        """Return target index for alias name, if found."""
        for aw in self.node.w:
            if pm.aliasAttr(aw, q=True) == name:
                return aw.index()

    def addTarget(self, targetName):
        """Add an internal target and return its index."""
        geo = self.node.getOutputGeometry()[0]
        newIdx = self.findAvailableBlendTargetIndex()

        # Add internal target via temporary physical mesh.
        tmp = pm.duplicate(geo, n=targetName)[0]
        pm.blendShape(self.node, e=True, target=(geo, newIdx, targetName, 1.0))
        pm.delete(tmp)
        return newIdx

    def setTargetValue(self, targetIndexOrName, value):
        """Set target channel value by index or alias."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)
        self.node.w[targetIndex].set(value)

    def getTargetValue(self, targetIndexOrName):
        """Get target channel value by index or alias."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)
        return self.node.w[targetIndex].get()

    def getWeights(self):
        """Return base per-vertex blendShape weights."""
        numVertices = self.node.getOutputGeometry()[0].numVertices()
        weights = [0] * numVertices
        for i in range(numVertices):
            weights[i] = cmds.getAttr("{}.inputTarget[0].baseWeights[{}]".format(self.node, i))
        return weights

    def setWeights(self, weights):
        """Set base per-vertex blendShape weights."""
        numVertices = self.node.getOutputGeometry()[0].numVertices()
        assert len(weights) == numVertices, "Number of weights must match number of vertices"
        for i in range(numVertices):
            if weights[i] == 1.0: # by defaults weights = 1
                cmds.removeMultiInstance("{}.inputTarget[0].baseWeights[{}]".format(self.node, i), b=True)
            else:
                cmds.setAttr("{}.inputTarget[0].baseWeights[{}]".format(self.node, i), weights[i])

    def resetWeights(self):
        """Clear base per-vertex blendShape weights."""        
        numVertices = self.node.getOutputGeometry()[0].numVertices()
        for i in range(numVertices):
            cmds.removeMultiInstance("{}.inputTarget[0].baseWeights[{}]".format(self.node, i), b=True)            

    def getTargetWeights(self, targetIndexOrName):
        """Return per-vertex weights for a target."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        numVertices = self.node.getOutputGeometry()[0].numVertices()
        weights = [0] * numVertices
        for i in range(numVertices):
            weights[i] = cmds.getAttr("{}.inputTarget[0].inputTargetGroup[{}].targetWeights[{}]".format(self.node, targetIndex, i))
        return weights

    def setTargetWeights(self, targetIndexOrName, weights):
        """Set per-vertex weights for a target."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        numVertices = self.node.getOutputGeometry()[0].numVertices()
        assert len(weights) == numVertices, "Number of weights must match number of vertices"
        for i in range(numVertices):
            if weights[i] == 1.0: # by defaults weights = 1
                cmds.removeMultiInstance("{}.inputTarget[0].inputTargetGroup[{}].targetWeights[{}]".format(self.node, targetIndex, i), b=True)
            else:
                cmds.setAttr("{}.inputTarget[0].inputTargetGroup[{}].targetWeights[{}]".format(self.node, targetIndex, i), weights[i])

    def resetTargetWeights(self, targetIndexOrName):
        """Clear target per-vertex blendShape weights."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        numVertices = self.node.getOutputGeometry()[0].numVertices()
        for i in range(numVertices):
            cmds.removeMultiInstance("{}.inputTarget[0].inputTargetGroup[{}].targetWeights[{}]".format(self.node, targetIndex, i), b=True)            

    def getTargetDelta(self, targetIndexOrName):
        """Return target delta vertex indices and point deltas."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        targetDeltas = self.node.inputTarget[0].inputTargetGroup[targetIndex].inputTargetItem[6000].inputPointsTarget.get()
        targetComponentsPlug = self.node.inputTarget[0].inputTargetGroup[targetIndex].inputTargetItem[6000].inputComponentsTarget.__apimplug__()

        targetIndices = []
        componentList = pm.api.MFnComponentListData(targetComponentsPlug.asMObject())
        compTargetIndices = pm.api.MIntArray()
        for i in range(componentList.length()):
            singleIndexFn = pm.api.MFnSingleIndexedComponent(componentList[i])
            singleIndexFn.getElements(compTargetIndices)
            targetIndices.extend(compTargetIndices)

        return targetIndices, [list(p) for p in targetDeltas]

    def setTargetDelta(self, targetIndexOrName, indices, deltas, useSelection=True):
        """Set sparse target deltas from vertex indices and vectors."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        data = dict(zip(indices, deltas))

        if useSelection:
            selectedIndices = getSelectedIndices()
            if selectedIndices:
                existingIndices, existingDeltas = self.getTargetDelta(targetIndex)

                for existingIdx, existingDelta in zip(existingIndices, existingDeltas):
                    if existingIdx not in selectedIndices:
                        data[existingIdx] = existingDelta

        # optimize deltas
        data = {
            idx: delta 
            for idx, delta in data.items() 
            if om.MVector(delta).length() >= 1e-3
        }

        targetComponents = ["vtx[%d]" % v for v in data.keys()]
        newDeltas = list(data.values())
        self.node.inputTarget[0].inputTargetGroup[targetIndex].inputTargetItem[6000].inputPointsTarget.set(len(newDeltas), *newDeltas, type="pointArray")
        self.node.inputTarget[0].inputTargetGroup[targetIndex].inputTargetItem[6000].inputComponentsTarget.set(len(targetComponents), *targetComponents, type="componentList")

    def resetTargetDelta(self, targetIndexOrName):
        """Reset target deltas to a zeroed default entry."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        indices, _ = self.getTargetDelta(targetIndex)
        deltas = [[0, 0, 0] for _ in indices]
        self.setTargetDelta(targetIndex, indices, deltas)

    def copyTargetDelta(self, sourceTargetIndexOrName, destTargetIndexOrName):
        """Copy target delta data from one target to another."""
        sourceTargetIndex = self.findTarget(sourceTargetIndexOrName) if isinstance(sourceTargetIndexOrName, str) else sourceTargetIndexOrName
        if sourceTargetIndex is None:
            raise ValueError("Source target not found: %s" % sourceTargetIndexOrName)

        destTargetIndex = self.findTarget(destTargetIndexOrName) if isinstance(destTargetIndexOrName, str) else destTargetIndexOrName
        if sourceTargetIndex is None:
            raise ValueError("Destination target not found: %s" % destTargetIndexOrName)

        sourceIndices, sourceDeltas = self.getTargetDelta(sourceTargetIndex)
        self.setTargetDelta(destTargetIndex, sourceIndices, sourceDeltas)

    def scaleTargetDelta(self, targetIndexOrName, scaleFactor):
        """Scale all target deltas by a factor."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        indices, deltas = self.getTargetDelta(targetIndex)
        deltas = [[x * scaleFactor, y * scaleFactor, z * scaleFactor] for x, y, z in deltas]
        self.setTargetDelta(targetIndex, indices, deltas)

    def editTarget(self, targetIndexOrName, points):
        """Edit target by applying full point positions."""
        outputGeom = self.node.getOutputGeometry()[0]
        numVertices = outputGeom.numVertices()
        assert len(points) == numVertices, "Number of weights must match number of vertices"

        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        selectedIndices = getSelectedIndices()

        inp = self.node.w[targetIndex].inputs(p=True)
        if inp:
            inp[0] // self.node.w[targetIndex]
        else:
            inp = self.node.w[targetIndex].get()

        self.node.w[targetIndex].set(1)
        pm.sculptTarget(self.node, e=True, target=targetIndex)
        
        meshFn = om.MFnMesh(getMDagPath(outputGeom.name()))
        if selectedIndices:
            currentPoints = meshFn.getPoints(om.MSpace.kObject)
            for idx in selectedIndices:
                currentPoints[idx] = om.MPoint(*points[idx])
            meshFn.setPoints(currentPoints)
        else:
            meshFn.setPoints([om.MPoint(*p) for p in points])
            
        pm.sculptTarget(self.node, e=True, target=targetIndex)

        if pm.objExists(inp):
            self.node.w[targetIndex] >> inp
        else:
            self.node.w[targetIndex].set(inp)

    def mirrorTarget(self, targetIndexOrName, flip=False, tolerance=1e-3):
        """Mirror target deltas across X with optional flip behavior."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError("Target not found: %s" % targetIndexOrName)

        inputMesh = str(self.node.inputShapeAtIndex(0))
        meshDagPath = getMDagPath(inputMesh)
        meshFn = om.MFnMesh(meshDagPath)
        basePoints = meshFn.getPoints(om.MSpace.kWorld)

        meshIntersector = om.MMeshIntersector()
        meshIntersector.create(meshDagPath.node(), meshDagPath.inclusiveMatrix())

        targetIndices, targetDeltas = self.getTargetDelta(targetIndex)
        oldDeltas = {}
        for idx, delta in zip(targetIndices, targetDeltas):
            oldDeltas[idx] = om.MPoint(delta)

        newDeltas = {}
        for i in range(len(basePoints)):
            mirroredP = om.MPoint(basePoints[i])
            mirroredP.x *= -1
            pom = meshIntersector.getClosestPoint(mirroredP)

            vertices3 = meshFn.getPolygonTriangleVertices(pom.face, pom.triangle)
            u, v = pom.barycentricCoords
            w = 1 - u - v

            wp = om.MPoint()
            for wt, vtx in zip([u, v, w], vertices3):
                wp += oldDeltas.get(vtx, om.MPoint(0, 0, 0)) * wt
            wp.x *= -1

            if (wp - om.MPoint()).length() > tolerance:
                newDeltas[i] = wp

        if not flip:
            for i in oldDeltas:
                newDeltas[i] = oldDeltas[i] if i not in newDeltas else [a + b for a, b in zip(oldDeltas[i], newDeltas[i])]

        self.setTargetDelta(targetIndex, list(newDeltas.keys()), list(newDeltas.values()))

    def saveToFile(self, filename):
        """Save blend shape weights and targets to file."""
        data = {"baseWeights": self.getWeights(), "targets":{}}

        targets = data["targets"]

        for idx in self.getTargets():
            targets[idx] = {
                "name": self.getTargetName(idx), 
                "delta":self.getTargetDelta(idx), 
                "weights": self.getTargetWeights(idx),
            }

        with open(filename, "w") as f:
            json.dump(data, f)

    def loadFromFile(self, filename):
        """Load blend shape weights and targets from file."""
        with open(filename, "r") as f:
            data = json.load(f)

        self.setWeights(data["baseWeights"])
        targets = data["targets"]

        for idx in targets:
            item = targets[idx]

            tgt = self.findTarget(item["name"])
            if tgt is None:
                idx = self.addTarget(item["name"])

            self.setTargetDelta(idx, *item["delta"])
            self.setTargetWeights(idx, item["weights"])
