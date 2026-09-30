<module name="SelectUnusedNodes" muted="0" uid="ab761cd64d194e00a36920a9780abbdc">
<run><![CDATA[import pymel.core as pm

if not @noInputs and not @noOutputs:
    error("noInputs or noOutputs must be specified")

nodes = set()
for n in pm.ls(type=@type or None):
    if pm.objectType(n) in @skipTypes:
        continue
        
    if isinstance(n, pm.nt.Transform) or isinstance(n, pm.nt.Shape):
        continue
    
    if n.isDefaultNode():
        continue                        
        
    if (@noOutputs and not n.outputs()) or (@noInputs and not n.inputs()):
        nodes.add(n)
        
pm.select(nodes)]]></run>
<doc><![CDATA[## Summary
Selects nodes in the Maya scene that are either input‑only or output‑only, optionally filtered by node type and excluded types. The module ensures that at least one of the `noInputs` or `noOutputs` flags is set before performing the selection.

## Inputs
- **`noInputs`** (`bool`): When `True`, the module will include nodes that have no incoming connections.
- **`noOutputs`** (`bool`): When `True`, the module will include nodes that have no outgoing connections.
- **`type`** (`str`, optional): Node type to filter the search (e.g., `"transform"`, `"mesh"`). If omitted, all node types are considered.
- **`skipTypes`** (`list` of `str`, optional): Node types that should be excluded from the search (e.g., `["joint", "camera"]`).

## Outputs
- The module selects the nodes that satisfy the chosen criteria in the Maya scene. No explicit output attribute is created; the selection can be used by subsequent modules or scripts.

## Usage
1. **Configure Flags**: Set either `noInputs` **or** `noOutputs` to `True`. Setting both or neither will trigger an error.
2. **Optional Filters**: Specify a `type` to limit the search to a particular node type, and/or provide a list of `skipTypes` to exclude unwanted types.
3. **Run the Module**: Execute the module. It will gather all nodes that match the criteria and place them in the current selection.
4. **Proceed**: Use the resulting selection for further processing, such as creating constraints, assigning attributes, or feeding into downstream rigging modules.]]></doc>
<attributes>
<attr name="type" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "groupId", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="noInputs" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="noOutputs" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="skipTypes" template="listBox" category="General" connect=""><![CDATA[{"items": ["objectSet"], "default": "items"}]]></attr>
</attributes>
</module>