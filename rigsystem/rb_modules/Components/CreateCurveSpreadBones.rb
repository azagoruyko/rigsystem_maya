<module name="createCurveSpreadBones" muted="0" uid="71ceb8cb55bb4b3bb800035e3a578fd4">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds

numBones = int(@numBones)

if len(@curves) < 2:
    error("Need at least 2 curves to create spread bones")

if numBones < 1:
    error("Need at least 1 bone set")

curves = proxy.nodes(@curves)
curveShapes = []
for crv in curves:
    shape = crv.getShapes(type="nurbsCurve")[0] if crv.type() == "transform" else crv
    curveShapes.append(shape)

numCurves = len(curveShapes)

# Organization groups at origin
bonesGrp = proxy.create("transform", f"{@name}_spreadBones_group", suffix=False)

allRootJoints = []
allIkHandles = []
allJoints = []

for i in range(numBones):
    param = float(i) / (numBones - 1) if numBones > 1 else 0.5

    # Sample positions on each curve at this parameter
    positions = []
    for crvShape in curveShapes:
        poci = proxy.create("pointOnCurveInfo")
        crvShape.worldSpace[0].connect(poci.inputCurve)
        poci.parameter.set(param)
        poci.turnOnPercentage.set(True)
        positions.append(poci.position.get()[0])
        cmds.delete(str(poci))

    # Build joint chain across curves
    chainJoints = []
    for j, pos in enumerate(positions):
        jnt = proxy.create("joint", f"{@name}_spread{i + 1}_{j + 1}", skipSelection=True)
        cmds.xform(str(jnt), worldSpace=True, translation=pos)
        if chainJoints:
            cmds.parent(str(jnt), str(chainJoints[-1]))
        chainJoints.append(jnt)

    # Orient joint chain
    if len(chainJoints) > 1:
        cmds.joint(str(chainJoints[0]), e=True, oj="xyz", secondaryAxisOrient="yup", ch=True, zso=True)
        chainJoints[-1].jointOrient.set((0, 0, 0))

    cmds.parent(str(chainJoints[0]), str(bonesGrp))

    # Pin root joint translate to curve 0
    rootPoci = proxy.create("pointOnCurveInfo", f"{@name}_spread{i + 1}_root_poci", suffix=False)
    curveShapes[0].worldSpace[0].connect(rootPoci.inputCurve)
    rootPoci.parameter.set(param)
    rootPoci.turnOnPercentage.set(True)
    rootPoci.position.connect(chainJoints[0].translate)

    # SC IK for each consecutive joint pair, handle pinned to next curve
    for j in range(numCurves - 1):
        ikHName, _ = cmds.ikHandle(
            sj=str(chainJoints[j]), ee=str(chainJoints[j + 1]),
            sol="ikSCsolver",
            n=f"{@name}_spread{i + 1}_{j + 1}_ikHandle"
        )
        ikH = proxy.node(ikHName)
        bonesGrp | ikH

        poci = proxy.create("pointOnCurveInfo", f"{@name}_spread{i + 1}_{j + 1}_ik_poci", suffix=False)
        curveShapes[j + 1].worldSpace[0].connect(poci.inputCurve)
        poci.parameter.set(param)
        poci.turnOnPercentage.set(True)
        poci.position.connect(ikH.translate)

        allIkHandles.append(str(ikH))

    allRootJoints.append(str(chainJoints[0]))
    allJoints.extend(str(j) for j in chainJoints)

@set_output(allJoints)
@set_ikHandles(allIkHandles)
]]></run>
<doc><![CDATA[## Summary  
Creates a set of SC‑IK bone chains that are evenly spread across multiple input curves. For each bone set, joints are positioned at the same parameter on every curve, chained together, and driven by short‑circuit IK handles that are pinned to the next curve.

## Inputs  
- **`name`** – Naming prefix for all created nodes (e.g., `M_spread`).  
- **`numBones`** – Integer specifying how many bone sets to generate (must be ≥ 1).  
- **`curves`** – List of curve transform or shape nodes that define the spread path. At least two curves are required.

## Outputs  
- **`output`** – List of all joint names created for every bone set.  
- **`ikHandles`** – List of all SC‑IK handle names that drive the joint chains.  
- **`bonesGrp`** – (Implicit) transform group named `<name>_spreadBones_group` that contains all joints.  
- **`ikGrp`** – (Implicit) group that parents all IK handles.

## Usage  
1. Specify a naming prefix in **`name`**.  
2. Set **`numBones`** to the desired number of bone sets.  
3. Populate **`curves`** with at least two curve nodes that will guide the spread.  
4. Execute the module.  
5. The module will create joint chains and SC‑IK handles, pinning each root joint to the first curve and each handle to the subsequent curve.  
6. Use the **`output`** list to connect the joints to downstream rig components, and the **`ikHandles`** list to drive deformation or animation systems.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Creates <b>N bone chains</b> spread across input <b>curves</b> using SC IK."}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_spread", "placeholder": "Naming prefix", "buttonEnabled": false, "default": "value"}]]></attr>
<attr name="numBones" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 7, "placeholder": "", "buttonEnabled": false, "min": 1, "max": 100, "validator": 1, "default": "value"}]]></attr>
<attr name="curves" template="listBox" category="General" connect=""><![CDATA[{"items": ["curve1", "curve3"], "default": "items"}]]></attr>
<attr name="output" template="listBox" category="Output" connect=""><![CDATA[{"items": ["M_spread_spread1_1_jnt", "M_spread_spread1_2_jnt", "M_spread_spread2_1_jnt", "M_spread_spread2_2_jnt", "M_spread_spread3_1_jnt", "M_spread_spread3_2_jnt", "M_spread_spread4_1_jnt", "M_spread_spread4_2_jnt", "M_spread_spread5_1_jnt", "M_spread_spread5_2_jnt", "M_spread_spread6_1_jnt", "M_spread_spread6_2_jnt", "M_spread_spread7_1_jnt", "M_spread_spread7_2_jnt"], "default": "items"}]]></attr>
<attr name="ikHandles" template="listBox" category="Output" connect=""><![CDATA[{"items": ["M_spread_spread1_1_ikHandle", "M_spread_spread2_1_ikHandle", "M_spread_spread3_1_ikHandle", "M_spread_spread4_1_ikHandle", "M_spread_spread5_1_ikHandle", "M_spread_spread6_1_ikHandle", "M_spread_spread7_1_ikHandle"], "default": "items"}]]></attr>
</attributes>
</module>
