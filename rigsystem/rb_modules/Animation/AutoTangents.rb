<module name="autoTangent" type="Tools/AutoTangents" muted="0" uid="fe8646386e674920b0dfd829b30e6736">
<run><![CDATA[import pymel.core as pm
import maya.cmds as cmds
import math

def clamp(v, mn, mx):
    if v > mx: return mx
    if v < mn: return mn
    return v

def isEqual(a,b): 
    return abs(a-b) < 0.001
    
def getSelectedKeys():
    selectedKeys = {}
    for n in cmds.keyframe(q=True, name=True, sl=True):
        if n not in selectedKeys:
            selectedKeys[n] = []
        selectedKeys[n] += cmds.keyframe(n, q=True, indexValue=True, sl=True)
    return selectedKeys    

def getCurrentAnimCurves():    
    graphEditorCurves = cmds.animCurveEditor("graphEditor1GraphEd", q=True, cs=True)
    if graphEditorCurves:
        return graphEditorCurves
    else:
        return cmds.listConnections(type=["animCurveTA", "animCurveTU", "animCurveTL"])
                
def getPrevIndex(animCurve, index):
    numKeys = animCurve.numKeys()
    current = animCurve.getValue(index)
    
    if index == 0: # first
        if animCurve.getPreInfinityType() != "constant":
            if isEqual(animCurve.getValue(numKeys-1), current):
                return numKeys-2 # before last        
            return numKeys-1
        return index          
        
    else:    
        return index-1
    
def getNextIndex(animCurve, index):
    numKeys = animCurve.numKeys()
    current = animCurve.getValue(index)
    
    if index == numKeys-1: # last       
        if animCurve.getPostInfinityType() != "constant":
            if isEqual(animCurve.getValue(0), current):
                return 1
            return 0
        else:
            return index                    
    else:
        return index+1
                    
def isExtremumKey(animCurve, index):
    if index == 0 and animCurve.getPreInfinityType() == "constant":
        return True

    if index == animCurve.numKeys()-1 and animCurve.getPostInfinityType() == "constant":
        return True
        
    if animCurve.numKeys() > 2:             
        current = animCurve.getValue(index)
        prev = animCurve.getValue(getPrevIndex(animCurve, index))
        next = animCurve.getValue(getNextIndex(animCurve, index))
        return (current > prev and current > next) or (current < prev and current < next)

def autoTangents(animCurve, keyIndices=None):
    for index in range(animCurve.numKeys()):
        if keyIndices is not None and index not in keyIndices:
            continue
            
        if isExtremumKey(animCurve, index):
            if (index == 0 and animCurve.getPreInfinityType() == "constant" or\
                index == animCurve.numKeys()-1 and animCurve.getPostInfinityType() == "constant") and not @flatten:
                cmds.keyTangent(animCurve.name(), index=[(index, index)], e=True, itt="spline", ott="spline")
    
            else:
                cmds.keyTangent(animCurve.name(), index=[(index, index)], e=True, itt="flat", ott="flat")
        else:
            evalAtIndex = lambda idx: cmds.keyframe(animCurve.name(), index=[(idx, idx)], q=True, eval=True)[0]
            
            prevIndex = getPrevIndex(animCurve, index)
            nextIndex = getNextIndex(animCurve, index)

            valuePrevChange = animCurve.getValue(index) - animCurve.getValue(prevIndex)
            valueNextChange = animCurve.getValue(nextIndex) - animCurve.getValue(index)
            
            prevTime = animCurve.getTime(prevIndex)
            nextTime = animCurve.getTime(nextIndex)
            
            if index == 0:
                prevTime = -(animCurve.getTime(animCurve.numKeys()-1)-animCurve.getTime(prevIndex))
            elif index == animCurve.numKeys()-1:
                nextTime = animCurve.getTime(index) + animCurve.getTime(1)-animCurve.getTime(0)

            timePrevChange = animCurve.getTime(index) - prevTime
            timeNextChange = nextTime - animCurve.getTime(index)
                
            slopeIn = valuePrevChange / timePrevChange if timePrevChange != 0 else 0 
            slopeOut = valueNextChange / timeNextChange if timeNextChange != 0 else 0 
                        
            prevAngle = math.atan(slopeIn)*180.0/math.pi
            nextAngle = math.atan(slopeOut)*180.0/math.pi
            
            if prevAngle == 0:prevAngle = 0.001
            if nextAngle == 0:nextAngle = 0.001
            
            sumAngleWeight = 1.0/nextAngle + 1.0/prevAngle
            nextAngleWeight = 1.0/nextAngle / sumAngleWeight
            prevAngleWeight = 1.0/prevAngle / sumAngleWeight
            angle = nextAngle*nextAngleWeight + prevAngle*prevAngleWeight
                        
            cmds.keyTangent(animCurve.name(), index=[(index, index)], e=True, itt="spline", ott="spline")
            cmds.keyTangent(animCurve.name(), index=[(index,index)], e=True, oa=angle)            
            
            # soft
            powIn = 0.5
            powOut = 0.5
            			
            if slopeIn + slopeOut != 0:
                powIn = 1.0 - abs(slopeIn) / (abs(slopeIn) + abs(slopeOut))
                
            powOut = 1.0 - powIn
            	
            powIn = (1.0 - @soft) * powIn + @soft * 0.5
            powOut = (1.0 - @soft) * powOut + @soft * 0.5
            	
            newSlope = powIn * slopeIn + powOut * slopeOut
            smoothAngle = math.atan(newSlope) * 180.0 / math.pi
            cmds.keyTangent(animCurve.name(), index=[(index, index)], e=True, oa=smoothAngle*@soft + angle*(1-@soft))

if @selected==0:
    selectedKeys = getSelectedKeys()
    for animCurve in selectedKeys:
        autoTangents(pm.PyNode(animCurve), selectedKeys[animCurve])

elif @selected==1:
    for animCurve in getCurrentAnimCurves():
        autoTangents(pm.PyNode(animCurve))

    ]]></run>
