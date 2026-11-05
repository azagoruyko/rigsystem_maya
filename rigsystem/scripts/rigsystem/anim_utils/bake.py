import json

import maya.api.OpenMaya as om
import maya.mel as mel

from rigsystem import proxy
from rigsystem.rig_utils.general import makeSurfaceTransform
from rigsystem.rig_utils.moduleInfo import getModuleInfo

cmds = proxy.cmds


def getFrameRange():
    """Return (startFrame, endFrame) from timeline slider, or None if range is invalid."""
    mayaPlayBackSlider = mel.eval('$tmpVar=$gPlayBackSlider')
    startFrame, endFrame = cmds.timeControl(mayaPlayBackSlider, q=True, ra=True)
    if endFrame - startFrame <= 1:
        return None
    return (startFrame, endFrame)


def getSpineControls(moduleInfo, prefix):
    """Return list of spine controls for the given prefix from module info."""
    controls = []
    idx = 1
    while moduleInfo.hasAttr(f"{prefix}{idx}"):
        controls.append(moduleInfo.getAttr(f"{prefix}{idx}").node)
        idx += 1
    return controls


def spine_bakeFKtoIK(object, startFrame=None, endFrame=None):
    """Bake spine animation from FK to IK over the given or selected timeline range."""
    if startFrame is None or endFrame is None:
        result = getFrameRange()
        if result is None:
            cmds.warning("spine_bakeFKtoIK: range must be selected on timeline to bake")
            return
        startFrame, endFrame = result

    moduleInfo = getModuleInfo(object)
    if not moduleInfo:
        return

    fixSurface = moduleInfo.getAttr("fix_surface").node
    params = json.loads(moduleInfo.getAttr("params"))
    ikParams = [param for _, param in params["ik"]]

    fkControls = getSpineControls(moduleInfo, "fk")
    fkControls.append(moduleInfo.getAttr("hip").node)

    ikControls = getSpineControls(moduleInfo, "ik")

    tmpMatrices = {} # per object each frame

    # save IK controls world matrices
    for f in range(int(startFrame), int(endFrame)+1):
        cmds.currentTime(f)

        for i, ctrl in enumerate(ikControls):
            if ctrl not in tmpMatrices:
                tmpMatrices[ctrl] = {}

            m = cmds.xform(ctrl, q=True, ws=True, m=True)

            if i == len(ikControls)-1:
                fixt = makeSurfaceTransform(f"{ctrl}_fix_surface_tmp", fixSurface, ikParams[i], 0.5)
                endt = makeSurfaceTransform(f"{ctrl}_fix_surface_tmp", fixSurface, 0.99, 0.5)
                q1 = om.MTransformationMatrix(om.MMatrix(cmds.xform(fixt, q=True, m=True))).rotation(asQuaternion=True)
                q2 = om.MTransformationMatrix(om.MMatrix(cmds.xform(endt, q=True, m=True))).rotation(asQuaternion=True)
                q = q1.inverse() * q2
                cmds.delete([fixt, endt])
                
                trm = om.MTransformationMatrix(om.MMatrix(m))
                trm.rotateBy(q, om.MSpace.kWorld)
                m = list(trm.asMatrix())

            tmpMatrices[ctrl][f] = m

    # set ik animation
    for f in range(int(startFrame), int(endFrame)+1):
        cmds.currentTime(f)

        # reset fk controls animation
        for ctrl in fkControls:
            for a in ["tx", "ty", "tz", "rx", "ry", "rz"]:
                attr = proxy.plug(f"{ctrl}.{a}")
                if attr.get(settable=True):
                    attr.set(0)
                    cmds.setKeyframe(str(attr))

        for ctrl in ikControls:
            cmds.xform(ctrl, ws=True, m=tmpMatrices[ctrl][f])
            cmds.setKeyframe(ctrl)

    cmds.keyTangent(fkControls + ikControls, t=(startFrame, endFrame + 1), itt="auto", ott="auto")


def spine_bakeIKtoFK(object, startFrame=None, endFrame=None):
    """Bake spine animation from IK to FK over the given or selected timeline range."""
    if startFrame is None or endFrame is None:
        result = getFrameRange()
        if result is None:
            cmds.warning("spine_bakeIKtoFK: range must be selected on timeline to bake")
            return
        startFrame, endFrame = result

    moduleInfo = getModuleInfo(object)
    if not moduleInfo:
        return

    fkControls = getSpineControls(moduleInfo, "fk")
    ikControls = getSpineControls(moduleInfo, "ik")

    fixSurface = moduleInfo.getAttr("fix_surface").node
    fkSurface = moduleInfo.getAttr("fk_surface").node

    params = json.loads(moduleInfo.getAttr("params"))
    fkParams = [param for _, param in params["fk"]]
    fkParams[-1] = 0.999 # last FK control should be oriented by the end of the surface

    tmpData = {}

    for ctrl, param in zip(fkControls, fkParams):
        fkt = makeSurfaceTransform(f"{ctrl}_fk_surface_tmp", fkSurface, param, 0.5)
        fixt = makeSurfaceTransform(f"{ctrl}_fix_surface_tmp", fixSurface, param, 0.5)

        tmpData[ctrl] = {}
        tmpData[ctrl]["offsetMatrix"] = om.MMatrix(proxy.plug(f"{ctrl}.worldMatrix[0]").get()) * om.MMatrix(proxy.plug(f"{fkt}.worldInverseMatrix[0]").get())
        tmpData[ctrl]["fix"] = fixt
        tmpData[ctrl]["matrices"] = {}

        cmds.delete(fkt)

    # save matrices per frame
    for f in range(int(startFrame), int(endFrame)+1):
        cmds.currentTime(f)

        for ctrl in tmpData:
            tmpData[ctrl]["matrices"][f] = list(tmpData[ctrl]["offsetMatrix"] * om.MMatrix(proxy.plug(f"{tmpData[ctrl]['fix']}.worldMatrix[0]").get()))

    for ctrl in tmpData:
        cmds.delete(tmpData[ctrl]["fix"])

    # set fk animation
    for f in range(int(startFrame), int(endFrame)+1):
        cmds.currentTime(f)

        for ctrl in ikControls:
            for a in ["tx", "ty", "tz", "rx", "ry", "rz"]:
                attr = proxy.plug(f"{ctrl}.{a}")
                if attr.get(settable=True):
                    attr.set(0)
                    cmds.setKeyframe(str(attr))

        for ctrl in fkControls:
            cmds.xform(ctrl, ws=True, m=tmpData[ctrl]["matrices"][f])
            cmds.setKeyframe(ctrl)

    cmds.keyTangent(fkControls + ikControls, t=(startFrame, endFrame + 1), itt="auto", ott="auto")
