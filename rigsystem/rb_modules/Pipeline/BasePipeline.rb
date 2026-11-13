<module name="BasePipeline" muted="0" uid="316be58f77c24c2682d2652ef7c64088">
<doc><![CDATA[## Summary
A collection of tools for fitting and building a rig. Run individual child modules as needed.

## Inputs
None.

## Outputs
None.

## Usage
Open the relevant group and run a specific child module.]]></doc>
<children>
<module name="Fitting" muted="0" uid="">
<children>
<module name="RigHierarchy" muted="0" uid="54888fff338a4a049762cbeb3377f929">
<run><![CDATA[from rigsystem import proxy, rig_utils, anim_utils

cmds = proxy.cmds

rigt = proxy.create("transform", "rig", suffix=False)
rig_utils.lockTRS(rigt, v=0.5)

transform = proxy.create("transform", "transform", parent=rigt, suffix=False)

internal = proxy.create("transform", "internal", parent=transform, suffix=False)
rig_utils.lockTRS(internal, v=0.5)

controls = proxy.create("transform", "controls", parent=transform, suffix=False)
rig_utils.lockTRS(controls, v=0.5)

skeleton = proxy.create("transform", "skeleton", parent=transform, suffix=False)
rig_utils.lockTRS(skeleton, v=0.5)

geometry = proxy.create("transform", "geometry", parent=rigt, suffix=False)
rig_utils.lockTRS(geometry, v=0.5)

others = proxy.create("transform", "others", parent=rigt, suffix=False)
rig_utils.lockTRS(others, v=0.5)

helpers = proxy.create("transform", "helpers", parent=rigt, suffix=False)
rig_utils.lockTRS(helpers, v=0.5)

main_control = proxy.create("transform", "main_control", parent=rigt, suffix=False)
helper = rig_utils.curve.makeCurve(str(main_control), "circle")
helper.s.set([5,5,5])
rig_utils.curve.makeFromCurve(main_control, helper)
cmds.delete(helper)

main_control.addAttr(ln="scaleFactor", min=0.01, dv=1, k=True)

main_control.scaleFactor >> main_control.sx
main_control.scaleFactor >> main_control.sy
main_control.scaleFactor >> main_control.sz

cmds.parentConstraint(main_control, transform, mo=True)
main_control.s >> transform.s

rig_utils.lockTRS(transform, v=0.5)
rig_utils.lockTRS(main_control, [], [], [1, 1, 1], 1)

anim_utils.dynamicParent.makeDynamicParent(main_control, main_control)

# root joint
rootJoint = proxy.create("joint", "root", parent=skeleton, suffix=False)
cmds.parentConstraint(main_control, rootJoint)
cmds.scaleConstraint(main_control, rootJoint)

moduleInfo = rig_utils.moduleInfo.ModuleInfo("rig")
moduleInfo.setAttr("type", "rig")
moduleInfo.setAttr("main_control", main_control.message)

    ]]></run>
<doc><![CDATA[## Summary
Creates a basic rig hierarchy with a main control, root joint, and supporting transform nodes, sets up constraints and dynamic parenting, and publishes a `moduleInfo` node for downstream modules.

## Inputs
- **None** – The module does not require any external inputs; all nodes are created internally.

## Outputs
- **`main_control`** – The primary control transform that drives the rig and is exposed via the `moduleInfo` node.
- **`rootJoint`** – The root joint of the skeleton, parented to the `skeleton` transform and constrained to `main_control`.
- **`moduleInfo`** – A `ModuleInfo` node named `"rig"` that stores the rig type and a message reference to `main_control`.
- **Rig hierarchy nodes** – `rigt`, `transform`, `internal`, `controls`, `skeleton`, `geometry`, `others`, `helpers`, and the dynamic parent node created by `anim_utils.dynamicParent.makeDynamicParent`.

## Usage
1. Execute the module; it will automatically create the rig hierarchy and publish the `moduleInfo` node.
2. The `main_control` can be positioned and scaled in the scene; its scale factor attribute controls the size of the control.
3. Downstream modules can connect to the `moduleInfo` node or directly to `rootJoint`/`main_control` to attach additional rig components.]]></doc>
</module>
<module name="ImportBipedBodyTemplate" muted="0" uid="">
<run><![CDATA[import os
import maya.cmds as cmds

template_path = os.path.join(os.environ["RIGSYSTEM_PATH"], "library", "biped_body_template.ma")
cmds.file(
    template_path,
    i=True,
    ignoreVersion=True,
    namespace=":",
    mergeNamespacesOnClash=False,
)]]></run>
<doc><![CDATA[## Summary
Imports the biped skeleton and helper template into the current Maya scene.

## Inputs
None. Uses the RigSystem scene library.

## Outputs
Adds the template nodes to the current Maya scene.

## Usage
Open the source scene and run this module once.]]></doc>
</module>
<module name="Symmetrize" muted="0" uid="62f2ec7d17484555ac960a629f02463f">
<run><![CDATA[from rigsystem import proxy
from rigsystem.rig_utils.general import symmetrizeJoint

for j in proxy.nodes(proxy.cmds.ls(selection=True, type=["transform", "joint"]) or []):
    symmetrizeJoint(j)]]></run>
<doc><![CDATA[## Summary
This module mirrors or symmetrizes the currently selected joints or transform nodes in the scene, creating or updating the corresponding opposite-side counterparts.

## Inputs
- **Selection**: Any number of transform or joint nodes selected in the viewport before executing the module.

## Outputs
- **Symmetrized Joints**: For each selected node, a mirrored joint (or transform) is created or updated on the opposite side of the character, preserving hierarchy and attributes as defined by `symmetrizeJoint`.

## Usage
1. In the Maya viewport, select the joint or transform nodes you wish to symmetrize.
2. Run the module (e.g., via the Rig Builder UI or a script).
3. The module will call `symmetrizeJoint` on each selected node, producing mirrored counterparts.
4. Verify the new joints appear on the opposite side and are correctly connected to the existing rig hierarchy.]]></doc>
</module>
<module name="MirrorCurves" muted="0" uid="c1f83e2098ab4b32a1290f845a7698bd">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds
if @useSelected:
    selection = proxy.nodes(cmds.ls(sl=True, type="transform") or [])
    if not selection:
        shapeSel = proxy.nodes(cmds.ls(sl=True, type="nurbsCurve") or [])
        selection = [shape.getParent() for shape in shapeSel]
else:
    selection = proxy.nodes(cmds.ls(type="transform") or [])

if not selection:
    warning("mirrorCurves: No curve transforms selected or found.")

