<module name="transferConnections" type="Tools/TransferConnections" muted="0" uid="af899998ea1544a8a63825cbd28d84e9">
<run><![CDATA[import pymel.core as pm
import json

def transferConnections(src, dest, inputs=True, outputs=True):
    src = pm.PyNode(src)
    dest = pm.PyNode(dest)
    
    if inputs:
        for aDest, aSrc in src.inputs(p=True, c=True):
            newDest = dest + "." + aDest.longName()
            
            if pm.objExists(newDest):
                if aDest.longName() == "inverseScale" and aSrc.longName() == "scale":
                    continue
                    
                print("Connect '%s' to '%s'"%(aSrc, newDest))            
                pm.connectAttr(aSrc, newDest, f=True)
                pm.disconnectAttr(aSrc, aDest)
            else:
                pm.warning("transferConnections: cannot find destination "+newDest)  
    
    if outputs:            
        for aSrc, aDest in src.outputs(p=True, c=True):
            newSrc = dest + "." + aSrc.longName()
    
            if pm.objExists(newSrc):
                if aDest.longName() == "inverseScale" and aSrc.longName() == "scale":
                    continue
                
                print("Connect '%s' to '%s'"%(dest+"."+aSrc.longName(), aDest))
                try:
                    pm.connectAttr(newSrc, aDest, f=True)
                except:
                    pm.warning("transferConnections: cannot connect '%s' to '%s'"%(newSrc, aDest))                
            else:
                pm.warning("transferConnections: cannot find source "+newSrc) 

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