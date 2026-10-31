<module name="MoveSkinToParentBones" muted="0" uid="1c376ace7e984f1dbaf52699eb92e551">
<run><![CDATA[from collections import defaultdict
from rigsystem import proxy
from rigsystem.rig_utils import skinCluster as skin

cmds = proxy.cmds
selection = proxy.nodes(cmds.ls(@joints, type="joint") or [])
if not selection:
    warning("No joints provided in the joints input.")
    exit()

sortedJoints = sorted(selection, key=lambda joint: len(joint.getAllParents()), reverse=True)

skinClusterMap = defaultdict(list)
for joint in sortedJoints:
    parent = joint.getParent()
    if not parent or parent.type() != "joint":
        warning(f"Joint '{joint}' has no joint parent. Skipping...")
        continue

    skinClusters = set(joint.listConnections(type="skinCluster"))
    for sk in skinClusters:
        skinClusterMap[str(sk)].append(joint)

if not skinClusterMap:
    print("No skin clusters found for the provided joints.")
    exit()

for skName, joints in skinClusterMap.items():
    skHelper = skin.SkinClusterHelper(skName)
    currentInfluences = set(proxy.nodes(skHelper.getInfluences()))

    missingParents = []
    for joint in joints:
        parent = joint.getParent()
        if parent not in currentInfluences:
            missingParents.append(parent)

    missingParents = list(set(missingParents))
    if missingParents:
        print(f"Adding missing parents to '{skName}': {[str(parent) for parent in missingParents]}")
        cmds.skinCluster(skName, edit=True, addInfluence=[str(parent) for parent in missingParents], lockWeights=True, weight=0)
        skHelper = skin.SkinClusterHelper(skName)

    weights = skHelper.getSkinWeights()
    jointsToRemove = []

    for joint in joints:
        parent = joint.getParent()
        childIdx = skHelper.getInfluencePhysicalIndex(joint)
        parentIdx = skHelper.getInfluencePhysicalIndex(parent)

        if childIdx is not None and parentIdx is not None:
            weights.mergeInfluences(childIdx, parentIdx)
            jointsToRemove.append(joint)
        else:
            warning(f"Could not find index for '{joint}' or '{parent}' in '{skName}'")

    skHelper.setSkinWeights(weights)

    if jointsToRemove:
        cmds.skinCluster(skName, edit=True, removeInfluence=[str(joint) for joint in jointsToRemove])

print(f"Moved skin weights from {len(sortedJoints)} joints across {len(skinClusterMap)} skin clusters.")]]></run>
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
