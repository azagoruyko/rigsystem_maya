import maya.api.OpenMaya as om
import pymel.core as pm

from rig_utils.general import copyAttrs
from rig_utils.moduleInfo import ModuleInfo
from rig_utils.naming import findSymmetricName

def flipMatrix(src, center, axis=(-1, 1, 1)):
    """Flip matrix over center; axis is scale applied after (e.g. (-1,1,1) for X mirror)."""
    multList = lambda a, b: [ia * ib for ia, ib in zip(a, b)]

    src = om.MMatrix(src)
    center = om.MMatrix(center)

    centerFn = om.MTransformationMatrix(center)
    scale = centerFn.scale(om.MSpace.kObject)
    centerFn.setScale(multList(scale, [-1, 1, 1]), om.MSpace.kObject)
    centerFlipped = centerFn.asMatrix()

    matFn = om.MTransformationMatrix(src * center.inverse() * centerFlipped)
    matFn.setScale(axis, om.MSpace.kObject)

    return matFn.asMatrix()


def mirrorControls(srcControls, destControls, centerControl, axis=(-1, 1, 1), exchange=False):
    """Apply flipped matrices to dest then optionally exchange with src."""
    centerMatrix = pm.xform(centerControl, q=True, ws=True, m=True)

    # save matrices
    srcMatrices = []
    destMatrices = []

    for srcCtrl, destCtrl in zip(srcControls, destControls):
        srcCtrlMatrix = pm.xform(srcCtrl, q=True, ws=True, m=True)
        srcMatrices.append(flipMatrix(srcCtrlMatrix, centerMatrix, axis))

        if exchange:
            destCtrlMatrix = pm.xform(destCtrl, q=True, ws=True, m=True)
            destMatrices.append(flipMatrix(destCtrlMatrix, centerMatrix, axis))

    for ctrl, m in zip(destControls, srcMatrices):
        pm.xform(ctrl, ws=True, m=m)

    for ctrl, m in zip(srcControls, destMatrices):
        pm.xform(ctrl, ws=True, m=m)


def mirrorControl(srcCtrl, destCtrl, centerCtrl, axis=(-1, 1, 1), exchange=False):
    """Mirror one control to another; optionally swap positions."""
    srcMat = pm.xform(srcCtrl, q=True, ws=True, m=True)
    centerMat = pm.xform(centerCtrl, q=True, ws=True, m=True)

    mat = flipMatrix(srcMat, centerMat, axis)

    if exchange and srcCtrl != destCtrl:
        destMat = pm.xform(destCtrl, q=True, ws=True, m=True)
        pm.xform(destCtrl, ws=True, m=mat)
        pm.xform(srcCtrl, ws=True, m=flipMatrix(destMat, centerMat, axis))
    else:
        pm.xform(destCtrl, ws=True, m=mat)


def mirrorAttributesWithCoefficient(src, dest, attrs, exchange=False):
    """Copy or exchange attribute values with coefficient (e.g. (-1) for mirror)."""
    for a, coeff in attrs:
        if exchange:
            v = src.attr(a).get()
            src.attr(a).set(coeff * dest.attr(a).get())
            dest.attr(a).set(coeff * v)
        else:
            dest.attr(a).set(coeff * src.attr(a).get())


def mirrorSpine(moduleInfo, centerControl, exchange=False):
    """Mirror spine FK/IK/fix controls over center."""
    controls = []
    i = 1
    while moduleInfo.hasAttr("fk" + str(i)):
        controls.append(moduleInfo.getAttr("fk" + str(i)).node())
        i += 1

    if moduleInfo.hasAttr("hip"):
        controls.append(moduleInfo.getAttr("hip").node())

    for label in ["ik", "fix"]:
        i = 1
        while moduleInfo.hasAttr(label + str(i)):
            controls.append(moduleInfo.getAttr(label + str(i)).node())
            i += 1

    mirrorControls(controls, controls, centerControl, axis=(-1, 1, 1))


def mirrorHead(moduleInfo, centerControl, exchange=False):
    """Mirror head seamless FK/IK controls over center."""
    controls = []
    i = 1
    while moduleInfo.hasAttr("seamless_fk" + str(i)):
        controls.append(moduleInfo.getAttr("seamless_fk" + str(i)).node())
        i += 1

    for label in ["fk", "ik"]:
        controls.append(moduleInfo.getAttr("seamless_" + label).node())

    mirrorControls(controls, controls, centerControl, axis=(-1, 1, 1))


