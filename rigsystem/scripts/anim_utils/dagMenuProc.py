"""Viewport menu helpers; see `dagMenuProc.txt` for Maya integration steps."""
import os
import re

import maya.cmds as cmds
import pymel.core as pm

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

from rig_utils.general import (
    copyAttrs,
    resetControl,
    resetControls,
    selectControls,
    toggleVisible,
)
from rig_utils.moduleInfo import ModuleInfo, getModuleInfo
from rig_utils.naming import isLeftSide, isRightSide

def customDagMenuProc(parent, object):
    """Build and show the custom DAG menu for the given object."""
    object = pm.PyNode(object)

    menu = Menu()

    moduleInfo = getModuleInfo(object)
    if moduleInfo:
        menu.mergeMenu(makeMenuByModuleInfo(moduleInfo, object))

    addDefaultMenu(menu, object)

    # Embed menu
    if not menu.isEmpty():
        ls = pm.ls(sl=True, type="transform") + [object]
        postfix = "... [multi selection]" if len(set(ls)) > 1 else ""

        pm.menuItem(l=object + postfix, bld=True, en=True)
        pm.menuItem(divider=True)

        menu.buildIn(parent)

        return True

    return False


def simpleMirror(object):
    """Mirror selected controls (left/right sided) including the given object."""
    selected = pm.ls(sl=True, type="transform") + [object]

    for ctrl in selected:
        ctrl = pm.PyNode(ctrl)

        namespace = ctrl.namespace()
        ctrl_local = ctrl.stripNamespace()
        ctrl_mirrored_local = findSymmetricName(ctrl_local)

        if ctrl_local != ctrl_mirrored_local:
            copyAttrs(ctrl, namespace + ctrl_mirrored_local)


def addDefaultMenu(menu, object):
    """Add default control menu items (mirror, follow, reset, etc.) and dynamic parent menu."""
    if object.endswith("_control"):  # menu for controls only

        if not menu.find("Mirror"):
            localName = object.stripNamespace()
            if isLeftSide(localName) or isRightSide(localName):
                menu.addChild("Mirror", pm.Callback(simpleMirror, object), icon="polyMirrorGeometry.png")

        for a in ["follow", "followBody", "followNeck"]:
            title = a[0].upper() + a[1:] + " Switch"
            if object.hasAttr(a) and not menu.find(title):                
                attr = object.attr(a)
                if attr.type() == "enum":
                    followMenu = menu.addChild(title, icon="polyAlignUVLinear.png")
                    for field, v in attr.getEnums().items():
                        followMenu.addChild(field, pm.Callback(switchAttributeSeamlessly, object, a, v))
                else:
                    menu.addChild(title, pm.Callback(switchAttributeSeamlessly, object, a), icon="polyAlignUVLinear.png")

        f = lambda node: (resetControl(node), [resetControl(n) for n in pm.ls(sl=True)])
        menu.addChild("Reset", pm.Callback(f, object), icon="refresh.png")

        if object.r.isSettable():
            rotateOrderSwitchMenu = menu.addChild("Rotate Order Switch", icon="srt.png")

            RotateOrders = ["xyz", "yzx", "zxy", "xzy", "yxz", "zyx"]
            for i, ro in enumerate(RotateOrders):
                ico = "play_S.png" if object.ro.get() == i else ""
                rotateOrderSwitchMenu.addChild(ro, pm.Callback(rotateOrderSwitchMulti, object, i), icon=ico)

        menu.addChild("Selection gizmo", makeGizmo, icon="lattice.png")

        # save/load animation
        clipMenu = menu.addChild("Animation Clip", icon="camera.svg")
        clipMenu.addChild("Save temp", pm.Callback(saveAnimationClip, object), icon="fileSave.png")
        clipMenu.addChild("Load temp", pm.Callback(loadAnimationClip, object, choosePath=False), icon="openScript.png")
        clipMenu.addChild("Save As...", pm.Callback(saveAnimationClip, object, choosePath=True), icon="fileSave.png")
        clipMenu.addChild("Load...", pm.Callback(loadAnimationClip, object), icon="openScript.png")

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

    ls = pm.ls(sl=True)
    try:
        pm.select(object, add=True)
        pm.saveAnimClip(f=filePath)
    finally:
        pm.select(ls)


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
        pm.warning("No animation clip found at: " + filePath)
        return

    ls = pm.ls(sl=True)
    try:
        pm.select(object, add=True)
        pm.loadAnimClip(f=filePath)
    finally:
        pm.select(ls)


def makeGizmo():
    """Create selection gizmo via the selectionGizmo module."""
    from . import selectionGizmo
    selectionGizmo.makeGizmo()


