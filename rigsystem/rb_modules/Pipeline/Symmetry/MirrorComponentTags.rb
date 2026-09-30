<module name="mirrorComponentTags" muted="0" uid="52d9a9a2cf4043e6a43708dd4e4fb98b">
<run><![CDATA[import maya.cmds as cmds
import maya.api.OpenMaya as om
import rig_utils

def getShape(geo):
    if not geo or not cmds.objExists(geo):
        return None
    shapes = cmds.listRelatives(geo, s=True, f=True) or []
    return next((s for s in shapes if not cmds.getAttr(s + ".intermediateObject")), None)

def getMDagPath(node):
    sel = om.MSelectionList()
    sel.add(node)
    return sel.getDagPath(0)

def mirrorComponentTag(srcMesh, srcTag, destMesh, destTag):
    srcShape = getShape(srcMesh)
    if not srcShape:
        warning(f"mirrorComponentTags: Source mesh '{srcMesh}' or its shape does not exist.")
        return False

    destMesh = destMesh or srcMesh
    destShape = getShape(destMesh)
    if not destShape:
        warning(f"mirrorComponentTags: Destination mesh '{destMesh}' or its shape does not exist.")
        return False

    if not srcTag:
        warning("mirrorComponentTags: Please specify a source component tag.")
        return False

    if not destTag:
        destTag = rig_utils.naming.findSymmetricName(srcTag)
        if not destTag or destTag == srcTag:
            if srcShape != destShape:
                destTag = srcTag

    if not destTag:
        warning(f"mirrorComponentTags: Could not determine destination component tag for '{srcTag}'.")
        return False

    vtxIndices = cmds.geometryAttrInfo(f"{srcShape}.outMesh", componentTagExpression=srcTag, pointIndices=True, castToVerts=True)
    if not vtxIndices:
        warning(f"mirrorComponentTags: Tag '{srcTag}' not found or contains no vertices on '{srcShape}'.")
        return False

    srcDag = getMDagPath(srcShape)
    destDag = getMDagPath(destShape)

    srcMeshFn = om.MFnMesh(srcDag)
    destMeshFn = om.MFnMesh(destDag)

    meshIntersector = om.MMeshIntersector()
    meshIntersector.create(destDag.node(), destDag.inclusiveMatrix())

    destVtxComponents = []

    srcPoints = srcMeshFn.getPoints(om.MSpace.kWorld)
    beginProgress(f"Mirroring tag '{srcTag}' -> '{destTag}'", len(vtxIndices))
    try:
        for stepCounter, vIdx in enumerate(vtxIndices, 1):
            if stepCounter % 100 == 0:
                stepProgress(stepCounter)

            if srcPoints[vIdx].x < -1e-5:
                continue

            mirroredPt = om.MPoint(srcPoints[vIdx])
            mirroredPt.x *= -1.0

            poim = meshIntersector.getClosestPoint(mirroredPt)

            faceVtxs = destMeshFn.getPolygonVertices(poim.face)
            bestVtx = min(faceVtxs, key=lambda v: destMeshFn.getPoint(v, om.MSpace.kWorld).distanceTo(mirroredPt))
            destVtxComponents.append(f"{destShape}.vtx[{bestVtx}]")
    finally:
        endProgress()

    if not destVtxComponents:
        warning(f"mirrorComponentTags: No mirrored vertices found for tag '{srcTag}'.")
        return False

    mode = "replace"
    tags = cmds.geometryAttrInfo(destShape + ".outMesh", componentTagNames=True) or []
    if srcTag == destTag and srcShape == destShape:
        mode = "add"
    elif destTag not in tags:
        cmds.componentTag(destShape, cr=True, ntn=destTag)

    cmds.componentTag(destVtxComponents, modify=mode, tagName=destTag)
    print(f"Successfully mirrored component tag '{srcTag}' -> '{destTag}' on '{destShape}'.")
    return True

srcMesh = @srcMesh
if @useSelected and not srcMesh:
    sel = cmds.ls(sl=True)
    if sel:
        srcMesh = sel[0]

if not srcMesh:
    warning("mirrorComponentTags: Source Mesh is not specified.")
else:
    if @allTags or not @srcTag:
        srcShape = getShape(srcMesh)
        if srcShape:
            tags = cmds.geometryAttrInfo(f"{srcShape}.outMesh", componentTagNames=True) or []
            if not tags:
                warning(f"mirrorComponentTags: No component tags found on '{srcMesh}'.")
            for tag in tags:
                dTag = rig_utils.naming.findSymmetricName(tag) if not @destTag else @destTag
                mirrorComponentTag(srcMesh, tag, @destMesh, dTag)
    else:
        mirrorComponentTag(srcMesh, @srcTag, @destMesh, @destTag)
]]></run>
<doc><![CDATA[## Summary
Mirrors geometry component tags from a source mesh to a destination mesh, optionally across the X‑axis on the same mesh or between symmetric meshes. It can copy a single tag or all tags, automatically resolving symmetric tag names when the destination tag is omitted.

## Inputs
- **`srcMesh`** – Transform name of the source mesh that contains component tags.  
- **`srcTag`** – Specific component tag to mirror. Leave empty or enable **`allTags`** to mirror every tag found on the source mesh.  
- **`destMesh`** – Transform name of the target mesh that will receive the mirrored tags. Defaults to the source mesh if left empty.  
- **`destTag`** – Target component tag name. If omitted, the module attempts to find a symmetric name using `rig_utils.naming.findSymmetricName`.  
- **`useSelected`** – When checked and `srcMesh` is empty, the first selected object in the viewport is used as the source mesh.  
- **`allTags`** – When checked, the module processes every component tag on the source mesh instead of a single tag.

## Outputs
- The destination mesh’s component tags are updated:  
  - If the source and destination are the same mesh and the tag names match, the tag is **added** to the existing set.  
  - Otherwise, the destination tag is **replaced** or created if it does not exist.  
- A console message reports success or failure for each mirrored tag.

## Usage
1. **Set the source mesh** (`srcMesh`). If you want to use the current selection, enable **`useSelected`** and leave `srcMesh` empty.  
2. **Choose the tag(s)** to mirror:  
   - Enter a specific tag name in **`srcTag`** to mirror only that tag.  
   - Leave **`srcTag`** empty and enable **`allTags`** to mirror every tag on the source mesh.  
3. **Specify the destination**:  
   - Leave **`destMesh`** empty to mirror onto the same mesh.  
   - Provide a different mesh name to copy tags to another geometry.  
4. **Set the destination tag** (`destTag`). If left blank, the module will automatically resolve a symmetric tag name; if that fails, it will use the source tag name.  
5. **Run the module**. The script will mirror the selected tags, printing a success message for each. The destination mesh will now contain the mirrored component tags, ready for skinning, clustering, or other downstream operations.]]></doc>
<attributes>
<attr name="srcMesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Source Mesh", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="srcTag" template="lineEdit" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Source Tag (leave empty for all)", "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="destMesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Destination Mesh (same as src if empty)", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="destTag" template="lineEdit" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Destination Tag (auto-symmetric if empty)", "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="useSelected" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="allTags" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
</attributes>
<children>
</children>
</module>