processed = set()
for item in selection:
    shapes = item.getShapes(type="nurbsCurve")
    if not shapes:
        continue

    name = str(item)
    if name in processed:
        continue

    if @direction == "Left to Right" and not rig_utils.naming.isLeftSide(name):
        continue
    elif @direction == "Right to Left" and not rig_utils.naming.isRightSide(name):
        continue

    dest = rig_utils.curve.mirrorCurveShape(item)
    if dest:
        processed.add(str(item))
        processed.add(str(dest))
]]></run>
<doc><![CDATA[## Summary
Mirrors the shape of selected NURBS curve transforms across a chosen axis, optionally filtering by side (left/right) and direction. The module updates the CV positions of the target curves in place, ensuring symmetric topology and geometry.

## Inputs
- **`useSelected`** (`checkBox`):
  When checked, only the curves currently selected in the scene are processed. If unchecked, all transform nodes in the scene are considered.
- **`axis`** (`comboBox`):
  The axis across which the mirroring occurs. Options are **X**, **Y**, or **Z**.
- **`direction`** (`comboBox`):
  Determines which curves are mirrored:
  - **Selected to Opposite** – mirrors each selected curve to its symmetric counterpart.
  - **Left to Right** – only processes curves whose names indicate a left side.
  - **Right to Left** – only processes curves whose names indicate a right side.

## Outputs
- The module does not create new nodes; it **modifies the CV positions of the existing curve shapes** in the scene.
- Any curves that are successfully mirrored are marked as processed to avoid duplicate work.

## Usage
1. **Select Curves**
   - If `useSelected` is checked, select the curve transforms you wish to mirror.
   - If unchecked, the module will iterate over all transform nodes in the scene.
2. **Set Parameters**
   - Choose the mirroring **axis** (X, Y, or Z).
   - Pick the **direction**:
     - *Selected to Opposite* to mirror each curve to its symmetric counterpart.
     - *Left to Right* or *Right to Left* to filter curves by side before mirroring.
3. **Run the Module**
   - Execute the module. It will locate the opposite curve names using the naming convention, verify topology, and update the CV positions symmetrically across the chosen axis.
4. **Verify**
   - Inspect the mirrored curves in the viewport to confirm that their shapes are now symmetric.
   - If any curves were not mirrored, check the warning log for missing or mismatched names.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Select left/right curves to find opposite curves (via naming) and update their shape symmetrically."}]]></attr>
<attr name="useSelected" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="direction" template="comboBox" category="General" connect=""><![CDATA[{"current": "Selected to Opposite", "default": "current", "items": ["Selected to Opposite", "Left to Right", "Right to Left"]}]]></attr>
</attributes>
</module>
<module name="MirrorAverageValues" muted="0" uid="e7f568dc08e241e09d741aa978e51e5f">
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
<module name="UpdateAverageBaseAngle" muted="0" uid="9b6ba97ecdbf4974997680e52cad5502">
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
<module name="MatrixToOffsetParentMatrix" muted="0" uid="18853f5b0d0c472791a6371f8c6b5838">
<run><![CDATA[from rigsystem import proxy, rig_utils

selected = proxy.nodes(proxy.cmds.ls(selection=True, type=["transform", "joint"]) or [])

if @mode == 0: # to
    for t in selected:
        if t.offsetParentMatrix.inputs():
            warning(f"{t}.offsetParentMatrix has inputs, skipped")
            continue

        rig_utils.setToOffsetParentMatrix(t)

else: # from
    for t in selected:
        rig_utils.setFromOffsetParentMatrix(t)]]></run>
<doc><![CDATA[## Summary
This module transfers the current matrix of selected transform nodes into their `offsetParentMatrix` attribute (mode 0) or restores the original matrix from the `offsetParentMatrix` (mode 1). It is useful for baking or unbaking offset transforms in a Maya scene.

## Inputs
- **`mode`** (integer):
  - `0` – **To**: Copy the current world matrix into `offsetParentMatrix` and reset the node’s world matrix to identity.
  - `1` – **From**: Restore the world matrix from `offsetParentMatrix` and clear the offset.
- **Selection**: The module operates on all currently selected transform nodes. It checks that each node has no incoming connections on its `offsetParentMatrix` before proceeding.

## Outputs
- The selected transform nodes have their `offsetParentMatrix` and world matrix values updated according to the chosen mode. No new nodes or attributes are created; the operation only modifies existing transform data.

## Usage
1. Select the transform nodes you wish to bake or unbake.
2. Set the module’s `mode` attribute to `0` to bake the current world matrix into the offset, or to `1` to restore the original world matrix.
3. Execute the module.
4. Verify that the transforms’ world matrices and `offsetParentMatrix` values reflect the intended state.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["To", "From"], "current": 0, "columns": 3, "default": "current"}]]></attr>
</attributes>
</module>
</children>
</module>
<module name="Controls" muted="0" uid="">
<children>
<module name="MatrixToOffsetParentMatrix" muted="0" uid="18853f5b0d0c472791a6371f8c6b5838">
<run><![CDATA[from rigsystem import proxy, rig_utils

selected = proxy.nodes(proxy.cmds.ls(selection=True, type=["transform", "joint"]) or [])

if @mode == 0: # to
    for t in selected:
        if t.offsetParentMatrix.inputs():
            warning(f"{t}.offsetParentMatrix has inputs, skipped")
            continue

        rig_utils.setToOffsetParentMatrix(t)

else: # from
    for t in selected:
        rig_utils.setFromOffsetParentMatrix(t)]]></run>
<doc><![CDATA[## Summary
This module transfers the current matrix of selected transform nodes into their `offsetParentMatrix` attribute (mode 0) or restores the original matrix from the `offsetParentMatrix` (mode 1). It is useful for baking or unbaking offset transforms in a Maya scene.

## Inputs
- **`mode`** (integer):
  - `0` – **To**: Copy the current world matrix into `offsetParentMatrix` and reset the node’s world matrix to identity.
  - `1` – **From**: Restore the world matrix from `offsetParentMatrix` and clear the offset.
- **Selection**: The module operates on all currently selected transform nodes. It checks that each node has no incoming connections on its `offsetParentMatrix` before proceeding.

## Outputs
- The selected transform nodes have their `offsetParentMatrix` and world matrix values updated according to the chosen mode. No new nodes or attributes are created; the operation only modifies existing transform data.

## Usage
1. Select the transform nodes you wish to bake or unbake.
2. Set the module’s `mode` attribute to `0` to bake the current world matrix into the offset, or to `1` to restore the original world matrix.
3. Execute the module.
4. Verify that the transforms’ world matrices and `offsetParentMatrix` values reflect the intended state.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["To", "From"], "current": 0, "columns": 3, "default": "current"}]]></attr>
</attributes>
</module>
<module name="MakeCurveShape" muted="0" uid="1f5e3d986051407397d0b580e70ef628">
<run><![CDATA[from rigsystem import rig_utils
rig_utils.curve.makeCurve(@name, @curveType)]]></run>
<doc><![CDATA[## Summary
Creates a curve node with a user‑defined name and shape, positioned at the current selection or a specified transform. The curve can be used as a visual reference or as a target for constraints and connections.

## Inputs
- **`name`** (`lineEditAndButton`): The desired name for the curve node (e.g., `L_bracer`).
- **`curveType`** (`comboBox`): The shape of the curve to generate. Options include `arc`, `arrow`, `axis`, `axisSphere`, `cube`, `circle`, `diamond`, `key`, `pyramid`, `rect`, `sphere`, `triangle`, and `plus`. The default is `triangle`.

## Outputs
- **Curve Node**: A new curve node created in the scene with the specified `name` and `curveType`. This node can be used as a visual guide, constraint target, or reference transform for downstream modules.

## Usage
1. Set the **`name`** attribute to the desired node name.
2. Choose a **`curveType`** from the dropdown to define the visual shape.
3. Execute the module.
4. The created curve will appear in the scene; you can parent, constrain, or connect it to other rig components as needed.]]></doc>
<attributes>
<attr name="curveType" template="comboBox" category="General" connect=""><![CDATA[{"items": ["arc", "arrow", "arrowCircle", "axis", "axisSphere", "circle", "cube", "diamond", "flag", "gear", "guide", "key", "main", "plus", "pyramid", "rect", "sphere", "triangle"], "current": "rect", "default": "current"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import os\nfrom rigsystem import rig_utils\n\ncurves = sorted(\n    os.path.splitext(filename)[0]\n    for filename in os.listdir(rig_utils.curve.CurvesPath)\n    if filename.endswith(\".json\")\n)\ncurrent = ch(\"/curveType\")\nif current not in curves:\n    chset(\"/curveType\", curves[0] if curves else \"\", \"current\")\n\nchset(\"/curveType\", curves, \"items\")", "label": "Get All Curves", "color": "", "default": "command"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="CreateFKControls" muted="0" uid="2583b3b8a41a4ee6b2235c66a1acfd28">
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
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["M_belt_waist_vert_1_joint", "M_belt_waist_vert_2_joint", "M_belt_waist_vert_3_joint"], "default": "items"}]]></attr>
<attr name="orientation" template="radioButton" category="General" connect=""><![CDATA[{"items": ["world", "joint"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="helper" template="comboBox" category="General" connect=""><![CDATA[{"items": ["circle", "rect", "sphere", "cube"], "current": "circle", "default": "current"}]]></attr>
<attr name="connectScale" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="setParent" template="radioButton" category="General" connect=""><![CDATA[{"items": ["none", "hierarchy"], "current": 1, "columns": 2, "default": "current"}]]></attr>
</attributes>
</module>
<module name="MakeCorrectiveControl" muted="0" uid="e8b9c7463d6f4ef99a6aee1aeddf43fb">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds

makeHelperMod = module.child("makeHelper")
compClusterMod = module.child("compensationCluster")

compClusterMod.run()
parentHandle = proxy.node(compClusterMod.attr.out_parent.get())
handle = proxy.node(compClusterMod.attr.out_handle.get())
deformer = proxy.node(compClusterMod.attr.out_deformer.get())

makeHelperMod.run()

transform = proxy.create("transform", f"{@name}_control_transform", suffix=False)
cmds.matchTransform(str(transform), str(handle))

ctrl = proxy.node(makeHelperMod.attr.name.get())
transform | ctrl
cmds.matchTransform(str(ctrl), str(handle))
rig_utils.setToOffsetParentMatrix(ctrl)
rig_utils.lockAttr(ctrl.v, 1)

ctrl | parentHandle

if @type == "softMod":
    ctrl.addAttr(ln="radius", min=0, dv=@deformRadius, k=True)
    ctrl.radius.connect(deformer.falloffRadius)

ctrl.t.connect(handle.t)
ctrl.r.connect(handle.r)
ctrl.s.connect(handle.s)

@set_out_control(str(ctrl))]]></run>
<doc><![CDATA[## Summary
This module builds a compensation cluster deformer on the currently selected geometry and creates a helper control that follows the cluster handle. The helper’s transform and radius are wired to the cluster deformer, allowing the control to drive the cluster’s fall‑off and maintain mesh volume during extreme joint rotations.

## Inputs
- **`name`** (`lineEditAndButton`): Base name used for the cluster deformer and the helper control (e.g., `R_shoulder_cluster`).
- **`deformRadius`** (`lineEditAndButton`): Default radius value that will be assigned to the helper control’s `radius` attribute and connected to the cluster deformer’s `falloffRadius`.
- **Selection**: Geometry must be selected in the scene before running the module; it will be clustered by the compensation cluster child.

## Outputs
- **Compensation Cluster Deformer** (`<name>_cluster`): Deformer node with envelope set to 0.99999 and manual matrix control.
- **Compensation Transform Hierarchy** (`<name>_compensation_transform` & `<name>_transform`): Transforms that drive the cluster’s weighted, pre, and post matrices via a scriptJob.
- **Helper Control** (`<name>`): A curve/locator node positioned at the cluster handle, parented to the compensation transform, with its `t`, `r`, `s` attributes driving the cluster handle and a `radius` attribute controlling the deformer’s fall‑off.
- **ScriptJob**: Keeps the cluster matrices updated during idle time.
- **Attribute**: Sets `out_control` to be the generated control.

## Usage
1. **Set the `name` attribute** to a unique identifier for the cluster and helper (e.g., `R_shoulder_cluster`).
2. **Set the `deformRadius` attribute** to the desired default radius for the helper control.
3. **Select the geometry** you want to protect from volume collapse.
4. **Run the module**. It will create the compensation cluster, the helper control, and wire the control’s transform and radius to the cluster deformer.
5. **Adjust the helper control** in the viewport to fine‑tune the cluster’s influence, or connect the generated nodes to downstream deformation or rigging modules.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_shirt_sleeve_front", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="curveType" template="comboBox" category="General" connect=""><![CDATA[{"items": ["arc", "arrow", "axis", "axisSphere", "cube", "circle", "diamond", "key", "pyramid", "rect", "sphere", "triangle", "plus"], "current": "sphere", "default": "current"}]]></attr>
<attr name="deformRadius" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 15, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 2, "default": "value"}]]></attr>
<attr name="type" template="comboBox" category="General" connect=""><![CDATA[{"items": ["cluster", "softMod"], "current": "softMod", "default": "current"}]]></attr>
<attr name="out_control" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="makeHelper" muted="1" uid="1f5e3d986051407397d0b580e70ef628">
<run><![CDATA[from rigsystem import rig_utils
rig_utils.curve.makeCurve(@name, @curveType)]]></run>
<doc><![CDATA[## Summary
Creates a curve node with a user‑defined name and shape, positioned at the current selection or a specified transform. The curve can be used as a visual reference or as a target for constraints and connections.

## Inputs
- **`name`** (`lineEditAndButton`): The desired name for the curve node (e.g., `L_bracer`).
- **`curveType`** (`comboBox`): The shape of the curve to generate. Options include `arc`, `arrow`, `axis`, `axisSphere`, `cube`, `circle`, `diamond`, `key`, `pyramid`, `rect`, `sphere`, `triangle`, and `plus`. The default is `triangle`.

## Outputs
- **Curve Node**: A new curve node created in the scene with the specified `name` and `curveType`. This node can be used as a visual guide, constraint target, or reference transform for downstream modules.

## Usage
1. Set the **`name`** attribute to the desired node name.
2. Choose a **`curveType`** from the dropdown to define the visual shape.
3. Execute the module.
4. The created curve will appear in the scene; you can parent, constrain, or connect it to other rig components as needed.]]></doc>
<attributes>
<attr name="curveType" template="comboBox" category="General" connect="/curveType"><![CDATA[{"items": ["arc", "arrow", "arrowCircle", "axis", "axisSphere", "circle", "cube", "diamond", "flag", "gear", "guide", "key", "main", "plus", "pyramid", "rect", "sphere", "triangle"], "current": "sphere", "default": "current"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import os\nfrom rigsystem import rig_utils\n\ncurves = sorted(\n    os.path.splitext(filename)[0]\n    for filename in os.listdir(rig_utils.curve.CurvesPath)\n    if filename.endswith(\".json\")\n)\ncurrent = ch(\"/curveType\")\nif current not in curves:\n    chset(\"/curveType\", curves[0] if curves else \"\", \"current\")\n\nchset(\"/curveType\", curves, \"items\")", "label": "Get All Curves", "color": "", "default": "command"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_shirt_sleeve_front_control", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value", "_expression": "value = ch(\"../name\") + \"_control\""}]]></attr>
</attributes>
</module>
<module name="compensationCluster" muted="1" uid="e3bfce6c327f4c16ad859bea29ba1dcb">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds

if @type == "cluster":
    deformer, handle = proxy.nodes(cmds.cluster(name=f"{@name}_cluster"))
    deformer.clusterXforms.disconnect(handle.clusterTransforms[0])

elif @type == "softMod":
    deformer, handle = proxy.nodes(cmds.softMod(name=f"{@name}_softMod"))
    deformer.softModXforms.disconnect(handle.softModTransforms[0])
    deformer.falloffMasking.set(0)
    deformer.falloffAroundSelection.set(1)

deformer.envelope.set(0.99999) # when 1 deformer doesn't work, maybe bug
deformer.matrix.disconnect(handle.worldMatrix)

parent = proxy.create("transform", f"{@name}_compensation")
child = proxy.create("transform", f"{@name}", parent=parent)
parent.t.set(cmds.xform(str(handle), q=True, ws=True, rp=True))
cmds.delete(str(handle))

def callback():
    child.matrix >> deformer.weightedMatrix
    parent.worldInverseMatrix[0] >> deformer.postMatrix
    parent.worldMatrix[0] >> deformer.preMatrix

cmds.scriptJob(runOnce=True, event=("idle", callback))

@set_out_parent(str(parent))
@set_out_handle(str(child))
@set_out_deformer(str(deformer))

]]></run>
<doc><![CDATA[## Summary
Creates a compensation cluster deformer that mitigates mesh volume collapse during extreme joint rotations. The module generates a cluster deformer, a compensation transform hierarchy, and a scriptJob that keeps the cluster matrices updated.

## Inputs
- **`name`** (string): Base name used for the cluster deformer and the two transform nodes (`<name>_cluster`, `<name>_compensation_transform`, `<name>_transform`).
- **Selection**: The geometry to be clustered must be selected in the scene before executing the module.

## Outputs
- **Cluster Deformer** (`<name>_cluster`): Deformer node with envelope set to 0.99999 and matrix connections removed for manual control.
- **Compensation Transform** (`<name>_compensation_transform`): Parent transform positioned at the cluster handle’s world position.
- **Child Transform** (`<name>_transform`): Child of the compensation transform, used to drive the cluster’s weighted, pre, and post matrices.
- **ScriptJob**: Keeps the cluster’s weightedMatrix, preMatrix, and postMatrix attributes linked to the compensation transform’s matrices during idle time.

## Usage
1. **Select the geometry** you want to protect from volume collapse.
2. **Set the `name` attribute** to a unique identifier for the cluster (e.g., `R_shoulder_cluster`).
3. **Run the module**. It will create the cluster deformer, compensation transform hierarchy, and a scriptJob that updates the matrices automatically.
4. **Adjust the cluster envelope** or the compensation transform as needed to fine‑tune the deformation.
5. **Optional**: Connect the created nodes to other rig elements or use them as part of a larger deformation strategy.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect="/name"><![CDATA[{"value": "R_shirt_sleeve_front", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="type" template="comboBox" category="General" connect="/type"><![CDATA[{"items": ["cluster", "softMod"], "current": "softMod", "default": "current"}]]></attr>
<attr name="out_parent" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_handle" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_deformer" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
</children>
</module>
</children>
</module>
<module name="Deform" muted="0" uid="">
<children>
<module name="CopySkin" muted="0" uid="f9211b6431fe4eae97f8f06a2e7fadd9">
<run><![CDATA[import maya.mel as mel
from rigsystem import proxy

cmds = proxy.cmds
import os


def get_influence_list(m_node):
    cmds.select(m_node, replace=True)
    mel.eval("RemoveUnusedInfluences")
    skin = mel.eval('findRelatedSkinCluster "{}"'.format(m_node))
    return cmds.skinCluster(skin, weightedInfluence=True, query=True) or []

def apply_influence_list(m_node, influences):
    cmds.skinCluster(influences, m_node, bm=1, sm=0, tsb=True)

def copy_skin(m_node, m_node_list):
    influences = get_influence_list(m_node)
    sourceSkinCluster = mel.eval('findRelatedSkinCluster "{}"'.format(m_node))

    for n in m_node_list:
        apply_influence_list(n, influences)
        destSkinCluster = mel.eval('findRelatedSkinCluster "{}"'.format(n))

        ##if @by_vertex_ID:
            ##set_vtx_weights(destination, get_vtx_weights_list(source))
        ##else:
            ##cmds.copySkinWeights(ss=sourceSkinCluster, ds=destSkinCluster, noMirror=True)
        cmds.copySkinWeights(ss=sourceSkinCluster, ds=destSkinCluster, noMirror=True)

def get_vtx_weights_list(m_node):
    skin_cluster = mel.eval('findRelatedSkinCluster "{}"'.format(m_node))
    influences = cmds.skinCluster(skin_cluster, query=True, influence=True) or []
    vertex_count = cmds.polyEvaluate(m_node, vertex=True)
    weights = []
    for index in range(vertex_count):
        vertex = "{}.vtx[{}]".format(m_node, index)
        values = cmds.skinPercent(skin_cluster, vertex, query=True, value=True) or []
        weights.append(dict(zip(influences, values)))
    return weights

def set_vtx_weights(m_node, weights_list):
    skin_cluster = mel.eval('findRelatedSkinCluster "{}"'.format(m_node))
    for index, weights in enumerate(weights_list):
        vertex = "{}.vtx[{}]".format(m_node, index)
        cmds.skinPercent(
            skin_cluster,
            vertex,
            transformValue=list(weights.items()),
        )


copy_skin(@source_mesh, @destination_mesh)]]></run>
<doc><![CDATA[## Summary
Copies skin cluster influence weights from a source mesh to one or more destination meshes, ensuring that the destination geometry receives the same skinning data as the source. The module uses Maya’s `copySkinWeights` command and automatically creates or updates skin clusters on the target meshes.

## Inputs
- **`source_mesh`** – Name of the source mesh geometry that already has a skin cluster.
- **`destination_mesh`** – List of one or more target mesh objects that will receive the skin weights. The destination meshes must have the same number of influences as the source; otherwise the copy will fail.

## Outputs
- The destination meshes are updated with a skin cluster that contains the same influences and vertex weight values as the source mesh.
- No new nodes or data containers are created; the operation modifies the existing geometry directly.

## Usage
1. **Select the source mesh** in the scene and set the `source_mesh` field to its name (or use the `<` button to pick it).
2. **Choose one or more destination meshes** from the `destination_mesh` list box.
3. Click **Run** (or execute the module from the UI).
4. After execution, verify that the destination meshes now share the same skin weights as the source.
5. If the destination meshes already have a skin cluster, the weights will be overwritten; if they do not, a new skin cluster will be created automatically.
6. Ensure that the influence count matches between source and destination; otherwise the copy will raise an error.]]></doc>
<attributes>
<attr name="info" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Copies skin from one mesh to another using same influence num"}]]></attr>
<attr name="source_mesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "body_base"}]]></attr>
<attr name="destination_mesh" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["Geometry|body|neck_1_geo|neck_1_geoShape", "arm_10_geo", "arm_9_geo", "arm_8_geo", "arm_7_geo", "arm_6_geo", "arm_5_geo", "arm_4_geo", "arm_3_geo", "arm_2_geo", "arm_1_geo", "foot_3_geo", "foot_2_geo", "foot_1_geo", "ankle_geo", "leg_11_geo", "leg_10_geo", "leg_9_geo", "leg_8_geo", "leg_7_geo", "leg_6_geo", "leg_5_geo", "leg_4_geo", "leg_3_geo", "leg_2_geo", "leg_1_geo", "pelvis_2_geo", "pelvis_1_geo", "spine_4_geo", "spine_3_geo", "Geometry|body|spine_2_geo", "Geometry|body|spine_1_geo", "chest_6_geo", "chest_5_geo", "chest_4_geo", "chest_3_geo", "chest_2_geo", "chest_1_geo", "neck_3_geo", "Geometry|body|neck_2_geo", "Geometry|body|neck_1_geo"]}]]></attr>
</attributes>
</module>
<module name="BindMode" muted="0" uid="c7ae99e054f94721afc9256cf449e180">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
joints = proxy.nodes(@joints)
selectedSkins = set(proxy.nodes(@skins))

if not joints and selectedSkins:
    influences = {
        name
        for skin in selectedSkins
        for name in cmds.skinCluster(str(skin), query=True, influence=True) or []
    }
    joints = proxy.nodes(sorted(influences))

def getJointsSkinClusters(joint):
    return {plug.node for plug in joint.worldMatrix.outputs(type="skinCluster")}

def influenceIndex(skin, joint):
    return skin.mfn().indexForInfluenceObject(joint.mdagpath)

if @mode == 0: # unbind
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            preMatrix = skin.bindPreMatrix[idx]
            if not preMatrix.inputs():
                j.worldInverseMatrix[0] >> preMatrix

    print("Unbinded")
    @set_mode(1)
else:
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            matrix = j.worldInverseMatrix[0].get()

            if cmds.isConnected(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx])):
                cmds.disconnectAttr(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx]))
                skin.bindPreMatrix[idx].set(matrix)

    print("Binded")
    @set_mode(0)
        ]]></run>
