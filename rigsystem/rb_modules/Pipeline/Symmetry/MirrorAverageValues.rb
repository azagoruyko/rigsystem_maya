<module name="mirrorAverageValues" muted="0" uid="e7f568dc08e241e09d741aa978e51e5f">
<run><![CDATA[import pymel.core as pm
import rig_utils

averages = pm.ls("*_average_*_locator")
for avg in averages:
    if not ("_pos_" in avg.name() or "_neg_" in avg.name()):
        continue
        
    if not rig_utils.naming.isLeftSide(avg.name()):
        continue
        
    symAvg = rig_utils.naming.findSymmetricName(avg)
    if "_pos_" in avg.name():
        symAvg = symAvg.replace("_pos_", "_neg_")
    elif "_neg_" in avg.name():
        symAvg = symAvg.replace("_neg_", "_pos_")
    
    if symAvg != avg and pm.objExists(symAvg):
        print("{} >> {}".format(avg, symAvg))
        symAvg = pm.PyNode(symAvg)
        for a in ["t", "speedInner", "speedOutter"]:
            coeff = -1 if a == "t" else 1
            if symAvg.attr(a).isSettable():
                v = avg.attr(a).get()           
                symAvg.attr(a).set(coeff * v)]]></run>
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