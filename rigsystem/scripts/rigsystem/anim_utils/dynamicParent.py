import maya.mel as mel

from rigsystem import proxy
from rigsystem.rig_utils.general import lockTRS
from rigsystem.rig_utils.anim import isAnimated
from .bake import getFrameRange

cmds = proxy.cmds

dynParentKeyColor = [1, 1, 0]

keyAttributes = ["dynparent", "tx", "ty", "tz", "rx", "ry", "rz"]


def setTickColor(control, attribute):
    """Set timeline tick color for the control's attribute at current time."""
    control = proxy.node(control)
    currentTime = cmds.currentTime(q=True)
    cmds.displayRGBColor("timeControlTickDrawSpecial", *dynParentKeyColor)
    cmds.keyframe(control, at=attribute, edit=True, tickDrawSpecial=True, time=(currentTime, currentTime))


def getTempAnimCurves(control, attributes):
    """Duplicate and return anim curves for the given attributes on the control."""
    control = proxy.node(control)
    animCurves = {}
    for a in attributes:
        connections = [plug.node for plug in control.attr(a).inputs(type="animCurve")]
        if connections:
            animCurves[a] = cmds.duplicate(connections[0])[0]
    return animCurves


class DynamicParent:
    """Dynamic parent (parent constraint) management for a control."""

    def __init__(self, ctrl):
        self.control = proxy.node(ctrl)


    def getDynamicParentTransform(self):
        """Return the dynamic parent transform node or None."""
        if self.control.hasAttr("dynamicParent"):
            inputs = self.control.dynamicParent.inputs()
            return inputs[0].node if inputs else None
        return None


    def getParentConstraint(self):
        """Return the parent constraint on the dynamic parent transform or None."""
        transform = self.getDynamicParentTransform()
        if not transform:
            return None
        lst = transform.getChildren(type="parentConstraint")
        return lst[0] if lst else None


    def getTargets(self):
        """Return list of parent constraint target transforms."""
        constraint = self.getParentConstraint()
        if not constraint:
            return []
        return cmds.parentConstraint(constraint, q=True, targetList=True) or []


    def getCurrentTarget(self):
        """Return the current dynamic parent target or None."""
        if self.control.hasAttr("dynparent"):
            index = self.control.dynparent.get()
        else:
            return None
        if index > 0:  # skip (no parent)
            targets = self.getTargets()
            idx = index - 1
            if idx < len(targets):
                return targets[idx]


    def findTarget(self, target):
        """Return index of target in constraint targets or -1."""
        constraint = self.getParentConstraint()
        if not constraint:
            return -1

        targets = self.getTargets()
        targetPath = proxy.node(target).mdagpath.fullPathName()
        targetPaths = [target.mdagpath.fullPathName() for target in proxy.nodes(targets)]
        return targetPaths.index(targetPath) if targetPath in targetPaths else -1


    def setDrivenKeys(self):
        """Set driven keys from dynparent enum to constraint weights."""
        constraint = self.getParentConstraint()
        if not constraint or not self.control.hasAttr("dynparent"):
            return

        weights = cmds.parentConstraint(constraint, q=True, weightAliasList=True) or []
        for i in range(len(weights)):
            attr = weights[i]

            cmds.setDrivenKeyframe(constraint, at=attr, v=1, dv=i + 1, cd=self.control.dynparent)

            if i < len(weights) - 1:
                cmds.setDrivenKeyframe(constraint, at=attr, v=0, dv=i + 2, cd=self.control.dynparent)

            cmds.setDrivenKeyframe(constraint, at=attr, v=0, dv=i, cd=self.control.dynparent)


    def addTarget(self, target):
        """Add a transform as dynamic parent target; update enum and driven keys."""
        target = proxy.node(target)
        if self.findTarget(target) != -1:
            cmds.warning(f"addTarget: Target '{target}' already exists in this dynamic parent")
            return

        cmds.undoInfo(ock=True)

        try:
            transform = self.getDynamicParentTransform()

            if not self.control.hasAttr("dynparent"):
                self.control.addAttr(ln="dynparent", at="enum", enumName="(no parent)", k=True)

            if not self.getParentConstraint():  # reset before first parent
                pos = cmds.xform(self.control, q=True, ws=True, t=True)
                rot = cmds.xform(self.control, q=True, ws=True, ro=True)

                transform = proxy.node(transform)
                transform.translate.set((0, 0, 0))
                transform.rotate.set((0, 0, 0))

                cmds.xform(self.control, ws=True, t=pos)
                cmds.xform(self.control, ws=True, ro=rot)

            st = [a for a in ("x", "y", "z") if not self.control.attr(f"t{a}").get(settable=True)]
            sr = [a for a in ("x", "y", "z") if not self.control.attr(f"r{a}").get(settable=True)]

            if not st:  # when full translation is available for the constraint
                sr = []  # free rotation as well

            pc = proxy.node(cmds.parentConstraint(target, transform, mo=True, st=st, sr=sr)[0])

            idx = len(self.getTargets()) - 1
            scalePlug = pc.attr(f"target[{idx}].targetScale")
            source = scalePlug.inputs()
            if source:
                scalePlug.disconnect(source[0])

        except Exception:
            raise

        finally:
            cmds.undoInfo(cck=True)

        if cmds.cycleCheck(pc):
            cmds.undo()
            cmds.warning(f"addTarget: cannot add '{target}' as a target because of a cycle")
            return

        pc.restTranslate.set((0, 0, 0))
        pc.restRotate.set((0, 0, 0))

        dynparentPlug = self.control.dynparent
        names = cmds.addAttr(dynparentPlug, q=True, en=True)
        names = f"{names}:{str(target).replace(':', '_')}"
        cmds.addAttr(dynparentPlug, e=True, en=names)

        self.setDrivenKeys()


    def removeTarget(self, item):
        """Remove a dynamic parent target by name; optionally bake to world and update driven keys."""
        constraint = self.getParentConstraint()
        if not constraint:
            return

        dynparentPlug = self.control.dynparent
        parentAnimCurve = [plug.node for plug in dynparentPlug.inputs(type="animCurve")]

        if parentAnimCurve:
            if cmds.confirmDialog(m="Parent attribute has an animation. Removed parent will be baked to world. Okay?", b=["Yes", "No"]) == "No":
                return

        names = cmds.addAttr(dynparentPlug, q=True, en=True)

        itemToRemove = item.replace(":", "_")
        if itemToRemove not in names:
            cmds.warning(f"removeTarget: cannot find '{itemToRemove}' in '{dynparentPlug}'")
            return

        idx = names.split(":").index(itemToRemove)

        if parentAnimCurve:  # update animation
            tmpAnimCurves = getTempAnimCurves(self.control, keyAttributes)

            currentTime = cmds.currentTime(q=True)
            ac = parentAnimCurve[0]

            # bake to world
            acTemp = cmds.duplicate(ac)[0]
            k = 0
            keyCount = cmds.keyframe(acTemp, q=True, keyframeCount=True)
            while k < keyCount:
                if cmds.keyframe(acTemp, q=True, index=(k, k), valueChange=True)[0] == idx:
                    nextIdx = k + 1 if k < keyCount - 1 else keyCount - 1  # next or last
                    start = cmds.keyframe(acTemp, q=True, index=(k, k), timeChange=True)[0]
                    end = cmds.keyframe(acTemp, q=True, index=(nextIdx, nextIdx), timeChange=True)[0]
                    for f in range(int(start), int(end) + 1):
                        cmds.currentTime(f)

                        for a in tmpAnimCurves:
                            keyframe_value = cmds.keyframe(tmpAnimCurves[a], time=(f, f), eval=True, q=True)
                            if keyframe_value:
                                self.control.attr(a).set(keyframe_value[0])

                        dynamicParentSwitch_local(self.control, "")
                    k = nextIdx + 1
                    continue
                k += 1

            cmds.delete(list(tmpAnimCurves.values()))
            cmds.delete(acTemp)

            ac = parentAnimCurve[0]
            for k in range(cmds.keyframe(ac, q=True, keyframeCount=True)):
                v = cmds.keyframe(ac, q=True, index=(k, k), valueChange=True)[0]
                if v > idx:
                    cmds.keyframe(ac, e=True, index=(k, k), valueChange=v - 1)

            cmds.currentTime(currentTime)
        else:
            dynamicParentSwitch_local(self.control, "")

        newNames = names.replace(":" + itemToRemove, "")
        cmds.addAttr(dynparentPlug, e=True, en=newNames)

        constraint = proxy.node(constraint)
        for weight in cmds.parentConstraint(constraint, q=True, weightAliasList=True) or []:
            curves = cmds.keyframe(constraint.attr(weight), q=True, name=True) or []
            if curves:
                cmds.delete(curves)

        targets = self.getTargets()
        if idx > 0 and idx - 1 < len(targets):
            target = targets[idx - 1]
            cmds.parentConstraint(target, constraint, remove=True)
        elif idx == 0:
            cmds.warning("removeTarget: cannot remove '(no parent)' option")
            return False

        self.setDrivenKeys()
        return True


    def removeDynamicParent(self):
        """Remove dynamic parent: reparent control and delete transform node."""
        transform = self.getDynamicParentTransform()

        if transform:
            # Reparent control to transform's parent (or world if no parent)
            transform = proxy.node(transform)
            transformParent = transform.getParent(fullPath=True)
            if transformParent:
                self.control = transformParent | self.control
            else:
                self.control = proxy.node(cmds.parent(self.control, world=True)[0])
            
            # Delete transform node
            cmds.delete(transform)

        # Remove dynamicParent message attribute (Maya will disconnect connections automatically)
        if self.control.hasAttr("dynamicParent"):
            self.control.deleteAttr("dynamicParent")
        
        # Remove dynparent enum attribute
        if self.control.hasAttr("dynparent"):
            self.control.deleteAttr("dynparent")


