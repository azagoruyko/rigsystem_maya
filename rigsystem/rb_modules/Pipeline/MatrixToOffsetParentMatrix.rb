<module name="matrixToOffsetParentMatrix" muted="0" uid="18853f5b0d0c472791a6371f8c6b5838">
<run><![CDATA[import pymel.core as pm
import rig_utils

if @mode == 0: # to
    for t in pm.selected(type=["transform", "joint"]):
        if t.offsetParentMatrix.inputs():
            warning(f"{t}.offsetParentMatrix has inputs, skipped")
            continue

        rig_utils.setToOffsetParentMatrix(t)
        
else: # from
    for t in pm.selected(type=["transform", "joint"]):
        rig_utils.setFromOffsetParentMatrix(t)]]></run>
<doc><![CDATA[## Summary  
This module transfers the current matrix of selected transform nodes into their `offsetParentMatrix` attribute (mode 0) or restores the original matrix from the `offsetParentMatrix` (mode 1). It is useful for baking or unbaking offset transforms in a Maya scene.

## Inputs  
- **`mode`** (integer):  
  - `0` – **To**: Copy the current world matrix into `offsetParentMatrix` and reset the node’s world matrix to identity.  
  - `1` – **From**: Restore the world matrix from `offsetParentMatrix` and clear the offset.  
- **Selection**: The module operates on all currently selected transform nodes. It checks that each node has no incoming connections on its `offsetParentMatrix` before proceeding.

## Outputs  
- The selected transform nodes have their `offsetParentMatrix` and world matrix values updated according to the chosen mode. No new nodes or attributes are created; the operation only modifies existing transform data.

## Usage  
1. Select the transform nodes you wish to bake or unbake.  
2. Set the module’s `mode` attribute to `0` to bake the current world matrix into the offset, or to `1` to restore the original world matrix.  
3. Execute the module.  
4. Verify that the transforms’ world matrices and `offsetParentMatrix` values reflect the intended state.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["To", "From"], "current": 0, "columns": 3, "default": "current"}]]></attr>
</attributes>
</module>