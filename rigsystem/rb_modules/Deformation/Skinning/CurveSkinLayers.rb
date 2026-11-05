<module name="CurveSkinLayers" muted="0" uid="28b7e6993fe94ae384cd4bcff1328692">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy, rig_utils

cmds = proxy.cmds
mainCurve = proxy.node(@mainCurve)
makeSkinLocalMod = module.child("makeSkinLocal")
attachToCurveMod = module.child("attachToCurve")

def curveShape(curve):
    curve = proxy.node(curve)
    return curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve

def curveTransform(curve):
    curve = proxy.node(curve)
    return curve.getParent() if curve.type() == "nurbsCurve" else curve

def generateJoints(curve, params, layerName):
    curveFn = curveShape(curve).mfn(shape=True)
    sizes = {"major": 0.5, "minor": 0.3}
    joints = []
    for i, param in enumerate(params):
        joint = proxy.create("joint", f"{@prefix}_{layerName}_{i + 1}_joint", suffix=False, skipSelection=True)
        point = curveFn.getPointAtParam(param, om.MSpace.kWorld)
        joint.t.set((point.x, point.y, point.z))
        joint.radius.set(sizes.get(layerName, 1.0))
        joints.append(joint)
    return joints

def generateControls(curve, joints, layerName, curveType, *, addTransform=False):
    sizes = {"major": 0.5, "minor": 0.3}
    curveFn = curveShape(curve).mfn(shape=True)
    size = curveFn.length() / (len(joints) * 1.5) * sizes.get(layerName, 1.0)
    controls = []
    for i, joint in enumerate(joints):
        ctrl = proxy.create("transform", f"{@prefix}_{layerName}_{i + 1}_control", suffix=False)
        cmds.matchTransform(str(ctrl), str(joint))
        cmds.parentConstraint(str(ctrl), str(joint))
        ctrl.s >> joint.s

        if addTransform:
            transform = proxy.create("transform", f"{ctrl}_transform", suffix=False)
            cmds.matchTransform(str(transform), str(ctrl))
            transform | ctrl

        rig_utils.setToOffsetParentMatrix(ctrl)
        helper = rig_utils.curve.makeCurve("helper", curveType)
        cmds.matchTransform(str(helper), str(ctrl))
        helper.s.set((size, size, size))
        rig_utils.curve.makeFromCurve(ctrl, helper)
        cmds.delete(str(helper))

        if layerName in ("main", "major"):
            rig_utils.lockTRS(ctrl, [], [], [], 1)
        else:
            rig_utils.lockTRS(ctrl, [], [1, 1, 1], [1, 1, 1], 1)
        controls.append(ctrl)
    return controls

def duplicateCurve(curve, layerName):
    duplicate = proxy.node(cmds.duplicate(str(curveTransform(curve)))[0])
    duplicate.rename(f"{@prefix}_{layerName}_curve")
    curveShape(curve).local >> curveShape(duplicate).create
    return duplicate

def attachControls(curve, controls):
    attachToCurveMod.attr.curve.set(str(curve))
    attachToCurveMod.attr.transforms.set([str(ctrl.getParent()) for ctrl in controls])
    attachToCurveMod.run()

def makeLocal(curve, controls):
    makeSkinLocalMod.attr.skinnedGeo.set(str(curve))
    makeSkinLocalMod.run()
    basis = makeSkinLocalMod.attr.out_basis.get()
    for ctrl, basisName in zip(controls, basis):
        ctrl.getParent() | proxy.node(basisName)

mainJoints = generateJoints(mainCurve, @mainParams, "main")
cmds.skinCluster([str(joint) for joint in mainJoints], str(curveTransform(mainCurve)), tsb=True, dr=3.0)
mainControls = generateControls(mainCurve, mainJoints, "main", "rect")

majorCurve = duplicateCurve(mainCurve, "major")
majorJoints = generateJoints(majorCurve, @majorParams, "major")
cmds.skinCluster([str(joint) for joint in majorJoints], str(majorCurve), tsb=True, dr=3.0)
majorControls = generateControls(majorCurve, majorJoints, "major", "sphere", addTransform=True)
attachControls(mainCurve, majorControls)
makeLocal(majorCurve, majorControls)

