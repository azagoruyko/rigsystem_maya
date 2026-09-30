import pymel.core as pm
import maya.cmds as cmds

import re

from .matrix import (
    slerp,
    blendMatrices,
    mirrorBehaviourMatrix,
)
from .naming import (
    findSymmetricName,
    isLeftSide,
    isRightSide,
)

def copyAttrs(source, dest, exchange=False):
    """Copy keyable attributes from source to destination."""
    source = pm.PyNode(source)
    dest = pm.PyNode(dest)

    for a in source.listAttr(k=True):
        if dest.hasAttr(a.shortName()):
            if dest.attr(a.shortName()).isSettable():
                if exchange:
                    tmp = dest.attr(a.shortName()).get()
                    dest.attr(a.shortName()).set(a.get())
                    a.set(tmp)
                else:
                    dest.attr(a.shortName()).set(a.get())

def copyAttrsSpec(source, dest, attrs, exchange=False):
    """Copy selected attributes from source to destination."""
    source = pm.PyNode(source)
    dest = pm.PyNode(dest)

    for a in attrs:
        if source.hasAttr(a) and dest.hasAttr(a):
            if dest.attr(a).isSettable():
                if exchange:
                    tmp = dest.attr(a).get()
                    dest.attr(a).set(source.attr(a).get())
                    source.attr(a).set(tmp)
                else:
                    dest.attr(a).set(source.attr(a).get())

def freezeJoints(joints):
    """Freeze joint rotations into joint orientation."""
    for j in joints:
        j.setOrientation(j.getRotation().asQuaternion() * j.getOrientation())
        j.setRotation([0,0,0])

def resetControl(control):
    """Reset keyable control attributes to default values."""
    control = pm.PyNode(control)

    for a in control.listAttr(k=True, w=True, u=True, s=True):
        if a.isDynamic():
            a.set(pm.addAttr(a, q=True, dv=True))
        else:
            if a.shortName() in ["sx", "sy", "sz", "v"]:
                a.set(1)
            else:
                a.set(0)

def resetControls(namespace, skip=["main_control"]):
    """Reset all controls in a namespace except skipped ones."""
    ls = pm.ls(namespace + "*_control")
    skip = [pm.PyNode(namespace + o) for o in skip if pm.objExists(namespace + o)]

    for ctrl in set(ls) - set(skip):
        resetControl(ctrl)

def selectControls(namespace, skip=[]):
    """Select controls in a namespace except skipped ones."""
    ls = pm.ls(namespace + "*_control")
    skip = [pm.PyNode(namespace + o) for o in skip if pm.objExists(namespace + o)]

    pm.select(set(ls) - set(skip))

def lockAttr(attr, v=1):
    """Lock, hide, or expose an attribute based on mode."""
    if v == 1: # lock and hide
        attr.setKeyable(False)
        attr.setLocked(True)
        attr.showInChannelBox(False)

    if v == 0.5: # make non-keyable
        attr.setKeyable(False)
        attr.setLocked(False)
        attr.showInChannelBox(True)

    if v == 0: # make keyable and show
        attr.setLocked(False)
        attr.showInChannelBox(True)
        attr.setKeyable(True)

def lockTRS(object, t=[1,1,1], r=[1,1,1], s=[1,1,1], v=1):
    """Set lock and keyability states for transform channels."""
    if not pm.objExists(object):
        return

    if type(object) not in [pm.nt.Transform, pm.nt.Joint]:
        return

    translates = ["tx", "ty", "tz"]
    rotates = ["rx", "ry", "rz"]
    scales = ["sx", "sy", "sz"]
    visibility = ["v"]

    listAttrs = ([translates, t], [rotates, r], [scales, s], [visibility, [v]])

    for attrs, vals in listAttrs:
        for attr, val in zip(attrs, vals):
            lockAttr(object.attr(attr), val)

def isVisible(obj):
    """Return effective visibility state for object or object set."""
    isHidden = pm.hide(obj, tv=True)
    if isHidden == 1: # hidden
        return False

    elif isHidden == 2: # visible
        return True

    elif isHidden == 0:
        if pm.objectType(obj) == "objectSet":
            return all(isVisible(x) for x in pm.sets(obj, q=True))
        else:
            return pm.PyNode(obj).v.get()

