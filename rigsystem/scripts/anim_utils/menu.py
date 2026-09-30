class Menu(object):
    """Hierarchical menu used in dagMenuProc to build a Maya viewport menu."""

    def __init__(self, name="", command=None, altCommand=None, icon=""):
        self.name = name
        self.command = command
        self.altCommand = altCommand
        self.icon = icon

        self.children = []

    def isEmpty(self):
        """Return True if the menu has no child items."""
        return len(self.children) == 0

    def show(self, indent=""):
        """Print menu tree to console (debug)."""
        print(indent + self.name)
        for ch in self.children:
            ch.show(indent + "  ")

    def addMenu(self, otherMenu):
        """Append another menu as a child."""
        self.children.append(otherMenu)

    def mergeMenu(self, otherMenu):
        """Append all children of otherMenu to this menu."""
        for ch in otherMenu.children:
            self.children.append(ch)

    def addChild(self, *args, **kwargs):
        """Create and append a child menu; return it."""
        ch = Menu(*args, **kwargs)
        self.children.append(ch)
        return ch

    def find(self, name, recursive=True):
        """Return first child menu with the given name, or None."""
        for ch in self.children:
            if ch.name == name:
                return ch
            
            if recursive:
                found = ch.find(name, recursive)
                if found:
                    return found

    def buildIn(self, parent):
        """Build this menu into the given Maya UI parent (e.g. from dagMenuProc)."""
        import pymel.core as pm

        def buildIn_local(menu):
            for child in menu.children:
                if not child.isEmpty():
                    pm.menuItem(label=child.name, sm=True, i=child.icon, to=True)
                    buildIn_local(child)
                else:
                    if child.name == "-":
                        pm.menuItem(divider=True)

                    else:
                        if callable(child.command):
                            pm.menuItem(label=child.name, c=pm.Callback(child.command), i=child.icon)

                        if callable(child.altCommand):
                            pm.menuItem(optionBox=True, c=pm.Callback(child.altCommand))

            pm.setParent("..", m=True)

        pm.setParent(parent, m=True)
        buildIn_local(self)
