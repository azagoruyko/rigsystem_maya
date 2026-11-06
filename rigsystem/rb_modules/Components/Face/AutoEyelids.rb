<module name="autoEyelids" muted="0" uid="ffcab4d1287549d2b3b2fc007f222cd8">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
eye_aim = proxy.node("M_eyes_aim_joint")

for side in "LR":
    eye_control = proxy.node(f"{side}_eye_transform_control")
    ctrl = proxy.node(f"{side}_eyelid_upper_main_control")
    ctrl.addAttr(ln="auto", at="float", min=0.0, max=1.0, dv=1.0, k=True)

    root = proxy.create("transform", f"{side}_eyelids_auto_root_transform", parent=eye_control, suffix=False)
    cmds.matchTransform(root, eye_aim)
    auto_transform = proxy.create("transform", f"{side}_eyelids_auto_transform", parent=root, suffix=False)
    offset_transform = proxy.create("transform", f"{side}_eyelid_upper_main_auto_offset_transform", parent=eye_control, suffix=False)
    auto_transform | offset_transform | ctrl

    right_coeff = @rightInversion if side == "R" else [1, 1, 1]
    rotation_coeff = [a * b for a, b in zip(right_coeff, @rotationCoeff)]

    mult_rot = proxy.create("multiplyDivide", f"{side}_eyelids_auto_rot_multiplyDivide", suffix=False)
    mult_rot.input1.set(rotation_coeff)
    ctrl.auto >> mult_rot.input2X
    ctrl.auto >> mult_rot.input2Y
    ctrl.auto >> mult_rot.input2Z

    mult = proxy.create("multiplyDivide", f"{side}_eyelids_auto_multiplyDivide", suffix=False)
    eye_aim.r >> mult.input1
    mult_rot.output >> mult.input2
    mult.output >> auto_transform.r
]]></run>
<doc><![CDATA[## Summary
The **autoEyelids** module automatically builds a simple eyelid driver for both left and right eyes in Maya. For each side it creates a root transform attached to the eye control, adds a secondary transform that follows the eye’s rotation, and introduces an “auto” attribute on the eyelid main control. The driver blends the eye’s rotation with side‑specific coefficients, enabling the eyelid to move automatically when the eye turns.

## Inputs
- **`rotationCoeff`** (`vector`): Three‑component vector that scales the eye’s rotation for the eyelid driver.
- **`rightInversion`** (`vector`): Coefficient vector applied only to the right eye to invert the Y component (or any other component) for correct mirroring.
- **Scene Nodes**:
  - `M_eyes_aim_joint` – the eye aim joint used for matching the root transform.
  - `side_eye_transform_control` – the eye control transform for each side (`L_eye_transform_control`, `R_eye_transform_control`).
  - `side_eyelid_upper_main_control` – the main eyelid control for each side.

## Outputs
- **Root Transforms**: `L_eyelids_auto_root_transform`, `R_eyelids_auto_root_transform` – positioned at the eye aim joint.
- **Eyelid Driver Transforms**: `L_eyelids_auto_transform`, `R_eyelids_auto_transform` – driven by the eye’s rotation and the specified coefficients.
- **Attribute Added**: An `auto` float attribute (0–1) on each `side_eyelid_upper_main_control`, controlling the influence of the driver.
- **MultiplyDivide Nodes**: `side_eyelids_auto_rot_multiplyDivide` and `side_eyelids_auto_multiplyDivide` that blend the rotation and drive the eyelid transform.

## Usage
1. **Prepare the Scene** – Ensure the eye controls (`L_eye_transform_control`, `R_eye_transform_control`) and eyelid controls (`L_eyelid_upper_main_control`, `R_eyelid_upper_main_control`) exist.
2. **Set Parameters** – Adjust `rotationCoeff` to tune how much the eye’s rotation affects the eyelid. For the right eye, `rightInversion` can be used to flip the Y component (default `[1, -1, 1]`).
3. **Run the Module** – Execute the module in Maya. It will create the root and driver transforms, add the `auto` attribute, and wire the multiplyDivide nodes.
4. **Control the Driver** – Animate the `auto` attribute on each eyelid main control to enable or disable the automatic eyelid movement. The eyelid will follow the eye’s rotation automatically when `auto` is set to 1.]]></doc>
<attributes>
<attr name="rotationCoeff" template="vector" category="General" connect=""><![CDATA[{"value": [0.0, 0.33, 0.9], "default": "value", "dimension": 3, "precision": 2, "columns": 3}]]></attr>
<attr name="rightInversion" template="vector" category="General" connect=""><![CDATA[{"value": [1.0, -1.0, 1.0], "default": "value", "dimension": 3, "precision": 0, "columns": 3}]]></attr>
</attributes>
</module>