def toggleSetVisibility(namespace, currentSetNode, setType, restPattern, currentVisible=1, restVisible=-1):
    """Toggle visibility of sets by type (1=show, 0=hide, -1=ignore); run on/off scripts as needed."""
    def setVisibility(node, value):
        convertPyNodes = lambda x: re.sub(r"@\b(\w+)\b", "pm.PyNode('{}\\1')".format(node.namespace()), x)

        onScript = ""
        offScript = ""
        if node.hasAttr("onScript"):
            onScript = convertPyNodes(node.onScript.get())
        if node.hasAttr("offScript"):
            offScript = convertPyNodes(node.offScript.get())

        script = ""
        if value == 0:
            pm.hide(node)
            script = offScript
        elif value == 1:
            pm.showHidden(node)
            script = onScript
        elif value == 2:
            if toggleVisible(node):
                script = onScript
            else:
                script = offScript

        if script:
            exec(script, {"pm":pm, "cmds":cmds})

    for s in pm.ls(namespace + restPattern, type="objectSet"):
        stype = ""
        if s.hasAttr("type"):
            stype = s.attr("type").get() or ""

        if setType == stype and restVisible != -1:
            setVisibility(s, restVisible)

    if currentVisible != -1 and currentSetNode:
        setVisibility(pm.PyNode(currentSetNode), currentVisible)


def keyframeAllControls(namespace):
    """Set keyframe on all keyable attributes of controls in the namespace."""
    for n in pm.ls(namespace + "*_control", type="transform"):
        for a in n.listAttr(k=True):
            if a.isSettable():
                pm.setKeyframe(a)


def makeMenuByModuleInfo(moduleInfo, object):
    """Build menu items based on module type (rig, limb, spine, head, etc.)."""
    menu = Menu()
    moduleType = moduleInfo.getAttr("type")

    if moduleType == "rig":
        namespace = object.namespace()
        menu.addChild("Reset controls", pm.Callback(resetControls, namespace), icon="refresh.png")
        menu.addChild("Select controls", pm.Callback(selectControls, namespace), icon="QR_QuickRigTool.png")
        menu.addChild("Keyframe controls", pm.Callback(keyframeAllControls, namespace), icon="insertKeySmall.png")

    elif moduleType == "limb":
        menu.addChild("IK/FK Switch", pm.Callback(kinematicSwitchMulti, object), icon="kinJoint.png")

        ik = moduleInfo.getAttr("ik").node()
        polevec = moduleInfo.getAttr("polevector").node()

        fk1 = moduleInfo.getAttr("fk1").node()
        fk2 = moduleInfo.getAttr("fk2").node()
        fk3 = moduleInfo.getAttr("fk3").node()

        if object in [fk1, fk2, fk3]:
            menu.addChild("Edit FK with IK", pm.Callback(editFKwithIK.createRig, getModuleInfo(object, root=False)), icon="ikSCsolver.svg")

        if object in [ik, polevec]:
            menu.addChild("Snap Switch", pm.Callback(snapSwitch, object), icon="snapPoint.png")

        menu.addChild("Mirror", pm.Callback(mirrorByModuleInfo, getModuleInfo(object)), icon="polyMirrorGeometry.png")
        menu.addChild("Flip", pm.Callback(mirrorByModuleInfo, getModuleInfo(object), exchange=True), icon="polyFlip.png")

    elif moduleType in ["leg", "quadLeg"]:
        limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node())
        limbMenu = makeMenuByModuleInfo(limb_moduleInfo, object)
        menu.mergeMenu(limbMenu)

    elif moduleType == "spine":
        menu.addChild("Flip", pm.Callback(mirrorByModuleInfo, getModuleInfo(object)), icon="polyFlip.png")

    elif moduleType == "head":
        menu.addChild("IK/FK Switch", pm.Callback(kinematicSwitchMulti, object), icon="kinJoint.png")
        menu.addChild("Flip", pm.Callback(mirrorByModuleInfo, getModuleInfo(object)), icon="polyFlip.png")

    elif moduleType == "fingers":
        menu.addChild("Mirror all", pm.Callback(mirrorByModuleInfo, getModuleInfo(object)), icon="HIKmirror.png")
        menu.addChild("Flip all", pm.Callback(mirrorByModuleInfo, getModuleInfo(object), exchange=True), icon="polyFlipUVs.png")

    return menu


def makeDynamicParentMenu(object):
    """Build menu for dynamic parent switch and bake."""
    menu = Menu()

    if hasDynamicParent(object):
        menu.addChild("Dynamic parent Bake", pm.Callback(dynamicParentBake, object), icon="appendCache.png")
        dynamicParentMenu = menu.addChild("Dynamic parents", icon="selectByHierarchy.png")

        icon = "teRightArrow.png" if object.hasAttr("parent") and object.attr("parent").get() == 0 else ""
        dynamicParentMenu.addChild("(no parent)", pm.Callback(dynamicParentSwitch, object, ''), icon=icon)

        dyn = DynamicParent(object)
        for tar in dyn.getTargets():
            icon = "teRightArrow.png" if tar == dyn.getCurrentTarget() else ""
            dynamicParentMenu.addChild(tar.name(), 
                                       pm.Callback(dynamicParentSwitch, object, tar), 
                                       pm.Callback(deleteFromDynamicParent, object, tar), 
                                       icon)

        if pm.ls(sl=True, type="transform"):
            dynamicParentMenu.addChild("-")
            dynamicParentMenu.addChild("Add selected", pm.Callback(addSelectedToDynamicParent, object), icon="addClip.png")

    return menu
