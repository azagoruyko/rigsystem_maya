<module name="JointsToBlocks" muted="0" uid="2682dff45ad54c1cb4ce095b568f4fba">
<run><![CDATA[import fnmatch
import pymel.core as pm

root_name = @rootJoint
if not root_name:
    selected = pm.ls(sl=True, type="joint")
    if not selected:
        error("Set rootJoint or select a root joint in Maya.")
    root_name = selected[0]

root = pm.PyNode(root_name)
if root.type() != "joint":
    error("rootJoint must be a Maya joint.")

diameter = float(@diameter)
ratio = float(@diameterRatio)
skip_pattern = @skipPattern.strip()
attach = @attach
if diameter < 0 or ratio <= 0:
    error("diameter must be nonnegative and diameterRatio must be positive.")

def is_skipped(joint):
    """Match a joint name against the case-sensitive skip glob."""
    return bool(skip_pattern) and fnmatch.fnmatchcase(
        joint.nodeName(), "*{}*".format(skip_pattern)
    )


def included_children(joint):
    """Return joint children that are not in skipped subtrees."""
    return [
        child for child in joint.getChildren(type="joint")
        if not is_skipped(child)
    ]


if is_skipped(root):
    error("rootJoint matches skipPattern.")

blocks = []


def joint_position(joint):
    """Return the joint's world-space position."""
    return pm.dt.Vector(pm.xform(joint, q=True, ws=True, t=True))


def make_block(start, end, joint):
    """Create one block and optionally drive it with the joint matrix."""
    name = joint.nodeName()
    direction = end - start
    length = direction.length()
    if length < 1e-6:
        warning("Skipping zero-length block: {}".format(name))
        return

    width = diameter or length * ratio
    y_axis = direction.normal()
    guide = pm.dt.Vector(0, 0, 1) if abs(y_axis.z) < 0.99 else pm.dt.Vector(1, 0, 0)
    x_axis = y_axis.cross(guide).normal()
    z_axis = x_axis.cross(y_axis).normal()
    center = (start + end) * 0.5

    block = pm.polyCube(w=width, h=length, d=width, ch=True, name="{}_block".format(name))[0]
    blocks.append(block)

    world_matrix = pm.dt.Matrix([
        x_axis.x, x_axis.y, x_axis.z, 0,
        y_axis.x, y_axis.y, y_axis.z, 0,
        z_axis.x, z_axis.y, z_axis.z, 0,
        center.x, center.y, center.z, 1,
    ])
    if attach:
        local_matrix = world_matrix * joint.worldInverseMatrix[0].get()
        pm.xform(block, matrix=local_matrix)
        joint.worldMatrix[0] >> block.offsetParentMatrix

    else:
        pm.xform(block, matrix=world_matrix)


def walk(joint):
    """Follow the joint chain and split only at continuing children."""
    children = included_children(joint)
    if not children:
        return

    continuing = [child for child in children if included_children(child)]
    start = joint_position(joint)

    if not continuing:
        end = sum((joint_position(child) for child in children), pm.dt.Vector()) / len(children)
        make_block(start, end, joint)
        return

    if len(continuing) == 1:
        child = continuing[0]
        make_block(start, joint_position(child), joint)
        walk(child)
        return

    for child in continuing:
        make_block(start, joint_position(child), joint)
        walk(child)


walk(root)
@set_out_blocks([block.name() for block in blocks])
]]></run>
<doc><![CDATA[## Summary
Creates separate rectangular polygon blocks along a Maya joint hierarchy. Only children with their own children start or continue branches; terminal leaf joints define the end of an existing branch.

## Inputs
- `rootJoint`: Root joint name. If empty, uses the selected Maya joint.
- `skipPattern`: Case-sensitive name glob matched anywhere (for example, `twist` or `*_end`). Matching joints and their descendants are excluded before classifying branches and leaves.
- `diameter`: Square cross-section width. Zero uses automatic width.
- `diameterRatio`: Automatic width as a fraction of each block's length.
- `attach`: Connect the starting joint's `worldMatrix` directly to each block's `offsetParentMatrix`. The block follows that joint as one rigid object.

## Outputs
- `out_blocks`: Names of the created mesh transforms. No extra transform groups are created; each block keeps editable `polyCube` construction history.

## Usage
Choose a root joint, optionally set skipPattern, set a fixed diameter or leave it at zero, and enable attach to make each entire block follow its starting joint through `offsetParentMatrix`. Run in Maya. A single continuing child extends the current branch. Multiple continuing children each produce their own block chain; leaf siblings are ignored. When all children are leaves, their average world position ends the current branch. Adjust dimensions or subdivisions later on each block's `polyCube` history node.]]></doc>
<attributes>
<attr name="rootJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_spine_1_joint", "placeholder": "Root joint (or select in Maya)", "buttonCommand": "import maya.cmds as cmds\njoints = cmds.ls(sl=True, type='joint')\nvalue = joints[0] if joints else ''", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="skipPattern" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "average", "placeholder": "Joint name pattern to skip", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="diameter" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0, "placeholder": "0 = automatic", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 2, "default": "value"}]]></attr>
<attr name="diameterRatio" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 0.2, "placeholder": "", "buttonCommand": "", "buttonLabel": "", "buttonEnabled": false, "min": 0, "max": 100, "validator": 2, "default": "value"}]]></attr>
<attr name="attach" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="out_blocks" template="listBox" category="Output" connect=""><![CDATA[{"items": ["M_spine_1_joint_block", "M_spine_2_joint_block", "M_spine_3_joint_block", "M_spine_4_joint_block", "M_spine_5_joint_block", "L_shoulder_joint_block", "L_arm_1_joint_block", "L_arm_2_joint_block", "L_arm_3_joint_block", "L_thumb_1_joint_block", "L_thumb_2_joint_block", "L_thumb_3_joint_block", "L_arm_3_joint_block1", "L_ring_cup_joint_block", "L_ring_1_joint_block", "L_ring_2_joint_block", "L_ring_3_joint_block", "L_ring_cup_joint_block1", "L_pinky_1_joint_block", "L_pinky_2_joint_block", "L_pinky_3_joint_block", "L_arm_3_joint_block2", "L_index_1_joint_block", "L_index_2_joint_block", "L_index_3_joint_block", "L_arm_3_joint_block3", "L_middle_1_joint_block", "L_middle_2_joint_block", "L_middle_3_joint_block", "L_arm_1_joint_block1", "L_arm_1_twist_3_joint_block", "L_shoulder_aim_joint_block", "M_spine_5_joint_block1", "R_shoulder_joint_block", "R_arm_1_joint_block", "R_arm_2_joint_block", "R_arm_3_joint_block", "R_thumb_1_joint_block", "R_thumb_2_joint_block", "R_thumb_3_joint_block", "R_arm_3_joint_block1", "R_ring_cup_joint_block", "R_ring_1_joint_block", "R_ring_2_joint_block", "R_ring_3_joint_block", "R_ring_cup_joint_block1", "R_pinky_1_joint_block", "R_pinky_2_joint_block", "R_pinky_3_joint_block", "R_arm_3_joint_block2", "R_index_1_joint_block", "R_index_2_joint_block", "R_index_3_joint_block", "R_arm_3_joint_block3", "R_middle_1_joint_block", "R_middle_2_joint_block", "R_middle_3_joint_block", "R_arm_1_joint_block1", "R_arm_1_twist_3_joint_block", "R_shoulder_aim_joint_block", "M_spine_5_joint_block2", "M_neck_joint_block", "M_head_joint_block", "L_eye_joint_block", "M_head_joint_block1", "R_eye_joint_block", "M_spine_1_joint_block1", "L_leg_1_joint_block", "L_leg_2_joint_block", "L_leg_3_joint_block", "L_leg_4_joint_block", "M_spine_1_joint_block2", "R_leg_1_joint_block", "R_leg_2_joint_block", "R_leg_3_joint_block", "R_leg_4_joint_block"], "default": "items"}]]></attr>
</attributes>
</module>