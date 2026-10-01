<module name="GotoBindPose" muted="0" uid="b578e5408c1f4a94b6d5b528c90376c9">
<run><![CDATA[import pymel.core as pm

for j in pm.selected(type="joint"):
    if not pm.objExists(@skin):
        conn = j.worldMatrix.outputs(type="skinCluster", p=True)
        if not conn:
            continue
        
        plug = conn[0]
        skin = plug.node()
                
        idx = plug.index()
    else:
        skin = pm.PyNode(@skin)
        try:
            idx = skin.indexForInfluenceObject(j)
        except:
            continue
                        
    m = skin.bindPreMatrix[idx].get()
    
    print(f"Reset {j}")
    pm.xform(j, ws=True, m=m.inverse())]]></run>
<doc><![CDATA[## Summary
Resets the world-space transforms of selected joints to their bind pose by applying the inverse of the skinCluster’s bindPreMatrix. If a skinCluster is not explicitly provided, the module automatically detects the skinCluster connected to each joint.

## Inputs
- **`skin` (optional)**: Name or reference to a skinCluster node. If omitted, the module searches for a skinCluster connected to each selected joint.
- **Selected Joints**: Joints must be selected in the scene before executing the module.

## Outputs
- No explicit output attributes are created. The module performs in‑scene transformations and prints a confirmation message for each processed joint.

## Usage
1. Select the joints you wish to reset to bind pose.  
2. (Optional) Set the `skin` attribute to the name of the skinCluster that drives those joints.  
3. Run the module.  
4. The console will display “Reset \<joint_name\>” for each joint, and the joint’s transform will be set to its bind pose.]]></doc>
<attributes>
<attr name="skin" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Maya node", "buttonCommand": "import pymel.core as pm\n\nls = pm.selected(type=\"transform\")\nif not ls:\n    value = \"\"\nelse:    \n    skin = pm.mel.eval(f\"findRelatedSkinCluster {ls[0]}\")\n    if not skin:\n        value = \"\"\n    else:        \n        value = skin", "buttonLabel": "Get from mesh", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>