def makeDynamicParent(control, controlParent=None):
    """Create dynamic parent transform and wire it to the control."""
    controlParent = proxy.node(controlParent or control)
    control = proxy.node(control)
    parent = controlParent.getParent(fullPath=True)
    dynamicParent = proxy.create(
        "transform",
        f"{control.localName()}_dynamicParent",
        parent=parent
    )

    dynamicParent | controlParent
    lockTRS(dynamicParent, t=[], r=[], s=1, v=1)

    control.addAttr(ln="dynamicParent", at="message")
    dynamicParent.message >> control.dynamicParent


def dynamicParentSwitch_local(control, item, applyColor=True):
    """Switch dynamic parent to the given item (enum name); optionally set tick color."""
    control = proxy.node(control)
    if not control.hasAttr("dynparent"):
        return

    enumNames = cmds.addAttr(control.dynparent, query=True, enumName=True)
    if not enumNames:
        return

    items = enumNames.split(":")  # get enum items

    parentLabel = item.replace(":", "_")
    index = items.index(parentLabel) if parentLabel in items else 0

    m = cmds.xform(control, q=True, ws=True, m=True)
    control.dynparent.set(index)
    cmds.xform(control, ws=True, m=m)

    if cmds.autoKeyframe(q=True, state=True) or isAnimated(control.dynparent):
        cmds.setKeyframe(control, at='dynparent')
        if applyColor:
            setTickColor(control, 'dynparent')


