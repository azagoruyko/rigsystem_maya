<module name="SaveLoadTransform" muted="0" uid="8fb4d6c44f1f4743a962a6385fadb21c">
<run><![CDATA[import pymel.core as pm
import json

if @mode==0: # save transformation
    data = {}
    for n in @objects:
        n = pm.PyNode(n)
        k = n.name()
        data[k] = {}
        data[k]["t"] = list(n.t.get())
        data[k]["r"] = list(n.r.get())
        data[k]["s"] = list(n.s.get())
    
    with open(@file, "w") as f:
        json.dump(data, f)    
    
else: # load transformation
    with open(@file, "r") as f:
        data = json.load(f)
        
    for k in data:
        if not @loadAllObjects and k not in @objects:
            continue
            
        if pm.objExists(k):
            j = pm.PyNode(k)
            if j.t.isSettable():j.t.set(data[k]["t"])
            if j.r.isSettable():j.r.set(data[k]["r"])
            if j.s.isSettable():j.s.set(data[k]["s"])
            print(j)
        else:
            pm.warning("Cannot find "+k)
]]></run>
<doc><![CDATA[## Summary  
The **saveLoadTransform** tool captures the translation, rotation, and scale of selected rig controls and writes them to a JSON file, or restores those attributes from a JSON file back onto the controls. It is useful for saving neutral poses, transferring presets between assets, or re‑applying control transforms after a rebuild.

## Inputs  
- **`mode`** (`radioButton`):  
  - `0` – **Save**: write the current transforms of the selected objects to the file.  
  - `1` – **Load**: read transforms from the file and apply them to the objects.  
- **`objects`** (`listBox`): list of control names (or any transform nodes) whose transforms will be saved or loaded.  
- **`file`** (`fileSelector`): path to the JSON file used for saving or loading. The button opens a save dialog by default; right-click it to switch to `openFile` when loading.  
- **`loadAllObjects`** (`checkBox`): when unchecked, only the objects listed in **`objects`** are updated during a load; when checked, all objects present in the JSON file are applied regardless of the list.

## Outputs  
- **JSON file** at the path specified by **`file`** containing a dictionary of node names mapped to their `t`, `r`, and `s` values.  
- On load, the tool sets the `t`, `r`, and `s` attributes of each node (if settable) and prints the node name to the console.  
- No additional rig nodes or attributes are created; the tool purely reads/writes transform data.

## Usage  
1. **Select the controls** you want to preserve in the **`objects`** list.  
2. **Choose a file** path via the button or type it manually.  
3. Set **`mode`** to **Save** and click **Run** to write the current transforms to the JSON file.  
4. To restore a pose, set **`mode`** to **Load**.  
   - If you only want to update the controls listed in **`objects`**, leave **`loadAllObjects`** unchecked.  
   - If you want to apply all transforms stored in the file, check **`loadAllObjects`**.  
5. Click **Run**; the tool will apply the stored transforms and print each updated node to the console.  

This tool is ideal for capturing neutral poses, creating pose presets, or re‑applying control transforms after a rig rebuild.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 0, "items": ["Save", "Load"], "default": "current"}]]></attr>
<attr name="objects" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": []}]]></attr>
<attr name="file" template="fileSelector" category="General" connect=""><![CDATA[{"value": "C:\\Users\\kashaed\\AppData\\Local\\Temp\\saveLoadTranforms", "unresolvedValue": "$TEMP\\saveLoadTranforms", "mode": "saveFile", "filter": "JSON Files (*.json)", "title": "Select JSON file", "default": "value"}]]></attr>
<attr name="loadAllObjects" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
</attributes>
</module>