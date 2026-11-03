<module name="Lips" muted="0" uid="b5078682064a44b28b222e0a723b8bb1">
<doc><![CDATA[## Summary
Fits the face_lips template to upper and lower edge curves, then runs the existing lip build stages.

## Inputs
- upper_curve, lower_curve: open degree-1 lip edge curves sharing both corner endpoints.

## Outputs
Updates the wire and tuner curves, positions the lip tuners, and creates the existing lip rig outputs.

## Usage
Import face_lips, set the upper and lower curves, then run Lips. FitCurves executes first.]]></doc>
<attributes>
<attr name="importTemplate" template="button" category="General" connect=""><![CDATA[{"command": "import os\nimport maya.cmds as cmds\n\ntemplatePath = os.path.join(\n    os.environ[\"RIGSYSTEM_PATH\"],\n    \"library\",\n    \"face_lips.ma\",\n)\ncmds.file(\n    templatePath,\n    i=True,\n    ignoreVersion=True,\n    namespace=\":\",\n    mergeNamespacesOnClash=False,\n)", "label": "Import face_lips", "color": "", "default": "command"}]]></attr>
<attr name="upper_curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "upper_curve", "placeholder": "Open degree-1 lip edge curve", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="lower_curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_curve", "placeholder": "Open degree-1 lip edge curve", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="FitCurves" muted="0" uid="">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

WIRE_CURVE = "lip_{lid}_curve"
TUNER_CURVE = "lip_{lid}_tuner_curve"
CORNER_TUNERS = {
    "L": "L_lips_corner_tuner",
    "R": "R_lips_corner_tuner",
}
MAIN_TUNERS = {
    "upper": "lip_upper_tuner",
    "lower": "lip_lower_tuner",
}


def copyGeometry(source, target):
    """Bake source world geometry into the existing target shape's local space."""
    geometry = proxy.create("transformGeometry")
    try:
        source.worldSpace[0] >> geometry.inputGeometry
        geometry.transform.set(target.worldInverseMatrix[0].get())
        geometry.outputGeometry.connect(target.create, force=True)
        target.spans.get()
        geometry.outputGeometry.disconnect(target.create)
    finally:
        cmds.delete(geometry)


sources = {}
points = {}
for lid, name in [("upper", ch("../upper_curve")), ("lower", ch("../lower_curve"))]:
    curve = proxy.node(name)
    shape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
    fn = shape.mfn(shape=True)
    if fn.degree != 1 or fn.form != om.MFnNurbsCurve.kOpen:
        raise ValueError(f"{lid}_curve must be an open degree-1 curve.")

    sources[lid] = shape
    start, end = fn.knotDomain
    corners = [
        fn.getPointAtParam(start, om.MSpace.kWorld),
        fn.getPointAtParam(end, om.MSpace.kWorld),
    ]
    corners.sort(key=lambda point: point.x)
    points[lid] = {
        "R": corners[0],
        "L": corners[1],
        "main": fn.getPointAtParam(start + 0.5 * (end - start), om.MSpace.kWorld),
    }

for side in "LR":
    if points["upper"][side].distanceTo(points["lower"][side]) > 1e-4:
        raise ValueError(f"upper_curve and lower_curve must meet at the {side} corner.")

wireOriginals = {
    lid: next(
        shape
        for shape in proxy.node(WIRE_CURVE.format(lid=lid)).getShapes(
            type="nurbsCurve", noIntermediate=False
        )
        if shape.intermediateObject.get()
    )
    for lid in ("upper", "lower")
}
tunerCurves = {
    lid: proxy.node(TUNER_CURVE.format(lid=lid)).getShapes(type="nurbsCurve")[0]
    for lid in ("upper", "lower")
}
cornerTuners = {side: proxy.node(name) for side, name in CORNER_TUNERS.items()}
mainTuners = {lid: proxy.node(name) for lid, name in MAIN_TUNERS.items()}

for side, tuner in cornerTuners.items():
    point = points["upper"][side]
    cmds.xform(tuner, worldSpace=True, translation=(point.x, point.y, point.z))

for lid, tuner in mainTuners.items():
    point = points[lid]["main"]
    cmds.xform(tuner, worldSpace=True, translation=(point.x, point.y, point.z))

