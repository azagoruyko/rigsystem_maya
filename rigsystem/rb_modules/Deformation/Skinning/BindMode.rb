<module name="BindMode" muted="0" uid="c7ae99e054f94721afc9256cf449e180">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
joints = proxy.nodes(@joints)

def getJointsSkinClusters(joint):
    return {plug.node for plug in joint.worldMatrix.outputs(type="skinCluster")}

def influenceIndex(skin, joint):
    return skin.mfn().indexForInfluenceObject(joint.mdagpath)

if @mode in (0, ""): # unbind; older embedded modules may have an empty mode
    for j in joints:
        for skin in getJointsSkinClusters(j):
            idx = influenceIndex(skin, j)
        
            preMatrix = skin.bindPreMatrix[idx]
            if not preMatrix.inputs():
                j.worldInverseMatrix[0] >> preMatrix
    
    print("Unbinded")
    @set_mode(1)
else:
    for j in joints:
        for skin in getJointsSkinClusters(j):
            idx = influenceIndex(skin, j)
        
            matrix = j.worldInverseMatrix[0].get()

            if cmds.isConnected(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx])):
                cmds.disconnectAttr(str(j.worldInverseMatrix[0]), str(skin.bindPreMatrix[idx]))
                skin.bindPreMatrix[idx].set(matrix)
    
    print("Binded")
    @set_mode(0)
        ]]></run>
<doc><![CDATA[## Summary
Temporarily follows selected joints with their skin clusters' bind pre-matrices so the joints can be repositioned without changing the skinned geometry. Running again stores the joints' current world inverse matrices as the new bind pre-matrices.

## Inputs
- **`joints`** (`listBox`): Joints to process. **Get From Mesh** lists the influences of selected meshes.
- **`mode`** (`radioButton`): `Unbind` (0) connects the world inverse matrices; `Bind` (1) disconnects them and stores the current matrices. An empty value from an older embedded module is treated as `Unbind`.

## Usage
1. Choose the joints and run with **Unbind** selected.
2. Reposition the joints.
3. Run again with **Bind** selected. The mode switches automatically after each run.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "<html>\n1. Set joints and run <b>Unbind</b>.<br>\n2. Reposition the joints.<br>\n3. Run <b>Bind</b> to store their current matrices.<br>\nThe mode switches automatically after each run.\n</html>", "default": "text"}]]></attr>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": 0, "columns": 3, "default": "current"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import maya.cmds as cmds\nimport maya.mel as mel\n\njoints = set()\nfor mesh in cmds.ls(sl=True) or []:\n    skin = mel.eval('findRelatedSkinCluster \"{}\"'.format(mesh))\n    if skin:\n        joints.update(cmds.skinCluster(skin, query=True, influence=True) or [])\n\nchset(\"/joints\", sorted(joints))", "label": "Get From Mesh", "color": "", "default": "command"}]]></attr>
</attributes>
</module>
