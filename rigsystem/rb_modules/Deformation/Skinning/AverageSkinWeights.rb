<module name="averageSkinWeights" type="Tools/AverageSkinWeights" muted="0" uid="d73db96a87244fc5bca4875396ed3dd8">
<run><![CDATA[import pymel.core as pm
import time

ls = pm.ls(sl=True, fl=True)
if ls and len(ls) > 1:    
    geom = ls[0].node()
    skin = pm.PyNode(pm.mel.eval("findRelatedSkinCluster "+geom))
    
    beginProgress("Calculating average", len(ls), 0.1)
    weights = {}    
    for i, v in enumerate(ls):
        stepProgress(i)
        idx = v.indices()[0]
           
        for inf in skin.influenceObjects():
            infIdx = skin.indexForInfluenceObject(inf)
            
            w = pm.getAttr(skin+".weightList[%s].weights[%s]" % (idx, infIdx))
            if not w:
                continue
            
            if inf not in weights: 
                weights[inf] = w
            else:
                weights[inf] = (weights[inf] + w)/2.0
                
    endProgress()        
    
    normalizeWeights = skin.normalizeWeights.get()   
    
    skin.normalizeWeights.set(0)
    for inf in weights:    
        infIdx = skin.indexForInfluenceObject(inf)        
        for v in ls:  
            idx = v.indices()[0]
            w = pm.getAttr(skin+".weightList[%s].weights[%s]"%(idx, infIdx))
            newWeight = weights[inf] * @percent + w*(1-@percent)
            pm.setAttr(skin+".weightList[%s].weights[%s]"%(idx, infIdx), newWeight)
    
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