temporary = []
try:
    for lid in ("upper", "lower"):
        fn = sources[lid].mfn(shape=True)
        cvs = fn.cvPositions(om.MSpace.kWorld)
        duplicate = proxy.node(cmds.curve(
            point=[(point.x, point.y, point.z) for point in cvs],
            degree=1,
            knot=list(fn.knots()),
        ))
        temporary.append(duplicate)

        if cvs[0].x < cvs[-1].x:
            cmds.reverseCurve(
                duplicate,
                constructionHistory=False,
                replaceOriginal=True,
            )

        shape = duplicate.getShapes(type="nurbsCurve")[0]
        copyGeometry(shape, wireOriginals[lid])

        cmds.rebuildCurve(
            duplicate,
            constructionHistory=False,
            replaceOriginal=True,
            rebuildType=0,
            endKnots=1,
            keepRange=0,
            keepControlPoints=False,
            keepEndPoints=True,
            keepTangents=False,
            spans=6,
            degree=3,
            tolerance=0.01,
        )
        shape = duplicate.getShapes(type="nurbsCurve")[0]
        copyGeometry(shape, tunerCurves[lid])
finally:
    if temporary:
        cmds.delete(temporary)

bindMode = module.child("BindMode")
joints = set()
for lid in ("upper", "lower"):
    mainCurve = proxy.node(f"lip_{lid}_main_curve")
    shape = mainCurve.getShapes(type="nurbsCurve")[0]

    for skin in shape.inputs(type="skinCluster"):
        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])

bindMode.attr.joints = sorted(joints)
bindMode.attr.mode = 0
bindMode.run()
bindMode.attr.mode = 1
bindMode.run()
]]></run>
<doc><![CDATA[## Summary
Fits the face_lips tuner curves and locator tuners to two degree-1 lip edge curves.

## Inputs
- Parent `upper_curve` and `lower_curve`: open degree-1 curves that share their L/R corner endpoints.

## Outputs
Copies the degree-1 inputs into the upper/lower wire curve Origs. Rebuilds each input to six spans and copies it into the corresponding tuner curve. Positions the L/R corner tuners at the curve ends and the upper/lower main tuners at normalized parameter 0.5.

## Usage
Import face_lips, set the two parent inputs, then run Lips. Input direction may be reversed; wire geometry is normalized from L to R.]]></doc>
<children>
<module name="BindMode" muted="1" uid="c7ae99e054f94721afc9256cf449e180">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
joints = proxy.nodes(@joints)


def getJointsSkinClusters(joint):
    return {plug.node for plug in joint.worldMatrix.outputs(type="skinCluster")}


def influenceIndex(skin, joint):
    return skin.mfn().indexForInfluenceObject(joint.mdagpath)


if @mode == 0:
    for joint in joints:
        for skin in getJointsSkinClusters(joint):
            index = influenceIndex(skin, joint)
            preMatrix = skin.bindPreMatrix[index]
            if not preMatrix.inputs():
                joint.worldInverseMatrix[0] >> preMatrix

    print("Unbinded")
    @set_mode("Unbinded")
