<module name="makeSurfaceTransforms" muted="0" uid="4f767e9fccee4ad495c3ae0f8cf33d25">
<run><![CDATA[import pymel.core as pm
import maya.cmds as cmds
import rig_utils

surface = pm.PyNode(@surface)
surface_shape = surface.getShape()
prefix = @name
number = int(@number)
along = @along

if number < 1:
    error("Number of transforms must be at least 1.")

if along not in ("u", "v"):
    error("Along must be either 'u' or 'v'.")

u_min = cmds.getAttr(surface_shape + ".minValueU")
u_max = cmds.getAttr(surface_shape + ".maxValueU")
v_min = cmds.getAttr(surface_shape + ".minValueV")
v_max = cmds.getAttr(surface_shape + ".maxValueV")

transforms = []
for index in range(number):
    fraction = float(index) / max(number - 1, 1)

    if along == "u":
        u = u_min + (u_max - u_min) * fraction
        v = (v_min + v_max) * 0.5
    else:
        u = (u_min + u_max) * 0.5
        v = v_min + (v_max - v_min) * fraction

    transform = rig_utils.makeSurfaceTransform(
        "{}_{}".format(prefix, index + 1),
        surface,
        u,
        v,
    )
    transforms.append(transform.name())

@set_out_transforms(transforms)
]]></run>
<doc><![CDATA[## Summary
Creates a series of evenly spaced transform nodes along a NURBS surface in either the U or V direction. The module generates a list of transform names that can be used by downstream modules for positioning or rigging purposes.

## Inputs
- **`surface`**: The NURBS surface node on which the transforms will be placed.
- **`name`**: Prefix used for naming each generated transform node.
- **`number`**: Integer count of transforms to create (must be ≥ 1).
- **`along`**: Direction along the surface to distribute the transforms; accepts `"u"` or `"v"`.

## Outputs
- **`out_transforms`**: A list of the names of all created transform nodes, in order from the start to the end of the chosen surface direction.

## Usage
1. Provide a valid NURBS surface node to `surface`.
2. Set `name` to the desired prefix for the transforms.
3. Specify `number` (≥ 1) for how many transforms you want.
4. Choose `along` as `"u"` or `"v"` to distribute the transforms along the U or V axis.
5. Execute the module; the resulting transform names will be available in `out_transforms` for further processing or connection to other rig components.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Generate evenly spaced surface transforms along U or V."}]]></attr>
<attr name="surface" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "belt_surface", "placeholder": "NURBS surface name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "belt", "placeholder": "Transform name prefix", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="number" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": 5, "placeholder": "Number of transforms", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 1, "max": 100, "validator": 1}]]></attr>
<attr name="along" template="comboBox" category="General" connect=""><![CDATA[{"default": "current", "items": ["u", "v"], "current": "u"}]]></attr>
<attr name="out_transforms" template="listBox" category="Output" connect=""><![CDATA[{"default": "items", "items": ["belt_1_transform", "belt_2_transform", "belt_3_transform", "belt_4_transform", "belt_5_transform"]}]]></attr>
</attributes>
</module>