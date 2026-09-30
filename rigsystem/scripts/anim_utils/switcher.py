import maya.cmds as cmds
import maya.mel as mel
import pymel.core as pm

from rig_utils.general import resetControl, copyAttrsSpec, lockTRS, isAnimated
from rig_utils.matrix import taxis
from rig_utils.moduleInfo import ModuleInfo, getModuleInfo


def kinematicSwitchMulti(object, startFrame=None, endFrame=None):
    """Switch IK/FK for object(s) over current time or selected timeline range."""
    def getFrameSpecList(ac):
        specList = []
        for i in range(pm.keyframe(ac, q=True, kc=True)):
            t = pm.keyframe(ac, index=i, q=True)
            v = pm.keyframe(ac, index=i, q=True, vc=True)
            if t and v:
                specList.append((t[0], v[0]))

        return specList

    def getValueFromFrameSpecList(specList, tm):
        _, prev_v = specList[0]
        for i, (t, v) in enumerate(specList):
            if t > tm:
                return prev_v
            prev_v = v
        return v

    if startFrame is None or endFrame is None:
        mayaPlayBackSlider = mel.eval('$tmpVar=$gPlayBackSlider')
        startFrame, endFrame = cmds.timeControl(mayaPlayBackSlider, q=True, ra=True)

    isRangeSelected = endFrame - startFrame > 1

    nodes = set(pm.selected(type="transform") + [pm.PyNode(object)])

    autoKeyPressed = pm.autoKeyframe(q=True, state=True)

    animCurves = []
    if isRangeSelected:
        for obj in nodes:
            for a in ["tx","ty","tz","rx","ry","rz"]:
                animCurves += obj.attr(a).inputs(type="animCurve")

        if not autoKeyPressed:
            pm.autoKeyframe(state=True)

    skip = set()
    for obj in nodes:
        moduleInfo = getModuleInfo(obj)
        if not moduleInfo or moduleInfo.node in skip:
            continue

        if moduleInfo.getAttr("type") in ["leg", "quadLeg"]:
            limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node())
            ikfk = limb_moduleInfo.getAttr("ikfk")
        elif moduleInfo.hasAttr("ikfk"):
            ikfk = moduleInfo.getAttr("ikfk")
        else:
            continue

        if isRangeSelected:
            kinematic_animCurves = ikfk.inputs(type="animCurve")
            frameSpecList = getFrameSpecList(kinematic_animCurves[0]) if kinematic_animCurves else [(0, 0)]

            skipFrames = []
            for ac in animCurves + kinematic_animCurves:
                for i in range(pm.keyframe(ac, q=True, kc=True)):
                    time = pm.keyframe(ac, index=i, q=True)
                    if time and time[0] not in skipFrames and time[0] >= startFrame and time[0] <= endFrame:
                        pm.currentTime(time[0])
                        ikfk.set(getValueFromFrameSpecList(frameSpecList, time[0]))

                        kinematicSwitch(moduleInfo)

                        skipFrames.append(time[0])
                        skip.add(moduleInfo.node)
        
        else:
            if autoKeyPressed:
                pm.currentTime(startFrame - 1) # go to previous frame and key ikfk
                pm.setKeyframe(ikfk)
                pm.currentTime(startFrame) # return to current frame

            kinematicSwitch(moduleInfo)
            skip.add(moduleInfo.node)

    if isRangeSelected and not autoKeyPressed:
        pm.autoKeyframe(state=False)


def kinematicSwitch(moduleInfo):
    """Dispatch to limb/leg/quadLeg/head kinematic switch implementation."""
    moduleType = moduleInfo.getAttr("type")

    if moduleType == "limb":
        limb_kinematicSwitch(moduleInfo)

    elif moduleType == "leg":
        limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node())
        leg_kinematicSwitch(moduleInfo)

    elif moduleType == "quadLeg":
        limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node())
        quadLeg_kinematicSwitch(moduleInfo)

    elif moduleType == "head":
        head_kinematicSwitch(moduleInfo)


