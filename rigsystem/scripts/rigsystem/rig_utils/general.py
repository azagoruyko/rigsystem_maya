import maya.api.OpenMaya as om
import maya.api.OpenMayaAnim as oma

import re

from .. import proxy
from .matrix import (
    mirrorBehaviourMatrix,
)
from .naming import (
    findSymmetricName,
    isLeftSide,
    isRightSide,
)

cmds = proxy.cmds

def copyAttrs(source, dest, exchange=False):
    """Copy keyable attributes from source to destination."""
    source = proxy.node(source)
    dest = proxy.node(dest)

    for attr in source.listAttr(k=True, sn=True):
        if cmds.attributeQuery(attr, node=dest, exists=True):
            destPlug = dest.attr(attr)
            if destPlug.get(settable=True):
                sourcePlug = source.attr(attr)
                if exchange:
                    value = destPlug.get()
                    destPlug.set(sourcePlug.get())
                    sourcePlug.set(value)
                else:
                    destPlug.set(sourcePlug.get())


def copyAttrsSpec(source, dest, attrs, exchange=False):
    """Copy selected attributes from source to destination."""
    source = proxy.node(source)
    dest = proxy.node(dest)

    for attr in attrs:
        if cmds.attributeQuery(attr, node=source, exists=True) and cmds.attributeQuery(attr, node=dest, exists=True):
            destPlug = dest.attr(attr)
            if destPlug.get(settable=True):
                sourcePlug = source.attr(attr)
                if exchange:
                    value = destPlug.get()
                    destPlug.set(sourcePlug.get())
                    sourcePlug.set(value)
                else:
                    destPlug.set(sourcePlug.get())


def freezeJoints(joints):
    """Freeze joint rotations into joint orientation."""
    for joint in joints:
        selection = om.MSelectionList()
        selection.add(str(joint))
        jointFn = oma.MFnIkJoint(selection.getDagPath(0))
        jointFn.setOrientation(jointFn.rotation(asQuaternion=True) * jointFn.orientation(asQuaternion=True))
        jointFn.setRotation(om.MQuaternion(), om.MSpace.kTransform)


def resetControl(control):
    """Reset keyable control attributes to default values."""
    control = proxy.node(control)
    userAttrs = set(control.listAttr(userDefined=True))
    for attr in control.listAttr(k=True, w=True, u=True, s=True, sn=True):
        plug = control.attr(attr)
        if plug.name in userAttrs:
            plug.set(cmds.addAttr(plug, query=True, defaultValue=True))
        else:
            if attr in ("sx", "sy", "sz", "v"):
                plug.set(1)
            else:
                plug.set(0)


def resetControls(namespace, skip=("main_control",)):
    """Reset all controls in a namespace except skipped ones."""
    controls = cmds.ls(f"{namespace}*_control") or []
    skipped = {namespace + name for name in skip if cmds.objExists(namespace + name)}

    for ctrl in controls:
        if ctrl in skipped:
            continue
        resetControl(ctrl)


def selectControls(namespace, skip=()):
    """Select controls in a namespace except skipped ones."""
    controls = cmds.ls(f"{namespace}*_control") or []
    skipped = {namespace + name for name in skip if cmds.objExists(namespace + name)}

    cmds.select([ctrl for ctrl in controls if ctrl not in skipped], replace=True)


def lockAttr(attr, v=1):
    """Lock, hide, or expose an attribute based on mode."""
    if v == 1: # lock and hide
        cmds.setAttr(attr, keyable=False)
        cmds.setAttr(attr, lock=True)
        cmds.setAttr(attr, channelBox=False)

    if v == 0.5: # make non-keyable
        cmds.setAttr(attr, keyable=False)
        cmds.setAttr(attr, lock=False)
        cmds.setAttr(attr, channelBox=True)

    if v == 0: # make keyable and show
        cmds.setAttr(attr, lock=False)
        cmds.setAttr(attr, channelBox=True)
        cmds.setAttr(attr, keyable=True)


def lockTRS(object, t=1, r=1, s=1, v=1):
    """Set lock and keyability states for transform channels."""
    if not cmds.objExists(object):
        return

    object = proxy.node(object)
    if object.type() not in ("transform", "joint"):
        return

    translates = ["tx", "ty", "tz"]
    rotates = ["rx", "ry", "rz"]
    scales = ["sx", "sy", "sz"]
    visibility = ["v"]

    listAttrs = []
    for attrs, values, compound in (
        (translates, t, "t"),
        (rotates, r, "r"),
        (scales, s, "s"),
    ):
        vals = list(values) if isinstance(values, (list, tuple)) else [values] * len(attrs)
        listAttrs.append((attrs, vals, compound))

    if v is not None:
        listAttrs += ([visibility, [v], None],)

    for attrs, vals, compound in listAttrs:
        if compound and len(vals) == len(attrs):
            compoundValue = vals[0] if all(val == vals[0] for val in vals) else 0
            lockAttr(f"{object}.{compound}", compoundValue)

        for attr, val in zip(attrs, vals):
            lockAttr(f"{object}.{attr}", val)


