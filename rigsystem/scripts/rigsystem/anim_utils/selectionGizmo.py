import maya.cmds as cmds
import pymel.core as pm
   
NAME = "selectionGizmo"

def setWorldMatrixWithoutUndo(node, wm):
    nodePath = node.__apimdagpath__()
    lm = wm * nodePath.exclusiveMatrixInverse() # make local matrix    
    
    if isinstance(node, pm.nt.Joint):
        joInv = node.getOrientation().asMatrix().inverse()
        m = lm * joInv # consider jointOrient if any
        m.a30 = lm.a30
        m.a31 = lm.a31
        m.a32 = lm.a32
    else:
        m = lm        
    
    pm.api.MFnTransform(nodePath).set(pm.api.MTransformationMatrix(m)) 

def gizmoChange(msg, plug, otherPlug, data):
    if msg & pm.api.MNodeMessage.kAttributeSet:
        gizmoMat = data["gizmo"].wm.get()
        for ctrl, offset in zip(data["controls"], data["offsets"]):
            setWorldMatrixWithoutUndo(ctrl, offset*gizmoMat)
    
def removeGizmoCallback(callbackId):
    """Remove the gizmo attribute callback and persistent selection scriptJob (scene change)."""
    pm.api.MMessage.removeCallback(callbackId)

def makeGizmo():
    selected = pm.selected(type="transform")
    if not selected:
        pm.warning("Select controls")
        return

    if pm.objExists(NAME):
        pm.delete(NAME)

    center = pm.dt.Vector()
    for ctrl in selected:
        center += ctrl.getTranslation("world")
    center /= len(selected)
    
    gizmo = pm.createNode("transform", n=NAME)
    gizmo.hiddenInOutliner.set(True)

    pm.api.MFnTransform(gizmo.__apimdagpath__()).setTranslation(center, pm.api.MSpace.kWorld) # set pos without undo
    
    offsets = [ctrl.wm.get() * gizmo.wim.get() for ctrl in selected]
    
    data = {"gizmo": gizmo, "controls": selected, "offsets": offsets}
    callbackId = pm.api.MNodeMessage.addAttributeChangedCallback(gizmo.__apimobject__(), gizmoChange, data)
    
    pm.scriptJob(e=["NewSceneOpened", pm.Callback(removeGizmoCallback, callbackId)], ro=True)
    pm.scriptJob(e=["SceneOpened", pm.Callback(removeGizmoCallback, callbackId)], ro=True)
    
    cmds.setToolTo('moveSuperContext')
    print("Gizmo created")

