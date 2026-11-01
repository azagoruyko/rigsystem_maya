import maya.api.OpenMaya as om
import json
import re

from .. import proxy

cmds = proxy.cmds

def getSelectedIndices():
    vtxExpr = re.compile(r"\[(\d+)]")
    indices = set()
    for v in cmds.ls(sl=True, fl=True, type="float3") or []:
        r = re.search(vtxExpr, v)
        if r:
            indices.add(int(r.group(1)))
    return indices

class BlendShapeHelper(object):
    def __init__(self, blendShape):
        """Initialize helper around an existing blendShape node."""
        self.node = proxy.node(blendShape)


    @staticmethod
    def create(geo, name=None):
        """Create a blendShape on geometry and return helper instance."""
        blend = cmds.blendShape(geo)[0]
        if name:
            blend = cmds.rename(blend, name)
        return BlendShapeHelper(blend)


    def findAvailableBlendTargetIndex(self):
        """Return first free target index in the blendShape weights."""
        idx = 0
        used = set(cmds.getAttr(self.node.weight, multiIndices=True) or [])
        while idx in used:
            idx += 1
        return idx


    def getTargetName(self, targetIndex):
        """Return alias name for a target index."""
        return cmds.aliasAttr(self.node.weight[targetIndex], q=True)

    
    def setTargetName(self, targetIndex, name):
        """Set alias name for a target index."""
        cmds.aliasAttr(name, self.node.weight[targetIndex])


    def getGeometry(self):
        """Return the first geometry affected by this blendShape."""
        geometry = cmds.blendShape(self.node, query=True, geometry=True)[0]
        return proxy.node(geometry)


    def getTargets(self):
        """Return mapping of target index to alias name."""
        aliases = cmds.aliasAttr(self.node, q=True) or []
        return {int(plug.split("[")[1].split("]")[0]): alias for alias, plug in zip(aliases[::2], aliases[1::2])}


    def findTarget(self, name):
        """Return target index for alias name, if found."""
        for index, alias in self.getTargets().items():
            if alias == name:
                return index


    def addTarget(self, targetName):
        """Add an internal target and return its index."""
        geo = self.getGeometry()
        newIdx = self.findAvailableBlendTargetIndex()

        # Add internal target via temporary physical mesh.
        tmp = cmds.duplicate(geo, n=targetName)[0]
        cmds.blendShape(self.node, e=True, target=(geo, newIdx, targetName, 1.0))
        cmds.delete(tmp)
        return newIdx


    def setTargetValue(self, targetIndexOrName, value):
        """Set target channel value by index or alias."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")
        self.node.weight[targetIndex].set(value)


    def getTargetValue(self, targetIndexOrName):
        """Get target channel value by index or alias."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")
        return self.node.weight[targetIndex].get()


    def getWeights(self):
        """Return base per-vertex blendShape weights."""
        numVertices = cmds.polyEvaluate(self.getGeometry(), v=True)
        weights = [0] * numVertices
        baseWeights = self.node.attr("inputTarget[0].baseWeights")
        for i in range(numVertices):
            weights[i] = baseWeights[i].get()
        return weights


    def setWeights(self, weights):
        """Set base per-vertex blendShape weights."""
        numVertices = cmds.polyEvaluate(self.getGeometry(), v=True)
        assert len(weights) == numVertices, "Number of weights must match number of vertices"
        baseWeights = self.node.attr("inputTarget[0].baseWeights")
        for i in range(numVertices):
            if weights[i] == 1.0: # by defaults weights = 1
                cmds.removeMultiInstance(baseWeights[i], b=True)
            else:
                baseWeights[i].set(weights[i])


    def resetWeights(self):
        """Clear base per-vertex blendShape weights."""        
        numVertices = cmds.polyEvaluate(self.getGeometry(), v=True)
        baseWeights = self.node.attr("inputTarget[0].baseWeights")
        for i in range(numVertices):
            cmds.removeMultiInstance(baseWeights[i], b=True)


    def getTargetWeights(self, targetIndexOrName):
        """Return per-vertex weights for a target."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

        numVertices = cmds.polyEvaluate(self.getGeometry(), v=True)
        weights = [0] * numVertices
        targetWeights = self.node.attr(f"inputTarget[0].inputTargetGroup[{targetIndex}].targetWeights")
        for i in range(numVertices):
            weights[i] = targetWeights[i].get()
        return weights


    def setTargetWeights(self, targetIndexOrName, weights):
        """Set per-vertex weights for a target."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

        numVertices = cmds.polyEvaluate(self.getGeometry(), v=True)
        assert len(weights) == numVertices, "Number of weights must match number of vertices"
        targetWeights = self.node.attr(f"inputTarget[0].inputTargetGroup[{targetIndex}].targetWeights")
        for i in range(numVertices):
            if weights[i] == 1.0: # by defaults weights = 1
                cmds.removeMultiInstance(targetWeights[i], b=True)
            else:
                targetWeights[i].set(weights[i])


    def resetTargetWeights(self, targetIndexOrName):
        """Clear target per-vertex blendShape weights."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        numVertices = cmds.polyEvaluate(self.getGeometry(), v=True)
        targetWeights = self.node.attr(f"inputTarget[0].inputTargetGroup[{targetIndex}].targetWeights")
        for i in range(numVertices):
            cmds.removeMultiInstance(targetWeights[i], b=True)


    def getTargetDelta(self, targetIndexOrName):
        """Return target delta vertex indices and point deltas."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

        item = f"inputTarget[0].inputTargetGroup[{targetIndex}].inputTargetItem[6000]"
        targetDeltas = cmds.getAttr(self.node.attr(f"{item}.inputPointsTarget")) or []
        components = cmds.getAttr(self.node.attr(f"{item}.inputComponentsTarget")) or []

        targetIndices = []
        for component in components:
            start, _, end = component.removeprefix("vtx[").removesuffix("]").partition(":")
            targetIndices.extend(range(int(start), int(end) + 1) if end else [int(start)])

        return targetIndices, [list(p) for p in targetDeltas]


    def setTargetDelta(self, targetIndexOrName, indices, deltas, useSelection=True):
        """Set sparse target deltas from vertex indices and vectors."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

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
            if om.MVector(delta[0], delta[1], delta[2]).length() >= 1e-3
        }

        targetComponents = [f"vtx[{v}]" for v in data]
        newDeltas = [tuple(delta) if len(delta) == 4 else (*delta, 1.0) for delta in data.values()]
        item = f"inputTarget[0].inputTargetGroup[{targetIndex}].inputTargetItem[6000]"
        cmds.setAttr(self.node.attr(f"{item}.inputPointsTarget"), len(newDeltas), *newDeltas, type="pointArray")
        cmds.setAttr(self.node.attr(f"{item}.inputComponentsTarget"), len(targetComponents), *targetComponents, type="componentList")


    def resetTargetDelta(self, targetIndexOrName):
        """Reset target deltas to a zeroed default entry."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

        indices, _ = self.getTargetDelta(targetIndex)
        deltas = [[0, 0, 0] for _ in indices]
        self.setTargetDelta(targetIndex, indices, deltas)


    def copyTargetDelta(self, sourceTargetIndexOrName, destTargetIndexOrName):
        """Copy target delta data from one target to another."""
        sourceTargetIndex = self.findTarget(sourceTargetIndexOrName) if isinstance(sourceTargetIndexOrName, str) else sourceTargetIndexOrName
        if sourceTargetIndex is None:
            raise ValueError(f"Source target not found: {sourceTargetIndexOrName}")

        destTargetIndex = self.findTarget(destTargetIndexOrName) if isinstance(destTargetIndexOrName, str) else destTargetIndexOrName
        if sourceTargetIndex is None:
            raise ValueError(f"Destination target not found: {destTargetIndexOrName}")

        sourceIndices, sourceDeltas = self.getTargetDelta(sourceTargetIndex)
        self.setTargetDelta(destTargetIndex, sourceIndices, sourceDeltas)


    def scaleTargetDelta(self, targetIndexOrName, scaleFactor):
        """Scale all target deltas by a factor."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

        indices, deltas = self.getTargetDelta(targetIndex)
        deltas = [[x * scaleFactor, y * scaleFactor, z * scaleFactor] for x, y, z in deltas]
        self.setTargetDelta(targetIndex, indices, deltas)


    def editTarget(self, targetIndexOrName, points):
        """Edit target by applying full point positions."""
        outputGeom = self.getGeometry()
        numVertices = cmds.polyEvaluate(outputGeom, v=True)
        assert len(points) == numVertices, "Number of weights must match number of vertices"

        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

        selectedIndices = getSelectedIndices()

        weightPlug = self.node.weight[targetIndex]
        inputs = weightPlug.inputs()
        if inputs:
            cmds.disconnectAttr(inputs[0], weightPlug)
        else:
            previousValue = weightPlug.get()

        weightPlug.set(1)
        cmds.sculptTarget(self.node, e=True, target=targetIndex)
        
        meshFn = proxy.node(outputGeom).mfn(shape=True)
        if selectedIndices:
            currentPoints = meshFn.getPoints(om.MSpace.kObject)
            for idx in selectedIndices:
                currentPoints[idx] = om.MPoint(*points[idx])
            meshFn.setPoints(currentPoints)
        else:
            meshFn.setPoints([om.MPoint(*p) for p in points])
            
        cmds.sculptTarget(self.node, e=True, target=targetIndex)

        if inputs:
            cmds.connectAttr(inputs[0], weightPlug, force=True)
        else:
            weightPlug.set(previousValue)


    def mirrorTarget(self, targetIndexOrName, flip=False, tolerance=1e-3):
        """Mirror target deltas across X with optional flip behavior."""
        targetIndex = self.findTarget(targetIndexOrName) if isinstance(targetIndexOrName, str) else targetIndexOrName
        if targetIndex is None:
            raise ValueError(f"Target not found: {targetIndexOrName}")

        inputMesh = self.node.attr("input[0].inputGeometry").listConnections(
            source=True,
            destination=False,
            shapes=True,
        )[0]
        inputMeshNode = proxy.node(inputMesh)
        meshDagPath = inputMeshNode.mdagpath
        meshFn = inputMeshNode.mfn(shape=True)
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

        for item in targets.values():
            targetIndex = self.findTarget(item["name"])
            if targetIndex is None:
                targetIndex = self.addTarget(item["name"])

            self.setTargetDelta(targetIndex, *item["delta"])
            self.setTargetWeights(targetIndex, item["weights"])
