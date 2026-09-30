<module name="mirrorCurves" muted="0" uid="c1f83e2098ab4b32a1290f845a7698bd">
<run><![CDATA[import pymel.core as pm
import rig_utils

if @useSelected:
    selection = pm.ls(sl=True, type="transform")
    if not selection:
        shapeSel = pm.ls(sl=True, type="nurbsCurve")
        selection = [s.getParent() for s in shapeSel]
else:
    selection = pm.ls(type="transform")

if not selection:
    warning("mirrorCurves: No curve transforms selected or found.")

processed = set()
for item in selection:
    shapes = [s for s in item.getShapes() if not s.isIntermediate() and isinstance(s, pm.nt.NurbsCurve)]
    if not shapes:
        continue

    name = item.name()
    if name in processed:
        continue

    if @direction == "Left to Right" and not rig_utils.naming.isLeftSide(name):
        continue
    elif @direction == "Right to Left" and not rig_utils.naming.isRightSide(name):
        continue

    dest = rig_utils.curve.mirrorCurveShape(item)
    if dest:
        processed.add(item.name())
        processed.add(dest.name())
]]></run>
<doc><![CDATA[## Summary
Mirrors the shape of selected NURBS curve transforms across a chosen axis, optionally filtering by side (left/right) and direction. The module updates the CV positions of the target curves in place, ensuring symmetric topology and geometry.

## Inputs
- **`useSelected`** (`checkBox`):  
  When checked, only the curves currently selected in the scene are processed. If unchecked, all transform nodes in the scene are considered.
- **`axis`** (`comboBox`):  
  The axis across which the mirroring occurs. Options are **X**, **Y**, or **Z**.
- **`direction`** (`comboBox`):  
  Determines which curves are mirrored:  
  - **Selected to Opposite** – mirrors each selected curve to its symmetric counterpart.  
  - **Left to Right** – only processes curves whose names indicate a left side.  
  - **Right to Left** – only processes curves whose names indicate a right side.

## Outputs
- The module does not create new nodes; it **modifies the CV positions of the existing curve shapes** in the scene.  
- Any curves that are successfully mirrored are marked as processed to avoid duplicate work.

## Usage
1. **Select Curves**  
   - If `useSelected` is checked, select the curve transforms you wish to mirror.  
   - If unchecked, the module will iterate over all transform nodes in the scene.
2. **Set Parameters**  
   - Choose the mirroring **axis** (X, Y, or Z).  
   - Pick the **direction**:  
     - *Selected to Opposite* to mirror each curve to its symmetric counterpart.  
     - *Left to Right* or *Right to Left* to filter curves by side before mirroring.
3. **Run the Module**  
   - Execute the module. It will locate the opposite curve names using the naming convention, verify topology, and update the CV positions symmetrically across the chosen axis.  
4. **Verify**  
   - Inspect the mirrored curves in the viewport to confirm that their shapes are now symmetric.  
   - If any curves were not mirrored, check the warning log for missing or mismatched names.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Select left/right curves to find opposite curves (via naming) and update their shape symmetrically."}]]></attr>
<attr name="useSelected" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="direction" template="comboBox" category="General" connect=""><![CDATA[{"current": "Selected to Opposite", "default": "current", "items": ["Selected to Opposite", "Left to Right", "Right to Left"]}]]></attr>
</attributes>
</module>