<module name="AttachToCurve" muted="0" uid="b79ce70fe8fc4009a31219c30b5eb506">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds
curve = proxy.node(@curve)
transforms = proxy.nodes(@transforms)
curveShape = curve.getShapes(type="nurbsCurve")[0] if curve.type() == "transform" else curve
curveFn = curveShape.mfn(shape=True)

for t in transforms:
    coords = cmds.xform(str(t), q=True, ws=True, t=True)
    position = om.MPoint(coords[0], coords[1], coords[2])
    _, param = curveFn.closestPoint(position, 1e-6, om.MSpace.kWorld)
    poci = proxy.create("pointOnCurveInfo", f"{t}")
    curveShape.worldSpace[0] >> poci.inputCurve
    poci.parameter.set(param)
    poci.turnOnPercentage.set(False)
    pmm = proxy.create("pointMatrixMultDL", f"{t}_parentInverse")
    poci.position >> pmm.inPoint
    t.parentInverseMatrix >> pmm.inMatrix
    pmm.output >> t.translate
    ]]></run>
<doc><![CDATA[## Summary  
The **attachToCurve** module snaps a list of transforms to a NURBS curve by projecting each transform’s world position onto the curve. It uses a `pointOnCurveInfo` node to drive the transform’s translation, leaving rotation and scale untouched.

## Inputs  
- **`curve`** – Name or reference to the NURBS curve that will serve as the attachment surface.  
- **`transforms`** – List of transform nodes whose world positions will be projected onto the curve.  

## Outputs  
- No explicit output nodes are created.  
- The module directly modifies the **translate** attributes of each transform in the `transforms` list, aligning them to the nearest point on the specified curve.

## Usage  
1. **Select the curve** you want the transforms to follow and set the **`curve`** attribute (or use its button to pick the selected curve).  
2. **Populate the `transforms` list** with the transforms to attach.  
3. **Run the module**. Each transform is snapped to the curve and follows its shape.  
4. **Adjust** the transforms as needed; their translate remains connected to the curve.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS curve</b> using closest point (translate only)."}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "curve1", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["pCube1"], "default": "items"}]]></attr>
</attributes>
</module>