def toggleVisible(obj):
    """Toggle object visibility and return new visible state."""
    isHidden = pm.hide(obj, tv=True)
    if isHidden == 1: # hidden
        pm.showHidden(obj)
        return True

    elif isHidden == 2: # visible
        pm.hide(obj)
        return False

    elif isHidden == 0:
        if pm.objectType(obj) == "objectSet":
            v = pm.sets(obj, q=True)[0].v.get()
        else:
            v = pm.PyNode(obj).v.get()

        if v:
            pm.hide(obj)
            return False
        else:
            pm.showHidden(obj)
            return True

def isAnimated(attr):
    """Return True if attribute is animated (has keyframes or connections)."""
    return pm.api.MAnimUtil.isAnimated(pm.PyNode(attr).__apimplug__())            

def makeSurfaceTransform(name, surface, u=0.5, v=0.5, percentUV=False):
    """Create a transform driven by surface position and tangents."""
    posi = pm.createNode("pointOnSurfaceInfo", n=name+"_pointOnSurfaceInfo")
    fourByFour = pm.createNode("fourByFourMatrix", n=name+"_fourByFourMatrix")
    decompose = pm.createNode("decomposeMatrix", n=name+"_decomposeMatrix")
    inv = pm.createNode("multMatrix", n=name+"_multMatrix")
    transform = pm.createNode("transform", n=name+"_transform")

    surface.worldSpace >> posi.inputSurface
    posi.turnOnPercentage.set(percentUV)

    if type(u) in [int, float]:
        posi.parameterU.set(u)
    else:
        pm.Attribute(u) >> posi.parameterU

    if type(v) in [int, float]:
        posi.parameterV.set(v)
    else:
        pm.Attribute(v) >> posi.parameterV

    posi.positionX >> fourByFour.in30
    posi.positionY >> fourByFour.in31
    posi.positionZ >> fourByFour.in32
    posi.normalX >> fourByFour.in00
    posi.normalY >> fourByFour.in01
    posi.normalZ >> fourByFour.in02
    posi.tangentUx >> fourByFour.in10
    posi.tangentUy >> fourByFour.in11
    posi.tangentUz >> fourByFour.in12
    posi.tangentVx >> fourByFour.in20
    posi.tangentVy >> fourByFour.in21
    posi.tangentVz >> fourByFour.in22

    fourByFour.output >> inv.matrixIn[0]
    transform.pim >> inv.matrixIn[1]
    inv.matrixSum >> decompose.inputMatrix

    decompose.outputTranslate >> transform.t
    decompose.outputRotate >> transform.r

    return transform

def setPivot(source, destination):
    """Set destination pivots to source world translation."""
    t = source.getTranslation("world")
    cmds.move(t[0], t[1], t[2], [destination + ".scalePivot", destination + ".rotatePivot"], a=True)

def setPolevectorPositon(j1, j2, j3, offsetCoeff, polevector):
    """Place pole vector control using three-joint chain geometry."""
    start = pm.xform(j1, q=1, ws=1, t=1)
    mid = pm.xform(j2, q=1, ws=1, t=1)
    end = pm.xform(j3, q=1, ws=1, t=1)

    startV = pm.api.MVector(start[0], start[1], start[2])
    midV = pm.api.MVector(mid[0], mid[1], mid[2])
    endV = pm.api.MVector(end[0], end[1], end[2])

    startEnd = endV - startV
    startMid = midV - startV

    dotP = startMid * startEnd
    proj = float(dotP) / float(startEnd.length())
    startEndN = startEnd.normal()
    projV = startEndN * proj

    arrowV = startMid - projV
    arrowV *= offsetCoeff
    finalV = arrowV + midV

    pm.xform(polevector, ws=True, t=(finalV.x, finalV.y, finalV.z))

def createPathCurve(name, objs, degree=3, spans=4):
    """Create a curve through world positions of given objects."""
    if not objs:
        return

    poses = [pm.PyNode(o).getTranslation("world") for o in objs]
    crv = pm.curve(d=1, ep=poses, n=name + "_curve")

    if degree and spans:
        pm.rebuildCurve(crv, ch=0, rpo=1, rt=0, end=1, kr=0, kcp=0, kep=1, kt=0, d=degree, s=spans, tol=0.01)

    return crv

def getDistance(transform1, transform2):
    """Return world-space distance between two transforms."""
    p1 = transform1.getTranslation("world")
    p2 = transform2.getTranslation("world")
    return p1.distanceTo(p2)

