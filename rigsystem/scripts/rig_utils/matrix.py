import pymel.core as pm
import maya.api.OpenMaya as om

import math

def xaxis(m):
    """Return the matrix X axis as a vector."""
    return pm.dt.Vector(m.a00, m.a01, m.a02)

def yaxis(m):
    """Return the matrix Y axis as a vector."""
    return pm.dt.Vector(m.a10, m.a11, m.a12)

def zaxis(m):
    """Return the matrix Z axis as a vector."""
    return pm.dt.Vector(m.a20, m.a21, m.a22)

def taxis(m):
    """Return the matrix translation as a vector."""
    return pm.dt.Vector(m.a30, m.a31, m.a32)

def mscale(m):
    """Return per-axis scale magnitudes extracted from a matrix."""
    return pm.dt.Vector(xaxis(m).length(), yaxis(m).length(), zaxis(m).length())

def maxis(m, a):
    """Return matrix row axis values excluding the homogeneous column."""
    return pm.dt.Vector(m[a][:-1]) # skip last column

def set_maxis(m, a, v):
    """Set a matrix row axis vector."""
    m[a] = v

def scaledMatrix(m, scale=pm.dt.Vector(1,1,1)):
    """Return a matrix with preserved axes and overridden scale."""
    out = pm.dt.Matrix(m)
    set_maxis(out, 0, xaxis(out).normal() * scale.x)
    set_maxis(out, 1, yaxis(out).normal() * scale.y)
    set_maxis(out, 2, zaxis(out).normal() * scale.z)
    return out

def slerp(q1, q2, w):
    """Spherically interpolate two quaternions."""
    q = om.MQuaternion.slerp(om.MQuaternion(q1.x, q1.y, q1.z, q1.w), om.MQuaternion(q2.x, q2.y, q2.z, q2.w), w)
    return pm.dt.Quaternion(q.x, q.y, q.z, q.w)

def blendMatrices(m1, m2, w):
    """Blend two transforms by interpolating rotation, scale, and translation."""
    q1 = pm.dt.MTransformationMatrix(scaledMatrix(m1)).rotation()
    q2 = pm.dt.MTransformationMatrix(scaledMatrix(m2)).rotation()

    s = mscale(m1) * (1-w) + mscale(m2) * w
    m = scaledMatrix(slerp(q1, q2, w).asMatrix(), s)

    set_maxis(m, 3, maxis(m1, 3)*(1-w) + maxis(m2, 3)*w)
    return m

def mirrorBehaviourMatrix(worldMatrix, translate=True, rotate=True, behaviourMatrix=None):
    """Mirror matrix behavior across X with optional translation/rotation mirroring."""
    worldMatrix = om.MMatrix(worldMatrix)
    if behaviourMatrix is None:
        behaviourMatrix = om.MQuaternion(math.pi, om.MVector(1,0,0)).asMatrix()
    m = worldMatrix * behaviourMatrix if rotate else worldMatrix
    m[12] = worldMatrix[12] * (-1 if translate else 1)
    m[13] = worldMatrix[13]
    m[14] = worldMatrix[14]
    return m

def makeMatrix(primaryAxis, secondaryAxis, t):
    """Build an orthonormal matrix from two axes and translation."""
    x = primaryAxis.normal()
    z = x.cross(secondaryAxis).normal()
    y = z.cross(x).normal()

    m = om.MMatrix()
    m[0] = x.x
    m[1] = x.y
    m[2] = x.z
    m[4] = y.x
    m[5] = y.y
    m[6] = y.z
    m[8] = z.x
    m[9] = z.y
    m[10] = z.z
    m[12] = t.x
    m[13] = t.y
    m[14] = t.z
    return m

def parentConstraintMatrix(destBase, srcBase, src):
    """Compute parent-constraint style offset matrix."""
    destBase = om.MMatrix(destBase)
    srcBase = om.MMatrix(srcBase)
    src = om.MMatrix(src)
    return destBase * srcBase.inverse() * src

def flipXAxisMatrix(m):
    """Flip matrix orientation and translation across the X axis."""
    out = om.MMatrix(m)
    out[0] *= -1
    out[4] *= -1
    out[8] *= -1
    out[12] *= -1
    return out

def mirrorMatrix(base, srcBase, src):
    """Mirror a source matrix into a destination base space."""
    return parentConstraintMatrix(base, flipXAxisMatrix(srcBase), flipXAxisMatrix(src))

def mirrorMatrixByDelta(srcBase, src, destBase):
    """Mirror transform delta from source base onto destination base."""
    srcBase = om.MMatrix(srcBase)
    src = om.MMatrix(src)
    destBase = om.MMatrix(destBase)

    mirroredSrcBase = mirrorMatrix(om.MMatrix(), om.MMatrix(), srcBase)
    mirroredSrc = mirrorMatrix(om.MMatrix(), om.MMatrix(), src)

    # Set translation to match destination for stable mirrored rotation.
    dt = om.MVector(mirroredSrcBase[12], mirroredSrcBase[13], mirroredSrcBase[14]) - om.MVector(destBase[12], destBase[13], destBase[14])
    mirroredSrc[12] -= dt.x
    mirroredSrc[13] -= dt.y
    mirroredSrc[14] -= dt.z
    mirroredSrcBase[12] -= dt.x
    mirroredSrcBase[13] -= dt.y
    mirroredSrcBase[14] -= dt.z

    return parentConstraintMatrix(destBase, mirroredSrcBase, mirroredSrc)
