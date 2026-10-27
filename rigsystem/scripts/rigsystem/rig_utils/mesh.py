import maya.api.OpenMaya as om

def getMDagPath(nodeName):
    """Return an MDagPath for the given DAG node name."""
    sel = om.MSelectionList()
    sel.add(nodeName)
    return sel.getDagPath(0)

class ClosestPoint:
    def __init__(self, mesh):
        """Initialize closest-point queries for a mesh."""
        self._meshDagPath = getMDagPath(mesh)
        self._meshFn = om.MFnMesh(self._meshDagPath)
        self._intersector = om.MMeshIntersector()
        self._intersector.create(self._meshFn.object(), self._meshDagPath.inclusiveMatrix())

    def getClosestPoint(self, p):
        """Return closest point, supporting triangle, and barycentric weights."""
        pom = self._intersector.getClosestPoint(om.MPoint(p))
        vertices3 = self._meshFn.getPolygonTriangleVertices(pom.face, pom.triangle)
        u, v = pom.barycentricCoords
        w = 1 - u - v
        return om.MPoint(pom.point), vertices3, (u, v, w)

class VertexSymmetricTable:
    def __init__(self, mesh, x=-1, y=1, z=1):
        """Build a symmetry lookup table for mesh vertices."""
        self._meshDagPath = getMDagPath(mesh)
        self._meshFn = om.MFnMesh(self._meshDagPath)
        self._closestPoint = ClosestPoint(mesh)

        self._table = None
        self._calculate(x, y, z)

    def _calculate(self, x=-1, y=1, z=1):
        """Populate symmetry mapping using mirrored closest-point lookup."""
        points = self._meshFn.getPoints(om.MSpace.kWorld)
        self._table = [0] * self._meshFn.numVertices
        for i in range(self._meshFn.numVertices):
            mirrorPoint = om.MPoint(x * points[i].x, y * points[i].y, z * points[i].z)
            _, vertices3, uvw = self._closestPoint.getClosestPoint(mirrorPoint)
            self._table[i] = (vertices3, uvw)

    def interpolate(self, dataPoints):
        """Interpolate per-vertex data through the symmetry table."""
        assert len(dataPoints) == len(self._table), "Number of vertices must be the same"

        dataSize = len(dataPoints[0])
        outPoints = [0] * len(self._table)
        for i in range(len(self._table)):
            vertices3, uvw = self._table[i]
            data = [0] * dataSize
            for w, vtx in zip(uvw, vertices3):
                for j in range(dataSize):
                    data[j] += dataPoints[vtx][j] * w
            outPoints[i] = data
        return outPoints

def mirrorMeshPoints(meshBase, mesh):
    """Mirror mesh point offsets from base mesh across X."""
    meshBaseFn = om.MFnMesh(getMDagPath(meshBase))
    meshFn = om.MFnMesh(getMDagPath(mesh))

    basePoints = meshBaseFn.getPoints(om.MSpace.kWorld)
    points = meshFn.getPoints(om.MSpace.kWorld)

    assert len(basePoints) == len(points), "Number of vertices must be the same"

    offsets = [points[i] - basePoints[i] for i in range(len(points))]
    sym = VertexSymmetricTable(meshBase)
    newOffsets = sym.interpolate(offsets)

    newPoints = om.MPointArray(basePoints)
    for i in range(len(points)):
        offset = om.MPoint(newOffsets[i])
        offset.x *= -1
        newPoints[i] += offset

    return newPoints

def getVertexTangentSpaces(mesh, weightByUVTriangleSize=False, translation=True, rotation=True):
    """Return per-vertex tangent-space matrices."""
    meshDagPath = getMDagPath(mesh)
    meshFn = om.MFnMesh(meshDagPath)
    points = meshFn.getPoints(om.MSpace.kWorld)
    tangents = meshFn.getTangents(om.MSpace.kWorld)
    binormals = meshFn.getBinormals(om.MSpace.kWorld)

    meshPolyIter = om.MItMeshPolygon(meshDagPath)
    meshVertexIter = om.MItMeshVertex(meshDagPath)

    outMatrices = [0] * meshFn.numVertices
    while not meshVertexIter.isDone():
        vtxId = meshVertexIter.index()
        connectedFaceIds = meshVertexIter.getConnectedFaces()

        divisor = 0 if weightByUVTriangleSize else len(connectedFaceIds)
        tangent = om.MFloatVector()
        binormal = om.MFloatVector()

        for faceId in connectedFaceIds:
            tangentId = meshFn.getTangentId(faceId, vtxId)

            if weightByUVTriangleSize:
                meshPolyIter.setIndex(faceId)
                area = meshPolyIter.getUVArea()
                binormal += binormals[tangentId] * area
                tangent += tangents[tangentId] * area
                divisor += area
            else:
                binormal += binormals[tangentId]
                tangent += tangents[tangentId]

        binormal /= divisor
        tangent /= divisor

        binormal.normalize()
        tangent.normalize()

        normal = tangent ^ binormal
        normal.normalize()

        m = om.MMatrix()
        if rotation:
            m[0] = tangent.x
            m[1] = tangent.y
            m[2] = tangent.z
            m[4] = binormal.x
            m[5] = binormal.y
            m[6] = binormal.z
            m[8] = normal.x
            m[9] = normal.y
            m[10] = normal.z
        if translation:
            m[12] = points[vtxId].x
            m[13] = points[vtxId].y
            m[14] = points[vtxId].z
        outMatrices[vtxId] = m

        meshVertexIter.next()

    return outMatrices

def getVertexOffsets(mesh, target):
    """Return per-vertex world-space offsets from mesh to target."""
    meshFn = om.MFnMesh(getMDagPath(mesh))
    targetFn = om.MFnMesh(getMDagPath(target))
    meshPoints = meshFn.getPoints(om.MSpace.kWorld)
    targetPoints = targetFn.getPoints(om.MSpace.kWorld)
    assert len(meshPoints) == len(targetPoints), "Number of vertices must be the same"
    return [targetPoints[i] - meshPoints[i] for i in range(meshFn.numVertices)]

def setVertexOffsets(mesh, offsets):
    """Apply per-vertex world-space offsets to a mesh."""
    meshFn = om.MFnMesh(getMDagPath(mesh))
    outPoints = meshFn.getPoints(om.MSpace.kWorld)
    for i in range(meshFn.numVertices):
        outPoints[i] += om.MPoint(offsets[i])
    meshFn.setPoints(outPoints, om.MSpace.kWorld)

def getVertexOffsetsInTangentSpace(base, target):
    """Return offsets between meshes expressed in base tangent space."""
    matrices = getVertexTangentSpaces(base, translation=False)
    offsets = getVertexOffsets(base, target)
    return [offsets[i] * matrices[i].inverse() for i in range(len(offsets))]

def setVertexOffsetsInTangentSpace(mesh, offsets):
    """Apply tangent-space offsets to a mesh in world space."""
    meshFn = om.MFnMesh(getMDagPath(mesh))
    matrices = getVertexTangentSpaces(mesh)
    outPoints = [om.MPoint(offsets[i]) * matrices[i] for i in range(len(offsets))]
    meshFn.setPoints(outPoints, om.MSpace.kWorld)

def setSymmetricVertexOffsets(baseMesh, targetBase, target, destBase):
    """Mirror target offsets from one base mesh onto another."""
    offsets = getVertexOffsets(str(targetBase), target)
    for o in offsets:
        o.x *= -1
    symTable = VertexSymmetricTable(str(baseMesh))
    symOffsets = symTable.interpolate(offsets)
    setVertexOffsets(str(destBase), symOffsets)
