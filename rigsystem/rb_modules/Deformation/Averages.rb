<module name="Averages" muted="0" uid="eedb6617e102478a81cbbe59cce3aa2c">
<children>
<module name="updateAverageBaseAngle" muted="0" uid="9b6ba97ecdbf4974997680e52cad5502">
<run><![CDATA[import pymel.core as pm

for loc in pm.ls("*_average_*_locator"):
    if pm.objExists(loc+".outAngle") and loc.baseAngle.isSettable():        
        loc.baseAngle.set(-loc.outAngle.get())
        print(loc)]]></run>
<doc><![CDATA[## Summary  
The **Averages** module orchestrates the creation, maintenance, and mirroring of joint‑angle averaging locators for biped and finger rigs. It runs a set of child modules that generate average groups, locators, and weight‑blending nodes, then updates base angles and mirrors parameters between left and right sides.

## Inputs  
- **Joint names** (`joint1`, `joint2`, `joint3`) – the three joints that define the averaging segment.  
- **Name** (`name`) – base name used for the average group and locator naming.  
- **Offset** (`offset`) – numeric value controlling the distance of the helper locators from the joint chain.  
- **Speed** (`speed`) – multiplier for the `speedInner` and `speedOutter` attributes.  
- **Axis toggles** (`yAxis`, `zAxis`) – enable averaging on the Y or Z axis.  
- **Direction toggles** (`posDirection`, `negDirection`) – choose whether to create positive or negative direction averages.  
- **Scene joints** – the module expects the scene to contain the specified joint hierarchy (e.g., shoulder, elbow, wrist, finger joints).

## Outputs  
- **Average groups** (`*_average_group`) and **locators** (`*_average_*_locator`) that drive weight blending.  
- **Attributes** on each locator: `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`.  
- **Mirrored attributes** – the module copies `t`, `speedInner`, and `speedOutter` from left‑side locators to their right‑side counterparts.  
- **Base angle updates** – `baseAngle` is set to the negative of `outAngle` for all average locators.

## Usage  
1. **Configure child modules** – For each limb or finger, set the `name`, `joint1`, `joint2`, `joint3`, `offset`, `speed`, and axis/direction toggles.  
2. **Run `updateAverageBaseAngle`** – This script sets every locator’s `baseAngle` to the negative of its `outAngle`.  
3. **Run `mirrorAverageValues`** – Mirrors the `t`, `speedInner`, and `speedOutter` attributes from left to right side locators.  
4. **Execute `bipedAverages`** – Generates average locators for shoulders, hips, knees, and elbows.  
5. **Execute `bipedFingersAverages`** – Automatically creates average locators for each finger digit (thumb, index, middle, ring, pinky).  
6. **Optionally run `mirrorAverageJoints`** – Mirrors the locator parameters again if new locators were added.  
7. **Connect outputs** – Use the generated locators and attributes as inputs to downstream modules (e.g., corrective shape drivers, deformation rigs).]]></doc>
</module>
<module name="mirrorAverageValues" muted="0" uid="e7f568dc08e241e09d741aa978e51e5f">
<run><![CDATA[import pymel.core as pm
import rig_utils

averages = pm.ls("*_average_*_locator")
for avg in averages:
    if not ("_pos_" in avg.name() or "_neg_" in avg.name()):
        continue
        
    if not rig_utils.naming.isLeftSide(avg.name()):
        continue
        
    symAvg = rig_utils.naming.findSymmetricName(avg)
    if "_pos_" in avg.name():
        symAvg = symAvg.replace("_pos_", "_neg_")
    elif "_neg_" in avg.name():
        symAvg = symAvg.replace("_neg_", "_pos_")
    
    if symAvg != avg and pm.objExists(symAvg):
        print("{} >> {}".format(avg, symAvg))
        symAvg = pm.PyNode(symAvg)
        for a in ["t", "speedInner", "speedOutter"]:
            coeff = -1 if a == "t" else 1
            if symAvg.attr(a).isSettable():
                v = avg.attr(a).get()           
                symAvg.attr(a).set(coeff * v)]]></run>
