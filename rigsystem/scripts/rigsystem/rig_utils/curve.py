import json
import os

import maya.api.OpenMaya as om

from .. import proxy
from .general import getColorByName, lockTRS

cmds = proxy.cmds

CurvesPath = os.path.join(os.path.dirname(__file__), "curveShapes")


from .naming import findSymmetricName


def unlockTRS(obj):
    """Unlock transform attributes so they can be keyed."""
    lockTRS(proxy.node(obj), t=0, r=0, s=0, v=None)


def shapeParent(objects):
    """Parent shapes of all but the last object to the last; remove intermediate transforms."""
    if not objects or len(objects) == 1:
        cmds.error("Select at least 2 object to make parenting")

    parent = proxy.node(objects[-1])
    for obj in proxy.nodes(objects[:-1]):
        unlockTRS(obj)

        obj = parent | obj

        children = obj.getChildren(type="transform")
        if children:
            cmds.delete(children)

        objShapes = obj.getShapes()
        cmds.makeIdentity(obj, apply=True, t=True, r=True, s=True, n=False)

        for i, shape in enumerate(objShapes):
            shape = proxy.node(cmds.parent(shape, parent, r=True, shape=True)[0])
            shapeName = str(parent).rsplit("|", 1)[-1]
            shape.rename(f"{shapeName}Shape{i + 1}")

        cmds.delete(obj)

    return parent


def saveCurveData(curve, curveType):
    """Save NURBS curve data to JSON in the curves folder."""
    data = []
    for shape in proxy.node(curve).getShapes():
        curveFn = shape.mfn(shape=True)

        cvs = curveFn.cvPositions(om.MSpace.kObject)
        knots = curveFn.knots()

        curveData = {}
        curveData["degree"] = curveFn.degree
        curveData["cvs"] = [[cv.x, cv.y, cv.z] for cv in cvs]
        curveData["knots"] = list(knots)

        curveForms = {om.MFnNurbsCurve.kOpen: 0,
                      om.MFnNurbsCurve.kClosed: 1,
                      om.MFnNurbsCurve.kPeriodic: 2}
        curveData["form"] = curveForms[curveFn.form]

        data.append(curveData)

    with open(os.path.join(CurvesPath, f"{curveType}.json"), "w") as f:
        json.dump(data, f)


def loadCurveData(curveType):
    """Load curve data JSON for the given curve type."""
    with open(os.path.join(CurvesPath, f"{curveType}.json"), "r") as f:
        return json.load(f)


def createCurveFromData(curveData):
    """Create a NURBS curve from saved curve data dict."""
    return proxy.node(cmds.curve(p=curveData["cvs"], d=curveData["degree"], k=curveData["knots"], per=False))


def makeFromCurve(parent, otherCurve):
    """Duplicate otherCurve, match the duplicate's transform to the source, shape-parent it under parent and return the shapes."""
    crv = proxy.node(otherCurve)
    parent = proxy.node(parent)
    dup = proxy.node(cmds.duplicate(crv)[0])
    unlockTRS(dup)
    for attr in ("t", "r", "s"):
        dup.attr(attr).set(crv.attr(attr).get()[0])

    # transfer lineWidth
    crvShapes = crv.getShapes()
    dupShapes = dup.getShapes()
    for crvSh, dupSh in zip(crvShapes, dupShapes):
        dupSh.lineWidth.set(crvSh.lineWidth.get())

    return proxy.node(shapeParent([dup, parent])).getShapes()


def makeCurve(name, curveType):
    """Create a curve helper from saved data; set color by left/right side."""
    curvePath = os.path.join(CurvesPath, f"{curveType}.json")
    if not os.path.exists(curvePath):
        cmds.error(f"makeCurve: cannot find '{curveType}' curve type")

    curves = [createCurveFromData(d) for d in loadCurveData(curveType)]
    crv = shapeParent(curves) if len(curves) > 1 else curves[0]

    color = getColorByName(name)
    crv = proxy.node(crv).rename(name)
    for shape in crv.getShapes():
        shape.overrideEnabled.set(True)
        shape.overrideColor.set(color)

    return crv


def mirrorCurveShape(curve):
    """
    Find opposite curve using naming.findSymmetricName, check topology,
    and mirror CV positions from curve to its opposite counterpart.
    """
    srcNode = proxy.node(curve)
    if srcNode.type() == "nurbsCurve":
        srcNode = srcNode.getParent(fullPath=True)
    src = str(srcNode)

    destName = findSymmetricName(src)
    if destName == src:
        cmds.warning(f"mirrorCurveShape: No symmetric counterpart name pattern found for '{src}'")
        return None

    if not cmds.objExists(destName):
        cmds.warning(f"mirrorCurveShape: Opposite curve '{destName}' does not exist")
        return None

    dest = destName

    srcNode = proxy.node(src)
    destNode = proxy.node(dest)
    srcShapes = srcNode.getShapes(type="nurbsCurve")
    destShapes = destNode.getShapes(type="nurbsCurve")

    if len(srcShapes) != len(destShapes):
        cmds.warning(f"mirrorCurveShape: Shape count mismatch between '{src}' ({len(srcShapes)}) and '{dest}' ({len(destShapes)})")
        return None

    for sShape, dShape in zip(srcShapes, destShapes):
        srcCVs = sShape.controlPoints.get(size=True)
        destCVs = dShape.controlPoints.get(size=True)
        if srcCVs != destCVs:
            cmds.warning(f"mirrorCurveShape: Topology mismatch - CV count differs between '{sShape}' ({srcCVs}) and '{dShape}' ({destCVs})")
            return None
        srcDegree = sShape.degree.get()
        destDegree = dShape.degree.get()
        if srcDegree != destDegree:
            cmds.warning(f"mirrorCurveShape: Topology mismatch - Degree differs between '{sShape}' ({srcDegree}) and '{dShape}' ({destDegree})")
            return None

    for sourceShape, destinationShape in zip(srcShapes, destShapes):
        for i in range(sourceShape.controlPoints.get(size=True)):
            point = cmds.xform(f"{sourceShape}.cv[{i}]", q=True, ws=True, t=True)
            point[0] *= -1.0
            cmds.xform(f"{destinationShape}.cv[{i}]", ws=True, t=point)

    return dest
