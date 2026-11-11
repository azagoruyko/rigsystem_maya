<module name="Eyelids" muted="0" uid="dfe3879a37134d94aa15cf03688c6763">
<doc><![CDATA[## Summary
Imports the face_eyelids template and runs the visible build stages in child order.

## Inputs
- leftEyeJoint, rightEyeJoint: joints used to position the L/R eye transform controls.
- upper_curve, lower_curve: open degree-1 edge curves with a shared inner start point nearest X=0.

## Outputs
Imports the eyelid template, fits its curves and controls, then builds eyelid joints and attachments.

## Usage
Set the four inputs and run Eyelids. The child order shows the build sequence: FitCurves, then BuildEyelids. MakeJointsOnCurve remains a muted helper.]]></doc>
<attributes>
<attr name="importTemplate" template="button" category="General" connect=""><![CDATA[{"command": "import os\nimport maya.cmds as cmds\n\ntemplatePath = os.path.join(\n    os.environ[\"RIGSYSTEM_PATH\"],\n    \"library\",\n    \"face_eyelids.ma\",\n)\ncmds.file(\n    templatePath,\n    i=True,\n    ignoreVersion=True,\n    namespace=\":\",\n    mergeNamespacesOnClash=False,\n)", "label": "Import face_eyelids", "color": "", "default": "command"}]]></attr>
<attr name="leftEyeJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_eye_joint", "placeholder": "Left eye joint", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="rightEyeJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_eye_joint", "placeholder": "Right eye joint", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="upper_curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "eyelid_upper_curve", "placeholder": "Degree-1 edge curve, inner corner first", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="lower_curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "eyelid_lower_curve", "placeholder": "Degree-1 edge curve, inner corner first", "buttonCommand": "import maya.cmds as cmds\nselection = cmds.ls(selection=True)\nvalue = selection[0] if selection else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="FitCurves" muted="0" uid="">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

EDGE_CURVE = "{side}_eyelid_{lid}_curve"
TUNER_CURVE = "L_eyelid_{lid}_tuner_curve"
TUNER_POSITIONS = (
    ("L_eyelids_upper_main_tuner", "upper", 0.5),
    ("L_eyelids_lower_main_tuner", "lower", 0.5),
    ("L_eyelids_corner_inner_tuner", "upper", 0),
    ("L_eyelids_corner_outer_tuner", "upper", 1),
)
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
reverseDirections = {}
for lid, name in [("upper", ch("../upper_curve")), ("lower", ch("../lower_curve"))]:
    curve = proxy.node(name)
    shape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
    fn = shape.mfn(shape=True)
    if fn.degree != 1 or fn.form != om.MFnNurbsCurve.kOpen:
        raise ValueError(f"{lid}_curve must be an open degree-1 curve.")

    cvs = fn.cvPositions(om.MSpace.kWorld)
    if abs(abs(cvs[0].x) - abs(cvs[-1].x)) <= 1e-5:
        raise ValueError(f"{lid}_curve needs a distinct inner corner closer to X=0.")

    reverseDirections[lid] = abs(cvs[0].x) > abs(cvs[-1].x)
    outer = cvs[0] if reverseDirections[lid] else cvs[-1]
    sign = 1 if outer.x > 0 else -1
    if any(point.x * sign < -1e-5 for point in cvs):
        raise ValueError(f"{lid}_curve must stay on one side of X=0.")

    sources[lid] = shape
    start, end = fn.knotDomain
    params = {0, 1} | {param for name, curveLid, param in TUNER_POSITIONS
                       if curveLid == lid}
    points[lid] = {
        param: fn.getPointAtParam(
            start + (1 - param if reverseDirections[lid] else param) * (end - start),
            om.MSpace.kWorld,
        )
        for param in params
    }

if points["upper"][0].distanceTo(points["lower"][0]) > 1e-5:
    raise ValueError("upper_curve and lower_curve must start at the same point.")

if points["upper"][1].x * points["lower"][1].x <= 0:
    raise ValueError("upper_curve and lower_curve must be on the same side of X=0.")

edgeOriginals = {}
for side in "LR":
    for lid in ("upper", "lower"):
        edgeOriginals[side, lid] = next(
            shape
            for shape in proxy.node(EDGE_CURVE.format(side=side, lid=lid)).getShapes(
                type="nurbsCurve", noIntermediate=False
            )
            if shape.intermediateObject.get()
        )

tunerCurves = {
    lid: proxy.node(TUNER_CURVE.format(lid=lid)).getShapes(type="nurbsCurve")[0]
    for lid in ("upper", "lower")
}
tuners = [(proxy.node(name), lid, param) for name, lid, param in TUNER_POSITIONS]

transformTuner = proxy.node("L_eyelids_transform_tuner")
cmds.matchTransform(transformTuner, ch("../leftEyeJoint"), position=True, rotation=False)

for tuner, lid, param in tuners:
    point = points[lid][param]
    cmds.xform(tuner, worldSpace=True, translation=(point.x, point.y, point.z))