def isVisible(obj):
    """Return effective visibility state for object or object set."""
    isHidden = cmds.hide(obj, tv=True)
    if isHidden == 1: # hidden
        return False

    elif isHidden == 2: # visible
        return True

    elif isHidden == 0:
        if proxy.node(obj).type() == "objectSet":
            return all(isVisible(x) for x in (cmds.sets(obj, q=True) or []))
        else:
            return proxy.node(obj).v.get()


def toggleVisible(obj):
    """Toggle object visibility and return new visible state."""
    isHidden = cmds.hide(obj, tv=True)
    if isHidden == 1: # hidden
        cmds.showHidden(obj)
        return True

    elif isHidden == 2: # visible
        cmds.hide(obj)
        return False

    elif isHidden == 0:
        if proxy.node(obj).type() == "objectSet":
            members = cmds.sets(obj, q=True) or []
            v = proxy.node(members[0]).v.get() if members else False
        else:
            v = proxy.node(obj).v.get()

        if v:
            cmds.hide(obj)
            return False
        else:
            cmds.showHidden(obj)
            return True


def makeSurfaceTransform(name, surface, u=0.5, v=0.5, percentUV=False):
    """Create a transform driven by surface position and tangents."""
    posi = proxy.create("pointOnSurfaceInfo", name)
    fourByFour = proxy.create("fourByFourMatrix", name)
    decompose = proxy.create("decomposeMatrix", name)
    inv = proxy.create("multMatrix", name)
    transform = proxy.create("transform", name)

    surfaceShape = (proxy.node(surface).getShapes(noIntermediate=True) or [proxy.node(surface)])[0]
    surfaceShape.worldSpace[0] >> posi.inputSurface
    posi.turnOnPercentage.set(percentUV)

    if type(u) in [int, float]:
        posi.parameterU.set(u)
    else:
        proxy.plug(u) >> posi.parameterU

    if type(v) in [int, float]:
        posi.parameterV.set(v)
    else:
        proxy.plug(v) >> posi.parameterV

    for source, target in (
        ("positionX", "in30"), ("positionY", "in31"), ("positionZ", "in32"),
        ("normalX", "in00"), ("normalY", "in01"), ("normalZ", "in02"),
        ("tangentUx", "in10"), ("tangentUy", "in11"), ("tangentUz", "in12"),
        ("tangentVx", "in20"), ("tangentVy", "in21"), ("tangentVz", "in22"),
    ):
        posi.attr(source) >> fourByFour.attr(target)

    fourByFour.output >> inv.matrixIn[0]
    transform.parentInverseMatrix[0] >> inv.matrixIn[1]
    inv.matrixSum >> decompose.inputMatrix
    decompose.outputTranslate >> transform.translate
    decompose.outputRotate >> transform.rotate

    return transform


def setPivot(source, destination):
    """Set destination pivots to source world translation."""
    t = cmds.xform(source, q=True, ws=True, t=True)
    cmds.move(t[0], t[1], t[2], [f"{destination}.scalePivot", f"{destination}.rotatePivot"], a=True)


def setPolevectorPositon(j1, j2, j3, offsetCoeff, polevector):
    """Place pole vector control using three-joint chain geometry."""
    start = cmds.xform(j1, q=True, ws=True, t=True)
    mid = cmds.xform(j2, q=True, ws=True, t=True)
    end = cmds.xform(j3, q=True, ws=True, t=True)

    startV = om.MVector(start)
    midV = om.MVector(mid)
    endV = om.MVector(end)

    startEnd = endV - startV
    startMid = midV - startV

    dotP = startMid * startEnd
    proj = float(dotP) / float(startEnd.length())
    startEndN = startEnd.normal()
    projV = startEndN * proj

    arrowV = startMid - projV
    arrowV *= offsetCoeff
    finalV = arrowV + midV

    cmds.xform(polevector, ws=True, t=(finalV.x, finalV.y, finalV.z))