else:
    for joint in joints:
        for skin in getJointsSkinClusters(joint):
            index = influenceIndex(skin, joint)
            matrix = joint.worldInverseMatrix[0].get()

            if cmds.isConnected(
                str(joint.worldInverseMatrix[0]),
                str(skin.bindPreMatrix[index]),
            ):
                cmds.disconnectAttr(
                    str(joint.worldInverseMatrix[0]),
                    str(skin.bindPreMatrix[index]),
                )
                skin.bindPreMatrix[index].set(matrix)

    print("Binded")
    @set_mode("")
]]></run>
<doc><![CDATA[Temporarily unbinds and rebinds the lip main-curve skin influences so their bind pre-matrices match the fitted curves.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": "", "columns": 3, "default": "current"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_lips_corner_main_joint", "M_lip_lower_main_joint", "M_lip_upper_main_joint", "R_lips_corner_main_joint"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>
<module name="makeUpperJoints" muted="0" uid="edca6ffb8012413abb1b69a4fbd15f8f">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds
crv = proxy.node(@curve)
crvShape = crv.getShapes(type="nurbsCurve")[0] if crv.type() == "transform" else crv
curveFn = crvShape.mfn(shape=True)

start, end = curveFn.knotDomain

joints = []
count = @numJoints if not @numAsCVs else curveFn.numCVs
    
for i in range(count):
    joint = proxy.create("joint", f"{@name}_{i + 1}", skipSelection=True)
    joints.append(joint)

    if not @numAsCVs:
        perc = (i / float(count - 1) * (end - start) + start) if count > 1 else start
        p = curveFn.getPointAtParam(perc, om.MSpace.kWorld)
    else:
        p = curveFn.cvPositions(om.MSpace.kWorld)[i]
    cmds.xform(joint, ws=True, t=(p.x, p.y, p.z))

    if i > 0:
        joints[i - 1] | joint

# reorient
cmds.joint(joints[0], e=True, zso=True, oj="xyz", sao="yup", ch=True)

if not @makeConnected:
    for i in range(1, len(joints)):
        cmds.parent(joints[i], world=True)

if @attach:
    for i in range(count):
        poci = proxy.create("pointOnCurveInfo", joints[i].localName())
        crvShape.worldSpace[0] >> poci.inputCurve
        
        if not @numAsCVs:
            perc = (i / float(count - 1) * (end - start) + start) if count > 1 else start
            poci.parameter.set(perc)
        else:
            param = curveFn.closestPoint(curveFn.cvPositions(om.MSpace.kWorld)[i], space=om.MSpace.kWorld)[1]
            poci.parameter.set(param)
        poci.position >> joints[i].translate

@set_out_joints([str(j) for j in joints])
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
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_lips_upper", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "upper_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="numJoints" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 10, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="numAsCVs" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="makeConnected" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["M_lips_upper_1_joint", "M_lips_upper_2_joint", "M_lips_upper_3_joint", "M_lips_upper_4_joint", "M_lips_upper_5_joint", "M_lips_upper_6_joint", "M_lips_upper_7_joint", "M_lips_upper_8_joint", "M_lips_upper_9_joint", "M_lips_upper_10_joint", "M_lips_upper_11_joint", "M_lips_upper_12_joint", "M_lips_upper_13_joint", "M_lips_upper_14_joint", "M_lips_upper_15_joint", "M_lips_upper_16_joint", "M_lips_upper_17_joint", "M_lips_upper_18_joint", "M_lips_upper_19_joint"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="makeLowerJoints" muted="0" uid="edca6ffb8012413abb1b69a4fbd15f8f">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds
crv = proxy.node(@curve)
crvShape = crv.getShapes(type="nurbsCurve")[0] if crv.type() == "transform" else crv
curveFn = crvShape.mfn(shape=True)

start, end = curveFn.knotDomain

joints = []
count = @numJoints if not @numAsCVs else curveFn.numCVs
    
for i in range(count):
    joint = proxy.create("joint", f"{@name}_{i + 1}", skipSelection=True)
    joints.append(joint)

    if not @numAsCVs:
        perc = (i / float(count - 1) * (end - start) + start) if count > 1 else start
        p = curveFn.getPointAtParam(perc, om.MSpace.kWorld)
    else:
        p = curveFn.cvPositions(om.MSpace.kWorld)[i]
    cmds.xform(joint, ws=True, t=(p.x, p.y, p.z))

    if i > 0:
        joints[i - 1] | joint

# reorient
cmds.joint(joints[0], e=True, zso=True, oj="xyz", sao="yup", ch=True)

if not @makeConnected:
    for i in range(1, len(joints)):
        cmds.parent(joints[i], world=True)

if @attach:
    for i in range(count):
        poci = proxy.create("pointOnCurveInfo", joints[i].localName())
        crvShape.worldSpace[0] >> poci.inputCurve
        
        if not @numAsCVs:
            perc = (i / float(count - 1) * (end - start) + start) if count > 1 else start
            poci.parameter.set(perc)
        else:
            param = curveFn.closestPoint(curveFn.cvPositions(om.MSpace.kWorld)[i], space=om.MSpace.kWorld)[1]
            poci.parameter.set(param)
        poci.position >> joints[i].translate

@set_out_joints([str(j) for j in joints])
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
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_lips_lower", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="numJoints" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 10, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="numAsCVs" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="makeConnected" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["M_lips_lower_1_joint", "M_lips_lower_2_joint", "M_lips_lower_3_joint", "M_lips_lower_4_joint", "M_lips_lower_5_joint", "M_lips_lower_6_joint", "M_lips_lower_7_joint", "M_lips_lower_8_joint", "M_lips_lower_9_joint", "M_lips_lower_10_joint", "M_lips_lower_11_joint", "M_lips_lower_12_joint", "M_lips_lower_13_joint", "M_lips_lower_14_joint", "M_lips_lower_15_joint", "M_lips_lower_16_joint", "M_lips_lower_17_joint", "M_lips_lower_18_joint", "M_lips_lower_19_joint"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="sortJoints" muted="0" uid="">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds


def sortJoints(jointNames, lid):
    joints = proxy.nodes(jointNames)
    if not joints:
        error(f"No {lid} lip joints to sort")

    records = [
        (joint, cmds.xform(joint, query=True, worldSpace=True, translation=True)[0])
        for joint in joints
    ]
    center, centerX = min(records, key=lambda record: abs(record[1]))
    left = sorted(
        (record for record in records if record[0] != center and record[1] > 0.0),
        key=lambda record: record[1],
    )
    right = sorted(
        (record for record in records if record[0] != center and record[1] <= 0.0),
        key=lambda record: record[1],
        reverse=True,
    )

    for index, joint in enumerate(joints):
        joint.rename(f"__lip_{lid}_sort_{index}_joint")

    center.rename(f"M_lip_{lid}_joint")
    for index, (joint, positionX) in enumerate(left, start=1):
        joint.rename(f"L_lip_{lid}_{index}_joint")
    for index, (joint, positionX) in enumerate(right, start=1):
        joint.rename(f"R_lip_{lid}_{index}_joint")

    return [
        str(joint)
        for joint, positionX in sorted(records, key=lambda record: record[1], reverse=True)
    ]


@set_out_upper_joints(sortJoints(ch("../makeUpperJoints/out_joints"), "upper"))
@set_out_lower_joints(sortJoints(ch("../makeLowerJoints/out_joints"), "lower"))
]]></run>
<doc><![CDATA[## Summary
Sorts the generated upper and lower lip joints by world X and renames them for skin mirroring.

The joint nearest X=0 becomes `M_lip_<lid>_joint`. Positive-X joints become `L_` and negative-X joints become `R_`; side indices increase from the center toward the corner. Outputs remain ordered from maximum X to minimum X.]]></doc>
<attributes>
<attr name="out_upper_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["L_lip_upper_9_joint", "L_lip_upper_8_joint", "L_lip_upper_7_joint", "L_lip_upper_6_joint", "L_lip_upper_5_joint", "L_lip_upper_4_joint", "L_lip_upper_3_joint", "L_lip_upper_2_joint", "L_lip_upper_1_joint", "M_lip_upper_joint", "R_lip_upper_1_joint", "R_lip_upper_2_joint", "R_lip_upper_3_joint", "R_lip_upper_4_joint", "R_lip_upper_5_joint", "R_lip_upper_6_joint", "R_lip_upper_7_joint", "R_lip_upper_8_joint", "R_lip_upper_9_joint"], "default": "items"}]]></attr>
<attr name="out_lower_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["L_lip_lower_9_joint", "L_lip_lower_8_joint", "L_lip_lower_7_joint", "L_lip_lower_6_joint", "L_lip_lower_5_joint", "L_lip_lower_4_joint", "L_lip_lower_3_joint", "L_lip_lower_2_joint", "L_lip_lower_1_joint", "M_lip_lower_joint", "R_lip_lower_1_joint", "R_lip_lower_2_joint", "R_lip_lower_3_joint", "R_lip_lower_4_joint", "R_lip_lower_5_joint", "R_lip_lower_6_joint", "R_lip_lower_7_joint", "R_lip_lower_8_joint", "R_lip_lower_9_joint"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="upper_connectLipScale" muted="0" uid="">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds
control = proxy.node(@control)
controlPos = om.MVector(cmds.xform(control, q=True, ws=True, t=True))

maxDist = 0.0001
for j in proxy.nodes(@joints):
    pos = om.MVector(cmds.xform(j, q=True, ws=True, t=True))
    d = (controlPos - pos).length()
    if d > maxDist:
        maxDist = d

for j in proxy.nodes(@joints):
    pos = om.MVector(cmds.xform(j, q=True, ws=True, t=True))
    perc = (controlPos - pos).length() / maxDist
    _, blender = curve_evaluate(@profile_data, perc)
    
    b2a = proxy.create("blendTwoAttr", f"{j}_{@scaleAttr}")
    b2a.input[0].set(1)
    control.attr(@scaleAttr) >> b2a.input[1]
    b2a.attributesBlender.set(blender)
    
    b2a.output >> j.attr(@scaleAttr)]]></run>
