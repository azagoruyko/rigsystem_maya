from .. import proxy

cmds = proxy.cmds


class ModuleInfo:
    MayaNodeType = "network"
    MayaNodePostfix = "_moduleInfo"

    def __init__(self, name):
        name = str(name)
        nodeName = name.replace(self.MayaNodePostfix, "") + self.MayaNodePostfix
        self.node = proxy.node(nodeName) if cmds.objExists(nodeName) else proxy.create(
            self.MayaNodeType
        ).rename(nodeName)


    @staticmethod
    def exists(name):
        nodeName = name.replace(ModuleInfo.MayaNodePostfix, "") + ModuleInfo.MayaNodePostfix
        return cmds.objExists(nodeName)


    def name(self):
        return str(self.node)


    def setAttr(self, name, value):
        source = value.node.message if isinstance(value, ModuleInfo) else value
        isConnection = isinstance(source, (str, proxy.Plug)) and "." in str(source) and cmds.objExists(source)

        if not cmds.attributeQuery(name, node=self.node, exists=True):
            if isConnection:
                self.node.addAttr(ln=name, at="message")
            elif isinstance(value, str):
                self.node.addAttr(ln=name, dt="string")
            elif isinstance(value, bool):
                self.node.addAttr(ln=name, at="bool")
            elif isinstance(value, int):
                self.node.addAttr(ln=name, at="long")
            elif isinstance(value, float):
                self.node.addAttr(ln=name, at="float")
            else:
                cmds.error("ModuleInfo.setAttr: invalid value")

        plug = self.node.attr(name)
        cmds.setAttr(plug, lock=False)
        if cmds.getAttr(plug, type=True) == "message":
            if not isConnection:
                cmds.error("ModuleInfo.setAttr: invalid value")
            previous = plug.inputs()
            if previous:
                cmds.disconnectAttr(previous[0], plug)
            cmds.connectAttr(source, plug)
        elif cmds.getAttr(plug, type=True) == "string":
            cmds.setAttr(plug, value, type="string")
        else:
            cmds.setAttr(plug, value)
        cmds.setAttr(plug, lock=True)


    def getParent(self):
        if self.hasAttr("_parent"):
            return ModuleInfo(self.getAttr("_parent").node)


    def getRoot(self):
        return self.getParent().getRoot() if self.hasAttr("_parent") else self


    def setParent(self, parentModuleInfo):
        self.setAttr("_parent", parentModuleInfo.node.message)


    def hasAttr(self, name):
        return cmds.attributeQuery(name, node=self.node, exists=True)


    def getAttr(self, name):
        """Return a connected attribute as a Plug, or its stored value."""
        plug = self.node.attr(name)
        connections = plug.inputs()
        return connections[0] if connections else cmds.getAttr(plug)


    def deleteAttr(self, name):
        self.node.deleteAttr(name)


    def listAttrs(self):
        return [self.node.attr(attr) for attr in self.node.listAttr(ud=True)]


def getModuleInfo(object, root=True):
    connections = proxy.node(object).message.listConnections(
        source=False,
        destination=True,
        type=ModuleInfo.MayaNodeType,
    )
    for node in connections:
        nodeName = str(node)
        if nodeName.endswith(ModuleInfo.MayaNodePostfix):
            moduleInfo = ModuleInfo(nodeName)
            return moduleInfo.getRoot() if root else moduleInfo
