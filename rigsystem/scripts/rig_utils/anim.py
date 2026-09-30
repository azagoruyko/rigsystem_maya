import math
import random

import pymel.core as pm
import maya.api.OpenMaya as om

from . import matrix as matrixUtils
from . import mesh as meshUtils
from .blendShape import BlendShapeHelper
from .naming import findSymmetricName, isLeftSide, isRightSide

def getMDagPath(nodeName):
    """Return an MDagPath for the given DAG node name."""
    sel = om.MSelectionList()
    sel.add(nodeName)
    return sel.getDagPath(0)

def isAnimated(attr):
    """Return True if the given attribute has animation."""
    return pm.api.MAnimUtil.isAnimated(pm.PyNode(attr).__apimplug__())

def getAnimCurveData(animCurve):
    """
    Get an animation curve (animCurve) data as a list.
    """
    animCurve = pm.PyNode(animCurve)
    curveType = pm.nodeType(animCurve)

    data = []
    for i in range(pm.keyframe(animCurve, q=True, kc=True)):
        if curveType in ["animCurveTA", "animCurveTL", "animCurveTT", "animCurveTU"]:
            time = pm.keyframe(animCurve, index=i, q=True, tc=True) # time based curves
        else:
            time = pm.keyframe(animCurve, index=i, q=True, fc=True) # unit based curves

        value = pm.keyframe(animCurve, index=i, q=True, vc=True)

        tangentNames = pm.keyTangent(animCurve, index=[i], q=True, itt=True, ott=True)
        tangentValues = pm.keyTangent(animCurve, index=[i], q=True, ix=True, ox=True, iy=True, oy=True)
        locks = pm.keyTangent(animCurve, index=[i], q=True, wt=True, l=True, wl=True)

        data.append([time[0], value[0], tangentNames, tangentValues, locks])

    return curveType, animCurve.preInfinity.get(), animCurve.postInfinity.get(), data

def makeAnimCurve(data, name=""):
    """
    Make an animation curve with data privided.
    """
    curveType, preinf, postinf, keyData = data

    animCurve = pm.createNode(curveType, n="%s_%s"%(name, curveType) if name else curveType)
    animCurve.preInfinity.set(preinf)
    animCurve.postInfinity.set(postinf)

    for i, frameData in enumerate(keyData):
        time, value, tangentNames, tangentValues, locks = frameData
        itt, ott = tangentNames
        ix, ox, iy, oy = tangentValues
        wt, l, wl = locks

        if curveType in ["animCurveTA", "animCurveTL", "animCurveTT", "animCurveTU"]:
            pm.setKeyframe(animCurve, t=[time], v=value)
        else:
            pm.setKeyframe(animCurve, f=[time], v=value)

        pm.keyTangent(animCurve, index=[i], wt=wt)
        if wl:
            pm.keyTangent(animCurve, index=[i], wl=wl)
        if l:
            pm.keyTangent(animCurve, index=[i], l=l)
        pm.keyTangent(animCurve, index=[i], itt=itt, ott=ott)
        pm.keyTangent(animCurve, index=[i], ix=ix, ox=ox, iy=iy, oy=oy)

    return animCurve

def createSoftIKAnimCurve(name):
    """Create and return a preset Soft IK animation curve."""
    softIKData = ["animCurveUU", 0, 1, [[0.8993431925773621, 1.0, ["fixed", "fixed"],
                                         [0.28632286190986633, 0.28632307052612305, 0.011662350036203861, 0.01166236400604248],
                                         [True, True, False]],[1.5, 1.5, ["fixed", "fixed"],
                                         [1.4915778636932373, 2.243647336959839, 1.4919474124908447, 2.244203567504883],
                                         [True, True, False]], [100.0, 100.0, ["linear", "linear"], [1.5, 0, 1.5, 0.0],
                                         [True, True, True]]]]
    return makeAnimCurve(softIKData, name)

