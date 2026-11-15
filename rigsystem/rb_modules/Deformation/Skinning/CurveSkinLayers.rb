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

def generateJoints(curve, params, layerName, helpers):
    curveFn = curveShape(curve).mfn(shape=True)
    sizes = {"major": 0.5, "minor": 0.3}
    joints = []
    for i, param in enumerate(params):
        joint = proxy.create("joint", f"{@prefix}_{layerName}_{i + 1}_joint", parent=internalGrp, suffix=False, skipSelection=True)
        point = curveFn.getPointAtParam(param, om.MSpace.kWorld)
        cmds.xform(joint, ws=True, t=(point.x, point.y, point.z))
        cmds.matchTransform(joint, proxy.node(helpers[i]), position=False, rotation=True)
        joint.radius.set(sizes.get(layerName, 1.0))
        joints.append(joint)
    return joints

def generateHelpers(curve, params, layerName, curveType):
    """Create control shape guides at the layer's curve parameters."""
    sizes = {"major": 0.5, "minor": 0.3}
    curveFn = curveShape(curve).mfn(shape=True)
    size = curveFn.length() / (len(params) * 1.5) * sizes.get(layerName, 1.0)
    helpers = []
    for i, param in enumerate(params):
        helper = rig_utils.curve.makeCurve(f"{@prefix}_{layerName}_{i + 1}_control_helper", curveType)
        point = curveFn.getPointAtParam(param, om.MSpace.kWorld)
        helper.t.set((point.x, point.y, point.z))
        helper.s.set((size, size, size))
        helpersGrp | helper
        helpers.append(str(helper))

    return helpers

def generateControls(curve, joints, layerName, helpers, *, addTransform=False):
    """Build controls using the corresponding helper curve shapes."""
    controls = []
    for i, joint in enumerate(joints):
        ctrl = proxy.create("transform", f"{@prefix}_{layerName}_{i + 1}_control", parent=None if addTransform else controlsGrp, suffix=False)
        cmds.matchTransform(ctrl, joint, position=True, rotation=False)
        cmds.matchTransform(ctrl, proxy.node(helpers[i]), position=False, rotation=True)
        cmds.parentConstraint(ctrl, joint)
        ctrl.s >> joint.s

        if addTransform:
            transform = proxy.create("transform", f"{ctrl}_transform", parent=controlsGrp, suffix=False)
            cmds.matchTransform(transform, ctrl)
            transform | ctrl

        rig_utils.setToOffsetParentMatrix(ctrl)
        rig_utils.curve.makeFromCurve(ctrl, proxy.node(helpers[i]))

        if layerName in ("main", "major"):
            rig_utils.lockTRS(ctrl, [], [], [], 1)
        else:
            rig_utils.lockTRS(ctrl, [], [1, 1, 1], [1, 1, 1], 1)
        controls.append(ctrl)
    return controls

def duplicateCurve(curve, layerName):
    duplicate = proxy.node(cmds.duplicate(curveTransform(curve))[0])
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

if @mode == 0:  # helpers
    helpersGrp = proxy.create("transform", f"{@prefix}_helpers", parent=proxy.node("helpers"), suffix=False)
    @set_h_main(generateHelpers(mainCurve, @mainParams, "main", "rect"))
    @set_h_major(generateHelpers(mainCurve, @majorParams, "major", "sphere") if @majorParams else [])
    @set_h_minor(generateHelpers(mainCurve, @minorParams, "minor", "sphere") if @minorParams else [])
    @set_out_finalCurve("")

