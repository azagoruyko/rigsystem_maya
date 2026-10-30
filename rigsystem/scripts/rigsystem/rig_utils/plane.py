import maya.api.OpenMaya as om


class Plane(object):
    def __init__(self, orig, normal):
        """Create a plane from origin point and normal vector."""
        self._orig = om.MPoint(orig)
        self._normal = om.MVector(normal).normal()


    def projectVector(self, v):
        """Project a vector onto this plane."""
        v = om.MVector(v)
        return v - (v * self._normal) * self._normal


    def distance(self, p):
        """Return signed distance from point to plane."""
        return (om.MPoint(p) - self._orig) * self._normal


    def projectPoint(self, p):
        """Project a point onto this plane."""
        p = om.MPoint(p)
        dist = (p - self._orig) * self._normal
        return p - dist * self._normal


    def findLineIntersection(self, linePoint, lineDirection):
        """Return intersection point between a line and the plane."""
        linePoint = om.MPoint(linePoint)
        lineDirection = om.MVector(lineDirection)
        d = ((self._orig - linePoint) * self._normal) / (lineDirection * self._normal)
        return linePoint + d * lineDirection