<attributes>
<attr name="control" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_lip_upper_main_control", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joints" template="listBox" category="General" connect="/sortJoints/out_upper_joints"><![CDATA[{"items": ["L_lip_upper_9_joint", "L_lip_upper_8_joint", "L_lip_upper_7_joint", "L_lip_upper_6_joint", "L_lip_upper_5_joint", "L_lip_upper_4_joint", "L_lip_upper_3_joint", "L_lip_upper_2_joint", "L_lip_upper_1_joint", "M_lip_upper_joint", "R_lip_upper_1_joint", "R_lip_upper_2_joint", "R_lip_upper_3_joint", "R_lip_upper_4_joint", "R_lip_upper_5_joint", "R_lip_upper_6_joint", "R_lip_upper_7_joint", "R_lip_upper_8_joint", "R_lip_upper_9_joint"], "default": "items"}]]></attr>
<attr name="profile" template="curve" category="General" connect=""><![CDATA[{"cvs": [[0.0, 1.0], [0.2691092287517815, 0.9569240154374594], [0.539858712281016, 0.9356695107272315], [0.8084760766308507, 0.8705882352941176], [0.8611437115103058, 0.8578277912316241], [0.9283072946896116, 0.8594206592095875], [0.9669934640522875, 0.7656862745098042], [0.9750487093507333, 0.7461688739996332], [0.9980505571824403, 0.24817055568975568], [1.0, 0.2156862745098039]], "default": "cvs"}]]></attr>
<attr name="scaleAttr" template="comboBox" category="General" connect=""><![CDATA[{"items": ["sx", "sy", "sz"], "current": "sy", "default": "current"}]]></attr>
</attributes>
</module>
<module name="lower_connectLipScale" muted="0" uid="">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds
control = proxy.node(@control)
controlPos = om.MVector(cmds.xform(control, q=True, ws=True, t=True))

