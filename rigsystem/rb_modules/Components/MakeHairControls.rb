<module name="MakeHairControls" muted="0" uid="a8b4f5c765f84cf4b63fa281e9f51d8a">
<run><![CDATA[import math
import re

import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

if not @curves:
    raise ValueError("MakeHairControls needs at least one curve.")

density = float(@controlsPerUnit)
if not math.isfinite(density) or density <= 0:
    raise ValueError("Controls per unit must be greater than zero.")

minControls = int(@minControls)
maxControls = int(@maxControls)
if minControls < 1 or maxControls < minControls:
    raise ValueError("Control limits must satisfy 1 <= minControls <= maxControls.")

makeJoints = module.child("MakeJointsOnCurve")
orientJoints = module.child("OrientJointsOnCurve")
makeControls = module.child("CreateFKControls")

curveCounts = []
for curveName in @curves:
    curve = proxy.node(curveName)
    shape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
    curveFn = shape.mfn(shape=True)
    if curveFn.form != om.MFnNurbsCurve.kOpen:
        raise ValueError(f"MakeHairControls curve {curveName} must be open.")

    length = om.MDistance(curveFn.length(), om.MDistance.kCentimeters).asUnits(
        om.MDistance.uiUnit()
    )
    if length <= 0:
        raise ValueError(f"MakeHairControls curve {curveName} has zero length.")

    controlCount = min(maxControls, max(minControls, int(math.ceil(length * density))))
    count = controlCount + 1
    curveNode = curve if curve.type() == "transform" else proxy.node(
        cmds.listRelatives(curveName, parent=True, fullPath=True)[0]
    )
    baseName = re.sub(r"_?curve$", "", curveNode.localName(), flags=re.IGNORECASE)
    baseName = baseName or curveNode.localName()
    jointName = f"{curveNode.namespace()}{baseName}"
    curveCounts.append((curveName, count, curveFn, jointName))

allJoints = []
allControls = []
for curveName, count, curveFn, jointName in curveCounts:
    makeJoints.attr.name = jointName
    makeJoints.attr.curve = curveName
    makeJoints.attr.numJoints = count
    makeJoints.attr.numAsCVs = False
    makeJoints.attr.makeConnected = True
    makeJoints.attr.attach = False
    makeJoints.run()
    joints = makeJoints.attr.out_joints.get()

    # MakeJointsOnCurve samples equal parameters; place its chain at equal arc lengths.
    startLength = curveFn.findLengthFromParam(curveFn.knotDomain[0])
    curveLength = curveFn.length() - startLength
    for jointIndex, joint in enumerate(joints):
        distance = startLength + curveLength * jointIndex / (count - 1)
        param = curveFn.findParamFromLength(distance)
        point = curveFn.getPointAtParam(param, om.MSpace.kWorld)
        cmds.xform(joint, worldSpace=True, translation=(point.x, point.y, point.z))

    cmds.joint(joints[0], edit=True, zeroScaleOrient=True,
               orientJoint="xyz", secondaryAxisOrient="yup", children=True)

    orientJoints.attr.joints = joints
    orientJoints.attr.curve = curveName
    orientJoints.attr.mesh = @normalMesh
    orientJoints.run()

    controlJoints = joints[:-1]
    makeControls.attr.joints = controlJoints
    makeControls.attr.orientation = 1
    makeControls.attr.helper = @controlShape
    makeControls.attr.connectScale = False
    makeControls.attr.setParent = 1
    makeControls.run()

    allJoints.extend(joints)
    for joint in controlJoints:
        node = proxy.node(joint)
        controlName = f"{node.namespace()}{node.localName().replace('_joint', '')}_control"
        allControls.append(cmds.ls(controlName, long=True)[0])

@set_out_joints(allJoints)
@set_out_controls(allControls)
]]></run>
<doc><![CDATA[## Summary
Creates one connected joint chain for each input hair curve, with FK controls on every joint except the tip.

## Inputs
- **curves**: Ordered list of open NURBS curves, each running from root to tip.
- **controlsPerUnit**: Desired number of controls per current Maya linear unit. The calculated control count is `ceil(curve length * controlsPerUnit)`.
- **minControls**, **maxControls**: Lower and upper limits on the control count for each curve. The joint chain has one additional tip joint without a control; limits must satisfy `1 <= minControls <= maxControls`.
- **mesh**: Optional polygon mesh used to orient joint Y axes. The nearest point on this mesh supplies each joint's normal.
- **controlShape**: Shape passed to CreateFKControls.

## Orientation
OrientJointsOnCurve aligns every joint's X axis to the curve tangent at its own position, including the tip joint. If a mesh is supplied, Y follows the nearest mesh normal projected perpendicular to X. An exactly parallel normal cannot define Y; in that case the original Y is used as a fallback. Without a mesh, Y follows the original `yup` orientation as closely as possible. CreateFKControls then matches the final joint orientation.

## Outputs
- **out_joints**: All joints, ordered by input curve and root to tip, including each uncontrolled tip joint.
- **out_controls**: FK controls in the same order, excluding each tip joint.

## Usage
Add MakeHairControls to a Rig Builder rig, supply root-to-tip curves, a source mesh, and the desired controls per Maya unit, then run it. Each chain is named from its curve transform, with a trailing `curve` or `_curve` removed. The muted child modules are invoked once per curve.]]></doc>
<attributes>
<attr name="curves" template="listBox" category="General" connect=""><![CDATA[{"items": ["R_hair_curl_e_curve"], "default": "items"}]]></attr>
<attr name="normalMesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "hair_geo", "placeholder": "Combined hair mesh", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="controlsPerUnit" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0.25, "placeholder": "Controls per Maya unit", "buttonEnabled": false, "min": 0.001, "max": 1000, "validator": 2, "default": "value"}]]></attr>
<attr name="minControls" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 3, "placeholder": "Minimum controls per curve", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 10, "validator": 1, "default": "value"}]]></attr>
<attr name="maxControls" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 6, "placeholder": "Maximum controls per curve", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 5, "max": 25, "validator": 1, "default": "value"}]]></attr>
<attr name="controlShape" template="comboBox" category="General" connect=""><![CDATA[{"items": ["circle", "rect", "sphere", "cube"], "current": "circle", "default": "current"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["R_hair_curl_e_1_joint", "R_hair_curl_e_2_joint", "R_hair_curl_e_3_joint", "R_hair_curl_e_4_joint", "R_hair_curl_e_5_joint"], "default": "items"}]]></attr>
<attr name="out_controls" template="listBox" category="Output" connect=""><![CDATA[{"items": ["|R_hair_curl_e_1_control", "|R_hair_curl_e_1_control|R_hair_curl_e_2_control", "|R_hair_curl_e_1_control|R_hair_curl_e_2_control|R_hair_curl_e_3_control", "|R_hair_curl_e_1_control|R_hair_curl_e_2_control|R_hair_curl_e_3_control|R_hair_curl_e_4_control"], "default": "items"}]]></attr>
</attributes>
<children>
<module name="MakeJointsOnCurve" muted="1" uid="edca6ffb8012413abb1b69a4fbd15f8f">
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
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_hair_curl_e", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_hair_curl_e_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="numJoints" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 5, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="numAsCVs" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="makeConnected" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["R_hair_curl_e_1_joint", "R_hair_curl_e_2_joint", "R_hair_curl_e_3_joint", "R_hair_curl_e_4_joint", "R_hair_curl_e_5_joint"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="CreateFKControls" muted="1" uid="2583b3b8a41a4ee6b2235c66a1acfd28">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds

