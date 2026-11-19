import maya.cmds as cmds
import maya.api.OpenMaya as om

from rigsystem import proxy

NAME = "selectionGizmo"


def setWorldMatrixWithoutUndo(node, wm):
    """Set the world matrix without undo, preserving joint orientation and scale compensation."""
    transform = proxy.node(node)
    nodePath = transform.mdagpath
    parentInverse = om.MMatrix(transform.parentInverseMatrix.get())
    localMatrix = om.MMatrix(wm) * parentInverse
    nodeFn = transform.mfn()
    if not nodePath.node().hasFn(om.MFn.kJoint):
        nodeFn.setTransformation(om.MTransformationMatrix(localMatrix))
        return

    space = om.MSpace.kTransform
    translation = om.MVector(localMatrix[12], localMatrix[13], localMatrix[14])

    # A joint applies inverseScale after jointOrient. Remove both before extracting rotation and scale.
    if transform.segmentScaleCompensate.get():
        parentScale = om.MTransformationMatrix()
        parentScale.setScale(transform.inverseScale.get()[0], space)
        localMatrix *= parentScale.asMatrix()

    jointOrientPlug = transform.jointOrient.mplug
    orientAngles = [jointOrientPlug.child(i).asMAngle().asRadians() for i in range(3)]
    jointOrient = om.MEulerRotation(*orientAngles)
    rotationScale = om.MTransformationMatrix(localMatrix * jointOrient.asMatrix().inverse())
    rotateAxis = nodeFn.rotateOrientation(space)
    rotation = rotateAxis.inverse() * rotationScale.rotation(asQuaternion=True)

    nodeFn.setTranslation(translation, space)
    nodeFn.setRotation(rotation, space)
    nodeFn.setScale(rotationScale.scale(space))


def gizmoChange(msg, plug, otherPlug, data):
    if msg & om.MNodeMessage.kAttributeSet:
        gizmoMat = om.MMatrix(proxy.plug(f"{data['gizmo']}.worldMatrix[0]").get())
        for ctrl, offset in zip(data["controls"], data["offsets"]):
            setWorldMatrixWithoutUndo(ctrl, offset*gizmoMat)

    
def removeGizmoCallback(callbackId):
    """Remove the gizmo attribute callback and persistent selection scriptJob (scene change)."""
    om.MMessage.removeCallback(callbackId)


def makeGizmo():
    selected = cmds.ls(sl=True, type="transform", long=True) or []
    if not selected:
        cmds.warning("Select controls")
        return

    # Apply parent matrices first so descendants are moved only once.
    selected.sort(key=lambda path: path.count("|"))

    if cmds.objExists(NAME):
        cmds.delete(NAME)

    center = om.MVector()
    for ctrl in selected:
        center += om.MVector(cmds.xform(ctrl, q=True, ws=True, t=True))
    center /= len(selected)
    
    gizmo = cmds.createNode("transform", n=NAME)
    proxy.node(gizmo).hiddenInOutliner.set(True)

    gizmoNode = proxy.node(gizmo)
    gizmoPath = gizmoNode.mdagpath
    gizmoNode.mfn().setTranslation(center, om.MSpace.kWorld) # set pos without undo
    
    gizmoInverse = om.MMatrix(proxy.plug(f"{gizmo}.worldInverseMatrix[0]").get())
    offsets = [om.MMatrix(proxy.plug(f"{ctrl}.worldMatrix[0]").get()) * gizmoInverse for ctrl in selected]
    
    data = {"gizmo": gizmo, "controls": selected, "offsets": offsets}
    callbackId = om.MNodeMessage.addAttributeChangedCallback(gizmoPath.node(), gizmoChange, data)
    
    cmds.scriptJob(e=["NewSceneOpened", lambda *args: removeGizmoCallback(callbackId)], ro=True)
    cmds.scriptJob(e=["SceneOpened", lambda *args: removeGizmoCallback(callbackId)], ro=True)
    
    cmds.setToolTo('moveSuperContext')
    print("Gizmo created")