def createPathCurve(name, objs, degree=3, spans=4):
    """Create a curve through world positions of given objects."""
    if not objs:
        return

    poses = [cmds.xform(o, q=True, ws=True, t=True) for o in objs]
    crv = cmds.curve(d=1, ep=poses, n=f"{name}_curve")

    if degree and spans:
        cmds.rebuildCurve(crv, ch=0, rpo=1, rt=0, end=1, kr=0, kcp=0, kep=1, kt=0, d=degree, s=spans, tol=0.01)

    return proxy.node(crv)


def getDistance(transform1, transform2):
    """Return world-space distance between two transforms."""
    p1 = cmds.xform(transform1, q=True, ws=True, t=True)
    p2 = cmds.xform(transform2, q=True, ws=True, t=True)
    return om.MPoint(p1).distanceTo(om.MPoint(p2))


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
    sourceJoint = proxy.node(sourceJoint)
    j = proxy.create("joint", name or "joint1", suffix=False)
    cmds.matchTransform(j, sourceJoint)
    if sourceJoint.type() == "joint":
        j.preferredAngle.set(sourceJoint.preferredAngle.get())
    freezeJoints([j])
    return j


def createDistance(name, nodeA, nodeB):
    """Create a distance network and return the output distance plug."""
    nodeA = proxy.node(nodeA)
    nodeB = proxy.node(nodeB)

    mm = proxy.create("multMatrix", name)
    nodeB.parentMatrix >> mm.matrixIn[0]
    nodeA.parentInverseMatrix >> mm.matrixIn[1]

    distance = proxy.create("distanceBetween", name)
    nodeA.translate >> distance.point1
    nodeB.translate >> distance.point2
    mm.matrixSum >> distance.inMatrix2
    return distance.distance


def makeStretchable(name, objects, attr, stretch=1, squash=1, saveVolume=0, minValue=0, scales=(True, True, True), useTx=False):
    """Build stretch/squash scaling setup for a transform chain."""
    mult = proxy.create("multiplyDivide", f"{name}_stretch")
    mult.operation.set(2) # /

    proxy.plug(attr) >> mult.input1X
    proxy.plug(attr) >> mult.input2Y

    if isinstance(minValue, str) and cmds.objExists(minValue):
        proxy.plug(minValue) >> mult.input1Y
        proxy.plug(minValue) >> mult.input2X
    elif minValue == 0:
        initialValue = proxy.plug(attr).get()
        mult.input1Y.set(initialValue)
        mult.input2X.set(initialValue)
    else:
        mult.input1Y.set(minValue)
        mult.input2X.set(minValue)

    finalX = mult.outputX
    finalY = mult.outputY

    # stretch
    b2aX = proxy.create("blendTwoAttr", f"{name}_stretch_x")

    if isinstance(stretch, str) and cmds.objExists(stretch):
        proxy.plug(stretch) >> b2aX.attributesBlender
    else:
        b2aX.attributesBlender.set(stretch)

    b2aX.input[0].set(1)
    mult.outputX >> b2aX.input[1]
    finalX = b2aX.output

    if scales[1] or scales[2]:
        b2aY = proxy.create("blendTwoAttr", f"{name}_stretch_yz")
        if isinstance(stretch, str) and cmds.objExists(stretch):
            proxy.plug(stretch) >> b2aY.attributesBlender
        else:
            b2aY.attributesBlender.set(stretch)

        b2aY.input[0].set(1)
        mult.outputY >> b2aY.input[1]
        finalY = b2aY.output

    # squash
    squashCond = proxy.create("condition", f"{name}_squash")
    squashCond.operation.set(2) # >
    finalX >> squashCond.firstTerm

    if isinstance(squash, str) and cmds.objExists(squash):
        setRange = proxy.create("setRange", f"{name}_squash")
        proxy.plug(squash) >> setRange.valueX
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
        b2a = proxy.create("blendTwoAttr", f"{name}_saveVolume")
        b2a.input[0].set(1)
        finalY >> b2a.input[1]

        if isinstance(saveVolume, str) and cmds.objExists(saveVolume):
            proxy.plug(saveVolume) >> b2a.attributesBlender
        else:
            b2a.attributesBlender.set(saveVolume)

        finalY = b2a.output

    for obj in proxy.nodes(objects):
        if scales[0]:
            if useTx:
                t = obj.translate.inputs()
                if t:
                    mult = proxy.create("multiplyDivide", f"{obj}_stretch_t")
                    t[0] >> mult.input1
                    finalX >> mult.input2X
                    mult.output.connect(obj.translate, force=True)
                else:
                    tx = obj.tx.inputs()

                    mult = proxy.create("multDL", f"{obj}_stretch_tx")

                    if tx:
                        tx[0] >> mult.input1
                    else:
                        mult.input1.set(obj.tx.get())

                    finalX >> mult.input2
                    mult.output.connect(obj.tx, force=True)
            else:
                finalX.connect(obj.sx, force=True)

        if scales[1]: # y
            finalY.connect(obj.sy, force=True)

        if scales[2]: # z
            finalY.connect(obj.sz, force=True)

    return finalX, finalY


