<module name="SetMaxInfluences" muted="0" uid="ba683572a8564671832cbe81d0fc0b8c">
<run><![CDATA[import pymel.core as pm
from rig_utils import skinCluster

geo = @mesh
maxInf = int(@maxInf)

if not pm.objExists(geo):
    error("Cannot find geometry '{0}'.".format(geo))
if maxInf < 1:
    error("Maximum influences must be at least 1.")

skinNode = pm.mel.eval("findRelatedSkinCluster " + geo)
if not skinNode:
    error("Cannot find a skinCluster on '{0}'.".format(geo))

skinHelper = skinCluster.SkinClusterHelper(geo)
skinWeights = skinHelper.getSkinWeights()
skinWeights.setMaxInfluence(maxInf)
skinHelper.setSkinWeights(skinWeights)

print("Processed {0} vertices on '{1}' with a limit of {2} influences.".format(
    skinWeights.numVertices(), geo, maxInf))
]]></run>
<doc><![CDATA[## Summary
Limits the number of bone influences per vertex on a selected mesh’s skin cluster to a user‑defined maximum, updating the skin weights in place.

## Inputs
- **`mesh`**: The name of the mesh object whose skin cluster will be processed.  
- **`maxInf`**: Integer specifying the maximum number of influences allowed per vertex (must be ≥ 1).

## Outputs
- The module does not create new nodes or attributes; it directly modifies the existing skin cluster on the specified mesh, reducing each vertex’s influence list to the specified maximum.

## Usage
1. Connect the target mesh to the **`mesh`** attribute.  
2. Set **`maxInf`** to the desired influence limit (e.g., 4).  
3. Execute the module.  
4. The console will report the number of vertices processed and the applied limit. The skin cluster on the mesh is updated accordingly.]]></doc>
<attributes>
<attr name="mesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "body_proxy_geo", "placeholder": "Skinned mesh", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="maxInf" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 4, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 4, "max": 16, "validator": 1, "default": "value"}]]></attr>
</attributes>
</module>