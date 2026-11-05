<module name="mirrorAverageValues" muted="0" uid="e7f568dc08e241e09d741aa978e51e5f">
<run><![CDATA[from rigsystem import proxy, rig_utils

cmds = proxy.cmds
averages = proxy.nodes(cmds.ls("*_average_*_locator") or [])
for avg in averages:
    name = str(avg)
    if not ("_pos_" in name or "_neg_" in name):
        continue
        
    if not rig_utils.naming.isLeftSide(name):
        continue
        
    symAvg = rig_utils.naming.findSymmetricName(name)
    if "_pos_" in name:
        symAvg = symAvg.replace("_pos_", "_neg_")
    elif "_neg_" in name:
        symAvg = symAvg.replace("_neg_", "_pos_")
    
    if symAvg != name and cmds.objExists(symAvg):
        print(f"{avg} >> {symAvg}")
        symAvg = proxy.node(symAvg)
        for a in ["t", "speedInner", "speedOutter"]:
            coeff = -1 if a == "t" else 1
            destination = symAvg.attr(a)
            if cmds.getAttr(str(destination), settable=True):
                value = avg.attr(a).get()
                if a == "t":
                    value = tuple(-component for component in value[0])
                else:
                    value *= coeff
                destination.set(value)]]></run>
<doc><![CDATA[## Summary
Mirrors the average locator parameters (`t`, `speedInner`, `speedOutter`) from left‑side rig components to their right‑side counterparts, automatically negating the `t` value for proper mirroring.

## Inputs
- **Left‑side average locators** (`*_average_*_locator`) that contain the attributes:
  - `t` – a numeric value that should be mirrored with a sign flip.
  - `speedInner` – a numeric value copied as‑is.
  - `speedOutter` – a numeric value copied as‑is.
- Naming convention: locators must include `_pos_` or `_neg_` in their names and be identified as left side by `rig_utils.naming.isLeftSide`.

## Outputs
- **Right‑side average locators** (found via `rig_utils.naming.findSymmetricName`) with their `t`, `speedInner`, and `speedOutter` attributes updated to match the left side, where `t` is negated.

## Usage
1. Ensure all average locators are created and named following the pattern `*_average_*_locator` with `_pos_` or `_neg_` suffixes.
2. Run the `mirrorAverageValues` module. It will automatically locate the corresponding right‑side locators and copy the attributes, printing each mirrored pair.
3. Verify that the right‑side locators now hold the mirrored values; they can be used by downstream rig modules that rely on these parameters.]]></doc>
</module>
