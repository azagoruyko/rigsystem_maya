<module name="Limb" muted="0" uid="d2e886c7fa894a018b74d0f9b00c62e5">
<run><![CDATA[from rigsystem import proxy, rig_utils
from rigsystem.anim_utils import dynamicParent, switcher

cmds = proxy.cmds
joint1 = proxy.node(@joint1)
joint2 = proxy.node(@joint2)
joint3 = proxy.node(@joint3)

controlsParent = proxy.node("controls")
internalParent = proxy.node("internal")
othersParent = proxy.node("others")
helpersParent = proxy.node("helpers")

if @mode == 0:  # helpers
    scale = rig_utils.getDistance(joint1, joint3) / 10
    
    p1 = rig_utils.matrix.taxis(joint1.wm.get())
    p2 = rig_utils.matrix.taxis(joint2.wm.get())
    p3 = rig_utils.matrix.taxis(joint3.wm.get())
        
    planeTransform = proxy.create("transform", f"{@name}_ik_plane_helper", parent=helpersParent)
    cmds.pointConstraint(joint2, planeTransform)
    oc = proxy.node(cmds.orientConstraint(joint1, joint2, planeTransform)[0])
    oc.interpType.set(2) # shortest

    #polevector
    h_polevector = rig_utils.curve.makeCurve(f"{@name}_ik_polevector_control_helper", "sphere")
    h_polevector.s.set([scale/2, scale/2, scale/2])
    planeTransform | h_polevector
    
    avg = (p1 - p2).normal() + (p3 - p2).normal()
    polePosition = p2 - avg.normal() * scale * 3
    cmds.xform(h_polevector, ws=True, t=(polePosition.x, polePosition.y, polePosition.z))
    rig_utils.lockTRS(h_polevector, [1,0,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_polevector, ty=-1)
    @set_h_polevector(str(h_polevector))

    # IK Control
    h_ik = rig_utils.curve.makeCurve(f"{@name}_ik_control_helper", @ikHelperType)
    
    isLeg = any(part in {"leg", "frontLeg", "backLeg", "leg_front", "leg_back"} for part in @name.split("_"))
    if isLeg:     
        h_ik_transform = proxy.create("transform", f"{@name}_ik_control_helper", parent=helpersParent)
        cmds.pointConstraint(joint3, h_ik_transform, sk=["y"])
        cmds.orientConstraint(joint3, h_ik_transform, sk=["x", "z"], mo=True)
        h_ik_transform | h_ik
        cmds.xform(h_ik, ws=True, t=(p3.x, 0, p3.z)) # place on ground
        h_ik.s.set([scale, scale/5, scale*2])
        rig_utils.lockTRS(h_ik, [0,1,0], [1,0,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik, tx=-1, ry=-1)
    else:
        helpersParent | h_ik
        cmds.parentConstraint(@placeIkAt or joint3, h_ik)
        h_ik.s.set([scale, scale, scale])
        rig_utils.lockTRS(h_ik, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik)
    @set_h_ik(str(h_ik))
    
    #options
    h_options = rig_utils.curve.makeCurve(f"{@name}_options_control_helper", "flag")
    h_options.s.set([scale, scale, scale])
    planeTransform | h_options
    h_options.t.set([0,0,0])
    cmds.orientConstraint(helpersParent, h_options, mo=True)
    rig_utils.lockTRS(h_options, [0,1,0], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_options(str(h_options))
    
    # position
    h_position = rig_utils.curve.makeCurve(f"{@name}_position_control_helper", "axis")
    helpersParent | h_position
    h_position.s.set([scale/2.0, scale/2.0, scale/2.0])
    cmds.pointConstraint(joint1, h_position)
    rig_utils.lockTRS(h_position, [1,1,1], [], [])
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_position(str(h_position))

    # FK
    h_fk1 = rig_utils.curve.makeCurve(f"{@name}_fk_1_control_helper", "circle")
    h_fk2 = rig_utils.curve.makeCurve(f"{@name}_fk_2_control_helper", "circle")
    h_fk3 = rig_utils.curve.makeCurve(f"{@name}_fk_3_control_helper", "circle")

    for j, h in [(joint1, h_fk1), (joint2, h_fk2), (joint3, h_fk3)]:
        helpersParent | h
        h.s.set([scale, scale, scale])
        
        pc = proxy.node(cmds.parentConstraint(j, h)[0])
        pc.attr("target[0].targetOffsetRotate").set((0, 0, 90))
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h)

    @set_h_fk1(str(h_fk1))
    @set_h_fk2(str(h_fk2))
    @set_h_fk3(str(h_fk3))

if @mode == 1:  # run
    jointsParent = joint1.getParent()

    h_fk1 = proxy.node(@h_fk1)
    h_fk2 = proxy.node(@h_fk2)
    h_fk3 = proxy.node(@h_fk3)
    h_ik = proxy.node(@h_ik)
    h_polevector = proxy.node(@h_polevector)
    h_options = proxy.node(@h_options)
    h_position = proxy.node(@h_position) if cmds.objExists(@h_position) else None

    # controls and joints groups
    controls_grp = proxy.create("transform", f"{@name}_controls_group", parent=controlsParent, suffix=False)

    internal_grp = proxy.create("transform", f"{@name}_internal_group", parent=internalParent, suffix=False)
    internal_grp.v.set(False)
    
    rig_utils.lockTRS(controls_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internal_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)

    others_grp = proxy.create("transform", f"{@name}_others_group", parent=othersParent, suffix=False)

    # options control
    options_ctrl = proxy.create("transform", f"{@name}_options_control", parent=controls_grp, suffix=False)
    cmds.parentConstraint(joint1, options_ctrl)

    rig_utils.curve.makeFromCurve(options_ctrl, h_options)

    options_ctrl.addAttr(ln="ikfk", at="float", min=0, max=1, k=True)
    options_ctrl.addAttr(ln="scaleFactor1x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr(ln="scaleFactor2x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr(ln="scaleFactor3x", at="float", min=0.1, dv=1, k=True)
    
    for i, j in enumerate([joint1, joint2, joint3]):
        a = f"scaleFactor{i+1}"
        options_ctrl.addAttr(ln=a, min=0.01, dv=1.0, k=True)
        if i == 2:
            md = proxy.create("multiplyDivide", f"{j.localName()}_scaleFactor")
            options_ctrl.attr(a) >> md.input1X
            options_ctrl.attr(a) >> md.input1Y
            options_ctrl.attr(a) >> md.input1Z
            options_ctrl.scaleFactor3x >> md.input2X
            md.output >> j.s
        else:
            options_ctrl.attr(a) >> j.sx
            options_ctrl.attr(a) >> j.sy
            options_ctrl.attr(a) >> j.sz

    rig_utils.lockTRS(options_ctrl, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)
    
    # ikfk switch
    ikfk_rev = proxy.create("reverse", f"{@name}_ikfk")
    options_ctrl.ikfk >> ikfk_rev.inputX

    # bones start position control
    positionCtrl = None
    if h_position:
        positionTransform = proxy.create("transform", f"{@name}_1_position_control", parent=controls_grp)
        cmds.matchTransform(positionTransform, jointsParent)
        cmds.matchTransform(positionTransform, joint1, position=True, rotation=False)
        
        if jointsParent:
            cmds.parentConstraint(jointsParent, positionTransform, mo=True)
        
        positionCtrl = proxy.create("transform", f"{@name}_1_position_control", parent=positionTransform, suffix=False)
        cmds.matchTransform(positionCtrl, joint1, position=True, rotation=False)
        
        rig_utils.curve.makeFromCurve(positionCtrl, h_position)
        rig_utils.lockTRS(positionCtrl, [])
        
    # IK chain
    ik1 = proxy.node(rig_utils.matchJoint(joint1, f"{@name}_ik_1_joint"))
    ik2 = proxy.node(rig_utils.matchJoint(joint2, f"{@name}_ik_2_joint"))
    ik3 = proxy.node(rig_utils.matchJoint(joint3, f"{@name}_ik_3_joint"))
    internal_grp | ik1 | ik2 | ik3
    
    cmds.parentConstraint(positionCtrl or jointsParent, ik1, mo=True, skipRotate=["x", "y", "z"]) # pointConstraint

    # FIX
    fix1 = proxy.node(rig_utils.matchJoint(joint1, f"{@name}_fix_1_joint"))
    fix2 = proxy.node(rig_utils.matchJoint(joint2, f"{@name}_fix_2_joint"))
    fix3 = proxy.node(rig_utils.matchJoint(joint3, f"{@name}_fix_3_joint"))

    internal_grp | fix1 | fix2 | fix3

    cmds.pointConstraint(ik1, fix1)

    # FK
    fk1 = proxy.node(rig_utils.matchJoint(joint1, f"{@name}_fk_1_joint"))
    fk2 = proxy.node(rig_utils.matchJoint(joint2, f"{@name}_fk_2_joint"))
    fk3 = proxy.node(rig_utils.matchJoint(joint3, f"{@name}_fk_3_joint"))
    internal_grp | fk1 | fk2 | fk3

    # FK controls
    # fk1
    fk1_ctrl = proxy.create("transform", f"{@name}_fk_1_control", parent=controls_grp, suffix=False)
    cmds.matchTransform(fk1_ctrl, joint1)
    rig_utils.curve.makeFromCurve(fk1_ctrl, h_fk1)
    cmds.parentConstraint(positionCtrl or jointsParent, fk1_ctrl, sr=["x","y","z"], mo=True)

    switcher.addFollow(fk1_ctrl, controls_grp, jointsParent, attr="followBody", default=0.0, type="orient")
    
    rig_utils.setToOffsetParentMatrix(fk1_ctrl)
    options_ctrl.ikfk >> fk1_ctrl.v
    rig_utils.lockTRS(fk1_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    cmds.parentConstraint(fk1_ctrl, fk1)
    
    # fk2
    fk2_ctrl = proxy.create("transform", f"{@name}_fk_2_control", parent=fk1_ctrl, suffix=False)
    cmds.matchTransform(fk2_ctrl, joint2)
    cmds.pointConstraint(fk2, fk2_ctrl)
    rig_utils.setToOffsetParentMatrix(fk2_ctrl)

    rig_utils.curve.makeFromCurve(fk2_ctrl, h_fk2)    
    rig_utils.lockTRS(fk2_ctrl, [1, 1, 1], [1, 1, 0], [1, 1, 1], 1)
    
    cmds.orientConstraint(fk2_ctrl, fk2)
    
    # fk3
    fk3_ctrl = proxy.create("transform", f"{@name}_fk_3_control", parent=fk2_ctrl, suffix=False)
    cmds.matchTransform(fk3_ctrl, joint3)
    cmds.pointConstraint(fk3, fk3_ctrl)
    rig_utils.setToOffsetParentMatrix(fk3_ctrl)

    rig_utils.curve.makeFromCurve(fk3_ctrl, h_fk3)
    rig_utils.lockTRS(fk3_ctrl, [1, 1, 1], [], [1, 1, 1], 1)

    cmds.orientConstraint(fk3_ctrl, fk3)
    
    # FIX IK handles
    fix_ikHandle1 = proxy.node(cmds.ikHandle(startJoint=fix1,
                                endEffector=fix2,
                                solver="ikSCsolver",
                                n=f"{@name}_fix_1_ikHandle")[0])
    internal_grp | fix_ikHandle1

    fix_ikHandle2 = proxy.node(cmds.ikHandle(startJoint=fix2,
                                endEffector=fix3,
                                solver="ikSCsolver",
                                n=f"{@name}_fix_2_ikHandle")[0])
    internal_grp | fix_ikHandle2    
    
    # IK handle
    ikHandle = proxy.node(cmds.ikHandle(startJoint=ik1, endEffector=ik3, solver="ikRPsolver", n=f"{@name}_ikHandle")[0])
    internal_grp | ikHandle

    # IK control
    ik_ctrl = proxy.create("joint", f"{@name}_ik_control", parent=controls_grp, suffix=False)

    ik_ctrl.radius.set(0)
    rig_utils.lockAttr(ik_ctrl.radius, 1)
    
    cmds.matchTransform(ik_ctrl, @placeIkAt or ik3, position=True, rotation=False)

    rig_utils.setToOffsetParentMatrix(ik_ctrl)
    
    if cmds.objExists(@lastCtrlOrient):
        cmds.matchTransform(ik_ctrl, @lastCtrlOrient, position=False, rotation=True)
        rig_utils.freezeJoints([ik_ctrl])

    rig_utils.curve.makeFromCurve(ik_ctrl, h_ik)
    ikfk_rev.outputX >> ik_ctrl.v

    dynamicParent.makeDynamicParent(ik_ctrl, ik_ctrl)

    rig_utils.lockTRS(ik_ctrl, [], [], [1, 1, 1], 1)

    # IK polevector control
    polevec_follow_j1 = proxy.node(rig_utils.matchJoint(joint1, f"{@name}_ik_polevector_follow_1_joint"))
    polevec_follow_j2 = proxy.node(rig_utils.matchJoint(joint3, f"{@name}_ik_polevector_follow_2_joint"))
    internal_grp | polevec_follow_j1 | polevec_follow_j2    
    
    polevec_follow_ikHandle = proxy.node(cmds.ikHandle(sj=polevec_follow_j1, ee=polevec_follow_j2, solver="ikSCsolver")[0])
    polevec_follow_ikHandle.rename(f"{@name}_ik_polevector_follow_ikHandle")
    internal_grp | polevec_follow_ikHandle
    
    cmds.parentConstraint(ik_ctrl, polevec_follow_ikHandle, mo=True)
    cmds.pointConstraint(ik1, polevec_follow_j1)
    
    polevec_ctrl = proxy.create("transform", f"{@name}_ik_polevector_control", parent=controls_grp, suffix=False)
    cmds.matchTransform(polevec_ctrl, h_polevector, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(polevec_ctrl)    

    switcher.addFollow(polevec_ctrl, internal_grp, polevec_follow_j1, attr="follow", default=0.0, type="parent")
    
    polevec_ctrl.addAttr(ln="snap", min=0, max=1, k=True)
    polevec_ctrl.addAttr(ln="stretch", min=0, max=1, dv=1, k=True)
    polevec_ctrl.stretch.set(0)

    rig_utils.curve.makeFromCurve(polevec_ctrl, h_polevector)
    
    ikfk_rev.outputX >> polevec_ctrl.v
    
    rig_utils.lockTRS(polevec_ctrl, [], [1, 1, 1], [1, 1, 1], 1)

    cmds.pointConstraint(polevec_ctrl, fix_ikHandle1)  # snap fix1-fix2
    
    if @constrainIK:
        cmds.pointConstraint(ik_ctrl, fix_ikHandle2)  # snap fix2-fix3

    dynamicParent.makeDynamicParent(polevec_ctrl, polevec_ctrl)

    rig_utils.makeHelpLine(
        f"{@name}_polevector",
        [polevec_ctrl, joint2],
        visibleAttr=str(ikfk_rev.outputX),
        parent=others_grp)

    ik_ctrl.addAttr(ln="stretch", min=0, max=1, dv=1, k=True)
    ik_ctrl.stretch.set(0)

    dFix1 = rig_utils.createDistance(f"{@name}_fix_1_distance", fix1, polevec_ctrl)
    dFix2 = rig_utils.createDistance(f"{@name}_fix_2_distance", fix2, ik_ctrl)
    d = rig_utils.createDistance(f"{@name}_ik_distance", ik1, ik_ctrl)

    ik2_tx_scaleMult = proxy.create("multDL", f"{ik2.localName()}_tx_scaleFactor1x")
    ik2_tx_scaleMult.input1.set(abs(ik2.tx.get()))
    options_ctrl.scaleFactor1x >> ik2_tx_scaleMult.input2

    ik3_tx_scaleMult = proxy.create("multDL", f"{ik3.localName()}_tx_scaleFactor2x")
    ik3_tx_scaleMult.input1.set(abs(ik3.tx.get()))
    options_ctrl.scaleFactor2x >> ik3_tx_scaleMult.input2

    ik2ik3_tx_sumAdd = proxy.create("addDL", f"{@name}_ik_sum_tx")
    ik2_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input1
    ik3_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input2

    sFix1 = rig_utils.makeStretchable(
        f"{@name}_fix_1",
        [fix1],
        dFix1, 
        str(polevec_ctrl.stretch),
        0.01, 0,
        str(ik2_tx_scaleMult.output),
        scales=[True, False, False])
                                    
    sFix2 = rig_utils.makeStretchable(
        f"{@name}_fix_2",
        [fix2],
        dFix2,
        str(ik_ctrl.stretch),
        0.01,
        0,
        str(ik3_tx_scaleMult.output),
        scales=[True, False, False])
                                    
    s = rig_utils.makeStretchable(
        f"{@name}_ik",
        [ik1, ik2],
        d,
        str(ik_ctrl.stretch),
        1,
        0,
        str(ik2ik3_tx_sumAdd.output),
        scales=[True, False, False],  
        useTx=False)

    # softIK
    ik_ctrl.addAttr(ln="softIK", min=0, max=0.5, dv=0.05, k=True)

    ac_x = proxy.node(rig_utils.anim.createSoftIKAnimCurve(f"{@name}_softIK"))

    stretchX = proxy.node(f"{@name}_ik_stretch_x_blendTwoAttr")
    cond = proxy.node(f"{@name}_ik_squash_condition")

    stretchX.output >> ac_x.input

    softIk_switch = proxy.create("multDL", f"{@name}_softIK_switch")
    ik_ctrl.softIK >> softIk_switch.input1
    ik_ctrl.stretch >> softIk_switch.input2

    softIk_b2a = proxy.create("blendTwoAttr", f"{@name}_softIK")
    softIk_switch.output >> softIk_b2a.attributesBlender
    stretchX.output >> softIk_b2a.i[0]
    ac_x.output >> softIk_b2a.i[1]

    softIk_b2a.output.connect(cond.firstTerm, force=True)
    softIk_b2a.output.connect(cond.colorIfTrueR, force=True)

    # fk stretch with scaleFactor
    fk2_scaleFactor_mult = proxy.create("multDL", f"{fk2.localName()}_scaleFactor")
    options_ctrl.scaleFactor1x >> fk2_scaleFactor_mult.input1
    fk2_scaleFactor_mult.input2.set(fk2.tx.get())
    fk2_scaleFactor_mult.output >> fk2.tx
    
    fk3_scaleFactor_mult = proxy.create("multDL", f"{fk3.localName()}_scaleFactor")
    options_ctrl.scaleFactor2x >> fk3_scaleFactor_mult.input1
    fk3_scaleFactor_mult.input2.set(fk3.tx.get())
    fk3_scaleFactor_mult.output >> fk3.tx

    # ik stretch
    multIK1 = proxy.create("multiplyDivide", f"{ik1.localName()}_scaleFactor")
    s[0] >> multIK1.input1X
    options_ctrl.scaleFactor1x >> multIK1.input2X

    multIK2 = proxy.create("multiplyDivide", f"{ik2.localName()}_scaleFactor")
    s[0] >> multIK2.input1X
    options_ctrl.scaleFactor2x >> multIK2.input2X

    multFIX1 = proxy.create("multiplyDivide", f"{fix1.localName()}_scaleFactor")
    sFix1[0] >> multFIX1.input1X
    options_ctrl.scaleFactor1x >> multFIX1.input2X
    multFIX1.outputX.connect(fix1.sx, force=True)

    multFIX2 = proxy.create("multiplyDivide", f"{fix2.localName()}_scaleFactor")
    sFix2[0] >> multFIX2.input1X
    options_ctrl.scaleFactor2x >> multFIX2.input2X
    multFIX2.outputX.connect(fix2.sx, force=True)

    b2a = proxy.create("blendTwoAttr", f"{ik1.localName()}_stretch_x")
    multIK1.outputX >> b2a.i[0]
    multFIX1.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output.connect(ik1.sx, force=True)

    b2a = proxy.create("blendTwoAttr", f"{ik2.localName()}_stretch_x")
    multIK2.outputX >> b2a.i[0]
    multFIX2.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output.connect(ik2.sx, force=True)

    defPolevec = proxy.create("transform", f"{polevec_ctrl.localName()}_default")
    cmds.matchTransform(defPolevec, h_polevector, position=True, rotation=False)
    cmds.parent(defPolevec, fk2)

    cmds.poleVectorConstraint(polevec_ctrl, ikHandle)

    if @constrainIK:
        pc = proxy.node(cmds.pointConstraint(ik_ctrl, fix3, ikHandle)[0])

        snap_rev = proxy.create("reverse", f"{@name}_ik_snap")
        polevec_ctrl.snap >> snap_rev.inputX

        snap_rev.outputX >> pc.w0
        polevec_ctrl.snap >> pc.w1

        cmds.orientConstraint(ik_ctrl, ik3, mo=True)

    # blend IKFK constraints
    for j, ikj, fkj in [(joint1, ik1, fk1), (joint2, ik2, fk2), (joint3, ik3, fk3)]:
        oc = proxy.node(cmds.parentConstraint(ikj, fkj, j)[0])
        oc.interpType.set(2)
        ikfk_rev.outputX >> oc.w0
        options_ctrl.ikfk >> oc.w1
        
    # ModuleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(f"{@name}_limb")
    moduleInfo.setAttr("type", "limb")

    moduleInfo.setAttr("options", options_ctrl.message)
    moduleInfo.setAttr("ikfk", options_ctrl.ikfk)    
    moduleInfo.setAttr("snap", polevec_ctrl.snap)     
    moduleInfo.setAttr("ik1_joint", ik1.message)
    moduleInfo.setAttr("ik2_joint", ik2.message)
    moduleInfo.setAttr("ik3_joint", ik3.message)
    moduleInfo.setAttr("fk1_joint", fk1.message)
    moduleInfo.setAttr("fk2_joint", fk2.message)
    moduleInfo.setAttr("fk3_joint", fk3.message)    
    moduleInfo.setAttr("ik", ik_ctrl.message)
    moduleInfo.setAttr("polevector", polevec_ctrl.message)
    moduleInfo.setAttr("fk1", fk1_ctrl.message)
    moduleInfo.setAttr("fk2", fk2_ctrl.message)
    moduleInfo.setAttr("fk3", fk3_ctrl.message)

    # seamless
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk1", fk1_ctrl, ik1)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk2", fk2_ctrl, ik2)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk3", fk3_ctrl, ik3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "ik", ik_ctrl, fk3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "polevector", polevec_ctrl, defPolevec)
]]></run>
<doc><![CDATA[## Summary  
The **L_arm** module creates a fully functional IK/FK arm rig. It first generates placement helpers (IK plane, pole‑vector, IK and FK controls) in *Helpers* mode, then builds the rig in *Run* mode, adding an IK/FK switch, pole‑vector controller, stretch and soft‑IK logic, and exposes all key objects through a `ModuleInfo` node for downstream use.

## Inputs  
- **mode** – Selects *Helpers* (0) or *Run* (1).  
- **name** – Base name for all generated nodes.  
- **joint1 / joint2 / joint3** – Target joint names forming the arm chain.  
- **lastCtrlOrient** – Optional joint used to orient the final IK control.  
- **ikHelperType** – Shape of the IK control curve (e.g., cube, sphere).  
- **constrainIK** – Boolean to enable optional IK‑to‑fix constraints.  
- **placeIkAt** – Optional transform to position the IK control at start.

## Outputs  
- **h_fk1 / h_fk2 / h_fk3** – FK helper curves.  
- **h_ik** – IK helper curve.  
- **h_polevector** – Pole‑vector helper curve.  
- **h_options** – Options helper curve.  
- **out_ikfkSwitch** – PlusMinusAverage node driving the IK/FK blend.  
- **out_ik1 / out_ik2 / out_ik3** – IK joint chain.  
- **out_fk1 / out_fk2 / out_fk3** – FK joint chain.  
- **out_fix3** – Third fix joint for optional constraints.  
- **out_ikHandle** – Main IK handle.  
- **out_fix2_ikHandle** – Secondary IK handle for fix joints.  
- **out_ikCtrl** – IK control joint.  
- **out_polevecCtrl** – Pole‑vector control.  
- **moduleInfo** – `ModuleInfo` node exposing rig type, joints, controls, and switch attributes.

## Usage  
1. **Set Target Joints** – Assign `joint1`, `joint2`, and `joint3` to the arm’s shoulder, elbow, and wrist joints.  
2. **Generate Helpers** – Set `mode` to **Helpers** and run. The module will create placement helpers under the *Helpers* parent, scaled to the joint spacing. Adjust their positions and orientations in the viewport.  
3. **Configure Optional Settings** –  
   - Choose an `ikHelperType` shape.  
   - Toggle `constrainIK` if you need the IK control to drive the fix joints.  
   - If desired, set `placeIkAt` to a transform that will be used as the IK control’s base position.  
4. **Build the Rig** – Switch `mode` to **Run** and execute. The module will create the full FK/IK chain, IK/FK switch, pole‑vector controller, stretch and soft‑IK systems, and lock/unlock attributes appropriately.  
5. **Connect to Other Modules** – Use the `moduleInfo` node or the individual output attributes (`out_ikCtrl`, `out_polevecCtrl`, `out_fk1`, etc.) to link this arm rig to downstream modules such as hand, fingers, or other limb systems.  
6. **Mirror or Duplicate** – The helper attributes (`h_fk1`, `h_fk2`, `h_fk3`, `h_ik`, `h_polevector`, `h_options`) can be mirrored or reused for building a symmetrical arm.  

The module automatically handles mirroring, dynamic parenting, and provides a clean interface for further customization or integration into larger rigging pipelines.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "L_arm", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_3_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_3_joint"}]]></attr>
<attr name="ikHelperType" template="comboBox" category="Others" connect=""><![CDATA[{"current": "cube", "items": ["arc", "axis", "axisSphere", "cube", "circle", "diamond", "pyramid", "rect", "sphere", "triangle"], "default": "current"}]]></attr>
<attr name="constrainIK" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="placeIkAt" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "L_arm_ik_polevector_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_options_control_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
