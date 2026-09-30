<module name="wheel" type="Others/Wheel" muted="0" uid="a691834bf052466aae538d215056b75c">
<run><![CDATA[import pymel.core as pm

@start = pm.PyNode(@start)
@end = pm.PyNode(@end)
@center = pm.PyNode(@center)

expr = '''
float $RADIUS = %radius;

vector $forward = <<%end.tx - %start.tx,
                    %end.ty - %start.ty,
                    %end.tz - %start.tz>>;

vector $prevTranslate = <<%transform.prevTranslateX,
                          %transform.prevTranslateY,
                          %transform.prevTranslateZ>>;

vector $newTranslate = <<%transform.translateX,
                         %transform.translateY,
                         %transform.translateZ>>;

float $cx = $newTranslate.x - $prevTranslate.x;
float $cy = $newTranslate.y - $prevTranslate.y;
float $cz = $newTranslate.z - $prevTranslate.z;

float $distance = sqrt($cx*$cx + $cy*$cy + $cz*$cz);

float $angle = floor(rad_to_deg(angle($forward, <<$cx,$cy,$cz>>)));
float $dctrl = $angle < 90 ? 1 : ($angle == 90 ? 0 : -1);

float $value = $dctrl * (( $distance / (6.2831 * $RADIUS)) * 360.0);
%transform.rotateX = %transform.rotateX + $value;

%transform.prevTranslateX = $newTranslate.x;
%transform.prevTranslateY = $newTranslate.y;
%transform.prevTranslateZ = $newTranslate.z;
'''

transform = pm.createNode("transform", n=@name+"_transform")
pm.xform(transform, ws=True, t=@center.getTranslation("world"))

transform.addAttr("prevTranslateX",at="float",k=True)
transform.addAttr("prevTranslateY",at="float",k=True)
transform.addAttr("prevTranslateZ",at="float",k=True)

expr = expr.replace("%radius", str(@radius))
expr = expr.replace("%start", @start.name())
expr = expr.replace("%end", @end.name())
expr = expr.replace("%transform", transform.name())

pm.expression(s=expr,n=@name+"_expression")]]></run>
<doc><![CDATA[## Summary  
Creates a procedural wheel rig that automatically rotates a wheel transform based on the wheel’s forward direction and the distance it has moved. The module uses a start and end transform to define the wheel’s forward axis, a center transform to position the wheel, and a radius value to convert linear travel into rotational degrees. An expression node drives the wheel’s rotation and stores the previous translation to compute incremental movement.

## Inputs  
- **`name`** – Base name for the generated wheel nodes (e.g., `L_wheel_forward`).  
- **`radius`** – Wheel radius in scene units; used to convert travel distance into rotation.  
- **`start`** – Transform node that marks the wheel’s “start” point; defines the forward axis.  
- **`end`** – Transform node that marks the wheel’s “end” point; used with `start` to compute the forward vector.  
- **`center`** – Transform node that determines the world position of the wheel’s rotation node.

## Outputs  
- **`<name>_transform`** – A new transform node positioned at `center`. It contains the attributes `prevTranslateX`, `prevTranslateY`, and `prevTranslateZ` to track the wheel’s previous location.  
- **`<name>_expression`** – An expression node that updates the transform’s `rotateX` each frame based on the wheel’s movement along the forward axis.  
- The transform’s `rotateX` value represents the wheel’s roll and can be connected to downstream animation or rigging modules.

## Usage  
1. **Set up the wheel geometry** – Place the `start`, `end`, and `center` transforms in the scene to define the wheel’s forward direction and position.  
2. **Configure the module** – Enter a suitable `name` and the wheel’s `radius`.  
3. **Run the module** – The script will create the wheel transform and expression node.  
4. **Animate or drive the wheel** – Move the wheel’s transform (or any node that drives its translation) and observe the wheel’s rotation updating automatically.  
5. **Connect downstream** – Use the `<name>_transform` node as a control or reference for other rig components such as suspension or steering systems.]]></doc>
<attributes>
<attr name="name" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "L_wheel_forward", "min": ""}]]></attr>
<attr name="radius" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "100", "validator": 2, "value": 11.2, "min": "0"}]]></attr>
<attr name="start" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "start_transform"}]]></attr>
<attr name="end" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "end_transform"}]]></attr>
<attr name="center" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_wheel_forward_control_null"}]]></attr>
</attributes>
<children>
</children>
</module>