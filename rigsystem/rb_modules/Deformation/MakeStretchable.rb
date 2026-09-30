<module name="makeStretchable" muted="0" uid="e2d5e2c2f71b41078b86f36600ef2af7">
<run><![CDATA[import pymel.core as pm
import rig_utils

control = pm.PyNode(@control)
jnt = pm.PyNode(@joint)

# Measure distance between control and joint
d = rig_utils.createDistance(@joint + "_distance", jnt, control)

# Build stretchable setup
rig_utils.makeStretchable(
    @joint+"_stretch",
    [jnt],
    d,
    squash=0.01,
    saveVolume=0,
    scales=(True, False, False),
)
]]></run>
<doc><![CDATA[## Summary
Creates a stretchable rig for a single joint by measuring the distance between a specified control and the joint, then driving the joint’s scale (or translate) based on the ratio of the current distance to the rest distance. The network supports per‑axis scaling, optional squash, and volume preservation.

## Inputs
- **`control`** – The transform node that will drive the stretch.  
- **`joint`** – The joint that will receive the stretchable scaling.

## Outputs
- **Distance node** – A local‑space distance node named `<joint>_distance` that reports the current distance between the joint and the control.  
- **Stretch network** – A stretchable node graph named `<joint>_stretch` that connects the distance value to the joint’s scale (or translate) attributes, applying squash and optional volume preservation.

## Usage
1. **Set the inputs**: In the module’s UI, choose the joint you want to stretch and the control that will drive it.  
2. **Run the module**: Execute the module; it will automatically create the distance node and the stretchable network.  
3. **Connect downstream**: If needed, connect the created `<joint>_stretch` node to other rig elements (e.g., IK handles or FK chains) to propagate the stretch effect.  
4. **Adjust parameters** (if you modify the source code): The squash, volume preservation, and per‑axis scaling options are hard‑coded but can be tweaked in the `rig_utils.makeStretchable` call for different behavior.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Make <b>joint</b> stretchable towards <b>control</b>"}]]></attr>
<attr name="control" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_scarf_fix_control", "placeholder": "Control transform", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_scarf_start_joint", "placeholder": "Input joint", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>