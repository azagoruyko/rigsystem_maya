<module name="ConstrainToClosest" muted="0" uid="7326747d968a47ca9d7ba65e2dce3019">
<run><![CDATA[import math
import pymel.core as pm

boneNames = @transforms
rootName = @rootJoint.strip()
maxDistance = @maxDistance

if not boneNames:
    error("Add at least one bone to the bones list.")
if not rootName or not pm.objExists(rootName):
    error("Specify an existing target root joint.")

root = pm.PyNode(rootName)
if pm.nodeType(root) not in ("transform", "joint"):
    error("Target root must be a transform or joint.")

validBones = pm.ls(boneNames, type=["transform", "joint"]) or []
if not validBones:
    error("No valid bones were found in the bones list.")

targets = pm.listRelatives(root, allDescendents=True, type=["transform", "joint"]) or []
targets.append(root)

targetPositions = {
    target: pm.xform(target, query=True, worldSpace=True, rotatePivot=True)
    for target in targets
}

constrained = []
for bone in validBones:
    if pm.listConnections(bone, source=True, destination=False, type="constraint"):
        warning("Skipping '{0}': already constrained.".format(bone.nodeName()))
        continue

    validTargets = [target for target in targets if target != bone]
    if not validTargets:
        warning("Skipping '{0}': no other target is available.".format(bone.nodeName()))
        continue

    position = pm.xform(bone, query=True, worldSpace=True, rotatePivot=True)
    closest = min(
        validTargets,
        key=lambda target: sum(
            (a - b) ** 2 for a, b in zip(position, targetPositions[target])
        ),
    )
    distanceSquared = sum(
        (a - b) ** 2 for a, b in zip(position, targetPositions[closest])
    )

    if maxDistance > 0 and distanceSquared > maxDistance ** 2:
        warning("Skipping '{0}': closest target '{1}' is too far ({2:.3f} > {3}).".format(
            bone.nodeName(), closest.nodeName(), math.sqrt(distanceSquared), maxDistance))
        continue

    skipTranslate = [axis for axis in "xyz" if bone.attr("t" + axis).isLocked()]
    skipRotate = [axis for axis in "xyz" if bone.attr("r" + axis).isLocked()]
    if len(skipTranslate) == 3 and len(skipRotate) == 3:
        warning("Skipping '{0}': all translate and rotate axes are locked.".format(
            bone.nodeName()))
        continue

    pm.parentConstraint(
        closest, bone, maintainOffset=True,
        skipTranslate=skipTranslate, skipRotate=skipRotate,
    )
    constrained.append(bone.name())
    print("Constrained '{0}' to '{1}' (distance: {2:.3f})".format(
        bone.nodeName(), closest.nodeName(), math.sqrt(distanceSquared)))
]]></run>
<doc><![CDATA[## Summary
Constrains each bone to the closest transform or joint under a target hierarchy root. Bones with an incoming constraint are skipped, and locked translate or rotate axes are excluded from the parent constraint.

## Inputs
- **`bones`**: Source transforms or joints. Use the listBox selection control to add them.
- **`rootJoint`**: Root of the target hierarchy. Use **Set selected** to capture one selected transform or joint.
- **`maxDistance`**: Maximum allowed distance to a target. Set to `0` for no limit.

## Outputs
- Creates parent constraints on the eligible bones. No output attribute is produced.

## Usage
1. Add bones to `bones` and set `rootJoint`.
2. Optionally set `maxDistance` to skip distant targets.
3. Run the module and inspect the created constraints before saving the Maya scene.]]></doc>
<attributes>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["pCube1"], "default": "items"}]]></attr>
<attr name="rootJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "joint1", "placeholder": "Target hierarchy root", "buttonCommand": "import pymel.core as pm\nselection = pm.ls(sl=True, type=[\"transform\", \"joint\"])\nif selection:\n    value = selection[0].name()", "buttonLabel": "Set selected", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="maxDistance" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0, "placeholder": "0 = no limit", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100000, "validator": 2, "default": "value"}]]></attr>
</attributes>
</module>
