<module name="BipedFingersAverages" muted="0" uid="8bde81c4d3ca49d9ba1fa6bb8511fedf">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds

sides = ["L", "R"]
fingers = ["thumb", "index", "middle", "ring", "pinky"]
startTranformSuffix = "_0_transform"

avgModule = module.child(0)

for side in sides:
    isLeft = rig_utils.naming.isLeftSide(f"{side}_")
    avgModule.attr.negDirection.set(isLeft)
    avgModule.attr.posDirection.set(not isLeft)
    
    for f in fingers:
        joints = cmds.ls(f"{side}_{f}_?_joint") or []
        print(f"{side}_{f}")
        if f != "thumb": # no needed for thumb
            if not cmds.objExists(f"{side}_{f}_1_average_group"):
                avgModule.attr.name.set(f"{side}_{f}_1")
                avgModule.attr.joint1.set(f"{side}_{f}{startTranformSuffix}")
                avgModule.attr.joint2.set(joints[0])
                avgModule.attr.joint3.set(joints[1])
                avgModule.run()
        
        if len(joints) > 2 and not cmds.objExists(f"{side}_{f}_2_average_group"):
            avgModule.attr.name.set(f"{side}_{f}_2")
            avgModule.attr.joint1.set(joints[0])
            avgModule.attr.joint2.set(joints[1])
            avgModule.attr.joint3.set(joints[2])
            avgModule.run()                
            
        if len(joints) > 3 and not cmds.objExists(f"{side}_{f}_3_average_group"):
            avgModule.attr.name.set(f"{side}_{f}_3")
            avgModule.attr.joint1.set(joints[1])
            avgModule.attr.joint2.set(joints[2])
            avgModule.attr.joint3.set(joints[3])
            avgModule.run()
        
    ]]></run>
<doc><![CDATA[## Summary  
The **bipedFingersAverages** module automates the creation of joint‑angle averaging rigs for each finger segment on both hands. It iterates over left and right sides, identifies the joint chain for each finger, and for each valid segment it configures and runs the child **AverageJoints** module to generate an average group, locators, and weighted transform nodes that compute the angle between three joints and drive directional speed attributes.

## Inputs  
- **Joint Naming Convention** – Joints must follow the pattern `side_finger?_joint` (e.g., `L_thumb_1_joint`, `R_pinky_3_joint`).  
- **Child Module (`AverageJoints`)** – The first child module must expose attributes:  
  - `negDirection` (bool) – whether to compute negative direction averages.  
  - `posDirection` (bool) – whether to compute positive direction averages.  
  - `name` (string) – base name for the average group (e.g., `L_thumb_1`).  
  - `joint1`, `joint2`, `joint3` (string) – names of the three joints that define the angle.  
- **`startTranformSuffix`** – Suffix used for the first joint of a finger segment (`_0_transform`).  
- **Scene State** – Existing joints and any previously created average groups are checked to avoid duplication.

## Outputs  
- **Average Groups** – For each finger segment, a transform node named `side_finger_X_average_group` is created (e.g., `L_pinky_2_average_group`).  
- **Locators & Transforms** – Inside each group, the **AverageJoints** module generates:  
  - An origin locator (`*_average_orig_locator`) and an end locator (`*_average_end_locator`).  
  - For each enabled axis/direction pair, a locator (`*_average_pos_y_locator`, `*_average_neg_z_locator`, etc.) and a child transform that receives weighted translation driven by the computed angle.  
- **Custom Attributes** – Each locator receives attributes such as `outWeight`, `outWeightAbs`, `outAngle`, `baseAngle`, `speedInner`, `speedOutter`, and their component sub‑attributes.  
- **Constraint Network** – Point and orient constraints are applied to align the average group with the joint chain.  

## Usage  
1. **Prepare the Joint Chain** – Ensure all finger joints are named according to the `side_finger?_joint` pattern and that the first joint of each segment ends with `_0_transform`.  
2. **Run the Module** – Execute the **bipedFingersAverages** module. It will automatically detect each finger, determine the number of joints, and invoke **AverageJoints** for each valid segment.  
3. **Verify Creation** – In the scene, check that `*_average_group` nodes and their associated locators/transforms exist.  
4. **Adjust Parameters** – If needed, toggle the `posDirection`/`negDirection` and axis checkboxes in the **AverageJoints** child to control which directional averages are generated.  
5. **Use the Averages** – The generated locators expose `outWeight`, `outWeightAbs`, and `outAngle` attributes that can be connected to blendshape drivers, corrective rigs, or other downstream modules for finger deformation or animation blending.]]></doc>
<children>
<module name="AverageJoints" muted="1" uid="aa34933cc99d4d389840950f60ed08be">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds

joint1 = proxy.node(@joint1)
joint2 = proxy.node(@joint2)
joint3 = proxy.node(@joint3)
parent = proxy.node("internal")

def createNode(nodeType, name, parent=None):
    return proxy.create(nodeType, name, parent=parent, suffix=False)

def locator(name):
    return proxy.node(cmds.spaceLocator(name=name)[0])

