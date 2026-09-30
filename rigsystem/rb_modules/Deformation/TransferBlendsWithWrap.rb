<module name="transferBlendsWithWrap" muted="0" uid="5772ef3bbe374b19bbfa620fa562cab5">
<run><![CDATA[import pymel.core as pm
import rig_utils

srcGeo = pm.PyNode(@srcGeoWithBlends)
destGeo = pm.PyNode(@destGeo)

# 1. Create wrap deformer on destGeo driven by srcGeo
wrapNode = rig_utils.createWrap(srcGeo, destGeo)

# 2. Find blendShape on srcGeo
blendShapeNode = pm.listHistory(srcGeo, type="blendShape")[0]

# 3. Walk through each blend target
created_geos = []
for w in blendShapeNode.w:
    name = pm.aliasAttr(w, q=True)
    if not name:
        continue

    orig_val = w.get()
    w.set(1.0)

    dup = pm.duplicate(destGeo, name=name)[0]
    if dup.getParent():
        pm.parent(dup, world=True)
    dup.v.set(True)
    created_geos.append(dup)

    w.set(orig_val)

# 4. Clean up wrap
if pm.objExists(wrapNode):
    pm.delete(wrapNode)
base_name = str(srcGeo) + "Base"
if pm.objExists(base_name):
    pm.delete(base_name)

print("Successfully transferred %d blend shapes to '%s'" % (len(created_geos), destGeo))
]]></run>
<doc><![CDATA[## Summary  
This module copies all blend‑shape targets from a source mesh (`srcGeoWithBlends`) to a destination mesh (`destGeo`). It does so by creating a temporary wrap deformer, duplicating the destination mesh for each blend target, and then cleaning up the wrap and any temporary base node. The result is a set of new geometry nodes, one per blend target, named after the original blend‑shape names.

## Inputs  
- **`srcGeoWithBlends`** – The source geometry that already contains blend‑shape targets.  
- **`destGeo`** – The destination geometry that will receive the duplicated meshes for each blend target.

## Outputs  
- **`created_geos`** – A list of duplicated destination geometry nodes, each named after a blend‑shape target from the source mesh.  
- **Console message** – Prints “Successfully transferred X blend shapes to ‘destGeo’” indicating the number of targets processed.  
- **Cleanup** – The temporary wrap deformer and any base node created during the process are deleted, leaving only the duplicated geometries.

## Usage  
1. **Set the inputs**: In the module’s attribute panel, assign the source mesh that contains blend shapes to `srcGeoWithBlends` and the target mesh to `destGeo`.  
2. **Run the module**: Execute the module. It will create a wrap deformer, duplicate the destination mesh for each blend target, and then delete the wrap.  
3. **Verify results**: In the scene, you should see new geometry nodes named after each blend‑shape target. These can be used for further rigging or deformation work.  
4. **Optional cleanup**: If any temporary nodes remain (e.g., a base node named `srcGeoBase`), the script will delete them automatically.]]></doc>
<attributes>
<attr name="srcGeoWithBlends" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "orig_lip_pursed_base_geo", "placeholder": "Source geometry with blendShape", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="destGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "mouth_geo1", "placeholder": "Destination geometry", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>