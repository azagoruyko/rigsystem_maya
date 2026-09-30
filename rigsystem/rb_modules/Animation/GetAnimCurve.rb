<module name="getAnimCurve" type="Tools/GetAnimCurve" muted="0" uid="dc8b7eedb70245a68d294d58cf5b3967">
<run><![CDATA[import pymel.core as pm
import rig_utils
    
if @mode == 0: # get
    @set_data(rig_utils.getAnimCurveData(pm.PyNode(@animCurve)))
    
elif @mode == 1: # set
    rig_utils.makeAnimCurve(@data)
]]></run>
<doc><![CDATA[## Summary
Retrieves keyframe and tangent information from a Maya animation curve into a structured Python list, or creates a new animation curve from such data. This tool is useful for exporting, mirroring, or re‑applying animation curves across controls.

## Inputs
- **`mode`** (`radioButton`):  
  - **Get** (`0`): Extract data from the selected animation curve.  
  - **Create** (`1`): Build a new animation curve from the provided data list.
- **`animCurve`** (`lineEditAndButton`): Name or path of the Maya animation curve node to read from or write to.
- **`data`** (`lineEdit`): When in **Create** mode, paste the exported data list here; when in **Get** mode, this field will be populated with the extracted data.

## Outputs
- **`data`**: In **Get** mode, this attribute is filled with a list containing keyframe times, values, tangent types, and in/out tangent vectors.  
- **Animation Curve Node**: In **Create** mode, a new animation curve is instantiated in the scene using the supplied data.

## Usage
1. **Get Curve Data**  
   - Set **`mode`** to **Get**.  
   - Use the button on **`animCurve`** to pick the target animation curve.  
   - Click **Run**.  
   - The **`data`** field will display the extracted keyframe information; copy it for later use.

2. **Create Curve from Data**  
   - Set **`mode`** to **Create**.  
   - Paste the previously copied data list into the **`data`** field.  
   - Specify the desired name/path in **`animCurve`** (or leave blank to let Maya auto‑name).  
   - Click **Run** to generate a new animation curve with the provided keyframes.

3. **Mirroring or Export**  
   - Export the **`data`** list to a file or use it as input for another rigging tool that requires identical animation curves on mirrored controls.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Get", "Create"], "default": "current"}]]></attr>
<attr name="animCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "pCube1_translateX"}]]></attr>
<attr name="data" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "value": ["animCurveTL", 0, 0, [[1.0, 0.0, ["auto", "auto"], [1.0, 1.0, 0.0, 0.0], [0, 1, 0]], [15.0, 2.6117272631582686, ["auto", "auto"], [0.19840861917354588, 0.1984086191735459, 0.980119390603842, 0.9801193906038421], [0, 1, 0]], [26.0, 5.145732593666446, ["auto", "auto"], [0.13488401596735866, 0.13488401596735866, 0.9908613940589861, 0.9908613940589861], [0, 1, 0]], [37.0, 9.345583789498198, ["auto", "auto"], [1.0, 1.0, 0.0, 0.0], [0, 1, 0]]]]}]]></attr>
</attributes>
<children>
</children>
</module>