<doc><![CDATA[## Summary

Mirrors joint angle average values and locator parameters from left to right side rig components.

## Use cases

- Synchronizing average locator setup parameters across symmetrical limbs.
- Automating symmetric driver attribute configuration.
- Mirroring angle calculation attributes across character sides.]]></doc>
</module>
<module name="bipedAverages" muted="0" uid="238c845a2ae24859928dc59289f54fca">
<doc><![CDATA[## Summary

Compound module for biped rigs that sets up joint angle averaging across shoulders, hips, knees, and elbows for corrective shape drivers.

## Use cases

- Automating angle calculation locators across all biped major joints.
- Driving pose-space deformation (RBF/PSD) weights from joint orientation angles.
- Standardizing average node setups for biped character assets.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
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
<module name="bipedFingersAverages" muted="0" uid="8bde81c4d3ca49d9ba1fa6bb8511fedf">
<run><![CDATA[import pymel.core as pm
import rig_utils

sides = ["L", "R"]
fingers = ["thumb", "index", "middle", "ring", "pinky"]
startTranformSuffix = "_0_transform"

avgModule = module.child(0)

for side in sides:
    isLeft = rig_utils.naming.isLeftSide(side+"_")
    avgModule.attr.negDirection.set(isLeft)
    avgModule.attr.posDirection.set(not isLeft)
    
    for f in fingers:
        joints = pm.ls("{}_{}_?_joint".format(side, f))             
        print("{}_{}".format(side, f))
        if f != "thumb": # no needed for thumb
            if not pm.objExists("{}_{}_1_average_group".format(side, f)):                
                avgModule.attr.name.set("{}_{}_1".format(side, f))
                avgModule.attr.joint1.set("{}_{}{}".format(side, f, startTranformSuffix))
                avgModule.attr.joint2.set(joints[0].name())
                avgModule.attr.joint3.set(joints[1].name())            
                avgModule.run()
        
        if len(joints) > 2 and not pm.objExists("{}_{}_2_average_group".format(side, f)):                
            avgModule.attr.name.set("{}_{}_2".format(side, f))
            avgModule.attr.joint1.set(joints[0].name())
            avgModule.attr.joint2.set(joints[1].name())
            avgModule.attr.joint3.set(joints[2].name())            
            avgModule.run()                
            
        if len(joints) > 3 and not pm.objExists("{}_{}_3_average_group".format(side, f)):                
            avgModule.attr.name.set("{}_{}_3".format(side, f))
            avgModule.attr.joint1.set(joints[1].name())
            avgModule.attr.joint2.set(joints[2].name())
            avgModule.attr.joint3.set(joints[3].name())            
            avgModule.run()
        
    ]]></run>
<doc><![CDATA[## Summary

Specialized compound module for generating joint angle average nodes across finger digit joints for corrective finger blending.

## Use cases

- Computing finger flexion and splay angles for corrective blendshape triggers.
- Driving organic hand mesh deformations on finger bending.
- Automating angle locator networks across left and right hand fingers.]]></doc>
<children>
<module name="AverageJoints" muted="1" uid="aa34933cc99d4d389840950f60ed08be">
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_pinky_3", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_pinky_2_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_pinky_3_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_pinky_4_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
</attributes>
</module>
<module name="mirrorAverageJoints" muted="0" uid="e7f568dc08e241e09d741aa978e51e5f">
<run><![CDATA[import pymel.core as pm
import rig_utils

averages = pm.ls("*_average_*_locator")
for avg in averages:
    if not ("_pos_" in avg.name() or "_neg_" in avg.name()):
        continue
        
    if not rig_utils.naming.isLeftSide(avg.name()):
        continue
        
    symAvg = rig_utils.naming.findSymmetricName(avg)
    if "_pos_" in avg.name():
        symAvg = symAvg.replace("_pos_", "_neg_")
    elif "_neg_" in avg.name():
        symAvg = symAvg.replace("_neg_", "_pos_")
    
    if symAvg != avg and pm.objExists(symAvg):
        print("{} >> {}".format(avg, symAvg))
        symAvg = pm.PyNode(symAvg)
        for a in ["t", "speedInner", "speedOutter"]:
            coeff = -1 if a == "t" else 1
            if symAvg.attr(a).isSettable():
                v = avg.attr(a).get()           
                symAvg.attr(a).set(coeff * v)]]></run>
<doc><![CDATA[## Summary

Mirrors joint angle average values and locator parameters from left to right side rig components.

## Use cases

- Synchronizing average locator setup parameters across symmetrical limbs.
- Automating symmetric driver attribute configuration.
- Mirroring angle calculation attributes across character sides.]]></doc>
</module>
<module name="updateAverageBaseAngle" muted="0" uid="9b6ba97ecdbf4974997680e52cad5502">
<run><![CDATA[import pymel.core as pm

for loc in pm.ls("*_average_*_locator"):
    if pm.objExists(loc+".outAngle") and loc.baseAngle.isSettable():        
        loc.baseAngle.set(-loc.outAngle.get())
        print(loc)]]></run>
<doc><![CDATA[## Summary

The script scans all Maya locator objects whose names match the pattern *_average_*_locator. For each matching locator, it verifies that an outAngle attribute exists and that the baseAngle attribute is writable. If both conditions are satisfied, it assigns baseAngle the negative of outAngle and logs the locator’s name, effectively mirroring the outAngle value onto baseAngle for the selected locators.

## Use cases

- Synchronizing angle attributes across mirrored locator pairs.
- Automating attribute adjustments during rig setup or cleanup.
- Providing quick debugging output for locator configurations.]]></doc>
</module>
</children>
</module>
<module name="AverageJoints" muted="0" uid="aa34933cc99d4d389840950f60ed08be">
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

Calculates average position and orientation values between joints or node groups to build helper locators and weight blending nodes for dynamic joint averaging.

## Use cases

- Automating joint angle and position averaging for rig helpers.
- Driving intermediate twist or deformation joints based on surrounding skeleton positions.
- Setting up symmetric average transformations for limb or torso deformation.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_neck", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "joint1|joint2", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "joint3", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "joint3|joint2", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 3.0, "min": "", "buttonEnabled": false}]]></attr>
<attr name="speed" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 0.03, "min": "", "buttonEnabled": false}]]></attr>
<attr name="yAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="zAxis" template="checkBox" category="Params" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="posDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="negDirection" template="checkBox" category="Params" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
</attributes>
</module>
</children>
</module>