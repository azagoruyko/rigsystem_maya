<module name="CombineSkinnedMeshes" muted="0" uid="631d966020084cd3af2e9802447454e6">
<run><![CDATA[import pymel.core as pm

resultName = "combinedSkinnedMesh"


def _getMeshShapeFromNode(node):
    if pm.nodeType(node) == "mesh":
        return pm.PyNode(node)

    shapes = pm.listRelatives(node, shapes=True, fullPath=True) or []
    meshShapes = [shape for shape in shapes if pm.nodeType(shape) == "mesh"]
    if not meshShapes:
        return None

    nonIntermediate = [
        shape for shape in meshShapes
        if not shape.intermediateObject.get()
    ]
    return nonIntermediate[0] if nonIntermediate else meshShapes[0]


def _getSkinClusterFromMesh(meshShape):
    history = pm.listHistory(meshShape) or []
    skinClusters = pm.ls(history, type="skinCluster") or []
    return skinClusters[0] if skinClusters else None


def _getInfluencesFromSkin(skinCluster):
    try:
        influences = pm.skinCluster(skinCluster, query=True, influence=True) or []
    except Exception:
        influences = pm.listConnections(
            "{0}.matrix".format(skinCluster),
            source=True,
            destination=False
        ) or []
    existing = [influence for influence in influences if pm.objExists(influence)]
    if len(existing) != len(influences):
        missing = [influence for influence in influences if influence not in existing]
        if missing:
            warning(
                "Missing influences were skipped: {0}".format(", ".join(str(influence) for influence in missing))
            )
    return existing
def _getMaxInfluences(skinCluster):
    try:
        return int(pm.getAttr("{0}.maxInfluences".format(skinCluster)))
    except Exception:
        return 1


def _getUniqueName(baseName):
    if not pm.objExists(baseName):
        return baseName
    index = 1
    while True:
        candidate = "{0}_{1}".format(baseName, index)
        if not pm.objExists(candidate):
            return candidate
        index += 1



def _collectSourceInfos(selection):
    sourceInfos = []
    meshTransforms = []
    maxInfluences = 1
    totalVertexCount = 0

    for node in selection:
        meshShape = _getMeshShapeFromNode(node)
        if not meshShape:
            continue

        skinCluster = _getSkinClusterFromMesh(meshShape)
        if not skinCluster:
            warning("Mesh has no skinCluster: {0}".format(meshShape))
            continue

        influences = _getInfluencesFromSkin(skinCluster)
        if not influences:
            error("SkinCluster has no influences: {0}".format(meshShape))

        meshTransform = pm.listRelatives(meshShape, parent=True, fullPath=True)[0]
        meshTransforms.append(meshTransform)
        maxInfluences = max(maxInfluences, _getMaxInfluences(skinCluster))

        vertexCount = pm.polyEvaluate(meshShape, vertex=True)
        totalVertexCount += vertexCount
        sourceInfos.append({
            "meshShape": meshShape,
            "meshTransform": meshTransform,
            "influences": influences,
            "vertexCount": vertexCount,
        })

    return {
        "sourceInfos": sourceInfos,
        "meshTransforms": meshTransforms,
        "maxInfluences": maxInfluences,
        "totalVertexCount": totalVertexCount,
    }


def combineSkinnedMeshes(
    selection,
    keepSources=False
):
    """
    Combine skinned meshes into a single mesh and transfer weights to the combined skin.
    """
    selection = selection or pm.selected()
    if not selection:
        error("No mesh inputs provided.")

    collectData = _collectSourceInfos(selection)
    sourceInfos = collectData["sourceInfos"]
    meshTransforms = collectData["meshTransforms"]
    maxInfluences = collectData["maxInfluences"]
    totalVertexCount = collectData["totalVertexCount"]

    if len(meshTransforms) < 2:
        error("Select at least two skinned meshes.")

    combineTransforms = meshTransforms
    duplicateNames = []
    if keepSources:
        dupRoots = []
        for meshTransform in meshTransforms:
            dup = pm.duplicate(
                meshTransform,
                returnRootsOnly=True,
                inputConnections=False,
                renameChildren=True
            ) or []
            if not dup:
                continue
            dupRoot = dup[0]
            if pm.nodeType(dupRoot) != "transform":
                continue
            dupShapes = pm.listRelatives(dupRoot, shapes=True, fullPath=True) or []
            intermediateShapes = [
                shape for shape in dupShapes
                if shape.intermediateObject.get()
            ]
            if intermediateShapes:
                pm.delete(intermediateShapes)
            dupRoots.append(dupRoot)
            duplicateNames.append(dupRoot.longName())

        if not dupRoots:
            error("No mesh transforms found in duplicated sources.")

        combineTransforms = dupRoots
    combineShapes = []
    for transform in combineTransforms:
        meshShape = _getMeshShapeFromNode(transform)
        if meshShape:
            combineShapes.append(meshShape)

    if not combineShapes:
        error("No mesh shapes found for combine.")
    expectedVtxCount = totalVertexCount
    combined = pm.polyUnite(combineShapes, ch=False, mergeUVSets=True)[0]
    combinedShape = _getMeshShapeFromNode(combined)
    combinedVtxCount = pm.polyEvaluate(combinedShape, vertex=True)

    if combinedVtxCount != expectedVtxCount:
        pm.delete(combined)
        combined = pm.polyUnite(combineTransforms, ch=False, mergeUVSets=True)[0]
        combinedShape = _getMeshShapeFromNode(combined)
        combinedVtxCount = pm.polyEvaluate(combinedShape, vertex=True)

    if combinedVtxCount != expectedVtxCount:
        pm.delete(combined)
        error("Combined vertex count does not match the source meshes.")

    combined = pm.rename(combined, _getUniqueName(resultName))
    uniqueInfluences = []
    for info in sourceInfos:
        for influence in info["influences"]:
            if influence not in uniqueInfluences:
                uniqueInfluences.append(influence)

    pm.skinCluster(
        uniqueInfluences,
        combined,
        toSelectedBones=True,
        bindMethod=0,
        normalizeWeights=2, # post
        maximumInfluences=maxInfluences,
        obeyMaxInfluences=True,
    )

    vertexOffset = 0
    beginProgress("Copying skin weights...", len(sourceInfos))
    try:
        for index, info in enumerate(sourceInfos):
            sourceShape = info["meshShape"]
            if not pm.objExists(sourceShape):
                vertexOffset += info["vertexCount"]
                stepProgress(index + 1)
                continue

            sourceTransform = info["meshTransform"]
            vertexCount = info["vertexCount"]
            startIndex = vertexOffset
            endIndex = vertexOffset + vertexCount - 1
            combinedComponent = "{0}.vtx[{1}:{2}]".format(
                combined, startIndex, endIndex
            )

            pm.copySkinWeights(
                sourceTransform,
                combinedComponent,
                noMirror=True,
                surfaceAssociation="closestPoint",
                influenceAssociation=["oneToOne", "closestJoint"],
            )

            vertexOffset += vertexCount
            stepProgress(index + 1)
    finally:
        endProgress()

    if keepSources:
        remainingDuplicates = [name for name in duplicateNames if pm.objExists(name)]
        if remainingDuplicates:
            pm.delete(remainingDuplicates)
    else:
        pm.delete(meshTransforms)

    pm.select(combined, replace=True)

    return combined

combined = combineSkinnedMeshes(
    @meshes,
    keepSources=@keepSources,
)
]]></run>
<doc><![CDATA[## Summary
Combines two or more skinned meshes into a single mesh while preserving all skin weights and influences. The module optionally keeps the original meshes or duplicates them before merging, and it automatically creates a new skinCluster on the combined mesh that matches the maximum influence count of the source meshes.

## Inputs
- **`meshes`** – A list of mesh transforms or shapes that already have a skinCluster. At least two meshes must be selected; otherwise the module will error.
- **`keepSources`** – Boolean flag. If `True`, the original meshes are duplicated and retained after the merge; if `False`, the original meshes are deleted once the combined mesh is created.

## Outputs
- **Combined mesh node** – A new transform node (default name `combinedSkinnedMesh`, uniquified if needed) that contains the merged geometry and a skinCluster with all unique influences from the source meshes. The module selects this node in the scene and returns it.

## Usage
1. Select at least two skinned meshes in the scene.  
2. Set the `keepSources` attribute to `True` if you want to preserve the originals, or leave it `False` to delete them after merging.  
3. Execute the module. It will duplicate the sources if requested, merge the geometry, create a new skinCluster with the correct influence count, copy all skin weights, and finally delete the source meshes (or their duplicates).  
4. The resulting combined mesh will be selected and can be used for further rigging or deformation work.]]></doc>
<attributes>
<attr name="meshes" template="listBox" category="General" connect=""><![CDATA[{"items": ["pCube1", "pSphere1"], "default": "items"}]]></attr>
<attr name="keepSources" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
</attributes>
</module>