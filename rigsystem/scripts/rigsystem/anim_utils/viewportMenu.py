"""RigSystem's viewport menu for selected controls."""
from functools import partial
import os

import maya.api.OpenMaya as om
import maya.mel as mel

from rigsystem import proxy
from .menu import Menu
from .switcher import (
    kinematicSwitchMulti,
    switchAttributeSeamlessly,
    rotateOrderSwitchMulti,
    snapSwitch,
)
from .mirror import mirrorByModuleInfo
from .dynamicParent import (
    DynamicParent,
    hasDynamicParent,
    dynamicParentBake,
    dynamicParentSwitch,
    deleteFromDynamicParent,
    addSelectedToDynamicParent,
)
from .bake import spine_bakeIKtoFK, spine_bakeFKtoIK
from . import editFKwithIK

from rigsystem.rig_utils.general import (
    copyAttrs,
    resetControl,
    resetControls,
    selectControls,
    toggleVisible,
)
from rigsystem.rig_utils.matrix import mirrorBehaviourMatrix
from rigsystem.rig_utils.moduleInfo import ModuleInfo, getModuleInfo
from rigsystem.rig_utils.naming import findSymmetricName, isLeftSide, isRightSide

cmds = proxy.cmds

_originalPostCommands = {}


def buildViewportMenu(parent, object):
    """Build RigSystem's menu for the selected object when it has actions."""
    object = str(object)

    menu = Menu()

    moduleInfo = getModuleInfo(object)
    if moduleInfo:
        menu.mergeMenu(makeMenuByModuleInfo(moduleInfo, object))

    addDefaultMenu(menu, object)

    # Embed menu
    if not menu.isEmpty():
        selected = cmds.ls(sl=True, type="transform", long=True) or []
        objectPath = (cmds.ls(object, long=True) or [object])[0]
        postfix = "... [multi selection]" if len(set(selected + [objectPath])) > 1 else ""
        displayName = str(object).rsplit("|", 1)[-1]

        cmds.menuItem(parent=parent, l=f"{displayName}{postfix}", bld=True, en=True)
        cmds.menuItem(parent=parent, divider=True)

        menu.buildIn(parent)

        return True

    return False


def _postMenuCommand(parent, originalCommand, *mayaArgs):
    """Show RigSystem actions or let Maya build its standard menu."""
    selected = cmds.ls(selection=True, long=True, type="transform") or []
    if selected:
        cmds.menu(parent, edit=True, deleteAllItems=True)
        if buildViewportMenu(parent, selected[-1]):
            return

    mel.eval(originalCommand)


def installViewportMenu():
    """Attach RigSystem to existing Maya viewport menu callbacks."""
    for menuName in cmds.lsUI(menus=True):
        if menuName in _originalPostCommands:
            continue

        originalCommand = cmds.menu(menuName, query=True, postMenuCommand=True)
        if isinstance(originalCommand, str) and "buildObjectMenuItemsNow" in originalCommand:
            _originalPostCommands[menuName] = originalCommand
            cmds.menu(
                menuName,
                edit=True,
                postMenuCommand=partial(_postMenuCommand, menuName, originalCommand),
            )


def uninstallViewportMenu():
    """Restore Maya's viewport menu callbacks."""
    for menuName, originalCommand in _originalPostCommands.items():
        if cmds.menu(menuName, exists=True):
            cmds.menu(menuName, edit=True, postMenuCommand=originalCommand)

    _originalPostCommands.clear()


def simpleMirror(object):
    """Mirror selected controls (left/right sided) including the given object."""
    selected = (cmds.ls(sl=True, type="transform") or []) + [object]

    for ctrl in proxy.nodes(selected):
        namespace = ctrl.namespace()
        ctrl_local = ctrl.localName()
        ctrl_mirrored_local = findSymmetricName(ctrl_local)

        if ctrl_local != ctrl_mirrored_local:
            mirroredCtrl = proxy.node(f"{namespace}{ctrl_mirrored_local}")
            copyAttrs(ctrl, mirroredCtrl)

            parentMatrix = mirroredCtrl.parentMatrix[0].get()
            parentScale = om.MTransformationMatrix(om.MMatrix(parentMatrix)).scale(om.MSpace.kTransform)
            hasMirroredParent = parentScale[0] * parentScale[1] * parentScale[2] < 0
            if not hasMirroredParent:
                mirroredWorld = mirrorBehaviourMatrix(
                    ctrl.worldMatrix[0].get(),
                    translate=True,
                    rotate=True,
                )
                cmds.xform(mirroredCtrl, ws=True, m=list(mirroredWorld))


