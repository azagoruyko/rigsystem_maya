<module name="CombineSkinnedMeshes" muted="0" uid="631d966020084cd3af2e9802447454e6">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds

resultName = "combinedSkinnedMesh"


def _getMeshShapeFromNode(node):
    node_name = str(node)
    if cmds.nodeType(node_name) == "mesh":
        return proxy.node(node_name)

    shapes = cmds.listRelatives(node_name, shapes=True, fullPath=True) or []
    meshShapes = [
        proxy.node(shape) for shape in shapes
        if cmds.nodeType(shape) == "mesh"
    ]
    if not meshShapes:
        return None

    nonIntermediate = [
        shape for shape in meshShapes
        if not shape.intermediateObject.get()
    ]
    return nonIntermediate[0] if nonIntermediate else meshShapes[0]


def _getSkinClusterFromMesh(meshShape):
    history = cmds.listHistory(str(meshShape)) or []
    skinClusters = cmds.ls(history, type="skinCluster") or []
    return proxy.node(skinClusters[0]) if skinClusters else None


def _getInfluencesFromSkin(skinCluster):
    try:
        influences = cmds.skinCluster(
            str(skinCluster), query=True, influence=True
        ) or []
    except RuntimeError:
        influences = cmds.listConnections(
            "{}.matrix".format(skinCluster),
            source=True,
            destination=False
        ) or []
    existingNames = [influence for influence in influences if cmds.objExists(influence)]
    existing = [proxy.node(influence) for influence in existingNames]
    if len(existingNames) != len(influences):
        missing = [influence for influence in influences if influence not in existingNames]
        if missing:
            warning(
                "Missing influences were skipped: {0}".format(", ".join(str(influence) for influence in missing))
            )
    return existing
def _getMaxInfluences(skinCluster):
    if not cmds.objExists("{}.maxInfluences".format(skinCluster)):
        return 1
    return int(cmds.getAttr("{}.maxInfluences".format(skinCluster)))


def _getUniqueName(baseName):
    if not cmds.objExists(baseName):
        return baseName
    index = 1
    while True:
        candidate = "{0}_{1}".format(baseName, index)
        if not cmds.objExists(candidate):
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

        meshTransform = cmds.listRelatives(
            str(meshShape), parent=True, fullPath=True
        )[0]
        meshTransforms.append(meshTransform)
        maxInfluences = max(maxInfluences, _getMaxInfluences(skinCluster))

        vertexCount = cmds.polyEvaluate(str(meshShape), vertex=True)
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
    selection = selection or (cmds.ls(selection=True) or [])
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
            dup = cmds.duplicate(
                str(meshTransform),
                returnRootsOnly=True,
                inputConnections=False,
                renameChildren=True
            ) or []
            if not dup:
                continue
            dupRoot = dup[0]
            if cmds.nodeType(dupRoot) != "transform":
                continue
            dupShapes = cmds.listRelatives(dupRoot, shapes=True, fullPath=True) or []
            intermediateShapes = [
                shape for shape in dupShapes
                if cmds.getAttr(shape + ".intermediateObject")
            ]
            if intermediateShapes:
                cmds.delete(intermediateShapes)
            dupRoots.append(dupRoot)
            duplicateNames.append(dupRoot)

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
    combined = cmds.polyUnite(combineShapes, ch=False, mergeUVSets=True)[0]
    combinedShape = _getMeshShapeFromNode(combined)
    combinedVtxCount = cmds.polyEvaluate(str(combinedShape), vertex=True)

    if combinedVtxCount != expectedVtxCount:
        cmds.delete(combined)
        combined = cmds.polyUnite(combineTransforms, ch=False, mergeUVSets=True)[0]
        combinedShape = _getMeshShapeFromNode(combined)
        combinedVtxCount = cmds.polyEvaluate(str(combinedShape), vertex=True)

    if combinedVtxCount != expectedVtxCount:
        cmds.delete(combined)
        error("Combined vertex count does not match the source meshes.")

    combined = cmds.rename(combined, _getUniqueName(resultName))
    uniqueInfluences = []
    for info in sourceInfos:
        for influence in info["influences"]:
            if influence not in uniqueInfluences:
                uniqueInfluences.append(influence)

    cmds.skinCluster(
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
            if not cmds.objExists(str(sourceShape)):
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

            cmds.copySkinWeights(
                str(sourceTransform),
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
        remainingDuplicates = [name for name in duplicateNames if cmds.objExists(name)]
        if remainingDuplicates:
            cmds.delete(remainingDuplicates)
    else:
        cmds.delete(meshTransforms)

    cmds.select(combined, replace=True)

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