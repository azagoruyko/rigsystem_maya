# RigSystem for Maya

RigSystem is a **rigging environment for Maya**. It brings together Maya tools, plug-ins, and modules for [Rig Builder](https://github.com/azagoruyko/rigBuilder) in one workflow.

## ⚡ Quick start

After completing the installation steps below:

1. Open `rigsystem/library/biped_body_template.ma` in Maya.
2. Open Rig Builder and select the RigSystem workspace.
3. Insert the `Characters/Biped` module by pressing Tab.
4. Press **Run**.

The full featured bipedal rig is ready for animation,

## 🧪 Compatibility

> [!IMPORTANT]
> **Pilot support:** Maya 2026 on Windows (`win64`). The bundled `.mll` plug-ins are built for this configuration. Other Maya versions may be added as needed, after their builds have been tested.

The scripts use **Python 3.11** inside Maya. Autodesk lists Python 3.11.4 for [Maya 2026](https://help.autodesk.com/cloudhelp/2026/ENU/Maya-DEVHELP/files/Maya_DEVHELP_Open_Source_Components_html.html).

## 📦 What's included

| Path | Contents |
| --- | --- |
| `rigsystem/scripts` | Maya rigging and animation scripts |
| `rigsystem/rb_modules` | Modules to run in Rig Builder |
| `rigsystem/platforms/2026/win64` | Maya 2026 plug-ins and platform-specific scripts |
| `rigsystem/library` | Maya scene assets and templates |

## 🧩 Dependencies

The following plug-ins are included as compiled `.mll` files. Their source code is maintained in separate repositories:

| Bundled plug-in | Source repository |
| --- | --- |
| `animClip.mll` | [`animClip`](https://github.com/azagoruyko/animClip) |
| `colliders.mll` | [`colliders`](https://github.com/azagoruyko/colliders) |
| `skeleposer.mll` | [`skeleposer`](https://github.com/azagoruyko/skeleposer) |

The Python scripts and many Rig Builder modules use `PyMEL`. Install it in the Maya 2026 Python environment if it is not already available. [Rig Builder](https://github.com/azagoruyko/rigBuilder) is a separate application required to use the modules in `rigsystem/rb_modules`.

## 🚀 Installation

Set `MAYA_MODULE_PATH` to the **repository root**, the folder containing `rigsystem.mod`.

The module definition points to `./rigsystem` and its Maya 2026 Windows plug-ins.

### 🎬 Viewport animation menu

To enable RigSystem's animation tools in Maya's viewport right-click menu, follow [`dagMenuProc.txt`](rigsystem/platforms/2026/win64/scripts/dagMenuProc.txt). The instructions show how to make a local copy of Maya's `dagMenuProc.mel` and insert the RigSystem call. This menu setup is optional for the rest of RigSystem.

### 🔌 Connect Maya to Rig Builder

1. Start Rig Builder and open **Host Manager** using the gear button next to the host selector.
2. Under **Host Startup Code Generator**, select **Maya** and copy the generated **Startup Script**.
3. In Maya's Script Editor, switch to the Python tab, paste the script, and run it.
4. Select the detected Maya host in Rig Builder.

This starts Rig Builder's host connection inside Maya so modules can execute there.

### 🛠️ Rig Builder workspace

The recommended setup is to point a dedicated Rig Builder workspace directly to this repository's `rigsystem/rb_modules` directory:

1. In Rig Builder, open **Manage Workspaces** using the gear button next to the workspace selector.
2. Create or select a workspace for RigSystem.
3. Set **Modules Path** to the full path of `rigsystem/rb_modules` in your local copy of this repository.
4. Switch to that workspace to browse and use the modules.

> [!TIP]
> Pointing **Modules Path** at this repository uses it as a live library: pulling updates refreshes the available modules, and saving a module writes to your local repository copy. To customize modules in a separate workspace, copy the ones you need into that workspace's `modules` directory. Copied modules must be updated separately.

## 🤖 AI and MCP

RigSystem is very AI-friendly: its `.rb` modules contain readable code, structured inputs and outputs, and documentation that an AI assistant can use to understand and extend a rig.

[Rig Builder](https://github.com/azagoruyko/rigBuilder) provides an MCP server that lets compatible AI clients search the workspace library, inspect and edit the active module tree, and run modules through a connected Maya host. Select the RigSystem workspace, keep Rig Builder running, and connect your client using Rig Builder's **Copy MCP Config** option. See the [Rig Builder MCP setup](https://github.com/azagoruyko/rigBuilder#6-connect-an-mcp-client) for details.

## 🤝 Contributions

Contributions to the Maya package belong in this repository:

- Add or improve Rig Builder modules in `rigsystem/rb_modules`.
- Add or improve Maya rigging and animation scripts in `rigsystem/scripts`.
- Report issues with the packaged Maya module, its installation, or bundled builds here.

For changes to Rig Builder itself, use the [Rig Builder repository](https://github.com/azagoruyko/rigBuilder). For plug-in source changes, contribute to [`animClip`](https://github.com/azagoruyko/animClip), [`colliders`](https://github.com/azagoruyko/colliders), or [`skeleposer`](https://github.com/azagoruyko/skeleposer) in their respective repositories.

When opening a pull request here, describe the affected component, the Maya version used, and how you tested the change in Maya.

## 📄 License

See [`LICENSE`](LICENSE) for this repository. Refer to the linked plug-in repositories for their source licenses.
