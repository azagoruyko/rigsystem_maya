<module name="AutoWindRotation" muted="0" uid="5c066feddef04e8f8e649fa9822c4cf9">
<run><![CDATA[from rigsystem import proxy

cmds = proxy.cmds
transforms = proxy.nodes(t for t in @transforms if cmds.objExists(t))
if not transforms:
    print("AutoWindRotation: No valid transforms supplied.")
else:
    controlNode = proxy.node(@controlNode)

    # Rotation axis mapping
    axisMap = {0: "X", 1: "Y", 2: "Z"}
    rotAxis = axisMap[@rotateAxis]

    # Projection plane mapping: 0 -> XZ, 1 -> XY, 2 -> YZ
    planeMap = {
        0: ("x", "z", "tx", "tz"),
        1: ("x", "y", "tx", "ty"),
        2: ("y", "z", "ty", "tz")
    }
    axisU, axisV, attrUName, attrVName = planeMap[@projectPlane]

    # Add control attributes to the control node
    if not controlNode.hasAttr("windAmplitude"):
        controlNode.addAttr(ln="windAmplitude", at="float", k=True, dv=0.0, min=0)
    if not controlNode.hasAttr("windFrequency"):
        controlNode.addAttr(ln="windFrequency", at="float", k=True, dv=4.0, min=0)
    if not controlNode.hasAttr("windCurlOffset"):
        controlNode.addAttr(ln="windCurlOffset", at="float", k=True, dv=1.0)
    if not controlNode.hasAttr("windDepthScale"):
        controlNode.addAttr(ln="windDepthScale", at="float", k=True, dv=2.0, min=0)
    if not controlNode.hasAttr("windOffset"):
        controlNode.addAttr(ln="windOffset", at="float", k=True, dv=0.0)
    if not controlNode.hasAttr(attrUName):
        controlNode.addAttr(ln=attrUName, at="float", k=True, dv=0.0, min=-1.0, max=1.0)
    if not controlNode.hasAttr(attrVName):
        controlNode.addAttr(ln=attrVName, at="float", k=True, dv=0.0, min=-1.0, max=1.0)
    if not controlNode.hasAttr("windFalloff"):
        controlNode.addAttr(ln="windFalloff", at="float", k=True, dv=1.0, min=0.001)

    ctrl = str(controlNode)
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
    unique_roots = sorted({info["root"] for info in chain_info.values()}, key=str)

    # Compute average world position for each curl chain (centroid of all controls in the curl)
    curl_members = {}
    for r in unique_roots:
        curl_members[r] = [t for t in transforms if chain_info[t]["root"] == r]

    curl_avg_positions = {}
    for r, members in curl_members.items():
        count = float(len(members))
        positions = [cmds.xform(t, q=True, ws=True, t=True) for t in members]
        avg_x = sum(p[0] for p in positions) / count
        avg_y = sum(p[1] for p in positions) / count
        avg_z = sum(p[2] for p in positions) / count
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
    if cmds.objExists(@expressionName):
        existing = cmds.expression(@expressionName, q=True, s=True)
        cmds.expression(@expressionName, e=True, s=existing + "\n" + exprStr)
    else:
        cmds.expression(s=exprStr, n=@expressionName, ae=True)
]]></run>
<doc><![CDATA[## Summary
AutoWindRotation creates a Maya expression that animates the selected hair controls with a sine wave. It groups the controls by hierarchy, uses each group's world-space center to calculate a normalized position on the chosen plane, and varies rotation by chain depth and distance from a movable wind spot.

## Inputs
- **`transforms`**: Hair control transforms in any order. Missing transforms are skipped. Their hierarchy determines curl roots and depths.
- **`controlNode`**: Existing transform that holds the wind settings. Its built-in translate channels position the wind spot.
- **`expressionName`**: Name of the expression to create or append to; default `wind_expression`.
- **`projectPlane`**: XZ uses `tx` and `tz`; XY uses `tx` and `ty`; YZ uses `ty` and `tz` on `controlNode`.
- **`rotateAxis`**: X, Y, or Z axis of each control's `rotateAxis` attribute.

## Outputs
- Adds `windAmplitude`, `windFrequency`, `windCurlOffset`, `windDepthScale`, `windOffset`, and `windFalloff` to `controlNode` if they are missing. The spot uses existing translate channels; no separate `windSpot` attributes are created.
- Creates an expression that writes directly to the chosen `rotateAxis` component of each listed control. No intermediate wind transforms are created.
- If `expressionName` already exists, appends a new block to its source. Re-running does not replace old blocks, so repeated controls or removed controls can leave old assignments in the expression.

## Usage
1. Supply the hair controls, an existing wind control node, an expression name, a projection plane, and a rotation axis.
2. Run the module to add wind settings and build the expression.
3. Animate the wind control's translate channels for the selected plane to move the spot. Curl centers are normalized to the range -1 to 1 on each plane axis, so that range spans the curls. Adjust `windFalloff` to change the affected area.
4. Adjust amplitude, frequency, curl phase offset, depth scale, and time offset on the wind control.
5. When changing the control list, remove or replace the old expression before running again if its previous assignments should no longer apply.]]></doc>
<attributes>
<attr name="expressionName" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "wind_expression", "placeholder": "Expression node name", "buttonEnabled": false, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["L_hair_curl_a_2_control", "L_hair_curl_a_3_control", "L_hair_curl_b_2_control", "L_hair_curl_b_3_control", "L_hair_curl_b_4_control", "L_hair_curl_b_5_control", "L_hair_curl_c_2_control", "L_hair_curl_c_3_control", "L_hair_curl_c_4_control", "L_hair_curl_c_5_control", "L_hair_curl_d_2_control", "L_hair_curl_d_3_control", "L_hair_curl_d_4_control", "L_hair_curl_d_5_control", "L_hair_curl_e_2_control", "L_hair_curl_e_3_control", "L_hair_curl_e_4_control", "L_hair_curl_e_5_control", "L_hair_curl_e_6_control", "L_hair_curl_f_2_control", "L_hair_curl_f_3_control", "L_hair_curl_f_4_control", "L_hair_curl_f_5_control", "L_hair_curl_f_6_control", "L_hair_curl_g_2_control", "L_hair_curl_g_3_control", "L_hair_curl_g_4_control", "L_hair_curl_g_5_control", "L_hair_curl_g_6_control", "L_hair_curl_h_2_control", "L_hair_curl_h_3_control", "L_hair_curl_h_4_control", "L_hair_curl_h_5_control", "L_hair_curl_h_6_control", "L_hair_curl_i_2_control", "L_hair_curl_i_3_control", "L_hair_curl_i_4_control", "L_hair_curl_i_5_control", "L_hair_curl_i_6_control", "L_hair_curl_j_2_control", "L_hair_curl_j_3_control", "L_hair_curl_j_4_control", "L_hair_curl_j_5_control", "L_hair_curl_k_2_control", "L_hair_curl_k_3_control", "L_hair_curl_k_4_control", "L_hair_curl_k_5_control", "L_hair_curl_l_2_control", "L_hair_curl_l_3_control", "L_hair_curl_l_4_control", "L_hair_curl_l_5_control", "L_hair_curl_l_6_control", "L_hair_curl_m_2_control", "L_hair_curl_m_3_control", "L_hair_curl_m_4_control", "L_hair_curl_m_5_control", "L_hair_curl_n_2_control", "L_hair_curl_n_3_control", "L_hair_curl_n_4_control", "L_hair_curl_n_5_control", "L_hair_curl_o_2_control", "L_hair_curl_o_3_control", "L_hair_curl_o_4_control", "L_hair_curl_o_5_control", "R_hair_curl_j_2_control", "R_hair_curl_j_3_control", "R_hair_curl_j_4_control", "R_hair_curl_j_5_control", "R_hair_curl_k_2_control", "R_hair_curl_k_3_control", "R_hair_curl_k_4_control", "R_hair_curl_k_5_control", "R_hair_curl_l_2_control", "R_hair_curl_l_3_control", "R_hair_curl_l_4_control", "R_hair_curl_l_5_control", "R_hair_curl_l_6_control", "R_hair_curl_m_2_control", "R_hair_curl_m_3_control", "R_hair_curl_m_4_control", "R_hair_curl_m_5_control", "R_hair_curl_a_2_control", "R_hair_curl_a_3_control", "R_hair_curl_i_2_control", "R_hair_curl_i_3_control", "R_hair_curl_i_4_control", "R_hair_curl_i_5_control", "R_hair_curl_b_2_control", "R_hair_curl_b_3_control", "R_hair_curl_b_4_control", "R_hair_curl_b_5_control", "R_hair_curl_d_2_control", "R_hair_curl_d_3_control", "R_hair_curl_d_4_control", "R_hair_curl_d_5_control", "R_hair_curl_f_2_control", "R_hair_curl_f_3_control", "R_hair_curl_f_4_control", "R_hair_curl_f_5_control", "R_hair_curl_h_2_control", "R_hair_curl_h_3_control", "R_hair_curl_h_4_control", "R_hair_curl_h_5_control", "R_hair_curl_h_6_control", "R_hair_curl_e_2_control", "R_hair_curl_e_3_control", "R_hair_curl_e_4_control", "R_hair_curl_g_2_control", "R_hair_curl_g_3_control", "R_hair_curl_g_4_control", "R_hair_curl_g_5_control", "R_hair_curl_g_6_control", "R_hair_curl_o_2_control", "R_hair_curl_o_3_control", "R_hair_curl_o_4_control", "R_hair_curl_o_5_control", "R_hair_curl_o_6_control", "R_hair_curl_n_2_control", "R_hair_curl_n_3_control"], "default": "items"}]]></attr>
<attr name="controlNode" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_hair_wind_control", "placeholder": "Node to receive wind attrs", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="projectPlane" template="radioButton" category="General" connect=""><![CDATA[{"items": ["XZ", "XY", "YZ"], "current": 0, "columns": 3, "default": "current"}]]></attr>
<attr name="rotateAxis" template="radioButton" category="General" connect=""><![CDATA[{"current": 2, "items": ["X", "Y", "Z"], "columns": 3, "default": "current"}]]></attr>
</attributes>
</module>