maxDist = 0.0001
for j in proxy.nodes(@joints):
    pos = om.MVector(cmds.xform(j, q=True, ws=True, t=True))
    d = (controlPos - pos).length()
    if d > maxDist:
        maxDist = d

for j in proxy.nodes(@joints):
    pos = om.MVector(cmds.xform(j, q=True, ws=True, t=True))
    perc = (controlPos - pos).length() / maxDist
    _, blender = curve_evaluate(@profile_data, perc)
    
    b2a = proxy.create("blendTwoAttr", f"{j}_{@scaleAttr}")
    b2a.input[0].set(1)
    control.attr(@scaleAttr) >> b2a.input[1]
    b2a.attributesBlender.set(blender)
    
    b2a.output >> j.attr(@scaleAttr)]]></run>
<attributes>
<attr name="control" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_lip_lower_main_control", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joints" template="listBox" category="General" connect="/sortJoints/out_lower_joints"><![CDATA[{"items": ["L_lip_lower_9_joint", "L_lip_lower_8_joint", "L_lip_lower_7_joint", "L_lip_lower_6_joint", "L_lip_lower_5_joint", "L_lip_lower_4_joint", "L_lip_lower_3_joint", "L_lip_lower_2_joint", "L_lip_lower_1_joint", "M_lip_lower_joint", "R_lip_lower_1_joint", "R_lip_lower_2_joint", "R_lip_lower_3_joint", "R_lip_lower_4_joint", "R_lip_lower_5_joint", "R_lip_lower_6_joint", "R_lip_lower_7_joint", "R_lip_lower_8_joint", "R_lip_lower_9_joint"], "default": "items"}]]></attr>
<attr name="profile" template="curve" category="General" connect="/upper_connectLipScale/profile"><![CDATA[{"cvs": [[0.0, 1.0], [0.2691092287517815, 0.9569240154374594], [0.539858712281016, 0.9356695107272315], [0.8084760766308507, 0.8705882352941176], [0.8611437115103058, 0.8578277912316241], [0.9283072946896116, 0.8594206592095875], [0.9669934640522875, 0.7656862745098042], [0.9750487093507333, 0.7461688739996332], [0.9980505571824403, 0.24817055568975568], [1.0, 0.2156862745098039]], "default": "cvs"}]]></attr>
<attr name="scaleAttr" template="comboBox" category="General" connect="/upper_connectLipScale/scaleAttr"><![CDATA[{"items": ["sx", "sy", "sz"], "current": "sy", "default": "current"}]]></attr>
</attributes>
</module>
<module name="LipsZip" muted="0" uid="f79ad52fcfbe438484e0ed8c6504bd0a">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy, rig_utils

cmds = proxy.cmds