<doc><![CDATA[## Summary
BindMode updates bind pre-matrices for the listed joints. Unbind connects each joint's world inverse matrix to its bind pre-matrix so the joint can be repositioned without moving the skinned geometry. Bind disconnects that link and stores the joint's current world inverse matrix.

## Inputs
- `joints`: Joints whose influences are updated. If empty while `skins` is set, Run uses all influences of those skin clusters.
- `skins`: Skin clusters to update. If the list is empty, Run uses every skin cluster connected to each listed joint. If it contains names, Run updates only those skin clusters.
- `mode`: Unbind (0) or Bind (1).

## Get From Selected Geo
Select geometry and press **Get From Selected Geo** to fill both `skins` and `joints`: the skin clusters found on the selection and their influencing joints. You can also edit either list manually. An empty `skins` list means all skin clusters connected to the listed joints.

## Usage
1. Set `joints` and, if needed, limit `skins`.
2. Run **Unbind** before repositioning the joints.
3. Reposition the joints, then run **Bind** to store their new bind pre-matrices.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "<html>\n1. Set joints and run <b>Unbind</b>.<br>\n2. Reposition the joints.<br>\n3. Run <b>Bind</b> to store their current matrices.<br>\nThe mode switches automatically after each run.\n</html>", "default": "text"}]]></attr>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": 0, "columns": 3, "default": "current"}]]></attr>
<attr name="skins" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import maya.cmds as cmds\nimport maya.mel as mel\n\njoints = set()\nskins = set()\nfor mesh in cmds.ls(sl=True) or []:\n    skin = mel.eval('findRelatedSkinCluster \"{}\"'.format(mesh))\n    if skin:\n        skins.add(skin)\n        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])\n        joints.update(cmds.listConnections(\n            f\"{skin}.matrix\", source=True, destination=False, type=\"joint\"\n        ) or [])\n\nchset(\"/joints\", sorted(joints))\nchset(\"/skins\", sorted(skins))", "label": "Get From Selected Geo", "color": "", "default": "command"}]]></attr>
</attributes>
</module>
<module name="SplitBlend" muted="0" uid="909adcb7aa7c4d9eaedc54c95ddf9165">
<run><![CDATA[import maya.api.OpenMaya as om
import maya.mel as mel
from rigsystem import proxy, rig_utils

cmds = proxy.cmds

skinGeo = proxy.node(@skinGeo)
blendGeo = proxy.node(@blendGeo)
skin = mel.eval('findRelatedSkinCluster "{}"'.format(skinGeo))

if not skin:
    error("Cannot find skinCluster on '%s'" % skinGeo)

print("Normalize skinCluster weights")
skinHelper = rig_utils.skinCluster.SkinClusterHelper(skin)
skinWeights = skinHelper.getSkinWeights()
skinWeights.normalize()

skinShape = skinGeo.getShapes(type="mesh")[0]
blendShape = blendGeo.getShapes(type="mesh")[0]
skinPoints = skinShape.mfn(shape=True).getPoints(om.MSpace.kObject)
blendPoints = blendShape.mfn(shape=True).getPoints(om.MSpace.kObject)

for j in @joints:
    idx = skinHelper.getInfluencePhysicalIndex(j)
    if idx is None:
        print("Warning: Joint %s is not an influence in %s" % (j, skin))
        continue

    weights = skinWeights.getInfluenceWeights(idx)
    newPoints = [s + (b - s) * w for s, b, w in zip(skinPoints, blendPoints, weights)]

    newBlendGeo = cmds.duplicate(
        str(skinGeo), name="{}_{}_geo".format(blendGeo, j)
    )[0]
    newBlendShape = proxy.node(newBlendGeo).getShapes(type="mesh")[0]
    newBlendShape.mfn(shape=True).setPoints(newPoints, om.MSpace.kObject)
]]></run>
<doc><![CDATA[## Summary
The **splitBlend** module creates joint‑based corrective blendshape targets by leveraging the skinCluster weights of a source geometry. For each selected joint, it generates a new geometry that contains only the deformation contributed by that joint, allowing localized control of blendshape influence.

## Inputs
- **`skinGeo`** – The source geometry that has a skinCluster attached.
- **`blendGeo`** – The target geometry whose shape will be split.
- **`joints`** – A list of joint names (or transform nodes) that are influences of the skinCluster. These joints determine which corrective shapes are generated.

## Outputs
- **New geometry nodes** – For every joint in `joints`, a duplicate of `skinGeo` is created and named `"<blendGeo>_<joint>_geo"`.
  These meshes contain the deformation contributed solely by the corresponding joint and can be used as individual blendshape targets or corrective shapes.

## Usage
1. **Set the source and target geometries**
   - In the `skinGeo` field, choose the geometry that has the skinCluster.
   - In the `blendGeo` field, choose the geometry you want to split (often a blendshape target).

2. **Select the joints**
   - Use the list box to add the joints that influence the skinCluster.
   - Joints not found in the skinCluster will trigger a warning but will be skipped.

3. **Run the module**
   - Execute the module. It will normalize the skin weights, compute the joint‑specific deformations, and duplicate the geometry for each joint.

4. **Utilize the results**
   - The newly created meshes can be added to a blendshape node as separate targets, giving you fine‑grained control over each joint’s contribution.
   - Optionally, rename or organize the generated meshes as needed for your pipeline.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "<html>\nSplit a blendShape using skinCluster weights on <b>joints</b>.\n</html>"}]]></attr>
