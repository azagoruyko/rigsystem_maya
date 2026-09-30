<module name="BendRig" muted="0" uid="c936e465689042df9808edc3ab5e712f">
<run><![CDATA[import pymel.core as pm
import rig_utils

point1 = pm.PyNode(@point1)
point2 = pm.PyNode(@point2)

rotate1 = pm.PyNode(@rotate1)
rotate2 = pm.PyNode(@rotate2)

internalParent = pm.PyNode("internal")
controlsParent = pm.PyNode("controls")
helpersParent = pm.PyNode("helpers")

mainControl = pm.PyNode("main_control")

if @mode == 0:
    scale = rig_utils.getDistance(point1, point2) / 10.0

    @helper = rig_utils.curve.makeCurve(@name + "_helper", "axis")
    pm.delete(pm.parentConstraint([point1, point2], helper))

    @helper.s.set([scale, scale, scale])
    helpersParent | @helper
    @set_helper(str(@helper))

elif @mode == 1:
    helper = pm.PyNode(@helper)
    joints = [pm.PyNode(j) for j in @joints]

    if @updateJointsPos:
        numJoints = len(joints)
        p1 = point1.getTranslation("world")
        p2 = point2.getTranslation("world")
        for i in range(numJoints):
            perc = i / float(numJoints)
            pos = p1 + (p2 - p1) * perc
            joints[i].setTranslation(pos, "world")

    startTransform = pm.createNode("transform", n=@name + "_start_transform")
    endTransform = pm.createNode("transform", n=@name + "_end_transform")

    internalParent | startTransform | endTransform

    plane = pm.nurbsPlane(p=[0, 0, 0],
                          ax=[0, 1, 0],
                          w=1,
                          lr=1,
                          d=3,
                          u=len(@joints),
                          v=1,
                          ch=False,
                          n=@name + "_plane")[0]

    plane.inheritsTransform.set(False)
    plane.template.set(True)

    startTransform | plane

    actualNumControls = @numControls + 2
    lattice = pm.lattice(plane,
                         divisions=[actualNumControls, 2, 2],
                         objectCentered=True,
                         ldv=[2, 2, 2],
                         ol=1,
                         n=@name + "_lattice")
                         
    startTransform | lattice[1]
    startTransform | lattice[2]

    lattice[1].inheritsTransform.set(False)
    lattice[2].inheritsTransform.set(False)

    lattice[1].v.set(False)
    lattice[2].v.set(False)

    controlJoints = []
    controlsGroup = pm.createNode("transform", n=@name + "_controls", p=controlsParent)
    pm.parentConstraint(startTransform, controlsGroup, mo=True)

    controls = []
    for i in range(actualNumControls):  # both tips must be present
        transform = pm.createNode("transform", n=@name + "_" + str(i + 1) + "_control_null", p=controlsGroup)

        perc = i / float(actualNumControls - 1)

        pc = pm.pointConstraint(startTransform, endTransform, transform)
        pc.w0.set(1 - perc)
        pc.w1.set(perc)

        oc = pm.orientConstraint(startTransform, endTransform, transform, mo=True, skip=["y", "z"])
        oc.interpType.set(2)  # shortness
        oc.w0.set(1 - perc)
        oc.w1.set(perc)

        controlPrefix = "transform" if i == 0 or i == actualNumControls - 1 else "control"
        control = pm.createNode("transform", n=@name + "_" + str(i + 1) + "_" + controlPrefix, p=transform)

        j = pm.createNode("joint", n=@name + "_" + str(i + 1) + "_control_joint", ss=True, p=startTransform)
        j.radius.set(0.5)
        pm.parentConstraint(control, j)
        controlJoints.append(j)

        if i > 0 and i < actualNumControls - 1:
            hlp = helper.duplicate()[0]
            s = hlp.s.get()
            pm.matchTransform(hlp, control)
            hlp.s.set(s)
            rig_utils.curve.makeFromCurve(control, hlp)
            pm.delete(hlp)
            rig_utils.lockTRS(control, [], [1, 1, 1], [1, 1, 1], 1)

            controls.append(control)

    startTransform.tx.set(-0.5)
    endTransform.tx.set(1)

    pm.skinCluster(controlJoints, lattice[1], tsb=True, dr=20)

    pm.pointConstraint(point1, startTransform)
    pm.pointConstraint(point2, endTransform)

    pm.orientConstraint(rotate1, startTransform)
    pm.orientConstraint(rotate2, endTransform, mo=True)

    for i in range(len(@joints)):
        p, u, v = plane.closestPoint(joints[i].getTranslation("world"))

        surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_" + str(i + 1) + "_onSurface", plane, u, v)
        startTransform | surfaceTransform

        pm.parentConstraint(surfaceTransform, @joints[i], mo=True, decompRotationToChild=True)

    rig_utils.makeSurfaceTransform(@name + "_" + len(@joints) + "_onSurface", plane, 1.0, 0.5) # keep the last one

    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@name)
    moduleInfo.setAttr("type", "bendRig")

    for i, ctrl in enumerate(controls):
        moduleInfo.setAttr("control" + str(i + 1), ctrl.message)
]]></run>
<doc><![CDATA[## Summary
Creates a flexible bend rig between two target points using a NURBS plane, lattice deformer, and control nulls. In **Helpers** mode it generates a guide curve; in **Run** mode it builds the full rig, positions twist joints, creates control joints, skins the lattice, and publishes a `moduleInfo` node for downstream modules.

## Inputs
- **`mode`** (`radioButton`):  
  - `0` – *Helpers*: generate a guide curve between `point1` and `point2`.  
  - `1` – *Run*: build the bend rig using the previously created helper.
- **`name`** (`lineEditAndButton`): Base name for all created nodes (e.g., `L_arm_1_bendRig`).
- **`numControls`** (`lineEditAndButton`): Number of intermediate control nulls to create (actual count = `numControls + 2` to include start and end).
- **`point1`** (`lineEditAndButton`): Transform node at the start of the bend (e.g., shoulder joint).
- **`point2`** (`lineEditAndButton`): Transform node at the end of the bend (e.g., wrist or bend control).
- **`rotate1`** (`lineEditAndButton`): Transform used to orient the start of the rig (e.g., twist extractor joint).
- **`rotate2`** (`lineEditAndButton`): Transform used to orient the end of the rig (e.g., end joint).
- **`joints`** (`listBox`): List of twist joints that will be positioned along the bend curve.
- **`helper`** (`lineEditAndButton`): Name of the guide curve created in Helpers mode; used as the source curve in Run mode.
- **`updateJointsPos`** (`checkBox`): When checked, the module will reposition the twist joints along the line between `point1` and `point2` before building the rig.

## Outputs
- **`helper`**: The guide curve node created in Helpers mode (also used as the source curve in Run mode).
- **`moduleInfo`** (`ModuleInfo` node): Publishes the rig type (`bendRig`) and messages to each control joint (`control1`, `control2`, …). This node is the primary interface for downstream modules.
- **Control joints**: For each control null, a joint is created and parented under the start transform. These joints are exposed via the `moduleInfo` node.
- **Lattice and NURBS plane**: Deformers that drive the twist joints; not directly exposed but form the core of the rig.

## Usage
1. **Setup**  
   - Assign the target start and end transforms to `point1` and `point2`.  
   - Specify the twist joints in the `joints` list.  
   - Set `numControls` to the desired number of intermediate controls.  
   - Enable `updateJointsPos` if you want the twist joints to be automatically repositioned along the line.

2. **Generate Helper**  
   - Switch `mode` to **Helpers** and execute.  
   - A guide curve named `<name>_helper` will appear between `point1` and `point2`.  
   - Adjust the curve or its scale if needed.

3. **Build the Rig**  
   - Switch `mode` to **Run** and execute.  
   - The module will create the lattice, control nulls, joints, constraints, and skinCluster.  
   - The `moduleInfo` node will contain messages to each control joint.

4. **Connect to Downstream Modules**  
   - Use the `moduleInfo` node or the individual control joint messages to link this bend rig to other rig components (e.g., a twist chain or a secondary animation layer).]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "L_arm_1_bendRig", "buttonEnabled": false}]]></attr>
<attr name="numControls" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": 1, "buttonEnabled": false}]]></attr>
<attr name="point1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="point2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_bend_control"}]]></attr>
<attr name="rotate1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_twistExtractor_1_joint"}]]></attr>
<attr name="rotate2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"current": -1, "items": ["L_arm_1_twist_1_joint", "L_arm_1_twist_2_joint", "L_arm_1_twist_3_joint"], "default": "items"}]]></attr>
<attr name="helper" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_bendRig_helper"}]]></attr>
<attr name="updateJointsPos" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
</attributes>
</module>