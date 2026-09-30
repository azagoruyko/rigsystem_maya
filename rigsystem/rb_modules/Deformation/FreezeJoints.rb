<module name="freezeJoints" type="Tools/FreezeJoints" muted="0" uid="e13ecd930d9943d69299094249a7e31e">
<run><![CDATA[import pymel.core as pm
import rig_utils

rig_utils.freezeJoints([pm.PyNode(j) for j in @joints])]]></run>
<doc><![CDATA[## Summary
The **freezeJoints** tool standardizes joint orientations by freezing rotations and zeroing joint orient values while keeping the skeleton in world space. It is useful for preparing custom skeletons for IK setups or for ensuring consistent joint orientation conventions.

## Inputs
- **`joints`** (`listBox`): A list of joint names (e.g., `joint1`, `joint2`, …) that will be processed. The tool converts each name to a PyNode and applies the freeze operation.

## Outputs
- This module does not produce any output nodes or data containers; it directly modifies the selected joints in the scene.

## Usage
1. Open the **freezeJoints** module in Rig Builder.  
2. In the **joints** attribute, add the names of the joints you want to freeze.  
3. Click **Run** (or execute the module).  
4. The tool will freeze rotations and zero joint orient values for each listed joint, preserving the current world-space pose.]]></doc>
<attributes>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["joint1", "joint2", "joint3", "joint4", "joint5"]}]]></attr>
</attributes>
<children>
</children>
</module>