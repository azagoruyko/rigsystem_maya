import pymel.core as pm

class Plane(object):
    def __init__(self, orig, normal):
        """Create a plane from origin point and normal vector."""
        self._orig = pm.dt.Point(orig)
        self._normal = pm.dt.Vector(normal).normal()

    def projectVector(self, v):
        """Project a vector onto this plane."""
        return v - v.dot(self._normal) * self._normal

    def distance(self, p):
        """Return signed distance from point to plane."""
        return (p - self._orig).dot(self._normal)

    def projectPoint(self, p):
        """Project a point onto this plane."""
        dist = (p - self._orig).dot(self._normal)
        return p - dist * self._normal

    def findLineIntersection(self, linePoint, lineDirection):
        """Return intersection point between a line and the plane."""
        d = (self._orig - linePoint).dot(self._normal) / lineDirection.dot(self._normal)
        return linePoint + d * lineDirection
