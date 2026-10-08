<module name="CreateFKControls" muted="0" uid="2583b3b8a41a4ee6b2235c66a1acfd28">
<run><![CDATA[import pymel.core as pm
import rig_utils

controlPerJoint = []

for j in @joints:
    j = pm.PyNode(j)
    name = j.name().replace("_joint", "")
    
    ctrl = pm.createNode("transform", n=name+"_control")
    h = rig_utils.curve.makeCurve(ctrl, @helper)
    h.r.set([0,0,90])
    rig_utils.curve.makeFromCurve(ctrl, h)
    pm.delete(h)
   
    if @orientation == 0: # world
        pm.matchTransform(ctrl, j, position=True, rotation=False)
    elif @orientation == 1: # joint
        pm.matchTransform(ctrl, j)
        
    rig_utils.setToOffsetParentMatrix(ctrl)        

    if @connectScale:
        ctrl.s >> j.s
        
    pm.parentConstraint(ctrl, j, mo=True)
    rig_utils.lockTRS(ctrl, [], [], [], 1)
    controlPerJoint.append(ctrl)
    
if @setParent == 1: # parent by hierarchy
    for i in range(1, len(controlPerJoint)):
        controlPerJoint[i-1] | controlPerJoint[i]
        rig_utils.setToOffsetParentMatrix(controlPerJoint[i])
    ]]></run>
<doc><![CDATA[## Summary
Creates forward‑kinematics (FK) control curves for a list of joints, allowing optional orientation matching, scale linking, and hierarchical or constraint‑based parenting of the generated controls.

## Inputs
- **`joints`** – List of joint names (e.g., `L_hair_curl_a_1_joint`) that the FK controls will follow.
- **`orientation`** – Radio button (`world` or `joint`) determining whether the control null matches only the joint position or both position and rotation.
- **`helper`** – Combo box selecting the shape of the helper curve used to build the control curve (`circle`, `rect`, `sphere`, `cube`).
- **`connectScale`** – Check box that, when checked, links the control’s scale to the joint’s scale.
- **`setParent`** – Radio button controlling how the FK controls are parented:
  - `none` – No additional parenting.
  - `hierarchy` – FK controls are parented to each other following the joint hierarchy.
  - `constraint` – FK controls are parent‑constrained to the joint hierarchy.

## Outputs
- **FK Control Transforms** – For each joint, a null transform (`*_control_null`) and a child control transform (`*_control`) are created.
- **Optional Parenting** – Depending on `setParent`, the FK controls are either hierarchically parented or constrained to the joint chain.
- **Scale Linking** – If `connectScale` is enabled, each control’s scale is driven by its corresponding joint’s scale.

## Usage
1. **Select Joints** – Populate the `joints` list with the target joint names.
2. **Configure Settings** – Choose the desired helper shape, orientation, and whether to link scale or set parenting behavior.
3. **Run the Module** – Execute the module to generate FK controls along the joint chain.
4. **Adjust Controls** – Position and orient the created controls as needed; they will automatically follow the joints via parent constraints.
5. **Parenting (Optional)** – If `setParent` is set to `hierarchy` or `constraint`, the FK controls will automatically adopt the chosen parenting scheme.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Create FK controls for <b>joints</b>"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["M_belt_waist_vert_1_joint", "M_belt_waist_vert_2_joint", "M_belt_waist_vert_3_joint"], "default": "items"}]]></attr>
<attr name="orientation" template="radioButton" category="General" connect=""><![CDATA[{"items": ["world", "joint"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="helper" template="comboBox" category="General" connect=""><![CDATA[{"items": ["circle", "rect", "sphere", "cube"], "current": "circle", "default": "current"}]]></attr>
<attr name="connectScale" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="setParent" template="radioButton" category="General" connect=""><![CDATA[{"items": ["none", "hierarchy"], "current": 1, "columns": 2, "default": "current"}]]></attr>
</attributes>
</module>