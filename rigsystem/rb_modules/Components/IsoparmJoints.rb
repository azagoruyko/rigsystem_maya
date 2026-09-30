<module name="isoparmJoints" muted="0" uid="a7c82e914f6b4d32a9018e472bc194d3">
<run><![CDATA[import pymel.core as pm
import rig_utils

isoparm = pm.PyNode(@isoparm.strip())

surface = isoparm.node()
uRange = surface.minMaxRangeU.get()
vRange = surface.minMaxRangeV.get()

# 1. Create curve from selected isoparm with construction history
curve = pm.PyNode(pm.duplicateCurve(isoparm, ch=True, n=@name + "_curve")[0])

isoNode = curve.getShape().create.inputs(type="curveFromSurfaceIso")[0]
isoNode.rename(@name + "_curveFromSurfaceIso")

isoDir = isoNode.isoparmDirection.get() # 0 = U isoparm (V varies), 1 = V isoparm (U varies)
isoVal = isoNode.isoparmValue.get()

if isoDir == 0: # U
    uStart, vStart = uRange[0], isoVal
    uEnd, vEnd = uRange[1], isoVal
else:
    uStart, vStart = isoVal, vRange[0]
    uEnd, vEnd = isoVal, vRange[1]
    
if @inverted:
    uStart, uEnd = uEnd, uStart
    vStart, vEnd = vEnd, vStart

# 2. Position transforms on surface at start (A) and end (B) rotated by surface normal
surfLocA = pm.PyNode(rig_utils.makeSurfaceTransform(@name + "_a_transform", surface, uStart, vStart))
surfLocB = pm.PyNode(rig_utils.makeSurfaceTransform(@name + "_b_transform", surface, uEnd, vEnd))

# 3. Create two joint chain (Bone A and Bone B)
jointA = rig_utils.matchJoint(surfLocA, @name + "_a_joint")
jointB = rig_utils.matchJoint(surfLocB, @name + "_b_joint")
jointA | jointB

# Start of curve/isoparm controls Bone A
pm.pointConstraint(surfLocA, jointA)

# 4. Use SC handle to control A, B bones (end of curve/isoparm controls Bone B)
ikHandle = pm.ikHandle(sj=jointA, ee=jointB, sol="ikSCsolver", n=@name + "_ikHandle")[0]
ikHandle.v.set(False)
surfLocB | ikHandle
]]></run>
<doc><![CDATA[## Summary  
Creates a two‑bone joint chain that follows a NURBS surface isoparm, driven by an SC IK handle. The chain is positioned at the start and end of the isoparm, oriented by the surface normal, and can be flipped along the isoparm direction.

## Inputs  
- **`name`** – Base name used for all created nodes (`*_curve`, `*_curveFromSurfaceIso`, `*_a_transform`, `*_b_transform`, `*_a_joint`, `*_b_joint`, `*_ikHandle`).  
- **`isoparm`** – Full path to the selected isoparm node (e.g., `loftedSurface1.u[8.58907269150601]`).  
- **`inverted`** – Boolean flag that reverses the start/end positions along the isoparm.

## Outputs  
- **Curve & Iso Node** – A duplicate of the isoparm curve (`<name>_curve`) and its `curveFromSurfaceIso` node (`<name>_curveFromSurfaceIso`).  
- **Surface Transforms** – Two transforms positioned on the surface at the isoparm start and end (`<name>_a_transform`, `<name>_b_transform`).  
- **Joint Chain** – Two joints (`<name>_a_joint`, `<name>_b_joint`) aligned with the surface transforms.  
- **IK Handle** – An SC IK handle (`<name>_ikHandle`) that drives the joint chain along the isoparm.  
- **Constraints** – A point constraint from the start transform to joint A and a parent constraint from joint B to the end transform.

## Usage  
1. **Select an isoparm** in the viewport and run the module.  
2. Set the **`name`** field to a descriptive identifier (e.g., `sleeve`).  
3. Toggle **`inverted`** if you want the chain to follow the isoparm in the opposite direction.  
4. Execute the module. It will create the curve, surface transforms, joints, and an SC IK handle named with the supplied base name.  
5. Adjust the created joints or IK handle as needed for your rig. The chain can be used as a foundation for cloth anchors, sleeve rigs, or other surface‑attached bone systems.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "sleeve", "buttonEnabled": false}]]></attr>
<attr name="isoparm" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "loftedSurface1.u[8.58907269150601]", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="inverted" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
</attributes>
</module>