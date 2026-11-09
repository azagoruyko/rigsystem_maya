<module name="AttachFKToSurface" muted="0" uid="535399efef7a4758950a50b614023dff">
<run><![CDATA[from rigsystem import proxy

# make additional transforms to make editable pivots later

for ctrl in proxy.nodes(@controls):
    if not ctrl.getChildren(type="transform"):
        proxy.create("transform", name=ctrl+"_fake_child", parent=ctrl)    ]]></run>
<doc><![CDATA[## Summary

Attach FK controls to nurbs surface preserving controls' FK behaviour.]]></doc>
<attributes>
<attr name="controls" template="listBox" category="General" connect=""><![CDATA[{"items": ["joint1_control", "joint2_control", "joint3_control", "joint4_control", "joint5_control", "joint6_control", "joint7_control"], "default": "items"}]]></attr>
<attr name="surface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "nurbsPlane1", "placeholder": "NURBS surface name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="MakeEditablePivot" muted="0" uid="14932544be434020a1338edbc2110db2">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds

makeHelperMod = module.child("MakeHelper")

out_transforms = []
for tr in @transforms:
    tr = proxy.node(tr)
    children = tr.getChildren(type="transform")
    if not children:
        warning(f"{tr} must have children to edit pivot for")
        continue
        
    name = f"{tr.namespace()}{tr.localName()}"
    pivot = proxy.create("transform", f"{name}_pivot", parent=tr.getParent())
    cmds.matchTransform(pivot, tr)
    rig_utils.setToOffsetParentMatrix(pivot)
    
    pivot | tr
            
    pivotOffset = proxy.create("transform", f"{name}_pivot_offset", parent=tr)
    cmds.parent(children, pivotOffset)
    
    rig_utils.lockTRS(pivotOffset)
    
    pivot.inverseMatrix >> pivotOffset.offsetParentMatrix

    if @makeShape:
        h = f"{name}_pivot_helper"
        makeHelperMod.attr.name.set(h)
        makeHelperMod.run()
        cmds.matchTransform(h, tr)
        
        ctrl = proxy.create("transform", f"{name}_pivot_control", suffix=False)
        pivot.parentMatrix[0] >> ctrl.offsetParentMatrix
        ctrl.inheritsTransform.set(False)
        
        rig_utils.curve.makeFromCurve(ctrl, h)
        cmds.delete(h)
        rig_utils.lockTRS(ctrl, [], [])
        
        cmds.parentConstraint(ctrl, pivot, mo=True)
        out_transforms.append(ctrl)
    else:
        out_transforms.append(pivot)        
        
@set_out_transforms([str(c) for c in out_transforms])

]]></run>
<doc><![CDATA[## Summary
Creates pivot helper objects for each selected transform, optionally generating visual helper curves and controls. The module offsets the pivot, locks the helper, and can spawn a helper curve via the child **MakeHelper** module. The resulting transforms (pivots or controls) are exposed for downstream rigging steps.

## Inputs
- **`transforms`** (`list`): A list of transform node names or paths that will receive pivot helpers.  
- **`makeShape`** (`bool`): When `True`, a helper curve and control are created for each pivot; otherwise only the pivot helper is generated.  

## Outputs
- **`out_transforms`** (`list` of strings): Paths to the created pivot helpers or control transforms. These can be connected to other modules (e.g., IK/FK rigs, constraints, or animation layers).

## Usage
1. Select the transforms you want to add pivot helpers to.  
2. Set the **`transforms`** attribute to the list of selected nodes (or let the module auto‑detect the selection).  
3. Toggle **`makeShape`** if you want visual helper curves and controls.  
4. Execute the module.  
5. The generated pivots or controls will appear in the scene; use the **`out_transforms`** output to feed into subsequent rigging modules.]]></doc>
<attributes>
<attr name="curveType" template="comboBox" category="General" connect=""><![CDATA[{"items": ["arc", "arrow", "axis", "axisSphere", "cube", "circle", "diamond", "key", "pyramid", "rect", "sphere", "triangle", "plus"], "current": "axis", "default": "current"}]]></attr>
<attr name="makeShape" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect="/controls"><![CDATA[{"items": ["joint1_control", "joint2_control", "joint3_control", "joint4_control", "joint5_control", "joint6_control", "joint7_control"], "default": "items"}]]></attr>
<attr name="out_transforms" template="listBox" category="Output" connect=""><![CDATA[{"items": ["joint1_control_pivot_transform", "joint2_control_pivot_transform", "joint3_control_pivot_transform", "joint4_control_pivot_transform", "joint5_control_pivot_transform", "joint6_control_pivot_transform", "joint7_control_pivot_transform"], "default": "items"}]]></attr>
</attributes>
<children>
<module name="MakeHelper" muted="1" uid="1f5e3d986051407397d0b580e70ef628">
<run><![CDATA[from rigsystem import rig_utils
rig_utils.curve.makeCurve(@name, @curveType)]]></run>
<doc><![CDATA[## Summary
Creates a helper curve node with a user‑defined name and shape, positioned at the current selection or a specified transform. The curve can be used as a visual reference or as a target for constraints and connections.

## Inputs
- **`name`** (`lineEditAndButton`): The desired name for the helper curve node (e.g., `L_bracer`).  
- **`curveType`** (`comboBox`): The shape of the curve to generate. Options include `arc`, `arrow`, `axis`, `axisSphere`, `cube`, `circle`, `diamond`, `key`, `pyramid`, `rect`, `sphere`, `triangle`, and `plus`. The default is `triangle`.

## Outputs
- **Helper Curve Node**: A new curve node (or locator/shape helper) created in the scene with the specified `name` and `curveType`. This node can be used as a visual guide, constraint target, or reference transform for downstream modules.

## Usage
1. Set the **`name`** attribute to the desired node name.  
2. Choose a **`curveType`** from the dropdown to define the visual shape.  
3. Execute the module.  
4. The created helper curve will appear in the scene; you can parent, constrain, or connect it to other rig components as needed.]]></doc>
<attributes>
<attr name="curveType" template="comboBox" category="General" connect="/curveType"><![CDATA[{"items": ["arc", "arrow", "arrowCircle", "axis", "axisSphere", "circle", "cube", "diamond", "flag", "gear", "guide", "key", "main", "plus", "pyramid", "rect", "sphere", "triangle"], "current": "axis", "default": "current"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import os\nfrom rigsystem import rig_utils\n\ncurves = sorted(\n    os.path.splitext(filename)[0]\n    for filename in os.listdir(rig_utils.curve.CurvesPath)\n    if filename.endswith(\".json\")\n)\ncurrent = ch(\"/curveType\")\nif current not in curves:\n    chset(\"/curveType\", curves[0] if curves else \"\", \"current\")\n\nchset(\"/curveType\", curves, \"items\")", "label": "Get All Curves", "color": "", "default": "command"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "joint4_pivot_transform_helper", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
</children>
</module>
<module name="makeAttachedTransforms" muted="0" uid="">
<run><![CDATA[from rigsystem import proxy
cmds = proxy.cmds

attachToSurfaceMod = module.parent().child("AttachToSurface")

pivots = proxy.nodes(ch("../MakeEditablePivot/out_transforms"))

attached = []
for pv in pivots:
    t = proxy.create("transform", pv.name().replace("_transform","")+"_attached", parent=pv.getParent())
    cmds.xform(t, ws=True, m=pv.wm.get())
    attached.append(t.name())
    
attachToSurfaceMod.attr.transforms.set(attached)
attachToSurfaceMod.run()

for pv, a in zip(pivots, proxy.nodes(attached)):
    cmds.parentConstraint(a, pv, mo=True)
    
    decompose = a.t.inputs()[0].node
    multMatrix = decompose.inputMatrix.inputs()[0].node
    m = multMatrix.matrixIn[1].get()
    multMatrix.matrixIn[1].disconnect()
    multMatrix.matrixIn[1].set(m)
]]></run>
<doc><![CDATA[## Summary
Creates a set of “attached” transform nodes that mirror the world matrices of the pivots produced by a **MakeEditablePivot** module, then runs an **AttachToSurface** module to bind those nodes to a surface. After the surface attachment, it establishes parent constraints from the attached nodes back to the original pivots and cleans up matrix connections to keep the constraints stable.

## Inputs
- **`MakeEditablePivot/out_transforms`** – The list of pivot transform nodes that will be duplicated and attached to the surface.  
- **`AttachToSurface` module** – A sibling module that performs the actual surface attachment; this module expects a `transforms` attribute to receive the list of nodes to attach.

## Outputs
- **Attached transform nodes** – New transform nodes named `<pivot_name>_attached` that are positioned exactly where each pivot was.  
- **Parent constraints** – Constraints from each attached node back to its original pivot, maintaining offset.  
- **Updated `AttachToSurface` module** – The module’s `transforms` attribute is set to the list of attached nodes and the module is executed, producing the surface‑attached result.

## Usage
1. Ensure a **MakeEditablePivot** module has run and its `out_transforms` attribute contains the pivot transforms you want to attach.  
2. Place this module after the **MakeEditablePivot** and **AttachToSurface** modules in the hierarchy.  
3. Run the module; it will create the attached nodes, execute the surface attachment, and set up the constraints.  
4. Verify that the attached nodes are correctly positioned and constrained, and that the surface attachment has taken effect.]]></doc>
</module>
<module name="AttachToSurface" muted="1" uid="b21c578b1b144f4e9fe06ec449961b0f">
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
<attr name="surface" template="lineEditAndButton" category="General" connect="/surface"><![CDATA[{"value": "nurbsPlane1", "placeholder": "NURBS surface name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["joint1_control_pivot_attached_transform", "joint2_control_pivot_attached_transform", "joint3_control_pivot_attached_transform", "joint4_control_pivot_attached_transform", "joint5_control_pivot_attached_transform", "joint6_control_pivot_attached_transform", "joint7_control_pivot_attached_transform"], "default": "items"}]]></attr>
<attr name="addNewParents" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
</attributes>
</module>
</children>
</module>
