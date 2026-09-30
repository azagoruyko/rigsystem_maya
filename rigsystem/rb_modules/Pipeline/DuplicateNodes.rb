<module name="duplicateNodes" muted="0" uid="76285d99838a4e2081ca89081a4ad5fc">
<run><![CDATA[import pymel.core as pm

newNodes = pm.duplicate(@nodes, rc=True, ro=True)
out = []
for i, n in enumerate(newNodes):
    n.rename(@pattern.format(i=i, type=pm.objectType(n)), old=n)
    out.append(n.name())
    
@set_out_nodes(out)    ]]></run>
<doc><![CDATA[## Summary  
Duplicates a list of scene nodes, renames each duplicate using a user‑supplied format string that can include the duplicate index and the node type, and returns the names of the newly created nodes.

## Inputs  
- **`nodes`** (`@nodes`): A list of PyMEL node objects (or names) that should be duplicated.  
- **`pattern`** (`@pattern`): A Python format string that may contain the placeholders `{i}` (the duplicate index) and `{type}` (the Maya type of the node, e.g., `transform`, `mesh`). This string is used to rename each duplicated node.

## Outputs  
- **`out_nodes`** (`@set_out_nodes(out)`): A list of strings containing the names of all duplicated nodes after they have been renamed.

## Usage  
1. **Provide the source nodes** – select or list the nodes you want to duplicate and assign them to the `nodes` attribute.  
2. **Define a naming pattern** – set the `pattern` attribute to a format string such as `"dup_{i}_{type}"` or `"copy_{i}"`.  
3. **Execute the module** – run the module; it will duplicate each node, rename it according to the pattern, and output the new names in `out_nodes`.  
4. **Connect the output** – use the `out_nodes` list to feed downstream modules or scripts that need references to the duplicated geometry or transforms.]]></doc>
<attributes>
<attr name="pattern" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_lip_upper_{i}_{type}", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="nodes" template="listBox" category="General" connect=""><![CDATA[{"items": ["M_lips_upper_0_joint", "M_lips_upper_1_joint", "M_lips_upper_2_joint", "M_lips_upper_3_joint", "M_lips_upper_4_joint", "M_lips_upper_5_joint", "M_lips_upper_6_joint", "M_lips_upper_7_joint", "M_lips_upper_8_joint", "M_lips_upper_9_joint", "M_lips_upper_10_joint"], "default": "items"}]]></attr>
<attr name="out_nodes" template="listBox" category="Output" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
</attributes>
</module>