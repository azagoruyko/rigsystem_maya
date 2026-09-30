import maya.cmds as cmds
import pymel.api as api
import pymel.core as pm

from rig_utils.moduleInfo import ModuleInfo, getModuleInfo
from rig_utils.general import matchJoint

NAME = "editFKwithIK"


def setOverrideColor(node, colorIdx):
    """Set override display color for all shapes of the node."""
    for sh in node.getShapes():
        sh.overrideColor.set(colorIdx)


def removeUserAttributes(node):
    """Remove all user-defined attributes from the node."""
    for a in node.listAttr(ud=True):
        a.delete()


def setWorldMatrixWithoutUndo(nodePath, matrixValues):
    """Apply world matrix to the node without undo (API)."""
    matrix = api.MMatrix()
    api.MScriptUtil.createMatrixFromList(matrixValues, matrix)

    trm = api.MTransformationMatrix(matrix * nodePath.exclusiveMatrixInverse())
    trfn = api.MFnTransform(nodePath)
    trfn.set(trm)


def attributeChangeCallback(msg, plug, otherPlug, data):
    """Sync FK control world matrices from IK joint positions on attribute change."""
    if msg & api.MNodeMessage.kAttributeSet:
        for jnt, ctrl in data:
            setWorldMatrixWithoutUndo(ctrl.__apimdagpath__(), cmds.xform(jnt.name(), q=True, ws=True, m=True))


def selectionChangedCallback():
    """Hide edit rig when selection no longer includes its manipulators."""
    ls = set(cmds.ls(sl=True))

    controlSet = set([NAME + "_ik_manipulator", NAME + "_ik_polevector_manipulator"])

    if not ls & controlSet:  # manipulators not in selection
        v = NAME + "_group.v"
        if cmds.objExists(v) and cmds.getAttr(v):
            cmds.setAttr(v, False)


def removeRigCallbacks(callbacks):
    """Remove all registered callbacks and clear the list."""
    for c in callbacks:
        api.MMessage.removeCallback(c)

    while callbacks:
        callbacks.pop()


def createRig(moduleInfo):
    """Build temporary IK rig to edit FK limb; sync FK from IK manipulators."""
    if moduleInfo.getAttr("type") != "limb":
        pm.warning("moduleInfo must be of 'limb' type")
        return

    if pm.objExists(NAME + "_group"):
        pm.delete(NAME + "_group")

    if moduleInfo.getAttr("ikfk").get() < 0.5:
        pm.warning("Go to FK kinematics and select FK control to use this tool")
        return

    grp = pm.createNode("transform", n=NAME + "_group")
    grp.hiddenInOutliner.set(True)

    # create IK joints
    getFKJoint = lambda idx: pm.PyNode(moduleInfo.getAttr(f"fk{idx}_joint").node())
    j1 = matchJoint(getFKJoint(1), NAME + "_1_joint")
    j2 = matchJoint(getFKJoint(2), NAME + "_2_joint")
    j3 = matchJoint(getFKJoint(3), NAME + "_3_joint")
    grp | j1 | j2 | j3
    j1.v.set(False)

    ikHandle = pm.ikHandle(sj=j1, ee=j3, n=NAME + "_ikHandle")[0]
    ikHandle.v.set(False)
    grp | ikHandle

    # create IK controls
    # ik control
    ikctrl = moduleInfo.getAttr("ik").node().duplicate()[0]
    ikctrl.rename(NAME + "_ik_manipulator")
    grp | ikctrl
    removeUserAttributes(ikctrl)

    ik_switcher = moduleInfo.getAttr("seamless_switcher_ik").node()
    pm.xform(ikctrl, ws=True, m=pm.xform(ik_switcher, q=True, ws=True, m=True))

    setOverrideColor(ikctrl, 16)

    # polevector control
    polctrl = moduleInfo.getAttr("polevector").node().duplicate()[0]
    polctrl.rename(NAME + "_ik_polevector_manipulator")
    grp | polctrl
    removeUserAttributes(polctrl)

    ik_polevec_switcher = moduleInfo.getAttr("seamless_switcher_polevector").node()
    pm.xform(polctrl, ws=True, m=pm.xform(ik_polevec_switcher, q=True, ws=True, m=True))

    setOverrideColor(polctrl, 16)

    pm.pointConstraint(ikctrl, ikHandle)
    pm.orientConstraint(ikctrl, j3, mo=True)
    pm.poleVectorConstraint(polctrl, ikHandle)

    # setup callbacks
    fk1 = moduleInfo.getAttr("fk1").node()
    fk2 = moduleInfo.getAttr("fk2").node()
    fk3 = moduleInfo.getAttr("fk3").node()
    data = [(j1, fk1), (j2, fk2), (j3, fk3)]

    callbacks = []
    callbacks.append(api.MNodeMessage.addAttributeChangedCallback(ikctrl.__apimobject__(), attributeChangeCallback, data))
    callbacks.append(api.MNodeMessage.addAttributeChangedCallback(polctrl.__apimobject__(), attributeChangeCallback, data))

    controlSet = set([ikctrl.name(), polctrl.name()])

    pm.scriptJob(e=["NewSceneOpened", pm.Callback(removeRigCallbacks, callbacks)], ro=True)
    pm.scriptJob(e=["SceneOpened", pm.Callback(removeRigCallbacks, callbacks)], ro=True)

    pm.select(ikctrl)
    cmds.setToolTo('moveSuperContext')


pm.scriptJob(e=["SelectionChanged", selectionChangedCallback])