def getColorByName(name):
    """Return Maya override color index by name (left=6, right=13, default=17)."""
    color = 17
    if isLeftSide(name):
        color = 6
    elif isRightSide(name):
        color = 13
    return color

def matchJoint(sourceJoint, name=None):
    """Create joint matching source transform; freeze orientation."""
    j = pm.createNode("joint", n=name or "joint1")
    pm.matchTransform(j, sourceJoint)
    if isinstance(sourceJoint, pm.nt.Joint):
        j.preferredAngle.set(sourceJoint.preferredAngle.get())
    freezeJoints([j])
    return j    

def createDistance(name, nodeA, nodeB):
    """Create a distance network and return the output distance plug."""
    mm = pm.createNode("multMatrix", n=name+"_multMatrix")
    nodeB.pm >> mm.matrixIn[0]
    nodeA.pim >> mm.matrixIn[1]

    d = pm.createNode("distanceBetween",n=name+"_distanceBetween")
    nodeA.t >> d.point1
    nodeB.t >> d.point2
    mm.matrixSum >> d.inMatrix2
    return d.distance

def makeStretchable(name, objects, attr, stretch=1, squash=1, saveVolume=0, minValue=0, scales=(True, True, True), useTx=False):
    """Build stretch/squash scaling setup for a transform chain."""
    mult = pm.createNode("multiplyDivide", n=name + "_stretch_multiplyDivide")
    mult.attr("operation").set(2) # /

    attr >> mult.input1X
    attr >> mult.input2Y

    if pm.objExists(minValue):
        minValue >> mult.input1Y
        minValue >> mult.input2X
    elif minValue == 0:
        mult.attr("input1Y").set(attr.get())
        mult.attr("input2X").set(attr.get())
    else:
        mult.attr("input1Y").set(minValue)
        mult.attr("input2X").set(minValue)

    finalX = mult.outputX
    finalY = mult.outputY

    # stretch
    b2aX = pm.createNode("blendTwoAttr", n=name + "_stretch_x_blendTwoAttr")

    if pm.objExists(stretch):
        stretch >> b2aX.attributesBlender
    else:
        b2aX.attributesBlender.set(stretch)

    b2aX.i[0].set(1)
    mult.outputX >> b2aX.i[1]
    finalX = b2aX.output

    if scales[1] or scales[2]:
        b2aY = pm.createNode("blendTwoAttr", n=name + "_stretch_yz_blendTwoAttr")
        if pm.objExists(stretch):
            stretch >> b2aY.attributesBlender
        else:
            b2aY.attributesBlender.set(stretch)

        b2aY.i[0].set(1)
        mult.outputY >> b2aY.i[1]
        finalY = b2aY.output

    # squash
    squashCond = pm.createNode("condition", n=name + "_squash_condition")
    squashCond.attr("operation").set(2) # >
    finalX >> squashCond.firstTerm

    if pm.objExists(squash):
        setRange = pm.createNode("setRange", n=name + "_squash_setRange")
        squash >> setRange.valueX
        setRange.oldMinX.set(0)
        setRange.oldMaxX.set(1)
        setRange.minX.set(1)
        setRange.maxX.set(0.1)

        setRange.outValueX >> squashCond.secondTerm
        setRange.outValueX >> mult.input2Z
        setRange.outValueX >> squashCond.colorIfFalseR
    else:
        squashCond.secondTerm.set(squash)
        mult.input2Z.set(squash)
        squashCond.colorIfFalseR.set(squash)

    finalX >> squashCond.colorIfTrueR
    finalY >> squashCond.colorIfTrueG

    mult.input1Z.set(1)
    mult.outputZ >> squashCond.colorIfFalseG

    finalX = squashCond.outColorR
    finalY = squashCond.outColorG

    # saveVolume
    if saveVolume not in [0, None]:
        b2a = pm.createNode("blendTwoAttr", n=name + "_saveVolume_blendTwoAttr")
        b2a.i[0].set(1)
        finalY >> b2a.i[1]

        if pm.objExists(saveVolume):
            saveVolume >> b2a.attributesBlender
        else:
            b2a.attributesBlender.set(saveVolume)

        finalY = b2a.output

    for obj in objects:
        if scales[0]:
            if useTx:
                obj = pm.PyNode(obj)

                t = obj.t.listConnections(p=True, s=True, d=False)
                if t:
                    mult = pm.createNode("multiplyDivide", n=obj + "_stretch_t_multiplyDivide")
                    t[0] >> mult.input1
                    finalX >> mult.input2X
                    mult.output >> obj.t
                else:
                    tx = obj.tx.listConnections(p=True, s=True, d=False)

                    mult = pm.createNode("multDL", n=obj + "_stretch_tx_multDL")

                    if tx:
                        tx[0] >> mult.input1
                    else:
                        mult.input1.set(obj.tx.get())

                    finalX >> mult.input2
                    mult.output >> obj.tx
            else:
                finalX >> pm.PyNode(obj).sx

        if scales[1]: # y
            finalY >> pm.PyNode(obj).sy

        if scales[2]: # z
            finalY >> pm.PyNode(obj).sz

    return finalX, finalY