def makeAngleBetweenRig(name, outPosition1, outPosition2, outPosition3):
    plus12 = createNode("plusMinusAverage", name + "_joint12_plusMinusAverage")
    plus23 = createNode("plusMinusAverage", name + "_joint23_plusMinusAverage")
    
    plus12.operation.set(2) # -
    plus23.operation.set(2) # -
    
    outPosition1 >> plus12.input3D[0]
    outPosition2 >> plus12.input3D[1]
    
    outPosition3 >> plus23.input3D[0]
    outPosition2 >> plus23.input3D[1]
    
    ab = createNode("angleBetween", name + "_angleBetween")
    plus12.output3D >> ab.vector1
    plus23.output3D >> ab.vector2
    
    return ab.angle

grp = createNode("transform", @name + "_average_group")
origLoc = locator(@name + "_average_orig_locator")
endLoc = locator(@name + "_average_end_locator")
origLoc.v.set(0)
endLoc.v.set(0)

parent | grp
grp | origLoc
grp | endLoc

cmds.pointConstraint(str(joint3), str(endLoc))

cmds.matchTransform(str(grp), str(joint2))
cmds.pointConstraint(str(joint2), str(grp))
joint2.s >> grp.s

oc = proxy.node(cmds.parentConstraint(
    str(joint1), str(joint2), str(grp),
    skipTranslate=["x", "y", "z"], maintainOffset=True,
)[0])
oc.interpType.set(2) # shortest

for enabled, n, offset in [(@yAxis, "y", [0,1,0]), (@zAxis, "z", [0,0,1])]:
    if not enabled:
        continue
        
    for enabled, k, coeff in [(@posDirection, "pos", 1), (@negDirection, "neg", -1)]:
        if not enabled:
            continue
            
        name = @name + "_average_%s_%s"%(k, n)
        
        loc1 = locator(name + "_locator")
        grp | loc1
        loc1.t.set([0,0,0])
        loc1.r.set([0,0,0])
        
        loc2 = createNode("transform", name + "_transform", parent=loc1)
        loc2.displayHandle.set(True)
        
        loc1.t.set([coeff*@offset*o for o in offset])
        
        loc1Shape = loc1.getShapes(type="locator")[0]
        origLocShape = origLoc.getShapes(type="locator")[0]
        endLocShape = endLoc.getShapes(type="locator")[0]
        a = makeAngleBetweenRig(
            name,
            loc1Shape.worldPosition[0],
            origLocShape.worldPosition[0],
            endLocShape.worldPosition[0],
        )
        for attrName in ("outWeight", "outWeightAbs", "outAngle", "baseAngle"):
            cmds.addAttr(str(loc1), longName=attrName, defaultValue=0, keyable=True)
        loc1.baseAngle.set(-a.get())
        
        rig_utils.lockTRS(loc1, [], [1,1,1], [1,1,1], 1)
        rig_utils.lockTRS(loc2, [], [1,1,1], [1,1,1], 1)
        
        a >> loc1.outAngle

        add = createNode("addDL", name + "_angle_addDL")
        a >> add.input1
        loc1.baseAngle >> add.input2                      
        add.output >> loc1.outWeight

        multAbs = createNode("multDL", name + "_abs_multDL")
        add.output >> multAbs.input1
        multAbs.input2.set(-1)
                    
        condAbs = createNode("condition", name + "_abs_condition")
        condAbs.operation.set(2) # >
        add.output >> condAbs.firstTerm
        add.output >> condAbs.colorIfTrueR
        multAbs.output >> condAbs.colorIfFalseR
        
        condAbs.outColorR >> loc1.outWeightAbs
        
        # tweaks            
        cmds.addAttr(str(loc1), longName="speedInner", attributeType="double3")
        cmds.addAttr(str(loc1), longName="speedInnerX", attributeType="double", keyable=True, parent="speedInner")
        cmds.addAttr(str(loc1), longName="speedInnerY", attributeType="double", keyable=True, parent="speedInner")
        cmds.addAttr(str(loc1), longName="speedInnerZ", attributeType="double", keyable=True, parent="speedInner")
        loc1.speedInner.set([@speed*o for o in offset])

        cmds.addAttr(str(loc1), longName="speedOutter", attributeType="double3")
        cmds.addAttr(str(loc1), longName="speedOutterX", attributeType="double", keyable=True, parent="speedOutter")
        cmds.addAttr(str(loc1), longName="speedOutterY", attributeType="double", keyable=True, parent="speedOutter")
        cmds.addAttr(str(loc1), longName="speedOutterZ", attributeType="double", keyable=True, parent="speedOutter")
        loc1.speedOutter.set([@speed*o for o in offset])
        
        speedInnerAttr = loc1.speedInner
        speedOutterAttr = loc1.speedOutter
        
        if coeff > 0:
            speedInnerInvert = createNode(
                "multiplyDivide", name + "_speedInner_inverse_multiplyDivide"
            )
            speedInnerAttr >> speedInnerInvert.input1
            speedInnerInvert.input2.set([-1, -1, -1])
            speedInnerAttr = speedInnerInvert.output
                    
        speedInnerMult = createNode("multiplyDivide", name + "_speedInner_multiplyDivide")
        speedInnerAttr >> speedInnerMult.input1
        add.output >> speedInnerMult.input2X
        add.output >> speedInnerMult.input2Y
        add.output >> speedInnerMult.input2Z
        
        if coeff < 0:
            speedOutterInvert = createNode(
                "multiplyDivide", name + "_speedInner_inverse_multiplyDivide"
            )
            speedOutterAttr >> speedOutterInvert.input1
            speedOutterInvert.input2.set([-1, -1, -1])
            speedOutterAttr = speedOutterInvert.output
                        
        speedOutterMult = createNode("multiplyDivide", name + "_speedOutter_multiplyDivide")
        speedOutterAttr >> speedOutterMult.input1
        add.output >> speedOutterMult.input2X
        add.output >> speedOutterMult.input2Y
        add.output >> speedOutterMult.input2Z
                    
        cond = createNode("condition", name + "_speedSelector_condition")
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
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds
averages = proxy.nodes(cmds.ls("*_average_*_locator") or [])
for avg in averages:
    name = str(avg)
    if not ("_pos_" in name or "_neg_" in name):
        continue
        
    if not rig_utils.naming.isLeftSide(name):
        continue
        
    symAvg = rig_utils.naming.findSymmetricName(name)
    if "_pos_" in name:
        symAvg = symAvg.replace("_pos_", "_neg_")
    elif "_neg_" in name:
        symAvg = symAvg.replace("_neg_", "_pos_")
    
    if symAvg != name and cmds.objExists(symAvg):
        print(f"{avg} >> {symAvg}")
        symAvg = proxy.node(symAvg)
        for a in ["t", "speedInner", "speedOutter"]:
            coeff = -1 if a == "t" else 1
            destination = symAvg.attr(a)
            if cmds.getAttr(str(destination), settable=True):
                value = avg.attr(a).get()
                if a == "t":
                    value = tuple(-component for component in value[0])
                else:
                    value *= coeff
                destination.set(value)]]></run>
