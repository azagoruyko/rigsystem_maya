<module name="updateControlsColor" muted="0" uid="30f854df893a476b83423f05a830ae7d">
<run><![CDATA[import pymel.core as pm
import rig_utils

for ctrl in pm.selected(type="transform"):
    c = rig_utils.getColorByName(ctrl.name())
    for sh in ctrl.getShapes():
        sh.overrideEnabled.set(True)
        sh.overrideColor.set(c)]]></run>
<doc><![CDATA[## Summary
Updates the color overrides of all shapes attached to the currently selected transform nodes in Maya. For each selected control, the module retrieves a color value based on the control's name via `rig_utils.getColorByName` and applies that color to every shape by enabling the override and setting the `overrideColor` attribute.

## Inputs
- **Selected Transform Nodes**: Any transform nodes that are currently selected in the Maya scene. The module operates on these nodes only.

## Outputs
- **Shape Color Overrides**: The module does not produce new nodes or data; it directly modifies the `overrideEnabled` and `overrideColor` attributes of the shapes belonging to each selected transform.

## Usage
1. In Maya, select one or more transform nodes (controls) whose shapes you want to recolor.  
2. Execute the `updateControlsColor` module (e.g., via the Rig Builder UI or a script).  
3. The module will automatically look up a color for each control name using `rig_utils.getColorByName` and apply that color to all shapes of the selected transforms.  
4. Verify the color changes in the viewport; the shapes should now display the assigned override color.]]></doc>
</module>