import maya.mel as mel
import maya.api.OpenMaya as om

from rigsystem import proxy
from rigsystem.rig_utils.general import resetControl, copyAttrsSpec, lockTRS
from rigsystem.rig_utils.anim import isAnimated
from rigsystem.rig_utils.matrix import taxis
from rigsystem.rig_utils.moduleInfo import ModuleInfo, getModuleInfo

cmds = proxy.cmds


def _connectedNode(moduleInfo, name):
    return moduleInfo.getAttr(name).node


def _copyAttr(source, destination, attr):
    proxy.node(destination).attr(attr).set(proxy.node(source).attr(attr).get())


def _worldPosition(node):
    return taxis(proxy.node(node).worldMatrix[0].get())


def _modulePlug(moduleInfo, name):
    plug = moduleInfo.node.attr(name)
    if cmds.getAttr(plug, type=True) == "message":
        connections = plug.inputs()
        if not connections:
            raise RuntimeError(f"ModuleInfo attribute '{plug}' has no connected plug")
        return connections[0]

    return plug


def kinematicSwitchMulti(object, startFrame=None, endFrame=None):
    """Switch IK/FK for object(s) over current time or selected timeline range."""
    def getFrameSpecList(ac):
        specList = []
        for i in range(cmds.keyframe(ac, q=True, kc=True)):
            t = cmds.keyframe(ac, index=(i, i), q=True, timeChange=True)
            v = cmds.keyframe(ac, index=(i, i), q=True, valueChange=True)
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

    nodes = set((cmds.ls(sl=True, type="transform") or []) + [str(proxy.node(object))])

    autoKeyPressed = cmds.autoKeyframe(q=True, state=True)

    animCurves = []
    if isRangeSelected:
        for obj in nodes:
            for a in ["tx","ty","tz","rx","ry","rz"]:
                animCurves += [plug.node for plug in proxy.node(obj).attr(a).inputs(type="animCurve")]

        if not autoKeyPressed:
            cmds.autoKeyframe(state=True)

    skip = set()
    for obj in nodes:
        moduleInfo = getModuleInfo(obj)
        if not moduleInfo or str(moduleInfo.node) in skip:
            continue

        if moduleInfo.getAttr("type") in ["leg", "quadLeg"]:
            limb_moduleInfo = ModuleInfo(_connectedNode(moduleInfo, "limb"))
            ikfk = _modulePlug(limb_moduleInfo, "ikfk")
        elif moduleInfo.hasAttr("ikfk"):
            ikfk = _modulePlug(moduleInfo, "ikfk")
        else:
            continue

        if isRangeSelected:
            kinematic_animCurves = [plug.node for plug in ikfk.inputs(type="animCurve")]
            frameSpecList = getFrameSpecList(kinematic_animCurves[0]) if kinematic_animCurves else [(0, 0)]

            skipFrames = []
            for ac in animCurves + kinematic_animCurves:
                for i in range(cmds.keyframe(ac, q=True, kc=True)):
                    time = cmds.keyframe(ac, index=(i, i), q=True, timeChange=True)
                    if time and time[0] not in skipFrames and time[0] >= startFrame and time[0] <= endFrame:
                        cmds.currentTime(time[0])
                        ikfk.set(getValueFromFrameSpecList(frameSpecList, time[0]))

                        kinematicSwitch(moduleInfo)

                        skipFrames.append(time[0])
                        skip.add(str(moduleInfo.node))
        
        else:
            if autoKeyPressed:
                cmds.currentTime(startFrame - 1) # go to previous frame and key ikfk
                cmds.setKeyframe(ikfk)
                cmds.currentTime(startFrame) # return to current frame

            kinematicSwitch(moduleInfo)
            skip.add(str(moduleInfo.node))

    if isRangeSelected and not autoKeyPressed:
        cmds.autoKeyframe(state=False)


def kinematicSwitch(moduleInfo):
    """Dispatch to limb/leg/quadLeg/head kinematic switch implementation."""
    moduleType = moduleInfo.getAttr("type")

    if moduleType == "limb":
        limb_kinematicSwitch(moduleInfo)

    elif moduleType == "leg":
        leg_kinematicSwitch(moduleInfo)

    elif moduleType == "quadLeg":
        quadLeg_kinematicSwitch(moduleInfo)

    elif moduleType == "head":
        head_kinematicSwitch(moduleInfo)