<attr name="skinGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_pursed_blend_geo", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="blendGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_pursed_blend_geo1", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_upper", "R_upper", "L_lower", "R_lower"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="TransferBlendsWithWrap" muted="0" uid="5772ef3bbe374b19bbfa620fa562cab5">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds
srcGeo = proxy.node(@srcGeoWithBlends)
destGeo = proxy.node(@destGeo)

# 1. Create wrap deformer on destGeo driven by srcGeo
wrapNode = rig_utils.createWrap(srcGeo, destGeo)

# 2. Find blendShape on srcGeo
blendShapeNode = proxy.node(cmds.ls(cmds.listHistory(str(srcGeo)) or [], type="blendShape")[0])

# 3. Walk through each blend target
created_geos = []
for w in blendShapeNode.weight:
    name = cmds.aliasAttr(str(w), q=True)
    if not name:
        continue

    orig_val = w.get()
    w.set(1.0)

    dup = proxy.node(cmds.duplicate(str(destGeo), name=name)[0])
    if dup.getParent():
        cmds.parent(str(dup), world=True)
    dup.v.set(True)
    created_geos.append(dup)

    w.set(orig_val)

# 4. Clean up wrap
if cmds.objExists(str(wrapNode)):
    cmds.delete(str(wrapNode))