elif @mode == 1:  # run
    controlsGrp = proxy.create("transform", f"{@prefix}_controls_group", parent=proxy.node("controls"), suffix=False)
    internalGrp = proxy.create("transform", f"{@prefix}_internal_group", parent=proxy.node("internal"), suffix=False)
    othersGrp = proxy.create("transform", f"{@prefix}_others_group", parent=proxy.node("others"), suffix=False)
    rig_utils.lockTRS(controlsGrp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internalGrp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(othersGrp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)
    internalGrp.v.set(False)
    othersGrp.v.set(False)

    othersGrp | curveTransform(mainCurve)

    mainJoints = generateJoints(mainCurve, @mainParams, "main", @h_main)
    skin = cmds.skinCluster(mainJoints, curveTransform(mainCurve), tsb=True, dr=3.0)[0]
    if @mainWeights:
        rig_utils.skinCluster.SkinClusterHelper(skin).fromJson(@mainWeights)
    mainControls = generateControls(mainCurve, mainJoints, "main", @h_main)

    finalCurve = mainCurve
    if @majorParams:
        majorCurve = duplicateCurve(mainCurve, "major")
        majorJoints = generateJoints(majorCurve, @majorParams, "major", @h_major)
        skin = cmds.skinCluster(majorJoints, majorCurve, tsb=True, dr=3.0)[0]
        if @majorWeights:
            rig_utils.skinCluster.SkinClusterHelper(skin).fromJson(@majorWeights)
        majorControls = generateControls(majorCurve, majorJoints, "major", @h_major, addTransform=True)
        attachControls(mainCurve, majorControls)
        makeLocal(majorCurve, majorControls)
        finalCurve = majorCurve

    if @minorParams:
        minorCurve = duplicateCurve(finalCurve, "minor")
        minorJoints = generateJoints(minorCurve, @minorParams, "minor", @h_minor)
        skin = cmds.skinCluster(minorJoints, minorCurve, tsb=True, dr=3.0)[0]
        if @minorWeights:
            rig_utils.skinCluster.SkinClusterHelper(skin).fromJson(@minorWeights)
        minorControls = generateControls(minorCurve, minorJoints, "minor", @h_minor, addTransform=True)
        attachControls(finalCurve, minorControls)
        makeLocal(minorCurve, minorControls)
        finalCurve = minorCurve

    inputCurve = str(@inputCurve).strip()
    if inputCurve:
        internalGrp | curveTransform(inputCurve)
        wireNode = cmds.wire(inputCurve, gw=False, ce=0.0, li=0.0, dds=[0, 100], w=finalCurve, name=f"{inputCurve}_wire")[0]
        baseWireShape = cmds.listConnections(f"{wireNode}.baseWire[0]", s=True, d=False, shapes=True)[0]
        internalGrp | proxy.node(baseWireShape).getParent()

    @set_out_finalCurve(str(finalCurve))
]]></run>
<doc><![CDATA[## Summary
Builds a main skin layer on a NURBS curve, with optional major and minor layers. Helpers mode creates control guides. Run mode skins each enabled layer, attaches its controls to the preceding curve, and optionally wire-deforms the input curve from the last built layer.

## Inputs
- **`mode`**: `Helpers` creates guides; `Run` builds the rig.
- **`prefix`**: Prefix for generated nodes and groups.
- **`mainCurve`**: Existing NURBS curve used as the first skin layer. Run mode moves it under `<prefix>_others_group`.
- **`inputCurve`**: Optional NURBS curve deformed by the final wire. Leave empty to build the skin layers without a wire.
- **`mainParams`**, **`majorParams`**, **`minorParams`**: Curve parameter values for each layer. `mainParams` is required; empty major or minor lists skip that layer.
- **`h_main`**, **`h_major`**, **`h_minor`**: Ordered lists of control shape guides. Helpers mode fills these lists; Run mode uses the guides in the same order as the corresponding parameter lists.
- **`mainWeights`**, **`majorWeights`**, **`minorWeights`**: Optional `SkinClusterHelper` JSON data for each layer; leave empty to keep the initial skin weights.

## Outputs
- Joint and control rotations follow the corresponding helper transforms.
- **`out_finalCurve`**: The last built curve: minor, major, or main, depending on which optional layers have parameters. Filled in Run mode.
- **Helpers mode**: Rectangular main guides and spherical major and minor guides under `helpers/<prefix>_helpers`.
- **Run mode**: Control transforms under `controls/<prefix>_controls_group`, joints and, when provided, the input curve under `internal/<prefix>_internal_group`, and the built layer curves under `others/<prefix>_others_group`. The wire base curve is placed in the internal group when created.
- **Deformation chain**: Each optional layer receives the preceding curve's `local` output. When provided, `inputCurve` is driven by a wire deformer from the last built curve.
- **Local skin bases**: Basis transforms for the major and minor skin clusters are parented under the corresponding control transforms.

## Usage
1. Provide the existing `mainCurve`, optionally set `inputCurve` and `prefix`, and enter valid parameter values for each layer. The scene must contain the top-level `helpers`, `controls`, `internal`, and `others` groups.
2. Set `mode` to **Helpers** and run the module. Adjust the generated guide shapes as needed; their names are stored in `h_main`, `h_major`, and `h_minor`.
3. Set `mode` to **Run** and run the module. It builds the enabled skin layers using those guide shapes and adds the final wire deformer when `inputCurve` is set.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="prefix" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_main_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="inputCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "This curve will be wired", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.5, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="majorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.3, 0.7, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="minorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.1, 0.5, 0.9, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_main" template="listBox" category="Helpers" connect=""><![CDATA[{"items": ["lower_main_1_control_helper", "lower_main_2_control_helper", "lower_main_3_control_helper"], "default": "items"}]]></attr>
<attr name="h_major" template="listBox" category="Helpers" connect=""><![CDATA[{"items": ["lower_major_1_control_helper", "lower_major_2_control_helper", "lower_major_3_control_helper", "lower_major_4_control_helper"], "default": "items"}]]></attr>
<attr name="h_minor" template="listBox" category="Helpers" connect=""><![CDATA[{"items": ["lower_minor_1_control_helper", "lower_minor_2_control_helper", "lower_minor_3_control_helper", "lower_minor_4_control_helper", "lower_minor_5_control_helper"], "default": "items"}]]></attr>
<attr name="mainWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {}, "placeholder": "SkinClusterHelper JSON", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="majorWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {}, "placeholder": "SkinClusterHelper JSON", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="minorWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {}, "placeholder": "SkinClusterHelper JSON", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_finalCurve" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "Final curve", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
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
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_major_curve", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["lower_minor_1_control_transform", "lower_minor_2_control_transform", "lower_minor_3_control_transform", "lower_minor_4_control_transform", "lower_minor_5_control_transform"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>