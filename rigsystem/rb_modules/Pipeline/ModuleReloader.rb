<module name="ModuleReloader" muted="0" uid="40c8f95e8f024df598e1241589afca6f">
<run><![CDATA[import sys
import os
import ast
import types
import traceback

# Python 2/3 compatible reload function resolution
try:
    from importlib import reload as reload_module
except ImportError:
    try:
        from imp import reload as reload_module
    except ImportError:
        reload_module = reload


def getSourcePath(filePath):
    """Convert compiled path (.pyc) to source path (.py) across Python 2 and 3."""
    if not filePath:
        return ""
    if filePath.endswith(".pyc"):
        try:
            import importlib.util
            return importlib.util.source_from_cache(filePath)
        except Exception:
            return filePath[:-1]
    return filePath


def getAstDependencies(moduleName, filePath):
    """Parse Python source file via AST to extract absolute/relative sub-module dependencies."""
    deps = set()
    sourcePath = getSourcePath(filePath)
    if not sourcePath or not os.path.isfile(sourcePath):
        return deps
    try:
        with open(sourcePath, "rb") as f:
            tree = ast.parse(f.read())
    except Exception:
        return deps

    parts = moduleName.split(".")
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            deps.update(alias.name for alias in node.names)
        elif isinstance(node, ast.ImportFrom):
            level = node.level or 0
            base = ".".join(parts[:-level]) if level > 0 and level <= len(parts) else ""
            module = node.module or ""
            resolved = "{0}.{1}".format(base, module) if (base and module) else (base or module)
            if resolved:
                deps.add(resolved)
                deps.update("{0}.{1}".format(resolved, alias.name) for alias in node.names)
    return deps


def getNamespaceDependencies(module, reloadSet):
    """Inspect module dictionary values to find referenced dependencies in reloadSet."""
    deps = set()
    for val in list(getattr(module, "__dict__", {}).values()):
        name = getattr(val, "__name__" if isinstance(val, types.ModuleType) else "__module__", None)
        if name in reloadSet:
            deps.add(name)
    return deps


def resolveReloadOrder(topLevelName):
    """Calculate recursive reload sequence (topological sort) for sub-modules."""
    reloadSet = {
        name for name in sys.modules
        if (name == topLevelName or name.startswith(topLevelName + "."))
        and sys.modules[name] is not None
    }
    dependencies = {name: set() for name in reloadSet}

    for name in reloadSet:
        module = sys.modules[name]
        dependencies[name].update(getNamespaceDependencies(module, reloadSet))
        filePath = getattr(module, "__file__", None)
        if filePath:
            dependencies[name].update(getAstDependencies(name, filePath) & reloadSet)
        dependencies[name].discard(name)

    visited, order = {}, []
    def visit(node):
        if visited.get(node):
            return
        visited[node] = 1
        for dep in sorted(dependencies[node]):
            visit(dep)
        order.append(node)

    for node in sorted(reloadSet):
        visit(node)
    return order


def reloadModuleRecursive(topLevelName):
    """Reload top-level module and loaded sub-modules in correct topological sequence."""
    order = resolveReloadOrder(topLevelName)
    if not order:
        return False

    success = True
    for name in order:
        if name in sys.modules:
            try:
                print("Reloading: {0}".format(name))
                reload_module(sys.modules[name])
            except Exception as e:
                success = False
                warning("Failed to reload: {0}\nError: {1}\n{2}".format(name, e, traceback.format_exc()))
    return success


targets = list(dict.fromkeys(@modules))
if not targets:
    error("No modules listed. Enter a filter and click List modules.")

for name in targets:
    if name not in sys.modules:
        warning("Module '{0}' is not loaded. Skipping.".format(name))
        continue

    reloadModuleRecursive(name)
]]></run>
<doc><![CDATA[## Summary
Lists loaded Python modules by name filter, then reloads the modules in the list and their loaded submodules in dependency order. Uses the same AST and namespace dependency analysis as the Maya Module Reloader script.

## Inputs
- **`filter`**: Case-insensitive name fragment used by **List modules**. Enter a nonempty filter.
- **`modules`**: List of loaded Python module names to reload. The button fills this list; you can edit it before running.

## Outputs
- Updates the `modules` list when **List modules** is clicked. Running reloads the listed modules in the current Maya process and reports progress and failures in Rig Builder output.

## Usage
1. Enter a module name fragment in `filter` and click **List modules**.
2. Review or edit the resulting `modules` list.
3. Run the module to reload only modules in that list, with loaded dependencies first.]]></doc>
<attributes>
<attr name="filter" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "rig_", "placeholder": "Module name contains", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import os\nimport sys\n\nfilterText = ch(\"/filter\").strip().lower()\nif not filterText:\n    error(\"Enter a module name filter before listing modules.\")\n\ntopLevelNames = set()\nbuiltinNames = set(sys.builtin_module_names)\npythonLibDir = os.path.dirname(os.__file__).lower() if getattr(os, \"__file__\", None) else \"\"\n\nfor name in sys.modules:\n    if not name:\n        continue\n\n    topName = name.split(\".\")[0]\n    mod = sys.modules.get(topName)\n    if mod is None or topName in builtinNames:\n        continue\n\n    filePath = getattr(mod, \"__file__\", None)\n    if filePath:\n        if pythonLibDir and filePath.lower().startswith(pythonLibDir):\n            continue\n    elif not getattr(mod, \"__path__\", None):\n        continue\n\n    if filterText in topName.lower():\n        topLevelNames.add(topName)\n\nchset(\"/modules\", sorted(topLevelNames))\n", "label": "List modules", "color": "", "default": "command"}]]></attr>
<attr name="modules" template="listBox" category="General" connect=""><![CDATA[{"items": ["rig_utils"], "current": 0, "default": "items"}]]></attr>
</attributes>
</module>