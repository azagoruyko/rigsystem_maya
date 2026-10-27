import logging
import os

import maya.cmds as cmds
import maya.utils


logger = logging.getLogger(__name__)


def loadPlugins(pluginsPath):
    """Load the available plug-ins for the active Maya platform."""
    for f in os.listdir(pluginsPath):
        if f.endswith(".mll") or f.endswith(".py"):
            pluginName = os.path.splitext(f)[0] if f.endswith(".py") else f
            if not cmds.pluginInfo(pluginName, q=True, loaded=True):
                try:
                    if cmds.loadPlugin(f):
                        logger.info("%s is loaded", f)
                except Exception as e:
                    logger.warning("Failed to load plugin %s: %s", f, e)


def installViewportMenu():
    """Install the viewport menu after Maya has created its UI."""
    from .anim_utils.viewportMenu import installViewportMenu as install

    install()


def startup():
    """Load RigSystem's plug-ins and install its viewport menu."""
    logger.info("*** rigsystem initialization ***")

    modulePath = cmds.getModulePath(moduleName="rigsystem")
    mayaVersion = cmds.about(majorVersion=True)  # 2026 or others
    platformPath = os.path.normpath(os.path.join(modulePath, "platforms", str(mayaVersion), "win64"))
    pluginsPath = os.path.normpath(os.path.join(platformPath, "plug-ins"))

    if os.path.isdir(pluginsPath):
        loadPlugins(pluginsPath)

    maya.utils.executeDeferred(installViewportMenu)

    logger.info("*** Done ***")
