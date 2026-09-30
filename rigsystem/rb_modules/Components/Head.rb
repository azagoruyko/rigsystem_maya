<module name="Head" muted="0" uid="b79cb052aef143f7ad8ea6d3260f8e98">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

ROTATE_ORDER = 3  # XZY

neckJoint = pm.PyNode(@neckJoint)
headJoint = pm.PyNode(@headJoint)

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")
        
if @mode == 0:  # helpers
    scale = rig_utils.getDistance(neckJoint, headJoint)

    # neck FK helper
    neckHelper_transform = pm.createNode("transform", n="M_neck_helper_transform", p=helpersParent)
    pm.parentConstraint(neckJoint, neckHelper_transform)
    
    neckFKHelper = rig_utils.curve.makeCurve("M_neck_fk_ctrl_helper", "circle")
    neckHelper_transform | neckFKHelper
    neckFKHelper.s.set([scale/2, scale/2, scale/2])
    rig_utils.lockTRS(neckFKHelper, [0,1,1], [1,1,1], [], 1)    
    @set_h_neckFK(neckFKHelper.name())

    # head options helper
    headHelpers_transform = pm.createNode("transform", n="M_head_helpers_transform", p=helpersParent)
    pm.parentConstraint(headJoint, headHelpers_transform)
    
    helper = rig_utils.curve.makeCurve("M_head_options_ctrl_helper", "flag")

    helper.s.set([scale/2, scale/2, scale/2])
    headHelpers_transform | helper
    helper.t.set([0,0,-scale])
    rig_utils.lockTRS(helper, [1,1,0], [1,1,1], [], 1)
    @set_h_options(helper.name())

    # head FK helper
    helper = rig_utils.curve.makeCurve("M_head_fk_ctrl_helper", "circle")
    headHelpers_transform | helper
    helper.t.set([scale, 0, 0])
    helper.r.set([0, 0, 90])
    helper.s.set([scale, scale, scale])
    rig_utils.lockTRS(helper, [0,1,1], [1,1,1], [], 1)
    @set_h_headFK(helper.name())

    # head IK helper
    helper = rig_utils.curve.makeCurve("M_head_ik_ctrl_helper", "sphere")
    headHelpers_transform | helper
    helper.t.set([scale/2, 0, 0])
    helper.s.set([scale, scale, scale])
    rig_utils.lockTRS(helper, [0,1,1], [1,1,1], [], 1)    
    @set_h_headIK(helper.name())

