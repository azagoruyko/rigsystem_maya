import maya.cmds as _maya_cmds
import maya.api.OpenMaya as om
import maya.api.OpenMayaAnim as oma


_API_FUNCTION_SETS = {
    "transform": om.MFnTransform,
    "joint": om.MFnTransform,
    "mesh": om.MFnMesh,
    "nurbsCurve": om.MFnNurbsCurve,
    "nurbsSurface": om.MFnNurbsSurface,
    "camera": om.MFnCamera,
    "skinCluster": oma.MFnSkinCluster,
    "animCurveTA": oma.MFnAnimCurve,
    "animCurveTL": oma.MFnAnimCurve,
    "animCurveTT": oma.MFnAnimCurve,
    "animCurveTU": oma.MFnAnimCurve,
}


def _wrapConnections(connections, kwargs):
    """Wrap Maya listConnections results as Node or Plug objects."""
    returnsPlugs = kwargs.get("plugs") or kwargs.get("p")
    returnsPairs = kwargs.get("connections") or kwargs.get("c")
    if returnsPairs and not returnsPlugs:
        return [
            Plug(connection) if "." in connection else Node(connection)
            for connection in connections
        ]
    resultType = Plug if returnsPlugs else Node
    return [resultType(connection) for connection in connections]


class Plug:
    """A Maya attribute name with small cmds and API helpers."""

    def __init__(self, value):
        if isinstance(value, om.MPlug):
            self._mplug = value
        else:
            plugName = str(value)
            selection = om.MSelectionList()
            try:
                selection.add(plugName)
                self._mplug = selection.getPlug(0)
            except RuntimeError as error:
                raise RuntimeError(f"Could not find plug '{plugName}': {error}") from error
            if self._mplug.isElement and "[" not in plugName:
                self._mplug = self._mplug.array()


    def __str__(self):
        return self._mplug.name()


    def __getattr__(self, name):
        if name.startswith("__"):
            raise AttributeError(name)
        return Plug(f"{self}.{name}")


    def __eq__(self, other):
        if not isinstance(other, Plug):
            return NotImplemented
        return self._mplug == other._mplug


    def __hash__(self):
        parts = []
        current = self._mplug
        while True:
            attribute = om.MObjectHandle(current.attribute())
            index = current.logicalIndex() if current.isElement else None
            parts.append((attribute.hashCode(), index))
            if current.isChild:
                current = current.parent()
            elif current.isElement:
                current = current.array()
            else:
                break

        node = om.MObjectHandle(self._mplug.node())
        return hash((node.hashCode(), tuple(parts)))


    def get(self, **kwargs):
        """Return the attribute value."""
        return cmds.getAttr(str(self), **kwargs)


    def set(self, value, **kwargs):
        """Set the attribute value."""
        name = str(self)
        if "type" not in kwargs:
            attrType = cmds.getAttr(name, type=True)
            if attrType in ("string", "matrix"):
                kwargs["type"] = attrType

        if isinstance(value, om.MMatrix):
            value = tuple(value)

        if isinstance(value, (tuple, list)):
            if len(value) == 1 and isinstance(value[0], (tuple, list)):
                value = value[0]
            cmds.setAttr(name, *value, **kwargs)
        else:
            cmds.setAttr(name, value, **kwargs)


    def connect(self, destination, force=False):
        """Connect this source plug to a destination plug."""
        cmds.connectAttr(str(self), str(plug(destination)), force=force)


    def isConnected(self, destination=None):
        """Return whether this plug has connections, or is connected to a destination plug."""
        if destination is None:
            return bool(self.inputs() or self.outputs())

        return cmds.isConnected(str(self), str(plug(destination)))


    def disconnect(self, other=None, inputs=True, outputs=True):
        """Disconnect one connected plug, or every incoming and/or outgoing connection."""
        if other is not None:
            other = plug(other)
            if cmds.isConnected(str(other), str(self)):
                cmds.disconnectAttr(str(other), str(self))
            else:
                cmds.disconnectAttr(str(self), str(other))
            return

        if inputs:
            for source in self.inputs():
                cmds.disconnectAttr(str(source), str(self))
        if outputs:
            for target in self.outputs():
                cmds.disconnectAttr(str(self), str(target))


    def inputs(self, **kwargs):
        """Return source plugs connected to this plug."""
        kwargs.setdefault("source", True)
        kwargs.setdefault("destination", False)
        kwargs.setdefault("plugs", True)
        return self.listConnections(**kwargs)


    def outputs(self, **kwargs):
        """Return destination plugs connected to this plug."""
        kwargs.setdefault("source", False)
        kwargs.setdefault("destination", True)
        kwargs.setdefault("plugs", True)
        return self.listConnections(**kwargs)


    @property
    def node(self):
        """Return the node that owns this plug."""
        name = om.MFnDependencyNode(self._mplug.node()).name()
        return Node(name)


    def name(self):
        """Return the full plug path, including the node and parent attributes."""
        return self._mplug.name()


    def partialName(self, **kwargs):
        """Return the plug's partial name using Maya API options."""
        defaults = {
            "includeNodeName": False,
            "includeNonMandatoryIndices": False,
            "includeInstancedIndices": False,
            "useAlias": False,
            "useFullAttributePath": False,
            "useLongNames": True,
        }
        for key, value in defaults.items():
            kwargs.setdefault(key, value)
        return self._mplug.partialName(**kwargs)


    def listConnections(self, **kwargs):
        """List connected nodes or plugs using Maya listConnections options."""
        connections = cmds.listConnections(str(self), **kwargs) or []
        return _wrapConnections(connections, kwargs)


    @property
    def mplug(self):
        """Return the Maya API MPlug for this attribute."""
        return self._mplug


    def index(self):
        """Return this array element's logical index."""
        return self._mplug.logicalIndex()


    def __iter__(self):
        """Iterate over existing elements of an array plug."""
        if not self._mplug.isArray:
            raise TypeError("Plug is not an array")

        for index in range(self._mplug.evaluateNumElements()):
            yield Plug(self._mplug.elementByPhysicalIndex(index))


    def __getitem__(self, index):
        return Plug(self._mplug.elementByLogicalIndex(index))


    def __rshift__(self, destination):
        self.connect(destination)
        return plug(destination)


