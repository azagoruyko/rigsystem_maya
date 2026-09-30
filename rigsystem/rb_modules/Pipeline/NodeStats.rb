<module name="nodeStats" muted="0" uid="ce87f404c0724cf595b6a885f1099f00">
<run><![CDATA[import pymel.core as pm

types = {}
total = 0
for n in pm.ls():
    if n.type() not in types:
        types[n.type()] = 0
    
    types[n.type()] += 1
    total += 1    

for k in sorted(types, key=lambda k: types[k]):
    print(f"{k}: {types[k]}")
print(f"Total nodes: {total}")]]></run>
<doc><![CDATA[## Summary
Counts and reports the number of nodes of each type present in the current Maya scene, displaying the results in the script editor or console.

## Inputs
- **None** – The script automatically queries all nodes in the current Maya scene using `pm.ls()`.

## Outputs
- **Console/Script Editor Output** – A list of node types and their respective counts, followed by the total number of nodes. Example:
  ```
  transform: 120
  mesh: 45
  camera: 3
  ...
  Total nodes: 168
  ```

## Usage
1. Open Maya and load the scene you wish to analyze.  
2. Open the Script Editor, create a new Python tab, and paste the module code.  
3. Execute the script (Ctrl+Enter or the “Execute” button).  
4. Review the printed output in the Script Editor or Python console to see the node type distribution.  
5. Optionally, redirect the output to a file or use the counts for further scripting or validation tasks.]]></doc>
</module>