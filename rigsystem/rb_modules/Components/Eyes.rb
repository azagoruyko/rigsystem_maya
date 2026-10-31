<module name="Eyes" muted="0" uid="5224e40320b643a787c6a601ecabdd31">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy, rig_utils
from rigsystem.anim_utils import dynamicParent, switcher

cmds = proxy.cmds
L_eye_joint = proxy.node(@L_eye_joint)
R_eye_joint = proxy.node(@R_eye_joint)

internalParent = proxy.node("internal")
controlsParent = proxy.node("controls")
helpersParent = proxy.node("helpers")

if @mode == 0: # helpers  
    h_eye = rig_utils.curve.makeCurve("M_eyes_control_helper", "rect")
    cmds.pointConstraint(L_eye_joint, R_eye_joint, h_eye, sk=["z"])
    h_eye.r.set([90, 0, 90])
    h_eye.s.set([3, 1, 5])
    position = h_eye.t.get()[0]
    h_eye.t.set((position[0], position[1], position[2] + 30))
    helpersParent | h_eye
    rig_utils.lockTRS(h_eye, [1,1,0], [1,1,1], [], 1)
    @set_h_eye(str(h_eye))
    
    for side, jnt, setter in [("L", L_eye_joint, @set_h_left), 
                              ("R", R_eye_joint, @set_h_right)]:
        h = rig_utils.curve.makeCurve(side+"_eye_control_helper", "circle")
        helpersParent | h
        cmds.pointConstraint(jnt, h, sk=["z"])
        h_eye.tz >> h.tz
        h.r.set([90, 0, 90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        setter(str(h))
        rig_utils.connectFromSymmetric(h)     

elif @mode == 1: # run
    parent = proxy.node(@parent)
    options_ctrl = proxy.node(@options)
    
    h_eye = proxy.node(@h_eye)
    h_left = proxy.node(@h_left)
    h_right = proxy.node(@h_right)
    
    internal_grp = proxy.create("transform", "M_eyes_internal_group", parent=internalParent, suffix=False)
    internal_grp.v.set(False)
    cmds.orientConstraint(parent, internal_grp, mo=True)
    
    controls_grp = proxy.create("transform", "M_eyes_controls_group", parent=controlsParent, suffix=False)
    rig_utils.lockTRS(controls_grp, v=0.5)
    
    options_ctrl.addAttr(ln="eyes_ikfk", at="float", min=0, max=1, dv=0, k=True)
    
    ikfk_rev = proxy.create("reverse", "M_eyes_ikfk")
    options_ctrl.eyes_ikfk >> ikfk_rev.inputX
    
    # eye_ik
    eyeIK_ctrl = proxy.create("transform", "M_eyes_ik_control", parent=controls_grp, suffix=False)
    eyeIK_ctrl.addAttr(ln="distanceFocus", at="float", dv=@distanceFocusCoeff, k=True)
    
    cmds.matchTransform(eyeIK_ctrl, h_eye, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(eyeIK_ctrl)

    cmds.orientConstraint(parent, eyeIK_ctrl, mo=True)
    
    rig_utils.curve.makeFromCurve(eyeIK_ctrl, h_eye)
    
    ikfk_rev.outputX >> eyeIK_ctrl.v
    rig_utils.lockTRS(eyeIK_ctrl,[],[1,1,1],[1,1,1],1)
    
    dynamicParent.makeDynamicParent(eyeIK_ctrl, eyeIK_ctrl)
    
    # eye_fk
    eyeFK_transform = proxy.create("transform", "M_eyes_fk_control", parent=controls_grp)
    eyeFK_ctrl = proxy.create("transform", "M_eyes_fk_control", parent=eyeFK_transform, suffix=False)
    eyeFK_ctrl.ro.set(3) # xzy
    
    cmds.pointConstraint(L_eye_joint, R_eye_joint, eyeFK_transform)
    cmds.orientConstraint(parent, eyeFK_transform, mo=True)
    
    switcher.addFollow(eyeFK_ctrl, controls_grp, parent, attr="followHead", default=1.0, type="orient")    
    
    rig_utils.curve.makeFromCurve(eyeFK_ctrl, h_eye)
    rig_utils.lockTRS(eyeFK_ctrl, [1,1,1], [0,0,1], [1,1,1], 1)
    
    options_ctrl.eyes_ikfk >> eyeFK_transform.v

    eyes_ikfk_transform = proxy.create("transform", "M_eyes_ikfk", parent=controls_grp)
    cmds.matchTransform(eyes_ikfk_transform, eyeFK_ctrl, position=True, rotation=False)
    pc = proxy.node(cmds.parentConstraint(eyeFK_ctrl, eyeIK_ctrl, eyes_ikfk_transform, mo=True)[0])
    options_ctrl.eyes_ikfk >> pc.w0
    ikfk_rev.outputX >> pc.w1

    # aim joint
    j1 = proxy.create("joint", "M_eyes_aim", parent=internal_grp)
    j2 = proxy.create("joint", "M_eyes_aim_end", parent=j1)
    cmds.pointConstraint(L_eye_joint, R_eye_joint, j1)
    cmds.matchTransform(j2, eyeIK_ctrl, position=True, rotation=False)
    cmds.joint(j1, e=True, zso=True, oj="xyz", sao="yup", ch=True)
    cmds.setAttr(j1.rx, lock=True)

    ikHandle = proxy.node(cmds.ikHandle(sj=j1, ee=j2, sol="ikSCsolver")[0])
    ikHandle.rename("M_eyes_aim_ikHandle")
    internal_grp | ikHandle
    cmds.parentConstraint(eyes_ikfk_transform, ikHandle, mo=True)
    
    coeff_mult = proxy.create("multDL", "M_eyes_compensationCoeff")
    j1.ry >> coeff_mult.input1
    coeff_mult.input2.set(-@compensationCoeff)    

    comp_clamp = proxy.create("clamp", "M_eyes_compensation")
    comp_clamp.minR.set(0)
    comp_clamp.maxR.set(50)    
    comp_clamp.minG.set(-50)
    comp_clamp.maxG.set(0)    
    coeff_mult.output >> comp_clamp.inputR
    coeff_mult.output >> comp_clamp.inputG

    # distanceFocus compensation calculation
    dist_plug = rig_utils.createDistance("M_eyes_distanceFocus", eyeIK_ctrl, j1)

    initial_dist = (
        om.MVector(cmds.xform(j1, q=True, ws=True, t=True))
        - om.MVector(cmds.xform(eyeIK_ctrl, q=True, ws=True, t=True))
    ).length()

    dist_div = proxy.create("multiplyDivide", "M_eyes_distanceFocus_ratio")
    dist_div.operation.set(2) # divide
    dist_plug >> dist_div.input1X
    dist_div.input2X.set(initial_dist if initial_dist > 0.0001 else 1.0)

    distanceFocus_rev = proxy.create("reverse", "M_eyes_distanceFocus")
    dist_div.outputX >> distanceFocus_rev.inputX

    distanceFocus_mult = proxy.create("multDL", "M_eyes_distanceFocus")
    distanceFocus_rev.outputX >> distanceFocus_mult.input1
    eyeIK_ctrl.distanceFocus >> distanceFocus_mult.input2

    distanceFocus_ik_mult = proxy.create("multDL", "M_eyes_distanceFocus_ik")
    distanceFocus_mult.output >> distanceFocus_ik_mult.input1
    ikfk_rev.outputX >> distanceFocus_ik_mult.input2
        
    # left/right eye controls
    for side, helper, eye_joint in [("L", h_left, L_eye_joint), ("R", h_right, R_eye_joint)]:
        ctrl = proxy.create("transform", f"{side}_eye_offset_control", parent=eyes_ikfk_transform, suffix=False)
        
        cmds.matchTransform(ctrl, helper, position=True, rotation=False)
        rig_utils.setToOffsetParentMatrix(ctrl)
        rig_utils.curve.makeFromCurve(ctrl, helper)
        rig_utils.lockTRS(ctrl, [0,0,1], [1,1,1], [1,1,1], 1)
    
        # eye compensation on rotation
        comp_joint = proxy.create("joint", f"{side}_eye_compensation", parent=j1)
        cmds.matchTransform(comp_joint, eye_joint, position=True, rotation=False)
        cmds.pointConstraint(eye_joint, comp_joint)
        rig_utils.freezeJoints([comp_joint])
        
        cmds.parentConstraint(comp_joint, eye_joint, st=["x", "y", "z"], dr=True, mo=True)
        
        ry = comp_clamp.outputR if side == "L" else comp_clamp.outputG
        
        offset_mult = proxy.create("multiplyDivide", f"{side}_eye_offset")
        ctrl.t >> offset_mult.input1
        offset_mult.input2.set((@translateCoeff, @translateCoeff, @translateCoeff))
        
        offset_mult.outputY >> comp_joint.rz
        
        ry_add = proxy.create("addDL", f"{side}_eye_addOffset")
        ry >> ry_add.input1
        offset_mult.outputX >> ry_add.input2

        if side == "L":
            side_distanceFocus_mult = proxy.create("multDL", "L_eye_distanceFocus")
            distanceFocus_ik_mult.output >> side_distanceFocus_mult.input1
            side_distanceFocus_mult.input2.set(-1.0)
            distanceFocus_val = side_distanceFocus_mult.output
        else:
            distanceFocus_val = distanceFocus_ik_mult.output

        ry_distanceFocus_add = proxy.create("addDL", f"{side}_eye_addDistanceFocus")
        ry_add.output >> ry_distanceFocus_add.input1
        distanceFocus_val >> ry_distanceFocus_add.input2
        ry_distanceFocus_add.output >> comp_joint.ry
]]></run>
<doc><![CDATA[## Summary
The **eyes** module builds a fully‑functional eye rig that includes a master aim control, individual left/right eye offset controls, and a dynamic IK/FK blend. It supports a helper‑generation mode for placing guide objects and a run mode that creates the control hierarchy, internal joints, constraints, and compensation logic for eye movement and distance focus.

## Inputs
- **`mode`** – Radio button (`Helpers` or `Run`).  
  *Helpers* creates placement guides; *Run* builds the rig.  
- **`L_eye_joint` / `R_eye_joint`** – Names of the left and right eye joints that the rig will drive.  
- **`parent`** – The head joint or control that the eye rig will be parented to.  
- **`options`** – Node that receives an `eye_ikfk` float attribute for IK/FK blending.  
- **`compensationCoeff`** – Float (0–1) controlling how much the eye joints compensate for head rotation.  
- **`translateCoeff`** – Float (0–10) scaling the eye offset translation.  
- **`distanceFocusCoeff`** – Float (-100–100) scaling the distance‑focus compensation.  
- **`h_eye` / `h_left` / `h_right`** – Helper transform names created in *Helpers* mode; used as shape references when running the rig.

## Outputs
- **Control hierarchy** under `controlsParent`:
  - `M_eyes_internal_group` (internal group, hidden)  
  - `M_eyes_controls_group` (visible controls)  
  - `M_eyes_ik_control_null` → `M_eyes_ik_control` (IK master)  
  - `M_eyes_fk_control_null` → `M_eyes_fk_control` (FK master)  
  - `M_eyes_ikfk_transform` (blend node)  
  - `L_eye_offset_control_null` → `L_eye_offset_control` (left eye offset)  
  - `R_eye_offset_control_null` → `R_eye_offset_control` (right eye offset)  
- **Internal joint chain**: `M_eyes_1_joint` → `M_eyes_2_joint` (aim joint chain) and the IK handle `M_eyes_ikHandle`.  
- **Compensation nodes**: `M_eyes_compensationCoeff_multDL`, `M_eyes_compensation_clamp`, and per‑eye compensation joints.  
- **Distance‑focus nodes**: `M_eyes_distanceFocus`, `M_eyes_distanceFocus_ratio_multiplyDivide`, `M_eyes_distanceFocus_reverse`, `M_eyes_distanceFocus_multDL`, `M_eyes_distanceFocus_ik_multDL`.  
- **Attribute on `options` node**: `eye_ikfk` (float 0–1) used to drive the IK/FK blend.  
- **Helper nodes** under `helpersParent` when in *Helpers* mode: `M_eyes_control_helper`, `L_eye_control_helper`, `R_eye_control_helper`.

## Usage
1. **Set the target joints**: Assign the left and right eye joints to `L_eye_joint` and `R_eye_joint`.  
2. **Choose mode**:  
   - **Helpers** – Run the module to create the helper transforms (`M_eyes_control_helper`, etc.). Position them in the viewport to match the character’s eye geometry.  
   - **Run** – Switch to *Run* mode, provide the `parent` (head joint/control) and `options` node, then execute.  
3. **Configure parameters** (optional): Adjust `compensationCoeff`, `translateCoeff`, and `distanceFocusCoeff` to fine‑tune eye rotation compensation, offset translation, and distance‑focus behavior.  
4. **Connect to downstream rigs**: Use the generated control nodes (`M_eyes_ik_control`, `M_eyes_fk_control`, `L_eye_offset_control`, `R_eye_offset_control`) or the internal joints for further animation or facial rig integration.  
5. **Blend IK/FK**: Drive the `eye_ikfk` attribute on the `options` node (or expose it in a UI) to switch between IK and FK eye control.  

This module provides a robust, parameter‑driven eye rig that can be integrated into larger character rigs or used as a standalone eye system.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="L_eye_joint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_eye_joint"}]]></attr>
<attr name="R_eye_joint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_eye_joint"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_head_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="options" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_options_control"}]]></attr>
<attr name="compensationCoeff" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "1", "validator": 2, "value": 0.33, "min": "0", "buttonEnabled": false}]]></attr>
<attr name="translateCoeff" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "10", "validator": 2, "value": 5.0, "min": "0", "buttonEnabled": false}]]></attr>
<attr name="distanceFocusCoeff" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 5, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": -100, "max": 100, "validator": 2, "default": "value"}]]></attr>
<attr name="h_eye" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_eye_control_helper"}]]></attr>
<attr name="h_left" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_eye_control_helper"}]]></attr>
<attr name="h_right" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_eye_control_helper"}]]></attr>
</attributes>
</module>