class Node:
    """A Maya node name with lightweight attribute and DAG helpers."""

    def __init__(self, value):
        if isinstance(value, Node):
            self._handle = value._handle
            return

        name = str(value)
        matches = cmds.ls(name, long=True) or []
        if not matches:
            raise ValueError(f"Maya node does not exist: {name or '<empty>'}")
        if len(matches) > 1:
            matchList = ", ".join(matches)
            raise ValueError(
                f"Maya node name is ambiguous: {name}. "
                f"Matches: {matchList}. Use a full DAG path."
            )

        selection = om.MSelectionList()
        selection.add(matches[0])
        self._handle = om.MObjectHandle(selection.getDependNode(0))


    def __str__(self):
        obj = self.mobject
        if obj.hasFn(om.MFn.kDagNode):
            return om.MDagPath.getAPathTo(obj).partialPathName()
        return om.MFnDependencyNode(obj).name()


    def __eq__(self, other):
        if not isinstance(other, Node):
            return NotImplemented
        return self._handle == other._handle


    def __hash__(self):
        return self._handle.hashCode()


    def localName(self):
        """Return the node name without its namespace or DAG path."""
        return om.MFnDependencyNode(self.mobject).name().rsplit(":", 1)[-1]


    def namespace(self):
        """Return the node namespace with a trailing colon, or an empty string."""
        namespace = om.MFnDependencyNode(self.mobject).name().rpartition(":")[0]
        return f"{namespace}:" if namespace else ""


    def type(self):
        """Return the Maya node type."""
        return cmds.nodeType(str(self))


    def mfn(self, shape=False):
        """Return this node's API function set, optionally using its first non-intermediate shape."""
        node = self
        if shape and self.mobject.hasFn(om.MFn.kTransform):
            shapes = self.getShapes()
            if shapes:
                node = shapes[0]

        obj = node.mobject
        isDagNode = obj.hasFn(om.MFn.kDagNode)
        nodeType = cmds.objectType(str(node))
        functionSet = _API_FUNCTION_SETS.get(nodeType)
        if functionSet is None:
            functionSet = om.MFnDagNode if isDagNode else om.MFnDependencyNode

        target = node.mdagpath if isDagNode else obj
        return functionSet(target)


    def __getattr__(self, name):
        if name.startswith("__"):
            raise AttributeError(name)
        return Plug(f"{self}.{name}")


    def attr(self, name):
        """Return a plug, including attributes that conflict with Python names."""
        return Plug(f"{self}.{name}")


    @property
    def mobject(self):
        """Return the Maya API MObject for this node."""
        if not self._handle.isValid():
            raise RuntimeError("Maya node no longer exists")
        return self._handle.object()


    @property
    def mdagpath(self):
        """Return the Maya API MDagPath for this DAG node."""
        return om.MDagPath.getAPathTo(self.mobject)


    def rename(self, name):
        """Rename this node and return its new name."""
        cmds.rename(str(self), name)
        return self


    def getParent(self, **kwargs):
        """Return this DAG node's parent, or None when it has no parent."""
        parents = cmds.listRelatives(str(self), parent=True, **kwargs) or []
        return Node(parents[0]) if parents else None


    def getAllParents(self):
        """Return all ancestors, starting with the direct parent."""
        parents = []
        parent = self.getParent(fullPath=True)
        while parent:
            parents.append(parent)
            parent = parent.getParent(fullPath=True)
        return parents


    def getChildren(self, type=None, **kwargs):
        """Return direct child nodes, optionally filtered by Maya node type."""
        if type is not None:
            kwargs["type"] = type
        kwargs.setdefault("fullPath", True)
        children = cmds.listRelatives(str(self), children=True, **kwargs) or []
        return [Node(child) for child in children]


    def getShapes(self, type=None, **kwargs):
        """Return this DAG node's shapes, optionally filtered by Maya node type."""
        if type is not None:
            kwargs["type"] = type
        kwargs.setdefault("fullPath", True)
        kwargs.setdefault("noIntermediate", True)
        shapes = cmds.listRelatives(str(self), shapes=True, **kwargs) or []
        return [Node(shape) for shape in shapes]


    def listAttr(self, **kwargs):
        """List this node's attribute names using Maya listAttr options."""
        return cmds.listAttr(str(self), **kwargs) or []


    def addAttr(self, **kwargs):
        """Add or query an attribute using Maya addAttr options."""
        return cmds.addAttr(str(self), **kwargs)


    def hasAttr(self, name):
        """Return whether this node has the named attribute."""
        return cmds.attributeQuery(name, node=str(self), exists=True)


    def listConnections(self, **kwargs):
        """List connected nodes or plugs using Maya listConnections options."""
        connections = cmds.listConnections(str(self), **kwargs) or []
        return _wrapConnections(connections, kwargs)


    def inputs(self, **kwargs):
        """Return incoming connected nodes or plugs."""
        kwargs.setdefault("source", True)
        kwargs.setdefault("destination", False)
        return self.listConnections(**kwargs)


    def outputs(self, **kwargs):
        """Return outgoing connected nodes or plugs."""
        kwargs.setdefault("source", False)
        kwargs.setdefault("destination", True)
        return self.listConnections(**kwargs)


    def deleteAttr(self, name):
        """Delete an attribute from this node."""
        attribute = self.attr(name)
        cmds.setAttr(attribute, lock=False)
        cmds.deleteAttr(attribute)


    def __or__(self, child):
        result = cmds.parent(str(node(child)), str(self))
        return Node(result[0])


