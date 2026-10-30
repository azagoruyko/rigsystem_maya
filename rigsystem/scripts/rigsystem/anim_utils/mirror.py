import maya.api.OpenMaya as om
import maya.cmds as cmds

from rigsystem import proxy
from rigsystem.rig_utils.general import copyAttrs
from rigsystem.rig_utils.moduleInfo import ModuleInfo
from rigsystem.rig_utils.naming import findSymmetricName


def _connectedNode(moduleInfo, name):
    """Return the node connected to a ModuleInfo message attribute."""
    return moduleInfo.getAttr(name).node


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
    centerMatrix = cmds.xform(centerControl, q=True, ws=True, m=True)

    # save matrices
    srcMatrices = []
    destMatrices = []

    for srcCtrl, destCtrl in zip(srcControls, destControls):
        srcCtrlMatrix = cmds.xform(srcCtrl, q=True, ws=True, m=True)
        srcMatrices.append(flipMatrix(srcCtrlMatrix, centerMatrix, axis))

        if exchange:
            destCtrlMatrix = cmds.xform(destCtrl, q=True, ws=True, m=True)
            destMatrices.append(flipMatrix(destCtrlMatrix, centerMatrix, axis))

    for ctrl, m in zip(destControls, srcMatrices):
        cmds.xform(ctrl, ws=True, m=list(m))

    for ctrl, m in zip(srcControls, destMatrices):
        cmds.xform(ctrl, ws=True, m=list(m))


def mirrorControl(srcCtrl, destCtrl, centerCtrl, axis=(-1, 1, 1), exchange=False):
    """Mirror one control to another; optionally swap positions."""
    srcMat = cmds.xform(srcCtrl, q=True, ws=True, m=True)
    centerMat = cmds.xform(centerCtrl, q=True, ws=True, m=True)

    mat = flipMatrix(srcMat, centerMat, axis)

    if exchange and srcCtrl != destCtrl:
        destMat = cmds.xform(destCtrl, q=True, ws=True, m=True)
        cmds.xform(destCtrl, ws=True, m=list(mat))
        cmds.xform(srcCtrl, ws=True, m=list(flipMatrix(destMat, centerMat, axis)))
    else:
        cmds.xform(destCtrl, ws=True, m=list(mat))


def mirrorAttributesWithCoefficient(src, dest, attrs, exchange=False):
    """Copy or exchange attribute values with coefficient (e.g. (-1) for mirror)."""
    source = proxy.node(src)
    destination = proxy.node(dest)
    for a, coeff in attrs:
        srcPlug = source.attr(a)
        destPlug = destination.attr(a)
        if exchange:
            value = srcPlug.get()
            srcPlug.set(coeff * destPlug.get())
            destPlug.set(coeff * value)
        else:
            destPlug.set(coeff * srcPlug.get())


def mirrorSpine(moduleInfo, centerControl, exchange=False):
    """Mirror spine FK/IK/fix controls over center."""
    controls = []
    i = 1
    while moduleInfo.hasAttr(f"fk{i}"):
        controls.append(_connectedNode(moduleInfo, f"fk{i}"))
        i += 1

    if moduleInfo.hasAttr("hip"):
        controls.append(_connectedNode(moduleInfo, "hip"))

    for label in ["ik", "fix"]:
        i = 1
        while moduleInfo.hasAttr(f"{label}{i}"):
            controls.append(_connectedNode(moduleInfo, f"{label}{i}"))
            i += 1

    mirrorControls(controls, controls, centerControl, axis=(-1, 1, 1))


def mirrorHead(moduleInfo, centerControl, exchange=False):
    """Mirror head seamless FK/IK controls over center."""
    controls = []
    i = 1
    while moduleInfo.hasAttr(f"seamless_fk{i}"):
        controls.append(_connectedNode(moduleInfo, f"seamless_fk{i}"))
        i += 1

    for label in ["fk", "ik"]:
        controls.append(_connectedNode(moduleInfo, f"seamless_{label}"))

    mirrorControls(controls, controls, centerControl, axis=(-1, 1, 1))


