<module name="autoTangent" type="Tools/AutoTangents" muted="0" uid="fe8646386e674920b0dfd829b30e6736">
<run><![CDATA[import maya.cmds as cmds
import math


def numKeys(curve):
    return cmds.keyframe(curve, q=True, keyframeCount=True) or 0


def getValue(curve, index):
    return cmds.keyframe(curve, index=(index, index), q=True, valueChange=True)[0]


def getTime(curve, index):
    return cmds.keyframe(curve, index=(index, index), q=True, timeChange=True)[0]


def isConstantInfinity(curve, pre):
    attr = "preInfinity" if pre else "postInfinity"
    return cmds.getAttr(f"{curve}.{attr}") == 0

def clamp(v, mn, mx):
    if v > mx: return mx
    if v < mn: return mn
    return v

def isEqual(a,b): 
    return abs(a-b) < 0.001
    
def getSelectedKeys():
    selectedKeys = {}
    for n in cmds.keyframe(q=True, name=True, sl=True) or []:
        if n not in selectedKeys:
            selectedKeys[n] = []
        selectedKeys[n] += cmds.keyframe(n, q=True, indexValue=True, sl=True) or []
    return selectedKeys    

def getCurrentAnimCurves():
    graphEditorCurves = []
    if cmds.animCurveEditor("graphEditor1GraphEd", exists=True):
        graphEditorCurves = cmds.animCurveEditor("graphEditor1GraphEd", q=True, cs=True) or []
    if graphEditorCurves:
        return graphEditorCurves
    return cmds.ls(type=["animCurveTA", "animCurveTU", "animCurveTL"]) or []
                
def getPrevIndex(animCurve, index):
    count = numKeys(animCurve)
    current = getValue(animCurve, index)
    
    if index == 0: # first
        if not isConstantInfinity(animCurve, pre=True):
            if isEqual(getValue(animCurve, count - 1), current):
                return count - 2 # before last
            return count - 1
        return index          
        
    else:    
        return index-1
    
def getNextIndex(animCurve, index):
    count = numKeys(animCurve)
    current = getValue(animCurve, index)
    
    if index == count - 1: # last
        if not isConstantInfinity(animCurve, pre=False):
            if isEqual(getValue(animCurve, 0), current):
                return 1
            return 0
        else:
            return index                    
    else:
        return index+1
                    
def isExtremumKey(animCurve, index):
    if index == 0 and isConstantInfinity(animCurve, pre=True):
        return True

    if index == numKeys(animCurve) - 1 and isConstantInfinity(animCurve, pre=False):
        return True
        
    if numKeys(animCurve) > 2:
        current = getValue(animCurve, index)
        prev = getValue(animCurve, getPrevIndex(animCurve, index))
        next = getValue(animCurve, getNextIndex(animCurve, index))
        return (current > prev and current > next) or (current < prev and current < next)

def autoTangents(animCurve, keyIndices=None):
    for index in range(numKeys(animCurve)):
        if keyIndices is not None and index not in keyIndices:
            continue
            
        if isExtremumKey(animCurve, index):
            if (index == 0 and isConstantInfinity(animCurve, pre=True) or\
                index == numKeys(animCurve) - 1 and isConstantInfinity(animCurve, pre=False)) and not @flatten:
                cmds.keyTangent(animCurve, index=[(index, index)], e=True, itt="spline", ott="spline")
    
            else:
                cmds.keyTangent(animCurve, index=[(index, index)], e=True, itt="flat", ott="flat")
        else:
            prevIndex = getPrevIndex(animCurve, index)
            nextIndex = getNextIndex(animCurve, index)

            valuePrevChange = getValue(animCurve, index) - getValue(animCurve, prevIndex)
            valueNextChange = getValue(animCurve, nextIndex) - getValue(animCurve, index)
            
            prevTime = getTime(animCurve, prevIndex)
            nextTime = getTime(animCurve, nextIndex)
            
            if index == 0:
                prevTime = -(getTime(animCurve, numKeys(animCurve) - 1) - getTime(animCurve, prevIndex))
            elif index == numKeys(animCurve) - 1:
                nextTime = getTime(animCurve, index) + getTime(animCurve, 1) - getTime(animCurve, 0)

            timePrevChange = getTime(animCurve, index) - prevTime
            timeNextChange = nextTime - getTime(animCurve, index)
                
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
                        
            cmds.keyTangent(animCurve, index=[(index, index)], e=True, itt="spline", ott="spline")
            cmds.keyTangent(animCurve, index=[(index,index)], e=True, oa=angle)
            
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
            cmds.keyTangent(animCurve, index=[(index, index)], e=True, oa=smoothAngle*@soft + angle*(1-@soft))

if @selected==0:
    selectedKeys = getSelectedKeys()
    for animCurve in selectedKeys:
        autoTangents(animCurve, selectedKeys[animCurve])

elif @selected==1:
    for animCurve in getCurrentAnimCurves():
        autoTangents(animCurve)

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
