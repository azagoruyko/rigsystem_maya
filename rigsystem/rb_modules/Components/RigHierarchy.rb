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
Creates a basic rig hierarchy with a main control, root joint, and supporting transform nodes, sets up constraints and dynamic parenting, and publishes a `moduleInfo` node for downstream modules.

## Inputs
- **None** – The module does not require any external inputs; all nodes are created internally.

## Outputs
- **`main_control`** – The primary control transform that drives the rig and is exposed via the `moduleInfo` node.
- **`rootJoint`** – The root joint of the skeleton, parented to the `skeleton` transform and constrained to `main_control`.
- **`moduleInfo`** – A `ModuleInfo` node named `"rig"` that stores the rig type and a message reference to `main_control`.
- **Rig hierarchy nodes** – `rigt`, `transform`, `internal`, `controls`, `skeleton`, `geometry`, `others`, `helpers`, and the dynamic parent node created by `anim_utils.dynamicParent.makeDynamicParent`.

## Usage
1. Execute the module; it will automatically create the rig hierarchy and publish the `moduleInfo` node.
2. The `main_control` can be positioned and scaled in the scene; its scale factor attribute controls the size of the control.
3. Downstream modules can connect to the `moduleInfo` node or directly to `rootJoint`/`main_control` to attach additional rig components.]]></doc>
</module>