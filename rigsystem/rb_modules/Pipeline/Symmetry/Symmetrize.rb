<module name="symmetrize" muted="0" uid="62f2ec7d17484555ac960a629f02463f">
<run><![CDATA[import pymel.core as pm
from rig_utils.general import symmetrizeJoint

for j in pm.selected(type=["transform", "joint"]):
    symmetrizeJoint(j)]]></run>
<doc><![CDATA[## Summary  
This module mirrors or symmetrizes the currently selected joints or transform nodes in the scene, creating or updating the corresponding opposite-side counterparts.

## Inputs  
- **Selection (`pm.selected`)**: Any number of transform or joint nodes that the user has selected in the viewport before executing the module.

## Outputs  
- **Symmetrized Joints**: For each selected node, a mirrored joint (or transform) is created or updated on the opposite side of the character, preserving hierarchy and attributes as defined by `symmetrizeJoint`.

## Usage  
1. In the Maya viewport, select the joint or transform nodes you wish to symmetrize.  
2. Run the module (e.g., via the Rig Builder UI or a script).  
3. The module will call `symmetrizeJoint` on each selected node, producing mirrored counterparts.  
4. Verify the new joints appear on the opposite side and are correctly connected to the existing rig hierarchy.]]></doc>
</module>