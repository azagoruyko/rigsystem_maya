<module name="mirrorMesh" muted="0" uid="f2e87a91b4c34d9eb8a71234567890ab">
<run><![CDATA[import maya.cmds as cmds
import maya.api.OpenMaya as om
import pymel.core as pm
import rig_utils

baseMesh = @baseMesh
mesh = @mesh
destMesh = @destMesh

if not baseMesh or not cmds.objExists(baseMesh):
    warning("mirrorMesh: Please specify a valid Base Mesh.")
elif not mesh or not cmds.objExists(mesh):
    warning("mirrorMesh: Please specify a valid Source Mesh.")
else:
    rig_utils.mesh.mirrorMesh(
        meshBase=baseMesh,
        mesh=mesh,
    )
    print(f"mirrorMesh: Successfully mirrored '{mesh}' across X-axis (Left to Right) using base mesh '{baseMesh}'.")
]]></run>
<doc><![CDATA[## Summary
The **mirrorMesh** module mirrors geometry deformations and vertex offsets from a source mesh across the X‑axis (Left +X → Right –X) onto a destination mesh or the source itself. It uses barycentric coordinates via closest‑point surface projection on a neutral base mesh, allowing accurate symmetry even for non‑symmetric topologies.

## Inputs
- **`baseMesh`** – Neutral reference geometry that defines the symmetry plane.  
- **`mesh`** – Source mesh containing the deformations or shape changes to be mirrored.  
- **`destMesh`** – Optional target mesh that will receive the mirrored result. If omitted, the source mesh is overwritten.

## Outputs
- The **`destMesh`** geometry is updated in‑place with the mirrored vertex positions.  
- No additional nodes or attributes are created; the operation is performed directly on the mesh data.

## Usage
1. **Select the meshes** in the viewport: first the base mesh, then the source mesh, and optionally the destination mesh.  
2. **Set the attributes** in the module UI:  
   - `baseMesh` – name of the neutral reference geometry.  
   - `mesh` – name of the mesh to mirror.  
   - `destMesh` – name of the mesh to receive the mirrored result (leave blank to overwrite the source).  
3. **Run the module**. The script will validate the inputs, perform the barycentric mirroring across the X‑axis, and print a success message.  
4. **Verify** the result by inspecting the destination mesh; the deformations should now be mirrored from left to right.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Mirror mesh deformations (Left to Right across X) using barycentric coordinates on base mesh (supports non-symmetric geos)."}]]></attr>
<attr name="baseMesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "base", "placeholder": "Base Mesh", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "eyelashes_curl_out_blend_geo", "placeholder": "Source Mesh", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif len(ls) > 1: value = ls[1]\nelif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="destMesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Destination Mesh (optional)", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif len(ls) > 2: value = ls[2]\nelif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>