<module name="Fingers" muted="0" uid="35660581920746079cd76409b837b743">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent

controlsParent = pm.PyNode("controls")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    helpers = []
    for name, j1, _, _, _, _ in @fingers:
        hlp = rig_utils.curve.makeCurve(@side + "_" + name + "_control_helper", "cube")
        pm.parentConstraint(pm.PyNode(@side + "_" + j1), hlp)
        helpersParent | hlp
        helpers.append(hlp.name())

    @set_helpers(helpers)

elif @mode == 1:  # run
    controls_grp = pm.createNode("transform", n=@side + "_" + @name + "_controls_group", p=controlsParent)
    rig_utils.lockTRS(controls_grp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)

    spreadNode = None
    cuppingNode = None
    
    controls = []
    constraints = []
    for i, (name, j1, j2, j3, _, _) in enumerate(@fingers):
        helper = pm.PyNode(@helpers[i])
        j1 = pm.PyNode(@side + "_" + j1)
        j2 = pm.PyNode(@side + "_" + j2)
        j3 = pm.PyNode(@side + "_" + j3) if pm.objExists(@side + "_" + j3) else None

        j3_children = j3.listRelatives(c=True, type="joint") if j3 else []
        j4 = j3_children[0] if j3_children else None

        # fk control
        transform = pm.createNode("transform", n=@side + "_" + name + "_control_transform", p=controls_grp)
        ctrl = pm.createNode("transform", n=@side + "_" + name + "_control", p=transform)
        rig_utils.lockTRS(ctrl, [], [], [1, 1, 1], 1)
        
        pm.matchTransform(transform, j1)        
        pm.parentConstraint(j1.getParent(), transform, mo=True)
        rig_utils.curve.makeFromCurve(ctrl, helper)
        
        dynamicParent.makeDynamicParent(ctrl, ctrl)

        pc = pm.parentConstraint(ctrl, j1)
        constraints.append(pc)

        if name == @spreadOn:
            spreadNode = ctrl

        if name == @cuppingOn:
            cuppingNode = ctrl
                    
        pm.aliasAttr("roll", ctrl.rx)
        pm.aliasAttr("sideways", ctrl.ry)
        pm.aliasAttr("bendA", ctrl.rz)        
    
        if j2:
            ctrl.addAttr("bendB", at="doubleAngle", dv=0, k=True)
            ctrl.bendB >> pm.PyNode(j2).rz
        if j3:
            ctrl.addAttr("bendC", at="doubleAngle", dv=0, k=True)
            ctrl.bendC >> j3.rz

                            
        for label, j in zip("ABC", [j1, j2, j3]): 
            if j:
                attr = "scaleFactor"+label      
                ctrl.addAttr(attr, at="float", dv=1, min=0.01, k=True)
                ctrl.attr(attr) >> j.sx        

        for label, j in zip(["A_yz", "B_yz", "C_yz"], [j1, j2, j3]): 
            if j:
                attr = "scaleFactor"+label
                ctrl.addAttr(attr, at="float", dv=1, min=0.01, k=True)
                ctrl.attr(attr) >> j.sy       
                ctrl.attr(attr) >> j.sz
           
        controls.append(ctrl)
        
    if spreadNode:
        spreadNode.addAttr("spread", dv=0, k=True)

        for i, (name, _, _, _, spread, _) in enumerate(@fingers):
            if spread == 0:
                continue
                
            mult = pm.createNode("multDL", n=@side + "_" + name + "_spread_multDL")
            mult.input1.set(spread)
            spreadNode.spread >> mult.input2
            mult.output >> constraints[i].target[0].targetOffsetRotate.targetOffsetRotateY

    if cuppingNode:
        cuppingNode.addAttr("cupping", dv=0, k=True)

        for i, (name, j1, _, _, _, cupping) in enumerate(@fingers):
            if cupping == 0:
                continue
                
            j1_parent = pm.PyNode(@side + "_" + j1).getParent()
            if j1_parent:
                md = pm.createNode("multiplyDivide", n=@side + "_" + name + "_cupping_multiplyDivide")
                md.input1.set(x*cupping for x in @cuppingCoeff)
                
                cuppingNode.cupping >> md.input2X
                cuppingNode.cupping >> md.input2Y
                cuppingNode.cupping >> md.input2Z
                md.output >> j1_parent.r

    # moduleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@side + "_" + @name)
    moduleInfo.setAttr("type", "fingers")
    
    for i, ctrl in enumerate(controls):
        moduleInfo.setAttr("control"+str(i+1), ctrl.message)
]]></run>
<doc><![CDATA[## Summary  
Creates a finger rig for a hand or paw, generating FK controls for each digit with optional spread and cupping attributes. The module can first produce placement helpers (in **Helpers** mode) and then build the full control hierarchy (in **Run** mode), publishing a `moduleInfo` node that lists all generated controls for downstream modules.

## Inputs  
- **`mode`** (`radioButton`):  
  - **Helpers** – creates placement helper curves for each finger.  
  - **Run** – builds the final FK control hierarchy.  
- **`side`** (`lineEditAndButton`): Prefix for all created nodes (e.g., `L` or `R`).  
- **`name`** (`lineEditAndButton`): Base name for the module (default `fingers`).  
- **`fingers`** (`table`): Table defining each digit. Each row contains:  
  1. **name** – finger identifier (`thumb`, `index`, …).  
  2. **joint1** – first joint of the finger.  
  3. **joint2** – second joint.  
  4. **joint3** – third joint (may be `None`).  
  5. **spread** – numeric value used to drive spread on the selected spread finger.  
  6. **cupping** – numeric value used to drive cupping on the selected cupping finger.  
- **`spreadOn`** (`comboBox`): Finger whose control will receive the `spread` attribute.  
- **`cuppingOn`** (`comboBox`): Finger whose control will receive the `cupping` attribute.  
- **`cuppingCoeff`** (`vector`): Coefficients applied when driving cupping rotations.  
- **`helpers`** (`listBox`): List of helper curve names created in **Helpers** mode; used as input when building the controls.

## Outputs  
- **`moduleInfo`** (`rig_utils.moduleInfo.ModuleInfo`):  
  - `type` = `"fingers"`.  
  - `control1`, `control2`, … – message attributes pointing to each finger FK control.  
- **`helpers`** list (in **Helpers** mode): Names of the helper curves created for each finger.  
- **Control hierarchy** under a group named `<side>_<name>_controls_group`:  
  - FK control nulls and controls for each finger.  
  - Spread and cupping attributes on the selected controls.  
  - Spread multiplier nodes and cupping multiplyDivide nodes that drive joint rotations.  
- **`spreadNode`** and **`cuppingNode`** (the controls selected by `spreadOn` and `cuppingOn`) receive the `spread` and `cupping` attributes, respectively.

## Usage  
1. **Set up the finger data**:  
   - Fill the `fingers` table with the joint names for each digit.  
   - Choose which finger will drive spread (`spreadOn`) and cupping (`cuppingOn`).  
2. **Generate helpers**:  
   - Switch `mode` to **Helpers** and execute.  
   - The module creates a cube helper curve for each finger and populates the `helpers` list.  
   - Position the helpers in the viewport to match the desired control placement.  
3. **Build the rig**:  
   - Set `mode` to **Run** and execute.  
   - The module creates FK controls, applies spread and cupping logic, and publishes the `moduleInfo`.  
4. **Connect downstream modules**:  
   - Use the `moduleInfo` node to reference the finger controls from other modules (e.g., hand, palm, or animation layers).  
   - If needed, adjust the spread or cupping attributes on the selected controls to fine‑tune finger spread or cupping behavior.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="side" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "L", "buttonEnabled": false}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "fingers", "buttonEnabled": false}]]></attr>