def head_kinematicSwitch(moduleInfo):
    """Switch head IK/FK; sync switcher transforms then set ikfk."""
    ikfk = _modulePlug(moduleInfo, "ikfk")

    if ikfk.get() == 1:
        head_ik = _connectedNode(moduleInfo, "seamless_head_ik")
        switcher_head_ik = _connectedNode(moduleInfo, "seamless_switcher_head_ik")

        for attr in ("translate", "rotate"):
            cmds.setAttr(head_ik.attr(attr), *cmds.getAttr(switcher_head_ik.attr(attr))[0])

        ikfk.set(0)
    else:
        neck_fk = _connectedNode(moduleInfo, "seamless_neck_fk")
        switcher_neck_fk = _connectedNode(moduleInfo, "seamless_switcher_neck_fk")
        cmds.setAttr(neck_fk.rotate, *cmds.getAttr(switcher_neck_fk.rotate)[0])

        cmds.setAttr(neck_fk.scaleFactor, _connectedNode(moduleInfo, "neck_ik_joint").sx.get())

        head_fk = _connectedNode(moduleInfo, "seamless_head_fk")
        switcher_head_fk = _connectedNode(moduleInfo, "seamless_switcher_head_fk")
        cmds.setAttr(head_fk.rotate, *cmds.getAttr(switcher_head_fk.rotate)[0])
        
        ikfk.set(1)


def leg_kinematicSwitch(moduleInfo):
    """Switch leg IK/FK via limb switcher and toe sync."""
    limb_moduleInfo = ModuleInfo(_connectedNode(moduleInfo, "limb"))
    ikfk = _modulePlug(limb_moduleInfo, "ikfk")

    if ikfk.get() == 1:
        limb_kinematicSwitch(limb_moduleInfo)

        toe_ik = _connectedNode(moduleInfo, "seamless_toe_ik")
        switcher_toe_ik = _connectedNode(moduleInfo, "seamless_switcher_toe_ik")

        resetControl(_connectedNode(moduleInfo, "footroll"))

        for attr in ("rx", "ry", "rz"):
            if toe_ik.attr(attr).get(settable=True):
                _copyAttr(switcher_toe_ik, toe_ik, attr)

        ikfk.set(0)
    else:
        limb_kinematicSwitch(limb_moduleInfo)
        
        toe_fk = _connectedNode(moduleInfo, "seamless_toe_fk")
        switcher_toe_fk = _connectedNode(moduleInfo, "seamless_switcher_toe_fk")

        resetControl(_connectedNode(moduleInfo, "footroll"))

        for attr in ("rx", "ry", "rz"):
            if toe_fk.attr(attr).get(settable=True):
                _copyAttr(switcher_toe_fk, toe_fk, attr)

        ikfk.set(1)


def quadLeg_kinematicSwitch(moduleInfo):
    """Switch quad leg IK/FK via limb and footroll."""
    limb_moduleInfo = ModuleInfo(_connectedNode(moduleInfo, "limb"))
    ikfk = _modulePlug(limb_moduleInfo, "ikfk")

    if ikfk.get() == 1:
        limb_kinematicSwitch(limb_moduleInfo)

        footroll = _connectedNode(moduleInfo, "seamless_footroll")
        switcher_footroll = _connectedNode(moduleInfo, "seamless_switcher_footroll")

        resetControl(footroll)
        for attr in ("rx", "rz"):
            _copyAttr(switcher_footroll, footroll, attr)

        ikfk.set(0)
    else:
        limb_kinematicSwitch(limb_moduleInfo)
        
        toe_fk = _connectedNode(moduleInfo, "seamless_toe_fk")
        switcher_toe_fk = _connectedNode(moduleInfo, "seamless_switcher_toe_fk")

        for attr in ("rx", "ry", "rz"):
            if toe_fk.attr(attr).get(settable=True):
                _copyAttr(switcher_toe_fk, toe_fk, attr)

        ikfk.set(1)