def makeHelpLine(name, objects, visibleAttr=None, parent=None):
    """Create a templated helper line constrained to objects."""
    poses = [[0, 0, 0] for o in objects]
    crv = pm.curve(n=name + "_helpLine_curve", d=1, p=poses)
    crv.template.set(True)

    grp = pm.createNode("transform", n=name + "_helpLine_group", p=parent)
    grp | crv

    if visibleAttr:
        if pm.objExists(visibleAttr):
            visibleAttr >> grp.v
        else:
            pm.displayWarning("makeHelpLine: '" + visibleAttr + "' doesn't exist. Used default value")

    for i, obj in enumerate(objects):
        pnt = pm.createNode("transform", n=name + "_helpLine_" + str(i + 1) + "_transform", p=grp)
        pnt.t >> crv.controlPoints[i]
        pm.pointConstraint(obj, pnt)

        lockTRS(pnt, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)

    lockTRS(crv, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)
    lockTRS(grp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)

def getDeformers(shape, types=None):
    """Return deformers in upstream order for a shape."""
    geoType = cmds.objectType(shape)

    if geoType == "mesh":
        attr = shape + ".inMesh"
    elif geoType in ["nurbsCurve", "nurbsSurface"]:
        attr = shape + ".create"
    else:
        cmds.error("Unsupported type: %s"%geoType)

    deformers = []
    while True:
        conn = cmds.listConnections(attr, s=True, d=False, p=True)
        if not conn:
            break

        plug = conn[0]

        node, cattr = plug.split(".")
        nodeType = cmds.objectType(node)

        if nodeType == "groupParts":
            attr = node +".inputGeometry"
        elif cattr.startswith("outputGeometry") and "input.inputGeometry" in cmds.listAttr(node):
            id = re.search("\\[(\\d+)\\]", cattr).group(1)
            attr = node + ".input[%s].inputGeometry"%id
        else:
            break

        if not types or (types and nodeType in types):
            deformers.append(node)

    return [pm.PyNode(d) for d in deformers[::-1]]

