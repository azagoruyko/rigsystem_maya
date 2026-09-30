<module name="addFollowAttr" muted="0" uid="ae9878fd05af41f49e42a3fe90540743">
<run><![CDATA[import pymel.core as pm
from anim_utils import switcher

control = pm.PyNode(@control)

follow = pm.PyNode(@transform).getParent() if @transform else control.getParent()

switcher.addFollow(
    control, 
    @nofollow, 
    follow, 
    transform=@transform,
    attr=@attr, 
    default=@default, 
    type=@type)
    
]]></run>
<doc><![CDATA[## Summary  
Adds a follow relationship to a specified control, optionally linking it to a target transform. The module creates a follow constraint (or equivalent node) that drives the control’s position/rotation based on the provided parameters, and optionally exposes the created node for downstream use.

## Inputs  
- **`control`** – The control node that will receive the follow behavior.  
- **`transform`** – (Optional) The transform node that the control should follow. If omitted, the control’s parent is used.  
- **`nofollow`** – Boolean flag indicating whether the follow should be disabled initially.  
- **`attr`** – Name of the attribute on the control that will be driven by the follow (e.g., `"translate"`, `"rotate"`).  
- **`default`** – Default value for the driven attribute when the follow is inactive.  
- **`type`** – Type of follow behavior (e.g., `"position"`, `"rotation"`, `"scale"` or a custom type understood by `switcher`).

## Outputs  
- **Follow node** – A constraint or custom node created by `switcher.addFollow` that connects the control to the target transform.  
- **Modified control** – The specified attribute on the control is set up to be driven by the follow node, with the default value applied when the follow is off.

## Usage  
1. **Set up inputs**:  
   - Choose the control you want to follow.  
   - Optionally select a target transform; otherwise the control’s parent will be used.  
   - Define the attribute to drive (`attr`), the default value (`default`), and the follow type (`type`).  
   - Set `nofollow` to `True` if you want the follow disabled initially.  
2. **Run the module**: Execute the module to create the follow relationship.  
3. **Verify**: The control should now follow the target transform according to the specified attribute and type.  
4. **Connect downstream**: If the created follow node is exposed (e.g., via an output attribute), connect it to other modules that need to reference the follow relationship.]]></doc>
<attributes>
<attr name="nofollow" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "main_control", "placeholder": "World-space / nofollow target", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transform" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Transform to follow", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="control" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_tunic_front_1_control", "placeholder": "Control to receive follow attr", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="type" template="comboBox" category="General" connect=""><![CDATA[{"items": ["point", "orient", "parent", "jointOrient"], "current": "parent", "default": "current"}]]></attr>
<attr name="attr" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "follow", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="default" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0.0, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>