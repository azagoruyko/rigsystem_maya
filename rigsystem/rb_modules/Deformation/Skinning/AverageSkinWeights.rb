<module name="averageSkinWeights" type="Tools/AverageSkinWeights" muted="0" uid="d73db96a87244fc5bca4875396ed3dd8">
<run><![CDATA[import maya.api.OpenMayaAnim as oma
import maya.mel as mel
from rigsystem import proxy

cmds = proxy.cmds

selection = cmds.ls(sl=True, fl=True) or []
if selection and len(selection) > 1:
    geom = selection[0].split(".", 1)[0]
    skinName = mel.eval('findRelatedSkinCluster "{}"'.format(geom))
    skin = proxy.node(skinName)
    skinFn = oma.MFnSkinCluster(skin.mobject)
    vertexIndices = [
        int(component.rsplit("[", 1)[1][:-1])
        for component in selection
    ]
    influenceIndices = [
        skinFn.indexForInfluenceObject(proxy.node(influence).dagPath)
        for influence in cmds.skinCluster(str(skin), query=True, influence=True) or []
    ]
    
    beginProgress("Calculating average", len(selection), 0.1)
    weights = {}    
    for i, idx in enumerate(vertexIndices):
        stepProgress(i)
           
        for infIdx in influenceIndices:
            
            w = cmds.getAttr("{}.weightList[{}].weights[{}]".format(skin, idx, infIdx))
            if not w:
                continue
            
            if infIdx not in weights:
                weights[infIdx] = w
            else:
                weights[infIdx] = (weights[infIdx] + w) / 2.0
                
    endProgress()        
    
    normalizeWeights = skin.normalizeWeights.get()
    
    skin.normalizeWeights.set(0)
    for infIdx in weights:
        for idx in vertexIndices:
            w = cmds.getAttr("{}.weightList[{}].weights[{}]".format(skin, idx, infIdx))
            newWeight = weights[infIdx] * @percent + w*(1-@percent)
            cmds.setAttr("{}.weightList[{}].weights[{}]".format(skin, idx, infIdx), newWeight)
    
    skin.normalizeWeights.set(normalizeWeights)]]></run>
<doc><![CDATA[## Summary  
The **Average Skin Weights** tool blends the influence weights of a skin cluster across a set of selected vertices. It computes the average weight for each influence within the selection and then mixes this average with the existing vertex weights according to a user‑defined percentage.

## Inputs  
- **Vertex Selection**: Any number of vertices on a mesh that is bound to a skin cluster. The first selected vertex is used to locate the skin cluster.  
- **Percent (`percent`)**: A float (default 0.5) that determines the blend ratio.  
  - `0` → no change (original weights).  
  - `1` → all selected vertices receive the exact average weight.  
  - Values in between linearly interpolate between the original and the average.

## Outputs  
- **In‑place weight modification**: The tool updates the weight list of the skin cluster directly; no new nodes or attributes are created.  
- **Optional progress feedback**: A progress bar is shown during calculation.

## Usage  
1. Select the vertices on the skinned mesh that you want to average.  
2. Open the **Average Skin Weights** tool.  
3. Set the **Percent** field to the desired blend ratio (e.g., 0.75 for a 75 % average).  
4. Click **Run**.  
5. The skin cluster weights for the selected vertices will be updated immediately.  
6. Verify the result by inspecting the skin weights or using a weight paint tool.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Select vertices on skinned mesh.\nIf percent=1 then all selected vertices will have the same weights."}]]></attr>
<attr name="percent" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "value": 0.5}]]></attr>
</attributes>
<children>
</children>
</module>