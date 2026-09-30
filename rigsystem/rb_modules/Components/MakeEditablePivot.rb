<module name="makeEditablePivot" muted="0" uid="14932544be434020a1338edbc2110db2">
<run><![CDATA[import pymel.core as pm
import rig_utils

makeHelperMod = module.child("MakeHelper")

controls = []
for tr in @transforms:
    tr = pm.PyNode(tr)
    children = tr.getChildren(type="transform")
    if not children:
        warning(f"{tr.name()} must have children to edit pivot for")
        continue
        
    pivot = pm.createNode("transform", n=tr+"_pivot_transform", p=tr.getParent())
    pm.matchTransform(pivot, tr)
    rig_utils.setToOffsetParentMatrix(pivot)
    
    pivot | tr
            
    pivotOffset = pm.createNode("transform", n=tr+"_pivot_offset_transform", p=tr)
    pm.parent(children, pivotOffset)
    
    rig_utils.lockTRS(pivotOffset)
    
    pivot.inverseMatrix >> pivotOffset.offsetParentMatrix

    if @makeShape:
        h = pivot + "_helper"
        makeHelperMod.attr.name.set(h)
        makeHelperMod.run()
        pm.matchTransform(h, tr)
        
        ctrl = pm.createNode("transform", n=tr+"_pivot_control")
        pivot.parentMatrix >> ctrl.offsetParentMatrix
        ctrl.inheritsTransform.set(False)
        
        rig_utils.curve.makeFromCurve(ctrl, h)
        pm.delete(h)
        rig_utils.lockTRS(ctrl, [], [])
        
        pm.parentConstraint(ctrl, pivot, mo=True)
        controls.append(ctrl)
        
@set_out_controls([c.name() for c in controls])

]]></run>
<doc><![CDATA[## Summary  
Creates pivot helpers and optional control curves for a list of selected transforms. For each transform it generates a pivot transform, an offset parent transform, and, if requested, a helper curve and a control that is constrained to the pivot. The module outputs the names of all created controls for downstream use.

## Inputs  
- **`@transforms`** – A list of transform node names or PyNode objects to process.  
- **`@makeShape`** – Boolean flag. When `True`, a helper curve is created for each pivot using the child module **MakeHelper**.  
- **`@set_out_controls`** – Output attribute that receives the list of created control names.

## Outputs  
- **`out_controls`** – A list of the names of all control transforms created by the module.  
- (Implicit) For each input transform, the module creates:  
  - A pivot transform (`*_pivot_transform`) parented to the original transform’s parent.  
  - A pivot offset transform (`*_pivot_offset_transform`) parented to the original transform, with its `offsetParentMatrix` driven by the pivot’s inverse matrix.  
  - If `@makeShape` is `True`, a helper curve (`*_helper`) and a control transform (`*_pivot_control`) that inherits the pivot’s transform but is constrained to it.

## Usage  
1. Select the transforms you want to add pivot helpers to.  
2. Set the `@transforms` attribute to the list of selected transforms (or let the module auto‑detect the selection).  
3. Toggle `@makeShape` to `True` if you want a visual helper curve and control for each pivot.  
4. Execute the module.  
5. The module will create the pivot hierarchy and, if requested, helper curves and controls.  
6. The names of all created controls are available in the `out_controls` output for connection to other rig modules or for further manipulation.]]></doc>
<attributes>
<attr name="curveType" template="comboBox" category="General" connect=""><![CDATA[{"items": ["arc", "arrow", "axis", "axisSphere", "cube", "circle", "diamond", "key", "pyramid", "rect", "sphere", "triangle", "plus"], "current": "axis", "default": "current"}]]></attr>
<attr name="makeShape" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["joint1", "joint2", "joint3", "joint4"], "default": "items"}]]></attr>
<attr name="out_controls" template="listBox" category="Output" connect=""><![CDATA[{"items": ["joint1_pivot_control", "joint2_pivot_control", "joint3_pivot_control", "joint4_pivot_control"], "default": "items"}]]></attr>
</attributes>
<children>
<module name="MakeHelper" muted="1" uid="1f5e3d986051407397d0b580e70ef628">
<run><![CDATA[import rig_utils
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
<attr name="curveType" template="comboBox" category="General" connect="/curveType"><![CDATA[{"items": ["arc", "arrow", "axis", "axisSphere", "cube", "circle", "diamond", "key", "pyramid", "rect", "sphere", "triangle", "plus"], "current": "axis", "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "joint4_pivot_transform_helper", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
</children>
</module>