def head_kinematicSwitch(moduleInfo):
    """Switch head IK/FK; sync switcher transforms then set ikfk."""
    ikfk = moduleInfo.getAttr("ikfk")

    if ikfk.get() == 1:
        head_ik = moduleInfo.getAttr("seamless_head_ik").node()
        switcher_head_ik = moduleInfo.getAttr("seamless_switcher_head_ik").node()

        head_ik.t.set(switcher_head_ik.t.get())
        head_ik.r.set(switcher_head_ik.r.get())

        ikfk.set(0)
    else:
        neck_fk = moduleInfo.getAttr("seamless_neck_fk").node()
        switcher_neck_fk = moduleInfo.getAttr("seamless_switcher_neck_fk").node()
        neck_fk.r.set(switcher_neck_fk.r.get())

        neck_fk.scaleFactor.set(moduleInfo.getAttr("neck_ik_joint").node().sx.get())

        head_fk = moduleInfo.getAttr("seamless_head_fk").node()
        switcher_head_fk = moduleInfo.getAttr("seamless_switcher_head_fk").node()
        head_fk.r.set(switcher_head_fk.r.get())
        
        ikfk.set(1)


def leg_kinematicSwitch(moduleInfo):
    """Switch leg IK/FK via limb switcher and toe sync."""
    limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node())
    ikfk = limb_moduleInfo.getAttr("ikfk")

    if ikfk.get() == 1:
        limb_kinematicSwitch(limb_moduleInfo)

        toe_ik = moduleInfo.getAttr("seamless_toe_ik").node()
        switcher_toe_ik = moduleInfo.getAttr("seamless_switcher_toe_ik").node()

        resetControl(moduleInfo.getAttr("footroll").node())

        if toe_ik.rx.isSettable():
            toe_ik.rx.set(switcher_toe_ik.rx.get())
        if toe_ik.ry.isSettable():
            toe_ik.ry.set(switcher_toe_ik.ry.get())
        if toe_ik.rz.isSettable():
            toe_ik.rz.set(switcher_toe_ik.rz.get())

        ikfk.set(0)
    else:
        limb_kinematicSwitch(limb_moduleInfo)
        
        toe_fk = moduleInfo.getAttr("seamless_toe_fk").node()
        switcher_toe_fk = moduleInfo.getAttr("seamless_switcher_toe_fk").node()

        resetControl(moduleInfo.getAttr("footroll").node())

        if toe_fk.rx.isSettable():
            toe_fk.rx.set(switcher_toe_fk.rx.get())
        if toe_fk.ry.isSettable():
            toe_fk.ry.set(switcher_toe_fk.ry.get())
        if toe_fk.rz.isSettable():
            toe_fk.rz.set(switcher_toe_fk.rz.get())

        ikfk.set(1)


def quadLeg_kinematicSwitch(moduleInfo):
    """Switch quad leg IK/FK via limb and footroll."""
    limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node())
    ikfk = limb_moduleInfo.getAttr("ikfk")

    if ikfk.get() == 1:
        limb_kinematicSwitch(limb_moduleInfo)

        footroll = moduleInfo.getAttr("seamless_footroll").node()
        switcher_footroll = moduleInfo.getAttr("seamless_switcher_footroll").node()

        resetControl(footroll)
        footroll.rx.set(switcher_footroll.rx.get())
        footroll.rz.set(switcher_footroll.rz.get())

        ikfk.set(0)
    else:
        limb_kinematicSwitch(limb_moduleInfo)
        
        toe_fk = moduleInfo.getAttr("seamless_toe_fk").node()
        switcher_toe_fk = moduleInfo.getAttr("seamless_switcher_toe_fk").node()

        if toe_fk.rx.isSettable():
            toe_fk.rx.set(switcher_toe_fk.rx.get())
        if toe_fk.ry.isSettable():
            toe_fk.ry.set(switcher_toe_fk.ry.get())
        if toe_fk.rz.isSettable():
            toe_fk.rz.set(switcher_toe_fk.rz.get())

        ikfk.set(1)