def mirrorLimb(moduleInfo, mirrorModuleInfo, namespace, rootModuleInfoType, centerControl, exchange=False):
    """Mirror limb IK, pole, FK and optional shoulder to opposite side."""
    ikAxis = [-1, 1, 1] if rootModuleInfoType in ["leg", "quadLeg"] else [-1, -1, -1]

    mirrorControl(_connectedNode(moduleInfo, "ik"), _connectedNode(mirrorModuleInfo, "ik"), centerControl, ikAxis, exchange)
    mirrorControl(_connectedNode(moduleInfo, "polevector"), _connectedNode(mirrorModuleInfo, "polevector"), centerControl, [-1, 1, 1], exchange)

    srcFKControls = [_connectedNode(moduleInfo, f"fk{i}") for i in range(1, 4)]
    destFKControls = [_connectedNode(mirrorModuleInfo, f"fk{i}") for i in range(1, 4)]
    mirrorControls(srcFKControls, destFKControls, centerControl, (-1, -1, -1), exchange)

    copyAttrs(_connectedNode(moduleInfo, "options"), _connectedNode(mirrorModuleInfo, "options"), exchange)

    side = moduleInfo.node.localName().split("_", 1)[0]
    if rootModuleInfoType == "limb" and cmds.objExists(f"{namespace}{side}_shoulder_control"):
        mirrorSide = mirrorModuleInfo.node.localName().split("_", 1)[0]
        mirrorControl(f"{namespace}{side}_shoulder_control", f"{namespace}{mirrorSide}_shoulder_control", centerControl, [-1, -1, -1], exchange)


def mirrorLeg(moduleInfo, mirrorModuleInfo, exchange=False):
    """Mirror leg limb, toe controls and footroll attributes."""
    mirrorByModuleInfo(_connectedNode(moduleInfo, "limb"), exchange)
    copyAttrs(_connectedNode(moduleInfo, "seamless_toe_ik"), _connectedNode(mirrorModuleInfo, "seamless_toe_ik"), exchange)
    copyAttrs(_connectedNode(moduleInfo, "seamless_toe_fk"), _connectedNode(mirrorModuleInfo, "seamless_toe_fk"), exchange)

    srcFootroll = _connectedNode(moduleInfo, "footroll")
    destFootroll = _connectedNode(mirrorModuleInfo, "footroll")
    attrs = [("rx", 1), ("rz", -1), ("weight", 1), ("heelPivot", -1), ("footPivot", -1), ("toePivot", -1)]
    mirrorAttributesWithCoefficient(srcFootroll, destFootroll, attrs, exchange)


def mirrorQuadLeg(moduleInfo, mirrorModuleInfo, exchange=False):
    """Mirror quad leg limb, toe FK and footroll attributes."""
    mirrorByModuleInfo(_connectedNode(moduleInfo, "limb"), exchange)
    copyAttrs(_connectedNode(moduleInfo, "seamless_toe_fk"), _connectedNode(mirrorModuleInfo, "seamless_toe_fk"), exchange)

    srcFootroll = _connectedNode(moduleInfo, "footroll")
    destFootroll = _connectedNode(mirrorModuleInfo, "footroll")
    attrs = [("rx", 1), ("rz", -1), ("roll", 1), ("sideways", -1), ("heelPivot", -1), ("toePivot", -1)]
    mirrorAttributesWithCoefficient(srcFootroll, destFootroll, attrs, exchange)


def mirrorFingers(moduleInfo, mirrorModuleInfo, exchange=False):
    """Mirror finger controls and translate attributes."""
    i = 1
    while moduleInfo.hasAttr(f"control{i}"):
        ctrl = _connectedNode(moduleInfo, f"control{i}")
        mirrorCtrl = _connectedNode(mirrorModuleInfo, f"control{i}")
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
    localName = moduleInfo.node.localName()
    namespace = moduleInfo.node.namespace()
    mirrorLocalName = findSymmetricName(localName)
    mirrorModuleInfo = ModuleInfo(namespace + mirrorLocalName)

    if moduleInfoType == "spine":
        centerControl = kwargs.get("centerControl", f"{namespace}main_control")
        mirrorSpine(moduleInfo, centerControl, exchange)

    elif moduleInfoType == "head":
        centerControl = kwargs.get("centerControl", f"{namespace}main_control")
        mirrorHead(moduleInfo, centerControl, exchange)

    elif moduleInfoType == "limb":
        centerControl = f"{namespace}M_spine_ik_2_control"
        if rootModuleInfoType == "leg":
            centerControl = f"{namespace}M_spine_fk_1_control"
        elif rootModuleInfoType == "quadLeg":
            centerControl = f"{namespace}M_spine_ik_2_control" if "_front_" in localName else f"{namespace}M_spine_ik_1_control"
        centerControl = kwargs.get("centerControl", centerControl)
        mirrorLimb(moduleInfo, mirrorModuleInfo, namespace, rootModuleInfoType, centerControl, exchange)

    elif moduleInfoType == "leg":
        mirrorLeg(moduleInfo, mirrorModuleInfo, exchange)

    elif moduleInfoType == "quadLeg":
        mirrorQuadLeg(moduleInfo, mirrorModuleInfo, exchange)

    elif moduleInfoType == "fingers":
        mirrorFingers(moduleInfo, mirrorModuleInfo, exchange)
