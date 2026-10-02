<module name="MoveSkinToParentBones" muted="0" uid="1c376ace7e984f1dbaf52699eb92e551">
<run><![CDATA[from collections import defaultdict
import pymel.core as pm
import rig_utils.skinCluster as skin

selection = pm.ls(@joints, type="joint")
if not selection:
    warning("No joints provided in the joints input.")
    exit()

sortedJoints = sorted(selection, key=lambda joint: len(joint.getAllParents()), reverse=True)

skinClusterMap = defaultdict(list)
for joint in sortedJoints:
    parent = joint.getParent()
    if not parent or not isinstance(parent, pm.nodetypes.Joint):
        warning("Joint '{0}' has no joint parent. Skipping...".format(joint.name()))
        continue

    skinClusters = list(set(joint.listConnections(type="skinCluster")))
    for sk in skinClusters:
        skinClusterMap[sk.name()].append(joint)

if not skinClusterMap:
    pm.displayInfo("No skin clusters found for the provided joints.")
    exit()

for skName, joints in skinClusterMap.items():
    skHelper = skin.SkinClusterHelper(skName)
    currentInfluences = set(skHelper.getInfluences())

    missingParents = []
    for joint in joints:
        parent = joint.getParent()
        if parent.name() not in currentInfluences:
            missingParents.append(parent)

    missingParents = list(set(missingParents))
    if missingParents:
        pm.displayInfo("Adding missing parents to '{0}': {1}".format(
            skName, [parent.name() for parent in missingParents]))
        pm.skinCluster(skName, e=True, ai=missingParents, lw=True, wt=0)
        skHelper = skin.SkinClusterHelper(skName)

    weights = skHelper.getSkinWeights()
    jointsToRemove = []

    for joint in joints:
        parent = joint.getParent()
        childIdx = skHelper.getInfluencePhysicalIndex(joint.name())
        parentIdx = skHelper.getInfluencePhysicalIndex(parent.name())

        if childIdx is not None and parentIdx is not None:
            weights.mergeInfluences(childIdx, parentIdx)
            jointsToRemove.append(joint)
        else:
            warning("Could not find index for '{0}' or '{1}' in '{2}'".format(
                joint.name(), parent.name(), skName))

    skHelper.setSkinWeights(weights)

    if jointsToRemove:
        pm.skinCluster(skName, e=True, ri=jointsToRemove)

pm.displayInfo("Moved skin weights from {0} joints across {1} skin clusters.".format(
    len(sortedJoints), len(skinClusterMap)))]]></run>
<doc><![CDATA[## Summary
Moves skin weights from the specified joints to their joint parents, then removes the processed joints as skin cluster influences. Processes deeper joints first so selected chains propagate weights toward their roots.

## Inputs
- **`joints`**: List of source joint names. Add joint names to the list, or connect a joint list from another module.

## Outputs
- Updates the affected skin clusters in the Maya scene. No output attribute is produced.

## Usage
1. Add the source joint names to `joints`, or connect a joint list to it.
2. Run the module. Each source joint needs a joint parent; joints without one are skipped.
3. Inspect the affected skin clusters and save the Maya scene when the result is correct.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"text": "CAUTION: It's not undoable!", "default": "text"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["joint2"], "default": "items"}]]></attr>
</attributes>
</module>