<module name="transferConnections" type="Tools/TransferConnections" muted="0" uid="af899998ea1544a8a63825cbd28d84e9">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds


def connectionPairs(node, source, destination):
    connections = cmds.listConnections(node, source=source, destination=destination, plugs=True, connections=True) or []
    return zip(connections[::2], connections[1::2])


def attrName(plug):
    return plug.partition(".")[2]

def transferConnections(src, dest, inputs=True, outputs=True):
    src = str(proxy.plug(src)) if "." in str(src) else str(proxy.node(src))
    dest = str(proxy.node(dest))
    
    if inputs:
        for aDest, aSrc in connectionPairs(src, True, False):
            newDest = f"{dest}.{attrName(aDest)}"
            
            if cmds.objExists(newDest):
                if attrName(aDest) == "inverseScale" and attrName(aSrc) == "scale":
                    continue
                    
                print(f"Connect '{aSrc}' to '{newDest}'")
                cmds.connectAttr(aSrc, newDest, force=True)
                cmds.disconnectAttr(aSrc, aDest)
            else:
                cmds.warning(f"transferConnections: cannot find destination {newDest}")
    
    if outputs:            
        for aSrc, aDest in connectionPairs(src, False, True):
            newSrc = f"{dest}.{attrName(aSrc)}"
    
            if cmds.objExists(newSrc):
                if attrName(aDest) == "inverseScale" and attrName(aSrc) == "scale":
                    continue
                
                print(f"Connect '{newSrc}' to '{aDest}'")
                try:
                    cmds.connectAttr(newSrc, aDest, force=True)
                except RuntimeError:
                    cmds.warning(f"transferConnections: cannot connect '{newSrc}' to '{aDest}'")
            else:
                cmds.warning(f"transferConnections: cannot find source {newSrc}")

transferConnections(@src, @dest, @inputs, @outputs)
        ]]></run>
<doc><![CDATA[## Summary
Transfers input and output connections from a source node to a target node, optionally preserving or discarding each side of the connection. It is useful for swapping drivers, refactoring utility networks, or re‑routing connections in complex rigs.

## Inputs
- **`src`** – The source node whose connections will be moved (e.g., a control or utility node).  
- **`dest`** – The destination node that will receive the connections.  
- **`inputs`** – Boolean flag (default `True`) that determines whether incoming connections to `src` are transferred to `dest`.  
- **`outputs`** – Boolean flag (default `True`) that determines whether outgoing connections from `src` are transferred to `dest`.

## Outputs
- The module does not create new nodes; it only re‑establishes existing connections.  
- After execution, `dest` will have the same input and/or output connections that `src` previously had, while `src` will have those connections removed (unless the destination attribute already exists, in which case the connection is skipped).

## Usage
1. **Select Nodes** – In the UI, set `src` to the node you want to move connections from and `dest` to the node that should receive them.  
2. **Toggle Flags** – Check or uncheck `inputs` and `outputs` to control which side of the connection is transferred.  
3. **Run** – Execute the module. It will print each connection it re‑establishes and warn if a target attribute cannot be found.  
4. **Verify** – Inspect the destination node’s connections to confirm the transfer.  
5. **Special Cases** – The script skips re‑connecting the `inverseScale` attribute when the source is `scale` to avoid common rigging pitfalls.]]></doc>
<attributes>
<attr name="src" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_jaw_control.sticky"}]]></attr>
<attr name="dest" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_jaw_control_new"}]]></attr>
<attr name="inputs" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="outputs" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
</attributes>
<children>
</children>
</module>
