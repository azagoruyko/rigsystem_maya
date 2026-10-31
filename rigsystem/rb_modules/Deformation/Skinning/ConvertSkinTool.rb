<module name="convertSkinTool" type="Tools/ConvertSkinTool" muted="0" uid="c7568f79334f48238ef02aacbae45fbe">
<run><![CDATA[# The script moves joints and use current deformer to get skin weights for each joint.

import maya.api.OpenMaya as om
import maya.api.OpenMayaAnim as oma
import maya.mel as mel
from rigsystem import proxy

cmds = proxy.cmds

try:
    import ngSkinTools as ng
    ngSkinToolsAvailable = True
except ImportError:    
    ngSkinToolsAvailable = False

geo = proxy.node(@sourceGeo)
joints = proxy.nodes(@joints)

geoShape = geo.getShapes(type="mesh")[0]
geoFn = om.MFnMesh(geoShape.dagPath)
origPoints = geoFn.getPoints(om.MSpace.kWorld)

skin = mel.eval('findRelatedSkinCluster "{}"'.format(@skinGeo))
if not skin:
    cmds.error("Cannot find skinCluster on " + @skinGeo)

skin = proxy.node(skin)
skinFn = oma.MFnSkinCluster(skin.mobject)

if ngSkinToolsAvailable and @ngskin_layerName:
    ngmll = ng.mllInterface.MllInterface()
    ngmll.setCurrentMesh(@skinGeo)
    
    if ngmll.getLayersAvailable():
        print("Init ngSkinTools layers")
        ngmll.initLayers()    

influenceObjects = cmds.skinCluster(str(skin), query=True, influence=True) or []

for j in joints:
    if str(j) not in influenceObjects:
        error("Cannot find {} in {}".format(j, skin))
        continue

    print(j)
    old_t = cmds.getAttr(f"{j}.translate")[0]
    idx = skinFn.indexForInfluenceObject(j.dagPath)
    try:
        cmds.setAttr(f"{j}.ty", cmds.getAttr(f"{j}.ty") + 1)

        points = geoFn.getPoints(om.MSpace.kWorld)
        beginProgress("Converting %s" % j, points.length(), 0.10)

        weights = [0.0] * points.length()
        for i in range(points.length()):
            weight = (origPoints[i] - points[i]).length()
            cmds.setAttr(
                f"{skin}.weightList[{i}].weights[{idx}]", weight
            )
            weights[i] = weight
            stepProgress(i)

        if ngSkinToolsAvailable and @ngskin_layerName:
            getLayerIds = lambda layerName: [
                layer[0] for layer in ngmll.listLayers() if layer[1] == layerName
            ]
            layerIds = getLayerIds(@ngskin_layerName)
            layerId = layerIds[0] if layerIds else ngmll.createLayer(@ngskin_layerName)
            ngmll.setInfluenceWeights(layerId, idx, weights)
    finally:
        cmds.setAttr(f"{j}.translate", *old_t, type="double3")
        if 'points' in locals():
            endProgress()
]]></run>
<doc><![CDATA[## Summary  
The **ConvertSkinTool** module re‑weights a Maya skinCluster by temporarily moving each influence joint, measuring the change in vertex positions, and assigning those distances as new weights. It can optionally write the resulting weights into an ngSkinTools layer for use in real‑time engines or modular rigs.

## Inputs  
- **`sourceGeo`** – The geometry that is currently deformed by a deformer controlled by the joints.  
- **`skinGeo`** – The geometry that owns the skinCluster to be updated; it must have the same joints as influences.  
- **`joints`** – A list of joint names that influence the skinCluster.  
- **`ngskin_layerName`** (optional) – Name of an ngSkinTools layer to store the new weights; if omitted or empty, only the skinCluster is updated.

## Outputs  
- The **skinCluster** on `skinGeo` is updated with new weights derived from the joint‑movement distance.  
- If `ngskin_layerName` is provided and ngSkinTools is available, a corresponding layer is created or updated with the same weight data.

## Usage  
1. **Set up the scene**  
   - Select the geometry that will be deformed (`sourceGeo`).  
   - Select the geometry that owns the skinCluster (`skinGeo`).  
   - Ensure the joints listed in `joints` are influences of that skinCluster.  
2. **Configure the tool**  
   - In the module UI, enter the names of `sourceGeo`, `skinGeo`, and the joint list.  
   - Optionally specify an ngSkinTools layer name if you want the weights stored for later use.  
3. **Run the conversion**  
   - Execute the module. It will temporarily move each joint up by 1 unit, compute the resulting vertex displacement, and write those distances as new weights.  
   - Progress is shown in a dialog; the operation finishes with the skinCluster (and optional layer) updated.  
4. **Verify**  
   - Inspect the skinCluster weights or the ngSkinTools layer to confirm the new values.  
   - Use the updated skin for real‑time evaluation or further rigging steps.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "<html>\n<b>sourceGeo</b> should be deformed by a some deformer.<br>\nThat defomer must be controlled by <b>joints</b><br>\n<b>skinGeo</b> must have <b>joints</b> as influences.\n</html>\n\n"}]]></attr>
<attr name="sourceGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "head_geo"}]]></attr>
<attr name="skinGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "head_geo"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["L_eyelid_upper_1_joint", "L_eyelid_upper_2_joint"]}]]></attr>
<attr name="ngskin_layerName" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "eyelids", "min": ""}]]></attr>
</attributes>
<children>
</children>
</module>