def addDefaultMenu(menu, object):
    """Add default control menu items (mirror, follow, reset, etc.) and dynamic parent menu."""
    if object.endswith("_control"):  # menu for controls only

        if not menu.find("Mirror"):
            localName = proxy.node(object).localName()
            if isLeftSide(localName) or isRightSide(localName):
                menu.addChild("Mirror", partial(simpleMirror, object), icon="polyMirrorGeometry.png")

        for a in ["follow", "followBody", "followNeck"]:
            title = a[0].upper() + a[1:] + " Switch"
            control = proxy.node(object)
            if control.hasAttr(a) and not menu.find(title):
                attr = control.attr(a)
                if attr.get(type=True) == "enum":
                    followMenu = menu.addChild(title, icon="polyAlignUVLinear.png")
                    labels = cmds.attributeQuery(a, node=control, listEnum=True)[0].split(":")
                    for value, field in enumerate(labels):
                        followMenu.addChild(field, partial(switchAttributeSeamlessly, object, a, value))
                else:
                    menu.addChild(title, partial(switchAttributeSeamlessly, object, a), icon="polyAlignUVLinear.png")

        def resetSelected(node):
            resetControl(node)
            for selected in cmds.ls(sl=True) or []:
                resetControl(selected)

        menu.addChild("Reset", partial(resetSelected, object), icon="refresh.png")

        control = proxy.node(object)
        if control.rotate.get(settable=True):
            rotateOrderSwitchMenu = menu.addChild("Rotate Order Switch", icon="srt.png")

            RotateOrders = ["xyz", "yzx", "zxy", "xzy", "yxz", "zyx"]
            for i, ro in enumerate(RotateOrders):
                ico = "play_S.png" if control.ro.get() == i else ""
                rotateOrderSwitchMenu.addChild(ro, partial(rotateOrderSwitchMulti, object, i), icon=ico)

        menu.addChild("Selection gizmo", makeGizmo, icon="lattice.png")

        # save/load animation
        clipMenu = menu.addChild("Animation Clip", icon="camera.svg")
        clipMenu.addChild("Save temp", partial(saveAnimationClip, object), icon="fileSave.png")
        clipMenu.addChild("Load temp", partial(loadAnimationClip, object, choosePath=False), icon="openScript.png")
        clipMenu.addChild("Save As...", partial(saveAnimationClip, object, choosePath=True), icon="fileSave.png")
        clipMenu.addChild("Load...", partial(loadAnimationClip, object), icon="openScript.png")

    dynamicParentMenu = makeDynamicParentMenu(object)
    if not dynamicParentMenu.isEmpty():
        menu.addChild("-")
        menu.mergeMenu(dynamicParentMenu)


def saveAnimationClip(object, choosePath=False):
    """Save selected controls and the given control to a temporary or chosen clip."""
    filePath = os.path.expandvars("$TEMP\\animclip.json")
    if choosePath:
        paths = cmds.fileDialog2(
            caption="Save Animation Clip",
            fileMode=0,
            fileFilter="Animation Clip (*.json)",
            startingDirectory=filePath,
        )
        if not paths:
            return

        filePath = paths[0]

    selected = cmds.ls(sl=True) or []
    try:
        cmds.select(object, add=True)
        cmds.saveAnimClip(f=filePath)
    finally:
        cmds.select(selected, replace=True)


def loadAnimationClip(object, choosePath=True):
    """Load a temporary or chosen clip onto selected controls and the given control."""
    filePath = os.path.expandvars("$TEMP\\animclip.json")
    if choosePath:
        paths = cmds.fileDialog2(
            caption="Load Animation Clip",
            fileMode=1,
            fileFilter="Animation Clip (*.json)",
            startingDirectory=filePath,
        )
        if not paths:
            return

        filePath = paths[0]

    if not os.path.exists(filePath):
        cmds.warning(f"No animation clip found at: {filePath}")
        return

    selected = cmds.ls(sl=True) or []
    try:
        cmds.select(object, add=True)
        cmds.loadAnimClip(f=filePath)
    finally:
        cmds.select(selected, replace=True)


def makeGizmo():
    """Create selection gizmo via the selectionGizmo module."""
    from . import selectionGizmo
    selectionGizmo.makeGizmo()


def toggleSetVisibility(namespace, currentSetNode, setType, restPattern, currentVisible=1, restVisible=-1):
    """Toggle visibility of sets by type (1=show, 0=hide, -1=ignore)."""
    def setVisibility(node, value):
        if value == 0:
            cmds.hide(node)
        elif value == 1:
            cmds.showHidden(node)
        elif value == 2:
            toggleVisible(node)

    for s in cmds.ls(f"{namespace}{restPattern}", type="objectSet") or []:
        stype = ""
        setNode = proxy.node(s)
        if setNode.hasAttr("type"):
            stype = setNode.type.get() or ""

        if setType == stype and restVisible != -1:
            setVisibility(s, restVisible)

    if currentVisible != -1 and currentSetNode:
        setVisibility(str(currentSetNode), currentVisible)


