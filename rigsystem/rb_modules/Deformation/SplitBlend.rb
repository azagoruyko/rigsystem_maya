<module name="splitBlend" muted="0" uid="909adcb7aa7c4d9eaedc54c95ddf9165">
<run><![CDATA[import pymel.core as pm
import rig_utils

skinGeo = pm.PyNode(@skinGeo)
blendGeo = pm.PyNode(@blendGeo)
skin = pm.mel.eval("findRelatedSkinCluster " + skinGeo)

if not skin:
    error("Cannot find skinCluster on '%s'" % skinGeo)

print("Normalize skinCluster weights")
skinHelper = rig_utils.skinCluster.SkinClusterHelper(skin)
skinWeights = skinHelper.getSkinWeights()
skinWeights.normalize()

skinPoints = skinGeo.getPoints()
blendPoints = blendGeo.getPoints()

for j in @joints:
    idx = skinHelper.getInfluencePhysicalIndex(j)
    if idx is None:
        print("Warning: Joint %s is not an influence in %s" % (j, skin))
        continue

    weights = skinWeights.getInfluenceWeights(idx)
    newPoints = [s + (b - s) * w for s, b, w in zip(skinPoints, blendPoints, weights)]

    newBlendGeo = skinGeo.duplicate(name="%s_%s_geo" % (blendGeo, j))[0]
    newBlendGeo.setPoints(newPoints)
]]></run>
<doc><![CDATA[## Summary
The **splitBlend** module creates joint‑based corrective blendshape targets by leveraging the skinCluster weights of a source geometry. For each selected joint, it generates a new geometry that contains only the deformation contributed by that joint, allowing localized control of blendshape influence.

## Inputs
- **`skinGeo`** – The source geometry that has a skinCluster attached.  
- **`blendGeo`** – The target geometry whose shape will be split.  
- **`joints`** – A list of joint names (or transform nodes) that are influences of the skinCluster. These joints determine which corrective shapes are generated.

## Outputs
- **New geometry nodes** – For every joint in `joints`, a duplicate of `skinGeo` is created and named `"<blendGeo>_<joint>_geo"`.  
  These meshes contain the deformation contributed solely by the corresponding joint and can be used as individual blendshape targets or corrective shapes.

## Usage
1. **Set the source and target geometries**  
   - In the `skinGeo` field, choose the geometry that has the skinCluster.  
   - In the `blendGeo` field, choose the geometry you want to split (often a blendshape target).  

2. **Select the joints**  
   - Use the list box to add the joints that influence the skinCluster.  
   - Joints not found in the skinCluster will trigger a warning but will be skipped.  

3. **Run the module**  
   - Execute the module. It will normalize the skin weights, compute the joint‑specific deformations, and duplicate the geometry for each joint.  

4. **Utilize the results**  
   - The newly created meshes can be added to a blendshape node as separate targets, giving you fine‑grained control over each joint’s contribution.  
   - Optionally, rename or organize the generated meshes as needed for your pipeline.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "<html>\nSplit a blendShape using skinCluster weights on <b>joints</b>.\n</html>"}]]></attr>
<attr name="skinGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_pursed_blend_geo", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="blendGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lip_pursed_blend_geo1", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_upper", "R_upper", "L_lower", "R_lower"], "default": "items"}]]></attr>
</attributes>
</module>