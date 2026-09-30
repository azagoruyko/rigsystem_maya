<module name="weightByCurve" type="" muted="0" uid="f155eae22ae348e79787de029d544b57">
<run><![CDATA[import pymel.core as pm
import pymel.api as api
import maya.cmds as cmds

geo = pm.PyNode(@geo)
pos = api.MPoint(pm.dt.Point(cmds.xform(@positionFrom, q=True, ws=True, t=True)))
radius = @radius * @radiusMultiplier
weightsAttrPattern = @outWeightAttr+"[%d]"

geoFn = api.MFnMesh(geo.__apimdagpath__())
geoPoints = api.MPointArray()
geoFn.getPoints(geoPoints, api.MSpace.kWorld)
N = geoFn.numVertices()

weights = [0.0] * N

for i in range(N):
    dist = (pos - geoPoints[i]).length()
    if dist >= radius:
        cmds.setAttr(weightsAttrPattern%i, 0)
        continue
        
    param = (radius - dist) / float(radius)
    
    p = evaluateBezierCurveFromX(@curve, param)
    weights[i] = p[1]
    
    cmds.setAttr(weightsAttrPattern%i, weights[i])
]]></run>
<doc><![CDATA[## Summary
The **weightByCurve** module assigns vertex weights to a mesh based on the distance from a reference point and a fall‑off curve. It calculates a weighted influence for each vertex within a specified radius, using a Bezier curve to shape the fall‑off, and writes the resulting weights to a chosen weight attribute.

## Inputs
- **`geo`** – The mesh whose vertices will be weighted (e.g., a character’s geometry).  
- **`positionFrom`** – A transform node whose world position serves as the center of the fall‑off radius.  
- **`radius`** – The base radius (in world units) within which vertices will receive non‑zero weights.  
- **`radiusMultiplier`** – Multiplies the base radius to allow quick scaling of the fall‑off area.  
- **`curve`** – A Bezier curve definition (`cvs`) that determines how the weight falls off from the center to the edge of the radius.  
- **`outWeightAttr`** – The full attribute path (e.g., `cluster.weightList[0].weights`) where the calculated weights will be written.

## Outputs
- **Vertex weights** – The module writes a float value for each vertex of `geo` to the attribute specified by `outWeightAttr`.  
  - Vertices outside the effective radius receive a weight of `0`.  
  - Vertices inside the radius receive a weight derived from the curve, ranging from `0` to `1`.

## Usage
1. **Prepare the scene**  
   - Select the mesh you want to weight and set it as `geo`.  
   - Choose a reference transform (e.g., a control or joint) and set it as `positionFrom`.  
   - Ensure the `outWeightAttr` points to a valid weight list attribute on the mesh or a deformer cluster.

2. **Configure fall‑off**  
   - Set `radius` to the desired influence distance.  
   - Adjust `radiusMultiplier` if you need to scale the radius quickly.  
   - Edit the `curve` values to shape the weight fall‑off (the curve’s X values should span 0–1).

3. **Execute**  
   - Run the module. It will iterate over all vertices, compute the distance to `positionFrom`, evaluate the curve, and write the resulting weights to `outWeightAttr`.

4. **Verify**  
   - Inspect the weight attribute in the channel box or use a weight paint tool to confirm the distribution.  
   - If needed, tweak the curve or radius and re‑run the module to refine the weighting.]]></doc>
<attributes>
<attr name="geo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "Jacket_geoShapeOrig"}]]></attr>
<attr name="positionFrom" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_collar_1_control"}]]></attr>
<attr name="radius" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "10", "validator": 2, "value": 4.82, "min": "0"}]]></attr>
<attr name="radiusMultiplier" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 2, "min": ""}]]></attr>
<attr name="curve" template="curve" category="General" connect=""><![CDATA[{"default": "cvs", "cvs": [[0.0, -0.0], [0.19756654454170688, 0.21424884017788476], [0.42015626958339597, 0.4796203006272556], [0.6302344043750939, 0.683450704225352], [0.7534896029167293, 0.8030402887826206], [0.8814760959817466, 0.8985339418194505], [1.0, 1.0]]}]]></attr>
<attr name="outWeightAttr" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "test_cluster.weightList[0].weights", "min": ""}]]></attr>
</attributes>
<children>
</children>
</module>