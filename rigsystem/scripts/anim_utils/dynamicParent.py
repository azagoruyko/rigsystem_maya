import maya.cmds as cmds
import pymel.core as pm

from rig_utils.general import lockTRS, isAnimated
from .bake import getFrameRange

dynParentKeyColor = [1, 1, 0]

keyAttributes = ["dynparent", "tx", "ty", "tz", "rx", "ry", "rz"]


def setTickColor(control, attribute):
    """Set timeline tick color for the control's attribute at current time."""
    currentTime = pm.currentTime(q=True)
    pm.displayRGBColor("timeSliderTickDrawSpecial", *dynParentKeyColor)
    pm.keyframe(control, at=attribute, edit=True, tickDrawSpecial=True, time=(currentTime, currentTime))


def getTempAnimCurves(control, attributes):
    """Duplicate and return anim curves for the given attributes on the control."""
    animCurves = {}
    for a in attributes:
        connections = control.attr(a).listConnections(s=True, d=False, type="animCurve")
        if connections:
            animCurves[a] = connections[0].duplicate()
    return animCurves


class DynamicParent:
    """Dynamic parent (parent constraint) management for a control."""

    def __init__(self, ctrl):
        self.control = pm.PyNode(ctrl)

    def getDynamicParentTransform(self):
        """Return the dynamic parent transform node or None."""
        if self.control.hasAttr("dynamicParent"):
            inputs = self.control.dynamicParent.inputs()
            return inputs[0] if inputs else None
        return None

    def getParentConstraint(self):
        """Return the parent constraint on the dynamic parent transform or None."""
        transform = self.getDynamicParentTransform()
        if not transform:
            return None
        lst = transform.listRelatives(type="parentConstraint")
        return lst[0] if lst else None

    def getTargets(self):
        """Return list of parent constraint target transforms."""
        targets = []

        constraint = self.getParentConstraint()
        if constraint:
            for t in constraint.target:
                targets += t.targetParentMatrix.inputs()
        return targets

    def getCurrentTarget(self):
        """Return the current dynamic parent target or None."""
        if self.control.hasAttr("dynparent") and self.control.dynparent.get() > 0:  # skip (no parent)
            targets = self.getTargets()
            idx = self.control.dynparent.get() - 1
            if idx < len(targets):
                return targets[idx]

    def findTarget(self, target):
        """Return index of target in constraint targets or -1."""
        constraint = self.getParentConstraint()
        if not constraint:
            return -1

        targets = self.getTargets()
        target_names = [t.name() for t in targets]
        return target_names.index(target.name()) if target.name() in target_names else -1

    def setDrivenKeys(self):
        """Set driven keys from dynparent enum to constraint weights."""
        constraint = self.getParentConstraint()
        if not constraint or not self.control.hasAttr("dynparent"):
            return

        weights = constraint.getWeightAliasList()
        for i in range(len(weights)):
            weight_parts = weights[i].split(".")
            if len(weight_parts) < 2:
                continue
            attr = weight_parts[1]

            pm.setDrivenKeyframe(constraint, at=attr, v=1, dv=i + 1, cd=self.control.dynparent)

            if i < len(weights) - 1:
                pm.setDrivenKeyframe(constraint, at=attr, v=0, dv=i + 2, cd=self.control.dynparent)

            pm.setDrivenKeyframe(constraint, at=attr, v=0, dv=i, cd=self.control.dynparent)

    def addTarget(self, target):
        """Add a transform as dynamic parent target; update enum and driven keys."""
        if self.findTarget(target) != -1:
            pm.displayWarning("addTarget: Target '" + str(target) + "' already exists in this dynamic parent")
            return

        pm.undoInfo(ock=True)

        try:
            transform = self.getDynamicParentTransform()

            if not self.control.hasAttr("dynparent"):
                self.control.addAttr("dynparent", at="enum", enumName="(no parent)", k=True)

            if not self.getParentConstraint():  # reset before first parent
                pos = pm.xform(self.control, q=True, ws=True, t=True)
                rot = pm.xform(self.control, q=True, ws=True, ro=True)

                transform.t.set([0, 0, 0])
                transform.r.set([0, 0, 0])

                pm.xform(self.control, ws=True, t=pos)
                pm.xform(self.control, ws=True, ro=rot)

            st = [a for a in ["x", "y", "z"] if not self.control.attr("t" + a).isSettable()]
            sr = [a for a in ["x", "y", "z"] if not self.control.attr("r" + a).isSettable()]

            if not st:  # when full translation is available for the constraint
                sr = []  # free rotation as well

            pc = pm.parentConstraint(target, transform, mo=True, st=st, sr=sr)

            idx = len(self.getTargets()) - 1
            pc.target[idx].targetScale.disconnect()

        except Exception:
            raise

        finally:
            pm.undoInfo(cck=True)

        if pm.cycleCheck(pc):
            pm.undo()
            pm.displayWarning("addTarget: cannot add '" + str(target) + "' as a target because of a cycle")
            return

        pc.restTranslate.set([0, 0, 0])
        pc.restRotate.set([0, 0, 0])

        names = cmds.addAttr(self.control.dynparent.name(), q=True, en=True)
        names = names + ":" + target.name().replace(":", "_")
        cmds.addAttr(self.control.dynparent.name(), e=True, en=names)

        self.setDrivenKeys()

    def removeTarget(self, item):
        """Remove a dynamic parent target by name; optionally bake to world and update driven keys."""
        constraint = self.getParentConstraint()
        if not constraint:
            return

        parentAnimCurve = self.control.dynparent.inputs(type="animCurve")

        if parentAnimCurve:
            if pm.confirmDialog(m="Parent attribute has an animation. Removed parent will be baked to world. Okay?", b=["Yes", "No"]) == "No":
                return

        names = cmds.addAttr(self.control.dynparent.name(), q=True, en=True)

        itemToRemove = item.replace(":", "_")
        if itemToRemove not in names:
            pm.warning("removeTarget: cannot find '" + itemToRemove + "' in '" + self.control.dynparent.name() + "'")
            return

        idx = names.split(":").index(itemToRemove)

        if parentAnimCurve:  # update animation
            tmpAnimCurves = getTempAnimCurves(self.control, keyAttributes)

            currentTime = pm.currentTime(q=True)
            ac = parentAnimCurve[0]

            # bake to world
            acTemp = ac.duplicate()[0]
            k = 0
            while k < acTemp.numKeys():
                if acTemp.getValue(k) == idx:
                    nextIdx = k + 1 if k < acTemp.numKeys() - 1 else acTemp.numKeys() - 1  # next or last
                    for f in range(int(acTemp.getTime(k)), int(acTemp.getTime(nextIdx)) + 1):
                        pm.currentTime(f)

                        for a in tmpAnimCurves:
                            keyframe_value = pm.keyframe(tmpAnimCurves[a], time=f, eval=True, q=True)
                            if keyframe_value:
                                self.control.attr(a).set(keyframe_value[0])

                        dynamicParentSwitch_local(self.control, "")
                    k = nextIdx + 1
                    continue
                k += 1

            pm.delete(tmpAnimCurves.values())
            pm.delete(acTemp)

            ac = parentAnimCurve[0]
            for k in range(ac.numKeys()):
                v = ac.getValue(k)
                if v > idx:
                    ac.setValue(k, v - 1)                    

            pm.currentTime(currentTime)
        else:
            dynamicParentSwitch_local(self.control, "")

        newNames = names.replace(":" + itemToRemove, "")
        cmds.addAttr(self.control.dynparent.name(), e=True, en=newNames)

        for w in constraint.getWeightAliasList():
            pm.delete(pm.keyframe(w, q=True, name=True))

        targets = self.getTargets()
        if idx > 0 and idx - 1 < len(targets):
            target = targets[idx - 1]
            pm.parentConstraint(target, constraint, remove=True)
        elif idx == 0:
            pm.displayWarning("removeTarget: cannot remove '(no parent)' option")
            return False

        self.setDrivenKeys()
        return True

    def removeDynamicParent(self):
        """Remove dynamic parent: reparent control and delete transform node."""
        transform = self.getDynamicParentTransform()

        if transform:
            # Reparent control to transform's parent (or world if no parent)
            transformParent = transform.getParent()
            if transformParent:
                pm.parent(self.control, transformParent)
            else:
                pm.parent(self.control, world=True)
            
            # Delete transform node
            pm.delete(transform)

        # Remove dynamicParent message attribute (Maya will disconnect connections automatically)
        if self.control.hasAttr("dynamicParent"):
            pm.deleteAttr(self.control.dynamicParent)
        
        # Remove dynparent enum attribute
        if self.control.hasAttr("dynparent"):
            pm.deleteAttr(self.control.dynparent)


