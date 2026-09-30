<module name="Eyes" muted="0" uid="5224e40320b643a787c6a601ecabdd31">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

L_eye_joint = pm.PyNode(@L_eye_joint)
R_eye_joint = pm.PyNode(@R_eye_joint)

internalParent = pm.PyNode("internal")
controlsParent = pm.PyNode("controls")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0: # helpers  
    h_eye = rig_utils.curve.makeCurve("M_eyes_control_helper", "rect")
    pm.pointConstraint(L_eye_joint, R_eye_joint, h_eye, sk=["z"])
    h_eye.r.set([90, 0, 90])
    h_eye.s.set([3, 1, 5])
    h_eye.t.set(h_eye.t.get() + [0, 0, 30])    
    helpersParent | h_eye
    rig_utils.lockTRS(h_eye, [1,1,0], [1,1,1], [], 1)
    @set_h_eye(h_eye.name())
    
    for side, jnt, setter in [("L", L_eye_joint, @set_h_left), 
                              ("R", R_eye_joint, @set_h_right)]:
        h = rig_utils.curve.makeCurve(side+"_eye_control_helper", "circle")
        helpersParent | h
        pm.pointConstraint(jnt, h, sk=["z"])
        h_eye.tz >> h.tz
        h.r.set([90, 0, 90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        setter(h.name())
        rig_utils.connectFromSymmetric(h)     

elif @mode == 1: # run
    parent = pm.PyNode(@parent)
    options_ctrl = pm.PyNode(@options)
    
    h_eye = pm.PyNode(@h_eye)
    h_left = pm.PyNode(@h_left)
    h_right = pm.PyNode(@h_right)
    
    internal_grp = pm.createNode("transform", n="M_eyes_internal_group", p=internalParent)
    internal_grp.v.set(False)
    pm.orientConstraint(parent, internal_grp, mo=True)
    
    controls_grp = pm.createNode("transform", n="M_eyes_controls_group", p=controlsParent)
    rig_utils.lockTRS(controls_grp, v=0.5)
    
    options_ctrl.addAttr("eyes_ikfk", at="float", min=0, max=1, dv=0, k=True)
    
    ikfk_rev = pm.createNode("reverse", n="M_eyes_ikfk_reverse")
    options_ctrl.eyes_ikfk >> ikfk_rev.inputX
    
    # eye_ik
    eyeIK_ctrl = pm.createNode("transform", n="M_eyes_ik_control", p=controls_grp)
    eyeIK_ctrl.addAttr("distanceFocus", at="float", dv=@distanceFocusCoeff, k=True)
    
    pm.matchTransform(eyeIK_ctrl, h_eye, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(eyeIK_ctrl)

    pm.orientConstraint(parent, eyeIK_ctrl, mo=True)
    
    rig_utils.curve.makeFromCurve(eyeIK_ctrl, h_eye)
    
    ikfk_rev.outputX >> eyeIK_ctrl.v
    rig_utils.lockTRS(eyeIK_ctrl,[],[1,1,1],[1,1,1],1)
    
    dynamicParent.makeDynamicParent(eyeIK_ctrl, eyeIK_ctrl)
    
    # eye_fk
    eyeFK_transform = pm.createNode("transform", n="M_eyes_fk_control_transform", p=controls_grp)
    eyeFK_ctrl = pm.createNode("transform", n="M_eyes_fk_control", p=eyeFK_transform)
    eyeFK_ctrl.ro.set(3) # xzy
    
    pm.pointConstraint(L_eye_joint, R_eye_joint, eyeFK_transform)
    pm.orientConstraint(parent, eyeFK_transform, mo=True)    
    
    switcher.addFollow(eyeFK_ctrl, controls_grp, parent, attr="followHead", default=1.0, type="orient")    
    
    rig_utils.curve.makeFromCurve(eyeFK_ctrl, h_eye)
    rig_utils.lockTRS(eyeFK_ctrl, [1,1,1], [0,0,1], [1,1,1], 1)
    
    options_ctrl.eyes_ikfk >> eyeFK_transform.v

    eyes_ikfk_transform = pm.createNode("transform", n="M_eyes_ikfk_transform", p=controls_grp)
    pm.matchTransform(eyes_ikfk_transform, eyeFK_ctrl, position=True, rotation=False)
    pc = pm.parentConstraint(eyeFK_ctrl, eyeIK_ctrl, eyes_ikfk_transform, mo=True)
    options_ctrl.eyes_ikfk >> pc.w0
    ikfk_rev.outputX >> pc.w1
    
    # aim joint
    j1 = pm.createNode("joint", n="M_eyes_aim_joint", p=internal_grp)
    j2 = pm.createNode("joint", n="M_eyes_aim_end_joint", p=j1)
    pm.pointConstraint(L_eye_joint, R_eye_joint, j1)
    pm.matchTransform(j2, eyeIK_ctrl, position=True, rotation=False)
    pm.joint(j1, e=True, zso=True, oj="xyz", sao="yup", ch=True)
    j1.rx.lock()    
    
    ikHandle = pm.ikHandle(sj=j1, ee=j2, sol="ikSCsolver")[0]
    ikHandle.rename("M_eyes_aim_ikHandle")
    internal_grp | ikHandle
    pm.parentConstraint(eyes_ikfk_transform, ikHandle, mo=True)  
    
    coeff_mult = pm.createNode("multDL",n="M_eyes_compensationCoeff_multDL")
    j1.ry >> coeff_mult.input1
    coeff_mult.input2.set(-@compensationCoeff)    

    comp_clamp = pm.createNode("clamp", n="M_eyes_compensation_clamp")
    comp_clamp.minR.set(0)
    comp_clamp.maxR.set(50)    
    comp_clamp.minG.set(-50)
    comp_clamp.maxG.set(0)    
    coeff_mult.output >> comp_clamp.inputR
    coeff_mult.output >> comp_clamp.inputG

    # distanceFocus compensation calculation
    dist_plug = rig_utils.createDistance("M_eyes_distanceFocus", eyeIK_ctrl, j1)

    initial_dist = (j1.getTranslation(space="world") - eyeIK_ctrl.getTranslation(space="world")).length()

    dist_div = pm.createNode("multiplyDivide", n="M_eyes_distanceFocus_ratio_multiplyDivide")
    dist_div.operation.set(2) # divide
    dist_plug >> dist_div.input1X
    dist_div.input2X.set(initial_dist if initial_dist > 0.0001 else 1.0)

    distanceFocus_rev = pm.createNode("reverse", n="M_eyes_distanceFocus_reverse")
    dist_div.outputX >> distanceFocus_rev.inputX

    distanceFocus_mult = pm.createNode("multDL", n="M_eyes_distanceFocus_multDL")
    distanceFocus_rev.outputX >> distanceFocus_mult.input1
    eyeIK_ctrl.distanceFocus >> distanceFocus_mult.input2

    distanceFocus_ik_mult = pm.createNode("multDL", n="M_eyes_distanceFocus_ik_multDL")
    distanceFocus_mult.output >> distanceFocus_ik_mult.input1
    ikfk_rev.outputX >> distanceFocus_ik_mult.input2
        
    # left/right eye controls
    for side, helper, eye_joint in [("L", h_left, L_eye_joint), ("R", h_right, R_eye_joint)]:
        ctrl = pm.createNode("transform", n=side+"_eye_offset_control", p=eyes_ikfk_transform)
        
        pm.matchTransform(ctrl, helper, position=True, rotation=False)
        rig_utils.setToOffsetParentMatrix(ctrl)
        rig_utils.curve.makeFromCurve(ctrl, helper)
        rig_utils.lockTRS(ctrl, [0,0,1], [1,1,1], [1,1,1], 1)
    
        # eye compensation on rotation
        comp_joint = pm.createNode("joint", n=side+"_eye_compensation_joint", p=j1)
        pm.matchTransform(comp_joint, eye_joint, position=True, rotation=False)
        pm.pointConstraint(eye_joint, comp_joint)    
        rig_utils.freezeJoints([comp_joint])
        
        pm.parentConstraint(comp_joint, eye_joint, st=["x", "y", "z"], dr=True, mo=True)
        
        ry = comp_clamp.outputR if side == "L" else comp_clamp.outputG
        
        offset_mult = pm.createNode("multiplyDivide", n=side+"_eye_offset_multiplyDivide")
        ctrl.t >> offset_mult.input1
        offset_mult.input2.set([@translateCoeff, @translateCoeff, @translateCoeff])
        
        offset_mult.outputY >> comp_joint.rz
        
        ry_add = pm.createNode("addDL", n=side+"_eye_addOffset_addDL")
        ry >> ry_add.input1
        offset_mult.outputX >> ry_add.input2

        if side == "L":
            side_distanceFocus_mult = pm.createNode("multDL", n="L_eye_distanceFocus_multDL")
            distanceFocus_ik_mult.output >> side_distanceFocus_mult.input1
            side_distanceFocus_mult.input2.set(-1.0)
            distanceFocus_val = side_distanceFocus_mult.output
        else:
            distanceFocus_val = distanceFocus_ik_mult.output

        ry_distanceFocus_add = pm.createNode("addDL", n=side+"_eye_addDistanceFocus_addDL")
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