temporary = []
try:
    for side in "LR":
        for lid in ("upper", "lower"):
            fn = sources[lid].mfn(shape=True)
            cvs = fn.cvPositions(om.MSpace.kWorld)
            duplicate = proxy.node(cmds.curve(
                point=[(point.x, point.y, point.z) for point in cvs],
                degree=1,
                knot=list(fn.knots()),
            ))
            temporary.append(duplicate)

            if reverseDirections[lid]:
                cmds.reverseCurve(
                    duplicate,
                    constructionHistory=False,
                    replaceOriginal=True,
                )

            if side == "R":
                duplicate.scaleX.set(-1)
                cmds.makeIdentity(
                    duplicate,
                    apply=True,
                    translate=True,
                    rotate=True,
                    scale=True,
                )

            shape = duplicate.getShapes(type="nurbsCurve")[0]
            copyGeometry(shape, edgeOriginals[side, lid])

            if side == "L":
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
for side in "LR":
    for lid in ("upper", "lower"):
        mainCurve = proxy.node(f"{side}_eyelid_{lid}_main_curve")
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
Fits the eyelid template through its tuner curves and locator tuners.

## Inputs
- Parent `leftEyeJoint`: positions the left eye transform tuner; the template mirrors it to the right.
- Parent `upper_curve` and `lower_curve`: open degree-1 curves on the same side of X=0, sharing an inner corner. Either curve direction is accepted.

## Outputs
Updates the L/R detailed eyelid curve Origs, orienting them from the inner corner toward the outer corner without changing the input curves. Rebuilds temporary copies of the input curves to six spans and copies them into the L upper/lower tuner curves, which drive both main curves and BaseWire shapes through the template. Positions the transform, main and corner tuners, refreshes the main-curve skin binding.

## Usage
Import face_eyelids with the parent button, set the input curves and left eye joint, then run Eyelids. The template handles right-side mirroring.]]></doc>
<children>
<module name="BindMode" muted="1" uid="c7ae99e054f94721afc9256cf449e180">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
joints = proxy.nodes(@joints)

def getJointsSkinClusters(joint):
    return {plug.node for plug in joint.worldMatrix.outputs(type="skinCluster")}

def influenceIndex(skin, joint):
    return skin.mfn().indexForInfluenceObject(joint.mdagpath)

if @mode == 0: # unbind
    for j in joints:
        for skin in getJointsSkinClusters(j):
            idx = influenceIndex(skin, j)
        
            preMatrix = skin.bindPreMatrix[idx]
            if not preMatrix.inputs():
                j.worldInverseMatrix[0] >> preMatrix
    
    print("Unbinded")
    @set_mode("Unbinded")
else:
    for j in joints:
        for skin in getJointsSkinClusters(j):
            idx = influenceIndex(skin, j)
        
            matrix = j.worldInverseMatrix[0].get()

            if cmds.isConnected(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx])):
                cmds.disconnectAttr(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx]))
                skin.bindPreMatrix[idx].set(matrix)
    
    print("Binded")
    @set_mode("")
        ]]></run>
<doc><![CDATA[## Summary  
The **bindMode** module toggles the binding state of selected joints to their skin clusters in Maya. When executed, it either connects each joint’s world inverse matrix to the skin cluster’s bind pre‑matrix (unbinding) or disconnects that connection and writes the current matrix back (rebinding). The module updates the `mode` attribute to reflect the new state and prints a status message.

## Inputs  
- **`joints`** (listBox): A list of joint names that the script will process.  
- **`mode`** (label): A flag indicating the current state. When empty, the module will perform a *bind* operation; when set to any value (e.g., `"Unbinded"`), it will perform an *unbind* operation.

## Outputs  
- **`mode`** (label): Updated to `"Unbinded"` after an unbind operation or cleared after a bind operation.  
- Console output: Prints `"Unbinded"` or `"Binded"` to indicate the action taken.

## Usage  
1. **Select Joints** – In the `joints` listBox, choose the joints you want to toggle.  
2. **Unbind** – If `mode` is empty, click **Run**. The script will unbind the selected joints from their skin clusters and set `mode` to `"Unbinded"`.  
3. **Adjust Joints** – Move or modify the joints as needed.  
4. **Rebind** – With `mode` now set, click **Run** again. The script will rebind the joints, restoring the original skin cluster matrices and clearing `mode`.  
5. **Repeat** – You can toggle between bind and unbind states as required during rigging or animation adjustments.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "<html>\nHow to use: <br>\n1. Set joints and press <b>Run</b> to unbind joints from skin clusters.<br>\n2. Change joints position.<br>\n3. Press <b>Run</b> to rebind again.<br>\n</html>", "default": "text"}]]></attr>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": "", "columns": 3, "default": "current"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_eyelid_lower_main_joint", "L_eyelid_upper_main_joint", "L_eyelids_corner_inner_joint", "L_eyelids_corner_outer_joint", "R_eyelid_lower_main_joint", "R_eyelid_upper_main_joint", "R_eyelids_corner_inner_joint", "R_eyelids_corner_outer_joint"], "default": "items"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import maya.cmds as cmds\nimport maya.mel as mel\n\njoints = set()\nfor mesh in cmds.ls(sl=True) or []:\n    skin = mel.eval('findRelatedSkinCluster \"{}\"'.format(mesh))\n    if skin:\n        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])\n\nchset(\"/joints\", sorted(joints))", "label": "Get From Mesh", "color": "", "default": "command"}]]></attr>
</attributes>
</module>
</children>
</module>
<module name="BuildEyelids" muted="0" uid="">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds

if cmds.objExists("eyelids_transforms"):
    warning("Eyelids are already built. Skipping BuildEyelids to avoid duplicates.")
    exit()

makeJointsMod = module.parent().child("MakeJointsOnCurve")

transformsGrp = proxy.create("transform", "eyelids_transforms", suffix=False)
rig_utils.lockTRS(transformsGrp)

for side in "LR":
    avgCurve = proxy.node(f"{side}_eyelids_avg_curve")
    blinkAttr = proxy.node(f"{side}_eyelid_upper_main_control").blink
    
    for direction in ["upper", "lower"]:
        print(f"{side}_eyelid_{direction}")
        curve = proxy.node(f"{side}_eyelid_{direction}_curve")
        curveShape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
        curveFn = curveShape.mfn(shape=True)
        if curveFn.degree != 1:
            raise ValueError(f"{curve} must be a degree-1 curve.")
        parameters = curveFn.knots()
        
        makeJointsMod.attr.name = f"{side}_eyelid_{direction}"
        makeJointsMod.attr.curve = str(curve)
        makeJointsMod.attr.numAsCVs = True
        makeJointsMod.run()
        
        joints = proxy.nodes(makeJointsMod.attr.out_joints.get())
        
        if len(joints) != len(parameters):
            raise ValueError(f"{curve} must have one joint per CV.")

        for i, j in enumerate(joints):
            aimj = proxy.create(
                "joint",
                j.localName().replace("_joint", "_aim"),
                parent=f"{side}_eyelids_joint",
            )
            aimj | j
            
            t = proxy.create(
                "transform",
                j.localName().replace("_joint", ""),
                parent=transformsGrp,
            )
            cmds.matchTransform(t, j, position=True, rotation=False)
            
            pointOnCurve = proxy.create(
                "pointOnCurveInfo",
                str(t),
            )
            curveShape.worldSpace[0] >> pointOnCurve.inputCurve
            pointOnCurve.parameter.set(parameters[i])
            
            nearestPointOnCurve = proxy.create(
                "nearestPointOnCurve",
                f"{t}_blink",
            )
            avgCurveShape = avgCurve.getShapes(type="nurbsCurve")[0] if avgCurve.type() == "transform" else avgCurve
            avgCurveShape.worldSpace[0] >> nearestPointOnCurve.inputCurve
            pointOnCurve.position >> nearestPointOnCurve.inPosition
            
            blendColors = proxy.create(
                "blendColors",
                f"{t}_blink",
            )
            nearestPointOnCurve.position >> blendColors.color1
            pointOnCurve.position >> blendColors.color2
            blinkAttr >> blendColors.blender
            blendColors.output >> t.translate
            
            cmds.aimConstraint(t, aimj, mo=True,
                worldUpType="objectrotation", aimVector=[0,0,1],
                worldUpObject=side+"_eyelids_joint")
            ]]></run>
<doc><![CDATA[## Summary
Builds eyelid joints and blink attachments from the fitted eyelid template.

## Inputs
Uses the fitted L/R eyelid curves and controls created by the preceding FitCurves module.

## Outputs
Creates eyelid joint chains, aim joints, point-on-curve nodes, blink nodes and constraints.

## Usage
Run as part of Eyelids after FitCurves. If `eyelids_transforms` already exists, the module skips the build to avoid duplicate groups, joints and utility nodes. MakeJointsOnCurve remains a muted helper module.]]></doc>
</module>
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
        poci = proxy.create("pointOnCurveInfo", f"{joints[i].localName()}_pointOnCurveInfo")
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
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_eyelid_lower", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_eyelid_lower_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="numJoints" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 4, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 2, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="numAsCVs" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="makeConnected" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="out_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["R_eyelid_lower_1_joint", "R_eyelid_lower_2_joint", "R_eyelid_lower_3_joint", "R_eyelid_lower_4_joint", "R_eyelid_lower_5_joint", "R_eyelid_lower_6_joint", "R_eyelid_lower_7_joint", "R_eyelid_lower_8_joint", "R_eyelid_lower_9_joint", "R_eyelid_lower_10_joint", "R_eyelid_lower_11_joint", "R_eyelid_lower_12_joint", "R_eyelid_lower_13_joint"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>