def limb_kinematicSwitch(moduleInfo):
    """Sync IK/FK transforms and switch limb ikfk; handle pole vector and scale factors."""
    ikfk = _modulePlug(moduleInfo, "ikfk")

    if ikfk.get() > 0.5:
        ik = _connectedNode(moduleInfo, "ik")
        polevector = _connectedNode(moduleInfo, "polevector")

        switcher_ik = _connectedNode(moduleInfo, "seamless_switcher_ik")
        switcher_polevector = _connectedNode(moduleInfo, "seamless_switcher_polevector")

        for attr in ("translate", "rotate"):
            cmds.setAttr(ik.attr(attr), *cmds.getAttr(switcher_ik.attr(attr))[0])

        fk1 = _connectedNode(moduleInfo, "fk1")
        fk2 = _connectedNode(moduleInfo, "fk2")
        fk3 = _connectedNode(moduleInfo, "fk3")

        _modulePlug(moduleInfo, "snap").set(0)

        # find polevector position
        dist = (_worldPosition(switcher_polevector) - _worldPosition(fk2)).length()
        vec = (_worldPosition(fk1) - _worldPosition(fk2)).normal() + (_worldPosition(fk3) - _worldPosition(fk2)).normal()
        if vec.length() > 0.001:
            pos = _worldPosition(fk2) - vec.normal() * dist
            cmds.xform(polevector, ws=True, t=(pos.x, pos.y, pos.z))
        else:
            cmds.setAttr(polevector.translate, *cmds.getAttr(switcher_polevector.translate)[0])

        ikfk.set(0)
        
        # keep joints length
        ikStretch = ik.stretch.get()
        ik.stretch.set(0)

        options = _connectedNode(moduleInfo, "options")
        fk_1_len = (_worldPosition(fk2) - _worldPosition(fk1)).length()
        fk_2_len = (_worldPosition(fk3) - _worldPosition(fk2)).length()

        ik1 = _connectedNode(moduleInfo, "ik1_joint")
        ik2 = _connectedNode(moduleInfo, "ik2_joint")
        ik3 = _connectedNode(moduleInfo, "ik3_joint")

        ik_1_len = (_worldPosition(ik2) - _worldPosition(ik1)).length()
        ik_2_len = (_worldPosition(ik3) - _worldPosition(ik2)).length()

        for attr, fkLength, ikLength in (("scaleFactor1x", fk_1_len, ik_1_len), ("scaleFactor2x", fk_2_len, ik_2_len)):
            plug = options.attr(attr)
            plug.set(plug.get() * fkLength / ikLength)
        
        ik.stretch.set(ikStretch)

        softIKOutput = proxy.plug(f"{str(ik).replace('ik_control', 'softIK_animCurveUU')}.output")
        if not cmds.objExists(softIKOutput) or softIKOutput.get() > 1:
            ik.softIK.set(0)

    else:
        fk1 = _connectedNode(moduleInfo, "fk1")
        fk2 = _connectedNode(moduleInfo, "fk2")
        fk3 = _connectedNode(moduleInfo, "fk3")

        switcher_fk1 = _connectedNode(moduleInfo, "seamless_switcher_fk1")
        switcher_fk2 = _connectedNode(moduleInfo, "seamless_switcher_fk2")
        switcher_fk3 = _connectedNode(moduleInfo, "seamless_switcher_fk3")

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
        limb_moduleInfo = ModuleInfo(_connectedNode(moduleInfo, "limb"))
        limbSnapSwitch(limb_moduleInfo)


def limbSnapSwitch(moduleInfo):
    """Toggle snap: pole to joint or IK to end joint."""
    snap = _modulePlug(moduleInfo, "snap")
    if snap.get() == 0:
        polevector = _connectedNode(moduleInfo, "polevector")
        joint = _connectedNode(moduleInfo, "ik2_joint")
        cmds.xform(polevector, ws=True, t=cmds.xform(joint, ws=True, q=True, t=True))
        snap.set(1)

    else:
        ik = _connectedNode(moduleInfo, "ik")
        joint = _connectedNode(moduleInfo, "ik3_joint")
        cmds.xform(ik, ws=True, t=cmds.xform(joint, ws=True, q=True, t=True))

        sx1 = _connectedNode(moduleInfo, "ik1_joint").sx.get()
        sx2 = _connectedNode(moduleInfo, "ik2_joint").sx.get()

        options = _connectedNode(moduleInfo, "options")
        options.scaleFactor1x.set(sx1)
        options.scaleFactor2x.set(sx2)

        snap.set(0)


