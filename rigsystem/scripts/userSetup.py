import maya.cmds as cmds

from rigsystem.startup import startup

if not cmds.about(batch=True):
    startup()
