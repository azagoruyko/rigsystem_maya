<module name="SurfaceSkinLayers" muted="0" uid="87a86bc4fe49483a8f8246922e87fb6b">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy, rig_utils

cmds = proxy.cmds
mainSurface = proxy.node(@mainSurface)
makeSkinLocalMod = module.child("makeSkinLocal")
attachToSurfaceMod = module.child("attachToSurface")


def surfaceShape(surface):
    """Return the NURBS surface shape of a shape or transform."""
    surface = proxy.node(surface)
    return surface.getShapes(type="nurbsSurface")[0] if surface.type() == "transform" else surface


def surfaceTransform(surface):
    """Return the transform of a NURBS surface."""
    surface = proxy.node(surface)
    return surface.getParent() if surface.type() == "nurbsSurface" else surface


def generateJoints(surface, params, layerName, helpers):
    """Place skin joints at the layer's U parameters and the chosen V parameter."""
    surfaceFn = surfaceShape(surface).mfn(shape=True)
    sizes = {"major": 0.5, "minor": 0.3}
    joints = []
    for i, u in enumerate(params):
        joint = proxy.create("joint", f"{@prefix}_{layerName}_{i + 1}_joint", parent=internalGrp, suffix=False, skipSelection=True)
        point = surfaceFn.getPointAtParam(u, @vParam, om.MSpace.kWorld)
        cmds.xform(joint, ws=True, t=(point.x, point.y, point.z))
        cmds.matchTransform(joint, proxy.node(helpers[i]), position=False, rotation=True)
        joint.radius.set(sizes.get(layerName, 1.0))
        joints.append(joint)

    return joints


def generateHelpers(surface, params, layerName, curveType):
    """Create control shape guides at the layer's surface parameters."""
    surfaceFn = surfaceShape(surface).mfn(shape=True)
    sizes = {"major": 0.5, "minor": 0.3}
    start = surfaceFn.getPointAtParam(params[0], @vParam, om.MSpace.kWorld)
    end = surfaceFn.getPointAtParam(params[-1], @vParam, om.MSpace.kWorld)
    size = start.distanceTo(end) / (len(params) * 1.5) * sizes.get(layerName, 1.0)
    helpers = []
    for i, u in enumerate(params):
        helper = rig_utils.curve.makeCurve(f"{@prefix}_{layerName}_{i + 1}_control_helper", curveType)
        surfaceGuide = rig_utils.makeSurfaceTransform(f"{@prefix}_{layerName}_{i + 1}_guide", surface, u, @vParam)
        cmds.matchTransform(helper, surfaceGuide)
        cmds.delete(surfaceGuide)
        helper.s.set((size, size, size))
        helpersGrp | helper
        helpers.append(str(helper))

    return helpers


def generateControls(joints, layerName, helpers, *, addTransform=False):
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

        controls.append(ctrl)

    return controls


def lockControls(controls, layerName):
    """Apply channel locks after control orientation is finalized."""
    for ctrl in controls:
        if layerName in ("main", "major"):
            rig_utils.lockTRS(ctrl, [], [], [], 1)
        else:
            rig_utils.lockTRS(ctrl, [], [1, 1, 1], [1, 1, 1], 1)


def duplicateSurface(surface, layerName):
    """Copy a surface and feed its construction input from the previous layer."""
    duplicate = proxy.node(cmds.duplicate(surfaceTransform(surface))[0])
    duplicate.rename(f"{@prefix}_{layerName}_surface")
    surfaceShape(surface).worldSpace[0] >> surfaceShape(duplicate).create
    return duplicate


def attachControls(surface, controls, helpers):
    """Attach control parents, then restore helper orientations on controls."""
    attachToSurfaceMod.attr.surface.set(str(surface))
    attachToSurfaceMod.attr.transforms.set([str(ctrl.getParent()) for ctrl in controls])
    attachToSurfaceMod.attr.addNewParents.set(False)
    attachToSurfaceMod.run()
    for ctrl, helper in zip(controls, helpers):
        cmds.matchTransform(ctrl, proxy.node(helper), position=False, rotation=True)
        rig_utils.setToOffsetParentMatrix(ctrl)


def makeLocal(surface, controls):
    """Parent the child module's skin bases under the control transforms."""
    makeSkinLocalMod.attr.skinnedGeo.set(str(surface))
    makeSkinLocalMod.run()
    basis = makeSkinLocalMod.attr.out_basis.get()
    for ctrl, basisName in zip(controls, basis):
        ctrl.getParent() | proxy.node(basisName)

if @mode == 0:  # helpers
    helpersGrp = proxy.create("transform", f"{@prefix}_helpers", parent=proxy.node("helpers"), suffix=False)
    @set_h_main(generateHelpers(mainSurface, @mainParams, "main", "rect"))
    @set_h_major(generateHelpers(mainSurface, @majorParams, "major", "sphere") if @majorParams else [])
    @set_h_minor(generateHelpers(mainSurface, @minorParams, "minor", "sphere") if @minorParams else [])
    @set_out_finalSurface("")

