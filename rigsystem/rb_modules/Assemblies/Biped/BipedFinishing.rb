<module name="BipedFinishing" muted="0" uid="e536a7df411640bda73a205a15293848">
<run><![CDATA[import pymel.core as pm
import rig_utils

if @mode == 1: # run
    pm.hide(pm.ls("*_average_group"))
    
    for side in ["L", "R"]:
        pm.addAttr(f"{side}_arm_options_control.ikfk", e=True, dv=1)
        pm.PyNode(f"{side}_arm_options_control").ikfk.set(1)
        pm.PyNode(f"{side}_leg_footroll_control").angle.set(@footAngle, k=False, l=True)

        for typ in ["arm", "leg"]:
            pm.PyNode(f"{side}_{type}_ik_control").stretch.set(1)
            pm.PyNode(f"{side}_{type}_ik_polevector_control").stretch.set(1)
]]></run>
<doc><![CDATA[## Summary
The **bipedFinishing** module finalizes a biped rig by applying user‑defined foot roll angles, enabling IK/FK blending on arm controls, activating stretch on all arm and leg IK chains, organizing visibility sets for controls and bend rigs, and hiding default helper groups. It prepares the rig for animation and export by locking and grouping relevant nodes.

## Inputs
- **`mode`** (`radioButton`):  
  - `0` – *Helpers* (no action).  
  - `1` – *Run* (execute finishing steps).  
- **`footAngle`** (`lineEdit`): Desired angle (in degrees) to set on the left and right leg foot‑roll controls (`L_leg_footroll_control`, `R_leg_footroll_control`).  
- **Existing rig nodes** (implicit inputs):  
  - Foot roll controls (`*_footroll_control`).  
  - Arm options controls (`*_arm_options_control`).  
  - IK and pole‑vector controls for arms and legs (`*_ik_control`, `*_ik_polevector_control`).  
  - Visibility sets (`*_visible_set`, `*_others_set`, `*_controls_group`, `*_others_group`, `*_fingers_controls_group`).  
  - Bend rig groups (`*_bendRig_controls_group`, `*_bend_control_null`).  
  - Helper groups (`*_average_group`).

## Outputs
- **Attribute adjustments**:  
  - Sets `ikfk` on arm options controls to `1` and adds a default value attribute.  
  - Enables `stretch` on all arm and leg IK and pole‑vector controls.  
  - Sets the foot roll angle on both leg foot‑roll controls.  
- **Visibility sets**:  
  - Adds control groups to existing visibility sets (`*_visible_set`).  
  - Creates a `bends_visible_set` containing all bend rig groups, tags it with a `type` attribute, and adds it to the global `visible_sets` or `sets` collection.  
- **Node visibility**: Hides all `*_average_group` and the newly created `bends_visible_set` by default.  
- **No new control nodes** are created; the module only modifies and organizes existing rig elements.

## Usage
1. **Prepare the rig**: Ensure all required control nodes and visibility sets exist (created by earlier rig‑building modules).  
2. **Configure the module**:  
   - Set **`mode`** to **`Run`**.  
   - Enter the desired **`footAngle`** value (e.g., `-15` for a slight foot roll).  
3. **Execute**: Run the module. It will apply the foot roll angle, enable IK/FK blending on arms, activate stretch on all IK chains, organize visibility sets, and hide helper groups.  
4. **Verify**: Check that the visibility sets contain the correct control groups and that the `bends_visible_set` is hidden by default.  
5. **Export**: The rig is now ready for animation or asset export, with all finishing adjustments applied.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="footAngle" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 10, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>