def appendMirrorAnimation(joints, bindFrame, startFrame, endFrame, insertFrame):
    """Append mirrored joint animation into a target frame range."""
    def setMatrixAndKeyframe(joint, matrix, ws=True):
        """Apply a matrix, preserve scale, and key transforms."""
        scale = pm.getAttr(joint + ".s")
        pm.xform(joint, ws=ws, m=matrix)
        pm.setAttr(joint + ".s", scale)
        pm.setKeyframe(joint + ".t")
        pm.setKeyframe(joint + ".r")

    symmetricJoints = {}
    for joint in joints:
        joint = str(joint)
        if isLeftSide(joint):
            mirrorJoint = findSymmetricName(joint)
            if pm.objExists(mirrorJoint):
                symmetricJoints[joint] = mirrorJoint
        elif not isRightSide(joint):
            symmetricJoints[joint] = joint

    leftJoints = set(symmetricJoints.keys())
    rightJoints = set(symmetricJoints.values())

    getMatrix = lambda joint, ws=True: om.MMatrix(pm.xform(joint, q=True, ws=ws, m=True))
    getMatrices = lambda ws=True: {joint: getMatrix(joint, ws) for joint in leftJoints | rightJoints}

    pm.currentTime(bindFrame)
    bindMatrices = getMatrices()
    localBindMatrices = getMatrices(False)

    framesMatrices = []
    for frame in range(startFrame, endFrame + 1):
        pm.currentTime(frame)
        framesMatrices.append(getMatrices())

    for idx in range(endFrame - startFrame + 1):
        pm.currentTime(insertFrame + idx)

        sortedLeft = sorted(leftJoints, key=lambda name: len(pm.PyNode(name).getAllParents()))
        for leftJoint in sortedLeft:
            rightJoint = symmetricJoints[leftJoint]
            matrix = matrixUtils.mirrorMatrixByDelta(bindMatrices[leftJoint], framesMatrices[idx][leftJoint], bindMatrices[rightJoint])
            setMatrixAndKeyframe(rightJoint, matrix)

            if leftJoint != rightJoint:
                setMatrixAndKeyframe(leftJoint, localBindMatrices[leftJoint], False)

    pm.filterCurve(leftJoints | rightJoints)

def appendMirrorMeshAnimation(mesh, bindFrame, startFrame, endFrame, insertFrame):
    """Create and animate a mirrored mesh over the requested range."""
    pm.currentTime(bindFrame)
    mesh = str(mesh)

    animMesh = pm.duplicate(mesh, n=mesh + "_mirrored")[0].name()
    meshFn = om.MFnMesh(getMDagPath(mesh))

    framePoints = {}
    for frame in range(startFrame, endFrame + 1):
        pm.currentTime(frame)
        framePoints[frame] = meshFn.getPoints(om.MSpace.kWorld)
        framePoints[insertFrame + frame - 1] = meshUtils.mirrorMeshPoints(animMesh, mesh)

    animateMeshWithBlendShape(animMesh, framePoints)
    return animMesh

def animateMeshWithTargets(targets):
    """Animate a mesh by turning target meshes into blend-shape frames."""
    animMesh = pm.duplicate(targets[0], n=targets[0] + "_anim")[0].name()
    framePoints = {idx: om.MFnMesh(getMDagPath(targets[idx])).getPoints(om.MSpace.kWorld) for idx in range(len(targets))}
    frameNames = {idx: targets[idx] for idx in range(len(targets))}
    animateMeshWithBlendShape(animMesh, framePoints, names=frameNames)
    return animMesh

def animateMeshWithBlendShape(mesh, framePoints, *, names=None):
    """Build a frame-driven blend shape from point samples."""
    blendShape = BlendShapeHelper(pm.blendShape(mesh)[0])
    basePoints = om.MFnMesh(getMDagPath(mesh)).getPoints(om.MSpace.kWorld)
    meshInvMat = om.MMatrix(pm.getAttr(mesh + ".im"))

    exprs = []
    for frame, points in framePoints.items():
        frameName = (names or {}).get(frame, "frame" + str(frame))
        deltas = [(point - basePoint) * meshInvMat for basePoint, point in zip(basePoints, points)]
        idx = blendShape.addTarget(frameName)
        blendShape.setTargetDelta(idx, range(len(basePoints)), deltas)
        exprs.append("{0}.{1} = time1.outTime == {2};".format(blendShape.node.name(), frameName, frame))

    pm.expression(s="\n".join(exprs), n=mesh + "_frames_expression")
    return blendShape.node