def makeDynamicParent(control, controlParent=None):
    """Create dynamic parent transform and wire it to the control."""
    controlParent = pm.PyNode(controlParent) if controlParent else control
    control = pm.PyNode(control)

    parent = controlParent.getParent()
    dynamicParent = pm.createNode("transform", n=control.name() + "_dynamicParent", p=parent)

    dynamicParent | controlParent
    lockTRS(dynamicParent, [], [], [1, 1, 1], 1)

    control.addAttr("dynamicParent", at="message")
    dynamicParent.message >> control.dynamicParent


def dynamicParentSwitch_local(control, item, applyColor=True):
    """Switch dynamic parent to the given item (enum name); optionally set tick color."""
    if not control.hasAttr("dynparent"):
        return

    enumResult = pm.attributeQuery("dynparent", node=control, le=True)
    if not enumResult or not enumResult[0]:
        return

    items = enumResult[0].split(":")  # get enum items

    parentLabel = item.replace(":", "_")
    index = items.index(parentLabel) if parentLabel in items else 0

    m = control.worldMatrix.get()
    control.dynparent.set(index)
    pm.xform(control, ws=True, m=m)

    if pm.autoKeyframe(q=True, state=True) or isAnimated(control.dynparent):
        pm.setKeyframe(control, at='dynparent')
        if applyColor:
            setTickColor(control, 'dynparent')