def node(name):
    """Wrap a Maya node name."""
    return name if isinstance(name, Node) else Node(name)


def nodes(values):
    """Wrap a list of Maya node names or Node objects."""
    return [node(value) for value in values]


def plug(name):
    """Wrap a Maya plug name."""
    return name if isinstance(name, Plug) else Plug(name)


def create(nodeType, name=None, parent=None, skipSelection=False, suffix=True):
    """Create a node, optionally keeping its exact name and current selection."""
    kwargs = {}
    if name is not None:
        typeSuffix = f"_{nodeType}" if suffix else ""
        base = str(name)
        if typeSuffix and base.endswith(typeSuffix):
            base = base[:-len(typeSuffix)]
        nodeName = f"{base}{typeSuffix}"
        index = 1
        while cmds.objExists(nodeName):
            nodeName = f"{base}_{index}{typeSuffix}"
            index += 1
        kwargs["name"] = nodeName

    if parent is not None:
        kwargs["parent"] = parent
    if skipSelection:
        kwargs["skipSelect"] = True
    return Node(cmds.createNode(nodeType, **kwargs))


def _mayaArgument(value):
    """Convert wrapper values to names accepted by Maya commands."""
    if isinstance(value, (Node, Plug)):
        return str(value)
    if isinstance(value, list):
        return [_mayaArgument(item) for item in value]
    if isinstance(value, tuple):
        return tuple(_mayaArgument(item) for item in value)
    if isinstance(value, dict):
        return {key: _mayaArgument(item) for key, item in value.items()}
    return value


class _CmdsProxy:
    """Forward Maya commands after converting wrapper arguments."""

    def __getattr__(self, name):
        command = getattr(_maya_cmds, name)
        if not callable(command):
            return command

        def call(*args, **kwargs):
            return command(
                *(_mayaArgument(arg) for arg in args),
                **{key: _mayaArgument(value) for key, value in kwargs.items()},
            )

        return call


cmds = _CmdsProxy()