def mirrorLimb(moduleInfo, mirrorModuleInfo, namespace, rootModuleInfoType, centerControl, exchange=False):
    """Mirror limb IK, pole, FK and optional shoulder to opposite side."""
    ikAxis = [-1, 1, 1] if rootModuleInfoType in ["leg", "quadLeg"] else [-1, -1, -1]

    mirrorControl(moduleInfo.getAttr("ik").node(), mirrorModuleInfo.getAttr("ik").node(), centerControl, ikAxis, exchange)
    mirrorControl(moduleInfo.getAttr("polevector").node(), mirrorModuleInfo.getAttr("polevector").node(), centerControl, [-1, 1, 1], exchange)

    srcFKControls = [moduleInfo.getAttr("fk1").node(), moduleInfo.getAttr("fk2").node(), moduleInfo.getAttr("fk3").node()]
    destFKControls = [mirrorModuleInfo.getAttr("fk1").node(), mirrorModuleInfo.getAttr("fk2").node(), mirrorModuleInfo.getAttr("fk3").node()]
    mirrorControls(srcFKControls, destFKControls, centerControl, (-1, -1, -1), exchange)

    copyAttrs(moduleInfo.getAttr("options").node(), mirrorModuleInfo.getAttr("options").node(), exchange)

    if rootModuleInfoType == "limb" and pm.objExists(namespace + moduleInfo.node.stripNamespace().split("_")[0] + "_shoulder_control"):
        side = moduleInfo.node.stripNamespace().split("_")[0]
        mirrorSide = mirrorModuleInfo.node.stripNamespace().split("_")[0]
        mirrorControl(namespace + side + "_shoulder_control", mirrorModuleInfo.node.namespace() + mirrorSide + "_shoulder_control", centerControl, [-1, -1, -1], exchange)


def mirrorLeg(moduleInfo, mirrorModuleInfo, exchange=False):
    """Mirror leg limb, toe controls and footroll attributes."""
    mirrorByModuleInfo(moduleInfo.getAttr("limb").node(), exchange)
    copyAttrs(moduleInfo.getAttr("seamless_toe_ik").node(), mirrorModuleInfo.getAttr("seamless_toe_ik").node(), exchange)
    copyAttrs(moduleInfo.getAttr("seamless_toe_fk").node(), mirrorModuleInfo.getAttr("seamless_toe_fk").node(), exchange)

    srcFootroll = moduleInfo.getAttr("footroll").node()
    destFootroll = mirrorModuleInfo.getAttr("footroll").node()
    attrs = [("rx", 1), ("rz", -1), ("weight", 1), ("heelPivot", -1), ("footPivot", -1), ("toePivot", -1)]
    mirrorAttributesWithCoefficient(srcFootroll, destFootroll, attrs, exchange)


def mirrorQuadLeg(moduleInfo, mirrorModuleInfo, exchange=False):
    """Mirror quad leg limb, toe FK and footroll attributes."""
    mirrorByModuleInfo(moduleInfo.getAttr("limb").node(), exchange)
    copyAttrs(moduleInfo.getAttr("seamless_toe_fk").node(), mirrorModuleInfo.getAttr("seamless_toe_fk").node(), exchange)

    srcFootroll = moduleInfo.getAttr("footroll").node()
    destFootroll = mirrorModuleInfo.getAttr("footroll").node()
    attrs = [("rx", 1), ("rz", -1), ("roll", 1), ("sideways", -1), ("heelPivot", -1), ("toePivot", -1)]
    mirrorAttributesWithCoefficient(srcFootroll, destFootroll, attrs, exchange)


def mirrorFingers(moduleInfo, mirrorModuleInfo, exchange=False):
    """Mirror finger controls and translate attributes."""
    i = 1
    while moduleInfo.hasAttr("control{}".format(i)):
        ctrl = moduleInfo.getAttr("control{}".format(i)).node()
        mirrorCtrl = mirrorModuleInfo.getAttr("control{}".format(i)).node()
        copyAttrs(ctrl, mirrorCtrl, exchange)

        attrs = [("tx", -1), ("ty", -1), ("tz", -1)]
        mirrorAttributesWithCoefficient(ctrl, mirrorCtrl, attrs, exchange)
        i += 1


def mirrorByModuleInfo(moduleInfo, exchange=False, **kwargs):
    """Mirror or flip module by type (spine, head, limb, leg, etc.)."""
    if not isinstance(moduleInfo, ModuleInfo):
        moduleInfo = ModuleInfo(moduleInfo)

    rootModuleInfoType = moduleInfo.getRoot().getAttr("type")
    moduleInfoType = moduleInfo.getAttr("type")
    namespace = moduleInfo.node.namespace()
    localName = moduleInfo.node.stripNamespace()
    mirrorLocalName = findSymmetricName(localName)
    mirrorModuleInfo = ModuleInfo(namespace + mirrorLocalName)

    if moduleInfoType == "spine":
        centerControl = kwargs.get("centerControl", namespace + "main_control")
        mirrorSpine(moduleInfo, centerControl, exchange)

    elif moduleInfoType == "head":
        centerControl = kwargs.get("centerControl", namespace + "main_control")
        mirrorHead(moduleInfo, centerControl, exchange)

    elif moduleInfoType == "limb":
        centerControl = namespace + "M_spine_ik_2_control"
        if rootModuleInfoType == "leg":
            centerControl = namespace + "M_spine_fk_1_control"
        elif rootModuleInfoType == "quadLeg":
            centerControl = namespace + ("M_spine_ik_2_control" if "_front_" in moduleInfo.node.name() else "M_spine_ik_1_control")
        centerControl = kwargs.get("centerControl", centerControl)
        mirrorLimb(moduleInfo, mirrorModuleInfo, namespace, rootModuleInfoType, centerControl, exchange)

    elif moduleInfoType == "leg":
        mirrorLeg(moduleInfo, mirrorModuleInfo, exchange)

    elif moduleInfoType == "quadLeg":
        mirrorQuadLeg(moduleInfo, mirrorModuleInfo, exchange)

    elif moduleInfoType == "fingers":
        mirrorFingers(moduleInfo, mirrorModuleInfo, exchange)