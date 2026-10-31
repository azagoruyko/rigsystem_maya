<module name="SkinControl" muted="0" uid="0f7c32b1393e4939aba1963e961af702">
<run><![CDATA[import maya.api.OpenMaya as om
import maya.cmds as cmds
import maya.mel as mel
from rigsystem import proxy

mesh = proxy.node(@mesh)
control = proxy.node(@control)

if not mesh or not control:
    error("Set a mesh transform and a control transform.")

mesh_shapes = mesh.getShapes(type="mesh", noIntermediate=True)
if not mesh_shapes:
    error("Mesh input has no visible mesh shape.")

source_skin = next((
    node for node in cmds.listHistory(str(mesh_shapes[0])) or []
    if cmds.nodeType(node) == "skinCluster"
), None)
if not source_skin:
    error("Input mesh is not skinned.")

influences = cmds.skinCluster(source_skin, query=True, influence=True) or []
if not influences:
    error("Source skinCluster has no influences.")

control_name = control.localName()
control_matrix = cmds.xform(str(control), query=True, worldSpace=True, matrix=True)

plane = cmds.polyPlane(
    name=control_name + "_skinPlane",
    width=1,
    height=1,
    subdivisionsX=1,
    subdivisionsY=1,
)[0]
cmds.xform(plane, worldSpace=True, matrix=control_matrix)
cmds.delete(plane, constructionHistory=True)

target_skin = cmds.skinCluster(
    influences, plane, tsb=True, name=control_name + "_skinCluster"
)[0]
cmds.copySkinWeights(
    sourceSkin=source_skin,
    destinationSkin=target_skin,
    noMirror=True,
    surfaceAssociation="closestPoint",
    influenceAssociation=["oneToOne", "name"],
)

existing_locators = set(cmds.ls(type="locator") or [])
existing_uv_pins = set(cmds.ls(type="uvPin") or [])
cmds.select(plane + ".f[0]", replace=True)
mel.eval("Rivet;")

new_locators = list(set(cmds.ls(type="locator") or []) - existing_locators)
if not new_locators:
    error("Maya Rivet command did not create a locator.")

rivet = proxy.node(new_locators[0]).getParent(fullPath=True)
rivet.rename(control_name + "_rivet")
plane | rivet
cmds.xform(str(rivet), matrix=list(om.MMatrix()))
rivet.inheritsTransform.set(False)

new_uv_pins = sorted(set(cmds.ls(type="uvPin") or []) - existing_uv_pins)

for index, uv_pin in enumerate(new_uv_pins):
    suffix = "" if index == 0 else str(index + 1)
    cmds.rename(uv_pin, control_name + "_uvPin" + suffix)

control_parent = control.getParent()
attachment = proxy.create(
    "transform", control_name + "_skinned"
)
cmds.matchTransform(str(attachment), str(control))
attachment | control

if control_parent:
    cmds.parent(str(attachment), str(control_parent))

cmds.parentConstraint(str(rivet), str(attachment), maintainOffset=True)]]></run>
<doc><![CDATA[## Summary
Creates a small plane at the control's current world position, skins it to the source mesh influences, copies the skin weights, then uses Maya's Rivet command to create a surface locator. A parentConstraint drives an offset group above the control from that locator.

## Inputs
- **mesh**: Transform of the skinned polygon mesh.
- **control**: Transform to attach to the skinned surface.

## Outputs
- **Plane and skinCluster**: The control-named plane carries copied weights from the source mesh.
- **Rivet locator**: Created by Maya's Rivet command and renamed to `<control>_rivet`.
- **UV pin**: Created by the Rivet command and renamed to `<control>_uvPin`.
- **Attachment group and constraint**: A group above the control is driven by `<control>_rivet_parentConstraint`. The group's original parent and the control's world transform are preserved.

## Usage
Set the `mesh` and `control` inputs, then run the module. The control remains under its attachment group and follows the rivet locator as the skinned plane deforms.]]></doc>
<attributes>
<attr name="mesh" template="lineEditAndButton" category="Inputs" connect=""><![CDATA[{"value": "Cloth_geo", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="control" template="lineEditAndButton" category="Inputs" connect=""><![CDATA[{"value": "pCube1", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>