def makeHelpLine(name, objects, visibleAttr=None, parent=None):
    """Create a templated helper line constrained to objects."""
    poses = [[0, 0, 0] for o in objects]
    crv = cmds.curve(n=f"{name}_helpLine_curve", d=1, p=poses)
    proxy.node(crv).template.set(True)

    grp = proxy.create("transform", f"{name}_helpLine_group", parent=parent)
    crv = grp | proxy.node(crv)

    if visibleAttr:
        if cmds.objExists(visibleAttr):
            proxy.plug(visibleAttr) >> grp.v
        else:
            cmds.warning(f"makeHelpLine: '{visibleAttr}' doesn't exist. Used default value")

    for i, obj in enumerate(objects):
        pnt = proxy.create(
            "transform",
            f"{name}_helpLine_{i + 1}",
            parent=grp,
        )
        shape = proxy.node(crv).getShapes()[0]
        pnt.translate >> shape.controlPoints[i]
        cmds.pointConstraint(obj, pnt)

        lockTRS(pnt, t=1, r=1, s=1, v=1)

    lockTRS(crv, t=1, r=1, s=1, v=1)
    lockTRS(grp, t=1, r=1, s=1, v=1)


def getDeformers(shape, types=None):
    """Return deformers in upstream order for a shape."""
    shape = proxy.node(shape)
    geoType = shape.type()

    if geoType == "mesh":
        attr = shape.inMesh
    elif geoType in ["nurbsCurve", "nurbsSurface"]:
        attr = shape.create
    else:
        cmds.error(f"Unsupported type: {geoType}")

    deformers = []
    while True:
        conn = attr.inputs()
        if not conn:
            break

        inputPlug = conn[0]
        node = inputPlug.node
        nodeType = node.type()

        if nodeType == "groupParts":
            attr = node.inputGeometry
        elif inputPlug.name == "outputGeometry" and "input.inputGeometry" in node.listAttr():
            attr = node.attr(f"input[{inputPlug.index()}].inputGeometry")
        else:
            break

        if not types or (types and nodeType in types):
            deformers.append(node)

    return deformers[::-1]


def createWrap(influence, surface,**kwargs):
    """Create and configure a Maya wrap deformer."""
    influence = str(influence)
    surface = str(surface)

    #create wrap deformer
    weightThreshold = kwargs.get('weightThreshold',0.0)
    maxDistance = kwargs.get('maxDistance',1.0)
    exclusiveBind = kwargs.get('exclusiveBind',False)
    autoWeightThreshold = kwargs.get('autoWeightThreshold',True)
    falloffMode = kwargs.get('falloffMode',0)

    wrapNode = proxy.node(cmds.deformer(surface, type='wrap', n=f"{surface}_wrap")[0])

    wrapNode.weightThreshold.set(weightThreshold)
    wrapNode.maxDistance.set(maxDistance)
    wrapNode.exclusiveBind.set(exclusiveBind)
    wrapNode.autoWeightThreshold.set(autoWeightThreshold)
    wrapNode.falloffMode.set(falloffMode)

    proxy.node(surface).worldMatrix[0] >> wrapNode.geomMatrix

    #add influence
    base = proxy.node(cmds.duplicate(influence, name=f"{influence}Base")[0])
    base.v.set(0)

    #create dropoff attr if it doesn't exist
    if not cmds.objExists(f"{influence}.dropoff"):
        proxy.node(influence).addAttr(ln="dropoff", sn='dr', dv=4.0, min=0.0, max=20.0, k=True)

    #if type mesh
    influenceShape = proxy.node(influence).getShapes(noIntermediate=True)[0]
    baseShape = base.getShapes(noIntermediate=True)[0]
    influenceType = influenceShape.type()
    if influenceType == 'mesh':
        #create smoothness attr if it doesn't exist
        if not cmds.objExists(f"{influence}.smoothness"):
            proxy.node(influence).addAttr(ln="smoothness", sn='smt', dv=0.0, min=0.0, k=True)

        #create the inflType attr if it doesn't exist
        if not cmds.objExists(f"{influence}.inflType"):
            proxy.node(influence).addAttr(ln="inflType", at='short', sn='ift', dv=2, min=1, max=2, k=True)

        influenceShape.worldMesh[0] >> wrapNode.driverPoints[0]
        baseShape.worldMesh[0] >> wrapNode.basePoints[0]
        proxy.node(influence).inflType >> wrapNode.inflType[0]
        proxy.node(influence).smoothness >> wrapNode.smoothness[0]

    #if type nurbsCurve or nurbsSurface
    if influenceType in ['nurbsCurve', 'nurbsSurface']:
        #create the wrapSamples attr if it doesn't exist
        if not cmds.objExists(f"{influence}.wrapSamples"):
            proxy.node(influence).addAttr(ln="wrapSamples", at='short', sn='wsm', dv=10, min=1, k=True)

        influenceShape.worldSpace[0] >> wrapNode.driverPoints[0]
        baseShape.worldSpace[0] >> wrapNode.basePoints[0]
        proxy.node(influence).wrapSamples >> wrapNode.nurbsSamples[0]

    proxy.node(influence).dropoff >> wrapNode.dropoff[0]

    # make wrap scalable
    if cmds.objExists("main_control"):
        scaleMatrix = proxy.create("composeMatrix", f"{surface}_scale")
        proxy.node("main_control").scale >> scaleMatrix.inputScale

        cmds.select([base, surface])
        cluster = proxy.node(cmds.deformer(type="cluster", foc=True, n=f"{surface}_scale_cluster")[0])
        scaleMatrix.outputMatrix >> cluster.matrix

    return wrapNode


