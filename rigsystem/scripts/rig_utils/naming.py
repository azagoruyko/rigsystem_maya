def findSymmetricName(name, left=True, right=True):
    """Return a mirrored side name variant when possible."""
    lStarts = {"L_": "R_", "l_": "r_", "Left": "Right", "left_": "right_"}
    lEnds = {"_L": "_R", "_l": "_r", "Left": "Right", "_left": "_right"}

    lMids = {"_L_": "_R_", "_l_": "_r_", "_left_": "_right_", "Left": "Right"}
    rMids = {"_R_": "_L_", "_r_": "_l_", "_right_": "_left_", "Right": "Left"}

    rStarts = {"R_": "L_", "r_": "l_", "Right": "Left", "right_": "left_"}
    rEnds = {"_R": "_L", "_r": "_l", "Right": "Left", "_right": "_left"}

    for enabled, starts, ends, mids in [
        (left, lStarts, lEnds, lMids),
        (right, rStarts, rEnds, rMids),
    ]:
        if enabled:
            for start in starts:
                if name.startswith(start):
                    return starts[start] + name[len(start):]

            for end in ends:
                if name.endswith(end):
                    return name[:-len(end)] + ends[end]

            for mid in mids:
                if mid in name:
                    return name.replace(mid, mids[mid])

    return name


def isSideOf(name, l=False, r=False):
    """Check whether a name belongs to the requested side."""
    lName = findSymmetricName(name, left=False)
    rName = findSymmetricName(name, right=False)
    if name == lName and name == rName:
        return False
    return (l and name == lName) or (r and name == rName)


def isLeftSide(name):
    """Return True when the name resolves to the left side."""
    return isSideOf(name, l=True)


def isRightSide(name):
    """Return True when the name resolves to the right side."""
    return isSideOf(name, r=True)