<attr name="fingers" template="table" category="General" connect=""><![CDATA[{"default": "items", "items": [["thumb", "thumb_1_joint", "thumb_2_joint", "thumb_3_joint", 0, 0], ["index", "index_1_joint", "index_2_joint", "index_3_joint", 0.666, 0], ["middle", "middle_1_joint", "middle_2_joint", "middle_3_joint", 0.05, 0], ["ring", "ring_1_joint", "ring_2_joint", "ring_3_joint", -0.5, 1], ["pinky", "pinky_1_joint", "pinky_2_joint", "pinky_3_joint", -1, 0]], "header": ["name", "joint1", "joint2", "joint3", "spread", "cupping"]}]]></attr>
<attr name="spreadOn" template="comboBox" category="General" connect=""><![CDATA[{"current": "thumb", "items": ["thumb", "index", "middle", "ring", "pinky"], "default": "current"}]]></attr>
<attr name="cuppingOn" template="comboBox" category="General" connect=""><![CDATA[{"current": "thumb", "items": ["(no cupping)", "thumb", "index", "middle", "ring", "pinky"], "default": "current"}]]></attr>
<attr name="cuppingCoeff" template="vector" category="General" connect=""><![CDATA[{"default": "value", "value": [-1.0, 0.15, 0.2]}]]></attr>
<attr name="helpers" template="listBox" category="Helpers" connect=""><![CDATA[{"default": "items", "items": ["L_thumb_control_helper", "L_index_control_helper", "L_middle_control_helper", "L_ring_control_helper", "L_pinky_control_helper"]}]]></attr>
</attributes>
</module>