def interpColor(weight):
    """Map a normalized weight to a heat-map color."""
    heatMap = {
        0: [0, 0, 0],
        0.01: [0, 0, 1],
        0.25: [0, 1, 0],
        0.5: [1, 1, 0],
        0.75: [1, 0.5, 0],
        0.99: [1, 0, 0],
        1: [1, 1, 1],
    }

    if weight >= 1:
        return heatMap[1]
    if weight <= 0:
        return heatMap[0]

    heatKeys = list(heatMap.keys())
    for i in range(len(heatKeys)):
        if weight <= heatKeys[i]:
            coeff = (weight - heatKeys[i - 1]) / (heatKeys[i] - heatKeys[i - 1])
            c = heatMap[heatKeys[i]]
            c1 = heatMap[heatKeys[i - 1]]
            r = c[0] * coeff + c1[0] * (1 - coeff)
            g = c[1] * coeff + c1[1] * (1 - coeff)
            b = c[2] * coeff + c1[2] * (1 - coeff)
            return [r, g, b]

def computeRMSE(sourcePoints, targetPoints):
    """Compute root-mean-square error between two point arrays."""
    assert len(sourcePoints) == len(targetPoints)
    numPoints = len(sourcePoints)
    sumSqErr = 0
    for idx in range(numPoints):
        sumSqErr += (sourcePoints[idx] - targetPoints[idx]).length() ** 2
    return math.sqrt(sumSqErr / numPoints)

def computeMeshRMSE(sourceMesh, targetMesh):
    """Compute mesh-level RMSE using world-space vertex points."""
    sourceFn = om.MFnMesh(getMDagPath(sourceMesh))
    targetFn = om.MFnMesh(getMDagPath(targetMesh))
    sourcePoints = sourceFn.getPoints(om.MSpace.kWorld)
    targetPoints = targetFn.getPoints(om.MSpace.kWorld)
    return computeRMSE(sourcePoints, targetPoints)

def visualizeRMSE(mesh, targetMesh, startFrame, endFrame, colorSet="rmse"):
    """Visualize per-vertex RMSE as vertex colors across a frame range."""
    meshFn = om.MFnMesh(getMDagPath(mesh))
    targetMeshFn = om.MFnMesh(getMDagPath(targetMesh))

    numVertices = meshFn.numVertices
    numFrames = endFrame - startFrame + 1
    sumSqErr = [0] * numVertices

    for frame in range(startFrame, endFrame + 1):
        pm.currentTime(frame)
        meshPoints = meshFn.getPoints(om.MSpace.kWorld)
        cachePoints = targetMeshFn.getPoints(om.MSpace.kWorld)
        for idx in range(numVertices):
            sumSqErr[idx] += (meshPoints[idx] - cachePoints[idx]).length() ** 2

    rmse = [math.sqrt(value / numFrames) for value in sumSqErr]
    maxRmse = max(rmse)
    weightedRmse = [value / maxRmse for value in rmse]

    allColorSets = pm.polyColorSet(mesh, acs=True, q=True) or []
    if colorSet not in allColorSets:
        pm.polyColorSet(mesh, create=True, clamped=True, rpt="RGBA", colorSet=colorSet)
    pm.polyColorSet(mesh, currentColorSet=True, colorSet=colorSet)

    vertexColors = [om.MColor()] * numVertices
    for idx in range(numVertices):
        vertexColors[idx] = interpColor(weightedRmse[idx])

    meshFn.setVertexColors(vertexColors, range(numVertices))

def generateRandomAnimation(joint, startFrame, endFrame, tx=None, ty=None, tz=None, rx=None, ry=None, rz=None):
    """Set random keyed transform values on a joint."""
    randFunc = lambda minVal, maxVal: random.random() * (maxVal - minVal) + minVal

    for frame in range(startFrame, endFrame + 1):
        attrs = [("tx", tx), ("ty", ty), ("tz", tz), ("rx", rx), ("ry", ry), ("rz", rz)]
        for attr, value in attrs:
            if type(value) in [list, tuple] and len(value) == 2:
                minVal, maxVal = value
                pm.setKeyframe("{}.{}".format(joint, attr), time=frame, value=randFunc(minVal, maxVal))
