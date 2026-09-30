<module name="changeTexturePath" type="Tools/ChangeTexturePath" muted="0" uid="459062f123f343adb2d73d0a5787865d">
<run><![CDATA[import pymel.core as pm
import re
import os

for node in pm.ls(type="file"):
    fileName = os.path.realpath(os.path.expandvars(node.fileTextureName.get()))
    
    newFileName = fileName
    for var in [u"MYTONA_PATH", u"TMO_PATH"]:
        if os.environ.get(var):
            envPath = os.path.realpath(os.path.expandvars("$"+var))
            if fileName.startswith(envPath):
                newFileName = fileName.replace(envPath, "$"+var)       
    
    if fileName != newFileName:
        print(node + " => " + newFileName)
        node.fileTextureName.set(newFileName)
]]></run>
<doc><![CDATA[## Summary
Updates the file paths of all `file` nodes in the current Maya scene to use environment variable placeholders (`$MYTONA_PATH` or `$TMO_PATH`) when the original path matches the corresponding project directory. This tool is useful for re‑pathing textures after a project folder migration or when standardizing texture locations across multiple scenes.

## Inputs
- **Environment Variables**  
  - `MYTONA_PATH`: Base directory for the primary project textures.  
  - `TMO_PATH`: Alternative base directory for texture assets.  
  The script reads these variables to determine which paths should be replaced.

## Outputs
- **Modified `file` Nodes**  
  The `fileTextureName` attribute of each `file` node whose path starts with one of the specified environment directories is updated to use the `$VAR` placeholder instead of the absolute path. No new nodes or data containers are created.

## Usage
1. Ensure the environment variables `MYTONA_PATH` and/or `TMO_PATH` are set to the correct project directories.  
2. Run the module in Maya.  
3. The console will list each `file` node that was updated, showing the old and new paths.  
4. Verify that the updated paths correctly reference the intended texture locations.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Change texture path to use MYTONA_PATH."}]]></attr>
</attributes>
<children>
</children>
</module>