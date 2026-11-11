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
