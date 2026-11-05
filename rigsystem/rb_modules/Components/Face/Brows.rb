<module name="Brows" muted="0" uid="db3561e008ed4d03b1ed486528722ede">
<doc><![CDATA[## Summary
Imports and fits the face_brows template to separate left and right degree-1 brow curves.

## Inputs
- left_curve, right_curve: open degree-1 curves for the corresponding brows.

## Outputs
Updates the L/R brow wire Origs, rebuilds the left tuner curve to six spans, and positions the left main tuner at normalized parameter 0.5. The template mirrors the tuner curve to the right side.]]></doc>
<attributes>
<attr name="importTemplate" template="button" category="General" connect=""><![CDATA[{"command": "import os\nimport maya.cmds as cmds\n\ntemplatePath = os.path.join(\n    os.environ[\"RIGSYSTEM_PATH\"],\n    \"library\",\n    \"face_brows.ma\",\n)\ncmds.file(\n    templatePath,\n    i=True,\n    ignoreVersion=True,\n    namespace=\":\",\n    mergeNamespacesOnClash=False,\n)", "label": "Import face_brows", "color": "", "default": "command"}]]></attr>
<attr name="left_curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_brow_edge_curve", "placeholder": "Open degree-1 left brow curve", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="right_curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_brow_edge_curve", "placeholder": "Open degree-1 right brow curve", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="FitCurves" muted="0" uid="">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

BROW_CURVE = "{side}_brow_curve"
TUNER_CURVE = "L_brow_tuner_curve"
MAIN_TUNER = "L_brow_main_tuner"


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
for side, name in [("L", ch("../left_curve")), ("R", ch("../right_curve"))]:
    curve = proxy.node(name)
    shape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
    fn = shape.mfn(shape=True)
    if fn.degree != 1 or fn.form != om.MFnNurbsCurve.kOpen:
        raise ValueError(f"{side.lower()}_curve must be an open degree-1 curve.")

    cvs = fn.cvPositions(om.MSpace.kWorld)
    directionIsValid = (
        cvs[0].x < cvs[-1].x
        if side == "L"
        else cvs[0].x > cvs[-1].x
    )
    if not directionIsValid:
        transform = curve if curve.type() == "transform" else shape.getParent()
        cmds.reverseCurve(
            transform,
            constructionHistory=False,
            replaceOriginal=True,
        )
        shape = transform.getShapes(type="nurbsCurve")[0]
        fn = shape.mfn(shape=True)
        cvs = fn.cvPositions(om.MSpace.kWorld)

    directionIsValid = (
        cvs[0].x < cvs[-1].x
        if side == "L"
        else cvs[0].x > cvs[-1].x
    )
    if not directionIsValid:
        comparison = "less" if side == "L" else "greater"
        raise ValueError(
            f"{side.lower()}_curve direction is invalid: first CV X must be "
            f"{comparison} than last CV X."
        )

    sources[side] = shape

wireOriginals = {
    side: next(
        shape
        for shape in proxy.node(BROW_CURVE.format(side=side)).getShapes(
            type="nurbsCurve", noIntermediate=False
        )
        if shape.intermediateObject.get()
    )
    for side in "LR"
}
tunerCurve = proxy.node(TUNER_CURVE).getShapes(type="nurbsCurve")[0]

leftFn = sources["L"].mfn(shape=True)
start, end = leftFn.knotDomain
point = leftFn.getPointAtParam(start + 0.5 * (end - start), om.MSpace.kWorld)
cmds.xform(MAIN_TUNER, worldSpace=True, translation=(point.x, point.y, point.z))

for side in "LR":
    copyGeometry(sources[side], wireOriginals[side])

leftCvs = leftFn.cvPositions(om.MSpace.kWorld)
duplicate = proxy.node(cmds.curve(
    point=[(point.x, point.y, point.z) for point in leftCvs],
    degree=1,
    knot=list(leftFn.knots()),
))
try:
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
    duplicateShape = duplicate.getShapes(type="nurbsCurve")[0]
    copyGeometry(duplicateShape, tunerCurve)
finally:
    cmds.delete(duplicate)

bindMode = module.child("BindMode")
joints = set()
for side in "LR":
    mainCurve = proxy.node(f"{side}_brow_main_curve")
    history = cmds.listHistory(mainCurve, future=True, allFuture=True) or []
    for skin in cmds.ls(history, type="skinCluster") or []:
        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])