def limb_kinematicSwitch(moduleInfo):
    """Sync IK/FK transforms and switch limb ikfk; handle pole vector and scale factors."""
    ikfk = moduleInfo.getAttr("ikfk")

    if ikfk.get() > 0.5:
        ik = moduleInfo.getAttr("ik").node()
        polevector = moduleInfo.getAttr("polevector").node()

        switcher_ik = moduleInfo.getAttr("seamless_switcher_ik").node()
        switcher_polevector = moduleInfo.getAttr("seamless_switcher_polevector").node()

        ik.t.set(switcher_ik.t.get())
        ik.r.set(switcher_ik.r.get())

        fk1 = moduleInfo.getAttr("fk1").node()
        fk2 = moduleInfo.getAttr("fk2").node()
        fk3 = moduleInfo.getAttr("fk3").node()

        moduleInfo.getAttr("snap").set(0)

        # find polevector position
        dist = (taxis(switcher_polevector.wm.get()) - taxis(fk2.wm.get())).length()
        vec = (taxis(fk1.wm.get()) - taxis(fk2.wm.get())).normal() + (taxis(fk3.wm.get()) - taxis(fk2.wm.get())).normal()
        if vec.length() > 0.001:
            pos = taxis(fk2.wm.get()) - vec.normal() * dist
            pm.xform(polevector, ws=True, t=pos) 
        else:
            polevector.t.set(switcher_polevector.t.get()) 

        ikfk.set(0)
        
        # keep joints length
        ikStretch = ik.stretch.get()
        ik.stretch.set(0)

        options = moduleInfo.getAttr("options").node()
        fk_1_len = (taxis(fk2.wm.get()) - taxis(fk1.wm.get())).length()
        fk_2_len = (taxis(fk3.wm.get()) - taxis(fk2.wm.get())).length()

        ik1 = moduleInfo.getAttr("ik1_joint").node()
        ik2 = moduleInfo.getAttr("ik2_joint").node()   
        ik3 = moduleInfo.getAttr("ik3_joint").node()   

        ik_1_len = (taxis(ik2.wm.get()) - taxis(ik1.wm.get())).length()
        ik_2_len = (taxis(ik3.wm.get()) - taxis(ik2.wm.get())).length()

        options.scaleFactor1x.set(options.scaleFactor1x.get() * fk_1_len / ik_1_len)
        options.scaleFactor2x.set(options.scaleFactor2x.get() * fk_2_len / ik_2_len)
        
        ik.stretch.set(ikStretch)

        softIK_animCurve = ik.name().replace("ik_control", "softIK_animCurveUU")
        if not pm.objExists(softIK_animCurve) or pm.PyNode(softIK_animCurve).output.get() > 1:
            ik.softIK.set(0)

    else:
        fk1 = moduleInfo.getAttr("fk1").node()
        fk2 = moduleInfo.getAttr("fk2").node()
        fk3 = moduleInfo.getAttr("fk3").node()

        switcher_fk1 = moduleInfo.getAttr("seamless_switcher_fk1").node()
        switcher_fk2 = moduleInfo.getAttr("seamless_switcher_fk2").node()
        switcher_fk3 = moduleInfo.getAttr("seamless_switcher_fk3").node()

        copyAttrsSpec(switcher_fk1, fk1, ["tx", "ty", "tz", "rx", "ry", "rz"])
        copyAttrsSpec(switcher_fk2, fk2, ["tx", "ty", "tz", "rx", "ry", "rz"])
        copyAttrsSpec(switcher_fk3, fk3, ["tx", "ty", "tz", "rx", "ry", "rz"])

        ikfk.set(1)


def snapSwitch(object):
    """Snap pole vector to limb or limb to pole (snap on/off)."""
    moduleInfo = getModuleInfo(object)
    if not moduleInfo:
        return

    moduleType = moduleInfo.getAttr("type")

    if moduleType == "limb":
        limbSnapSwitch(moduleInfo)

    elif moduleType == "leg":
        limb_moduleInfo = ModuleInfo(moduleInfo.getAttr("limb").node())
        limbSnapSwitch(limb_moduleInfo)


