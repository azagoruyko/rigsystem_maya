import maya.api.OpenMaya as om

from rigsystem import proxy
from rigsystem.rig_utils.general import matchJoint

cmds = proxy.cmds

NAME = "editFKwithIK"


def setOverrideColor(node, colorIdx):
    """Set override display color for all shapes of the node."""
    for shape in cmds.listRelatives(node, shapes=True, fullPath=True) or []:
        proxy.node(shape).overrideColor.set(colorIdx)


def removeUserAttributes(node):
    """Remove all user-defined attributes from the node."""
    for attr in cmds.listAttr(node, ud=True) or []:
        cmds.deleteAttr(f"{node}.{attr}")


def _dagPath(node):
    return proxy.node(node).dagPath


def setWorldMatrixWithoutUndo(node, matrixValues):
    """Apply world matrix to the node without undo (API)."""
    nodePath = _dagPath(node)
    trm = om.MTransformationMatrix(om.MMatrix(matrixValues) * nodePath.exclusiveMatrixInverse())
    trfn = om.MFnTransform(nodePath)
    trfn.setTransformation(trm)


def attributeChangeCallback(msg, plug, otherPlug, data):
    """Sync FK control world matrices from IK joint positions on attribute change."""
    if msg & om.MNodeMessage.kAttributeSet:
        for jnt, ctrl in data:
            setWorldMatrixWithoutUndo(ctrl, cmds.xform(jnt, q=True, ws=True, m=True))


def selectionChangedCallback():
    """Hide edit rig when selection no longer includes its manipulators."""
    ls = set(cmds.ls(sl=True))

    controlSet = {f"{NAME}_ik_manipulator", f"{NAME}_ik_polevector_manipulator"}

    if not ls & controlSet:  # manipulators not in selection
        v = f"{NAME}_group.v"
        if cmds.objExists(v) and cmds.getAttr(v):
            cmds.setAttr(v, False)


def removeRigCallbacks(callbacks):
    """Remove all registered callbacks and clear the list."""
    for c in callbacks:
        om.MMessage.removeCallback(c)

    while callbacks:
        callbacks.pop()


def createRig(moduleInfo):
    """Build temporary IK rig to edit FK limb; sync FK from IK manipulators."""
    if moduleInfo.getAttr("type") != "limb":
        cmds.warning("moduleInfo must be of 'limb' type")
        return

    if cmds.objExists(f"{NAME}_group"):
        cmds.delete(f"{NAME}_group")

    if moduleInfo.getAttr("ikfk").get() < 0.5:
        cmds.warning("Go to FK kinematics and select FK control to use this tool")
        return

    grp = cmds.createNode("transform", n=f"{NAME}_group")
    proxy.node(grp).hiddenInOutliner.set(True)

    # create IK joints
    getFKJoint = lambda idx: moduleInfo.getAttr(f"fk{idx}_joint").node
    j1 = matchJoint(getFKJoint(1), f"{NAME}_1_joint")
    j2 = matchJoint(getFKJoint(2), f"{NAME}_2_joint")
    j3 = matchJoint(getFKJoint(3), f"{NAME}_3_joint")
    proxy.node(j2) | j3
    proxy.node(j1) | j2
    proxy.node(grp) | j1
    proxy.node(j1).v.set(False)

    ikHandle = cmds.ikHandle(sj=j1, ee=j3, n=f"{NAME}_ikHandle")[0]
    proxy.node(ikHandle).v.set(False)
    proxy.node(grp) | ikHandle

    # create IK controls
    # ik control
    ikctrl = cmds.duplicate(moduleInfo.getAttr("ik").node)[0]
    ikctrl = cmds.rename(ikctrl, f"{NAME}_ik_manipulator")
    proxy.node(grp) | ikctrl
    removeUserAttributes(ikctrl)

    ik_switcher = moduleInfo.getAttr("seamless_switcher_ik").node
    cmds.xform(ikctrl, ws=True, m=cmds.xform(ik_switcher, q=True, ws=True, m=True))

    setOverrideColor(ikctrl, 16)

    # polevector control
    polctrl = cmds.duplicate(moduleInfo.getAttr("polevector").node)[0]
    polctrl = cmds.rename(polctrl, f"{NAME}_ik_polevector_manipulator")
    proxy.node(grp) | polctrl
    removeUserAttributes(polctrl)

    ik_polevec_switcher = moduleInfo.getAttr("seamless_switcher_polevector").node
    cmds.xform(polctrl, ws=True, m=cmds.xform(ik_polevec_switcher, q=True, ws=True, m=True))

    setOverrideColor(polctrl, 16)

    cmds.pointConstraint(ikctrl, ikHandle)
    cmds.orientConstraint(ikctrl, j3, mo=True)
    cmds.poleVectorConstraint(polctrl, ikHandle)

    # setup callbacks
    fk1 = moduleInfo.getAttr("fk1").node
    fk2 = moduleInfo.getAttr("fk2").node
    fk3 = moduleInfo.getAttr("fk3").node
    data = [(j1, fk1), (j2, fk2), (j3, fk3)]

    callbacks = []
    callbacks.append(om.MNodeMessage.addAttributeChangedCallback(_dagPath(ikctrl).node(), attributeChangeCallback, data))
    callbacks.append(om.MNodeMessage.addAttributeChangedCallback(_dagPath(polctrl).node(), attributeChangeCallback, data))

    cmds.scriptJob(e=["NewSceneOpened", lambda *args: removeRigCallbacks(callbacks)], ro=True)
    cmds.scriptJob(e=["SceneOpened", lambda *args: removeRigCallbacks(callbacks)], ro=True)

    cmds.select(ikctrl)
    cmds.setToolTo('moveSuperContext')


if not cmds.about(batch=True):
    cmds.scriptJob(e=["SelectionChanged", selectionChangedCallback])