bindMode.attr.joints = sorted(joints)
bindMode.attr.mode = 0
bindMode.run()
bindMode.attr.mode = 1
bindMode.run()
]]></run>
<doc><![CDATA[## Summary
Fits the face_brows wire and tuner curves.

Copies the degree-1 inputs into the L/R brow curve Origs. Rebuilds the left input to six cubic spans and copies it into `L_brow_tuner_curve`; the template mirrors that curve to the right. Positions `L_brow_main_tuner` at normalized parameter 0.5 without changing its offsetParentMatrix, then refreshes the L/R main-curve skin bindings.]]></doc>
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
<doc><![CDATA[Temporarily unbinds and rebinds the brow main-curve skin influences so their bind pre-matrices match the fitted curves.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": "", "columns": 3, "default": "current"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_brow_major_inner_joint", "L_brow_major_mid_joint", "L_brow_major_outer_joint", "R_brow_major_inner_joint", "R_brow_major_mid_joint", "R_brow_major_outer_joint"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>
<module name="makeLeftJoints" muted="0" uid="edca6ffb8012413abb1b69a4fbd15f8f">
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
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_brow", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_brow_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="numJoints" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 4, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="numAsCVs" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="makeConnected" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["L_brow_1_joint", "L_brow_2_joint", "L_brow_3_joint", "L_brow_4_joint", "L_brow_5_joint", "L_brow_6_joint", "L_brow_7_joint", "L_brow_8_joint"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="makeRightJoints" muted="0" uid="edca6ffb8012413abb1b69a4fbd15f8f">
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
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_brow", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_brow_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="numJoints" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 4, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="numAsCVs" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="makeConnected" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["R_brow_1_joint", "R_brow_2_joint", "R_brow_3_joint", "R_brow_4_joint", "R_brow_5_joint", "R_brow_6_joint", "R_brow_7_joint", "R_brow_8_joint"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="attachLeftJoints" muted="0" uid="b79ce70fe8fc4009a31219c30b5eb506">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds
curve = proxy.node(@curve)
transforms = proxy.nodes(@transforms)
curveShape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
curveFn = curveShape.mfn(shape=True)

for t in transforms:
    coords = cmds.xform(str(t), q=True, ws=True, t=True)
    position = om.MPoint(coords[0], coords[1], coords[2])
    _, param = curveFn.closestPoint(position, 1e-6, om.MSpace.kWorld)
    poci = proxy.create("pointOnCurveInfo", f"{t}")
    curveShape.worldSpace[0] >> poci.inputCurve
    poci.parameter.set(param)
    poci.turnOnPercentage.set(False)
    pmm = proxy.create("pointMatrixMultDL", f"{t}_parentInverse")
    poci.position >> pmm.inPoint
    t.parentInverseMatrix >> pmm.inMatrix
    pmm.output >> t.translate
    ]]></run>
<doc><![CDATA[## Summary  
The **attachToCurve** module snaps a list of transforms to a NURBS curve by projecting each transform’s world position onto the curve. It uses a `pointOnCurveInfo` node to drive the transform’s translation, leaving rotation and scale untouched.

## Inputs  
- **`curve`** – Name or reference to the NURBS curve that will serve as the attachment surface.  
- **`transforms`** – List of transform nodes whose world positions will be projected onto the curve.  

## Outputs  
- No explicit output nodes are created.  
- The module directly modifies the **translate** attributes of each transform in the `transforms` list, aligning them to the nearest point on the specified curve.

## Usage  
1. **Select the curve** you want the transforms to follow and set the **`curve`** attribute (or use its button to pick the selected curve).  
2. **Populate the `transforms` list** with the transforms to attach.  
3. **Run the module**. Each transform is snapped to the curve and follows its shape.  
4. **Adjust** the transforms as needed; their translate remains connected to the curve.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS curve</b> using closest point (translate only)."}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_brow_curve", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect="/makeLeftJoints/out_joints"><![CDATA[{"items": ["L_brow_1_joint", "L_brow_2_joint", "L_brow_3_joint", "L_brow_4_joint", "L_brow_5_joint", "L_brow_6_joint", "L_brow_7_joint", "L_brow_8_joint"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="attachRightJoints" muted="0" uid="b79ce70fe8fc4009a31219c30b5eb506">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds
curve = proxy.node(@curve)
transforms = proxy.nodes(@transforms)
curveShape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
curveFn = curveShape.mfn(shape=True)

for t in transforms:
    coords = cmds.xform(str(t), q=True, ws=True, t=True)
    position = om.MPoint(coords[0], coords[1], coords[2])
    _, param = curveFn.closestPoint(position, 1e-6, om.MSpace.kWorld)
    poci = proxy.create("pointOnCurveInfo", f"{t}")
    curveShape.worldSpace[0] >> poci.inputCurve
    poci.parameter.set(param)
    poci.turnOnPercentage.set(False)
    pmm = proxy.create("pointMatrixMultDL", f"{t}_parentInverse")
    poci.position >> pmm.inPoint
    t.parentInverseMatrix >> pmm.inMatrix
    pmm.output >> t.translate
    ]]></run>
<doc><![CDATA[## Summary  
The **attachToCurve** module snaps a list of transforms to a NURBS curve by projecting each transform’s world position onto the curve. It uses a `pointOnCurveInfo` node to drive the transform’s translation, leaving rotation and scale untouched.

## Inputs  
- **`curve`** – Name or reference to the NURBS curve that will serve as the attachment surface.  
- **`transforms`** – List of transform nodes whose world positions will be projected onto the curve.  

## Outputs  
- No explicit output nodes are created.  
- The module directly modifies the **translate** attributes of each transform in the `transforms` list, aligning them to the nearest point on the specified curve.

## Usage  
1. **Select the curve** you want the transforms to follow and set the **`curve`** attribute (or use its button to pick the selected curve).  
2. **Populate the `transforms` list** with the transforms to attach.  
3. **Run the module**. Each transform is snapped to the curve and follows its shape.  
4. **Adjust** the transforms as needed; their translate remains connected to the curve.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS curve</b> using closest point (translate only)."}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_brow_curve", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect="/makeRightJoints/out_joints"><![CDATA[{"items": ["R_brow_1_joint", "R_brow_2_joint", "R_brow_3_joint", "R_brow_4_joint", "R_brow_5_joint", "R_brow_6_joint", "R_brow_7_joint", "R_brow_8_joint"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>