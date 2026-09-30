<module name="BindMode" muted="0" uid="c7ae99e054f94721afc9256cf449e180">
<run><![CDATA[import pymel.core as pm

joints = [pm.PyNode(j) for j in @joints]

def getJointsSkinClusters(joint):
    skins = [obj for obj in pm.PyNode(joint).worldMatrix.listConnections() if pm.objectType(obj)=="skinCluster"]
    return set(skins)

if @mode == 0: # unbind
    for j in joints:
        for skin in getJointsSkinClusters(j):
            idx = skin.indexForInfluenceObject(j)
        
            if not pm.isConnected(j.worldInverseMatrix, skin.bindPreMatrix[idx]) and\
               not skin.bindPreMatrix[idx].inputs():
                j.worldInverseMatrix >> skin.bindPreMatrix[idx]
    
    print("Unbinded")
    @set_mode("Unbinded")
else:
    for j in joints:
        for skin in getJointsSkinClusters(j):
            idx = skin.indexForInfluenceObject(j)
        
            matrix = j.worldInverseMatrix.get()

            if pm.isConnected(j.worldInverseMatrix, skin.bindPreMatrix[idx]):
                j.worldInverseMatrix // skin.bindPreMatrix[idx]                
                skin.bindPreMatrix[idx].set(matrix)
    
    print("Binded")
    @set_mode("")
        ]]></run>
<doc><![CDATA[## Summary  
The **bindMode** module toggles the binding state of selected joints to their skin clusters in Maya. When executed, it either connects each joint’s world inverse matrix to the skin cluster’s bind pre‑matrix (unbinding) or disconnects that connection and writes the current matrix back (rebinding). The module updates the `mode` attribute to reflect the new state and prints a status message.

## Inputs  
- **`joints`** (listBox): A list of joint names that the script will process.  
- **`mode`** (label): A flag indicating the current state. When empty, the module will perform a *bind* operation; when set to any value (e.g., `"Unbinded"`), it will perform an *unbind* operation.

## Outputs  
- **`mode`** (label): Updated to `"Unbinded"` after an unbind operation or cleared after a bind operation.  
- Console output: Prints `"Unbinded"` or `"Binded"` to indicate the action taken.

## Usage  
1. **Select Joints** – In the `joints` listBox, choose the joints you want to toggle.  
2. **Unbind** – If `mode` is empty, click **Run**. The script will unbind the selected joints from their skin clusters and set `mode` to `"Unbinded"`.  
3. **Adjust Joints** – Move or modify the joints as needed.  
4. **Rebind** – With `mode` now set, click **Run** again. The script will rebind the joints, restoring the original skin cluster matrices and clearing `mode`.  
5. **Repeat** – You can toggle between bind and unbind states as required during rigging or animation adjustments.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "<html>\nHow to use: <br>\n1. Set joints and press <b>Run</b> to unbind joints from skin clusters.<br>\n2. Change joints position.<br>\n3. Press <b>Run</b> to rebind again.<br>\n</html>", "default": "text"}]]></attr>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Unbind", "Bind"], "current": 0, "columns": 3, "default": "current"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import pymel.core as pm\n\njoints = set()\nfor mesh in pm.selected():\n    skin = pm.mel.eval(\"findRelatedSkinCluster \"+mesh)\n    if skin:\n        joints = joints | set(pm.PyNode(skin).influenceObjects())\n        \nchset(\"/joints\", [str(j) for j in joints])", "label": "Get From Mesh", "color": "", "default": "command"}]]></attr>
</attributes>
</module>