base_name = str(srcGeo) + "Base"
if cmds.objExists(base_name):
    cmds.delete(base_name)

print(f"Successfully transferred {len(created_geos)} blend shapes to '{destGeo}'")
]]></run>
<doc><![CDATA[## Summary
This module copies all blend‑shape targets from a source mesh (`srcGeoWithBlends`) to a destination mesh (`destGeo`). It does so by creating a temporary wrap deformer, duplicating the destination mesh for each blend target, and then cleaning up the wrap and any temporary base node. The result is a set of new geometry nodes, one per blend target, named after the original blend‑shape names.

## Inputs
- **`srcGeoWithBlends`** – The source geometry that already contains blend‑shape targets.
- **`destGeo`** – The destination geometry that will receive the duplicated meshes for each blend target.

## Outputs
- **`created_geos`** – A list of duplicated destination geometry nodes, each named after a blend‑shape target from the source mesh.
- **Console message** – Prints “Successfully transferred X blend shapes to ‘destGeo’” indicating the number of targets processed.
- **Cleanup** – The temporary wrap deformer and any base node created during the process are deleted, leaving only the duplicated geometries.

## Usage
1. **Set the inputs**: In the module’s attribute panel, assign the source mesh that contains blend shapes to `srcGeoWithBlends` and the target mesh to `destGeo`.
2. **Run the module**: Execute the module. It will create a wrap deformer, duplicate the destination mesh for each blend target, and then delete the wrap.
3. **Verify results**: In the scene, you should see new geometry nodes named after each blend‑shape target. These can be used for further rigging or deformation work.
4. **Optional cleanup**: If any temporary nodes remain (e.g., a base node named `srcGeoBase`), the script will delete them automatically.]]></doc>
<attributes>
<attr name="srcGeoWithBlends" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "orig_lip_pursed_base_geo", "placeholder": "Source geometry with blendShape", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="destGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "mouth_geo1", "placeholder": "Destination geometry", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
</children>
</module>
<module name="Attachments" muted="0" uid="">
<children>
<module name="AttachToCurve" muted="0" uid="b79ce70fe8fc4009a31219c30b5eb506">
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
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "curve1", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["pCube1"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="AttachToMesh" muted="0" uid="4d2ae87b98374c2db77440111d83a5a0">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

sourceGeo = proxy.node(@sourceGeo)
sourceShape = sourceGeo.getShapes(type="mesh")[0]
objects = proxy.nodes(@objects)

class Rivet():
    def create(self, name, mesh, edge1, edge2, parent):
        self.input = {
            "name": name,
            "oMesh": proxy.node(mesh),
            "edgeIndex1": edge1,
            "edgeIndex2": edge2}

        self.createNodes()
        self.createConnections()
        self.setAttributes()

        if parent:
            cmds.parent(
                str(self.output["locator"].getParent()), str(parent)
            )

        self.output["locator"].getParent().rename(
            self.input["name"] + "_locator"
        )

        return self.output["locator"].getParent()

    def createNodes(self, *args):
        self.output = {
            "meshEdgeNode1": proxy.create("curveFromMeshEdge", self.input["name"] + "_edge1"),
            "meshEdgeNode2": proxy.create("curveFromMeshEdge", self.input["name"] + "_edge2"),
            "ptOnSurfaceIn": proxy.create("pointOnSurfaceInfo", self.input["name"] + ""),
            "matrixNode": proxy.create("fourByFourMatrix", self.input["name"] + ""),
            "decomposeMatrix": proxy.create("decomposeMatrix", self.input["name"] + ""),
            "loftNode": proxy.create("loft", self.input["name"] + ""),
            "locator": proxy.create("locator")}

    def createConnections(self, *args):
        meshWorld = self.input["oMesh"].worldMesh[0]
        meshWorld >> self.output["meshEdgeNode1"].inputMesh
        meshWorld >> self.output["meshEdgeNode2"].inputMesh
        self.output["meshEdgeNode1"].outputCurve >> self.output["loftNode"].inputCurve[0]
        self.output["meshEdgeNode2"].outputCurve >> self.output["loftNode"].inputCurve[1]
        self.output["loftNode"].outputSurface >> self.output["ptOnSurfaceIn"].inputSurface
        for source, target in (
            ("normalizedNormalX", "in00"),
            ("normalizedNormalY", "in01"),
            ("normalizedNormalZ", "in02"),
            ("normalizedTangentUX", "in10"),
            ("normalizedTangentUY", "in11"),
            ("normalizedTangentUZ", "in12"),
            ("normalizedTangentVX", "in20"),
            ("normalizedTangentVY", "in21"),
            ("normalizedTangentVZ", "in22"),
            ("positionX", "in30"),
            ("positionY", "in31"),
            ("positionZ", "in32"),
        ):
            self.output["ptOnSurfaceIn"].attr(source) >> self.output["matrixNode"].attr(target)
        self.output["matrixNode"].output >> self.output["decomposeMatrix"].inputMatrix
        locatorTransform = self.output["locator"].getParent()
        self.output["decomposeMatrix"].outputTranslate >> locatorTransform.translate
        self.output["decomposeMatrix"].outputRotate >> locatorTransform.rotate
        self.output["locator"].attr("visibility").set(False)

    def setAttributes(self):
        self.output["meshEdgeNode1"].edgeIndex[0].set(self.input["edgeIndex1"])
        self.output["meshEdgeNode2"].edgeIndex[0].set(self.input["edgeIndex2"])

        self.output["loftNode"].reverseSurfaceNormals.set(1)
        cmds.setAttr(str(self.output["loftNode"].inputCurve), size=2)
        self.output["loftNode"].uniform.set(True)
        self.output["loftNode"].sectionSpans.set(3)
        self.output["loftNode"].caching.set(True)

        self.output["ptOnSurfaceIn"].turnOnPercentage.set(True)
        self.output["ptOnSurfaceIn"].parameterU.set(0.5)
        self.output["ptOnSurfaceIn"].parameterV.set(0.5)
        self.output["ptOnSurfaceIn"].caching.set(True)

def findEdges(geo, p):
    meshFn = sourceShape.mfn(shape=True)
    _, faceIndex = meshFn.getClosestPoint(om.MPoint(*p), om.MSpace.kWorld)
    faceIt = om.MItMeshPolygon(sourceShape.mdagpath)
    faceIt.setIndex(faceIndex)
    edges = faceIt.getEdges()

    separatedEdges = []
    for e1 in edges:
        edge1 = om.MItMeshEdge(sourceShape.mdagpath)
        edge1.setIndex(e1)
        vertices1 = {edge1.vertexId(0), edge1.vertexId(1)}
        for e2 in edges:
            edge2 = om.MItMeshEdge(sourceShape.mdagpath)
            edge2.setIndex(e2)
            vertices2 = {edge2.vertexId(0), edge2.vertexId(1)}
            diff = vertices1 - vertices2
            if len(diff)==2:
                separatedEdges.append((e1, e2))

    return separatedEdges[0] if separatedEdges else edges[:2]

for obj in objects:
    print(obj)
    p = cmds.xform(str(obj), q=True, ws=True, t=True)
    e1, e2 = findEdges(sourceGeo, p)
    rivet = Rivet()
    rivet.create(str(obj).rsplit("|", 1)[-1], sourceShape, e1, e2, None)
    cmds.parentConstraint(
        str(rivet.output["locator"].getParent()), str(obj), mo=True
    )
]]></run>
<doc><![CDATA[## Summary
Creates a rivet system that attaches each selected object to a specified mesh surface. For every object, a hidden locator is generated at the nearest mesh edge and a parent constraint is applied so the object follows the mesh deformation.

## Inputs
- **`sourceGeo`** – The mesh node that will serve as the attachment surface.
- **`objects`** – A list of transform nodes (e.g., joints, controls, or helpers) that should be bound to the mesh.

## Outputs
- **Locator nodes** – For each object, a locator named `<object>_locator` is created and positioned on the mesh surface.
- **Parent constraints** – Each object is parent‑constrained to its corresponding locator (maintaining the object's world transform).
- **Internal nodes** – The module internally creates `curveFromMeshEdge`, `pointOnSurfaceInfo`, `fourByFourMatrix`, `decomposeMatrix`, and `loft` nodes to drive the locator’s position and orientation.

## Usage
1. Select the mesh you want to attach to and set it in the **`sourceGeo`** field.
2. Populate the **`objects`** list with the transforms you wish to bind.
3. Run the module. It will generate a hidden locator for each object and apply a parent constraint so the object follows the mesh deformation.
4. Use the created locators as reference points for further rigging or animation tasks.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>objects</b> to <b>source</b> mesh using rivet."}]]></attr>
<attr name="sourceGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "outputCloth1"}]]></attr>
<attr name="objects" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["skirt_A_1_joint", "skirt_A_2_joint", "skirt_A_3_joint", "skirt_A_4_joint", "skirt_A_5_joint", "skirt_A_6_joint", "skirt_A_7_joint", "skirt_A_8_joint", "skirt_B_1_joint", "skirt_B_2_joint", "skirt_B_3_joint", "skirt_B_4_joint", "skirt_B_5_joint", "skirt_B_6_joint", "skirt_B_7_joint", "skirt_B_8_joint", "skirt_C_1_joint", "skirt_C_2_joint", "skirt_C_3_joint", "skirt_C_4_joint", "skirt_C_5_joint", "skirt_C_6_joint", "skirt_C_7_joint", "skirt_C_8_joint", "skirt_D_1_joint", "skirt_D_2_joint", "skirt_D_3_joint", "skirt_D_4_joint", "skirt_D_5_joint", "skirt_D_6_joint", "skirt_D_7_joint", "skirt_D_8_joint"]}]]></attr>
</attributes>
</module>
<module name="AttachToSurface" muted="0" uid="b21c578b1b144f4e9fe06ec449961b0f">
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
<attr name="surface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "nurbsPlane1", "placeholder": "NURBS surface name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["ctrl1_pivot_transform", "ctrl2_pivot_transform", "ctrl3_pivot_transform"], "default": "items"}]]></attr>
<attr name="addNewParents" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
</attributes>
</module>
<module name="SkinControl" muted="0" uid="0f7c32b1393e4939aba1963e961af702">
<run><![CDATA[import maya.api.OpenMaya as om
import maya.cmds as cmds
import maya.mel as mel
from rigsystem import proxy

mesh = proxy.node(@mesh)
control = proxy.node(@control)

if not mesh or not control:
    error("Set a mesh transform and a control transform.")

mesh_shapes = mesh.getShapes(type="mesh", noIntermediate=True)
if not mesh_shapes:
    error("Mesh input has no visible mesh shape.")

source_skin = next((
    node for node in cmds.listHistory(str(mesh_shapes[0])) or []
    if cmds.nodeType(node) == "skinCluster"
), None)
if not source_skin:
    error("Input mesh is not skinned.")

influences = cmds.skinCluster(source_skin, query=True, influence=True) or []
if not influences:
    error("Source skinCluster has no influences.")

control_name = control.localName()
control_matrix = cmds.xform(str(control), query=True, worldSpace=True, matrix=True)

plane = cmds.polyPlane(
    name=control_name + "_skinPlane",
    width=1,
    height=1,
    subdivisionsX=1,
    subdivisionsY=1,
)[0]
cmds.xform(plane, worldSpace=True, matrix=control_matrix)
cmds.delete(plane, constructionHistory=True)

target_skin = cmds.skinCluster(
    influences, plane, tsb=True, name=control_name + "_skinCluster"
)[0]
cmds.copySkinWeights(
    sourceSkin=source_skin,
    destinationSkin=target_skin,
    noMirror=True,
    surfaceAssociation="closestPoint",
    influenceAssociation=["oneToOne", "name"],
)

existing_locators = set(cmds.ls(type="locator") or [])
existing_uv_pins = set(cmds.ls(type="uvPin") or [])
cmds.select(plane + ".f[0]", replace=True)
mel.eval("Rivet;")

new_locators = list(set(cmds.ls(type="locator") or []) - existing_locators)
if not new_locators:
    error("Maya Rivet command did not create a locator.")

rivet = proxy.node(new_locators[0]).getParent(fullPath=True)
rivet.rename(control_name + "_rivet")
plane | rivet
cmds.xform(str(rivet), matrix=list(om.MMatrix()))
rivet.inheritsTransform.set(False)

new_uv_pins = sorted(set(cmds.ls(type="uvPin") or []) - existing_uv_pins)

for index, uv_pin in enumerate(new_uv_pins):
    suffix = "" if index == 0 else str(index + 1)
    cmds.rename(uv_pin, control_name + "_uvPin" + suffix)

control_parent = control.getParent()
attachment = proxy.create(
    "transform", control_name + "_skinned"
)
cmds.matchTransform(str(attachment), str(control))
attachment | control

if control_parent:
    cmds.parent(str(attachment), str(control_parent))

cmds.parentConstraint(str(rivet), str(attachment), maintainOffset=True)]]></run>
<doc><![CDATA[## Summary
Creates a small plane at the control's current world position, skins it to the source mesh influences, copies the skin weights, then uses Maya's Rivet command to create a surface locator. A parentConstraint drives an offset group above the control from that locator.

## Inputs
- **mesh**: Transform of the skinned polygon mesh.
- **control**: Transform to attach to the skinned surface.

## Outputs
- **Plane and skinCluster**: The control-named plane carries copied weights from the source mesh.
- **Rivet locator**: Created by Maya's Rivet command and renamed to `<control>_rivet`.
- **UV pin**: Created by the Rivet command and renamed to `<control>_uvPin`.
- **Attachment group and constraint**: A group above the control is driven by `<control>_rivet_parentConstraint`. The group's original parent and the control's world transform are preserved.

## Usage
Set the `mesh` and `control` inputs, then run the module. The control remains under its attachment group and follows the rivet locator as the skinned plane deforms.]]></doc>
<attributes>
<attr name="mesh" template="lineEditAndButton" category="Inputs" connect=""><![CDATA[{"value": "Cloth_geo", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="control" template="lineEditAndButton" category="Inputs" connect=""><![CDATA[{"value": "pCube1", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
</children>
</module>
<module name="Face" muted="0" uid="">
<children>
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
skins = set()
for lid in ("upper", "lower"):
    mainCurve = proxy.node(f"lip_{lid}_main_curve")
    shape = mainCurve.getShapes(type="nurbsCurve")[0]

    for skin in shape.inputs(type="skinCluster"):
        skins.add(str(skin))
        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])

if not skins:
    raise ValueError("No skin clusters found on the lip main curves.")

bindMode.attr.joints = sorted(joints)
bindMode.attr.skins = sorted(skins)
bindMode.attr.mode = 0
bindMode.run()
bindMode.attr.mode = 1
bindMode.run()
cmds.setAttr("lips_corners_root_transform_pointConstraint1.nodeState", 1)
]]></run>
<doc><![CDATA[## Summary
Fits the face_lips tuner curves and locator tuners to two degree-1 lip edge curves.

## Inputs
- Parent `upper_curve` and `lower_curve`: open degree-1 curves that share their L/R corner endpoints.

## Outputs
Copies the degree-1 inputs into the upper/lower wire curve Origs. Rebuilds each input to six spans and copies it into the corresponding tuner curve. Positions the L/R corner tuners at the curve ends and the upper/lower main tuners at normalized parameter 0.5. Rebinds only the skin clusters on the main curves, then disables the lips corner root point constraint.

## Usage
Import face_lips, set the two parent inputs, then run Lips. Input direction may be reversed; wire geometry is normalized from L to R.]]></doc>
<children>
<module name="BindMode" muted="1" uid="c7ae99e054f94721afc9256cf449e180">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
joints = proxy.nodes(@joints)
selectedSkins = set(proxy.nodes(@skins))

if not joints and selectedSkins:
    influences = {
        name
        for skin in selectedSkins
        for name in cmds.skinCluster(str(skin), query=True, influence=True) or []
    }
    joints = proxy.nodes(sorted(influences))

def getJointsSkinClusters(joint):
    return {plug.node for plug in joint.worldMatrix.outputs(type="skinCluster")}

def influenceIndex(skin, joint):
    return skin.mfn().indexForInfluenceObject(joint.mdagpath)

if @mode == 0: # unbind
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            preMatrix = skin.bindPreMatrix[idx]
            if not preMatrix.inputs():
                j.worldInverseMatrix[0] >> preMatrix

    print("Unbinded")
    @set_mode(1)
else:
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            matrix = j.worldInverseMatrix[0].get()

            if cmds.isConnected(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx])):
                cmds.disconnectAttr(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx]))
                skin.bindPreMatrix[idx].set(matrix)

    print("Binded")
    @set_mode(0)
        ]]></run>