seal = proxy.node("M_lips_control").seal
l_zip = proxy.node("L_lips_corner_main_control").zip
r_zip = proxy.node("R_lips_corner_main_control").zip
l_falloff = proxy.node("L_lips_corner_main_control").zipFalloff
r_falloff = proxy.node("R_lips_corner_main_control").zipFalloff

firstRemap = None

if len(@upperJoints) != len(@lowerJoints):
    error("lowerJoints must have the same size as upperJoints")

attachToCurveMod = module.child("AttachToCurve")

upperCurve = proxy.node(@upperCurve)
lowerCurve = proxy.node(@lowerCurve)

avgCurve = proxy.node(cmds.duplicate(upperCurve, name="lips_avg_curve")[0])

cmds.blendShape(
    [upperCurve, lowerCurve],
    avgCurve,
    w=[(0, 0.5), (1, 0.5)],
    name="lips_avg_blendShape",
)

transforms = proxy.create("transform", "lips_transforms", suffix=False)
rig_utils.lockTRS(transforms)

zip_transforms = []
upper_out_transforms = []
lower_out_transforms = []

for i, (uj, lj) in enumerate(zip(proxy.nodes(@upperJoints), proxy.nodes(@lowerJoints))):
    zipt = proxy.create("transform", f"lips_zip_{i+1}", parent=transforms)
    p = avgCurve.mfn(shape=True).cvPositions(om.MSpace.kWorld)[i]
    cmds.xform(zipt, ws=True, t=(p.x, p.y, p.z))
    
    zip_transforms.append(zipt)
    
    upper_offset = proxy.create("transform", f"{uj}_zip_offset", parent=zipt)
    cmds.matchTransform(upper_offset, uj, position=True, rotation=False)
    rig_utils.lockTRS(upper_offset)

    lower_offset = proxy.create("transform", f"{lj}_zip_offset", parent=zipt)
    cmds.matchTransform(lower_offset, lj, position=True, rotation=False)
    rig_utils.lockTRS(lower_offset)
    
    ut = proxy.create("transform", f"{uj}_out", parent=transforms)
    cmds.matchTransform(ut, uj, position=True, rotation=False)
    upper_out_transforms.append(ut)
    
    lt = proxy.create("transform", f"{lj}_out", parent=transforms)
    cmds.matchTransform(lt, lj, position=True, rotation=False)
    lower_out_transforms.append(lt)
    
    # zip
    pc = proxy.node(cmds.pointConstraint(ut, upper_offset, uj)[0])
    param = float(i) / (len(@upperJoints)-1)

    # l
    l_add = proxy.create("addDL", f"lips_zip_l_{i+1}")
    l_add.input1.set(param*10)
    l_falloff >> l_add.input2
    
    l_falloff_clamp = proxy.create("clamp", f"lips_zip_l_{i+1}_falloff")
    l_falloff_clamp.maxR.set(10)
    l_add.output >> l_falloff_clamp.inputR    
    
    l_remap = proxy.create("remapValue", f"lips_zip_l_{i+1}")
    l_remap.inputMin.set(param*10)
    l_falloff_clamp.outputR >> l_remap.inputMax
    l_zip >> l_remap.inputValue
    
    if firstRemap is None:
        firstRemap = l_remap
    else:
        firstRemap.value >> l_remap.value        
   
    # r 
    r_add = proxy.create("addDL", f"lips_zip_r_{i+1}")
    r_add.input1.set(10-param * 10)
    r_falloff >> r_add.input2    
    
    r_falloff_clamp = proxy.create("clamp", f"lips_zip_r_{i+1}_falloff")
    r_falloff_clamp.maxR.set(10)
    r_add.output >> r_falloff_clamp.inputR    
        
    r_remap = proxy.create("remapValue", f"lips_zip_r_{i+1}")
    r_remap.inputMin.set(10-param*10)
    r_falloff_clamp.outputR >> r_remap.inputMax
    r_zip >> r_remap.inputValue
    firstRemap.value >> r_remap.value
    
    plus = proxy.create("plusMinusAverage", f"lips_zip_{i+1}")
    l_remap.outValue >> plus.input1D[0]
    r_remap.outValue >> plus.input1D[1]
    seal >> plus.input1D[2]
    
    clamp = proxy.create("clamp", f"lips_zip_{i+1}")
    clamp.maxR.set(1)
    plus.output1D >> clamp.inputR
    
    rev = proxy.create("reverse", f"lips_zip_{i+1}")
    clamp.outputR >> rev.inputX    
    
    rev.outputX >> pc.w0
    clamp.outputR >> pc.w1
    
    # lower
    pc = proxy.node(cmds.pointConstraint(lt, lower_offset, lj)[0])
    rev.outputX >> pc.w0
    clamp.outputR >> pc.w1
    
    cmds.orientConstraint("M_lip_upper_main_control_transform", "M_lip_upper_main_control", uj, mo=True)
    cmds.orientConstraint("M_lip_lower_main_control_transform", "M_lip_lower_main_control", lj, mo=True)
    
