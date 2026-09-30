<module name="Leg" muted="0" uid="aa7b42755ced4f1a823ebfaa97540183">
<doc><![CDATA[## Summary  
The **L_leg** module creates a complete leg rig that supports IK/FK switching, foot roll, toe controls, stretch, soft‑IK, and optional pole‑vector locking. It first generates helper controls in *Helpers* mode, then builds the full rig in *Run* mode by composing two child modules: **limb** (the main IK/FK chain) and **foot** (toe and foot‑roll mechanics). All key objects are exposed through a `moduleInfo` node for downstream modules.

## Inputs  
- **`mode`** – Radio button (`Helpers` / `Run`).  
- **`name`** – Base name for all created nodes.  
- **`joint1` – `joint5`** – Names of the joint chain:  
  - `joint1`: hip / upper leg joint.  
  - `joint2`: knee joint.  
  - `joint3`: ankle joint.  
  - `joint4`: toe base joint.  
  - `joint5`: toe tip joint.  
- **`lastCtrlOrient`** – Optional transform used to orient the final IK control.  
- **`fkNoFollow`** – (unused in current code, placeholder for FK follow toggle).  
- **`isQuad`** – Boolean flag for quad‑leg rigs (affects foot‑roll behavior).  
- **`ikHelperType`** – Shape of the IK control curve (e.g., cube, sphere).  
- **`constrainIK`** – If checked, the IK handle is constrained to the pole‑vector control.  
- **`placeIkAt`** – Optional joint/transform to place the IK control at.  
- **Helper attributes (`h_*`)** – Names of helper transforms created in *Helpers* mode:  
  - `h_fk1`, `h_fk2`, `h_fk3` – FK control helpers.  
  - `h_ik` – IK control helper.  
  - `h_polevector` – Pole‑vector helper.  
  - `h_options` – Options helper.  
  - `h_heel`, `h_side1`, `h_side2`, `h_foot`, `h_footroll` – Foot‑pivot helpers.  
  - `h_toe_ik`, `h_toe_fk` – Toe control helpers.

## Outputs  
- **`out_ikfkSwitch`** – PlusMinusAverage node driving the IK/FK blend.  
- **`out_ik1` / `out_ik2` / `out_ik3`** – IK joint chain (ankle, knee, hip).  
- **`out_fk1` / `out_fk2` / `out_fk3`** – FK joint chain.  
- **`out_fix3`** – Final fix joint used for IK stretch.  
- **`out_ikHandle`** – Main IK handle.  
- **`out_fix2_ikHandle`** – Secondary IK handle for stretch.  
- **`out_ikCtrl`** – IK control transform.  
- **`out_polevecCtrl`** – Pole‑vector control transform.  
- **`moduleInfo`** – `ModuleInfo` node exposing all key objects and attributes for downstream modules.  
- **Foot module outputs** (via `moduleInfo`): foot‑roll control, toe IK/FK controls, and the foot module’s own `moduleInfo` node.

## Usage  
1. **Set the joint chain** – Assign `joint1`–`joint5` to the hip, knee, ankle, toe base, and toe tip joints.  
2. **Generate helpers** – Switch `mode` to **Helpers** and run the module. Helper transforms (`h_*`) will be created under the *helpers* group.  
3. **Adjust helpers** – In the viewport, move and orient the helper controls to match the desired rig layout.  
4. **Build the rig** – Set `mode` to **Run** and execute. The module will create the FK/IK chain, foot‑roll system, stretch/soft‑IK nodes, and expose all objects via `moduleInfo`.  
5. **Connect downstream** – Use the `moduleInfo` node or individual output attributes to link this leg rig to other modules (e.g., hand, spine, or animation pipelines).  
6. **Optional settings** –  
   - Set `ikHelperType` to change the IK control shape.  
   - Enable `constrainIK` to lock the IK handle to the pole‑vector control.  
   - For quad rigs, set `isQuad` to true to adjust foot‑roll behavior.  
   - Use `placeIkAt` to position the IK control at a specific joint or transform.  

Follow these steps to quickly generate a robust, animatable leg rig that integrates seamlessly into larger character rigs.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "L_leg", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_3_joint"}]]></attr>
<attr name="joint4" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_4_joint"}]]></attr>
<attr name="joint5" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_5_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="fkNoFollow" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="isQuad" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_polevector_control_helper"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_options_control_helper"}]]></attr>
<attr name="h_toe_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_toe_ik_control_helper"}]]></attr>
<attr name="h_toe_fk" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_toe_fk_control_helper"}]]></attr>
<attr name="h_heel" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_heelPivot_helper"}]]></attr>
<attr name="h_toe" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_toePivot_helper"}]]></attr>
<attr name="h_side1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_side1Pivot_helper"}]]></attr>
<attr name="h_side2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_side2Pivot_helper"}]]></attr>
<attr name="h_footroll" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_footroll_control_helper"}]]></attr>
<attr name="h_foot" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_footPivot_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "L_leg_1_position_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="limb" muted="0" uid="d2e886c7fa894a018b74d0f9b00c62e5">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    scale = rig_utils.getDistance(joint1, joint3) / 10
    
    p1 = rig_utils.matrix.taxis(joint1.wm.get())
    p2 = rig_utils.matrix.taxis(joint2.wm.get())
    p3 = rig_utils.matrix.taxis(joint3.wm.get())
        
    planeTransform = pm.createNode("transform", n=@name + "_ik_plane_helper_transform", p=helpersParent)
    pm.pointConstraint(joint2, planeTransform)
    oc = pm.orientConstraint(joint1, joint2, planeTransform)
    oc.interpType.set(2) # shortest

    #polevector
    h_polevector = rig_utils.curve.makeCurve(@name + "_ik_polevector_control_helper", "sphere")    
    h_polevector.s.set([scale/2, scale/2, scale/2])
    planeTransform | h_polevector
    
    avg = (p1 - p2).normal() + (p3 - p2).normal()
    pm.xform(h_polevector, ws=True, t=p2 - avg.normal() * scale*3)
    rig_utils.lockTRS(h_polevector, [1,0,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_polevector, ty=-1)
    @set_h_polevector(h_polevector.name())

    # IK Control
    h_ik = rig_utils.curve.makeCurve(@name + "_ik_control_helper", @ikHelperType)    
    
    isLeg = any(map(lambda x:x in ["leg", "frontLeg", "backLeg", "leg_front", "leg_back"], @name.split("_")))    
    if isLeg:     
        h_ik_transform = pm.createNode("transform", n=@name + "_ik_control_helper_transform", p=helpersParent)
        pm.pointConstraint(joint3, h_ik_transform, sk=["y"])
        pm.orientConstraint(joint3, h_ik_transform, sk=["x", "z"], mo=True)
        h_ik_transform | h_ik
        pm.xform(h_ik, ws=True, t=[p3[0], 0, p3[2]]) # place on ground
        h_ik.s.set([scale, scale/5, scale*2])
        rig_utils.lockTRS(h_ik, [0,1,0], [1,0,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik, tx=-1, ry=-1)
    else:
        helpersParent | h_ik
        pm.parentConstraint(@placeIkAt or joint3, h_ik)
        h_ik.s.set([scale, scale, scale])
        rig_utils.lockTRS(h_ik, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik)
    @set_h_ik(h_ik.name())
    
    #options
    h_options = rig_utils.curve.makeCurve(@name + "_options_control_helper", "flag")
    h_options.s.set([scale, scale, scale])
    planeTransform | h_options
    h_options.t.set([0,0,0])
    pm.orientConstraint(helpersParent, h_options, mo=True)
    rig_utils.lockTRS(h_options, [0,1,0], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_options(h_options.name()) 
    
    # position
    h_position = rig_utils.curve.makeCurve(@name + "_position_control_helper", "axis")
    helpersParent | h_position
    h_position.s.set([scale/2.0, scale/2.0, scale/2.0])
    pm.pointConstraint(joint1, h_position)
    rig_utils.lockTRS(h_position, [1,1,1], [], [])
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_position(h_position.name())     

    # FK
    h_fk1 = rig_utils.curve.makeCurve(@name + "_fk_1_control_helper", "circle")
    h_fk2 = rig_utils.curve.makeCurve(@name + "_fk_2_control_helper", "circle")
    h_fk3 = rig_utils.curve.makeCurve(@name + "_fk_3_control_helper", "circle")

    for j, h in [(joint1, h_fk1), (joint2, h_fk2), (joint3, h_fk3)]:
        helpersParent | h
        h.s.set([scale, scale, scale])
        
        pc = pm.parentConstraint(j, h)
        pc.target[0].targetOffsetRotate.set([0,0,90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h)

    @set_h_fk1(h_fk1.name())
    @set_h_fk2(h_fk2.name())
    @set_h_fk3(h_fk3.name())

if @mode == 1:  # run
    jointsParent = joint1.getParent()

    h_fk1 = pm.PyNode(@h_fk1)
    h_fk2 = pm.PyNode(@h_fk2)
    h_fk3 = pm.PyNode(@h_fk3)
    h_ik = pm.PyNode(@h_ik)
    h_polevector = pm.PyNode(@h_polevector)
    h_options = pm.PyNode(@h_options)
    h_position = pm.PyNode(@h_position) if pm.objExists(@h_position) else None

    # controls and joints groups
    controls_grp = pm.createNode("transform", n=@name + "_controls_group", p=controlsParent)

    internal_grp = pm.createNode("transform", n=@name + "_internal_group", p=internalParent)
    internal_grp.v.set(False)
    
    rig_utils.lockTRS(controls_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internal_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)

    others_grp = pm.createNode("transform", n=@name + "_others_group", p=othersParent)

    # options control
    options_ctrl = pm.createNode("transform", n=@name + "_options_control", p=controls_grp)
    pm.parentConstraint(joint1, options_ctrl)

    rig_utils.curve.makeFromCurve(options_ctrl, h_options)

    options_ctrl.addAttr("ikfk", at="float", min=0, max=1, k=True)
    options_ctrl.addAttr("scaleFactor1x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor2x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor3x", at="float", min=0.1, dv=1, k=True)
    
    for i, j in enumerate([joint1, joint2, joint3]):
        a = f"scaleFactor{i+1}"
        options_ctrl.addAttr(a, min=0.01, dv=1.0, k=True)
        if i == 2:
            md = pm.createNode("multiplyDivide", n=j+"_scaleFactor_multiplyDivide")
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
    ikfk_rev = pm.createNode("reverse", n=@name + "_ikfk_reverse")
    options_ctrl.ikfk >> ikfk_rev.inputX

    # bones start position control
    positionCtrl = None
    if h_position:
        options_ctrl.addAttr("positionControl", at="bool", dv=False)
        rig_utils.lockAttr(options_ctrl.positionControl, 0.5)    
        
        positionTransform = pm.createNode("transform", n=@name + "_1_position_control_transform", p=controls_grp)
        pm.matchTransform(positionTransform, jointsParent)
        pm.matchTransform(positionTransform, joint1, position=True, rotation=False)
        options_ctrl.positionControl >> positionTransform.v
        
        if jointsParent:
            pm.parentConstraint(jointsParent, positionTransform, mo=True)
        
        positionCtrl = pm.createNode("transform", n=@name + "_1_position_control", p=positionTransform)
        pm.matchTransform(positionCtrl, joint1, position=True, rotation=False)        
        
        rig_utils.curve.makeFromCurve(positionCtrl, h_position)
        rig_utils.lockTRS(positionCtrl, [])
        
    # IK chain
    ik1 = rig_utils.matchJoint(joint1, @name + "_ik_1_joint")
    ik2 = rig_utils.matchJoint(joint2, @name + "_ik_2_joint")
    ik3 = rig_utils.matchJoint(joint3, @name + "_ik_3_joint")
    internal_grp | ik1 | ik2 | ik3
    
    pm.parentConstraint(positionCtrl or jointsParent, ik1, mo=True, skipRotate=["x", "y", "z"]) # pointConstraint

    # FIX
    fix1 = rig_utils.matchJoint(joint1, @name + "_fix_1_joint")
    fix2 = rig_utils.matchJoint(joint2, @name + "_fix_2_joint")
    fix3 = rig_utils.matchJoint(joint3, @name + "_fix_3_joint")

    internal_grp | fix1 | fix2 | fix3

    pm.pointConstraint(ik1, fix1)

    # FK
    fk1 = rig_utils.matchJoint(joint1, @name + "_fk_1_joint")
    fk2 = rig_utils.matchJoint(joint2, @name + "_fk_2_joint")
    fk3 = rig_utils.matchJoint(joint3, @name + "_fk_3_joint")
    internal_grp | fk1 | fk2 | fk3

    # FK controls
    # fk1
    fk1_ctrl = pm.createNode("transform", n=@name + "_fk_1_control", p=controls_grp)  
    pm.matchTransform(fk1_ctrl, joint1)
    rig_utils.curve.makeFromCurve(fk1_ctrl, h_fk1)
    pm.parentConstraint(positionCtrl or jointsParent, fk1_ctrl, sr=["x","y","z"], mo=True)

    switcher.addFollow(fk1_ctrl, controls_grp, jointsParent, attr="followBody", default=0.0, type="orient")
    
    rig_utils.setToOffsetParentMatrix(fk1_ctrl)
    options_ctrl.ikfk >> fk1_ctrl.v
    rig_utils.lockTRS(fk1_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.parentConstraint(fk1_ctrl, fk1)
    
    # fk2
    fk2_ctrl = pm.createNode("transform", n=@name + "_fk_2_control", p=fk1_ctrl)
    pm.matchTransform(fk2_ctrl, joint2)
    pm.pointConstraint(fk2, fk2_ctrl)
    rig_utils.setToOffsetParentMatrix(fk2_ctrl)

    rig_utils.curve.makeFromCurve(fk2_ctrl, h_fk2)    
    rig_utils.lockTRS(fk2_ctrl, [1, 1, 1], [1, 1, 0], [1, 1, 1], 1)
    
    pm.orientConstraint(fk2_ctrl, fk2)
    
    # fk3
    fk3_ctrl = pm.createNode("transform", n=@name + "_fk_3_control", p=fk2_ctrl)
    pm.matchTransform(fk3_ctrl, joint3)
    pm.pointConstraint(fk3, fk3_ctrl)
    rig_utils.setToOffsetParentMatrix(fk3_ctrl)

    rig_utils.curve.makeFromCurve(fk3_ctrl, h_fk3)
    rig_utils.lockTRS(fk3_ctrl, [1, 1, 1], [], [1, 1, 1], 1)

    pm.orientConstraint(fk3_ctrl, fk3)
    
    # FIX IK handles
    fix_ikHandle1 = pm.ikHandle(startJoint=fix1,
                                endEffector=fix2,
                                solver="ikSCsolver",
                                n=@name + "_fix_1_ikHandle")[0]
    internal_grp | fix_ikHandle1

    fix_ikHandle2 = pm.ikHandle(startJoint=fix2,
                                endEffector=fix3,
                                solver="ikSCsolver",
                                n=@name + "_fix_2_ikHandle")[0]
    internal_grp | fix_ikHandle2    
    
    # IK handle
    ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik3, solver="ikRPsolver", n=@name + "_ikHandle")[0]
    internal_grp | ikHandle

    # IK control
    ik_ctrl = pm.createNode("joint", n=@name + "_ik_control", p=controls_grp)

    ik_ctrl.radius.set(0)
    rig_utils.lockAttr(ik_ctrl.radius, 1)
    
    pm.matchTransform(ik_ctrl, @placeIkAt or ik3, position=True, rotation=False)

    rig_utils.setToOffsetParentMatrix(ik_ctrl)
    
    if pm.objExists(@lastCtrlOrient):
        pm.matchTransform(ik_ctrl, @lastCtrlOrient, position=False, rotation=True)    
        rig_utils.freezeJoints([ik_ctrl])

    rig_utils.curve.makeFromCurve(ik_ctrl, h_ik)
    ikfk_rev.outputX >> ik_ctrl.v

    dynamicParent.makeDynamicParent(ik_ctrl, ik_ctrl)

    rig_utils.lockTRS(ik_ctrl, [], [], [1, 1, 1], 1)

    # IK polevector control
    polevec_follow_j1 = rig_utils.matchJoint(joint1, @name + "_ik_polevector_follow_1_joint")
    polevec_follow_j2 = rig_utils.matchJoint(joint3, @name + "_ik_polevector_follow_2_joint")
    internal_grp | polevec_follow_j1 | polevec_follow_j2    
    
    polevec_follow_ikHandle = pm.ikHandle(sj=polevec_follow_j1, ee=polevec_follow_j2, solver="ikSCsolver")[0]
    polevec_follow_ikHandle.rename(@name+"_ik_polevector_follow_ikHandle")
    internal_grp | polevec_follow_ikHandle
    
    pm.parentConstraint(ik_ctrl, polevec_follow_ikHandle, mo=True)
    pm.pointConstraint(ik1, polevec_follow_j1)
    
    polevec_ctrl = pm.createNode("transform", n=@name + "_ik_polevector_control", p=controls_grp)
    pm.matchTransform(polevec_ctrl, h_polevector, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(polevec_ctrl)    

    switcher.addFollow(polevec_ctrl, internal_grp, polevec_follow_j1, attr="follow", default=0.0, type="parent")
    
    polevec_ctrl.addAttr("snap", min=0, max=1, k=True)
    polevec_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    polevec_ctrl.stretch.set(0)

    rig_utils.curve.makeFromCurve(polevec_ctrl, h_polevector)
    
    ikfk_rev.outputX >> polevec_ctrl.v
    
    rig_utils.lockTRS(polevec_ctrl, [], [1, 1, 1], [1, 1, 1], 1)

    pm.pointConstraint(polevec_ctrl, fix_ikHandle1)  # snap fix1-fix2
    
    if @constrainIK:
        pm.pointConstraint(ik_ctrl, fix_ikHandle2)  # snap fix2-fix3    

    dynamicParent.makeDynamicParent(polevec_ctrl, polevec_ctrl)

    rig_utils.makeHelpLine(
        @name + "_polevector", 
        [polevec_ctrl, joint2],
        visibleAttr=ikfk_rev.outputX,
        parent=others_grp)

    ik_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    ik_ctrl.stretch.set(0)

    dFix1 = rig_utils.createDistance(@name + "_fix_1_distance", fix1, polevec_ctrl)
    dFix2 = rig_utils.createDistance(@name + "_fix_2_distance", fix2, ik_ctrl)
    d = rig_utils.createDistance(@name + "_ik_distance", ik1, ik_ctrl)

    ik2_tx_scaleMult = pm.createNode("multDL", n=ik2 + "_tx_scaleFactor1x_multDL")
    ik2_tx_scaleMult.input1.set(abs(ik2.tx.get()))
    options_ctrl.scaleFactor1x >> ik2_tx_scaleMult.input2

    ik3_tx_scaleMult = pm.createNode("multDL", n=ik3 + "_tx_scaleFactor2x_multDL")
    ik3_tx_scaleMult.input1.set(abs(ik3.tx.get()))
    options_ctrl.scaleFactor2x >> ik3_tx_scaleMult.input2

    ik2ik3_tx_sumAdd = pm.createNode("addDL", n=@name + "_ik_sum_tx_addDL")
    ik2_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input1
    ik3_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input2

    sFix1 = rig_utils.makeStretchable(
        @name + "_fix_1", 
        [fix1],
        dFix1, 
        polevec_ctrl.stretch,
        0.01, 0,
        ik2_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    sFix2 = rig_utils.makeStretchable(
        @name + "_fix_2", 
        [fix2],
        dFix2,
        ik_ctrl.stretch,
        0.01,
        0,
        ik3_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    s = rig_utils.makeStretchable(
        @name + "_ik", 
        [ik1, ik2],
        d,
        ik_ctrl.stretch,
        1,
        0,
        ik2ik3_tx_sumAdd.output,
        scales=[True, False, False],  
        useTx=False)

    # softIK
    ik_ctrl.addAttr("softIK", min=0, max=0.5, dv=0.05, k=True)

    ac_x = rig_utils.anim.createSoftIKAnimCurve(@name + "_softIK")

    stretchX = pm.PyNode(@name + "_ik_stretch_x_blendTwoAttr")
    cond = pm.PyNode(@name + "_ik_squash_condition")

    stretchX.output >> ac_x.input

    softIk_switch = pm.createNode("multDL", n=@name + "_softIK_switch_multDL")
    ik_ctrl.softIK >> softIk_switch.input1
    ik_ctrl.stretch >> softIk_switch.input2

    softIk_b2a = pm.createNode("blendTwoAttr", n=@name + "_softIK_blendTwoAttr")
    softIk_switch.output >> softIk_b2a.attributesBlender
    stretchX.output >> softIk_b2a.i[0]
    ac_x.output >> softIk_b2a.i[1]

    softIk_b2a.output >> cond.firstTerm
    softIk_b2a.output >> cond.colorIfTrueR

    # fk stretch with scaleFactor
    fk2_scaleFactor_mult = pm.createNode("multDL", n=fk2 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor1x >> fk2_scaleFactor_mult.input1
    fk2_scaleFactor_mult.input2.set(fk2.tx.get())
    fk2_scaleFactor_mult.output >> fk2.tx
    
    fk3_scaleFactor_mult = pm.createNode("multDL", n=fk3 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor2x >> fk3_scaleFactor_mult.input1
    fk3_scaleFactor_mult.input2.set(fk3.tx.get())
    fk3_scaleFactor_mult.output >> fk3.tx

    # ik stretch
    multIK1 = pm.createNode("multiplyDivide", n=ik1 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK1.input1X
    options_ctrl.scaleFactor1x >> multIK1.input2X

    multIK2 = pm.createNode("multiplyDivide", n=ik2 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK2.input1X
    options_ctrl.scaleFactor2x >> multIK2.input2X

    multFIX1 = pm.createNode("multiplyDivide", n=fix1 + "_scaleFactor_multiplyDivide")
    sFix1[0] >> multFIX1.input1X
    options_ctrl.scaleFactor1x >> multFIX1.input2X
    multFIX1.outputX >> fix1.sx

    multFIX2 = pm.createNode("multiplyDivide", n=fix2 + "_scaleFactor_multiplyDivide")
    sFix2[0] >> multFIX2.input1X
    options_ctrl.scaleFactor2x >> multFIX2.input2X
    multFIX2.outputX >> fix2.sx

    b2a = pm.createNode("blendTwoAttr", n=ik1 + "_stretch_x_blendTwoAttr")
    multIK1.outputX >> b2a.i[0]
    multFIX1.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik1.sx

    b2a = pm.createNode("blendTwoAttr", n=ik2 + "_stretch_x_blendTwoAttr")
    multIK2.outputX >> b2a.i[0]
    multFIX2.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik2.sx

    defPolevec = pm.createNode("transform", n=polevec_ctrl + "_default_transform")
    pm.matchTransform(defPolevec, h_polevector, position=True, rotation=False)
    pm.parent(defPolevec, fk2)

    pm.poleVectorConstraint(polevec_ctrl, ikHandle)

    if @constrainIK:
        pc = pm.pointConstraint(ik_ctrl, fix3, ikHandle)

        snap_rev = pm.createNode("reverse", n=@name + "_ik_snap_reverse")
        polevec_ctrl.snap >> snap_rev.inputX

        snap_rev.outputX >> pc.w0
        polevec_ctrl.snap >> pc.w1

        pm.orientConstraint(ik_ctrl, ik3, mo=True)

    # blend IKFK constraints
    for j, ikj, fkj in [(joint1, ik1, fk1), (joint2, ik2, fk2), (joint3, ik3, fk3)]:
        oc = pm.parentConstraint(ikj, fkj, j)
        oc.interpType.set(2)
        ikfk_rev.outputX >> oc.w0
        options_ctrl.ikfk >> oc.w1
        
    # ModuleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@name + "_limb")
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
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect="/name"><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "L_leg", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect="/joint1"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect="/joint2"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect="/joint3"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_3_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect="/lastCtrlOrient"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="ikHelperType" template="comboBox" category="Others" connect=""><![CDATA[{"current": "cube", "items": ["arc", "axis", "axisSphere", "cube", "circle", "diamond", "pyramid", "rect", "sphere", "triangle"], "default": "current"}]]></attr>
<attr name="constrainIK" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="placeIkAt" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect="/h_fk1"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect="/h_fk2"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect="/h_fk3"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect="/h_ik"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect="/h_polevector"><![CDATA[{"value": "L_leg_ik_polevector_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect="/h_options"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_options_control_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect="/h_position"><![CDATA[{"value": "L_leg_1_position_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="foot" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

mode = ch("../mode")
name = ch("../name")
lastCtrlOrient = ch("../lastCtrlOrient")
isQuad = False

j1 = pm.PyNode(ch("../joint3"))
j2 = pm.PyNode(ch("../joint4"))
j3 = pm.PyNode(ch("../joint5"))

internalParent = pm.PyNode("internal")
controlsParent = pm.PyNode("controls")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if mode == 0:  # helpers
    scale = rig_utils.getDistance(j1, j3) / 2.0
    smallScale = scale / 5.0
    p1 = pm.xform(j1, ws=True, q=True, t=True)
    p2 = pm.xform(j2, ws=True, q=True, t=True)
    p3 = pm.xform(j3, ws=True, q=True, t=True)   
    
    pivots_null = pm.PyNode(name + "_ik_control_helper_null")
    
    h_heel = rig_utils.curve.makeCurve(name+"_heelPivot_helper", "axis")
    pm.xform(h_heel, ws=True, t=[p1[0], 0, p1[2]-scale])
    h_heel.s.set([smallScale, smallScale, smallScale])    
    pivots_null | h_heel    
    rig_utils.lockTRS(h_heel, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_heel, tx=-1)
    chset("../h_heel", h_heel.name())

    h_side1 = rig_utils.curve.makeCurve(name+"_side1Pivot_helper", "axis")
    pm.xform(h_side1, ws=True, t=[p2[0]+scale/2, 0, p2[2]])
    h_side1.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_side1
    rig_utils.lockTRS(h_side1, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_side1, tx=-1)
    chset("../h_side1", h_side1.name())

    h_side2 = rig_utils.curve.makeCurve(name+"_side2Pivot_helper", "axis")
    pm.xform(h_side2, ws=True, t=[p2[0]-scale/2, 0, p2[2]])
    h_side2.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_side2
    rig_utils.lockTRS(h_side2, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_side2, tx=-1)
    chset("../h_side2", h_side2.name())

    h_toe = rig_utils.curve.makeCurve(name+"_toePivot_helper", "axis")
    pm.xform(h_toe, ws=True, t=[p3[0], 0, p3[2]+scale/2])
    h_toe.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_toe
    rig_utils.lockTRS(h_toe, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_toe, tx=-1)
    chset("../h_toe", h_toe.name())

    h_foot = rig_utils.curve.makeCurve(name+"_footPivot_helper", "axis")
    pm.xform(h_foot, ws=True, t=[p2[0], 0, p2[2]])
    h_foot.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_foot
    rig_utils.lockTRS(h_foot, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_foot, tx=-1)
    chset("../h_foot", h_foot.name())

    h_footroll = rig_utils.curve.makeCurve(name+"_footroll_control_helper", "sphere")    
    pm.parentConstraint(j1, h_footroll)
    
    h_footroll.s.set([scale, scale, scale])
    helpersParent | h_footroll
    rig_utils.lockTRS(h_footroll, [1,1,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_footroll)
    chset("../h_footroll", h_footroll.name())
    
    toes_transform = pm.createNode("transform", n=name+"_toes_helpers_transform", p=helpersParent)
    pm.parentConstraint(j2, toes_transform)
    
    for label in ["toe_ik", "toe_fk"]:
        h = rig_utils.curve.makeCurve(name+"_"+label+"_control_helper", "circle")
        toes_transform | h
        h.t.set([0,0,0])
        h.r.set([0,0,90])
        h.s.set([scale, scale, scale])
        rig_utils.lockTRS(h, [1,1,1], [1,1,0], [], 1)
        rig_utils.connectFromSymmetric(h)
        chset("../h_"+label, h.name())
        
elif mode == 1:  # run
    h_footroll = pm.PyNode(ch("../h_footroll"))
    h_toe_ik = pm.PyNode(ch("../h_toe_ik"))
    h_toe_fk = pm.PyNode(ch("../h_toe_fk"))
    h_heel = pm.PyNode(ch("../h_heel"))
    h_toe = pm.PyNode(ch("../h_toe"))
    h_foot = pm.PyNode(ch("../h_foot"))
    h_side1 = pm.PyNode(ch("../h_side1"))
    h_side2 = pm.PyNode(ch("../h_side2"))
    if h_side2.tx > h_side1.tx: # side1.tx must be > side2.tx
        h_side1, h_side2 = h_side2, h_side1

    limb_ikHandle = pm.PyNode(name+"_ikHandle")
    limb_options_ctrl = pm.PyNode(name+"_options_control")
    limb_ikfk_rev = pm.PyNode(name+"_ikfk_reverse")
    limb_ik3 = pm.PyNode(name+"_ik_3_joint")
    limb_fk3 = pm.PyNode(name+"_fk_3_joint")
    limb_fk3_ctrl = pm.PyNode(name+"_fk_3_control")
    limb_fix3 = pm.PyNode(name+"_fix_3_joint")
    limb_ik_ctrl = pm.PyNode(name+"_ik_control")
    limb_polevecCtrl = pm.PyNode(name+"_ik_polevector_control")
    limb_moduleInfo = pm.PyNode(name+"_limb_moduleInfo")

    internal_grp = pm.PyNode(name+"_internal_group")
    controls_grp = pm.PyNode(name+"_controls_group")

    # IK chain
    ik1 = limb_ik3  # get the last ik joint(ankle) in limb template

    ik2 = rig_utils.matchJoint(j2, name=name+"_ik_4_joint")
    ik3 = rig_utils.matchJoint(j3, name=name+"_ik_5_joint")
    ik1 | ik2 | ik3

    # FK Chain FK controls
    fk1 = limb_fk3  # get the last fk joint(ankle) in limb template

    fk2 = rig_utils.matchJoint(j2, name=name+"_fk_4_joint")
    fk3 = rig_utils.matchJoint(j3, name=name+"_fk_5_joint")
    fk1 | fk2 | fk3

    # toe FK
    toe_fk_transform = pm.createNode("transform", n=name+"_toe_fk_control_transform", p=limb_fk3_ctrl)
    pm.pointConstraint(fk2, toe_fk_transform)
    pm.orientConstraint(fk1, toe_fk_transform)
    
    toe_fk_ctrl = pm.createNode("transform", n=name+"_toe_fk_control", p=toe_fk_transform)
    rig_utils.curve.makeFromCurve(toe_fk_ctrl, h_toe_fk)
    rig_utils.lockTRS(toe_fk_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(toe_fk_ctrl, fk2, mo=True)

    tmpOrientTransform = pm.createNode("transform")
    if pm.objExists(lastCtrlOrient):
        pm.matchTransform(tmpOrientTransform, pm.PyNode(lastCtrlOrient), position=False, rotation=True)

    # main aux joint start at ankle
    aux1 = pm.createNode("joint", n=name+"_aux_1_joint")
    pm.matchTransform(aux1, tmpOrientTransform)
    pm.matchTransform(aux1, j1, position=True, rotation=False)
    aux1.v.set(0)
    internal_grp | aux1

    # heel land pivot
    aux2 = pm.createNode("joint", n=name+"_aux_2_joint")
    pm.matchTransform(aux2, tmpOrientTransform)
    pm.matchTransform(aux2, h_heel, position=True, rotation=False)
    aux1 | aux2

    # toe pivot
    aux3 = pm.createNode("joint", n=name+"_aux_3_joint")
    pm.matchTransform(aux3, tmpOrientTransform)
    pm.matchTransform(aux3, h_foot, position=True, rotation=False)
    aux2 | aux3

    # left side pivot
    aux4 = pm.createNode("joint", n=name+"_aux_4_joint")
    pm.matchTransform(aux4, tmpOrientTransform)
    pm.matchTransform(aux4, h_side1, position=True, rotation=False)
    aux3 | aux4

    # right side  pivot
    aux5 = pm.createNode("joint", n=name+"_aux_5_joint")
    pm.matchTransform(aux5, tmpOrientTransform)
    pm.matchTransform(aux5, h_side2, position=True, rotation=False)
    aux4 | aux5

    #toe 2 pivot
    aux6 = pm.createNode("joint", n=name+"_aux_6_joint")
    pm.matchTransform(aux6, tmpOrientTransform)
    pm.matchTransform(aux6, h_foot, position=True, rotation=False)
    aux5 | aux6

    # foot pivot
    aux7 = pm.createNode("joint", n=name+"_aux_7_joint")
    pm.matchTransform(aux7, tmpOrientTransform)
    pm.matchTransform(aux7, h_toe, position=True, rotation=False)
    aux6 | aux7

    # foot pivot
    aux8 = pm.createNode("joint", n=name+"_aux_8_joint")
    pm.matchTransform(aux8, tmpOrientTransform)
    pm.matchTransform(aux8, j3, position=True, rotation=False)
    aux7 | aux8

    # toe pivot
    aux9 = pm.createNode("joint", n=name+"_aux_9_joint")
    pm.matchTransform(aux9, tmpOrientTransform)
    pm.matchTransform(aux9, j2, position=True, rotation=False)
    aux8 | aux9

    # ankle pivot
    aux10 = pm.createNode("joint", n=name+"_aux_10_joint")
    pm.matchTransform(aux10, tmpOrientTransform)
    pm.matchTransform(aux10, j1, position=True, rotation=False)
    aux9 | aux10

    # toe pivot
    auxToe1 = pm.createNode("joint", n=name+"_auxToe_1_joint")
    pm.matchTransform(auxToe1, tmpOrientTransform)
    pm.matchTransform(auxToe1, j2, position=True, rotation=False)
    aux8 | auxToe1

    #toe end pivot
    auxToe2 = pm.createNode("joint", n=name+"_auxToe_2_joint")
    pm.matchTransform(auxToe2, tmpOrientTransform)
    pm.matchTransform(auxToe2, j3, position=True, rotation=False)
    auxToe1 | auxToe2

    rig_utils.freezeJoints([aux1, aux2, aux3, aux4, aux5, aux6, aux7, aux8, aux9, aux10, auxToe1, auxToe2])

    # set limits
    aux2.setLimited(aux2.LimitType.rotateMaxX, True)
    aux2.setLimit(aux2.LimitType.rotateMaxX, 0)

    aux4.setLimited(aux4.LimitType.rotateMaxZ, True)
    aux4.setLimit(aux4.LimitType.rotateMaxZ, 0)

    aux5.setLimited(aux5.LimitType.rotateMinZ, True)
    aux5.setLimit(aux5.LimitType.rotateMinZ, 0)

    aux6.setLimited(aux6.LimitType.rotateMinX, True)
    aux6.setLimit(aux6.LimitType.rotateMinX, 0)

    aux7.setLimited(aux7.LimitType.rotateMinX, True)
    aux7.setLimit(aux7.LimitType.rotateMinX, 0)

    aux9.setLimited(aux9.LimitType.rotateMinX, True)
    aux9.setLimit(aux9.LimitType.rotateMinX, 0)

    ##IK handles
    toe_ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik2, solver="ikSCsolver", n=name+"_toe_ikHandle")[0]
    foot_ikHandle = pm.ikHandle(startJoint=ik2, endEffector=ik3, solver="ikSCsolver", n=name+"_foot_ikHandle")[0]
    toe_ikHandle.v.set(0)
    foot_ikHandle.v.set(0)
    aux10 | toe_ikHandle
    auxToe1 | foot_ikHandle

    # foot snap
    fix = pm.PyNode(name+"_fix_2_ikHandle")
    pm.delete(fix.listRelatives(type="pointConstraint"))
    pm.pointConstraint(aux10, fix)
   
    snap_rev = pm.createNode("reverse", n=name+"_snap_reverse")
    limb_polevecCtrl.snap >> snap_rev.inputX

    pc = pm.pointConstraint(aux10, limb_fix3, limb_ikHandle)
    snap_rev.outputX >> pc.w0
    limb_polevecCtrl.snap >> pc.w1

    # footroll control
    footroll_ctrl = pm.createNode("transform", n=name+"_footroll_control", p=limb_ik_ctrl)
    pm.matchTransform(footroll_ctrl, tmpOrientTransform)
    pm.pointConstraint(aux10, footroll_ctrl)

    rig_utils.curve.makeFromCurve(footroll_ctrl, h_footroll)

    footroll_ctrl.addAttr("weight", at="float", min=0, max=1, dv=0, k=True)
    footroll_ctrl.addAttr("angle", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("heelPivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("footPivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("toePivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("anklePivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("freeHeel", at="bool", dv=False, k=False)

    rig_utils.lockTRS(footroll_ctrl, [1, 1, 1], [0, 1, 0], [1, 1, 1], 1)

    #Footroll utility nodes setup
    footroll_ctrl.heelPivot >> aux2.ry
    footroll_ctrl.footPivot >> aux3.ry
    footroll_ctrl.toePivot >> aux7.ry

    if not isQuad:
        footroll_ctrl.rx >> aux2.rx
    else:
        b2a = pm.createNode("blendTwoAttr", n=aux2+"_blendWeighted")
        footroll_ctrl.weight >> b2a.attributesBlender
        b2a.i[0].set(0)
        footroll_ctrl.rx >> b2a.i[1]
        b2a.output >> aux2.rx

    footroll_ctrl.rz >> aux4.rz
    footroll_ctrl.rz >> aux5.rz

    freeHeelRev = pm.createNode("reverse", n=footroll_ctrl+"_freeHeel_reverse")
    footroll_ctrl.freeHeel >> freeHeelRev.inputX
    freeHeelRev.outputX >> aux9.minRotXLimitEnable

    freeHeelCond = pm.createNode("condition", n=footroll_ctrl+"_freeHeel_condition")
    footroll_ctrl.weight >> freeHeelCond.firstTerm
    freeHeelCond.colorIfFalseR.set(0)
    footroll_ctrl.freeHeel >> freeHeelCond.colorIfTrueR
    freeHeelCond.outColorR >> aux2.minRotXLimitEnable

    plus = pm.createNode("plusMinusAverage", n=aux7+"_plusMinusAverage")
    plus.operation.set(2)  # -
    footroll_ctrl.rx >> plus.input1D[0]
    aux6.rx >> plus.input1D[1]

    b2a = pm.createNode("blendTwoAttr", n=aux7+"_blendWeighted")
    footroll_ctrl.weight >> b2a.attributesBlender
    b2a.i[0].set(0)
    plus.output1D >> b2a.i[1]
    b2a.output >> aux7.rx

    b2a = pm.createNode("blendTwoAttr", n=aux9+"_blendWeighted")
    footroll_ctrl.weight >> b2a.attributesBlender
    footroll_ctrl.rx >> b2a.i[0]
    b2a.i[1].set(0)
    b2a.output >> aux9.rx
    footroll_ctrl.anklePivot >> aux9.rz

    cond = pm.createNode("condition", n=aux6+"_condition")
    cond.operation.set(4)  # <
    footroll_ctrl.rx >> cond.firstTerm
    footroll_ctrl.angle >> cond.secondTerm
    footroll_ctrl.rx >> cond.colorIfTrueR
    footroll_ctrl.angle >> cond.colorIfFalseR
    cond.outColorR >> aux6.rx

    ##Toe IK control
    toe_ik_transform = pm.createNode("transform", n=name+"_toe_ik_control_transform", p=limb_ik_ctrl)
    pm.pointConstraint(aux9, toe_ik_transform)
    pm.orientConstraint(aux8, toe_ik_transform)
    
    toe_ik_ctrl = pm.createNode("transform", n=name+"_toe_ik_control", p=toe_ik_transform)

    rig_utils.curve.makeFromCurve(toe_ik_ctrl, h_toe_ik)
    rig_utils.lockTRS(toe_ik_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(toe_ik_ctrl, auxToe1)
    
    oc = pm.orientConstraint(ik2, fk2, j2)
    oc.interpType.set(2)
    limb_ikfk_rev.outputX >> oc.w0
    limb_options_ctrl.ikfk >> oc.w1

    pm.pointConstraint(limb_ik_ctrl, aux1, mo=True)
    pm.orientConstraint(limb_ik_ctrl, aux1, mo=True)
    
    # fix stretch
    aux10.pm >> pm.PyNode(name+"_fix_2_distance_multMatrix").matrixIn[0]
    aux10.t >> pm.PyNode(name+"_fix_2_distance_distanceBetween").point2

    aux10.pm >> pm.PyNode(name+"_ik_distance_multMatrix").matrixIn[0]
    aux10.t >> pm.PyNode(name+"_ik_distance_distanceBetween").point2

    if not isQuad:  # for humans
        footroll_ctrl.anklePivot.set(0, k=False, l=True, cb=False)
        footroll_ctrl.freeHeel.set(False, k=False, l=True, cb=False)
    else:  # for quads
        footroll_ctrl.freeHeel.set(True, k=False, l=True, cb=False)

    pm.delete(tmpOrientTransform)

    # Seamless
    limb_moduleInfo = rig_utils.moduleInfo.ModuleInfo(limb_moduleInfo)

    moduleInfo = rig_utils.moduleInfo.ModuleInfo(name+"_foot")
    moduleInfo.setAttr("type", "leg")

    moduleInfo.setAttr("limb", limb_moduleInfo)

    limb_moduleInfo.setParent(moduleInfo)

    switcher.makeSeamlessKinematicSwitching(moduleInfo, "toe_ik", toe_ik_ctrl, toe_fk_ctrl)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "toe_fk", toe_fk_ctrl, toe_ik_ctrl)

    moduleInfo.setAttr("footroll", footroll_ctrl.message)
]]></run>
</module>
</children>
</module>