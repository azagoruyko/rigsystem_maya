<module name="rebuildJoints" muted="0" uid="31428debb222403b9b8e1d7308d3f8a1">
<run><![CDATA[import pymel.core as pm
import pymel.api as api
import re
import rig_utils

def getIncrementedName(name):
    lastNumRegex = "(\\d+)([a-zA-Z_]*$)"
    r = re.search(lastNumRegex, name)
    if r:
        d = int(r.group(1))
        d += 1
        return re.sub(lastNumRegex, "%s\\2"%d, name)
    else:
        return name

inputJoints = [pm.PyNode(j) for j in @inputJoints]
orientation = pm.xform(@orientFrom, q=True, ws=True, ro=True)

cvs = [j.getTranslation("world") for j in inputJoints]

crv = pm.curve(d=1, p=cvs)
pm.rebuildCurve(crv, rpo=1, rt=0, end=1, kr=0, kcp=0, kep=1, kt=0, s=1, d=3, tol=0.01)

orientCoeff = 1 if rig_utils.xaxis(pm.PyNode(@orientFrom).worldMatrix.get()) * crv.tangent(0) > 0 else -1

for j in inputJoints[1:-1]: # keep start/end
    j.ungroup()

jointName = getIncrementedName(inputJoints[0].name())

joints = []
for i in range(@numJoints):
    param = (i+1) / float(@numJoints+1)
    p = crv.getPointAtParam(param)
    tg = crv.tangent(param)
    
    name = jointName
    
    j = pm.createNode("joint", n=name)
    j.t.set(p)
    j.r.set(orientation)
    j.radius.set(inputJoints[0].radius.get())
    
    q = api.MQuaternion(orientCoeff*rig_utils.xaxis(j.worldMatrix.get()), tg)
    j.rotateBy(q)        
    
    if i == 0:
        inputJoints[0] | j
    else:
        joints[-1] | j
        
    if i == @numJoints-1:        
        j | inputJoints[-1]
        
    joints.append(j)
    jointName = getIncrementedName(jointName)

inputJoints[-1].rename(jointName)
    
pm.delete(crv)

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