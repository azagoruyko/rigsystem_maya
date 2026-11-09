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
    rig_utils.setToOffsetParentMatrix(tr)
            
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
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["pCube1"], "default": "items"}]]></attr>
<attr name="out_transforms" template="listBox" category="Output" connect=""><![CDATA[{"items": ["pCube1_pivot_transform"], "default": "items"}]]></attr>
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