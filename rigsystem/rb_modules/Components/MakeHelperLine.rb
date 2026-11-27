<module name="MakeHelperLine" muted="0" uid="78501955f0af4ef7a8eca0615de9ff76">
<run><![CDATA[from rigsystem import rig_utils
rig_utils.makeHelpLine(@name, @transforms)]]></run>
<doc><![CDATA[## Summary
Wraps the `rig_utils.makeHelpLine` utility to build a named helper line (a guide/curve strung through a set of scene transforms) used during rig construction and placement. It is a lightweight helper module rather than a full rig builder.

## Inputs
- **`name`**: Identifier assigned to the generated helper line, used to name/label the resulting node so it can be referenced later (e.g. by downstream placement or rig modules).
- **`transforms`**: Ordered collection of scene nodes (typically joints, locators, or control transforms) that define the points the helper line passes through. The order of this list determines the path/shape of the line.
- **`rig_utils` (import)**: The underlying `rigsystem.rig_utils` library providing `makeHelpLine`; no additional configuration is exposed beyond the two arguments above.

## Outputs
- **Helper line node (named via `name`)**: The line/curve geometry created by `makeHelpLine`, strung through the supplied `transforms`, serving as a visual guide or placement reference in the scene.
- **No rig controls or joint chains**: This module does not generate IK/FK systems, controllers, or `moduleInfo` containers — it only produces the guide line object.

## Usage
- Ensure `rigsystem.rig_utils` is available on the Python path and that the target transforms (joints/locators) already exist in the scene.
- Set `name` to a meaningful, unique label for the helper line.
- Pass `transforms` as an ordered list matching the intended path of the line (e.g. shoulder → elbow → wrist).
- Execute the module to create the guide line, then use it as a visual/placement reference when configuring or building rig modules.
- Do not expect downstream controller or `moduleInfo` outputs from this module; connect actual rig modules to obtain those.]]></doc>
<attributes>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_cloak", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": [], "default": "items"}]]></attr>
</attributes>
</module>