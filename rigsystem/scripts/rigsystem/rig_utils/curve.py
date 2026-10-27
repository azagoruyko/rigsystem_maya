import json
import os

import pymel.api as api
import pymel.core as pm

from .general import getColorByName

CurvesPath = os.path.join(os.path.dirname(__file__), "curveShapes")


from .naming import findSymmetricName


def unlockTRS(obj):
    """Unlock transform attributes so they can be keyed."""
    for a in ["tx", "ty", "tz", "t", "rx", "ry", "rz", "r", "sx", "sy", "sz", "s"]:
        pm.setAttr(obj.attr(a), k=True, l=False)


def shapeParent(objects):
    """Parent shapes of all but the last object to the last; remove intermediate transforms."""
    if not objects or len(objects) == 1:
        pm.error("Select at least 2 object to make parenting")
        return

    parent = objects[-1]
    for obj in objects[:-1]:
        unlockTRS(obj)

        parent | obj

        pm.delete(pm.listRelatives(obj, s=False, type="transform"))

        objShapes = pm.listRelatives(obj, s=True)
        pm.makeIdentity(obj, apply=True, t=1, r=1, s=1, n=0)

        for i, s in enumerate(objShapes):
            pm.parent(s, parent, r=True, shape=True)
            s.rename("{}Shape{}".format(parent, i + 1))

        pm.delete(obj)

    return parent


def saveCurveData(curve, curveType):
    """Save NURBS curve data to JSON in the curves folder."""
    curve = pm.PyNode(curve)

    data = []
    for shape in curve.getShapes():
        curve = api.MFnNurbsCurve(shape.__apimobject__())

        cvs = api.MPointArray()
        curve.getCVs(cvs)

        knots = api.MDoubleArray()
        curve.getKnots(knots)

        curveData = {}
        curveData["degree"] = curve.degree()
        curveData["cvs"] = [[cvs[i].x, cvs[i].y, cvs[i].z] for i in range(cvs.length())]
        curveData["knots"] = [knots[i] for i in range(knots.length())]

        curveForms = {api.MFnNurbsCurve.kOpen: 0,
                      api.MFnNurbsCurve.kClosed: 1,
                      api.MFnNurbsCurve.kPeriodic: 2}
        curveData["form"] = curveForms[curve.form()]

        data.append(curveData)

    with open(os.path.join(CurvesPath, f"{curveType}.json"), "w") as f:
        json.dump(data, f)


def loadCurveData(curveType):
    """Load curve data JSON for the given curve type."""
    with open(os.path.join(CurvesPath, f"{curveType}.json"), "r") as f:
        return json.load(f)


def createCurveFromData(curveData):
    """Create a NURBS curve from saved curve data dict."""
    return pm.curve(p=curveData["cvs"], d=curveData["degree"], k=curveData["knots"], per=False)


def makeFromCurve(parent, otherCurve):
    """Duplicate otherCurve, match the duplicate's transform to the source, shape-parent it under parent and return the shapes."""
    crv = pm.PyNode(otherCurve)
    dup = crv.duplicate()[0]
    unlockTRS(dup)
    dup.t.set(crv.t.get())
    dup.r.set(crv.r.get())
    dup.s.set(crv.s.get())

    # transfer lineWidth
    for crvSh, dupSh in zip(crv.getShapes(), dup.getShapes()):
        dupSh.lineWidth.set(crvSh.lineWidth.get())

    return shapeParent([dup, parent]).getShapes()


def makeCurve(name, curveType):
    """Create a curve helper from saved data; set color by left/right side."""
    curvePath = os.path.join(CurvesPath, f"{curveType}.json")
    if not os.path.exists(curvePath):
        pm.error(f"makeCurve: cannot find '{curveType}' curve type")
        return

    curves = [createCurveFromData(d) for d in loadCurveData(curveType)]
    crv = shapeParent(curves) if len(curves) > 1 else curves[0]

    color = getColorByName(name)
    crv.rename(name)
    for sh in crv.getShapes():
        sh.overrideEnabled.set(True)
        sh.overrideColor.set(color)

    return crv


def mirrorCurveShape(curve):
    """
    Find opposite curve using naming.findSymmetricName, check topology,
    and mirror CV positions from curve to its opposite counterpart.
    """
    src = pm.PyNode(curve)
    if isinstance(src, pm.nt.NurbsCurve):
        src = src.getParent()

    destName = findSymmetricName(src.name())
    if destName == src.name():
        pm.warning(f"mirrorCurveShape: No symmetric counterpart name pattern found for '{src.name()}'")
        return None

    if not pm.objExists(destName):
        pm.warning(f"mirrorCurveShape: Opposite curve '{destName}' does not exist")
        return None

    dest = pm.PyNode(destName)

    srcShapes = [s for s in src.getShapes() if not s.isIntermediate() and isinstance(s, pm.nt.NurbsCurve)]
    destShapes = [s for s in dest.getShapes() if not s.isIntermediate() and isinstance(s, pm.nt.NurbsCurve)]

    if len(srcShapes) != len(destShapes):
        pm.warning(f"mirrorCurveShape: Shape count mismatch between '{src}' ({len(srcShapes)}) and '{dest}' ({len(destShapes)})")
        return None

    for sShape, dShape in zip(srcShapes, destShapes):
        if sShape.numCVs() != dShape.numCVs():
            pm.warning(f"mirrorCurveShape: Topology mismatch - CV count differs between '{sShape}' ({sShape.numCVs()}) and '{dShape}' ({dShape.numCVs()})")
            return None
        if sShape.degree() != dShape.degree():
            pm.warning(f"mirrorCurveShape: Topology mismatch - Degree differs between '{sShape}' ({sShape.degree()}) and '{dShape}' ({dShape.degree()})")
            return None

    for sShape, dShape in zip(srcShapes, destShapes):
        for i in range(sShape.numCVs()):
            p = pm.xform(f"{sShape}.cv[{i}]", q=True, ws=True, t=True)
            p[0] *= -1.0
            pm.xform(f"{dShape}.cv[{i}]", ws=True, t=p)

    return dest