def connectFromSymmetric(node, **kwargs): # connects left node to the right one
    """Connect keyable attrs from symmetric counterpart to node."""
    node = str(node)

    symNode = findSymmetricName(node, left=False) # skip finding symmetrics for left nodes
    if cmds.objExists(symNode) and node != symNode: # symNode is a leftside node
        source = proxy.node(symNode)
        destination = proxy.node(node)

        for a in destination.listAttr(k=True, s=True, se=True):
            shortName = cmds.attributeQuery(a, node=node, shortName=True)
            coeff = kwargs.get(a) or kwargs.get(shortName)
            if coeff is None:
                source.attr(a).connect(destination.attr(a), force=True)
            else:
                mult = proxy.create("multDL", f"{symNode}_{a}_symmetric")
                source.attr(a) >> mult.input1
                mult.input2.set(coeff)
                mult.output.connect(destination.attr(a), force=True)


def symmetrizeJoint(srcJoint):
    """Symmetrize joint orientation and position using mirror behaviour."""
    srcJoint = proxy.node(srcJoint)

    destName = findSymmetricName(str(srcJoint))
    if not destName:
        cmds.warning(f"No symmetric counterpart for: {srcJoint}")
        return

    mirroredWorld = mirrorBehaviourMatrix(srcJoint.worldMatrix[0].get(), translate=True, rotate=True)
    cmds.xform(destName, ws=True, m=list(mirroredWorld))


def setToOffsetParentMatrix(node):
    """Set node's offsetParentMatrix to its matrix."""
    node = proxy.node(node)
    m = om.MMatrix(node.matrix.get())
    offset = om.MMatrix(node.offsetParentMatrix.get())
    node.offsetParentMatrix.set(m * offset)
    cmds.xform(node, m=list(om.MMatrix()))

    if node.type() == "joint":
        freezeJoints([node])    


def setFromOffsetParentMatrix(node):
    """Set node's matrix to its offsetParentMatrix."""
    node = proxy.node(node)
    m = om.MMatrix(node.matrix.get()) * om.MMatrix(node.offsetParentMatrix.get())
    cmds.xform(node, m=list(m))
    node.offsetParentMatrix.set(om.MMatrix())


def convertParentToParentOffsetMatrix(node):
    """Convert parent transform to node's parent offset matrix."""
    node = proxy.node(node)
    parents = node.getAllParents()
    parent = parents[0]
    parentMatrix = om.MMatrix(parent.matrix.get()) * om.MMatrix(parent.offsetParentMatrix.get())
    
    m = om.MMatrix(node.matrix.get()) * om.MMatrix(node.offsetParentMatrix.get()) * parentMatrix
    node.offsetParentMatrix.set(m)
    grandparent = parents[1] if len(parents) > 1 else None
    if grandparent:
        grandparent | node
    else:
        cmds.parent(node, world=True)
    cmds.xform(node, m=list(om.MMatrix()))
    cmds.delete(parent)

    if node.type() == "joint":
        freezeJoints([node])
