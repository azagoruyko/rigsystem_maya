<module name="updateAverageBaseAngle" muted="0" uid="9b6ba97ecdbf4974997680e52cad5502">
<run><![CDATA[import pymel.core as pm

for loc in pm.ls("*_average_*_locator"):
    if pm.objExists(loc+".outAngle") and loc.baseAngle.isSettable():        
        loc.baseAngle.set(-loc.outAngle.get())
        print(loc)]]></run>
<doc><![CDATA[## Summary  
The `updateAverageBaseAngle` module scans the Maya scene for all locator objects whose names match the pattern `*_average_*_locator`. For each matching locator, it checks that an `outAngle` attribute exists and that the `baseAngle` attribute is writable. If both conditions are met, it sets `baseAngle` to the negative value of `outAngle` and prints the locator’s name, effectively mirroring the angle value.

## Inputs  
- **Locator Objects (`*_average_*_locator`)**: Any locator node in the scene whose name follows the specified pattern.  
- **`outAngle` Attribute**: A numeric attribute on the locator that holds the angle to be mirrored.  
- **`baseAngle` Attribute**: A writable numeric attribute on the locator that will receive the mirrored value.

## Outputs  
- **Updated `baseAngle`**: For each processed locator, `baseAngle` is set to `-outAngle`.  
- **Console Log**: The name of each locator that was updated is printed to the output console.

## Usage  
1. Ensure that the scene contains locator nodes named with the pattern `*_average_*_locator` and that each has both `outAngle` and writable `baseAngle` attributes.  
2. Run the `updateAverageBaseAngle` module.  
3. Verify that the `baseAngle` values have been updated to the negative of `outAngle` and that the console lists the processed locators.]]></doc>
</module>