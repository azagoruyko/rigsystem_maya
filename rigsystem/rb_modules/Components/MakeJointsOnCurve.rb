<module name="makeJointsOnCurve" muted="0" uid="edca6ffb8012413abb1b69a4fbd15f8f">
<run><![CDATA[import pymel.core as pm

crv = pm.PyNode(@curve)

start, end = crv.getKnotDomain()

joints = []
count = @numJoints if not @numAsCVs else crv.numCVs()
    
for i in range(count):
    joints.append( pm.createNode("joint", n=f"{@name}_{i+1}_joint") )

    if not @numAsCVs:
        perc = (i / float(count - 1) * (end - start) + start) if count > 1 else start
        p = crv.getPointAtParam(perc)
        joints[i].setTranslation(p)
    else:
        joints[i].setTranslation(crv.cv[i].getPosition("world"))

    if i > 0:
        joints[i-1] | joints[i]

# reorient
pm.joint(joints[0], e=True, zso=True, oj="xyz", sao="yup", ch=True)

if not @makeConnected:
    for i in range(1, len(joints)):
        pm.parent(joints[i], world=True)

if @attach:
    crv_shape = crv.getShape() if crv.type() == "transform" else crv
    for i in range(count):
        poci = pm.createNode("pointOnCurveInfo", n=joints[i]+"_pointOnCurveInfo")
        crv_shape.worldSpace[0] >> poci.inputCurve
        
        if not @numAsCVs:
            perc = (i / float(count - 1) * (end - start) + start) if count > 1 else start
            poci.parameter.set(perc)
        else:
            cl = crv.closestPoint(crv.cv[i].getPosition("world"))
            param = crv.getParamAtPoint(cl)
            poci.parameter.set(param)
        poci.position >> joints[i].translate

@set_out_joints([j.name() for j in joints])
]]></run>
<doc><![CDATA[## Summary  
Creates a joint chain positioned along a specified Maya curve. The joint count can be set manually or derived from the curve’s CVs, joints can be left connected or unparented, and optional `pointOnCurveInfo` nodes can be generated to keep the joints dynamically attached to the curve.

## Inputs  
- **`name`** – Base name for the created joints (e.g., `L_eyelash_upper_fold`).  
- **`curve`** – The transform or shape node of the curve to follow.  
- **`numJoints`** – Desired number of joints when `numAsCVs` is unchecked.  
- **`numAsCVs`** – If checked, the joint count equals the curve’s number of CVs.  
- **`makeConnected`** – When unchecked, each joint is unparented from the chain after creation.  
- **`attach`** – When checked, a `pointOnCurveInfo` node is created for each joint to drive its translation along the curve.

## Outputs  
- **Joint chain** – Nodes named `{name}_{i}_joint` (i = 0 … count‑1) forming a hierarchy.  
- **`pointOnCurveInfo` nodes** – For each joint, a node named `{joint}_pointOnCurveInfo` that drives the joint’s translation when `attach` is enabled.  
- **Optional unparented joints** – If `makeConnected` is false, the joints are left in world space.

## Usage  
1. Select the curve you want the joints to follow.  
2. Set the **`name`** field to the desired joint prefix.  
3. Choose **`numAsCVs`** if you want the joint count to match the curve’s CVs; otherwise set **`numJoints`**.  
4. Toggle **`makeConnected`** to keep the joints chained or unparent them.  
5. Toggle **`attach`** to create `pointOnCurveInfo` nodes that keep the joints on the curve.  
6. Run the module. The joint chain and any `pointOnCurveInfo` nodes will appear in the scene, ready for further rigging steps.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_belt_waist_vert", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "polyToCurve1", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="numJoints" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 4, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="numAsCVs" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="makeConnected" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["M_belt_waist_vert_0_joint", "M_belt_waist_vert_1_joint", "M_belt_waist_vert_2_joint", "M_belt_waist_vert_3_joint"], "default": "items"}]]></attr>
</attributes>
</module>