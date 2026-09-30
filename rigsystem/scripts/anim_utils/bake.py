import json

import maya.mel as mel
import pymel.core as pm

from rig_utils.general import makeSurfaceTransform
from rig_utils.moduleInfo import getModuleInfo


def getFrameRange():
    """Return (startFrame, endFrame) from timeline slider, or None if range is invalid."""
    mayaPlayBackSlider = mel.eval('$tmpVar=$gPlayBackSlider')
    startFrame, endFrame = pm.timeControl(mayaPlayBackSlider, q=True, ra=True)
    if endFrame - startFrame <= 1:
        return None
    return (startFrame, endFrame)


def getSpineControls(moduleInfo, prefix):
    """Return list of spine controls for the given prefix from module info."""
    controls = []
    idx = 1
    while moduleInfo.hasAttr(prefix + str(idx)):
        controls.append(moduleInfo.getAttr(prefix + str(idx)).node())
        idx += 1
    return controls


def spine_bakeFKtoIK(object, startFrame=None, endFrame=None):
    """Bake spine animation from FK to IK over the given or selected timeline range."""
    if startFrame is None or endFrame is None:
        result = getFrameRange()
        if result is None:
            pm.warning("spine_bakeFKtoIK: range must be selected on timeline to bake")
            return
        startFrame, endFrame = result

    moduleInfo = getModuleInfo(object)
    if not moduleInfo:
        return

    fixSurface = moduleInfo.getAttr("fix_surface").node()
    params = json.loads(moduleInfo.getAttr("params"))
    ikParams = [param for _, param in params["ik"]]

    fkControls = getSpineControls(moduleInfo, "fk")
    fkControls.append(moduleInfo.getAttr("hip").node())

    ikControls = getSpineControls(moduleInfo, "ik")

    tmpMatrices = {} # per object each frame

    # save IK controls world matrices
    for f in range(int(startFrame), int(endFrame)+1):
        pm.currentTime(f)

        for i, ctrl in enumerate(ikControls):
            if ctrl.name() not in tmpMatrices:
                tmpMatrices[ctrl.name()] = {}

            m = pm.xform(ctrl, q=True, ws=True, m=True)

            if i == len(ikControls)-1:
                fixt = makeSurfaceTransform(ctrl+"_fix_surface_tmp", fixSurface, ikParams[i], 0.5)
                endt = makeSurfaceTransform(ctrl+"_fix_surface_tmp", fixSurface, 0.99, 0.5)
                q = fixt.getRotation().asQuaternion().inverse() * endt.getRotation().asQuaternion()
                pm.delete([fixt, endt])
                
                trm = pm.dt.TransformationMatrix(m)
                trm.rotateBy(q, "world")
                m = trm.asMatrix()

            tmpMatrices[ctrl.name()][f] = m

    # set ik animation
    for f in range(int(startFrame), int(endFrame)+1):
        pm.currentTime(f)

        # reset fk controls animation
        for ctrl in fkControls:
            for a in ["tx", "ty", "tz", "rx", "ry", "rz"]:
                if ctrl.attr(a).isSettable():
                    ctrl.attr(a).set(0)
                    pm.setKeyframe(ctrl.attr(a))

        for ctrl in ikControls:
            pm.xform(ctrl, ws=True, m=tmpMatrices[ctrl.name()][f])
            pm.setKeyframe(ctrl)

    pm.keyTangent(fkControls + ikControls, t="{}:{}".format(startFrame, endFrame + 1), itt="auto", ott="auto")


def spine_bakeIKtoFK(object, startFrame=None, endFrame=None):
    """Bake spine animation from IK to FK over the given or selected timeline range."""
    if startFrame is None or endFrame is None:
        result = getFrameRange()
        if result is None:
            pm.warning("spine_bakeIKtoFK: range must be selected on timeline to bake")
            return
        startFrame, endFrame = result

    moduleInfo = getModuleInfo(object)
    if not moduleInfo:
        return

    fkControls = getSpineControls(moduleInfo, "fk")
    ikControls = getSpineControls(moduleInfo, "ik")

    fixSurface = moduleInfo.getAttr("fix_surface").node()
    fkSurface = moduleInfo.getAttr("fk_surface").node()

    params = json.loads(moduleInfo.getAttr("params"))
    fkParams = [param for _, param in params["fk"]]
    fkParams[-1] = 0.999 # last FK control should be oriented by the end of the surface

    tmpData = {}

    for ctrl, param in zip(fkControls, fkParams):
        fkt = makeSurfaceTransform(ctrl+"_fk_surface_tmp", fkSurface, param, 0.5)
        fixt = makeSurfaceTransform(ctrl+"_fix_surface_tmp", fixSurface, param, 0.5)

        tmpData[ctrl.name()] = {}
        tmpData[ctrl.name()]["offsetMatrix"] = ctrl.wm.get() * fkt.wim.get()
        tmpData[ctrl.name()]["fix"] = fixt
        tmpData[ctrl.name()]["matrices"] = {}

        pm.delete(fkt)

    # save matrices per frame
    for f in range(int(startFrame), int(endFrame)+1):
        pm.currentTime(f)

        for ctrl in tmpData:
            tmpData[ctrl]["matrices"][f] = tmpData[ctrl]["offsetMatrix"] * tmpData[ctrl]["fix"].wm.get()

    for ctrl in tmpData:
        pm.delete(tmpData[ctrl]["fix"])

    # set fk animation
    for f in range(int(startFrame), int(endFrame)+1):
        pm.currentTime(f)

        for ctrl in ikControls:
            for a in ["tx", "ty", "tz", "rx", "ry", "rz"]:
                if ctrl.attr(a).isSettable():
                    ctrl.attr(a).set(0)
                    pm.setKeyframe(ctrl.attr(a))

        for ctrl in fkControls:
            pm.xform(ctrl, ws=True, m=tmpData[ctrl.name()]["matrices"][f])
            pm.setKeyframe(ctrl)

    pm.keyTangent(fkControls + ikControls, t="{}:{}".format(startFrame, endFrame + 1), itt="auto", ott="auto")
