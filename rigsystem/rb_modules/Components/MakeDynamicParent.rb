<module name="MakeDynamicParent" muted="0" uid="049b644ccf1c4022b8f02ef231b0ebe4">
<run><![CDATA[import anim_utils
anim_utils.dynamicParent.makeDynamicParent(@parent, @control)]]></run>
<doc><![CDATA[## Summary
Builds dynamic parent space switching setups (world, root, chest, head, ik) by adding custom enum attributes to a control node and wiring a parent‑constraint weight network that drives the control’s parent space during animation.

## Inputs
- **`parent`** – Name of the node that will serve as the target parent for the dynamic switching (e.g., a joint or a transform that represents a world, root, chest, head, or IK space).  
- **`control`** – Name of the control node that will receive the enum attribute and the constraint network, enabling the user to switch its parent space interactively.

## Outputs
- The **control node** is modified: an enum attribute (typically named something like `parentSpace`) is added, exposing options such as *World*, *Root*, *Chest*, *Head*, *IK*.  
- A **parent‑constraint network** (or a set of weight nodes) is created and connected to the control, so that selecting an enum value automatically changes the control’s parent.  
- No separate output nodes are created; the module’s effect is the modification of the existing control and the creation of the constraint network in the scene.

## Usage
1. **Select the target nodes**: In the scene, pick the node that will act as the parent (`parent`) and the control node that will receive the dynamic switching (`control`).  
2. **Configure the module**: In the module’s UI, the `parent` and `control` fields will already show the selected names; adjust them if necessary.  
3. **Run the module**: Execute the module. It will add the enum attribute to the control and wire the constraint network.  
4. **Test the switching**: In the control’s attribute editor, change the enum value to see the control snap to the chosen parent space.  
5. **Integrate downstream**: Connect the control to other rig modules (e.g., IK handles, FK chains) as needed; the dynamic parent will automatically update those connections.]]></doc>
<attributes>
<attr name="parent" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "sword1_main_control", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="control" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "sword1_main_control", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>