def keyframeAllControls(namespace):
    """Set keyframe on all keyable attributes of controls in the namespace."""
    nodes = cmds.ls(f"{namespace}*_control", type="transform") or []
    for control in proxy.nodes(nodes):
        for attr in control.listAttr(k=True):
            plug = control.attr(attr)
            if plug.get(settable=True):
                cmds.setKeyframe(str(plug))


def makeMenuByModuleInfo(moduleInfo, object):
    """Build menu items based on module type (rig, limb, spine, head, etc.)."""
    menu = Menu()
    moduleType = moduleInfo.getAttr("type")

    if moduleType == "rig":
        namespace = proxy.node(object).namespace()
        menu.addChild("Reset controls", partial(resetControls, namespace), icon="refresh.png")
        menu.addChild("Select controls", partial(selectControls, namespace), icon="QR_QuickRigTool.png")
        menu.addChild("Keyframe controls", partial(keyframeAllControls, namespace), icon="insertKeySmall.png")

    elif moduleType == "limb":
        menu.addChild("IK/FK Switch", partial(kinematicSwitchMulti, object), icon="kinJoint.png")

        ik = moduleInfo.getAttr("ik").node
        polevec = moduleInfo.getAttr("polevector").node

        fk1 = moduleInfo.getAttr("fk1").node
        fk2 = moduleInfo.getAttr("fk2").node
        fk3 = moduleInfo.getAttr("fk3").node

        objectMObject = proxy.node(object).mobject
        if objectMObject in [node.mobject for node in (fk1, fk2, fk3)]:
            menu.addChild("Edit FK with IK", partial(editFKwithIK.createRig, getModuleInfo(object, root=False)), icon="ikSCsolver.svg")

        if objectMObject in [node.mobject for node in (ik, polevec)]:
            menu.addChild("Snap Switch", partial(snapSwitch, object), icon="snapPoint.png")

        menu.addChild("Mirror", partial(mirrorByModuleInfo, getModuleInfo(object)), icon="polyMirrorGeometry.png")
        menu.addChild("Flip", partial(mirrorByModuleInfo, getModuleInfo(object), exchange=True), icon="polyFlip.png")

    elif moduleType in ["leg", "quadLeg"]:
        limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node)
        limbMenu = makeMenuByModuleInfo(limb_moduleInfo, object)
        menu.mergeMenu(limbMenu)

    elif moduleType == "spine":
        menu.addChild("Flip", partial(mirrorByModuleInfo, getModuleInfo(object)), icon="polyFlip.png")

    elif moduleType == "head":
        menu.addChild("IK/FK Switch", partial(kinematicSwitchMulti, object), icon="kinJoint.png")
        menu.addChild("Flip", partial(mirrorByModuleInfo, getModuleInfo(object)), icon="polyFlip.png")

    elif moduleType == "fingers":
        menu.addChild("Mirror all", partial(mirrorByModuleInfo, getModuleInfo(object)), icon="HIKmirror.png")
        menu.addChild("Flip all", partial(mirrorByModuleInfo, getModuleInfo(object), exchange=True), icon="polyFlipUVs.png")

    return menu


def makeDynamicParentMenu(object):
    """Build menu for dynamic parent switch and bake."""
    menu = Menu()

    if hasDynamicParent(object):
        menu.addChild("Dynamic parent Bake", partial(dynamicParentBake, object), icon="appendCache.png")
        dynamicParentMenu = menu.addChild("Dynamic parents", icon="selectByHierarchy.png")

        control = proxy.node(object)
        icon = "teRightArrow.png" if control.hasAttr("parent") and control.parent.get() == 0 else ""
        dynamicParentMenu.addChild("(no parent)", partial(dynamicParentSwitch, object, ""), icon=icon)

        dyn = DynamicParent(object)
        for tar in dyn.getTargets():
            icon = "teRightArrow.png" if tar == dyn.getCurrentTarget() else ""
            dynamicParentMenu.addChild(tar,
                                       partial(dynamicParentSwitch, object, tar),
                                       partial(deleteFromDynamicParent, object, tar),
                                       icon)

        if cmds.ls(sl=True, type="transform"):
            dynamicParentMenu.addChild("-")
            dynamicParentMenu.addChild("Add selected", partial(addSelectedToDynamicParent, object), icon="addClip.png")

    return menu
