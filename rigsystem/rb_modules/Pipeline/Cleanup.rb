<module name="Cleanup" muted="0" uid="7c43912840ca4115857564fb77efbd8c">
<doc><![CDATA[## Summary
The **Cleanup** module tidies a Maya scene after rig generation. It removes unused namespaces, locks or hides unnecessary control attributes, deletes specified node types, clears animation curves, and can report or delete orphaned geometry. The module also organizes remaining controls into a standard rig display hierarchy.

## Inputs
- **`mode`** (`radioButton`):  
  *Helpers* – prepares UI helpers (no cleanup performed).  
  *Run* – executes all cleanup actions.  
- **`keepNamespaces`** (`listBox`):  
  List of namespace names that should **not** be removed during the cleanup.  
- **`removeNodeTypes`** (`listBox`):  
  Node type names (e.g., `ngSkinLayerData`, `ngSkinLayerDisplay`, `ngst2SkinLayerData`, `unknown`) that the module will delete from the scene.

## Outputs
The module does **not** create new nodes or data containers; it performs in‑place modifications to the current Maya scene. After execution, the scene will have:
- Unused namespaces removed (except those in `keepNamespaces`).
- Unnecessary control attributes locked or hidden.
- Specified node types deleted.
- Animation curves (`animCurveTL`, `animCurveTA`, `animCurveTT`, `animCurveTU`) removed.
- Orphaned geometry reported or deleted via the `findUnusedGeo` child module.

## Usage
1. **Configure the module**  
   - Set `mode` to **Run** to perform cleanup.  
   - Add any namespaces that must be preserved to `keepNamespaces`.  
   - Add any node types that should be purged to `removeNodeTypes`.  
2. **Execute**  
   - Run the module. It will sequentially execute its child modules:  
     - `deleteReferences` – removes unused namespaces.  
     - `lockNodes` – locks or hides control attributes and organizes display groups.  
     - `removeNodeTypes` – deletes the specified node types.  
     - `removeAnimCurves` – clears animation curves.  
     - `findUnusedGeo` – reports or deletes orphaned geometry (optional).  
3. **Verify**  
   - Inspect the scene hierarchy to confirm that unwanted nodes are gone and controls are properly locked/hidden.  
   - Use the `findUnusedGeo` module separately if you need to audit or clean up unused geometry before or after the main cleanup.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="keepNamespaces" template="listBox" category="General" connect=""><![CDATA[{"items": ["mouth"], "default": "items"}]]></attr>
<attr name="removeNodeTypes" template="listBox" category="General" connect=""><![CDATA[{"items": ["ngst2MeshDisplay", "ngst2SkinLayerData", "unknown", "nodeGraphEditorInfo"], "default": "items"}]]></attr>
</attributes>
<children>
<module name="importReferences" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
import maya.cmds as cmds

keepNamespaces = ch("../keepNamespaces")

allowed_namespaces = ["UI", "shared"] + keepNamespaces

def importAllReferences():
    references = cmds.file(q=True,r=True)
    while references:
        for ref in references:
            cmds.file(ref,ir=True)
        references = cmds.file(q=True,r=True)

def get_namespaces():
    return [str(ns) for ns in cmds.namespaceInfo(listOnlyNamespaces=True)]

def removeNamespaces():
    cmds.namespace(set=":")
    namespaces = [ns for ns in get_namespaces() if ns not in allowed_namespaces]
    if not namespaces:
        return

    for item in namespaces:
        cmds.namespace(mv=(item, ":"), f=True)
        cmds.namespace(rm=item, f=True)

    remaining = [ns for ns in get_namespaces() if ns not in allowed_namespaces]
    if remaining and len(remaining) < len(namespaces):
        removeNamespaces()

importAllReferences()
removeNamespaces()]]></run>
</module>
<module name="lockNodes" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
import rig_utils

pm.delete(pm.ls(type="dagPose"))

for obj in pm.ls(type="joint"):
    obj.radius.showInChannelBox(False)

    if not obj.jointOrient.inputs():
        obj.jointOrient.setLocked(True)

for obj in pm.ls(type="skinCluster"):
    for a in obj.listAttr():
        if not a.isConnected():
            a.setLocked(True)

for obj in pm.ls(type="mesh"):
    obj.primaryVisibility.set(True)
    obj.castsShadows.set(True)
    obj.receiveShadows.set(True)
    obj.motionBlur.set(True)
    obj.visibleInReflections.set(True)
    obj.visibleInRefractions.set(True)

    v = pm.displaySmoothness(obj, q=True, polygonObject=True)
    if v and v[0] > 1:
        pm.displaySmoothness(obj, divisionsU=0, divisionsV=0, pointsWire=4, pointsShaded=1, polygonObject=1)        

for ik in pm.ls(type="ikHandle"):
    if type(ik.ikSolver.get()) == pm.nt.IkSplineSolver:
        for a in ["dTwistControlEnable","dWorldUpAxis","dWorldUpType"]:
            ik.attr(a).lock()

