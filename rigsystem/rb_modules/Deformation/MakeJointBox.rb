<module name="MakeJointBox" muted="0" uid="646f40fb76584fa1bd5e104aa8416978">
<run><![CDATA[import maya.cmds as cmds
import maya.mel as mel
import pymel.core as pm
import maya.api.OpenMaya as om
from rig_utils import skinCluster as skin
import math

IS_RETOPO_AVAILABLE = cmds.about(api=True) >= 20230000

def compactComponentRanges(meshName, indices, componentType='f'):
    """
    Converts a list of integer indices into a compact list of Maya component strings.
    Example: [1, 2, 3, 5, 8, 9] -> ["mesh.f[1:3]", "mesh.f[5]", "mesh.f[8:9]"]
    """
    if not indices:
        return []
    
    indices = sorted(list(indices))
    ranges = []
    start = prev = indices[0]
    
    for n in indices[1:]:
        if n == prev + 1:
            prev = n
        else:
            if start == prev:
                ranges.append("{}.{}[{}]".format(meshName, componentType, start))
            else:
                ranges.append("{}.{}[{}:{}]".format(meshName, componentType, start, prev))
            start = prev = n
            
    # Add the final range
    if start == prev:
        ranges.append("{}.{}[{}]".format(meshName, componentType, start))
    else:
        ranges.append("{}.{}[{}:{}]".format(meshName, componentType, start, prev))
        
    return ranges

  
def createMeshJointPatch(mesh, jointNames, threshold=0.1):
    """
    Create a new mesh patch from faces affected by the specified joints.
    Uses Maya API (OpenMaya) for high performance on dense meshes.
    
    Args:
        mesh (str or PyNode): The source mesh with a skinCluster.
        jointNames (list or str): A list of joint names to extract weights from.
        threshold (float): Minimum weight required to include a vertex.
        
    Returns:
        pm.nt.Transform: The created patch mesh.
    """
    # Ensure mesh is a PyNode for high-level operations
    mesh = pm.PyNode(mesh)
    if isinstance(jointNames, (str, unicode) if 'unicode' in globals() else str):
        jointNames = [jointNames]
    
    # Get skin cluster helper
    try:
        skHelper = skin.SkinClusterHelper(mesh)
    except Exception as e:
        error("No skinCluster found on {}: {}".format(mesh, e))
        return
    
    # Get all unique affected vertex indices (uses OM2 under the hood in SkinClusterHelper)
    allAffectedVtxIndices = list(set())
    skinWeights = skHelper.getSkinWeights()
    
    for jnt in jointNames:
        infIdx = skHelper.getInfluencePhysicalIndex(jnt)
        if infIdx is None:
            warning("Influence {} not found in skinCluster {}".format(jnt, skHelper.node()))
            continue
            
        vtxIndices = skinWeights.getAffectedIndices(infIdx)
        if threshold > 1e-4:
            vtxIndices = [i for i in vtxIndices if skinWeights.getVertexWeight(i, infIdx) >= threshold]
        allAffectedVtxIndices.extend(vtxIndices)
    
    allAffectedVtxIndices = list(set(allAffectedVtxIndices))
    if not allAffectedVtxIndices:
        warning("No vertices affected by {} on {}".format(jointNames, mesh))
        return
    
    # Initialize Progress UI for dense operations
    numVtx = len(allAffectedVtxIndices)
    showProgress = numVtx > 1000 # Only show if potentially slow
    
    if showProgress:
        cmds.progressWindow(title='Extracting Joint Patch', 
                            progress=0, 
                            status='Finding connected faces...', 
                            isInterruptable=True)
    
    try:
        # OPTIMIZATION: Use OpenMaya to find connected faces
        sel = om.MSelectionList()
        sel.add(mesh.name())
        dagPath = sel.getDagPath(0)
        itVtx = om.MItMeshVertex(dagPath)
        
        faceIndices = set()
        updateStepVtx = max(1, int(numVtx * 0.05)) # Update every 5%
        for i, vtxIdx in enumerate(allAffectedVtxIndices):
            if showProgress and i % updateStepVtx == 0:
                if cmds.progressWindow(query=True, isCancelled=True):
                    return
                progressValue = int((i / float(numVtx)) * 50)
                cmds.progressWindow(edit=True, progress=progressValue, status='Finding connected faces: {}/{}'.format(i, numVtx))
            
            itVtx.setIndex(vtxIdx)
            connectedFaces = itVtx.getConnectedFaces()
            faceIndices.update(connectedFaces)
        
        if not faceIndices:
            warning("No faces found for affected vertices of {}".format(jointNames))
            return
        
        # Duplicate mesh
        patchMesh = pm.duplicate(mesh, n="{}_patch".format(mesh.nodeName()))[0]
        if patchMesh.getParent():
            patchMesh.setParent(world=True)

        # Get all faces
        numFaces = patchMesh.numFaces()
        numToKeep = len(faceIndices)
        
        if numToKeep < numFaces:
            if showProgress:
                cmds.progressWindow(edit=True, progress=60, status='Compacting ranges...')
            
            # High-Performance: Select KEEP -> Invert -> Delete
            # Building a compact range string is much faster for Maya to parse than thousands of individual strings
            meshName = patchMesh.name()
            keepRanges = compactComponentRanges(meshName, faceIndices, 'f')
            
            if showProgress:
                cmds.progressWindow(edit=True, progress=85, status='Deleting unnecessary faces...')
            
            # Maya's internal inversion and deletion are extremely fast
            pm.select(keepRanges, replace=True)
            pm.mel.eval('InvertSelection;')
            pm.delete()
        
        # Cleanup history and wrap in PyNode
        pm.delete(patchMesh, ch=True)
        
        # Rename specifically if only one joint provided
        if len(jointNames) == 1:
            patchMesh.rename("{}_{}_patch".format(mesh.nodeName(), jointNames[0]))
        
        if showProgress:
            cmds.progressWindow(edit=True, progress=100, status='Patch created.')

    finally:
        if showProgress:
            cmds.progressWindow(endProgress=True)
    
    return patchMesh
    
# bounding box

def retopoMesh(mesh, targetFaceCount):
    """
    Applies Maya's polyRetopo command to the specified mesh.
    
    Args:
        mesh (PyNode): The mesh to retopologize.
        targetFaceCount (int): The desired number of faces.
    """
    cmds.polyRetopo(str(mesh), targetFaceCount=targetFaceCount)

def calculatePCA(points):
    """
    Computes Principal Component Analysis (PCA) on a set of MPoint objects.
    Returns: (eigenvectors, eigenvalues, centroid)
    Eigenvectors are returned as an MMatrix where each row is a principal axis.
    """
    numPoints = len(points)
    if numPoints < 3:
        return None, None

    # 1. Calculate Centroid (Mean)
    sumPt = om.MPoint(0, 0, 0)
    for pt in points:
        sumPt += pt
    centroid = sumPt / numPoints

    # 2. Build Covariance Matrix (3x3 symmetric)
    # cov[i][j] = sum((xi - mean_x) * (xj - mean_j)) / (N - 1)
    cov = [0.0] * 9  # 3x3 matrix as flat list
    for pt in points:
        dx = pt.x - centroid.x
        dy = pt.y - centroid.y
        dz = pt.z - centroid.z
        
        cov[0] += dx * dx # xx
        cov[1] += dx * dy # xy
        cov[2] += dx * dz # xz
        cov[4] += dy * dy # yy
        cov[5] += dy * dz # yz
        cov[8] += dz * dz # zz

    # Symmetric: xy=yx, xz=zx, yz=zy
    cov[3] = cov[1]
    cov[6] = cov[2]
    cov[7] = cov[5]
    
    # Normalize by N-1
    for i in range(9):
        cov[i] /= (numPoints - 1)

    # 3. Jacobi Eigenvalue Algorithm (Pure Python)
    # Find eigenvalues (diagonal) and eigenvectors (V matrix)
    V = [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0] # Identity
    A = list(cov)
    
    maxIterations = 50
    for _ in range(maxIterations):
        # Find the largest off-diagonal element
        p, q = 0, 1
        maxVal = abs(A[1])
        if abs(A[2]) > maxVal: p, q, maxVal = 0, 2, abs(A[2])
        if abs(A[5]) > maxVal: p, q, maxVal = 1, 2, abs(A[5])
        
        if maxVal < 1e-9: # Converged
            break
            
        # Calculate rotation angle
        # theta = 0.5 * atan(2 * Apq / (Aqq - App))
        app = A[p*3 + p]
        aqq = A[q*3 + q]
        apq = A[p*3 + q]
        
        phi = 0.5 * math.atan2(2.0 * apq, aqq - app)
        c = math.cos(phi)
        s = math.sin(phi)
        
        # Update A matrix (G^T * A * G)
        for i in range(3):
            # Update columns p and q
            aIp = A[i*3 + p]
            aIq = A[i*3 + q]
            A[i*3 + p] = c * aIp - s * aIq
            A[i*3 + q] = s * aIp + c * aIq
            
        for i in range(3):
            # Update rows p and q (symmetry means we just update A[p][i] and A[q][i])
            aPi = A[p*3 + i]
            aQi = A[q*3 + i]
            A[p*3 + i] = c * aPi - s * aQi
            A[q*3 + i] = s * aPi + c * aQi
            
        # Update V matrix (V * G)
        for i in range(3):
            vIp = V[i*3 + p]
            vIq = V[i*3 + q]
            V[i*3 + p] = c * vIp - s * vIq
            V[i*3 + q] = s * vIp + c * vIq

    # Convert back to OpenMaya types
    # Eigenvectors are columns of V
    eigenvectors = []
    for col in range(3):
        vec = om.MVector(V[col], V[col+3], V[col+6]).normal()
        eigenvectors.append(vec)
        
    return eigenvectors, centroid

def createBoundingBox(selection=None, density=1):
    """
    Creates a polyCube based strictly on the world-space positions of mesh vertices.
    Ignores transform-level bounding box attributes to ensure a tight fit to geometry.
    Uses OpenMaya for precise vertex data extraction.

    Args:
        selection (list, optional): List of Maya objects/components. Defaults to current selection.
        density (int, optional): Number of subdivisions in X, Y, and Z axes. Defaults to 1.
    """
    if not selection:
        selection = pm.selected(flatten=True)
    
    if not selection:
        warning("Nothing selected! Please select a mesh or vertices.")
        return None

    # Use OpenMaya to calculate the bounding box from vertex data
    selList = om.MSelectionList()
    for item in selection:
        try:
            # Handle PyNode objects or strings
            name = item.name() if hasattr(item, 'name') else str(item)
            selList.add(name)
        except Exception:
            # Skip invalid selection items
            continue

    if selList.isEmpty():
        warning("No valid Maya objects found in selection.")
        return None

    bbox = om.MBoundingBox()
    points = []

    for i in range(selList.length()):
        try:
            dagPath, component = selList.getComponent(i)
        except Exception:
            continue

        # Target mesh geometry
        if dagPath.hasFn(om.MFn.kMesh):
            meshFn = om.MFnMesh(dagPath)
            
            # If component is null or not a vertex component, get all points
            if component.isNull() or not component.hasFn(om.MFn.kMeshVertComponent):
                meshPoints = meshFn.getPoints(om.MSpace.kWorld)
                points.extend(list(meshPoints))
            else:
                # Iterate over specific selected vertices
                itVert = om.MItMeshVertex(dagPath, component)
                while not itVert.isDone():
                    points.append(itVert.position(om.MSpace.kWorld))
                    itVert.next()
                    
        elif dagPath.hasFn(om.MFn.kTransform):
            # Check for mesh children if the transform itself is selected
            for childIdx in range(dagPath.childCount()):
                child = dagPath.child(childIdx)
                if child.apiType() == om.MFn.kMesh:
                    childDag = om.MDagPath.getAPathTo(child)
                    meshFn = om.MFnMesh(childDag)
                    meshPoints = meshFn.getPoints(om.MSpace.kWorld)
                    points.extend(list(meshPoints))

    if not points:
        warning("No vertex data found in selection. Only meshes and vertices are supported.")
        return None

    # PCA to find oriented axes
    eigenvectors, centroid = calculatePCA(points)
    if not eigenvectors:
        warning("Could not calculate PCA for orientation.")
        return None

    # Construct the coordinate system matrix from eigenvectors
    vecX = eigenvectors[0]
    vecY = eigenvectors[1]
    vecZ = vecX ^ vecY # Cross product for orthogonal Z
    vecY = vecZ ^ vecX # Ensure orthogonal Y

    # Project points onto these axes to find min/max
    minVals = [float('inf')] * 3
    maxVals = [float('-inf')] * 3
    
    for pt in points:
        relPt = om.MVector(pt - centroid)
        # Dot product gives the projection length on each axis
        proj = [relPt * vecX, relPt * vecY, relPt * vecZ]
        for i in range(3):
            if proj[i] < minVals[i]: minVals[i] = proj[i]
            if proj[i] > maxVals[i]: maxVals[i] = proj[i]

    # Calculate dimensions and center in local oriented space
    width = maxVals[0] - minVals[0]
    height = maxVals[1] - minVals[1]
    depth = maxVals[2] - minVals[2]
    
    localCenter = om.MVector(
        (minVals[0] + maxVals[0]) * 0.5,
        (minVals[1] + maxVals[1]) * 0.5,
        (minVals[2] + maxVals[2]) * 0.5
    )
    
    # World center = centroid + local_center rotated by our axes
    worldCenter = centroid + (vecX * localCenter.x + vecY * localCenter.y + vecZ * localCenter.z)
    
    # Create the cube with PyMEL
    boxName = "orientedBoundingBox_GEO"
    if len(selection) == 1:
        # Use PyMEL nodeName if available
        cleanName = selection[0].nodeName() if hasattr(selection[0], 'nodeName') else str(selection[0]).split('|')[-1]
        boxName = "{}_OOBB".format(cleanName)

    newBox, boxShape = pm.polyCube(w=width, h=height, d=depth, sx=density, sy=density, sz=density, name=boxName)
    
    # Build transformation matrix for the box
    matList = [
        vecX.x, vecX.y, vecX.z, 0.0,
        vecY.x, vecY.y, vecY.z, 0.0,
        vecZ.x, vecZ.y, vecZ.z, 0.0,
        worldCenter.x, worldCenter.y, worldCenter.z, 1.0
    ]
    
    # Apply rotation and position using PyMEL xform
    pm.xform(newBox, matrix=matList, worldSpace=True)
    pm.select(newBox)
    
    return newBox


def conformMesh(deformMesh, liveMesh, offset=0.2):
    pm.select(liveMesh)
    pm.makeLive()
    pm.select(deformMesh)

    pm.mel.eval('optionVar -iv polyConformAlongNormals 0') 
    pm.mel.eval('optionVar -fv polyConformOffset {}'.format(offset)) 
    pm.mel.eval('performPolyConform 0;')
    
    pm.makeLive(none=True)
    

def applyDeltaMushSmooth(mesh):
    """
    Applies a deltaMush deformer to the given mesh with predefined settings.
    """
    dmNode = cmds.deformer(str(mesh), type="deltaMush")[0]

    cmds.setAttr(dmNode+".smoothingIterations", 10)
    cmds.setAttr(dmNode+".smoothingStep", 0.5)
    cmds.setAttr(dmNode+".inwardConstraint", 1.0)
    cmds.setAttr(dmNode+".outwardConstraint", 1.0)
    cmds.setAttr(dmNode+".distanceWeight", 0.0)    
    cmds.setAttr(dmNode+".displacement", 0.0)

    cmds.delete(str(mesh), ch=True)
    

def makeJointBox(mesh, joints, offset=0.1, density=3, targetFaceCount=None, skinWeightThreshold=1e-4):
    """
    Creates a conformed joint box by:
    1. Extracting a patch from the main mesh based on joint weights.
    2. Creating an oriented bounding box from that patch.
    3. Conforming the box to the main mesh surface.
    4. Optionally retopologizing the result to a specific face count.
    """
    patchMesh = createMeshJointPatch(mesh, joints, threshold=skinWeightThreshold)
    if not patchMesh:
        return
        
    bbox = createBoundingBox([patchMesh], density)
    if not bbox:
        pm.delete(patchMesh)
        return

    conformMesh(bbox, patchMesh, offset)
    pm.delete(patchMesh)
    
    # Set the local origin of the mesh to the bone position
    # so that when you zero the transforms, it goes to world origin
    bonePos = pm.xform(joints[0], q=True, ws=True, t=True)
    pm.xform(bbox, pivots=bonePos, ws=True)

    tempGrp = pm.createNode("transform")
    pm.xform(tempGrp, ws=True, t=bonePos)
    tempGrp | bbox
    pm.makeIdentity(bbox, apply=True, t=True, r=True, s=True, n=0)
    pm.parent(bbox, world=True)
    pm.delete(tempGrp)

    if targetFaceCount:
        retopoMesh(bbox, targetFaceCount)
    else:
        applyDeltaMushSmooth(bbox)

    pm.parentConstraint(joints[0] if len(joints) > 1 else joints, bbox, mo=True)

    # Set the final name according to the format: [mesh]_[joints]_jointBox
    jntNames = [jnt.nodeName() for jnt in joints]
    finalName = "{}_cdt".format("_".join(jntNames))
    bbox.rename(finalName)

    pm.delete(bbox, ch=True) # Delete history

    return bbox

meshName = @mesh.strip()
if not meshName:
    error("Specify a skinned source mesh.")

skinName = mel.eval("findRelatedSkinCluster " + meshName)
if not skinName:
    error("No skinCluster found on {0}.".format(meshName))

joints = [pm.PyNode(name) for name in @joints]
if not joints:
    joints = pm.PyNode(skinName).influenceObjects()
if not joints:
    error("No joints found for {0}.".format(meshName))

targetFaceCount = None
if @retopoEnabled:
    if IS_RETOPO_AVAILABLE:
        targetFaceCount = @targetFaceCount
    else:
        warning("polyRetopo is unavailable in this Maya version; using deltaMush smoothing.")

box = makeJointBox(
    meshName,
    joints,
    offset=@offset,
    density=@density,
    targetFaceCount=targetFaceCount,
    skinWeightThreshold=@skinWeightThreshold,
)
@set_out_jointBox(box.name() if box else "")
]]></run>
<doc><![CDATA[## Summary
Creates a conformed joint box from the skin weights of the specified joints. It extracts a weighted mesh patch, builds an oriented box, conforms it to the patch, and then retopologizes or smooths it.

## Inputs
- **`mesh`**: Skinned source mesh. Use **Set selected** to capture the current Maya selection.
- **`joints`**: Source joints as a list of names. Use the listBox selection control to fill it. If empty, all influences on the mesh's skin cluster are used.
- **`offset`**: Surface conform offset.
- **`density`**: Number of subdivisions on each box axis.
- **`skinWeightThreshold`**: Minimum joint weight used to include a vertex in the patch.
- **`retopoEnabled`**: Use Maya polyRetopo when available; otherwise the module uses deltaMush smoothing.
- **`targetFaceCount`**: Face count requested when retopology is enabled.

## Outputs
- **`out_jointBox`**: Name of the created box mesh, or an empty string when no box was created.

## Usage
1. Set a skinned mesh, then fill `joints` or leave it empty to use all skin influences.
2. Adjust the shape and retopology settings.
3. Run the module. It creates and constrains the joint box in the Maya scene. Inspect the result and save the scene when ready.]]></doc>
<attributes>
<attr name="mesh" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Skinned mesh", "buttonCommand": "import pymel.core as pm\nselection = pm.selected()\nif selection:\n    value = selection[0].name()", "buttonLabel": "Set selected", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["joint1"], "default": "items"}]]></attr>
<attr name="offset" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0.4, "placeholder": "", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 10, "validator": 2, "default": "value"}]]></attr>
<attr name="density" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 25, "placeholder": "", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 1, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="skinWeightThreshold" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0.2, "placeholder": "", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 1, "validator": 2, "default": "value"}]]></attr>
<attr name="retopoEnabled" template="checkBox" category="Retopology" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="targetFaceCount" template="lineEditAndButton" category="Retopology" connect=""><![CDATA[{"value": 50, "placeholder": "", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 10, "max": 1000, "validator": 1, "default": "value"}]]></attr>
<attr name="out_jointBox" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "", "placeholder": "Created joint box", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>