def generateRotateOrderOffsets(dest, src, rough=0.01):
    """Build choice node for rotate order offsets to keep pose when ro changes."""
    dest = proxy.node(dest)
    src = proxy.node(src)
    oldRo = dest.ro.get()
    offsets = []

    for i in range(6):
        dest.ro.set(i)
        cmds.setAttr(dest.rotate, 0, 0, 0)

        pc = proxy.node(cmds.parentConstraint(src, dest, mo=True)[0])
        v = pc.attr("target[0].targetOffsetRotate").get()[0]
        offsets.append(v)

        cmds.delete(pc)

    dest.ro.set(oldRo)
    cmds.setAttr(dest.rotate, 0, 0, 0)

    if not [x for x in offsets if om.MVector(x).length() > rough]:
        return

    choiceName = str(dest).rsplit("|", 1)[-1]
    choice = proxy.create("choice", f"{choiceName}_rotateOrder_choice")
    dest.ro >> choice.selector

    for i, o in enumerate(offsets):
        attr = f"choice_ro{i}"
        if not dest.hasAttr(attr):
            dest.addAttr(ln=attr, dt="double3")

        cmds.setAttr(dest.attr(attr), *o, type="double3")
        dest.attr(attr) >> choice.input[i]

    outAttr = "choice_output"
    if not dest.hasAttr(outAttr):
        dest.addAttr(ln=outAttr, at="double3")
        for axis in "XYZ":
            dest.addAttr(ln=f"{outAttr}{axis}", at="double", p=outAttr)

    choice.output >> dest.attr(outAttr)
    return dest.attr(outAttr)


def makeSeamlessKinematicSwitching(moduleInfo, name, control, influence):
    """Create seamless switcher transform and store on moduleInfo."""
    control = proxy.node(control)
    influence = proxy.node(influence)
    switchTransform = proxy.node(cmds.duplicate(control, parentOnly=True)[0])
    controlName = str(control).rsplit("|", 1)[-1]
    switchTransform.rename(f"{controlName}_seamless_switcher")

    if switchTransform.type() == "joint":
        control.jointOrient >> switchTransform.jointOrient

    lockTRS(switchTransform, t=0, r=0, s=1, v=0)
    switchTransform.v.set(False)

    outAttr = generateRotateOrderOffsets(switchTransform, influence)

    control.rotateOrder >> switchTransform.rotateOrder
    pc = proxy.node(cmds.parentConstraint(influence, switchTransform, mo=True)[0])

    if outAttr:
        outAttr.connect(pc.attr("target[0].targetOffsetRotate"), force=True)

    moduleInfo.setAttr(f"seamless_{name}", control.message)
    moduleInfo.setAttr(f"seamless_switcher_{name}", switchTransform.message)

    lockTRS(switchTransform, t=1, r=1, s=1, v=1)


def switchAttributeSeamlessly_local(ctrl, attr, value=None):
    """Set enum/attr and restore world matrix to avoid jump."""
    ctrl = proxy.node(ctrl)
    plug = ctrl.attr(attr)
    mat = cmds.xform(ctrl, q=True, ws=True, m=True)

    if value is not None:
        plug.set(value)
    else:
        if plug.get() < 0.5:
            plug.set(1)
        else:
            plug.set(0)

    cmds.xform(ctrl, ws=True, m=mat)


def switchAttributeSeamlessly(object, attr, value=None, startFrame=None, endFrame=None):
    """Switch attribute (e.g. follow) on control(s); optionally over timeline range."""
    if startFrame is None or endFrame is None:
        mayaPlayBackSlider = mel.eval('$tmpVar=$gPlayBackSlider')
        startFrame, endFrame = cmds.timeControl(mayaPlayBackSlider, q=True, ra=True)

    isRangeSelected = endFrame - startFrame > 1

    bakeAttributes = [attr, "tx", "ty", "tz", "rx", "ry", "rz"]
    tmpAnimCurves = {}
    controlsToBake = []

    controlNames = list(set((cmds.ls(sl=True, type="transform") or []) + [str(proxy.node(object))]))
    controlNodes = dict(zip(controlNames, proxy.nodes(controlNames)))
    for controlName in controlNames:
        control = controlNodes[controlName]
        if not control.hasAttr(attr):
            cmds.warning(f"switchAttributeSeamlessly: cannot find '{control}.{attr}' attribute")
            continue

        if isRangeSelected:
            if not isAnimated(control.attr(attr)):
                cmds.warning(f"switchAttributeSeamlessly: {control}.{attr} must be animated to bake")
                continue

            tmpAnimCurves[controlName] = {}

            for a in bakeAttributes:
                connections = control.attr(a).inputs(type="animCurve")
                if connections:
                    tmpAnimCurves[controlName][a] = proxy.node(cmds.duplicate(connections[0].node)[0])

        controlsToBake.append(controlName)

    if not controlsToBake:
        cmds.warning("switchAttributeSeamlessly: nothing to switch")
        return

    if isRangeSelected:
        autoKeyPressed = cmds.autoKeyframe(q=True, state=True)
        if not autoKeyPressed:
            cmds.autoKeyframe(state=True)

        for f in range(int(startFrame), int(endFrame) + 1):
            cmds.currentTime(f)

            for controlName in controlsToBake:
                control = controlNodes[controlName]
                for a in bakeAttributes:
                    if a in tmpAnimCurves[controlName]:
                        values = cmds.keyframe(tmpAnimCurves[controlName][a], time=(f, f), eval=True, q=True)
                        if values:
                            control.attr(a).set(values[0])

            for controlName in controlsToBake:
                switchAttributeSeamlessly_local(controlName, attr, value)

        if not autoKeyPressed:
            cmds.autoKeyframe(state=False)

        for curves in tmpAnimCurves.values():
            cmds.delete(list(curves.values()))

    else:
        for controlName in controlsToBake:
            switchAttributeSeamlessly_local(controlName, attr, value)