attachToCurveMod.attr.curve = str(avgCurve)
attachToCurveMod.attr.transforms = [str(t) for t in zip_transforms]
attachToCurveMod.run()

attachToCurveMod.attr.curve = @upperCurve
attachToCurveMod.attr.transforms = [str(t) for t in upper_out_transforms]
attachToCurveMod.run()

attachToCurveMod.attr.curve = @lowerCurve
attachToCurveMod.attr.transforms = [str(t) for t in lower_out_transforms]
attachToCurveMod.run()

]]></run>
<doc><![CDATA[## Summary  
Creates a lip‑zip rig system that averages an upper and lower lip curve, generates zip transforms for each joint pair, and snaps these transforms to the average curve and the individual upper/lower curves. The module drives the zip logic using existing control attributes (`seal`, `l_zip`, `r_zip`, `l_falloff`, `r_falloff`) and sets up constraints and helper nodes for animation.

## Inputs  
- **`upperJoints`** – List of joint names that form the upper lip chain.  
- **`lowerJoints`** – List of joint names that form the lower lip chain (must match the length of `upperJoints`).  
- **`upperCurve`** – NURBS curve node representing the upper lip shape.  
- **`lowerCurve`** – NURBS curve node representing the lower lip shape.  
- **Scene nodes** – The module expects the following nodes to exist in the scene:  
  - `M_lips_control` (provides the `seal` attribute)  
  - `L_lips_corner_main_control` (provides `zip` and `zipFalloff`)  
  - `R_lips_corner_main_control` (provides `zip` and `zipFalloff`)  

## Outputs  
- **`lips_transforms`** – A transform group containing all generated helper transforms.  
- **`lips_zip_*_transform`** – One transform per joint pair that drives the zip logic.  
- **`*_out_transform`** – Upper and lower output transforms that follow the original joint positions.  
- **`lips_avg_curve`** – Duplicate of the upper curve blended with the lower curve (50/50).  
- **`lips_avg_blendShape`** – BlendShape node that blends the two input curves into the average curve.  
- **Attachment nodes** – Each transform is snapped to the appropriate curve using the `AttachToCurve` child module, creating `pointOnCurveInfo` connections that keep the transforms on the curves during animation.

## Usage  
1. **Prepare the scene** – Ensure the required control nodes (`M_lips_control`, `L_lips_corner_main_control`, `R_lips_corner_main_control`) exist and contain the `seal`, `zip`, and `zipFalloff` attributes.  
2. **Set module attributes** –  
   - Assign the list of upper lip joints to `upperJoints`.  
   - Assign the list of lower lip joints to `lowerJoints`.  
   - Assign the upper lip curve node to `upperCurve`.  
   - Assign the lower lip curve node to `lowerCurve`.  
3. **Run the module** – Execute the module. It will create the average curve, zip transforms, and attach them to the curves.  
4. **Verify** – In the viewport, the zip transforms should sit along the average curve, while the upper and lower output transforms follow their respective joint chains.  
5. **Connect downstream** – Use the created transforms or the average curve as needed for further rigging steps (e.g., attaching facial controls or driving blend shapes).]]></doc>
<attributes>
<attr name="upperCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_upper_curve", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="lowerCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_lower_curve", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="upperJoints" template="listBox" category="General" connect="/sortJoints/out_upper_joints"><![CDATA[{"items": ["L_lip_upper_9_joint", "L_lip_upper_8_joint", "L_lip_upper_7_joint", "L_lip_upper_6_joint", "L_lip_upper_5_joint", "L_lip_upper_4_joint", "L_lip_upper_3_joint", "L_lip_upper_2_joint", "L_lip_upper_1_joint", "M_lip_upper_joint", "R_lip_upper_1_joint", "R_lip_upper_2_joint", "R_lip_upper_3_joint", "R_lip_upper_4_joint", "R_lip_upper_5_joint", "R_lip_upper_6_joint", "R_lip_upper_7_joint", "R_lip_upper_8_joint", "R_lip_upper_9_joint"], "default": "items"}]]></attr>
<attr name="lowerJoints" template="listBox" category="General" connect="/sortJoints/out_lower_joints"><![CDATA[{"items": ["L_lip_lower_9_joint", "L_lip_lower_8_joint", "L_lip_lower_7_joint", "L_lip_lower_6_joint", "L_lip_lower_5_joint", "L_lip_lower_4_joint", "L_lip_lower_3_joint", "L_lip_lower_2_joint", "L_lip_lower_1_joint", "M_lip_lower_joint", "R_lip_lower_1_joint", "R_lip_lower_2_joint", "R_lip_lower_3_joint", "R_lip_lower_4_joint", "R_lip_lower_5_joint", "R_lip_lower_6_joint", "R_lip_lower_7_joint", "R_lip_lower_8_joint", "R_lip_lower_9_joint"], "default": "items"}]]></attr>
</attributes>
<children>
<module name="AttachToCurve" muted="1" uid="b79ce70fe8fc4009a31219c30b5eb506">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

