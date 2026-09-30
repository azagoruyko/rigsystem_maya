# RigSystem for Maya

RigSystem is a **rigging environment for Maya**. It brings together Maya tools, plug-ins, and modules for [Rig Builder](https://github.com/azagoruyko/rigBuilder) in one workflow.

<img width="742" height="246" alt="image" src="https://github.com/user-attachments/assets/aab61922-3b0b-4d20-b443-0cb86bef4f25" />

## ⚡ Quick start

After completing the installation steps below:

1. Open `rigsystem/library/biped_body_template.ma` in Maya.
2. Open Rig Builder and select the RigSystem workspace.
3. Insert the `Assemblies/Biped/Biped` module by pressing Tab.
4. Press **Run**.
5. Save the resulting rig as a separate build/anim scene.

The full featured bipedal rig is ready for animation.

## 📂 Source and build scenes

Each rig should have two Maya scene files:

| Scene | Purpose |
| --- | --- |
| `source` | The rigger's working scene. It can keep guides, helpers, intermediate geometry, and anything else needed to develop the rig. |
| `build` (`anim`) | The generated scene for animators. The build scripts turn the source into a clean, optimized rig ready for animation. |

Make all scene changes in the `source` file. If the build logic needs to change, update its Rig Builder `.rb` module. Never edit the `build` scene directly: run the module again to reproduce it from the `source` scene and the `.rb` module.

### 🦴 Fit the skeleton

In the `source` scene, fit the template skeleton to the character by moving and rotating its bones along the available axes. Preserve each joint's local axes and orientation while adjusting its position and pose; the build modules use those axes to construct the rig.

### 📍 Place the helpers

Helpers are rigging guides in the `source` scene, not animation controls.

For `Biped`, the supplied template already contains helpers under the `helpers` group:

1. Use the template's existing helpers, or set the `Biped` module's `mode` to **Helpers** and run it to create guides for a new source scene.
2. Fit most helpers by editing their curve points (CVs).
3. Select the adjusted curves on one side and run `Pipeline/Symmetry/MirrorCurves` to mirror their shapes to the opposite side.
4. Switch `mode` to **Run** and execute the module again. The build uses the helpers to create an animation rig.

To change a control's placement later, adjust its helper in the `source` scene and rebuild the `build` scene.

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

## 🧪 Compatibility

> [!IMPORTANT]
> **Pilot support:** Maya 2026 on Windows (`win64`). The bundled `.mll` plug-ins are built for this configuration. Other Maya versions may be added as needed, after their builds have been tested.

The scripts use **Python 3.11** inside Maya. Autodesk lists Python 3.11.4 for [Maya 2026](https://help.autodesk.com/cloudhelp/2026/ENU/Maya-DEVHELP/files/Maya_DEVHELP_Open_Source_Components_html.html).

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

To start the connection automatically with Maya, append the generated **Startup Script** to your `userSetup.py` that Maya runs at startup.

### 🛠️ Rig Builder workspace (recommended workflow)

Create a dedicated Rig Builder workspace and copy the RigSystem modules into it:

1. In Rig Builder, open **Manage Workspaces** using the gear button next to the workspace selector.
2. Create a workspace named **RigSystem**.
3. Find its **Modules Path** in the workspace settings. Copy the *contents* of this repository's `rigsystem/rb_modules` directory into that folder.
4. Select the RigSystem workspace to browse and use the copied modules.

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