def rotateOrderSwitchMulti(object, ro):
    """Set rotate order on control(s), preserving pose via stored matrices per key."""
    controlNames = list(set((cmds.ls(sl=True) or []) + [str(proxy.node(object))]))
    controls = proxy.nodes(controlNames)

    for ctrl in controls:

        # find animation curves on rotation
        animCurves = []
        for a in ["rx", "ry", "rz"]:
            animCurves.extend(plug.node for plug in ctrl.attr(a).inputs(type="animCurve"))

        frames = []
        for acurve in animCurves:
            for k in range(cmds.keyframe(acurve, q=True, keyframeCount=True)):
                f = cmds.keyframe(acurve, q=True, index=(k, k), timeChange=True)[0]
                if f not in frames:
                    frames.append(f)
        
        currentFrame = cmds.currentTime(q=True)

        matrices = []
        for f in frames:
            cmds.currentTime(f)
            matrices.append(cmds.xform(ctrl, q=True, m=True))

        ctrl.rotateOrder.set(ro)

        for f, m in zip(frames, matrices):
            cmds.currentTime(f)
            cmds.xform(ctrl, m=m)

        cmds.keyTangent(ctrl.rotate, itt="auto", ott="auto")

        cmds.currentTime(currentFrame)


def addFollow(
    ctrl, nofollow_transform, follow_transform, 
    attr="follow", default=0.0, type="parent",
    transform=None):
    """Add follow attribute to control."""
    ctrl = proxy.node(ctrl)
    nofollow_transform = proxy.node(nofollow_transform)
    follow_transform = proxy.node(follow_transform)
    transform = proxy.node(transform) if transform else None
    label = str(ctrl).rsplit("|", 1)[-1]

    ctrl.addAttr(ln=attr, min=0.0, max=1.0, dv=default, k=True)
    if not transform and type != "jointOrient":
        transform = proxy.node(cmds.group(ctrl, n=f"{label}_{attr}_transform"))
        
    if type == "point":
        c = proxy.node(cmds.pointConstraint(nofollow_transform, follow_transform, transform, mo=True)[0])
    elif type == "orient":
        c = proxy.node(cmds.parentConstraint(nofollow_transform, follow_transform, transform, mo=True, st=["x", "y", "z"])[0])
        c.interpType.set(2)
    elif type == "parent":
        c = proxy.node(cmds.parentConstraint(nofollow_transform, follow_transform, transform, mo=True)[0])
        c.interpType.set(2)
    elif type == "jointOrient":
        transform = proxy.create("transform", f"{label}_{attr}_transform", parent=ctrl.getParent())
        cmds.matchTransform(transform, ctrl)
             
        c = proxy.node(cmds.parentConstraint(nofollow_transform, follow_transform, transform, mo=True, st=["x", "y", "z"])[0])
        c.interpType.set(2)
        for axis in "xyz":
            transform.attr(f"r{axis}") >> ctrl.attr(f"jo{axis}")
        
    follow_rev = proxy.create("reverse", f"{label}_{attr}_reverse")
    ctrl.attr(attr) >> follow_rev.inputX
    follow_rev.outputX >> c.w0
    ctrl.attr(attr) >> c.w1
    return transform
