<module name="AttachToSurface" muted="0" uid="b21c578b1b144f4e9fe06ec449961b0f">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds
surface = proxy.node(@surface)
surfaceShape = surface.getShapes(type="nurbsSurface")[0] if surface.type() == "transform" else surface
transforms = proxy.nodes(@transforms)

cpos = proxy.create("closestPointOnSurface", "attachToSurface_cpos_tmp", suffix=False)
surfaceShape.worldSpace[0] >> cpos.inputSurface

for t in transforms:
    pos = cmds.xform(str(t), q=True, ws=True, t=True)
    cpos.inPosition.set(pos)
    u = cpos.parameterU.get()
    v = cpos.parameterV.get()

    if @addNewParents:
        parent = t.getParent()
        st = rig_utils.makeSurfaceTransform(str(t), surface, u, v)
        if parent:
            cmds.parent(str(st), str(parent))
        cmds.parent(str(t), str(st))
    else:
        rig_utils.attachTransformToSurface(str(t), surface, u, v)

cmds.delete(str(cpos))
]]></run>
<doc><![CDATA[## Summary
Attaches a list of transform nodes to a NURBS surface by computing the closest surface parameters for each transform. Optionally creates intermediate surface‑aligned transform nodes that become the new parents of the original transforms.

## Inputs
- **`surface`** (`node`): The NURBS surface (or its transform) to which the transforms will be attached.  
- **`transforms`** (`list[node]`): A list of transform nodes whose world positions will be projected onto the surface.  
- **`addNewParents`** (`bool`): If `True`, a new surface‑aligned transform is created for each input transform and becomes its parent; otherwise the original transform is directly attached to the surface.

## Outputs
- The input **`transforms`** are re‑parented or attached to the specified **`surface`**.  
- When **`addNewParents`** is `True`, a new surface‑aligned transform node is created for each input transform and becomes its parent.  
- No explicit output attributes are produced; the module’s effect is the side‑effect on the scene hierarchy.

## Usage
1. Connect a NURBS surface node to the **`surface`** input.  
2. Provide a list of transform nodes to **`transforms`**.  
3. Set **`addNewParents`** to `True` if you want each transform to be wrapped in a surface‑aligned parent; leave it `False` to attach the transforms directly.  
4. Execute the module. The transforms will be positioned on the surface and, if requested, re‑parented under new surface‑aligned nodes.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS surface</b> using closest point projection."}]]></attr>
<attr name="surface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "nurbsPlane1", "placeholder": "NURBS surface name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["ctrl1_pivot_transform", "ctrl2_pivot_transform", "ctrl3_pivot_transform"], "default": "items"}]]></attr>
<attr name="addNewParents" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
</attributes>
</module>