for n in ["skeleton", "internal", "geometry", "others"]:
    pm.PyNode(n).overrideEnabled.set(1)
    pm.PyNode(n).overrideDisplayType.set(2)

pm.PyNode("skeleton").v.set(False)
pm.PyNode("internal").v.set(False)  
    
if pm.objExists("helpers"):
    pm.delete("helpers")
    
# hide root joints
for j in ["root", "root_joint"]:
    if pm.objExists(j):
        pm.PyNode(j).v.set(False)

# lock pivots
for ctrl in pm.ls("*_control"):
    rig_utils.lockAttr(ctrl.rotatePivot,1)
    rig_utils.lockAttr(ctrl.rotatePivotTranslate,1)
    rig_utils.lockAttr(ctrl.scalePivotTranslate,1)
    rig_utils.lockAttr(ctrl.scalePivot,1)
    ]]></run>
</module>
<module name="removeNodeTypes" muted="0" uid="">
<run><![CDATA[import pymel.core as pm

nodeTypes = ch("../removeNodeTypes")

for nt in nodeTypes:
    pm.delete(pm.ls(type=nt))]]></run>
</module>
<module name="removeAnimCurves" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
pm.delete(pm.ls(type=["animCurveTL", "animCurveTA", "animCurveTT", "animCurveTU"]))]]></run>
</module>
<module name="findUnusedGeo" muted="0" uid="e705e52bf9284751a7ca2ce039a24722">
<run><![CDATA[import pymel.core as pm

out = []

if @nurbs:
    for typ in ["nurbsSurface", "nurbsCurve"]:
        for n in pm.ls(type="nurbsSurface"):
            if not n.create.inputs() and not n.local.outputs() and not n.worldSpace.outputs() and n.intermediateObject.get():
                out.append(n.name())

if @mesh:    
    for n in pm.ls(type="mesh"):
        if not n.inMesh.inputs() and not n.outMesh.outputs() and not n.worldMesh.outputs() and n.intermediateObject.get():
            out.append(n.name())

if out:
    print(out)
    if @remove:
        pm.delete(out)
    else:
        pm.select(out)    ]]></run>
<doc><![CDATA[## Summary
Finds and optionally removes unused geometry nodes (nurbs surfaces, curves, or meshes) that are marked as intermediate objects and have no connections to other nodes. The module reports the names of these nodes, selects them in the scene, or deletes them if the **Remove** option is enabled.

## Inputs
- **`nurbs`** (`checkBox`): When checked, the module searches for unused **nurbsSurface** and **nurbsCurve** nodes.
- **`mesh`** (`checkBox`): When checked, the module searches for unused **mesh** nodes.
- **`remove`** (`checkBox`): When checked, the identified unused nodes are deleted from the scene; otherwise they are simply selected.

## Outputs
- **Console Output**: Prints a list of the names of all unused geometry nodes found.
- **Scene Selection**: If `remove` is unchecked, the nodes are selected in the viewport.
- **Deletion**: If `remove` is checked, the nodes are permanently removed from the scene.

## Usage
1. Open the module in Rig Builder and enable the **Nurbs** and/or **Mesh** checkboxes to specify which geometry types to scan.
2. Optionally check **Remove** if you want the module to delete the unused nodes automatically.
3. Execute the module. The console will display the list of unused geometry names; the nodes will be selected or deleted based on the `remove` setting.]]></doc>
<attributes>
<attr name="nurbs" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="mesh" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="remove" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
</attributes>
</module>
<module name="blockGPU" muted="0" uid="">
<run><![CDATA[import pymel.core as pm

# prevent some nodes to be processed on GPU due to Maya 2026 crashes with Delta Mush
for n in pm.ls(type=@nodeTypes):
    n.blockGPU.set(True)]]></run>
<attributes>
<attr name="nodeTypes" template="listBox" category="General" connect=""><![CDATA[{"items": ["deltaMush"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="findDuplicateNames" muted="0" uid="6408d318d1d345e3950dd96011986644">
<run><![CDATA[import maya.cmds as cmds

nodesByName = {}
for node in cmds.ls(long=True) or []:
    name = node.rsplit("|", 1)[-1]
    nodesByName.setdefault(name, []).append(node)

for name, nodes in sorted(nodesByName.items()):
    if len(nodes) > 1:
        warning("Duplicate name '{}'".format(name))
]]></run>
<doc><![CDATA[## Summary
This module scans the current Maya scene for duplicate node names and logs a warning for each name that appears more than once. It serves as a quick integrity check to help prevent naming conflicts before building rigs or other scene elements.

## Inputs
- **None** – The module operates on the entire scene without requiring any user-specified parameters.

## Outputs
- **Warnings** – For each duplicated short name, a warning message is emitted using the `warning()` API. No new nodes or data structures are created.

## Usage
1. Load the module into Rig Builder and execute it.  
2. Review the output log for any warning messages indicating duplicate names.  
3. Resolve the duplicates in Maya (e.g., rename or delete redundant nodes) before proceeding with rig construction or other automated processes.]]></doc>
</module>
</children>
</module>