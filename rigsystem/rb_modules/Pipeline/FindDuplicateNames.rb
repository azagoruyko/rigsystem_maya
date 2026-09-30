<module name="findDuplicateNames" muted="0" uid="6408d318d1d345e3950dd96011986644">
<run><![CDATA[import maya.cmds as cmds

nodesByName = {}
for node in cmds.ls(long=True) or []:
    name = node.rsplit("|", 1)[-1]
    nodesByName.setdefault(name, []).append(node)

for name, nodes in sorted(nodesByName.items()):
    if len(nodes) > 1:
        warning("Duplicate name '{}'".format(name))
]]></run>
<doc><![CDATA[## Summary
This module scans the current Maya scene for duplicate node names and logs a warning for each name that appears more than once. It serves as a quick integrity check to help prevent naming conflicts before building rigs or other scene elements.

## Inputs
- **None** – The module operates on the entire scene without requiring any user-specified parameters.

## Outputs
- **Warnings** – For each duplicated short name, a warning message is emitted using the `warning()` API. No new nodes or data structures are created.

## Usage
1. Load the module into Rig Builder and execute it.  
2. Review the output log for any warning messages indicating duplicate names.  
3. Resolve the duplicates in Maya (e.g., rename or delete redundant nodes) before proceeding with rig construction or other automated processes.]]></doc>
</module>