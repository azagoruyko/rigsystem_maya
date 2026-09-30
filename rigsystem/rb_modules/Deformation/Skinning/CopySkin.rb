<module name="copySkin" type="Tools/CopySkin" muted="0" uid="f9211b6431fe4eae97f8f06a2e7fadd9">
<run><![CDATA[import pymel.core as pm
import os

source = pm.PyNode(@source_mesh)
destination = @destination_mesh

def get_influence_list(m_node):
    pm.select(m_node)
    pm.mel.eval("RemoveUnusedInfluences")
    return pm.skinCluster(m_node, weightedInfluence=True, q=True)

def apply_influence_list(m_node, func):
    pm.skinCluster(m_node, func, bm=1, sm=0, tsb=True)

def copy_skin(m_node, m_node_list):
    lst = get_influence_list(m_node)
    
    sourceSkinCluster = pm.mel.eval('findRelatedSkinCluster '+m_node)
    
    for n in m_node_list:
        apply_influence_list(n, get_influence_list(m_node))
        destSkinCluster = pm.mel.eval('findRelatedSkinCluster '+n)
    
        ##if @by_vertex_ID:        
            ##set_vtx_weights(destination, get_vtx_weights_list(source)) 
        ##else:  
            ##pm.copySkinWeights(ss=sourceSkinCluster, ds=destSkinCluster,  noMirror=True)
        pm.copySkinWeights(ss=sourceSkinCluster, ds=destSkinCluster,  noMirror=True)

def get_vtx_weights_list(m_node):
    skinClust = pm.mel.eval('findRelatedSkinCluster '+m_node)
    inf = pm.PyNode(skinClust)
    joints = inf.influenceObjects()
    list2 = []
    dict = {}
    for vtx in node.vtx:
        list = pm.skinPercent(skinClust, vtx, query=True, value=True )
        cnt = 0
        for jnt in joints:
            dict[jnt.name()] = list[cnt]
            cnt += 1
        list2.append(dict)
    return list2

def set_vtx_weights(m_node, weights_list):
    skinClust = pm.mel.eval('findRelatedSkinCluster '+m_node)
    for vtx in m_node.vtx:
        for l in weights_list:
            for jnt, val in l.items():
                pm.skinPercent(skinClust, node, transformValue=[(jnt, val)])
     

copy_skin(source, destination)]]></run>
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
<children>
</children>
</module>