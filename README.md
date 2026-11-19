# RigSystem for Maya

![GitHub Tag](https://img.shields.io/github/v/tag/azagoruyko/rigsystem_maya?label=Version)

RigSystem is a Maya rigging toolkit with Python utilities, plug-ins, and [Rig Builder](https://github.com/azagoruyko/rigBuilder) modules.

<p align="center">
  <img src="https://github.com/user-attachments/assets/012cb13b-830c-4563-90f3-6304ac3aea4e" width="800" />
</p>

## Requirements

- Maya 2026 on Windows (`win64`). The bundled plug-ins are built for this configuration.
- [Rig Builder](https://github.com/azagoruyko/rigBuilder) to browse and run the `.rb` modules.

Maya 2026 uses Python 3.11. Other Maya versions and platforms are not currently supported.

## Install

For a walkthrough, see the [installation video](https://www.youtube.com/watch?v=g7IWIPeaabQ).

1. Set `MAYA_MODULE_PATH` to the repository root — the folder containing `rigsystem.mod`.
2. Restart Maya.
3. In Rig Builder, open **Manage Workspaces** from the gear button beside the workspace selector.
4. Create a workspace named **RigSystem**.
5. Add this repository's `rigsystem/rb_modules` folder as a dependency module path, then select the RigSystem workspace.

In interactive Maya, RigSystem loads its bundled plug-ins and adds the animation menu to the viewport at startup. No extra `MAYA_SCRIPT_PATH` or `PYTHONPATH` entry is needed. If you previously installed a custom `dagMenuProc.mel` for RigSystem, remove that override and restart Maya.

### Connect Rig Builder to Maya

1. In Rig Builder, open **Host Manager** using the gear button beside the host selector.
2. Under **Host Startup Code Generator**, select **Maya** and copy the generated startup script.
3. In Maya's Script Editor, select the Python tab, paste the script, and run it.
4. Select the detected Maya host in Rig Builder.

To connect automatically on startup, add the generated script to the `userSetup.py` that Maya runs.

## Build your first rig

1. Open `rigsystem/library/biped_body_template.ma` in Maya.
2. In Rig Builder, select the **RigSystem** workspace.
3. Insert `Assemblies/Biped/Biped` (press **Tab** and search for it).
4. Press **Run**.
5. Save the generated rig as a separate build/animation scene.

## Build a custom rig

[`Pipeline/MyPipeline`](rigsystem/rb_modules/Pipeline/MyPipeline.rb) groups reusable modules for custom biped, quadruped, prop, and other rigs. Insert it in Rig Builder with **Tab**, then choose the tools you need:

| Group | Purpose |
| --- | --- |
| **Fitting** | Create a rig hierarchy, import a biped template, and fit or mirror guides. |
| **Controls** | Create control shapes, FK controls, and corrective controls. |
| **Deform** | Work with skin weights, bind matrices, and blend shapes. |
| **Attachments** | Attach rig elements to curves, meshes, and surfaces. |
| **Face** | Build lips, eyelids, brows, and teeth. |

For a new scene, start with `Fitting/RigHierarchy` or import the biped template with `Fitting/ImportBipedBodyTemplate`. You can save `MyPipeline` in your own workspace and extend it with custom modules and settings.

## Rig development workflow

Keep the working scene separate from the scene delivered for animation:

| Scene | Use |
| --- | --- |
| **Source** | Working scene; may contain guides, helpers, and intermediate geometry. |
| **Build** (or **Anim**) | Generated scene for animators, built from the source scene. |

Make scene changes in the source file. To change how the rig is built, edit and rerun its Rig Builder `.rb` module. Do not edit the build scene directly; regenerate it from the source and module.

### Fit and place guides

- Fit the template skeleton by moving and rotating its joints. Preserve each joint's local axes and orientation; build modules use them to construct the rig.
- For the biped, use the helpers in the template's `helpers` group, or set the `Biped` module's `mode` to **Helpers** and run it to create guides.
- Fit helper curves by editing their CVs. Mirror one side with `Pipeline/Symmetry/MirrorCurves`.
- Set the `Biped` module's `mode` to **Run** and run it again to build the animation rig.
- To reposition a control later, adjust its helper in the source scene and rebuild.

## Viewport animation menu

Select a rig control and right-click in the viewport to see its actions. With multiple transforms selected, the menu uses the last selected transform; it does not inspect the object under the cursor. Maya's standard menu appears when the selection has no RigSystem actions.

## Bundled plug-ins

The following Maya plug-ins are included as compiled `.mll` files. Their source is maintained separately:

| Plug-in | Source |
| --- | --- |
| `animClip.mll` | [animClip](https://github.com/azagoruyko/animClip) |
| `colliders.mll` | [colliders](https://github.com/azagoruyko/colliders) |
| `skeleposer.mll` | [skeleposer](https://github.com/azagoruyko/skeleposer) |

## Contributing

- Maya scripts: `rigsystem/scripts/rigsystem`
- Rig Builder modules: `rigsystem/rb_modules`
- For Rig Builder application changes or plug-in source changes, contribute to their respective repositories.

When opening a pull request, include the affected component, Maya version, and how you tested the change.

## Versions

Version numbers use `major.minor.patch`: a major release can change existing workflows, a minor release adds features, and a patch release fixes problems without intentionally changing workflows.

| Version | What changed |
| --- | --- |
| `v1.0.0` | First tagged RigSystem release. |
| `v2.0.0` | Moved Maya tools into the `rigsystem` Python package and installed the viewport menu without replacing Maya's `dagMenuProc.mel`. |
| `v3.0.0` | Removed the PyMEL dependency from Python utilities and Rig Builder modules, replacing it with `maya.cmds`, Maya API 2.0, and `rigsystem.proxy`. Added face rig templates and fitting modules. |

For exact release changes, compare a Git tag with the previous tag.

## License

See [`LICENSE`](LICENSE). Plug-in source licenses are listed in their respective repositories.
