<module name="attachToCurve" muted="0" uid="b79ce70fe8fc4009a31219c30b5eb506">
<run><![CDATA[import pymel.core as pm
import maya.cmds as cmds

curve = pm.PyNode(@curve)
transforms = [pm.PyNode(t) for t in @transforms]

curveShape = curve.getShape() if curve.type() == "transform" else curve

for t in transforms:
    pos = pm.xform(t, q=True, ws=True, t=True)
    
    cl = curve.closestPoint(pos)
    param = curve.getParamAtPoint(cl)

    # Create pointOnCurveInfo to drive position
    poci = pm.createNode("pointOnCurveInfo", n=t.name() + "_pointOnCurveInfo")
    curveShape.worldSpace[0] >> poci.inputCurve
    poci.parameter.set(param)
    poci.turnOnPercentage.set(False)
    
    pmm = pm.createNode("pointMatrixMultDL", n=t.name()+"_parentInverse_pointMatrixMultDL")
    poci.position >> pmm.inPoint
    t.parentInverseMatrix >> pmm.inMatrix    
    pmm.output >> t.translate
    ]]></run>
<doc><![CDATA[## Summary  
The **attachToCurve** module snaps a list of transforms to a NURBS curve by projecting each transform’s world position onto the curve. It uses a `nearestPointOnCurve` node to find the closest curve parameter and a `pointOnCurveInfo` node to drive the transform’s translate, leaving rotation and scale untouched.

## Inputs  
- **`curve`** – Name or reference to the NURBS curve that will serve as the attachment surface.  
- **`transforms`** – List of transform nodes whose world positions will be projected onto the curve.  

## Outputs  
- No explicit output nodes are created.  
- The module directly modifies the **translate** attributes of each transform in the `transforms` list, aligning them to the nearest point on the specified curve.

## Usage  
1. **Select the curve** you want to attach to and set the `curve` attribute (or use the button to pick the selected curve).  
2. **Populate the `transforms` list** with the transforms you wish to snap (e.g., IK handles, control joints, helper objects).  
3. **Run the module**. Each transform’s translate will be driven by a `pointOnCurveInfo` node that follows the curve’s shape.  
4. **Optional**: After execution, the temporary `nearestPointOnCurve` node is automatically deleted, leaving only the `pointOnCurveInfo` nodes connected to the transforms.  
5. **Adjust** the transforms in the viewport if needed; the connections will keep them attached to the curve as you move the curve or the transforms.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS curve</b> using closest point (translate only)."}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "curve1", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["pCube1"], "default": "items"}]]></attr>
</attributes>
</module>