def dynamicParentSwitch(control, parent):
    """Switch dynamic parent for control(s) over selection or timeline range."""
    nodes = list(set((cmds.ls(sl=True) or []) + [str(control)]))
    controlNodes = dict(zip(nodes, proxy.nodes(nodes)))

    mayaPlayBackSlider = mel.eval('$tmpVar=$gPlayBackSlider')
    selectedRange = cmds.timeControl(mayaPlayBackSlider, q=True, ra=True)
    isRangeSelected = selectedRange[1] - selectedRange[0] > 1

    autoKey = cmds.autoKeyframe(q=True, state=True)
    currentTime = cmds.currentTime(q=True)

    for control in nodes:
        controlNode = controlNodes[control]
        if not controlNode.hasAttr("dynparent"):
            continue

        if isRangeSelected:  # selected keys
            animCurves = [plug.node for plug in controlNode.dynparent.inputs(type="animCurve")]
            for ac in animCurves:
                for i in range(cmds.keyframe(ac, q=True, keyframeCount=True)):
                    time = cmds.keyframe(ac, index=(i, i), q=True, timeChange=True)
                    if time and time[0] >= selectedRange[0] and time[0] <= selectedRange[1]:
                        cmds.currentTime(time[0])
                        dynamicParentSwitch_local(control, parent)

        else:
            if autoKey or isAnimated(controlNode.dynparent):  # key previous frame to prevent floating transition
                cmds.currentTime(currentTime - 1)
                cmds.setKeyframe(control, at=keyAttributes)
                cmds.currentTime(currentTime)

            dynamicParentSwitch_local(control, parent)
            cmds.currentTime(currentTime)