def dynamicParentSwitch(control, parent):
    """Switch dynamic parent for control(s) over selection or timeline range."""
    nodes = set(pm.ls(sl=True) + [pm.PyNode(control)])

    mayaPlayBackSlider = pm.mel.eval('$tmpVar=$gPlayBackSlider')
    selectedRange = cmds.timeControl(mayaPlayBackSlider, q=True, ra=True)
    isRangeSelected = selectedRange[1] - selectedRange[0] > 1

    autoKey = pm.autoKeyframe(q=True, state=True)
    currentTime = pm.currentTime(q=True)

    for control in nodes:
        if not control.hasAttr("dynparent"):
            continue

        if isRangeSelected:  # selected keys
            animCurves = control.dynparent.listConnections(s=True, d=False, type="animCurve")
            for ac in animCurves:
                for i in range(pm.keyframe(ac, q=True, kc=True)):
                    time = pm.keyframe(ac, index=i, q=True)
                    if time and time[0] >= selectedRange[0] and time[0] <= selectedRange[1]:
                        pm.currentTime(time[0])
                        dynamicParentSwitch_local(control, parent)

        else:
            if autoKey or isAnimated(control.dynparent):  # key previous frame to prevent floating transition
                pm.currentTime(currentTime - 1)
                pm.setKeyframe(control, at=keyAttributes)
                pm.currentTime(currentTime)

            dynamicParentSwitch_local(control, parent)
            pm.currentTime(currentTime)


def dynamicParentBake(object, startFrame=None, endFrame=None):
    """Bake dynamic parent animation to world over the given or selected timeline range."""
    if startFrame is None or endFrame is None:
        result = getFrameRange()
        if result is None:
            pm.warning("dynamicParentBake: range must be selected on timeline to bake")
            return
        startFrame, endFrame = result

    tmpAnimCurves = {}
    controlsToBake = []

    autoKeyPressed = pm.autoKeyframe(q=True, state=True)
    if not autoKeyPressed:
        pm.autoKeyframe(state=True)

    for control in set(pm.ls(sl=True, type="transform") + [pm.PyNode(object)]):
        if not control.hasAttr("dynparent"):
            pm.warning("dynamicParentBake: cannot find '{}.dynparent' attribute".format(control))
            continue

        if not isAnimated(control.dynparent):
            pm.warning("dynamicParentBake: {} must be animated to bake".format(control.dynparent.name()))
            continue

        tmpAnimCurves[control.name()] = getTempAnimCurves(control, keyAttributes)
        controlsToBake.append(control)

    for f in range(int(startFrame), int(endFrame) + 1):
        pm.currentTime(f)
        
        for control in controlsToBake:
            for a in keyAttributes:
                if a in tmpAnimCurves[control.name()]:
                    keyframe_value = pm.keyframe(tmpAnimCurves[control.name()][a], time=f, eval=True, q=True)
                    if keyframe_value:
                        control.attr(a).set(keyframe_value[0])

        for control in controlsToBake:
            parentValue_result = pm.keyframe(tmpAnimCurves[control.name()]["dynparent"], time=f, eval=True, q=True)
            if parentValue_result and len(parentValue_result) > 0:
                parentValue = parentValue_result[0]
                if parentValue > 0:
                    dynamicParentSwitch_local(control, "", applyColor=False)
        
    # Cleanup: remove sub-frame keys and reset color for bakeAttributes
    for control in controlsToBake:
        for attr in keyAttributes:
            if control.hasAttr(attr):
                keys = pm.keyframe(control.attr(attr), q=True, t=(startFrame, endFrame), tc=True)
                if keys:
                    sub_frames = [t for t in keys if round(t) != round(t, 4)]
                    for t in sub_frames:
                        pm.cutKey(control.attr(attr), time=(t, t))

                # Reset tick color for all baked attributes
                pm.keyframe(control.attr(attr), edit=True, tds=False, time=(startFrame, endFrame))

    for k in tmpAnimCurves:
        pm.delete(tmpAnimCurves[k].values())

    if not autoKeyPressed:
        pm.autoKeyframe(state=False)


def hasDynamicParent(control):
    """Return True if the control has a dynamic parent."""
    return pm.PyNode(control).hasAttr("dynamicParent")


def addSelectedToDynamicParent(control):
    """Add each selected transform as dynamic parent target for the control."""
    if not hasDynamicParent(control):
        return

    control = pm.PyNode(control)

    for selected in pm.ls(sl=True, type="transform"):
        if control != selected:
            dyn = DynamicParent(control)
            dyn.addTarget(selected)


def deleteFromDynamicParent(control, item):
    """Remove the given item from dynamic parent targets for selected control(s)."""
    for control in set(pm.ls(sl=True) + [pm.PyNode(control)]):
        if not hasDynamicParent(control) or not control.hasAttr("dynparent"):
            continue

        dyn = DynamicParent(control)

        names = cmds.addAttr(dyn.control.dynparent.name(), q=True, en=True).split(":")

        itemToRemove = item.replace(":", "_")
        if itemToRemove in names:
            dyn.removeTarget(item)
        else:
            pm.displayWarning("deleteFromDynamicParent: cannot find '" + item + "' in '" + dyn.control.dynparent.name() + "'")