controlPerJoint = []

for j in @joints:
    j = proxy.node(j)
    name = f"{j.namespace()}{j.localName().replace('_joint', '')}"

    ctrl = proxy.create("transform", f"{name}_control", suffix=False)
    h = rig_utils.curve.makeCurve(str(ctrl), @helper)
    h.r.set([0,0,90])
    rig_utils.curve.makeFromCurve(ctrl, h)
    cmds.delete(h)

    if @orientation == 0: # world
        cmds.matchTransform(ctrl, j, position=True, rotation=False)
    elif @orientation == 1: # joint
        cmds.matchTransform(ctrl, j)

    rig_utils.setToOffsetParentMatrix(ctrl)

    if @connectScale:
        ctrl.s >> j.s

    cmds.parentConstraint(ctrl, j, mo=True)
    rig_utils.lockTRS(ctrl, [], [], [], 1)
    controlPerJoint.append(ctrl)

if @setParent == 1: # parent by hierarchy
    for i in range(1, len(controlPerJoint)):
        controlPerJoint[i-1] | controlPerJoint[i]
        rig_utils.setToOffsetParentMatrix(controlPerJoint[i])
    ]]></run>
<doc><![CDATA[## Summary
Creates forward‑kinematics (FK) control curves for a list of joints, allowing optional orientation matching, scale linking, and hierarchical or constraint‑based parenting of the generated controls.

## Inputs
- **`joints`** – List of joint names (e.g., `L_hair_curl_a_1_joint`) that the FK controls will follow.
- **`orientation`** – Radio button (`world` or `joint`) determining whether the control null matches only the joint position or both position and rotation.
- **`helper`** – Combo box selecting the shape of the helper curve used to build the control curve (`circle`, `rect`, `sphere`, `cube`).
- **`connectScale`** – Check box that, when checked, links the control’s scale to the joint’s scale.
- **`setParent`** – Radio button controlling how the FK controls are parented:
  - `none` – No additional parenting.
  - `hierarchy` – FK controls are parented to each other following the joint hierarchy.
  - `constraint` – FK controls are parent‑constrained to the joint hierarchy.

## Outputs
- **FK Control Transforms** – For each joint, a null transform (`*_control_null`) and a child control transform (`*_control`) are created.
- **Optional Parenting** – Depending on `setParent`, the FK controls are either hierarchically parented or constrained to the joint chain.
- **Scale Linking** – If `connectScale` is enabled, each control’s scale is driven by its corresponding joint’s scale.

## Usage
1. **Select Joints** – Populate the `joints` list with the target joint names.
2. **Configure Settings** – Choose the desired helper shape, orientation, and whether to link scale or set parenting behavior.
3. **Run the Module** – Execute the module to generate FK controls along the joint chain.
4. **Adjust Controls** – Position and orient the created controls as needed; they will automatically follow the joints via parent constraints.
5. **Parenting (Optional)** – If `setParent` is set to `hierarchy` or `constraint`, the FK controls will automatically adopt the chosen parenting scheme.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Create FK controls for <b>joints</b>"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["R_hair_curl_e_1_joint", "R_hair_curl_e_2_joint", "R_hair_curl_e_3_joint", "R_hair_curl_e_4_joint"], "default": "items"}]]></attr>
<attr name="orientation" template="radioButton" category="General" connect=""><![CDATA[{"items": ["world", "joint"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="helper" template="comboBox" category="General" connect=""><![CDATA[{"items": ["circle", "rect", "sphere", "cube"], "current": "circle", "default": "current"}]]></attr>
<attr name="connectScale" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="setParent" template="radioButton" category="General" connect=""><![CDATA[{"items": ["none", "hierarchy"], "current": 1, "columns": 2, "default": "current"}]]></attr>
</attributes>
</module>
<module name="OrientJointsOnCurve" muted="1" uid="54a28ce33d9d4ec39871bccf18414f92">
<run><![CDATA[import math

import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

curve = proxy.node(@curve)
curveShape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
curveFn = curveShape.mfn(shape=True)
startParam, endParam = curveFn.knotDomain
startLength = curveFn.findLengthFromParam(startParam)
curveLength = curveFn.length() - startLength

meshFn = None
if @mesh:
    shape = @mesh if cmds.nodeType(@mesh) == "mesh" else cmds.listRelatives(
        @mesh, shapes=True, noIntermediate=True, type="mesh", fullPath=True
    )[0]
    selection = om.MSelectionList()
    selection.add(shape)
    meshFn = om.MFnMesh(selection.getDagPath(0))

worldMatrices = [cmds.xform(joint, query=True, worldSpace=True, matrix=True)
                 for joint in @joints]

for index, (joint, values) in enumerate(zip(@joints, worldMatrices)):
    position = om.MPoint(values[12], values[13], values[14])
    distance = startLength + curveLength * index / (len(@joints) - 1)
    param = endParam if index == len(@joints) - 1 else curveFn.findParamFromLength(distance)
    xAxis = curveFn.tangent(param, om.MSpace.kWorld).normal()

    referenceY = om.MVector(values[4], values[5], values[6])
    if meshFn:
        _, referenceY, _ = meshFn.getClosestPointAndNormal(
            position, om.MSpace.kWorld
        )

    yAxis = referenceY - xAxis * (referenceY * xAxis)
    if yAxis.length() < 1e-8:
        if meshFn:
            cmds.warning(f"{joint}: mesh normal is parallel to curve tangent; using fallback Y.")
        referenceY = om.MVector(values[4], values[5], values[6])
        yAxis = referenceY - xAxis * (referenceY * xAxis)
    if yAxis.length() < 1e-8:
        referenceY = om.MVector(0, 1, 0) if abs(xAxis.y) < 0.9 else om.MVector(0, 0, 1)
        yAxis = referenceY - xAxis * (referenceY * xAxis)

    yAxis = yAxis.normal()
    zAxis = (xAxis ^ yAxis).normal()
    yAxis = (zAxis ^ xAxis).normal()
    worldMatrix = om.MMatrix((
        xAxis.x, xAxis.y, xAxis.z, 0,
        yAxis.x, yAxis.y, yAxis.z, 0,
        zAxis.x, zAxis.y, zAxis.z, 0,
        0, 0, 0, 1,
    ))

    parent = cmds.listRelatives(joint, parent=True, type="joint", fullPath=True)
    if parent:
        parentValues = cmds.xform(parent[0], query=True, worldSpace=True, matrix=True)
        parentValues[12:15] = [0, 0, 0]
        worldMatrix *= om.MMatrix(parentValues).inverse()

    angles = om.MTransformationMatrix(worldMatrix).rotation(asQuaternion=True).asEulerRotation()
    cmds.setAttr(f"{joint}.jointOrient",
                 math.degrees(angles.x), math.degrees(angles.y), math.degrees(angles.z),
                 type="double3")
    cmds.xform(joint, worldSpace=True,
               translation=(position.x, position.y, position.z))
]]></run>
<doc><![CDATA[Aligns every joint's X axis to the tangent of its curve, including the last joint. When a mesh is supplied, Y follows its nearest normal projected perpendicular to X. Runs after joint placement and before FK controls are created.]]></doc>
<attributes>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["R_hair_curl_e_1_joint", "R_hair_curl_e_2_joint", "R_hair_curl_e_3_joint", "R_hair_curl_e_4_joint", "R_hair_curl_e_5_joint"], "default": "items"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_hair_curl_e_curve", "placeholder": "Strand curve", "buttonEnabled": false, "default": "value"}]]></attr>
<attr name="mesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "hair_geo", "placeholder": "Polygon mesh", "buttonEnabled": false, "default": "value"}]]></attr>
</attributes>
</module>
</children>
</module>