def limbSnapSwitch(moduleInfo):
    """Toggle snap: pole to joint or IK to end joint."""
    snap = moduleInfo.getAttr("snap")
    if snap.get() == 0:
        polevector = moduleInfo.getAttr("polevector").node()
        joint = moduleInfo.getAttr("ik2_joint").node()
        pm.xform(polevector, ws=True, t=pm.xform(joint, ws=True, q=True, t=True))
        snap.set(1)

    else:
        ik = moduleInfo.getAttr("ik").node()
        joint = moduleInfo.getAttr("ik3_joint").node()
        pm.xform(ik, ws=True, t=pm.xform(joint, ws=True, q=True, t=True))

        sx1 = moduleInfo.getAttr("ik1_joint").node().sx.get()
        sx2 = moduleInfo.getAttr("ik2_joint").node().sx.get()

        options = moduleInfo.getAttr("options").node()
        options.scaleFactor1x.set(sx1)
        options.scaleFactor2x.set(sx2)

        snap.set(0)


def generateRotateOrderOffsets(dest, src, rough=0.01):
    """Build choice node for rotate order offsets to keep pose when ro changes."""
    oldRo = dest.ro.get()
    offsets = []

    for i in range(6):
        dest.ro.set(i)
        dest.r.set([0, 0, 0])

        pc = pm.parentConstraint(src, dest, mo=True)
        v = pc.target[0].targetOffsetRotate.get()
        offsets.append(v)

        pm.delete(pc)

    dest.ro.set(oldRo)
    dest.r.set([0, 0, 0])

    if not [x for x in offsets if x.length() > rough]:
        return

    choice = pm.createNode("choice", n=dest + "_rotateOrder_choice")
    dest.ro >> choice.selector

    for i, o in enumerate(offsets):
        attr = "choice_ro{}".format(i)
        if not dest.hasAttr(attr):
            dest.addAttr(attr, dt="double3")

        dest.attr(attr).set(o)
        dest.attr(attr) >> choice.input[i]

    outAttr = "choice_output"
    if not dest.hasAttr(outAttr):
        dest.addAttr(outAttr, at="double3")
        dest.addAttr(outAttr + "X", at="double", p=outAttr)
        dest.addAttr(outAttr + "Y", at="double", p=outAttr)
        dest.addAttr(outAttr + "Z", at="double", p=outAttr)

    choice.output >> dest.attr(outAttr)
    return dest.attr(outAttr)


def makeSeamlessKinematicSwitching(moduleInfo, name, control, influence):
    """Create seamless switcher transform and store on moduleInfo."""
    switchTransform = control.duplicate(po=True)[0]
    switchTransform.rename(control.name() + "_seamless_switcher")

    if isinstance(switchTransform, pm.nt.Joint):
        control.jo >> switchTransform.jo

    lockTRS(switchTransform, [0, 0, 0], [0, 0, 0], [1, 1, 1], 0)
    switchTransform.v.set(False)

    outAttr = generateRotateOrderOffsets(switchTransform, influence)

    control.rotateOrder >> switchTransform.rotateOrder
    pc = pm.parentConstraint(influence, switchTransform, mo=True)

    if outAttr:
        outAttr >> pc.target[0].targetOffsetRotate

    moduleInfo.setAttr("seamless_" + name, control.message)
    moduleInfo.setAttr("seamless_switcher_" + name, switchTransform.message)

    lockTRS(switchTransform, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)


def switchAttributeSeamlessly_local(ctrl, attr, value=None):
    """Set enum/attr and restore world matrix to avoid jump."""
    attr = pm.PyNode(ctrl + "." + attr)
    mat = pm.xform(ctrl, q=True, ws=True, m=True)

    if value is not None:
        attr.set(value)
    else:
        if attr.get() < 0.5:
            attr.set(1)
        else:
            attr.set(0)

    pm.xform(ctrl, ws=True, m=mat)


