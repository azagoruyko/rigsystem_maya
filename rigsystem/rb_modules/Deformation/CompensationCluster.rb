<module name="compensationCluster" muted="0" uid="e3bfce6c327f4c16ad859bea29ba1dcb">
<run><![CDATA[import pymel.core as pm
import maya.cmds as cmds
import maya.mel as mel

if @type == "cluster":
    deformer, handle = pm.cluster(n=@name+"_cluster")
    cmds.disconnectAttr(handle+".clusterTransforms[0]", deformer+".clusterXforms")

elif @type == "softMod":
    deformer, handle = pm.softMod(n=@name+"_softMod")
    cmds.disconnectAttr(handle+".softModTransforms[0]", deformer+".softModXforms")
    deformer.falloffMasking.set(0)
    deformer.falloffAroundSelection.set(1)

deformer.envelope.set(0.99999) # when 1 deformer doesn't work, maybe bug
cmds.disconnectAttr(handle+".worldMatrix", deformer+".matrix")

parent = pm.createNode("transform", n=@name+"_compensation_transform")
child = pm.createNode("transform", n=@name+"_transform", p=parent)
parent.t.set(pm.xform(handle, q=True, ws=True, rp=True))
pm.delete(handle)

def callback():
    child.matrix >> deformer.weightedMatrix
    parent.wim >> deformer.postMatrix
    parent.wm >> deformer.preMatrix
    
pm.scriptJob(ro=True, e=("idle", callback))

@set_out_parent(parent.name())
@set_out_handle(child.name())
@set_out_deformer(deformer.name())

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
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "R_cuirass_sleeve_down", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="type" template="comboBox" category="General" connect=""><![CDATA[{"items": ["cluster", "softMod"], "current": "softMod", "default": "current"}]]></attr>
<attr name="out_parent" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_handle" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_deformer" template="lineEditAndButton" category="Output" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>