<module name="MakeControl" muted="0" uid="d25b5dd9832e485d89561e7a13924fb8">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent

controlsParent = pm.PyNode("controls")
helpersParent = pm.PyNode("helpers")

rotateOrder = @rotateOrder_data["items"].index(@rotateOrder)

if @mode == 0: # helpers
    hlp = rig_utils.curve.makeCurve(@name + "_control_helper", @curveType)
    helpersParent | hlp
    pm.parentConstraint(@helperAtTransform, hlp)
    rig_utils.lockTRS(hlp, [1,1,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(hlp)  
    @set_helper(hlp.name())
    
elif @mode == 1: # run
    helper = pm.PyNode(@helper)
    
    transform = pm.createNode("transform", n=@name + "_control_transform", p=controlsParent)
    ctrl = pm.createNode("transform", n=@name + "_control", p=transform)
    ctrl.ro.set(rotateOrder)

    rig_utils.lockTRS(ctrl, [1,1,1] if @translateLock else [], [1,1,1] if @rotateLock else [], [1,1,1], 1)
        
    pm.matchTransform(transform, helper)
    rig_utils.curve.makeFromCurve(ctrl, helper)
    
    if @parent:
        pm.parentConstraint(@parent, transform, mo=True)
        
    dynamicParent.makeDynamicParent(ctrl, ctrl)
    
    for n in @driven:
        if @constraint == 0: # pointConstraint
            pm.pointConstraint(ctrl, n)
    
        elif @constraint == 1: # orientConstraint
            pm.orientConstraint(ctrl, n, mo=True)
    
        elif @constraint == 2: # parentConstraint
            pm.parentConstraint(ctrl, n, mo=True)
            
    @set_out_control(ctrl.name())            
]]></run>
<doc><![CDATA[## Summary  
Creates a shoulder animation control curve with optional helper placement. In **Helpers** mode it generates a guide curve at a specified transform, while in **Run** mode it builds a control hierarchy (transform + control), applies channel locks, matches the helper, and drives selected objects with the chosen constraint type. The module outputs the final control name for downstream connections.

## Inputs  
- **`mode`** – Radio button (`Helpers` or `Run`) determining whether to create a helper or the final control.  
- **`name`** – Base name for the control and helper objects.  
- **`curveType`** – Shape of the helper/control curve (sphere, footstep, cube, circle, axis, arc).  
- **`helperAtTransform`** – Transform node used to position the helper curve in **Helpers** mode.  
- **`helper`** – Name of the helper curve created in **Helpers** mode, used as the reference transform in **Run** mode.  
- **`parent`** – Optional parent transform for the control transform; if set, a parent constraint is applied.  
- **`driven`** – List of transforms that will be driven by the control using the selected constraint type.  
- **`constraint`** – Constraint type applied to each driven object (`Point`, `Orient`, or `Parent`).  
- **`rotateOrder`** – Desired rotate order for the control transform.  
- **`translateLock`** – Boolean to lock translation channels on the control.  
- **`rotateLock`** – Boolean to lock rotation channels on the control.  

## Outputs  
- **`out_control`** – The name of the created control transform (e.g., `L_shoulder_control`).  
- The module also creates a helper curve (when in **Helpers** mode) and a control hierarchy under the `controls` and `helpers` parent transforms, which can be referenced by downstream modules.

## Usage  
1. **Helpers Mode** – Set `mode` to **Helpers**.  
   - Specify `name`, `curveType`, and `helperAtTransform`.  
   - Execute the module to generate a guide curve under the `helpers` parent.  
   - Adjust the helper’s position and orientation in the viewport as needed.  

2. **Run Mode** – Switch `mode` to **Run**.  
   - Provide the `helper` name created in the previous step.  
   - Set `parent` if the control should follow another transform.  
   - Define `driven` objects and choose the desired `constraint` type.  
   - Configure `rotateOrder`, `translateLock`, and `rotateLock` as required.  
   - Execute the module to create the control hierarchy under `controls`.  

3. **Connect Outputs** – Use the `out_control` value to link this control to other rig modules (e.g., arm, hand, or IK systems).  
4. **Optional** – The helper curve can be reused or deleted after the control is built.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 0, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "L_shoulder", "buttonEnabled": false}]]></attr>
<attr name="driven" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["L_shoulder_joint"]}]]></attr>
<attr name="constraint" template="radioButton" category="General" connect=""><![CDATA[{"current": 2, "items": ["Point", "Orient", "Parent"], "default": "current"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_spine_5_joint"}]]></attr>
<attr name="rotateOrder" template="comboBox" category="General" connect=""><![CDATA[{"current": "yxz", "items": ["xyz", "yzx", "zxy", "xzy", "yxz", "zyx"], "default": "current"}]]></attr>
<attr name="translateLock" template="checkBox" category="Locks" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="rotateLock" template="checkBox" category="Locks" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="curveType" template="comboBox" category="Helper" connect=""><![CDATA[{"current": "arc", "items": ["sphere", "footstep", "cube", "circle", "axis"], "default": "current"}]]></attr>
<attr name="helperAtTransform" template="lineEditAndButton" category="Helper" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="helper" template="lineEditAndButton" category="Helper" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_shoulder_control_helper"}]]></attr>
<attr name="out_control" template="lineEditAndButton" category="Out" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_shoulder_control"}]]></attr>
</attributes>
</module>