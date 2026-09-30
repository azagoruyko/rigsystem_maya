<module name="RigHierarchy" muted="0" uid="54888fff338a4a049762cbeb3377f929">
<run><![CDATA[import pymel.core as pm
import rig_utils
import anim_utils

rigt = pm.createNode("transform", n="rig")
rig_utils.lockTRS(rigt, v=0.5)

transform = pm.createNode("transform", n="transform", p=rigt)

internal = pm.createNode("transform", n="internal", p=transform)
rig_utils.lockTRS(internal, v=0.5)

controls = pm.createNode("transform", n="controls", p=transform)
rig_utils.lockTRS(controls, v=0.5)

skeleton = pm.createNode("transform", n="skeleton", p=transform)
rig_utils.lockTRS(skeleton, v=0.5)

geometry = pm.createNode("transform", n="geometry", p=rigt)
rig_utils.lockTRS(geometry, v=0.5)

others = pm.createNode("transform", n="others", p=rigt)
rig_utils.lockTRS(others, v=0.5)

helpers = pm.createNode("transform", n="helpers", p=rigt)
rig_utils.lockTRS(helpers, v=0.5)

main_control = pm.createNode("transform", n="main_control", p=rigt)
helper = rig_utils.curve.makeCurve(main_control, "circle")
helper.s.set([5,5,5])
rig_utils.curve.makeFromCurve(main_control, helper)
pm.delete(helper)

main_control.addAttr("scaleFactor", min=0.01, dv=1, k=True)

main_control.scaleFactor >> main_control.sx
main_control.scaleFactor >> main_control.sy
main_control.scaleFactor >> main_control.sz

pm.parentConstraint(main_control, transform, mo=True)
main_control.s >> transform.s

rig_utils.lockTRS(transform, v=0.5)
rig_utils.lockTRS(main_control, [], [], [1, 1, 1], 1)

anim_utils.dynamicParent.makeDynamicParent(main_control, main_control)

# root joint
rootJoint = pm.createNode("joint", n="root", p=skeleton)
pm.parentConstraint(main_control, rootJoint)
pm.scaleConstraint(main_control, rootJoint)

moduleInfo = rig_utils.moduleInfo.ModuleInfo("rig")
moduleInfo.setAttr("type", "rig")
moduleInfo.setAttr("main_control", main_control.message)

    ]]></run>
<doc><![CDATA[## Summary
Creates a standardized rigt hierarchy for a character asset, including groups for controls, internal logic, helpers, geometry, and deformation. It also generates a main control node with a circular helper, a root joint, and a module information container for downstream rigt modules.

## Inputs
- **None** – This module does not expose any configurable attributes; it simply builds the rigt structure when executed.

## Outputs
- **`main_control`** – A transform node with a circular helper curve, a `scaleFactor` attribute, and constraints to the rig’s transform group.
- **`rootJoint`** – A joint under the `skeleton` group, constrained to the main control.
- **`moduleInfo`** – A `ModuleInfo` node of type `rigt` that publishes the `main_control` message for other modules to reference.
- **Hierarchy Nodes** – The following transform groups are created under the root `rigt` node: `transform`, `internal`, `controls`, `skeleton`, `geometry`, `others`, `helpers`.

## Usage
1. **Execute the module** in the Rig Builder workspace. It will create the rigt hierarchy and the main control node automatically.
2. **Adjust the main control** in the viewport (position, orientation, scale) to match the character’s root.
3. **Connect the `moduleInfo`** or the `main_control` node to downstream rigt modules (e.g., limb, face, or animation modules) that require a reference to the rig’s root.
4. **Export or reference** the created hierarchy for scene integration, ensuring that the `rigt` node remains the top‑level parent for all rigt elements.]]></doc>
</module>