def createWrap(influence, surface,**kwargs):
    """Create and configure a Maya wrap deformer."""
    influence = pm.PyNode(influence)
    surface = pm.PyNode(surface)

    #create wrap deformer
    weightThreshold = kwargs.get('weightThreshold',0.0)
    maxDistance = kwargs.get('maxDistance',1.0)
    exclusiveBind = kwargs.get('exclusiveBind',False)
    autoWeightThreshold = kwargs.get('autoWeightThreshold',True)
    falloffMode = kwargs.get('falloffMode',0)

    wrapNode = pm.deformer(surface, type='wrap', n=surface+"_wrap")[0]

    wrapNode.weightThreshold.set(weightThreshold)
    wrapNode.maxDistance.set(maxDistance)
    wrapNode.exclusiveBind.set(exclusiveBind)
    wrapNode.autoWeightThreshold.set(autoWeightThreshold)
    wrapNode.falloffMode.set(falloffMode)

    surface.wm >> wrapNode.geomMatrix

    #add influence
    base = pm.duplicate(influence,name=influence+'Base')[0]
    base.v.set(0)

    #create dropoff attr if it doesn't exist
    if not pm.objExists(influence+".dropoff"):
        influence.addAttr("dropoff", sn='dr', dv=4.0, min=0.0, max=20.0, k=True )

    #if type mesh
    influenceType = pm.nodeType(influence.getShape())
    if influenceType == 'mesh':
        #create smoothness attr if it doesn't exist
        if not pm.objExists(influence+".smoothness"):
            influence.addAttr("smoothness", sn='smt', dv=0.0, min=0.0, k=True)

        #create the inflType attr if it doesn't exist
        if not pm.objExists(influence+".inflType"):
            influence.addAttr("inflType", at='short', sn='ift', dv=2, min=1, max=2, k=True )

        influence.worldMesh >> wrapNode.driverPoints[0]
        base.worldMesh >> wrapNode.basePoints[0]
        influence.inflType >> wrapNode.inflType[0]
        influence.smoothness >> wrapNode.smoothness[0]

    #if type nurbsCurve or nurbsSurface
    if influenceType in ['nurbsCurve', 'nurbsSurface']:
        #create the wrapSamples attr if it doesn't exist
        if not pm.objExists(influence+".wrapSamples"):
            influence.addAttr("wrapSamples", at='short', sn='wsm', dv=10, min=1, k=True)

        influence.ws >> wrapNode.driverPoints[0]
        base.ws >> wrapNode.basePoints[0]
        influence.wsm >> wrapNode.nurbsSamples[0]

    influence.dropoff >> wrapNode.dropoff[0]

    # make wrap scalable
    if pm.objExists("main_control"):
        scaleMatrix = pm.createNode("composeMatrix", n=surface+"_scale_composeMatrix")
        pm.PyNode("main_control").scale >> scaleMatrix.inputScale

        pm.select([base, surface])
        cluster = pm.deformer(type="cluster", foc=True, n=surface+"_scale_cluster")[0]
        scaleMatrix.outputMatrix >> cluster.matrix

    return wrapNode


def connectFromSymmetric(node, **kwargs): # connects left node to the right one
    """Connect keyable attrs from symmetric counterpart to node."""
    node = pm.PyNode(node)

    symNode = findSymmetricName(node.name(), left=False) # skip finding symmetrics for left nodes
    if pm.objExists(symNode) and node != symNode: # symNode is a leftside node
        symNode = pm.PyNode(symNode)

        for a in node.listAttr(k=True, s=True, se=True):
            coeff = kwargs.get(a.longName()) or kwargs.get(a.shortName())
            if coeff is None:
                symNode.attr(a.longName()) >> a
            else:
                mult = pm.createNode("multDL", n=symNode+"_"+a.longName()+"_symmetric_multDL")
                symNode.attr(a.longName()) >> mult.input1
                mult.input2.set(coeff)
                mult.output >> a

def symmetrizeJoint(srcJoint):
    """Symmetrize joint orientation and position using mirror behaviour."""
    srcJoint = pm.PyNode(srcJoint)

    destName = findSymmetricName(srcJoint.nodeName())
    if not destName:
        pm.displayWarning("No symmetric counterpart for: {}".format(srcJoint.nodeName()))
        return
    destJoint = pm.PyNode(destName)

    mirroredWorld = mirrorBehaviourMatrix(srcJoint.wm.get(), translate=True, rotate=True)
    pm.xform(destJoint, ws=True, m=mirroredWorld)

def setToOffsetParentMatrix(node):
    """Set node's offsetParentMatrix to its matrix."""
    m = node.matrix.get()
    node.offsetParentMatrix.set(m * node.offsetParentMatrix.get())
    pm.xform(node, m=pm.dt.Matrix())

    if pm.objectType(node) == "joint":
        freezeJoints([node])    

def setFromOffsetParentMatrix(node):
    """Set node's matrix to its offsetParentMatrix."""
    m = node.matrix.get() * node.offsetParentMatrix.get()
    pm.xform(node, m=m)
    node.offsetParentMatrix.set(pm.dt.Matrix())

def convertParentToParentOffsetMatrix(node):
    """Convert parent transform to node's parent offset matrix."""
    parent = node.getParent()
    parentMatrix = parent.matrix.get() * parent.offsetParentMatrix.get()
    
    m = node.matrix.get() * node.offsetParentMatrix.get() * parentMatrix
    node.offsetParentMatrix.set(m)
    if parent.getParent():
        parent.getParent() | node
    else:
        pm.parent(node, world=True)        
    pm.xform(node, m=pm.dt.Matrix())
    pm.delete(parent)

    if pm.objectType(node) == "joint":
        freezeJoints([node])
