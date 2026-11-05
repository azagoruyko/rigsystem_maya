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
Creates a helper curve node with a user‑defined name and shape, positioned at the current selection or a specified transform. The curve can be used as a visual reference or as a target for constraints and connections.

## Inputs
- **`name`** (`lineEditAndButton`): The desired name for the helper curve node (e.g., `L_bracer`).  
- **`curveType`** (`comboBox`): The shape of the curve to generate. Options include `arc`, `arrow`, `axis`, `axisSphere`, `cube`, `circle`, `diamond`, `key`, `pyramid`, `rect`, `sphere`, `triangle`, and `plus`. The default is `triangle`.

## Outputs
- **Helper Curve Node**: A new curve node (or locator/shape helper) created in the scene with the specified `name` and `curveType`. This node can be used as a visual guide, constraint target, or reference transform for downstream modules.

## Usage
1. Set the **`name`** attribute to the desired node name.  
2. Choose a **`curveType`** from the dropdown to define the visual shape.  
3. Execute the module.  
4. The created helper curve will appear in the scene; you can parent, constrain, or connect it to other rig components as needed.]]></doc>
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