def switchAttributeSeamlessly(object, attr, value=None, startFrame=None, endFrame=None):
    """Switch attribute (e.g. follow) on control(s); optionally over timeline range."""
    if startFrame is None or endFrame is None:
        mayaPlayBackSlider = mel.eval('$tmpVar=$gPlayBackSlider')
        startFrame, endFrame = cmds.timeControl(mayaPlayBackSlider, q=True, ra=True)

    isRangeSelected = endFrame - startFrame > 1

    bakeAttributes = [attr, "tx", "ty", "tz", "rx", "ry", "rz"]
    tmpAnimCurves = {}
    controlsToBake = []

    for control in set(pm.ls(sl=True, type="transform") + [pm.PyNode(object)]):
        if not control.hasAttr(attr):
            pm.warning("switchAttributeSeamlessly: cannot find '{}.{}' attribute".format(control, attr))
            continue

        if isRangeSelected:
            if not isAnimated(control.attr(attr)):
                pm.warning("switchAttributeSeamlessly: {} must be animated to bake".format(control.attr(attr).name()))
                continue

            tmpAnimCurves[control.name()] = {}

            for a in bakeAttributes:
                connections = control.attr(a).inputs(type="animCurve")
                if connections:
                    tmpAnimCurves[control.name()][a] = connections[0].duplicate()

        controlsToBake.append(control)

    if not controlsToBake:
        pm.warning("switchAttributeSeamlessly: nothing to switch")
        return

    if isRangeSelected:
        autoKeyPressed = pm.autoKeyframe(q=True, state=True)
        if not autoKeyPressed:
            pm.autoKeyframe(state=True)

        for f in range(int(startFrame), int(endFrame) + 1):
            pm.currentTime(f)

            for control in controlsToBake:
                for a in bakeAttributes:
                    if a in tmpAnimCurves[control.name()]:
                        control.attr(a).set(pm.keyframe(tmpAnimCurves[control.name()][a], time=f, eval=True, q=True)[0])

            for control in controlsToBake:
                switchAttributeSeamlessly_local(control, attr, value)

        if not autoKeyPressed:
            pm.autoKeyframe(state=False)

    else:
        for control in controlsToBake:
            switchAttributeSeamlessly_local(control, attr, value)


def rotateOrderSwitchMulti(object, ro):
    """Set rotate order on control(s), preserving pose via stored matrices per key."""
    controls = set(pm.ls(sl=True) + [pm.PyNode(object)])

    for ctrl in controls:

        # find animation curves on rotation
        animCurves = []
        for a in ["rx", "ry", "rz"]:
            animCurves.extend(ctrl.attr(a).listConnections(type=["animCurveTL", "animCurveTA", "animCurveTU"], d=False, s=True))

        frames = []
        for acurve in animCurves:
            for k in range(acurve.numKeys()):
                f = acurve.getTime(k)
                if f not in frames:
                    frames.append(f)
        
        currentFrame = pm.currentTime()

        matrices = []
        for f in frames:
            pm.currentTime(f)
            matrices.append(pm.xform(ctrl, q=True, m=True))

        ctrl.rotateOrder.set(ro)

        for f, m in zip(frames, matrices):
            pm.currentTime(f)
            pm.xform(ctrl, m=m)

        pm.keyTangent(ctrl.r, itt="auto", ott="auto")

        pm.currentTime(currentFrame)


def addFollow(
    ctrl, nofollow_transform, follow_transform, 
    attr="follow", default=0.0, type="parent",
    transform=None):
    """Add follow attribute to control."""
    ctrl = pm.PyNode(ctrl)

    ctrl.addAttr(attr, min=0.0, max=1.0, dv=default, k=True)
    if not transform and type != "jointOrient":
        transform = pm.group(ctrl, n=ctrl+"_"+attr+"_transform")
        
    if type == "point":
        c = pm.pointConstraint(nofollow_transform, follow_transform, transform, mo=True)            
    elif type == "orient":
        c = pm.parentConstraint(nofollow_transform, follow_transform, transform, mo=True, st=["x","y","z"])       
        c.interpType.set(2)
    elif type == "parent":
        c = pm.parentConstraint(nofollow_transform, follow_transform, transform, mo=True)
        c.interpType.set(2)
    elif type == "jointOrient":
        transform = pm.createNode("transform", n=ctrl+"_"+attr+"_transform", p=ctrl.getParent())
        pm.matchTransform(transform, ctrl)
             
        c = pm.parentConstraint(nofollow_transform, follow_transform, transform, mo=True, st=["x","y","z"])
        c.interpType.set(2)
        transform.rx >> ctrl.jox
        transform.ry >> ctrl.joy
        transform.rz >> ctrl.joz        
        
    follow_rev = pm.createNode("reverse", n=ctrl+"_"+attr+"_reverse")
    ctrl.attr(attr) >> follow_rev.inputX
    follow_rev.outputX >> c.w0
    ctrl.attr(attr) >> c.w1
    return transform
