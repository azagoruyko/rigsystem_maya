<module name="AutoWindRotation" muted="0" uid="5c066feddef04e8f8e649fa9822c4cf9">
<run><![CDATA[import pymel.core as pm

transforms = [pm.PyNode(t) for t in @transforms if pm.objExists(t)]
if not transforms:
    print("AutoWindRotation: No valid transforms supplied.")
else:
    controlNode = pm.PyNode(@controlNode)

    # Rotation axis mapping
    axisMap = {0: "X", 1: "Y", 2: "Z"}
    rotAxis = axisMap[@rotateAxis]

    # Projection plane mapping: 0 -> XZ, 1 -> XY, 2 -> YZ
    planeMap = {
        0: ("x", "z", "windSpotX", "windSpotZ"),
        1: ("x", "y", "windSpotX", "windSpotY"),
        2: ("y", "z", "windSpotY", "windSpotZ")
    }
    axisU, axisV, attrUName, attrVName = planeMap[@projectPlane]

    # Add control attributes to the control node
    if not controlNode.hasAttr("windAmplitude"):
        controlNode.addAttr("windAmplitude", at="float", k=True, dv=0.0, min=0)
    if not controlNode.hasAttr("windFrequency"):
        controlNode.addAttr("windFrequency", at="float", k=True, dv=4.0, min=0)
    if not controlNode.hasAttr("windCurlOffset"):
        controlNode.addAttr("windCurlOffset", at="float", k=True, dv=1.0)
    if not controlNode.hasAttr("windDepthScale"):
        controlNode.addAttr("windDepthScale", at="float", k=True, dv=2.0, min=0)
    if not controlNode.hasAttr("windOffset"):
        controlNode.addAttr("windOffset", at="float", k=True, dv=0.0)
    if not controlNode.hasAttr(attrUName):
        controlNode.addAttr(attrUName, at="float", k=True, dv=0.0, min=-1.0, max=1.0)
    if not controlNode.hasAttr(attrVName):
        controlNode.addAttr(attrVName, at="float", k=True, dv=0.0, min=-1.0, max=1.0)
    if not controlNode.hasAttr("windFalloff"):
        controlNode.addAttr("windFalloff", at="float", k=True, dv=1.0, min=0.001)

    ctrl = controlNode.name()
    transforms_set = set(transforms)

    # Automatically analyze hierarchy regardless of input list order:
    # 1. Find depth along chain (ancestor count within input transforms set)
    # 2. Find root node of each curl/chain
    chain_info = {}
    for t in transforms:
        depth = 0
        root = t
        curr = t.getParent()
        while curr:
            if curr in transforms_set:
                depth += 1
                root = curr
            curr = curr.getParent()
        chain_info[t] = {"root": root, "depth": depth}

    # Unique roots sorted deterministically
    unique_roots = sorted(list(set(info["root"] for info in chain_info.values())), key=lambda x: x.name())

    # Compute average world position for each curl chain (centroid of all controls in the curl)
    curl_members = {}
    for r in unique_roots:
        curl_members[r] = [t for t in transforms if chain_info[t]["root"] == r]

    curl_avg_positions = {}
    for r, members in curl_members.items():
        count = float(len(members))
        avg_x = sum(t.getTranslation("world").x for t in members) / count
        avg_y = sum(t.getTranslation("world").y for t in members) / count
        avg_z = sum(t.getTranslation("world").z for t in members) / count
        curl_avg_positions[r] = {"x": avg_x, "y": avg_y, "z": avg_z}

    # Bake 2D normalized coordinates based on curl centroids on the selected projection plane in [-1.0, 1.0] range
    u_coords = [curl_avg_positions[r][axisU] for r in unique_roots]
    v_coords = [curl_avg_positions[r][axisV] for r in unique_roots]

    min_u, max_u = min(u_coords), max(u_coords)
    min_v, max_v = min(v_coords), max(v_coords)

    range_u = max_u - min_u
    range_v = max_v - min_v

    root_uvs = {}
    for r in unique_roots:
        u_val = curl_avg_positions[r][axisU]
        v_val = curl_avg_positions[r][axisV]
        u01 = (u_val - min_u) / range_u if range_u > 1e-5 else 0.5
        v01 = (v_val - min_v) / range_v if range_v > 1e-5 else 0.5
        # Remap [0..1] to [-1..1] so (0,0) is center
        u = (u01 - 0.5) * 2.0
        v = (v01 - 0.5) * 2.0
        root_uvs[r] = (round(u, 4), round(v, 4))

    # Build expression header
    exprLines = []
    exprLines.append("$amp = {0}.windAmplitude;".format(ctrl))
    exprLines.append("$freq = {0}.windFrequency;".format(ctrl))
    exprLines.append("$sinOff = {0}.windOffset;".format(ctrl))
    exprLines.append("$curlOff = {0}.windCurlOffset;".format(ctrl))
    exprLines.append("$depthScale = {0}.windDepthScale;".format(ctrl))
    exprLines.append("$spotU = {0}.{1};".format(ctrl, attrUName))
    exprLines.append("$spotV = {0}.{1};".format(ctrl, attrVName))
    exprLines.append("$falloffRadius = {0}.windFalloff;".format(ctrl))
    exprLines.append("$radiusSq = $falloffRadius * $falloffRadius;")
    exprLines.append("$t = time;")
    exprLines.append("")

    # Calculate quadratic 2D distance falloff per curl root: F = clamp(0, 1, 1 - (d / R)^2)
    for curl_idx, r in enumerate(unique_roots):
        u, v = root_uvs[r]
        exprLines.append("$distSq_{idx} = ($spotU - {u}) * ($spotU - {u}) + ($spotV - {v}) * ($spotV - {v});".format(idx=curl_idx, u=u, v=v))
        exprLines.append("$falloff_{idx} = $radiusSq > 0.0001 ? clamp(0.0, 1.0, 1.0 - ($distSq_{idx} / $radiusSq)) : 1.0;".format(idx=curl_idx))
    exprLines.append("")

    for t in transforms:
        depth = chain_info[t]["depth"]
        curl_idx = unique_roots.index(chain_info[t]["root"])

        # sin(time * freq + depth * windOffset + curlIndex * windCurlOffset) * (amplitude * (1 + depth * windDepthScale)) * falloff2D_quadratic
        line = "{windTransform}.rotateAxis{axis} = sin($t * $freq + {depth} * $sinOff + {curl_idx} * $curlOff) * ($amp * (1.0 + {depth} * $depthScale)) * $falloff_{curl_idx};".format(
            windTransform=t,
            axis=rotAxis,
            depth=depth,
            curl_idx=curl_idx
        )
        exprLines.append(line)

    exprStr = "\n".join(exprLines)

    # Accumulate into a single expression: update if exists, create if not
    if pm.objExists(@expressionName):
        exprNode = pm.PyNode(@expressionName)
        existing = exprNode.getString()
        exprNode.setString(existing + "\n" + exprStr)
    else:
        pm.expression(s=exprStr, n=@expressionName, ae=True)
]]></run>
<doc><![CDATA[## Summary
The **hairAutoWindRotation** module automatically drives a sine‑based wind animation for multiple hair curl chains. It analyses the input transforms, determines each chain’s depth, calculates a 2‑D wind spot on a chosen projection plane, and builds a single Maya expression that drives per‑transform rotation along a specified axis with depth‑dependent amplitude, phase offsets, and a quadratic fall‑off.

## Inputs
- **`transforms`** – List of hair control transforms (any order). The module will resolve each chain’s root and depth.
- **`controlNode`** – Node that will receive the wind attributes (`windAmplitude`, `windFrequency`, etc.). If the node does not exist, the module will not run.
- **`expressionName`** – Name of the Maya expression node that will be created or updated.
- **`projectPlane`** – Projection plane for the wind spot: **XZ**, **XY**, or **YZ**. Determines which 2‑D attributes (`windSpotX/Z`, `windSpotX/Y`, or `windSpotY/Z`) are added.
- **`rotateAxis`** – Axis on which the wind rotation will be applied: **X**, **Y**, or **Z**.
- **`directConnect`** – If checked, the module will directly connect the expression to the original transforms; otherwise it creates a temporary `<transform>_wind_transform` node above each control and drives that node.

## Outputs
- **Expression node** (`<expressionName>`) that contains the wind rotation logic and updates the selected axis on each transform or its wind transform.
- **Wind transform nodes** (`<transform>_wind_transform`) created for each input transform when `directConnect` is unchecked.
- **Wind attributes** added to the `controlNode`:
  - `windAmplitude`, `windFrequency`, `windCurlOffset`, `windDepthScale`, `windOffset`, `windFalloff`
  - 2‑D spot attributes (`windSpotX`/`windSpotZ`, `windSpotX`/`windSpotY`, or `windSpotY`/`windSpotZ`) depending on the chosen plane.
- The module updates the expression node each time it runs, appending new logic for any new transforms.

## Usage
1. **Select the hair controls** you want to wind. They can be in any order; the module will automatically detect chain roots and depths.
2. **Choose a control node** that will hold the wind parameters (e.g., a dedicated wind controller).  
3. **Set the expression name** (default `wind_expression`).  
4. **Pick the projection plane** (XZ, XY, or YZ) and the rotation axis (X, Y, or Z).  
5. **Decide on direct connection**:  
   - *Checked* – the expression drives the original controls directly.  
   - *Unchecked* – a temporary wind transform node is created above each control and driven instead.  
6. **Run the module**. It will create the necessary attributes, build or update the expression, and add wind transform nodes if needed.  
7. **Adjust the wind parameters** on the control node (`windAmplitude`, `windFrequency`, etc.) and the 2‑D spot attributes to shape the wind effect.  
8. **Re‑run** if you add or remove hair controls; the module will append the new logic to the existing expression.]]></doc>
<attributes>
<attr name="expressionName" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "wind_expression", "placeholder": "Expression node name", "buttonEnabled": false, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_hair_curl_a_1_control", "L_hair_curl_a_2_control", "L_hair_curl_a_3_control", "L_hair_curl_a_4_control", "L_hair_curl_a_5_control", "L_hair_curl_b_1_control", "L_hair_curl_b_2_control", "L_hair_curl_b_3_control", "L_hair_curl_b_4_control", "L_hair_curl_b_5_control", "L_hair_curl_b_6_control", "L_hair_curl_c_1_control", "L_hair_curl_c_2_control", "L_hair_curl_c_3_control", "L_hair_curl_c_4_control", "L_hair_curl_d_1_control", "L_hair_curl_d_2_control", "L_hair_curl_d_3_control", "L_hair_curl_d_4_control", "L_hair_curl_d_5_control", "M_hair_curl_top_1_control", "M_hair_curl_top_2_control", "M_hair_curl_top_3_control", "L_hair_curl_e_1_control", "L_hair_curl_e_2_control", "L_hair_curl_e_3_control", "L_hair_curl_e_4_control", "M_hair_curl_a_1_control", "M_hair_curl_a_2_control", "M_hair_curl_a_3_control", "M_hair_curl_b_1_control", "M_hair_curl_b_2_control", "M_hair_curl_b_3_control", "R_hair_curl_a_1_control", "R_hair_curl_a_2_control", "R_hair_curl_a_3_control", "R_hair_curl_a_4_control", "R_hair_curl_a_5_control", "R_hair_curl_b_1_control", "R_hair_curl_b_2_control", "R_hair_curl_b_3_control", "R_hair_curl_b_4_control", "R_hair_curl_b_5_control", "R_hair_curl_c_1_control", "R_hair_curl_c_2_control", "R_hair_curl_c_3_control", "R_hair_curl_c_4_control", "R_hair_curl_d_1_control", "R_hair_curl_d_2_control", "R_hair_curl_d_3_control", "R_hair_curl_d_4_control", "R_hair_curl_d_5_control"], "default": "items"}]]></attr>
<attr name="controlNode" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_hair_wind_control", "placeholder": "Node to receive wind attrs", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="projectPlane" template="radioButton" category="General" connect=""><![CDATA[{"current": 0, "items": ["XZ", "XY", "YZ"], "columns": 3, "default": "current"}]]></attr>
<attr name="rotateAxis" template="radioButton" category="General" connect=""><![CDATA[{"current": 2, "items": ["X", "Y", "Z"], "columns": 3, "default": "current"}]]></attr>
</attributes>
</module>