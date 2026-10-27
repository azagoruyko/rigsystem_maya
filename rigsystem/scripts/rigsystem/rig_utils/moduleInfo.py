import pymel.core as pm

class ModuleInfo:
    MayaNodeType = "network"
    MayaNodePostfix = "_moduleInfo"

    def __init__(self, name):
        self.node = None

        nodeName = name.replace(ModuleInfo.MayaNodePostfix, "") + ModuleInfo.MayaNodePostfix

        if not pm.objExists(nodeName):
            self.node = pm.createNode(ModuleInfo.MayaNodeType, n=nodeName)
        else:
            self.node = pm.PyNode(nodeName)

    @staticmethod
    def exists(name):
        return pm.objExists(name.replace(ModuleInfo.MayaNodePostfix, "") + ModuleInfo.MayaNodePostfix)

    def name(self):
        return self.node.name()

    def setAttr(self, name, value):
        if not self.node.hasAttr(name):
            if isinstance(value, pm.Attribute) or  isinstance(value, ModuleInfo): # attribute connections
                self.node.addAttr(name, at="message")

            elif isinstance(value, str):
                self.node.addAttr(name, dt="string")

            elif isinstance(value, bool):
                self.node.addAttr(name, at="bool")

            elif isinstance(value, int):
                self.node.addAttr(name, at="long")

            elif isinstance(value, float):
                self.node.addAttr(name, at="float")

        self.node.attr(name).setLocked(False)

        if self.node.attr(name).type() == "message":
            if isinstance(value, pm.Attribute): # attribute connections
                self.node.attr(name).disconnect()
                value >> self.node.attr(name)

            elif isinstance(value, ModuleInfo):
                value.node.message >> self.node.attr(name)

            else:
                pm.error("ModuleInfo.setAttr: invalid value")
        else:
            self.node.attr(name).set(value)

        self.node.attr(name).setLocked(True)

    def getParent(self):
        if self.hasAttr("_parent"):
            return ModuleInfo(self.getAttr("_parent").node())

    def getRoot(self):
        return self.getParent().getRoot() if self.hasAttr("_parent") else self

    def setParent(self, parentModuleInfo):
        self.setAttr("_parent", parentModuleInfo.node.message)

    def hasAttr(self, name):
        return self.node.hasAttr(name)

    def getAttr(self, name):
        lst = self.node.attr(name).listConnections(p=True)
        return lst[0] if lst else self.node.attr(name).get()

    def deleteAttr(self, name):
        self.node.attr(name).setLocked(False)
        self.node.attr(name).delete()

    def listAttrs(self):
        return self.node.listAttr(ud=True)

def getModuleInfo(object, root=True):
    connections = pm.PyNode(object).message.outputs(type=ModuleInfo.MayaNodeType, plugs=True)
    
    if connections:
        m = ModuleInfo(connections[0].node())
        return m.getRoot() if root else m