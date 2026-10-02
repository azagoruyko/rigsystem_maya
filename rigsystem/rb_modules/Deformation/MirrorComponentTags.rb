<module name="MirrorComponentTags" muted="0" uid="782551aa058e4467979b60c2e3d5a5d0">
<run><![CDATA[import pymel.core as pm
import maya.api.OpenMaya as om
from rig_utils import naming

def getShape(geo):
    return next((shape for shape in (pm.listRelatives(geo, shapes=True) or []) if not shape.intermediateObject.get()), None)

def getMDagPath(node):
    """Returns MDagPath for a given node name."""
    sel = om.MSelectionList()
    sel.add(str(node))
    return sel.getDagPath(0)

def mirrorComponentTag(srcMesh, srcTag, destMesh, destTag):
    """Mirrors component membership from srcTag on srcMesh to destTag on destMesh."""
    srcShape = getShape(srcMesh)
    destShape = getShape(destMesh)

    if not srcShape or not destShape:
        error("Source or destination mesh shape was not found.")

    if not srcTag:
        error("Please specify a source component tag.")
        return False
    if not destTag:
        error("Please specify a destination component tag.")
        return False

    vtxIndices = pm.geometryAttrInfo(f"{srcShape}.outMesh", componentTagExpression=srcTag, pointIndices=True, castToVerts=True)
    if not vtxIndices:
        error(f"Tag '{srcTag}' not found or contains no vertices on '{srcShape}'.")
        return False

    srcDag = getMDagPath(srcShape)
    destDag = getMDagPath(destShape)

    srcMeshFn = om.MFnMesh(srcDag)
    destMeshFn = om.MFnMesh(destDag)

    meshIntersector = om.MMeshIntersector()
    meshIntersector.create(destDag.node(), destDag.inclusiveMatrix())

    destVtxComponents = []

    gMainProgressBar = pm.mel.eval("$tmpVar=$gMainProgressBar")
    pm.progressBar(gMainProgressBar, e=True, beginProgress=True, isInterruptable=False,
                     status=f"Mirroring tag '{srcTag}' -> '{destTag}'", maxValue=max(1, len(vtxIndices)))

    srcPoints = srcMeshFn.getPoints(om.MSpace.kWorld)
    for stepCounter, vIdx in enumerate(vtxIndices, 1):
        if stepCounter % 100 == 0:
            pm.progressBar(gMainProgressBar, e=True, progress=stepCounter)

        if srcPoints[vIdx].x < -1e-5:
            continue

        mirroredPt = om.MPoint(srcPoints[vIdx])
        mirroredPt.x *= -1.0

        poim = meshIntersector.getClosestPoint(mirroredPt)
        
        faceVtxs = destMeshFn.getPolygonVertices(poim.face)
        bestVtx = min(faceVtxs, key=lambda v: destMeshFn.getPoint(v, om.MSpace.kWorld).distanceTo(mirroredPt))
        destVtxComponents.append(f"{destShape}.vtx[{bestVtx}]")

    pm.progressBar(gMainProgressBar, e=True, endProgress=True)

    if not destVtxComponents:
        warning("No destination vertices were found for the source tag.")
        return False

    mode = "replace"
    tags = pm.geometryAttrInfo(str(destShape.outMesh), componentTagNames=True) or []
    if srcTag == destTag and srcShape == destShape:
        mode = "add"

    elif destTag not in tags:
        pm.componentTag(str(destShape), cr=True, ntn=destTag)

    pm.componentTag(destVtxComponents, modify=mode, tagName=destTag)

    print(f"Successfully mirrored component tag '{srcTag}' -> '{destTag}' on '{destShape}'.")
    return True

srcMesh = @srcMesh.strip()
srcTag = @srcTag.strip()
destMesh = @destMesh.strip() or srcMesh
if not srcMesh:
    error("Specify a source mesh.")
if not srcTag:
    error("Specify a source component tag.")
if not pm.objExists(srcMesh) or not pm.objExists(destMesh):
    error("Source or destination mesh does not exist.")

destTag = @destTag.strip() or naming.findSymmetricName(srcTag)
mirrorComponentTag(srcMesh, srcTag, destMesh, destTag)
]]></run>
<doc><![CDATA[## Summary
Mirrors the positive-X vertices of a source component tag onto a destination mesh by finding the nearest destination vertex at each mirrored position. It creates or updates the destination component tag.

## Inputs
- **`srcMesh`**: Source mesh transform. Use **Set selected** to capture a selected mesh.
- **`srcTag`**: Source component tag. Click **List source tags** after setting the source mesh to fill the dropdown.
- **`destMesh`**: Destination mesh transform. Leave blank to use the source mesh.
- **`destTag`**: Destination component tag name. Leave blank to use the symmetric name suggested by `rig_utils.naming.findSymmetricName`.

## Outputs
- Creates or updates the destination mesh's component tag in the Maya scene. When the source and destination tag and shape are the same, mirrored vertices are added to the existing tag.

## Usage
1. Set `srcMesh`, click **List source tags**, and choose `srcTag`.
2. Set `destMesh` and `destTag` if you do not want the defaults.
3. Run the module, inspect the destination tag, and save the scene when correct.]]></doc>
<attributes>
<attr name="srcMesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Source mesh", "buttonCommand": "import pymel.core as pm\nselection = pm.ls(sl=True, type=\"transform\")\nif selection:\n    value = selection[0].name()", "buttonLabel": "Set selected", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="srcTag" template="comboBox" category="General" connect=""><![CDATA[{"items": [], "current": "", "default": "current"}]]></attr>
<attr name="refreshSrcTags" template="button" category="General" connect=""><![CDATA[{"command": "import pymel.core as pm\n\nmeshName = ch(\"/srcMesh\").strip()\nif not meshName:\n    error(\"Specify a source mesh before listing its component tags.\")\nif not pm.objExists(meshName):\n    error(\"Source mesh '{0}' does not exist.\".format(meshName))\n\nshapes = pm.listRelatives(meshName, shapes=True, noIntermediate=True) or []\nif not shapes:\n    error(\"No mesh shape found under '{0}'.\".format(meshName))\n\ntags = pm.geometryAttrInfo(str(shapes[0].outMesh), componentTagNames=True) or []\nchset(\"/srcTag\", tags, \"items\")\nchset(\"/srcTag\", tags[0] if tags else \"\")\nif not tags:\n    warning(\"No component tags found on '{0}'.\".format(meshName))\n", "label": "List source tags", "color": "", "default": "command"}]]></attr>
<attr name="destMesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Blank uses source mesh", "buttonCommand": "import pymel.core as pm\nselection = pm.ls(sl=True, type=\"transform\")\nif selection:\n    value = selection[0].name()", "buttonLabel": "Set selected", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="destTag" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Blank uses symmetric source tag name", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>