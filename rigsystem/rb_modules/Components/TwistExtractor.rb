<module name="twistExtractor" muted="0" uid="08fbae9dd4ed41d48dc05d69ddbf6134">
<run><![CDATA[import pymel.core as pm

prefix = @name + "_twistExtractor"

orientation = pm.PyNode(@orientation)
parent = pm.PyNode(@parent)

aux1 = pm.createNode("joint", n=prefix+"_1_joint", p=parent)
aux2 = pm.createNode("joint", n=prefix+"_2_joint", p=aux1)

pm.delete(pm.orientConstraint(@orientation, aux1))
pm.delete(pm.orientConstraint(@orientation, aux2))

pm.delete(pm.pointConstraint(@point1, aux1))
pm.delete(pm.pointConstraint(@point2, aux2))

ik = pm.ikHandle(sj=aux1, ee=aux2, solver="ikSCsolver")
ik[0].rename(prefix+"_ikHandle")
ik[0].v.set(False)
parent | ik[0]

pm.scaleConstraint(parent, aux1)

pm.pointConstraint(@point1, aux1)
pm.pointConstraint(@point2, ik[0])
pm.orientConstraint(@orient, ik[0], mo=True)]]></run>
<doc><![CDATA[## Summary
The module creates a twist‑extractor rig for a two‑joint limb. It builds two helper joints, an IK handle between them, and applies orientation, point, and scale constraints so that the twist of the source joint is distributed smoothly along the chain.

## Inputs
- **`name`** – Base name used for all created nodes (e.g., `L_arm_1`).
- **`orientation`** – The joint or transform whose axial rotation will be extracted (default: `L_arm_1_joint`).
- **`point1`** – Transform that will be point‑constrained to the first helper joint (default: `L_arm_1_joint`).
- **`point2`** – Transform that will be point‑constrained to the second helper joint (default: `L_arm_2_joint`).
- **`orient`** – Transform used to orient the IK handle with maintain offset (`mo=True`) (default: `L_shoulder_joint`).
- **`parent`** – Parent node under which the helper joints and IK handle will be created (default: `internal`).

## Outputs
- **`<name>_1_joint`** – First helper joint, parented to `parent`.
- **`<name>_2_joint`** – Second helper joint, child of the first helper joint.
- **`<name>_ikHandle`** – IK handle created between the two helper joints, parented to `parent`.
- **Constraints** –  
  - Orientation constraints from `orientation` to both helper joints.  
  - Point constraints from `point1` to the first helper joint and from `point2` to the IK handle.  
  - An orientation constraint from `orient` to the IK handle with maintain offset.  
  - A scale constraint from `parent` to the first helper joint.

These nodes can be connected to downstream deformation or control systems to apply the extracted twist.

## Usage
1. **Set the attributes**:  
   - Choose the joint that carries the twist (`orientation`).  
   - Specify the start and end points (`point1`, `point2`) that should follow the helper joints.  
   - Provide an orientation reference (`orient`) for the IK handle.  
   - Optionally change the `parent` to place the helper nodes in a desired hierarchy.  
2. **Execute the module**: Run the module to create the helper joints, IK handle, and constraints.  
3. **Connect downstream**: Use the created `<name>_ikHandle` or helper joints as inputs to deformation rigs, blend shapes, or other twist‑distribution systems.  
4. **Adjust as needed**: Move or rotate the helper joints to fine‑tune the twist distribution; the constraints will keep the system stable.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "L_arm_1", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="orientation" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="point1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="point2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_2_joint"}]]></attr>
<attr name="orient" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_shoulder_joint"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "internal"}]]></attr>
</attributes>
</module>