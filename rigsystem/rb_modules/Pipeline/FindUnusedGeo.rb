<module name="findUnusedGeo" muted="0" uid="e705e52bf9284751a7ca2ce039a24722">
<run><![CDATA[import pymel.core as pm

out = []

if @nurbs:
    for typ in ["nurbsSurface", "nurbsCurve"]:
        for n in pm.ls(type="nurbsSurface"):
            if not n.create.inputs() and not n.local.outputs() and not n.worldSpace.outputs() and n.intermediateObject.get():
                out.append(n.name())

if @mesh:    
    for n in pm.ls(type="mesh"):
        if not n.inMesh.inputs() and not n.outMesh.outputs() and not n.worldMesh.outputs() and n.intermediateObject.get():
            out.append(n.name())

if out:
    print(out)
    if @remove:
        pm.delete(out)
    else:
        pm.select(out)    ]]></run>
<doc><![CDATA[## Summary
Finds and optionally removes unused geometry nodes (nurbs surfaces, curves, or meshes) that are marked as intermediate objects and have no connections to other nodes. The module reports the names of these nodes, selects them in the scene, or deletes them if the **Remove** option is enabled.

## Inputs
- **`nurbs`** (`checkBox`): When checked, the module searches for unused **nurbsSurface** and **nurbsCurve** nodes.
- **`mesh`** (`checkBox`): When checked, the module searches for unused **mesh** nodes.
- **`remove`** (`checkBox`): When checked, the identified unused nodes are deleted from the scene; otherwise they are simply selected.

## Outputs
- **Console Output**: Prints a list of the names of all unused geometry nodes found.
- **Scene Selection**: If `remove` is unchecked, the nodes are selected in the viewport.
- **Deletion**: If `remove` is checked, the nodes are permanently removed from the scene.

## Usage
1. Open the module in Rig Builder and enable the **Nurbs** and/or **Mesh** checkboxes to specify which geometry types to scan.
2. Optionally check **Remove** if you want the module to delete the unused nodes automatically.
3. Execute the module. The console will display the list of unused geometry names; the nodes will be selected or deleted based on the `remove` setting.]]></doc>
<attributes>
<attr name="nurbs" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="mesh" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="remove" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
</attributes>
</module>