<doc><![CDATA[## Summary
BindMode updates bind pre-matrices for the listed joints. Unbind connects each joint's world inverse matrix to its bind pre-matrix so the joint can be repositioned without moving the skinned geometry. Bind disconnects that link and stores the joint's current world inverse matrix.

## Inputs
- `joints`: Joints whose influences are updated. If empty while `skins` is set, Run uses all influences of those skin clusters.
- `skins`: Skin clusters to update. If the list is empty, Run uses every skin cluster connected to each listed joint. If it contains names, Run updates only those skin clusters.
- `mode`: Unbind (0) or Bind (1).

## Get From Selected Geo
Select geometry and press **Get From Selected Geo** to fill both `skins` and `joints`: the skin clusters found on the selection and their influencing joints. You can also edit either list manually. An empty `skins` list means all skin clusters connected to the listed joints.

## Usage
1. Set `joints` and, if needed, limit `skins`.
2. Run **Unbind** before repositioning the joints.
3. Reposition the joints, then run **Bind** to store their new bind pre-matrices.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "<html>\n1. Set joints and run <b>Unbind</b>.<br>\n2. Reposition the joints.<br>\n3. Run <b>Bind</b> to store their current matrices.<br>\nThe mode switches automatically after each run.\n</html>", "default": "text"}]]></attr>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": "", "columns": 3, "default": "current"}]]></attr>
<attr name="skins" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_lips_corner_main_joint", "M_lip_lower_main_joint", "M_lip_upper_main_joint", "R_lips_corner_main_joint"], "default": "items"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import maya.cmds as cmds\nimport maya.mel as mel\n\njoints = set()\nskins = set()\nfor mesh in cmds.ls(sl=True) or []:\n    skin = mel.eval('findRelatedSkinCluster \"{}\"'.format(mesh))\n    if skin:\n        skins.add(skin)\n        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])\n        joints.update(cmds.listConnections(\n            f\"{skin}.matrix\", source=True, destination=False, type=\"joint\"\n        ) or [])\n\nchset(\"/joints\", sorted(joints))\nchset(\"/skins\", sorted(skins))", "label": "Get From Selected Geo", "color": "", "default": "command"}]]></attr>
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
<module name="LipsZip" muted="0" uid="">
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

    oc = cmds.orientConstraint("M_lip_upper_main_control_transform", "M_lip_upper_main_control", uj, mo=True)
    proxy.node(oc[0]).interpType.set(2) # shortest
    oc = cmds.orientConstraint("M_lip_lower_main_control_transform", "M_lip_lower_main_control", lj, mo=True)
    proxy.node(oc[0]).interpType.set(2) # shortest

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
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_lower_curve", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_lip_lower_9_joint_out_transform", "L_lip_lower_8_joint_out_transform", "L_lip_lower_7_joint_out_transform", "L_lip_lower_6_joint_out_transform", "L_lip_lower_5_joint_out_transform", "L_lip_lower_4_joint_out_transform", "L_lip_lower_3_joint_out_transform", "L_lip_lower_2_joint_out_transform", "L_lip_lower_1_joint_out_transform", "M_lip_lower_joint_out_transform", "R_lip_lower_1_joint_out_transform", "R_lip_lower_2_joint_out_transform", "R_lip_lower_3_joint_out_transform", "R_lip_lower_4_joint_out_transform", "R_lip_lower_5_joint_out_transform", "R_lip_lower_6_joint_out_transform", "R_lip_lower_7_joint_out_transform", "R_lip_lower_8_joint_out_transform", "R_lip_lower_9_joint_out_transform"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>
</children>
</module>
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
selectedSkins = set(proxy.nodes(@skins))

