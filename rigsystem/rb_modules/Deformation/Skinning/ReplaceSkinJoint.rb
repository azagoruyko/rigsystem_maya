<module name="replaceSkinJoint" type="Tools/ReplaceSkinJoint" muted="0" uid="b7606eb6a4484ca2a9131f7f9290d458">
<run><![CDATA[import pymel.core as pm

sourceJoint = pm.PyNode(@sourceJoint)
destinationJoint = pm.PyNode(@destinationJoint)

for p in sourceJoint.wm.outputs(p=True, type="skinCluster"):
    destinationJoint.wm >> p
    
    if not destinationJoint.hasAttr("lockInfluenceWeights"):
        destinationJoint.addAttr("lockInfluenceWeights", at="bool", dv=False)
    
    destinationJoint.lockInfluenceWeights >> p.node().lockWeights[p.index()]
    
    if @updatePreMatrix:
        p.node().bindPreMatrix[p.index()].set(destinationJoint.wim.get())
        
    print(p)        ]]></run>
<doc><![CDATA[## Summary  
The **replaceSkinJoint** tool swaps a joint influence in one or more skinClusters with another joint while preserving the existing weight distribution. It optionally updates the skinCluster’s bind pre‑matrix to match the new joint’s world inverse matrix.

## Inputs  
- **`sourceJoint`** – The joint whose influence is to be replaced.  
- **`destinationJoint`** – The joint that will take over the influence.  
- **`updatePreMatrix`** (checkbox) – When checked, the tool updates the skinCluster’s `bindPreMatrix` for the replaced influence to match the destination joint’s world inverse matrix.

## Outputs  
- **Modified skinClusters** – All skinClusters that had the source joint as an influence now use the destination joint instead.  
- **Updated lockWeights** – The destination joint’s `lockInfluenceWeights` attribute is created (if missing) and connected to the skinCluster’s `lockWeights` for the replaced influence.  
- **Optional bindPreMatrix update** – If `updatePreMatrix` is enabled, the skinCluster’s `bindPreMatrix` entry for the replaced influence is set to the destination joint’s world inverse matrix.

## Usage  
1. Select the **source joint** in the viewport and click the `<` button next to the `sourceJoint` field, or type its name manually.  
2. Select the **destination joint** and click the `<` button next to the `destinationJoint` field, or type its name.  
3. (Optional) Check **updatePreMatrix** if you want the skinCluster’s bind pre‑matrix to be updated to match the new joint.  
4. Press **Run**. The tool will iterate over all skinClusters influenced by the source joint, replace the influence with the destination joint, set up the lockWeights connection, and optionally update the bind pre‑matrix.  
5. Verify the changes in the skinCluster editor or by inspecting the affected mesh’s skinning.]]></doc>
<attributes>
<attr name="sourceJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "joint1"}]]></attr>
<attr name="destinationJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "joint2"}]]></attr>
<attr name="updatePreMatrix" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
</attributes>
<children>
</children>
</module>