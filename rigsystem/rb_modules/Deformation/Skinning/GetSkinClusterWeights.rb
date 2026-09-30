<module name="getSkinClusterWeights" muted="0" uid="7604f4f6db0d419b9461bba2ecc80459">
<run><![CDATA[import pymel.core as pm
import rig_utils

if @mode == 0: # get
    @set_data(rig_utils.skinCluster.SkinClusterHelper(@skinCluster).toJson())
    
elif @mode == 1: # set
    rig_utils.skinCluster.SkinClusterHelper(@skinCluster).fromJson(@data)]]></run>
<doc><![CDATA[## Summary  
Retrieves or applies skin cluster weight data for a specified geometry. In **Get** mode it serializes the current skin weights to JSON and stores them in the `data` attribute; in **Set** mode it deserializes JSON from `data` and writes it back to the skin cluster.

## Inputs  
- **`mode`** (`radioButton`):  
  - `0` – **Get**: Export current skin weights.  
  - `1` – **Set**: Import weights from the `data` attribute.  
- **`skinCluster`** (`lineEditAndButton`): Name of the target skin cluster node.  
- **`data`** (`lineEditAndButton`): JSON string containing weight matrices (used only when `mode` is **Set**).

## Outputs  
- **`data`** (`lineEditAndButton`): When `mode` is **Get**, this attribute is populated with a JSON representation of the skin cluster’s weight arrays, ready for export or further processing.  
- Side effect: In **Set** mode, the skin cluster’s weights are overwritten with the values supplied in `data`.

## Usage  
1. **Select the skin cluster** you wish to query or modify.  
2. **Set `mode`**:  
   - Choose **Get** to export weights.  
   - Choose **Set** to apply weights from a previously exported JSON.  
3. **Execute the module**.  
   - In **Get** mode, the `data` attribute will contain the JSON weight matrix.  
   - In **Set** mode, ensure `data` holds a valid JSON weight structure before running.  
4. **Export or import** the `data` attribute as needed (e.g., save to a file, load from a file, or pass to another module).]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Get", "Set"], "current": 0, "columns": 2, "default": "current"}]]></attr>
<attr name="skinCluster" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "skinCluster14", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nimport maya.mel as mel\nls = cmds.ls(sl=True)\nif ls: value = mel.eval(\"findRelatedSkinCluster \" + ls[0])", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="data" template="lineEditAndButton" category="Data" connect=""><![CDATA[{"value": {"weights": {"M_spine_ik_1_joint": [1.0, 0.9999999266398172, 0.9999999266398172, 0.9999980196952959, 0.9918741522547496, 0.9919316783205016, 0.9919316783205016, 0.9918741522547497, 0.31912697000356083, 0.3191280337293164, 0.3191280337293164, 0.31912697000356083, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], "M_spine_ik_2_joint": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.22419263384839638, 0.22415977062897696, 0.22415977062897696, 0.22419263384839638, 0.8091728728207026, 0.8093308919002793, 0.8093308919002793, 0.8091728728207026, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], "M_spine_fix_joint": [0.0, 7.336018285103571e-08, 7.336018285103571e-08, 1.9803047041770833e-06, 0.008125847745250384, 0.008068321679498395, 0.008068321679498395, 0.008125847745250235, 0.6808730299964392, 0.6808719662706836, 0.6808719662706836, 0.6808730299964392, 0.7758073661516036, 0.775840229371023, 0.775840229371023, 0.7758073661516036, 0.19082712717929734, 0.19066910809972068, 0.19066910809972068, 0.19082712717929734, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]}, "skinningMethod": 0, "dqWeights": []}, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>