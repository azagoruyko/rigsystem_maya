<module name="BipedAverages" muted="0" uid="238c845a2ae24859928dc59289f54fca">
<doc><![CDATA[## Summary  
The **bipedAverages** module is a compound tool that creates joint‑angle averaging helpers for a biped rig. It spawns a set of child modules—one for each major joint (shoulder, elbow, hand, knee, hip)—that generate locator groups, angle‑between nodes, and weight attributes. These helpers can be used to drive corrective shape drivers, pose‑space deformation weights, or any other system that needs a smoothed representation of joint angles.

## Inputs  
Each child module requires the following inputs (set in the child’s attribute panel):  
- **name** – Identifier for the average group (e.g., `L_arm_1`).  
- **joint1, joint2, joint3** – The three joint transforms that define the segment (start, mid, end).  
- **offset** – Distance from the mid joint to place the average locator.  
- **speed** – Multiplier for the speed attributes that drive the locator’s translation.  
- **yAxis / zAxis** – Checkboxes to enable averaging along the Y or Z axis.  
- **posDirection / negDirection** – Checkboxes to create positive and negative direction averages.  

The root module itself has no direct parameters; it simply runs all child modules.

## Outputs  
Each child module creates the following nodes and attributes:  
- **Transform group** (`<name>_average_group`) with two locators (`<name>_average_orig_locator`, `<name>_average_end_locator`).  
- **Locators** (`<name>_average_<pos/neg>_<y/z>_locator`) that hold the average position.  
- **Attributes** on the locator:  
  - `outWeight` – Signed weight based on the angle difference.  
  - `outWeightAbs` – Absolute weight.  
  - `outAngle` – Current angle value.  
  - `baseAngle` – Reference angle (negative of the initial angle).  
  - `speedInner` / `speedOutter` – Double3 attributes controlling the locator’s translation speed.  
- **Transform** (`<name>_average_<pos/neg>_<y/z>_transform`) that receives the translated locator and can be used as a driver for downstream systems.  

These nodes are placed under the `internal` parent node and can be connected to other rig modules (e.g., corrective shape drivers, RBF/PSD weight generators).

## Usage  
1. **Add the module** to your rig workspace.  
2. **Configure each child**:  
   - Set the `name` to match the joint chain segment.  
   - Assign the correct `joint1`, `joint2`, and `joint3` transforms.  
   - Adjust `offset` and `speed` to match the desired spacing and responsiveness.  
   - Enable the desired axes (`yAxis`, `zAxis`) and directions (`posDirection`, `negDirection`).  
3. **Run the module** (or run each child individually). The script will create the locator groups, compute the angle between the joints, and wire the weight attributes.  
4. **Connect the outputs**: Use the generated `outWeight`, `outWeightAbs`, or the transform nodes as inputs to corrective shape drivers, blend nodes, or any other system that requires a smoothed joint‑angle value.  
5. **Iterate**: If you need to change the joint chain or tweak the averaging behavior, simply update the child attributes and re‑run.  

This setup provides a reusable, symmetric averaging framework for all major biped joints, simplifying the creation of corrective drivers and pose‑space deformation systems.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "Make sure elbow/knee averages are oriented by actual bends!", "default": "text"}]]></attr>
</attributes>
<children>
<module name="L_shoulder" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_1", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_shoulder_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_1_twist_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_1_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": 1, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
</attributes>
</module>
<module name="R_shoulder" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_1", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_shoulder_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_1_twist_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_1_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": 1, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
</attributes>
</module>
<module name="L_elbow" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_2", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_1_twist_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_2_twist_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_2_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="R_elbow" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_2", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_1_twist_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_2_twist_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_2_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="L_hand" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_3", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_2_twist_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_4_joint_transform", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": 1, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="R_hand" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_3", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_2_twist_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_arm_4_joint_transform", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": 1, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="L_knee" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_2", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_1_twist_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_2_twist_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_2_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="R_knee" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_2", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_1_twist_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_2_twist_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_2_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="L_hip" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_1", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_0_transform", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_1_noRotate_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_leg_1_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": 1, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="R_hip" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[import pymel.core as pm
import rig_utils

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)
parent = pm.PyNode("internal")

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = pm.createNode("plusMinusAverage", n=name+"_joint12_plusMinusAverage")
    plus23 = pm.createNode("plusMinusAverage", n=name+"_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = pm.createNode("angleBetween", n=name+"_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = pm.createNode("transform", n=@name+"_average_group")
origLoc = pm.spaceLocator(n=@name+"_average_orig_locator")
endLoc = pm.spaceLocator(n=@name+"_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

pm.pointConstraint(@joint3, endLoc)

pm.matchTransform(grp, @joint2)
pm.pointConstraint(@joint2, grp)
pm.PyNode(@joint2).s >> grp.s

oc = pm.parentConstraint(@joint1, @joint2, grp, st=["x", "y", "z"], mo=True)
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = pm.spaceLocator(n=name+"_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = pm.createNode("transform", n=name+"_transform", p=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        a = makeAngleBetweenRig(name, loc1.worldPosition, origLoc.worldPosition, endLoc.worldPosition)
        loc1.addAttr("outWeight", dv=0, k=True)
        loc1.addAttr("outWeightAbs", dv=0, k=True)
        loc1.addAttr("outAngle", dv=0, k=True)
        loc1.addAttr("baseAngle", dv=0, k=True)     
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = pm.createNode("addDL", n=name+"_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = pm.createNode("multDL", n=name+"_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = pm.createNode("condition", n=name+"_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        loc1.addAttr("speedInner", at="double3")
        loc1.addAttr("speedInnerX", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerY", at="double", k=True, p="speedInner")
        loc1.addAttr("speedInnerZ", at="double", k=True, p="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        loc1.addAttr("speedOutter", at="double3")
        loc1.addAttr("speedOutterX", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterY", at="double", k=True, p="speedOutter")
        loc1.addAttr("speedOutterZ", at="double", k=True, p="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = pm.createNode("multiplyDivide", n=name+"_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = pm.createNode("multiplyDivide", n=name+"_speedInner_inverse_multiplyDivide")
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = pm.createNode("multiplyDivide", n=name+"_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = pm.createNode("condition", n=name+"_speedSelector_condition")
        cond.operation.set(2) # >            
        add.output >> cond.firstTerm
        
        speedOutterMult.output >> cond.colorIfTrue
        speedInnerMult.output >> cond.colorIfFalse
        
        cond.outColor >> loc2.t
]]></run>
<doc><![CDATA[## Summary  
The **AverageJoints** module creates a helper group that averages the positions and orientations of three specified joints (or transforms). It generates locator nodes for each enabled axis and direction, calculates weighted angles between the joints, and exposes attributes that can drive other rig elements such as twist or deformation joints.

## Inputs  
- **`name`** – Base string used to name the created group and all helper nodes.  
- **`joint1`** – First joint or transform node in the chain (typically the root).  
- **`joint2`** – Middle joint or transform node; the pivot around which the average is calculated.  
- **`joint3`** – End joint or transform node; the target of the average.  
- **`offset`** – Numeric offset applied to the locator positions along the selected axis.  
- **`speed`** – Speed factor used when blending the weight attributes for the locators.  
- **`yAxis`** – Boolean flag to create average helpers along the Y axis.  
- **`zAxis`** – Boolean flag to create average helpers along the Z axis.  
- **`posDirection`** – Boolean flag to generate helpers for the positive direction of the chosen axis.  
- **`negDirection`** – Boolean flag to generate helpers for the negative direction of the chosen axis.

## Outputs  
- **`<name>_average_group`** – Main transform group containing all helper nodes.  
- **`<name>_average_orig_locator`** – Locator positioned at the middle joint.  
- **`<name>_average_end_locator`** – Locator positioned at the end joint.  
- For each enabled axis/direction combination:  
  - **`<name>_average_{pos/neg}_{y/z}_locator`** – Locator that holds the average position.  
  - **`<name>_average_{pos/neg}_{y/z}_transform`** – Child transform that receives the weighted translation.  
  - These locators expose attributes: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- All internal nodes (plusMinusAverage, angleBetween, condition, multiplyDivide, etc.) are created under the group but are not exposed as separate outputs.

## Usage  
1. **Assign Joints** – Set `joint1`, `joint2`, and `joint3` to the three joints you wish to average.  
2. **Configure Parameters** –  
   - Choose a descriptive `name` for the helper group.  
   - Adjust `offset` to control how far the locators sit from the joints.  
   - Set `speed` to tune the responsiveness of the weight blending.  
   - Toggle `yAxis`/`zAxis` and `posDirection`/`negDirection` to generate the desired set of helpers.  
3. **Run the Module** – Execute the module; it will create the group and all locator/transform nodes.  
4. **Utilize Helpers** – Use the locators’ attributes (`outWeight`, `outAngle`, etc.) to drive other rig components (e.g., twist joints, deformation controls).  
5. **Cleanup** – If you no longer need a particular helper, simply delete the corresponding locator or disable its axis/direction flags and re‑run the module.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_1", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_0_transform", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_1_noRotate_1_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_leg_1_twist_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": 1, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
</children>
</module>