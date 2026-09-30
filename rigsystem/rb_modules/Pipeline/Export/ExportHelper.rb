<module name="ExportHelper" muted="0" uid="3e1d4a234953465984ad40782cc951e2">
<run><![CDATA[import rig_utils

rig_utils.curve.saveCurveData(@nurbsCurve, @curveType)]]></run>
<doc><![CDATA[## Summary  
Saves the data of a specified NURBS curve to a file for use in game engine or Alembic export workflows.  

## Inputs  
- **`nurbsCurve`**: The name of the NURBS curve node to export.  
- **`curveType`**: A string describing the type of curve (e.g., “control”, “guide”, “animation”) that will be stored with the exported data.  

## Outputs  
- The module writes the curve’s control points, knot vector, and other relevant attributes to a file (the exact path and format are handled by `rig_utils.saveCurveData`).  
- No explicit node or attribute is created in the scene; the output is a file on disk.  

## Usage  
1. Select the NURBS curve you wish to export.  
2. In the **nurbsCurve** field, confirm the selected curve’s name (the button can auto‑populate the selection).  
3. Enter the desired **curveType** string.  
4. Click **Run** to execute the module; the curve data will be saved to the configured export location.  
5. Verify the output file in your project’s export directory.]]></doc>
<attributes>
<attr name="nurbsCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "curve1"}]]></attr>
<attr name="curveType" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "test", "min": "", "buttonEnabled": false}]]></attr>
</attributes>
</module>