def dynamicParentBake(object, startFrame=None, endFrame=None):
    """Bake dynamic parent animation to world over the given or selected timeline range."""
    if startFrame is None or endFrame is None:
        result = getFrameRange()
        if result is None:
            cmds.warning("dynamicParentBake: range must be selected on timeline to bake")
            return
        startFrame, endFrame = result

    tmpAnimCurves = {}
    controlsToBake = []

    autoKeyPressed = cmds.autoKeyframe(q=True, state=True)
    if not autoKeyPressed:
        cmds.autoKeyframe(state=True)

    controlNames = list(set((cmds.ls(sl=True, type="transform") or []) + [str(object)]))
    controlNodes = dict(zip(controlNames, proxy.nodes(controlNames)))
    for control in controlNames:
        controlNode = controlNodes[control]
        if not controlNode.hasAttr("dynparent"):
            cmds.warning(f"dynamicParentBake: cannot find '{control}.dynparent' attribute")
            continue

        if not isAnimated(controlNode.dynparent):
            cmds.warning(f"dynamicParentBake: {control}.dynparent must be animated to bake")
            continue

        tmpAnimCurves[control] = getTempAnimCurves(control, keyAttributes)
        controlsToBake.append(control)

    for f in range(int(startFrame), int(endFrame) + 1):
        cmds.currentTime(f)
        
        for control in controlsToBake:
            for a in keyAttributes:
                if a in tmpAnimCurves[control]:
                    keyframe_value = cmds.keyframe(tmpAnimCurves[control][a], time=(f, f), eval=True, q=True)
                    if keyframe_value:
                        controlNodes[control].attr(a).set(keyframe_value[0])

        for control in controlsToBake:
            parentValue_result = cmds.keyframe(tmpAnimCurves[control]["dynparent"], time=(f, f), eval=True, q=True)
            if parentValue_result and len(parentValue_result) > 0:
                parentValue = parentValue_result[0]
                if parentValue > 0:
                    dynamicParentSwitch_local(control, "", applyColor=False)
        
    # Cleanup: remove sub-frame keys and reset color for bakeAttributes
    for control in controlsToBake:
        for attr in keyAttributes:
            controlNode = controlNodes[control]
            if controlNode.hasAttr(attr):
                plug = controlNode.attr(attr)
                keys = cmds.keyframe(plug, q=True, t=(startFrame, endFrame), tc=True)
                if keys:
                    sub_frames = [t for t in keys if round(t) != round(t, 4)]
                    for t in sub_frames:
                        cmds.cutKey(plug, time=(t, t))

                # Reset tick color for all baked attributes
                cmds.keyframe(plug, edit=True, tds=False, time=(startFrame, endFrame))

    for k in tmpAnimCurves:
        cmds.delete(list(tmpAnimCurves[k].values()))

    if not autoKeyPressed:
        cmds.autoKeyframe(state=False)


def hasDynamicParent(control):
    """Return True if the control has a dynamic parent."""
    return proxy.node(control).hasAttr("dynamicParent")


def addSelectedToDynamicParent(control):
    """Add each selected transform as dynamic parent target for the control."""
    if not hasDynamicParent(control):
        return

    control = str(control)
    controlPath = (cmds.ls(control, long=True, type="transform") or [control])[0]

    for selected in cmds.ls(sl=True, type="transform", long=True) or []:
        if controlPath != selected:
            dyn = DynamicParent(control)
            dyn.addTarget(selected)


def deleteFromDynamicParent(control, item):
    """Remove the given item from dynamic parent targets for selected control(s)."""
    controlNames = list(set((cmds.ls(sl=True) or []) + [str(control)]))
    controlNodes = dict(zip(controlNames, proxy.nodes(controlNames)))
    for control in controlNames:
        controlNode = controlNodes[control]
        if not hasDynamicParent(controlNode) or not controlNode.hasAttr("dynparent"):
            continue

        dyn = DynamicParent(controlNode)

        names = cmds.addAttr(dyn.control.dynparent, q=True, en=True).split(":")

        itemToRemove = item.replace(":", "_")
        if itemToRemove in names:
            dyn.removeTarget(item)
        else:
            cmds.warning(f"deleteFromDynamicParent: cannot find '{item}' in '{dyn.control}.dynparent'")