<doc><![CDATA[## Summary
Automates the adjustment of animation curve tangents for selected keyframes or entire curves, providing smooth interpolation and optional flattening of extreme points. The tool can be run on either the currently selected keys or all animation curves in the scene, with a soft‑tangent blend and a flatten toggle for end‑point handling.

## Inputs
- **`flatten`** (`checkBox`): When checked, extreme keyframes at the start or end of a curve that are not part of a constant infinity type are set to spline tangents instead of flat, preserving the curve shape at the boundaries.
- **`selected`** (`radioButton`):  
  - *Keys* (`0`): Apply the tangent adjustments only to the keyframes that are currently selected in the graph editor.  
  - *Curves* (`1`): Apply the adjustments to every animation curve connected to the graph editor or found in the scene.
- **`soft`** (`lineEdit`): A float between 0 and 1 that blends the calculated spline angle with a “soft” angle derived from the surrounding key slopes. A value of `0` uses the full spline angle, while `1` applies a fully softened transition.

## Outputs
- The module does not create new nodes or data containers; it directly edits the tangent settings of the targeted animation curves in place. The changes are immediately reflected in the graph editor and any downstream animation playback.

## Usage
1. **Select the target**  
   - If you want to adjust only specific keyframes, select those keys in the graph editor and set **`selected`** to *Keys*.  
   - To process all curves in the scene, leave the selection empty and set **`selected`** to *Curves*.
2. **Configure options**  
   - Toggle **`flatten`** if you need the start/end extreme points to retain spline tangents.  
   - Enter a value for **`soft`** (0–1) to control how aggressively the tool softens the tangent angles.
3. **Run the tool**  
   - Click the execute button in Rig Builder. The script will iterate over the chosen curves/keys, compute appropriate spline angles, apply soft blending, and update the tangents.  
4. **Verify**  
   - Inspect the graph editor to confirm that keyframe tangents have been updated. The changes persist for playback and further animation work.]]></doc>
<attributes>
<attr name="flatten" template="checkBox" category="General" connect=""><![CDATA[{"__default__": "checked", "checked": false}]]></attr>
<attr name="selected" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Keys", "Curves"], "__default__": "current"}]]></attr>
<attr name="soft" template="lineEdit" category="General" connect=""><![CDATA[{"__default__": "value", "max": "1", "validator": 2, "value": 0.0, "min": "0"}]]></attr>
</attributes>
<children>
</children>
</module>