curve = proxy.node(@curve)
transforms = proxy.nodes(@transforms)

curveShape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
curveFn = curveShape.mfn(shape=True)

for t in transforms:
    position = cmds.xform(str(t), q=True, ws=True, t=True)
    position = om.MPoint(position[0], position[1], position[2])
    _, param = curveFn.closestPoint(position, 1e-6, om.MSpace.kWorld)

    # Create pointOnCurveInfo to drive position
    poci = proxy.create(
        "pointOnCurveInfo", f"{t}"
    )
    curveShape.worldSpace[0] >> poci.inputCurve
    poci.parameter.set(param)
    poci.turnOnPercentage.set(False)
    
    pmm = proxy.create(
        "pointMatrixMultDL", f"{t}_parentInverse"
    )
    poci.position >> pmm.inPoint
    t.parentInverseMatrix >> pmm.inMatrix    
    pmm.output >> t.translate
    ]]></run>
<doc><![CDATA[## Summary  
The **attachToCurve** module snaps a list of transforms to a NURBS curve by projecting each transform’s world position onto the curve. It uses a `nearestPointOnCurve` node to find the closest curve parameter and a `pointOnCurveInfo` node to drive the transform’s translate, leaving rotation and scale untouched.

## Inputs  
- **`curve`** – Name or reference to the NURBS curve that will serve as the attachment surface.  
- **`transforms`** – List of transform nodes whose world positions will be projected onto the curve.  

## Outputs  
- No explicit output nodes are created.  
- The module directly modifies the **translate** attributes of each transform in the `transforms` list, aligning them to the nearest point on the specified curve.

## Usage  
1. **Select the curve** you want to attach to and set the `curve` attribute (or use the button to pick the selected curve).  
2. **Populate the `transforms` list** with the transforms you wish to snap (e.g., IK handles, control joints, helper objects).  
3. **Run the module**. Each transform’s translate will be driven by a `pointOnCurveInfo` node that follows the curve’s shape.  
4. **Optional**: After execution, the temporary `nearestPointOnCurve` node is automatically deleted, leaving only the `pointOnCurveInfo` nodes connected to the transforms.  
5. **Adjust** the transforms in the viewport if needed; the connections will keep them attached to the curve as you move the curve or the transforms.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS curve</b> using closest point (translate only)."}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_lower_curve", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_lip_lower_9_joint_out_transform", "L_lip_lower_8_joint_out_transform", "L_lip_lower_7_joint_out_transform", "L_lip_lower_6_joint_out_transform", "L_lip_lower_5_joint_out_transform", "L_lip_lower_4_joint_out_transform", "L_lip_lower_3_joint_out_transform", "L_lip_lower_2_joint_out_transform", "L_lip_lower_1_joint_out_transform", "M_lip_lower_joint_out_transform", "R_lip_lower_1_joint_out_transform", "R_lip_lower_2_joint_out_transform", "R_lip_lower_3_joint_out_transform", "R_lip_lower_4_joint_out_transform", "R_lip_lower_5_joint_out_transform", "R_lip_lower_6_joint_out_transform", "R_lip_lower_7_joint_out_transform", "R_lip_lower_8_joint_out_transform", "R_lip_lower_9_joint_out_transform"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>
</children>
</module>