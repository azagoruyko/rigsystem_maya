<module name="ChainSC" muted="0" uid="203d121acbad47729699bf7ed6ff4b67">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
transforms = [proxy.node(node) for node in @transforms]

if len(transforms) < 2:
    error("ChainSC needs at least two transforms.")

scJoints = []

for transform, nextTransform in zip(transforms, transforms[1:]):
    transformName = f"{transform.namespace()}{transform.localName()}"

    startJoint = proxy.create("joint", f"{transformName}_sc_joint")
    cmds.matchTransform(startJoint, transform)

    endJoint = proxy.create("joint", f"{transformName}_sc_end_joint", parent=startJoint)
    cmds.matchTransform(endJoint, nextTransform, position=True, rotation=False)
    cmds.matchTransform(endJoint, startJoint, position=False, rotation=True)

    ikHandle = proxy.node(cmds.ikHandle(
        n=f"{transformName}_sc_ikHandle",
        sj=startJoint,
        ee=endJoint,
        solver="ikSCsolver",
    )[0])
    cmds.pointConstraint(transform, startJoint, mo=True)
    cmds.parentConstraint(nextTransform, ikHandle, mo=True)
    cmds.orientConstraint(startJoint, transform, mo=True)

    scJoints.append(str(startJoint))

@set_out_sc_joints(scJoints)]]></run>
<doc><![CDATA[## Summary
Builds one independent two-joint SC IK segment for each adjacent pair of input transforms. The current transform positions the start joint, the next transform drives the IK handle, and the start joint drives the current transform's rotation.

## Inputs
- **transforms** – Ordered list of at least two Maya transforms. Each entry except the last is oriented toward the next entry.

## Outputs
- **out_sc_joints** – Start joints named `<transformName>_sc_joint`, one for each adjacent pair. Each end joint is named `<transformName>_sc_end_joint`, and its handle is named `<transformName>_sc_ikHandle`.

## Usage
Set the ordered transforms, then run the module. The last transform is a target only because it has no successor. Use independent target transforms; a target parented beneath the transform it helps rotate can create a Maya dependency cycle.]]></doc>
<attributes>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["joint1", "joint2", "joint3", "joint4", "joint5"], "default": "items"}]]></attr>
<attr name="out_sc_joints" template="listBox" category="Output" connect=""><![CDATA[{"items": ["joint1_sc_joint", "joint2_sc_joint", "joint3_sc_joint", "joint4_sc_joint"], "default": "items"}]]></attr>
</attributes>
</module>