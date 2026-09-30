<module name="generateViewportImages" type="Tools/GenerateViewportImages" muted="0" uid="d82543088d8446c18efeecf3efe90747">
<run><![CDATA[import os

import pymel.core as pm
from PySide6.QtGui import QImage, QColor

def clamp(v, min, max):
    if v > max:
        return max
    elif v < min:
        return min
    else:        
        return v
    
def isAlmostEqualColor(a, b, rough=2):
    return abs(a.red()-b.red()) <= rough and abs(a.green()-b.green()) <= rough and abs(a.blue()-b.blue()) <= rough    
    
def trimImage(path, margin):
    img = QImage(path)    
    leftOffset = img.width()
    rightOffset = 0
    topOffset = img.height()
    bottomOffset = 0
    
    zeroColor = QColor(img.pixel(0, 0))
    
    for y in range(img.height()):
        for x in range(img.width()):
            c = QColor(img.pixel(x, y))
            if not isAlmostEqualColor(c, zeroColor):
                if x < leftOffset:
                    leftOffset = x
                if y < topOffset:
                    topOffset = y            
                if y > bottomOffset:
                    bottomOffset = y 
                    
                for x in range(img.width()-1, x, -1):
                    c = QColor(img.pixel(x, y))
                    if not isAlmostEqualColor(c, zeroColor):
                        if x > rightOffset:
                            rightOffset = x
                        break
                break                      
        
    return img.copy(clamp(leftOffset-margin,0, leftOffset), # x
                    clamp(topOffset-margin, 0, topOffset), # y
                    clamp(rightOffset-leftOffset+margin*2, 0, img.width()),  # width
                    clamp(bottomOffset-topOffset+margin*2, 0, img.height())) # height

if not os.path.isdir(@path):
    pm.error("Select an existing image folder")

beginProgress("Generating images", len(@sets))
for i, set in enumerate(@sets):
    stepProgress(i)
    
    set = pm.PyNode(set)
    objects = pm.sets(set, q=True)
    pm.showHidden(objects)
    
    pm.isolateSelect(@panel, state=True)
    if pm.objExists(@panel+"ViewSelectedSet"):
        pm.select(pm.sets(@panel+"ViewSelectedSet", q=True)) # remove previous objects
        pm.isolateSelect(@panel, rs=True)
    
    pm.select(objects)    
    pm.isolateSelect(@panel, addSelected=True)
    pm.viewFit(fitFactor=1)
    pm.select(cl=True)
    
    fname = set.name().replace("_skin_set", "").replace("_visible_set", "")
    fpath = os.path.join(@path, "{}.jpg".format(fname))
    print(fpath)
    pm.playblast(frame=[1], format="image", c="jpg",
                 fo=True, cf=fpath, 
                 qlt=100, p=100, orn=False, v=False)
    
    trimImage(fpath, @margin).save(fpath)
    
endProgress()

pm.isolateSelect("modelPanel4", state=False)    ]]></run>
<doc><![CDATA[## Summary
Generates viewport preview thumbnails for a list of Maya sets, capturing each set in the current viewport and saving the resulting images to a specified folder. The tool trims excess background and supports custom margin and panel selection.

## Inputs
- **`path`** (`lineEdit`): Directory where the generated JPEG images will be written.  
- **`sets`** (`listBox`): List of set names to capture (e.g., `Pig001_skin_set`).  
- **`panel`** (`lineEdit`): Name of the viewport panel to use for isolation and view fitting (default: `modelPanel4`).  
- **`margin`** (`lineEdit`): Pixel margin added when trimming the image borders (default: `25`).

## Outputs
- **Image files**: For each set, a JPEG file named after the set (with `_skin_set` stripped) is written to `@path`.  
- **Trimmed images**: The images are post‑processed to remove background pixels, leaving only the visible geometry.

## Usage
1. Set the **`path`** to a writable folder where you want the thumbnails stored.  
2. Populate the **`sets`** list with the names of the sets you wish to capture.  
3. Optionally change **`panel`** if you want to use a different viewport.  
4. Adjust **`margin`** to control how much padding is kept around the captured geometry.  
5. Run the module. It will isolate each set in the specified panel, playblast a single frame to a JPEG, trim the image, and save it to the target folder.  
6. After execution, the images can be used as icons in RigBuilder’s asset library or for visual inspection of rigs.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Generate viewport images from sets with current viewport settings.\nUse one-colored background."}]]></attr>
<attr name="path" template="fileSelector" category="General" connect=""><![CDATA[{"value": "", "mode": "directory", "filter": "All Files (*.*)", "title": "Select image folder", "default": "value"}]]></attr>
<attr name="sets" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["Pig001_skin_set", "Pig002_skin_set", "Robot001_skin_set", "Robot002_skin_set", "Weapon001_skin_set", "Weapon002_skin_set"]}]]></attr>
<attr name="panel" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "modelPanel4", "min": ""}]]></attr>
<attr name="margin" template="lineEdit" category="General" connect=""><![CDATA[{"default": "value", "max": "100", "validator": 1, "value": 25, "min": "0"}]]></attr>
</attributes>
<children>
</children>
</module>