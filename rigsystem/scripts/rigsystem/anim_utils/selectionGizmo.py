import maya.cmds as cmds
import maya.api.OpenMaya as om
import maya.api.OpenMayaAnim as oma

from rigsystem import proxy
   
NAME = "selectionGizmo"

def setWorldMatrixWithoutUndo(node, wm):
    nodePath = proxy.node(node).dagPath
    lm = om.MMatrix(wm) * nodePath.exclusiveMatrixInverse() # make local matrix
    
    if cmds.nodeType(node) == "joint":
        joInv = oma.MFnIkJoint(nodePath).orientation(asQuaternion=True).asMatrix().inverse()
        m = lm * joInv # consider jointOrient if any
        m[12], m[13], m[14] = lm[12], lm[13], lm[14]
    else:
        m = lm        
    
    om.MFnTransform(nodePath).setTransformation(om.MTransformationMatrix(m))


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

    if cmds.objExists(NAME):
        cmds.delete(NAME)

    center = om.MVector()
    for ctrl in selected:
        center += om.MVector(cmds.xform(ctrl, q=True, ws=True, t=True))
    center /= len(selected)
    
    gizmo = cmds.createNode("transform", n=NAME)
    proxy.node(gizmo).hiddenInOutliner.set(True)

    gizmoPath = proxy.node(gizmo).dagPath
    om.MFnTransform(gizmoPath).setTranslation(center, om.MSpace.kWorld) # set pos without undo
    
    gizmoInverse = om.MMatrix(proxy.plug(f"{gizmo}.worldInverseMatrix[0]").get())
    offsets = [om.MMatrix(proxy.plug(f"{ctrl}.worldMatrix[0]").get()) * gizmoInverse for ctrl in selected]
    
    data = {"gizmo": gizmo, "controls": selected, "offsets": offsets}
    callbackId = om.MNodeMessage.addAttributeChangedCallback(gizmoPath.node(), gizmoChange, data)
    
    cmds.scriptJob(e=["NewSceneOpened", lambda *args: removeGizmoCallback(callbackId)], ro=True)
    cmds.scriptJob(e=["SceneOpened", lambda *args: removeGizmoCallback(callbackId)], ro=True)
    
    cmds.setToolTo('moveSuperContext')
    print("Gizmo created")