<doc><![CDATA[## Summary
Mirrors the average locator parameters (`t`, `speedInner`, `speedOutter`) from left‑side rig components to their right‑side counterparts, automatically negating the `t` value for proper mirroring.

## Inputs
- **Left‑side average locators** (`*_average_*_locator`) that contain the attributes:
  - `t` – a numeric value that should be mirrored with a sign flip.
  - `speedInner` – a numeric value copied as‑is.
  - `speedOutter` – a numeric value copied as‑is.
- Naming convention: locators must include `_pos_` or `_neg_` in their names and be identified as left side by `rig_utils.naming.isLeftSide`.

## Outputs
- **Right‑side average locators** (found via `rig_utils.naming.findSymmetricName`) with their `t`, `speedInner`, and `speedOutter` attributes updated to match the left side, where `t` is negated.

## Usage
1. Ensure all average locators are created and named following the pattern `*_average_*_locator` with `_pos_` or `_neg_` suffixes.
2. Run the `mirrorAverageValues` module. It will automatically locate the corresponding right‑side locators and copy the attributes, printing each mirrored pair.
3. Verify that the right‑side locators now hold the mirrored values; they can be used by downstream rig modules that rely on these parameters.]]></doc>
</module>
<module name="updateAverageBaseAngle" muted="0" uid="9b6ba97ecdbf4974997680e52cad5502">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
for loc in proxy.nodes(cmds.ls("*_average_*_locator") or []):
    if loc.hasAttr("outAngle") and cmds.getAttr(str(loc.baseAngle), settable=True):
        loc.baseAngle.set(-loc.outAngle.get())
        print(loc)]]></run>
<doc><![CDATA[## Summary  
The `updateAverageBaseAngle` module scans the Maya scene for all locator objects whose names match the pattern `*_average_*_locator`. For each matching locator, it checks that an `outAngle` attribute exists and that the `baseAngle` attribute is writable. If both conditions are met, it sets `baseAngle` to the negative value of `outAngle` and prints the locator’s name, effectively mirroring the angle value.

## Inputs  
- **Locator Objects (`*_average_*_locator`)**: Any locator node in the scene whose name follows the specified pattern.  
- **`outAngle` Attribute**: A numeric attribute on the locator that holds the angle to be mirrored.  
- **`baseAngle` Attribute**: A writable numeric attribute on the locator that will receive the mirrored value.

## Outputs  
- **Updated `baseAngle`**: For each processed locator, `baseAngle` is set to `-outAngle`.  
- **Console Log**: The name of each locator that was updated is printed to the output console.

## Usage  
1. Ensure that the scene contains locator nodes named with the pattern `*_average_*_locator` and that each has both `outAngle` and writable `baseAngle` attributes.  
2. Run the `updateAverageBaseAngle` module.  
3. Verify that the `baseAngle` values have been updated to the negative of `outAngle` and that the console lists the processed locators.]]></doc>
</module>
</children>
</module>