if not joints and selectedSkins:
    influences = {
        name
        for skin in selectedSkins
        for name in cmds.skinCluster(str(skin), query=True, influence=True) or []
    }
    joints = proxy.nodes(sorted(influences))

def getJointsSkinClusters(joint):
    return {plug.node for plug in joint.worldMatrix.outputs(type="skinCluster")}

def influenceIndex(skin, joint):
    return skin.mfn().indexForInfluenceObject(joint.mdagpath)

if @mode == 0: # unbind
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            preMatrix = skin.bindPreMatrix[idx]
            if not preMatrix.inputs():
                j.worldInverseMatrix[0] >> preMatrix

    print("Unbinded")
    @set_mode(1)
else:
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            matrix = j.worldInverseMatrix[0].get()

            if cmds.isConnected(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx])):
                cmds.disconnectAttr(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx]))
                skin.bindPreMatrix[idx].set(matrix)

    print("Binded")
    @set_mode(0)
        ]]></run>
<doc><![CDATA[## Summary
BindMode updates bind pre-matrices for the listed joints. Unbind connects each joint's world inverse matrix to its bind pre-matrix so the joint can be repositioned without moving the skinned geometry. Bind disconnects that link and stores the joint's current world inverse matrix.

## Inputs
- `joints`: Joints whose influences are updated. If empty while `skins` is set, Run uses all influences of those skin clusters.
- `skins`: Skin clusters to update. If the list is empty, Run uses every skin cluster connected to each listed joint. If it contains names, Run updates only those skin clusters.
- `mode`: Unbind (0) or Bind (1).

## Get From Selected Geo
Select geometry and press **Get From Selected Geo** to fill both `skins` and `joints`: the skin clusters found on the selection and their influencing joints. You can also edit either list manually. An empty `skins` list means all skin clusters connected to the listed joints.

## Usage
1. Set `joints` and, if needed, limit `skins`.
2. Run **Unbind** before repositioning the joints.
3. Reposition the joints, then run **Bind** to store their new bind pre-matrices.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "<html>\n1. Set joints and run <b>Unbind</b>.<br>\n2. Reposition the joints.<br>\n3. Run <b>Bind</b> to store their current matrices.<br>\nThe mode switches automatically after each run.\n</html>", "default": "text"}]]></attr>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": "", "columns": 3, "default": "current"}]]></attr>
<attr name="skins" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_eyelid_lower_main_joint", "L_eyelid_upper_main_joint", "L_eyelids_corner_inner_joint", "L_eyelids_corner_outer_joint", "R_eyelid_lower_main_joint", "R_eyelid_upper_main_joint", "R_eyelids_corner_inner_joint", "R_eyelids_corner_outer_joint"], "default": "items"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import maya.cmds as cmds\nimport maya.mel as mel\n\njoints = set()\nfor mesh in cmds.ls(sl=True) or []:\n    skin = mel.eval('findRelatedSkinCluster \"{}\"'.format(mesh))\n    if skin:\n        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])\n\nchset(\"/joints\", sorted(joints))", "label": "Get From Selected Geo", "color": "", "default": "command"}]]></attr>
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

