<module name="setTexPathWithSceneEnv" type="" muted="0" uid="b2cb41b3508b4d0f84d20c9418db2f6d">
<run><![CDATA[import pymel.core as pm
import os

def n_dirname(path, n=0):
    parent = os.path.dirname(path)
    return parent if n <= 0 else n_dirname(parent, n-1)
    
def createSceneEnvVar(sceneEnvVar, depth=0): # 0-current asset folder, 1-parent folder, etc
    if pm.objExists(sceneEnvVar):
        pm.warning("'{}' already exists".format(sceneEnvVar))
        return
    
    currentFile = pm.api.MFileIO.currentFile()
    if currentFile.endswith("untitled"):
        warning("Save scene first")        
        return
        
    code = '''
import maya.cmds as cmds
import maya.OpenMaya as om

def n_dirname(path, n=0):
    dirname = lambda path: "/".join(path.split("/")[:-1])                  
    parent = dirname(path)
    return parent if n <= 0 else n_dirname(parent, n-1)
    
secretNode = cmds.ls("$VAR", r=True)
if secretNode:
    if cmds.referenceQuery(secretNode, isNodeReferenced=True):         
        refNode = cmds.referenceQuery(secretNode, rfn=True)
        refPath = cmds.referenceQuery(refNode, f=True)
    else:
        refPath = om.MFileIO.currentFile()
               
    path = n_dirname(refPath.replace("\\\\", "/"), $DEPTH)
    os.environ["$VAR"] = path
    print("Set $VAR to '{}'".format(path))'''.replace("$VAR", sceneEnvVar).replace("$DEPTH", str(depth))
       
    pm.scriptNode(st=1, bs=code, n="sceneEnv_scriptNode", stp="python")        
    pm.createNode("transform", n=sceneEnvVar) #  make secret node
    exec(code) # setup env
        
    # change file textures path_script
    sceneRoot = os.path.normpath(n_dirname(pm.api.MFileIO.currentFile(), depth))
    for n in pm.ls(type="file"):
         txPath = os.path.normpath(n.fileTextureName.get())
         if txPath.startswith(sceneRoot):
            txPath = txPath.replace(sceneRoot, "$"+sceneEnvVar)
            n.fileTextureName.set(txPath)
            print("{} => {}".format(n, txPath))

createSceneEnvVar(@sceneEnvPath, @depth) # depth=0-current asset folder, 1-parent folder, etc
        ]]></run>
<doc><![CDATA[## Summary
Creates an environment variable that points to a directory relative to the current Maya scene file and rewrites all file texture nodes to use that variable, enabling portable texture references across different project setups.

## Inputs
- **`sceneEnvPath`** – Name of the environment variable to create (e.g., `emma_path`).  
- **`depth`** – Integer indicating how many directory levels to ascend from the current scene file to determine the base path (0 = scene folder, 1 = parent folder, etc.).  
- **Current Maya scene file** – Must be saved; the module uses the file’s location to compute the path.

## Outputs
- **Environment variable** – Set in the operating system (`$sceneEnvPath`) to the computed directory.  
- **Script node** – A hidden `sceneEnv_scriptNode` that re‑establishes the environment variable each time the scene is opened.  
- **Transform node** – A dummy node named after the environment variable, used as a reference point.  
- **Updated file texture nodes** – All `file` nodes whose texture paths start with the scene root are rewritten to use the new environment variable (e.g., `fileTextureName` becomes `$sceneEnvPath/relative/path`).  
- **Console output** – Prints the new environment variable value and the texture path changes.

## Usage
1. **Save the scene** – The module requires a saved Maya file; otherwise it will abort with a warning.  
2. **Set parameters** – In the module’s UI, enter the desired environment variable name (`sceneEnvPath`) and the directory depth (`depth`).  
3. **Execute** – Run the module. It will create the environment variable, add the script node and dummy transform, and rewrite all applicable file texture paths.  
4. **Verify** – Check the Environment Variables panel or the console to confirm the new variable, and inspect any `file` nodes to ensure their paths now reference `$sceneEnvPath`.  
5. **Reopen the scene** – The script node will automatically restore the environment variable on scene load, keeping texture references functional.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Create an environment variable for the current scene.<br>\n<b>depth</b>: 0 - scene's directory, 1 - parent, etc."}]]></attr>
<attr name="sceneEnvPath" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "emma_path", "min": ""}]]></attr>
<attr name="depth" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "3", "validator": 1, "value": 0, "min": "0"}]]></attr>
</attributes>
<children>
</children>
</module>