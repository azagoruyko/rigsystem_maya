import os
import sys
import maya.cmds as cmds

print("*** rigsystem initialization ***")

modulePath = cmds.getModulePath(moduleName="rigsystem")
mayaVersion = cmds.about(majorVersion=True)  # 2026 or others
platformPath = os.path.normpath(os.path.join(modulePath, "platforms", str(mayaVersion), "win64"))

# Required to redirect standard scripts (like dagMenuProc.mel) to ours
scriptsPath = os.path.normpath(os.path.join(platformPath, "scripts"))
if os.path.isdir(scriptsPath):
    currScriptPath = os.environ.get("MAYA_SCRIPT_PATH", "")
    existingPaths = [p for p in currScriptPath.split(os.pathsep) if p]
    existingPaths = [
        p for p in existingPaths
        if os.path.normcase(os.path.normpath(p)) != os.path.normcase(scriptsPath)
    ]
    os.environ["MAYA_SCRIPT_PATH"] = os.pathsep.join([scriptsPath, *existingPaths])

# Load all plug-ins
pluginsPath = os.path.normpath(os.path.join(platformPath, "plug-ins"))
if os.path.isdir(pluginsPath):
    for f in os.listdir(pluginsPath):
        if f.endswith(".mll") or f.endswith(".py"):
            pluginName = os.path.splitext(f)[0] if f.endswith(".py") else f
            if not cmds.pluginInfo(pluginName, q=True, loaded=True):
                try:
                    if cmds.loadPlugin(f):
                        print(f + " is loaded")
                except Exception as e:
                    print(f"[WARNING] Failed to load plugin {f}: {e}")

print("*** Done ***")