headJoint = proxy.node("M_head_joint")
skins = set()
joints = set()
for side in "LR":
    mainCurve = proxy.node(f"{side}_brow_main_curve")
    skin = cmds.skinCluster(headJoint, mainCurve, toSelectedBones=True)[0]
    skins.add(skin)
    joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])

bindMode = module.child("BindMode")
bindMode.attr.joints = sorted(joints)
bindMode.attr.skins = sorted(skins)
bindMode.attr.mode = 0
bindMode.run()
bindMode.attr.mode = 1
bindMode.run()
]]></run>
<doc><![CDATA[## Summary
Fits the face_brows wire and tuner curves.

Copies the degree-1 inputs into the L/R brow curve Origs. Rebuilds the left input to six cubic spans and copies it into `L_brow_tuner_curve`; the template mirrors that curve to the right. Positions `L_brow_main_tuner` at normalized parameter 0.5 without changing its offsetParentMatrix, then skins the L/R main curves to `M_head_joint` and refreshes their skin bindings.]]></doc>
<children>
<module name="BindMode" muted="1" uid="c7ae99e054f94721afc9256cf449e180">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
joints = proxy.nodes(@joints)
selectedSkins = set(proxy.nodes(@skins))

if not joints and selectedSkins:
    influences = {
        name
        for skin in selectedSkins
        for name in cmds.skinCluster(str(skin), query=True, influence=True) or []
    }
    joints = proxy.nodes(sorted(influences))

def getJointsSkinClusters(joint):
    return {plug.node for plug in joint.worldMatrix.outputs(type="skinCluster")}

def influenceIndex(skin, joint):
    return skin.mfn().indexForInfluenceObject(joint.mdagpath)

if @mode == 0: # unbind
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            preMatrix = skin.bindPreMatrix[idx]
            if not preMatrix.inputs():
                j.worldInverseMatrix[0] >> preMatrix

    print("Unbinded")
    @set_mode(1)
else:
    for j in joints:
        for skin in getJointsSkinClusters(j):
            if selectedSkins and skin not in selectedSkins:
                continue

            idx = influenceIndex(skin, j)

            matrix = j.worldInverseMatrix[0].get()

            if cmds.isConnected(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx])):
                cmds.disconnectAttr(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx]))
                skin.bindPreMatrix[idx].set(matrix)

    print("Binded")
    @set_mode(0)
        ]]></run>
<doc><![CDATA[## Summary
BindMode updates bind pre-matrices for the listed joints. Unbind connects each joint's world inverse matrix to its bind pre-matrix so the joint can be repositioned without moving the skinned geometry. Bind disconnects that link and stores the joint's current world inverse matrix.

## Inputs
- `joints`: Joints whose influences are updated. If empty while `skins` is set, Run uses all influences of those skin clusters.
- `skins`: Skin clusters to update. If the list is empty, Run uses every skin cluster connected to each listed joint. If it contains names, Run updates only those skin clusters.
- `mode`: Unbind (0) or Bind (1).

## Get From Selected Geo
Select geometry and press **Get From Selected Geo** to fill both `skins` and `joints`: the skin clusters found on the selection and their influencing joints. You can also edit either list manually. An empty `skins` list means all skin clusters connected to the listed joints.

## Usage
1. Set `joints` and, if needed, limit `skins`.
2. Run **Unbind** before repositioning the joints.
3. Reposition the joints, then run **Bind** to store their new bind pre-matrices.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "<html>\n1. Set joints and run <b>Unbind</b>.<br>\n2. Reposition the joints.<br>\n3. Run <b>Bind</b> to store their current matrices.<br>\nThe mode switches automatically after each run.\n</html>", "default": "text"}]]></attr>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": 0, "columns": 3, "default": "current"}]]></attr>
<attr name="skins" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_brow_major_inner_joint", "L_brow_major_mid_joint", "L_brow_major_outer_joint", "R_brow_major_inner_joint", "R_brow_major_mid_joint", "R_brow_major_outer_joint"], "default": "items"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import maya.cmds as cmds\nimport maya.mel as mel\n\njoints = set()\nskins = set()\nfor mesh in cmds.ls(sl=True) or []:\n    skin = mel.eval('findRelatedSkinCluster \"{}\"'.format(mesh))\n    if skin:\n        skins.add(skin)\n        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])\n        joints.update(cmds.listConnections(\n            f\"{skin}.matrix\", source=True, destination=False, type=\"joint\"\n        ) or [])\n\nchset(\"/joints\", sorted(joints))\nchset(\"/skins\", sorted(skins))", "label": "Get From Selected Geo", "color": "", "default": "command"}]]></attr>
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
<module name="Teeth" muted="0" uid="">
<run><![CDATA[import os
import maya.cmds as cmds

template_path = os.path.join(os.environ["RIGSYSTEM_PATH"], "library", "face_teeth.ma")
cmds.file(
    template_path,
    i=True,
    ignoreVersion=True,
    namespace=":",
    mergeNamespacesOnClash=False,
)]]></run>
<doc><![CDATA[## Summary
Imports the teeth template into the current Maya scene.

## Inputs
None. Uses the RigSystem scene library.

## Outputs
Adds the template nodes to the current Maya scene.

## Usage
Open the source scene and run this module once.]]></doc>
</module>
</children>
</module>
</children>
</module>
