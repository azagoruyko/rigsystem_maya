<module name="GetJoints" muted="0" uid="9f20a01b042e46d389ce6774b7248fc3">
<run><![CDATA[import pymel.core as pm

joints = []
for skin in @skinClusters:
    skin = pm.PyNode(skin)
    
    for inf in skin.influenceObjects():
        if inf not in joints:
            joints.append(inf.name())
            
@set_outJoints(joints)]]></run>
<doc><![CDATA[## Summary  
Collects all unique joint names that influence the selected skin clusters. The module scans each skin cluster, gathers its influence objects, and outputs a list of joint names for downstream use.

## Inputs  
- **`skinClusters`** (`lineEditAndButton`):  
  A list of skin cluster node names. The button can automatically populate this list by selecting meshes in the scene and clicking **Get skinClusters by mesh**.

## Outputs  
- **`outJoints`** (`listBox`):  
  A list of joint names that are influences of the provided skin clusters. This list can be connected to other modules that require a joint list (e.g., constraint or rigging tools).

## Usage  
1. **Select Meshes** – In the scene, select the mesh(es) that have skin clusters attached.  
2. **Populate Skin Clusters** – Click the **Get skinClusters by mesh** button to automatically fill the `skinClusters` field with the skin clusters found on the selected meshes.  
3. **Run the Module** – Press **Run** (or execute the module) to collect all unique joint names from the listed skin clusters.  
4. **Consume the Output** – The resulting joint names appear in the `outJoints` list box. Connect this output to other modules that need a joint list, such as constraint or rigging tools.]]></doc>
<attributes>
<attr name="skinClusters" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": ["skinCluster13"], "placeholder": "", "buttonCommand": "import pymel.core as pm\n\nls = pm.ls(sl=True, fl=True)\n    \nvalue = []\nfor obj in ls:\n\tskin = pm.mel.eval(\"findRelatedSkinCluster \"+obj)\n\tif skin and skin not in value:\n\t\tvalue.append(skin)\n", "buttonLabel": "Get skinClusters by mesh", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Press <b>Run</b> to get skinClusters' joints."}]]></attr>
<attr name="outJoints" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
</attributes>
</module>