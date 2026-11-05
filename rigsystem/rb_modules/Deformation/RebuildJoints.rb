<module name="rebuildJoints" muted="0" uid="31428debb222403b9b8e1d7308d3f8a1">
<run><![CDATA[import maya.api.OpenMaya as om
import re
from rigsystem import proxy, rig_utils

cmds = proxy.cmds

def getIncrementedName(name):
    lastNumRegex = "(\\d+)([a-zA-Z_]*$)"
    r = re.search(lastNumRegex, name)
    if r:
        d = int(r.group(1))
        d += 1
        return re.sub(lastNumRegex, "%s\\2"%d, name)
    else:
        return name

inputJoints = proxy.nodes(@inputJoints)
orientation = cmds.xform(@orientFrom, q=True, ws=True, ro=True)

cvs = [cmds.xform(str(j), q=True, ws=True, t=True) for j in inputJoints]

crv = cmds.curve(d=1, p=cvs)
cmds.rebuildCurve(crv, rpo=1, rt=0, end=1, kr=0, kcp=0, kep=1, kt=0, s=1, d=3, tol=0.01)
curveShape = proxy.node(crv).getShapes(type="nurbsCurve")[0]
curveFn = curveShape.mfn(shape=True)

orientJoint = proxy.node(@orientFrom)
orientCoeff = 1 if (
    rig_utils.matrix.xaxis(orientJoint.worldMatrix[0].get())
    * curveFn.tangent(0, om.MSpace.kWorld)
) > 0 else -1

for j in inputJoints[1:-1]: # keep start/end
    cmds.ungroup(str(j))

jointName = getIncrementedName(str(inputJoints[0]))

joints = []
for i in range(@numJoints):
    param = (i+1) / float(@numJoints+1)
    p = curveFn.getPointAtParam(param, om.MSpace.kWorld)
    tg = curveFn.tangent(param, om.MSpace.kWorld)
    
    name = jointName
    
    j = proxy.create("joint", name, suffix=False)
    cmds.setAttr(f"{j}.translate", p.x, p.y, p.z, type="double3")
    cmds.setAttr(f"{j}.rotate", *orientation, type="double3")
    j.radius.set(inputJoints[0].radius.get())
    
    q = om.MQuaternion(orientCoeff * rig_utils.matrix.xaxis(j.worldMatrix[0].get()), tg)
    j.mfn().rotateBy(q, om.MSpace.kTransform)
    
    if i == 0:
        inputJoints[0] | j
    else:
        joints[-1] | j
        
    if i == @numJoints-1:        
        j | inputJoints[-1]
        
    joints.append(j)
    jointName = getIncrementedName(jointName)

inputJoints[-1].rename(jointName)
    
cmds.delete(crv)

rig_utils.freezeJoints(joints)
rig_utils.freezeJoints([inputJoints[0], inputJoints[-1]])
]]></run>
<doc><![CDATA[## Summary
Rebuilds a joint chain by inserting a specified number of evenly spaced joints along a curve defined by the original joints. The module keeps the first and last joints, creates new joints between them, aligns them to the curve’s tangent, and freezes the resulting joints.

## Inputs
- **`inputJoints`**: A list of joint nodes that define the original chain. The first and last joints are preserved; new joints are inserted between them.
- **`numJoints`**: The number of new joints to create along the curve (excluding the start and end joints).
- **`orientFrom`**: A joint node whose world rotation is used to orient the newly created joints.

## Outputs
- The original joint chain is modified in place:  
  - New joints are inserted between the first and last joints.  
  - The last joint is renamed to match the naming pattern of the new joints.  
  - All joints (original and new) are frozen to lock their transforms.

## Usage
1. **Select the joint chain** you wish to rebuild and list them in the `inputJoints` attribute (e.g., `M_spine_1_joint` to `M_spine_6_joint`).  
2. **Set `numJoints`** to the desired number of intermediate joints (e.g., `4`).  
3. **Choose an orientation reference** in `orientFrom` (typically a joint near the start of the chain).  
4. **Execute the module**. It will create a curve through the original joints, generate the new joints along that curve, align them, rename the end joint, delete the temporary curve, and freeze all joints.  
5. **Verify the rebuilt chain** in the scene; the joint hierarchy should now contain the new evenly spaced joints with proper orientation.]]></doc>
<attributes>
<attr name="inputJoints" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["M_spine_1_joint", "M_spine_2_joint", "M_spine_3_joint", "M_spine_4_joint", "M_spine_5_joint", "M_spine_6_joint"]}]]></attr>
<attr name="numJoints" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "value": 4}]]></attr>
<attr name="orientFrom" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_spine_2_joint"}]]></attr>
</attributes>
<children>
</children>
</module>
