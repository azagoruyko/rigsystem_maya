<module name="MakeCurveShape" muted="0" uid="1f5e3d986051407397d0b580e70ef628">
<run><![CDATA[from rigsystem import rig_utils
rig_utils.curve.makeCurve(@name, @curveType)]]></run>
<doc><![CDATA[## Summary
Creates a rig curve by delegating to `rig_utils.curve.makeCurve` with a specified name and curve type. This is a minimal curve-generation wrapper; it does not build rig controls, joints, or publish module interface data itself.

## Inputs
- **`name`** (`@name`): Name assigned to the generated curve/transform. Passed directly to `rig_utils.curve.makeCurve` for curve creation.
- **`curveType`** (`@curveType`): Curve shape/type identifier passed to `rig_utils.curve.makeCurve` to select the curve definition or generation mode supported by that helper.

## Outputs
- **Generated curve**: The curve object/node produced by `rig_utils.curve.makeCurve`. No output is explicitly assigned or published in this module, so downstream usage should rely on the helper’s return value or locate the generated node by its `name`.
- **No `moduleInfo` or rig-control outputs**: This module does not create a pipeline container, controllers, joints, or other rig-system outputs.

## Usage
- Provide a valid `name` for the curve to be created.
- Provide the desired `curveType` accepted by `rig_utils.curve.makeCurve`.
- Execute the module to create the curve in the current rig scene.
- Use the value returned by `rig_utils.curve.makeCurve` or locate the generated node by `name` when connecting it to downstream rig logic.]]></doc>
<attributes>
<attr name="curveType" template="comboBox" category="General" connect=""><![CDATA[{"items": ["arc", "arrow", "axis", "circle", "cross", "cube", "diamond", "flag", "guide", "key", "plus", "pyramid", "rect", "sphere", "triangle"], "current": "cube", "default": "current"}]]></attr>
<attr name="" template="button" category="General" connect=""><![CDATA[{"command": "import os\nfrom rigsystem import rig_utils\n\ncurves = sorted(\n    os.path.splitext(filename)[0]\n    for filename in os.listdir(rig_utils.curve.CurvesPath)\n    if filename.endswith(\".json\")\n)\ncurrent = ch(\"/curveType\")\nif current not in curves:\n    chset(\"/curveType\", curves[0] if curves else \"\", \"current\")\n\nchset(\"/curveType\", curves, \"items\")", "label": "Get All Curves", "color": "", "default": "command"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>