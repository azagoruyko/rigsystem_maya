<module name="attachToSurface" muted="0" uid="b21c578b1b144f4e9fe06ec449961b0f">
<run><![CDATA[import pymel.core as pm
import rig_utils

surface = pm.PyNode(@surface)
transforms = [pm.PyNode(t) for t in @transforms]

cpos = pm.createNode("closestPointOnSurface", n="attachToSurface_cpos_tmp")
surface.worldSpace >> cpos.inputSurface

for t in transforms:
	pos = pm.xform(t, q=True, ws=True, t=True)
	cpos.inPosition.set(pos)
	u = cpos.parameterU.get()
	v = cpos.parameterV.get()

	parent = t.getParent()
	st = rig_utils.makeSurfaceTransform(t.name(), surface, u, v)
	if parent:
		pm.parent(st, parent)
	pm.parent(t, st)

pm.delete(cpos)
]]></run>
<doc><![CDATA[## Summary
The **attachToSurface** module projects a list of transforms onto a specified NURBS surface and creates a surface‑transform node at each transform’s closest point. Each original transform is then parented under its corresponding surface transform, preserving the original hierarchy.

## Inputs
- **`surface`** (`lineEditAndButton`)  
  *Name of the NURBS surface to which the transforms will be attached.*  
  Example: `nurbsPlane1`.

- **`transforms`** (`listBox`)  
  *List of transform node names that should be projected onto the surface.*  
  Example: `L_hair_curl_a_1_control_null`, `L_hair_curl_b_2_control_null`, etc.

## Outputs
- **Surface Transform Nodes**  
  For each input transform, a new surface‑transform node is created (typically named after the original transform, e.g., `L_hair_curl_a_1_control_null_st`).  
  These nodes are parented to the original parent of the transform (if any) and then the original transform is parented under the new surface transform.

- **Re‑parented Transforms**  
  The original transforms are now children of their respective surface transform nodes, effectively locking them to the surface at the projected location.

- **Temporary Node Cleanup**  
  The temporary `closestPointOnSurface` node used for projection is deleted after the operation.

## Usage
1. **Select the NURBS surface** you want to attach to and enter its name in the **`surface`** field (or use the button to pick the selected node).  
2. **Populate the `transforms` list** with the transforms you wish to project onto the surface.  
3. **Run the module**.  
   - The script will compute the closest point on the surface for each transform’s current world position.  
   - A surface‑transform node is created at that point, the original transform is parented under it, and the original parent relationship is preserved.  
4. **Verify the result** in the scene hierarchy: each transform should now be a child of a new surface‑transform node positioned on the surface.  
5. **Optional**: If you need to adjust offsets or orientations, modify the newly created surface transform nodes directly.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS surface</b> using closest point projection."}]]></attr>
<attr name="surface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "nurbsPlane1", "placeholder": "NURBS surface name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["L_hair_curl_a_1_control_null", "L_hair_curl_a_2_control_null", "L_hair_curl_a_3_control_null", "L_hair_curl_a_4_control_null", "L_hair_curl_a_5_control_null", "L_hair_curl_b_1_control_null", "L_hair_curl_b_2_control_null", "L_hair_curl_b_3_control_null", "L_hair_curl_b_4_control_null", "L_hair_curl_b_5_control_null", "L_hair_curl_b_6_control_null", "L_hair_curl_c_1_control_null", "L_hair_curl_c_2_control_null", "L_hair_curl_c_3_control_null", "L_hair_curl_c_4_control_null", "L_hair_curl_d_1_control_null", "L_hair_curl_d_2_control_null", "L_hair_curl_d_3_control_null", "L_hair_curl_d_4_control_null", "L_hair_curl_d_5_control_null", "L_hair_curl_e_1_control_null", "L_hair_curl_e_2_control_null", "L_hair_curl_e_3_control_null", "L_hair_curl_e_4_control_null"]}]]></attr>
</attributes>
</module>