elif @mode == 1:  # run
    controlsGrp = proxy.create("transform", f"{@prefix}_controls_group", parent=proxy.node("controls"), suffix=False)
    internalGrp = proxy.create("transform", f"{@prefix}_internal_group", parent=proxy.node("internal"), suffix=False)
    othersGrp = proxy.create("transform", f"{@prefix}_others_group", parent=proxy.node("others"), suffix=False)
    rig_utils.lockTRS(controlsGrp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internalGrp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(othersGrp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)
    internalGrp.v.set(False)
    othersGrp.v.set(False)

    othersGrp | surfaceTransform(mainSurface)

    mainJoints = generateJoints(mainSurface, @mainParams, "main", @h_main)
    skin = cmds.skinCluster(mainJoints, surfaceTransform(mainSurface), tsb=True, dr=3.0)[0]
    if @mainWeights:
        rig_utils.skinCluster.SkinClusterHelper(skin).fromJson(@mainWeights)
    mainControls = generateControls(mainJoints, "main", @h_main)
    lockControls(mainControls, "main")

    finalSurface = mainSurface
    if @majorParams:
        majorSurface = duplicateSurface(mainSurface, "major")
        majorJoints = generateJoints(majorSurface, @majorParams, "major", @h_major)
        skin = cmds.skinCluster(majorJoints, majorSurface, tsb=True, dr=3.0)[0]
        if @majorWeights:
            rig_utils.skinCluster.SkinClusterHelper(skin).fromJson(@majorWeights)
        majorControls = generateControls(majorJoints, "major", @h_major, addTransform=True)
        attachControls(mainSurface, majorControls, @h_major)
        lockControls(majorControls, "major")
        makeLocal(majorSurface, majorControls)
        finalSurface = majorSurface

    if @minorParams:
        minorSurface = duplicateSurface(finalSurface, "minor")
        minorJoints = generateJoints(minorSurface, @minorParams, "minor", @h_minor)
        skin = cmds.skinCluster(minorJoints, minorSurface, tsb=True, dr=3.0)[0]
        if @minorWeights:
            rig_utils.skinCluster.SkinClusterHelper(skin).fromJson(@minorWeights)
        minorControls = generateControls(minorJoints, "minor", @h_minor, addTransform=True)
        attachControls(finalSurface, minorControls, @h_minor)
        lockControls(minorControls, "minor")
        makeLocal(minorSurface, minorControls)
        finalSurface = minorSurface

    inputSurface = str(@inputSurface).strip()
    if inputSurface:
        internalGrp | surfaceTransform(inputSurface)
        wrapNode = rig_utils.createWrap(finalSurface, surfaceTransform(inputSurface))
        baseShape = cmds.listConnections(f"{wrapNode}.basePoints[0]", s=True, d=False, shapes=True)[0]
        internalGrp | proxy.node(baseShape).getParent()

    @set_out_finalSurface(str(finalSurface))
]]></run>
<doc><![CDATA[## Summary
Builds a main skin layer on a NURBS surface, with optional major and minor layers. Helpers mode creates control guides. Run mode skins each enabled layer, attaches its controls to the preceding surface, and optionally wrap-deforms the input surface from the last built layer.

## Inputs
- **`mode`**: `Helpers` creates guides; `Run` builds the rig.
- **`prefix`**: Prefix for generated nodes and groups.
- **`mainSurface`**: Existing NURBS surface for the first skin layer.
- **`inputSurface`**: Optional NURBS surface deformed by the final wrap. Leave empty to build the skin layers without a wrap.
- **`mainParams`**, **`majorParams`**, **`minorParams`**: U parameters for each layer. `mainParams` is required; empty major or minor lists skip that layer.
- **`vParam`**: Shared V parameter for joint and guide placement (default `0.5`).
- **`h_main`**, **`h_major`**, **`h_minor`**: Ordered control shape guides filled by Helpers mode and used by Run mode.
- **`mainWeights`**, **`majorWeights`**, **`minorWeights`**: Optional `SkinClusterHelper` JSON data for each layer; leave empty to keep the initial skin weights.

## Outputs
- Joint and control rotations follow the corresponding helper transforms. After surface attachment, controls are realigned to helpers and their orientation is baked into `offsetParentMatrix`.
- **`out_finalSurface`**: The last built surface: minor, major, or main, depending on which optional layers have parameters. Filled in Run mode.
- Helpers mode creates guides under `helpers/<prefix>_helpers`.
- Run mode creates controls under `controls/<prefix>_controls_group`, joints and, when provided, the input surface under `internal/<prefix>_internal_group`, and the layered surfaces under `others/<prefix>_others_group`.
- Each optional layer receives the preceding surface's `worldSpace` output. When provided, `inputSurface` is driven by a wrap deformer from the last built surface.
- Major and minor skin bind bases are parented under their control transforms.

## Usage
1. Provide an existing `mainSurface` transform, optionally set `inputSurface`, and enter valid U and V parameters. The scene needs top-level `helpers`, `controls`, `internal`, and `others` groups.
2. Run Helpers mode and adjust the generated guide shapes.
3. Run Run mode to build the enabled skin layers using those guides. The final wrap is added when `inputSurface` is set.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="prefix" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "spine", "placeholder": "", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainSurface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "NURBS surface", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="inputSurface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "This surface will be wrapped", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.5, 1], "placeholder": "U parameters", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="majorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.3, 0.7, 1], "placeholder": "U parameters", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="minorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.1, 0.5, 0.9, 1], "placeholder": "U parameters", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="vParam" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0.5, "placeholder": "V parameter", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_main" template="listBox" category="Helpers" connect=""><![CDATA[{"items": ["spine_main_1_control_helper", "spine_main_2_control_helper", "spine_main_3_control_helper"], "default": "items"}]]></attr>
<attr name="h_major" template="listBox" category="Helpers" connect=""><![CDATA[{"items": ["spine_major_1_control_helper", "spine_major_2_control_helper", "spine_major_3_control_helper", "spine_major_4_control_helper"], "default": "items"}]]></attr>
<attr name="h_minor" template="listBox" category="Helpers" connect=""><![CDATA[{"items": ["spine_minor_1_control_helper", "spine_minor_2_control_helper", "spine_minor_3_control_helper", "spine_minor_4_control_helper", "spine_minor_5_control_helper"], "default": "items"}]]></attr>
<attr name="mainWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {}, "placeholder": "SkinClusterHelper JSON", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="majorWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {}, "placeholder": "SkinClusterHelper JSON", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="minorWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {}, "placeholder": "SkinClusterHelper JSON", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_finalSurface" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "Final surface", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
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
<attr name="skinnedGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "spine_minor_surface", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_basis" template="listBox" category="General" connect=""><![CDATA[{"items": ["spine_minor_1_joint_basis", "spine_minor_2_joint_basis", "spine_minor_3_joint_basis", "spine_minor_4_joint_basis", "spine_minor_5_joint_basis"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="attachToSurface" muted="1" uid="b21c578b1b144f4e9fe06ec449961b0f">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds
surface = proxy.node(@surface)
surfaceShape = surface.getShapes(type="nurbsSurface")[0] if surface.type() == "transform" else surface
transforms = proxy.nodes(@transforms)

cpos = proxy.create("closestPointOnSurface", "attachToSurface_cpos_tmp", suffix=False)
surfaceShape.worldSpace[0] >> cpos.inputSurface

for t in transforms:
    pos = cmds.xform(str(t), q=True, ws=True, t=True)
    cpos.inPosition.set(pos)
    u = cpos.parameterU.get()
    v = cpos.parameterV.get()

    if @addNewParents:
        parent = t.getParent()
        st = rig_utils.makeSurfaceTransform(str(t), surface, u, v)
        if parent:
            cmds.parent(str(st), str(parent))
        cmds.parent(str(t), str(st))
    else:
        rig_utils.attachTransformToSurface(str(t), surface, u, v)

cmds.delete(str(cpos))
]]></run>
<doc><![CDATA[## Summary
Attaches a list of transform nodes to a NURBS surface by computing the closest surface parameters for each transform. Optionally creates intermediate surface‑aligned transform nodes that become the new parents of the original transforms.

## Inputs
- **`surface`** (`node`): The NURBS surface (or its transform) to which the transforms will be attached.  
- **`transforms`** (`list[node]`): A list of transform nodes whose world positions will be projected onto the surface.  
- **`addNewParents`** (`bool`): If `True`, a new surface‑aligned transform is created for each input transform and becomes its parent; otherwise the original transform is directly attached to the surface.

## Outputs
- The input **`transforms`** are re‑parented or attached to the specified **`surface`**.  
- When **`addNewParents`** is `True`, a new surface‑aligned transform node is created for each input transform and becomes its parent.  
- No explicit output attributes are produced; the module’s effect is the side‑effect on the scene hierarchy.

## Usage
1. Connect a NURBS surface node to the **`surface`** input.  
2. Provide a list of transform nodes to **`transforms`**.  
3. Set **`addNewParents`** to `True` if you want each transform to be wrapped in a surface‑aligned parent; leave it `False` to attach the transforms directly.  
4. Execute the module. The transforms will be positioned on the surface and, if requested, re‑parented under new surface‑aligned nodes.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS surface</b> using closest point projection."}]]></attr>
<attr name="surface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "spine_major_surface", "placeholder": "NURBS surface name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["spine_minor_1_control_transform", "spine_minor_2_control_transform", "spine_minor_3_control_transform", "spine_minor_4_control_transform", "spine_minor_5_control_transform"], "default": "items"}]]></attr>
<attr name="addNewParents" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
</attributes>
</module>
</children>
</module>