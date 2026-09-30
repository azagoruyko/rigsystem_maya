<module name="makeSkinLocal" muted="0" uid="c3d086240a8642d5bcd762328d68df91">
<run><![CDATA[import pymel.core as pm

skinned = pm.PyNode(@skinnedGeo)
skin = pm.mel.eval("findRelatedSkinCluster "+skinned)
if not skin:
    error(f"Cannot find skinCluster for {skinned}")
    
skin = pm.PyNode(skin)
basis = []
    
for i, inf in enumerate(skin.influenceObjects()):
    if skin.bindPreMatrix[i].inputs():
        warning(f"bindPreMatrix[{i}] is connected, skipped")
        continue
        
    t = pm.createNode("transform", n=inf+"_basis")
    m = skin.bindPreMatrix[i].get().inverse()
    pm.xform(t, ws=True, m=m)
    t.worldInverseMatrix >> skin.bindPreMatrix[i]
    basis.append(t.name())
    
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
<attr name="skinnedGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_minor_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_basis" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
</attributes>
</module>