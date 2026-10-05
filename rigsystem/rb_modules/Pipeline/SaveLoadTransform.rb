<module name="SaveLoadTransform" muted="0" uid="8fb4d6c44f1f4743a962a6385fadb21c">
<run><![CDATA[import pymel.core as pm
import json
import os

if @mode==0: # save transformation
    data = {n: pm.xform(n, q=True, ws=True, m=True)
            for n in @objects}
    
    with open(os.path.expandvars(@file), "w") as f:
        json.dump(data, f)    
    
else: # load transformation
    with open(os.path.expandvars(@file), "r") as f:
        data = json.load(f)
        
    existingNodes = [pm.PyNode(k) for k in data.keys() if pm.objExists(k)]
    existingNodes = sorted(existingNodes, key=lambda x: len(x.getAllParents()))
        
    for n in existingNodes:
        k = n.name()
        
        if not @loadAllObjects and k not in @objects:
            continue
            
        s = n.s.get()
        pm.xform(n, ws=True, m=data[k])
            
        if @keepScale and n.s.isSettable():
            n.s.set(s)
                
        print(n)
]]></run>
<doc><![CDATA[## Summary
This module records or restores the world‑space transformation matrices of a set of scene objects. In **Save** mode it writes the matrices to a JSON file; in **Load** mode it reads the file and applies the stored transforms back to the objects, optionally preserving their original scale.

## Inputs
- **`mode`** (`int`):  
  - `0` – Save current transforms to the file.  
  - `1` – Load transforms from the file and apply them.
- **`objects`** (`list[str]`): Names of the objects whose transforms will be saved or restored.
- **`file`** (`str`): File path (may contain environment variables) where the JSON data is written or read.
- **`loadAllObjects`** (`bool`): When loading, if `False` only objects listed in `objects` are updated; if `True` all objects present in the file are processed.
- **`keepScale`** (`bool`): When loading, if `True` the original scale of each object is preserved after applying the new matrix.

## Outputs
None. The module writes to or reads from a file and prints the names of the processed nodes to the console.

## Usage
1. **Set the mode**:  
   - `mode = 0` to capture the current transforms.  
   - `mode = 1` to restore transforms from a file.
2. **Define the target objects** in the `objects` list (e.g., `["root", "spine1", "spine2"]`).
3. **Specify the file path** in `file` (use `$HOME` or other env vars if needed).
4. **Optional flags**:  
   - `loadAllObjects = True` to update every object stored in the file.  
   - `keepScale = True` to keep each object's original scale after loading.
5. **Execute the module**.  
   - In **Save** mode it will create/overwrite the JSON file with the current world‑space matrices.  
   - In **Load** mode it will read the file, apply the matrices, and print each processed node name.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Save", "Load"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="objects" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
<attr name="file" template="fileSelector" category="General" connect=""><![CDATA[{"value": "$TEMP\\saveLoadTranforms", "mode": "saveFile", "filter": "JSON Files (*.json)", "title": "Select JSON file", "default": "value"}]]></attr>
<attr name="loadAllObjects" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="keepScale" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
</attributes>
</module>