minorCurve = duplicateCurve(mainCurve, "minor")
minorJoints = generateJoints(minorCurve, @minorParams, "minor")
cmds.skinCluster([str(joint) for joint in minorJoints], str(minorCurve), tsb=True, dr=3.0)
minorControls = generateControls(minorCurve, minorJoints, "minor", "sphere", addTransform=True)
attachControls(majorCurve, minorControls)
makeLocal(minorCurve, minorControls)

cmds.wire(@edgeCurve, gw=False, ce=0.0, li=0.0, dds=[0, 100], w=str(minorCurve), name=f"{@edgeCurve}_wire")
]]></run>
<attributes>
<attr name="prefix" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="edgeCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_main_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.5, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="majorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.3, 0.7, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="minorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.1, 0.5, 0.9, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="makeSkinLocal" muted="1" uid="c3d086240a8642d5bcd762328d68df91">
<run><![CDATA[import maya.api.OpenMaya as om
import maya.mel as mel
from rigsystem import proxy

cmds = proxy.cmds
skinned = proxy.node(@skinnedGeo)
skin = mel.eval(f'findRelatedSkinCluster "{skinned}"')
if not skin:
    error(f"Cannot find skinCluster for {skinned}")
    
skin = proxy.node(skin)
skinFn = skin.mfn()
basis = []
    
for influence in skinFn.influenceObjects():
    index = skinFn.indexForInfluenceObject(influence)
    preMatrix = skin.bindPreMatrix[index]
    if preMatrix.inputs():
        warning(f"bindPreMatrix[{index}] is connected, skipped")
        continue
        
    t = proxy.create("transform", f"{influence.partialPathName()}_basis", suffix=False)
    matrix = om.MMatrix(preMatrix.get()).inverse()
    cmds.xform(str(t), ws=True, matrix=list(matrix))
    t.worldInverseMatrix[0] >> preMatrix
    basis.append(str(t))
    
@set_out_basis(basis)    ]]></run>
<doc><![CDATA[## Summary  
Creates a local basis transform for each influence of a skin cluster, replacing the bindPreMatrix with a world‑inverse matrix that keeps the skin cluster localized to the influence objects. This is useful for cleaning up skinning data or preparing a rig for further manipulation.

## Inputs  
- **`skinned`**: The name of the skinned mesh or transform node that has an associated skinCluster. The module will locate the skinCluster that is related to this node.

## Outputs  
- **Basis Transforms**: For every influence object of the skinCluster, a new transform node named `<influence>_basis` is created.  
- **Updated bindPreMatrix**: The skinCluster’s `bindPreMatrix` attribute for each influence is replaced with a connection to the `worldInverseMatrix` of the corresponding basis transform.  
- **Warnings**: If an influence’s `bindPreMatrix` is already connected, a warning is emitted and that influence is skipped.

## Usage  
1. **Select the skinned mesh** (or provide its name) and set the `skinned` attribute.  
2. **Run the module**. It will automatically find the skinCluster, create basis transforms for each influence, and update the bindPreMatrix connections.  
3. **Verify** that the new `<influence>_basis` nodes appear in the Outliner and that the skinCluster’s bindPreMatrix attributes now point to these nodes.  
4. **Proceed** with any further skinning or rigging steps that rely on localized skin data.]]></doc>
<attributes>
<attr name="skinnedGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_minor_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_basis" template="listBox" category="General" connect=""><![CDATA[{"items": ["lower_minor_1_joint_basis", "lower_minor_2_joint_basis", "lower_minor_3_joint_basis", "lower_minor_4_joint_basis", "lower_minor_5_joint_basis"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="attachToCurve" muted="1" uid="b79ce70fe8fc4009a31219c30b5eb506">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

curve = proxy.node(@curve)
transforms = proxy.nodes(@transforms)

curveShape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
curveFn = curveShape.mfn(shape=True)

for t in transforms:
    position = om.MPoint(cmds.xform(str(t), q=True, ws=True, t=True))
    closest = curveFn.closestPoint(position, 1e-6, om.MSpace.kWorld)
    param = curveFn.getParamAtPoint(closest, 1e-6, om.MSpace.kWorld)

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
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_major_curve", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["lower_minor_1_control_transform", "lower_minor_2_control_transform", "lower_minor_3_control_transform", "lower_minor_4_control_transform", "lower_minor_5_control_transform"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>