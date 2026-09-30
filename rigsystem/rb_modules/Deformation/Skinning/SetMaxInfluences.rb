<module name="setMaxInfluences" type="Tools/SetMaxInfluences" muted="0" uid="ba683572a8564671832cbe81d0fc0b8c">
<run><![CDATA[import pymel.core as pm

def setMaxInfluences(geo, maxinf=4):
    geo = pm.PyNode(geo)
    skin = pm.mel.eval("findRelatedSkinCluster "+geo)
    if not skin:
        pm.warning("setMaxInfluences: cannot find skinCluster on '%s'"%geo)
        return
    
    invalidIndices = []
    
    beginProgress("Set max influences", geo.numVertices(), 0.25)
    for i in range(geo.numVertices()):
        stepProgress(i)
        
        vtx = geo + ".vtx[%d]"%i
        weights = pm.skinPercent(skin, vtx, ignoreBelow=0.0001,query=True, value=True)
        
        if len(weights) > maxinf:
            invalidIndices.append(i)
            
            maxWeights = [0] * len(weights)
            for w in weights:                               
                # Move the target influence down until the bottom is reached (-1) or the next influence is greater
                j = len(weights)-1
                while j >= 0 and w > maxWeights[j]: 
                    j -= 1
                j += 1
                
                k = len(weights)-1
                while k > j:
                    maxWeights[k] = maxWeights[k-1]
                    k -= 1
                    
                maxWeights[k] = w
                 
            pruneValue = maxWeights[maxinf] + 0.0001
            pm.skinPercent(skin, vtx, pruneWeights=pruneValue)                             
    endProgress()
    print(invalidIndices)
    
if pm.objExists(@geo):
    setMaxInfluences(@geo, @maxInf)        
else:
    warning("Cannot find '%s' geometry"%@geo)    ]]></run>
<doc><![CDATA[## Summary
Clamps the number of joint influences per vertex on a selected geometry’s skinCluster, pruning any weights that exceed a user‑defined maximum. The tool also reports the vertex indices that were affected.

## Inputs
- **`geo`** (`lineEditAndButton`): The name of the geometry node whose skinCluster will be processed.  
- **`maxInf`** (`lineEdit`): Integer specifying the maximum allowed influences per vertex (default = 4, minimum = 2, maximum = 10).

## Outputs
- **In‑place modification**: The skinCluster on the specified geometry is updated; vertices with more than `maxInf` influences have the lowest weights pruned.  
- **Console report**: A list of vertex indices that exceeded the influence limit is printed to the script editor.

## Usage
1. **Select the target geometry** in the Maya viewport or type its name into the `geo` field.  
2. **Set the desired maximum influences** in the `maxInf` field (e.g., 4).  
3. **Execute the module** (click the run button or press the assigned hotkey).  
4. **Review the console output** for any vertex indices that were pruned.  
5. **Verify the skinning** by inspecting the skinCluster weights or using the `skinCluster` editor.]]></doc>
<attributes>
<attr name="geo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "Cat_geo"}]]></attr>
<attr name="maxInf" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "10", "validator": 1, "value": 4, "min": "2"}]]></attr>
</attributes>
<children>
</children>
</module>