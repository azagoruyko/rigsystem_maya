<module name="setModuleInfo" type="" muted="0" uid="6a834ba65ca34113a1d3c2c75d85f000">
<run><![CDATA[import pymel.core as pm
import rig_utils

moduleInfo = rig_utils.ModuleInfo(@moduleInfo)
moduleInfo.setAttr("type", @moduleType)
moduleInfo.setAttr(@control, pm.PyNode(@control).message)]]></run>
<doc><![CDATA[## Summary
Writes module metadata attributes (type, control references, and other optional data) into a `ModuleInfo` network node so that rig modules can be tracked and queried by downstream pipeline tools.

## Inputs
- **`moduleInfo`** – Name or path of the `ModuleInfo` node that will receive the metadata.  
- **`moduleType`** – String describing the module’s type (e.g., `AS_main`, `IKLimb`, `FKLimb`).  
- **`control`** – Name of the control node whose message attribute will be stored in the `ModuleInfo` node.

## Outputs
- The specified **`ModuleInfo` node** is updated with:
  - `type` attribute set to the value of `moduleType`.  
  - `control` attribute set to the message plug of the node named in `control`.  
  (No new nodes are created; the module only writes data into the existing node.)

## Usage
1. **Create or select a `ModuleInfo` node** in the scene (e.g., `moduleInfo1`).  
2. **Enter the node’s name** into the `moduleInfo` field.  
3. **Specify the module type** (e.g., `AS_main`) in the `moduleType` field.  
4. **Choose the control node** whose reference should be stored (use the button to pick a node from the viewport).  
5. **Run the module**. It will write the `type` and `control` attributes into the `ModuleInfo` node, making the module’s metadata available for other rig or pipeline modules.]]></doc>
<attributes>
<attr name="moduleInfo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "pCube1"}]]></attr>
<attr name="moduleType" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "value": "AS_main"}]]></attr>
<attr name="control" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "pCube1"}]]></attr>
</attributes>
<children>
</children>
</module>