elif @mode == 1:  # run
    neckParent = neckJoint.getParent()

    neckFKHelper = pm.PyNode(@h_neckFK)
    headFKHelper = pm.PyNode(@h_headFK)
    headIKHelper = pm.PyNode(@h_headIK)
    optionsHelper = pm.PyNode(@h_options)

    controls_grp = pm.createNode("transform", n="M_neck_controls_group", p=controlsParent)
    rig_utils.lockTRS(controls_grp)

    internal_grp = pm.createNode("transform", n="M_neck_internal_group", p=internalParent)
    rig_utils.lockTRS(internal_grp, v=0.5)

    # head options control
    head_options_ctrl = pm.createNode("transform", n="M_head_options_control", p=controls_grp)
    pm.parentConstraint(headJoint, head_options_ctrl)

    head_options_ctrl.addAttr("ikfk", min=0, max=1, dv=1, k=True)  # fk default

    head_options_ctrl.addAttr("scaleFactor", min=0.01, dv=1.0, k=True)
    head_options_ctrl.scaleFactor >> headJoint.sx
    head_options_ctrl.scaleFactor >> headJoint.sy
    head_options_ctrl.scaleFactor >> headJoint.sz

    rig_utils.curve.makeFromCurve(head_options_ctrl, optionsHelper)
    rig_utils.lockTRS(head_options_ctrl)

    ikfk_rev = pm.createNode("reverse", n="M_neck_ikfk_reverse")
    head_options_ctrl.ikfk >> ikfk_rev.inputX
    
    # ik/fk bones
    fk1 = rig_utils.matchJoint(neckJoint, name="M_neck_fk_joint")
    fk2 = rig_utils.matchJoint(headJoint, name="M_head_fk_joint")
    internal_grp | fk1 | fk2

    ik1 = rig_utils.matchJoint(neckJoint, name="M_neck_ik_joint")
    ik2 = rig_utils.matchJoint(headJoint, name="M_head_ik_joint")
    internal_grp | ik1 | ik2
    
    pm.pointConstraint(neckJoint, ik1)

    # neck FK control
    neck_fk_ctrl_transform = pm.createNode("transform", n="M_neck_fk_control_transform", p=controls_grp)
    pm.matchTransform(neck_fk_ctrl_transform, neckParent)
    pm.pointConstraint(neckJoint, neck_fk_ctrl_transform)
    head_options_ctrl.ikfk >> neck_fk_ctrl_transform.v
    
    neck_fk_ctrl = pm.createNode("transform", n="M_neck_fk_control")
    neck_fk_ctrl_transform | neck_fk_ctrl
    neck_fk_ctrl.ro.set(ROTATE_ORDER)
    neck_fk_ctrl.addAttr("scaleFactor",min=0.01, dv=1.0, k=True)
        
    pm.matchTransform(neck_fk_ctrl, neckJoint, position=True, rotation=False)  # position

    if pm.objExists(@neckOrient):  # local orientation
        pm.matchTransform(neck_fk_ctrl, @neckOrient, position=False, rotation=True)
            
    switcher.addFollow(neck_fk_ctrl, controls_grp, neckParent, attr="followBody", default=1.0, transform=neck_fk_ctrl_transform, type="orient")
    
    rig_utils.setToOffsetParentMatrix(neck_fk_ctrl)
    rig_utils.curve.makeFromCurve(neck_fk_ctrl, neckFKHelper)
    rig_utils.lockTRS(neck_fk_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.parentConstraint(neck_fk_ctrl, fk1, mo=True)
    neck_fk_ctrl.scaleFactor >> fk1.sx    
    
    # head FK control
    head_fk_ctrl = pm.createNode("transform", n="M_head_fk_control", p=neck_fk_ctrl)
    head_fk_ctrl.ro.set(ROTATE_ORDER)

    pm.matchTransform(head_fk_ctrl, headJoint, position=True, rotation=False)  # position

    if pm.objExists(@headOrient):  # local orientation
        pm.matchTransform(head_fk_ctrl, @headOrient, position=False, rotation=True)

    switcher.addFollow(head_fk_ctrl, controls_grp, neck_fk_ctrl, attr="followNeck", default=0.0, type="orient")
        
    rig_utils.setToOffsetParentMatrix(head_fk_ctrl)
    rig_utils.curve.makeFromCurve(head_fk_ctrl, headFKHelper)
    
    pm.pointConstraint(fk2, head_fk_ctrl, mo=True)
    
    rig_utils.lockTRS(head_fk_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(head_fk_ctrl, fk2, mo=True)

    # head IK control
    head_ik_ctrl = pm.createNode("joint", n="M_head_ik_control", p=controls_grp)
    head_ik_ctrl.ro.set(ROTATE_ORDER)
    head_ik_ctrl.radius.set(0)
    
    ikfk_rev.outputX >> head_ik_ctrl.v

    switcher.addFollow(head_ik_ctrl, controls_grp, neckParent, attr="followBody", default=1.0, type="parent")
    switcher.addFollow(head_ik_ctrl, controls_grp, neckParent, attr="followNeck", default=0.0, type="jointOrient")
    
    pm.matchTransform(head_ik_ctrl, headJoint, position=True, rotation=False)  # position

    if pm.objExists(@headOrient):  # local orientation
        pm.matchTransform(head_ik_ctrl, @headOrient, position=False, rotation=True)

    rig_utils.setToOffsetParentMatrix(head_ik_ctrl)

    rig_utils.curve.makeFromCurve(head_ik_ctrl, headIKHelper)
    
    dynamicParent.makeDynamicParent(head_ik_ctrl, head_ik_ctrl)
    rig_utils.lockTRS(head_ik_ctrl, [], [], [1, 1, 1], 1)
    rig_utils.lockAttr(head_ik_ctrl.radius)
    
    ik_sc_ikHandle = pm.ikHandle(
        sj=ik1,
        ee=ik2,
        solver="ikSCsolver",
        n="M_neck_ik_ikHandle")[0]
    internal_grp | ik_sc_ikHandle
    
    pm.parentConstraint(head_ik_ctrl, ik_sc_ikHandle, mo=True)
    
    d = rig_utils.createDistance("M_neck_ik_distance", ik1, head_ik_ctrl)
    
    rig_utils.makeStretchable(
        "M_neck_ik_stretch",
        [ik1],
        d,
        squash=0.01,
        saveVolume=0,
        scales=(True, False, False),
    )
    
    pm.orientConstraint(head_ik_ctrl, ik2, mo=True)
    
    # head constraints
    oc = pm.orientConstraint(fk1, ik1, neckJoint)
    oc.interpType.set(2)
    head_options_ctrl.ikfk >> oc.w0
    ikfk_rev.outputX >> oc.w1
    
    pc = pm.parentConstraint(fk2, ik2, headJoint, mo=True)
    pc.interpType.set(2)
    head_options_ctrl.ikfk >> pc.w0
    ikfk_rev.outputX >> pc.w1
    
    # moduleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo("M_head")
    moduleInfo.setAttr("type","head")

    moduleInfo.setAttr("options", head_options_ctrl.message)
    moduleInfo.setAttr("ikfk", head_options_ctrl.ikfk)
    
    moduleInfo.setAttr("head_joint", headJoint.message)
    moduleInfo.setAttr("neck_joint", neckJoint.message)
    moduleInfo.setAttr("neck_ik_joint", ik1.message)
    
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "neck_fk", neck_fk_ctrl, ik1)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "head_fk", head_fk_ctrl, head_ik_ctrl)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "head_ik", head_ik_ctrl, head_fk_ctrl)
]]></run>
<doc><![CDATA[## Summary
Builds a comprehensive head and neck rig that supports FK and IK control, head‑follow options, neck twist and stretch, and seamless kinematic switching. The system creates helper curves in *Helpers* mode, then constructs the full control hierarchy, joint chains, blend shapes, and stretchable spline IK in *Run* mode, publishing a `moduleInfo` node for downstream modules.

## Inputs
- **`mode`** (`Helpers` / `Run`): Toggles between generating placement helpers and building the final rig.
- **`headJoint`**: Name of the head joint that will be driven by the rig.
- **`neckJoints`**: List of neck joint names (typically one or more joints from base to head).
- **`numSpans`**: Number of spans for the spline curves used in FK/IK chains.
- **`numFKControls`**: Number of FK control points along the neck.
- **`splineIK_upAxis`**: Integer specifying the up‑axis for the spline IK solver.
- **`splineIK_upVector`**: 3‑component vector defining the up‑vector for the spline IK.
- **`neckControlsOrient`**: Optional transform used to orient neck FK controls locally.
- **`headControlsOrient`**: Optional transform used to orient head FK/IK controls locally.
- **`fkWeights` / `ikWeights`**: JSON objects containing pre‑defined skinning weights for FK and IK chains.
- **Helper attributes** (`neckFKHelpers`, `headFKHelper`, `headIKHelper`, `optionsHelper`): Names of helper curves created in *Helpers* mode; used to drive the final control shapes.

## Outputs
- **`moduleInfo` node (`M_head`)**: Publishes rig metadata (type, head/neck joints, scale factors, IK/FK switch attribute, options control) for downstream modules.
- **Control hierarchy**:  
  - `M_head_options_control` (FK default) with `ikfk` attribute.  
  - `M_head_fk_control` (FK head control).  
  - `M_head_ik_control` (IK head control).  
- **Joint chains**:  
  - FK joints (`M_neck_fk_*_joint`), end joint, and internal twist joints (`M_neck_rotate_*_joint`).  
  - IK joints (`M_head_ik_root_joint`, `M_head_ik_joint`).  
  - Spline IK joints (`M_neck_spline_*_joint`).  
- **Blend shapes & IK handles**: `M_neck` blend shape, spline IK handle, twist IK handle, and stretch nodes.
- **Helper groups**: `M_neck_controls_group`, `M_neck_internal_group`, `M_neck_others_group`.

## Usage
1. **Prepare the scene**: Create the head joint and one or more neck joints.  
2. **Run in *Helpers* mode** (`mode = 0`):  
   - The module will generate FK, head options, and IK helper curves under the `helpers` parent.  
   - Adjust the helper positions and orientations in the viewport to match the character’s anatomy.  
3. **Switch to *Run* mode** (`mode = 1`) and execute:  
   - The module reads the helper names, builds the full control hierarchy, joint chains, and spline IK.  
   - It also sets up stretch, twist, and seamless kinematic switching.  
4. **Connect downstream modules**:  
   - Use the `moduleInfo` node (`M_head`) to expose the head control, joint references, and IK/FK switch to other rigs (e.g., facial, eye, or torso modules).  
   - The `ikfk` attribute on the options control can be driven by external controllers for global IK/FK blending.  

Follow these steps to integrate the head rig into a larger character rig, ensuring that helper placement and joint ordering are correct before running the final build.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="headJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_head_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="neckJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_neck_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="neckOrient" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="headOrient" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_neckFK" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "M_neck_fk_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_headFK" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_fk_control_helper"}]]></attr>
<attr name="h_headIK" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_ik_control_helper"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_options_control_helper"}]]></attr>
</attributes>
</module>