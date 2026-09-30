<module name="curveSkinLayers" muted="0" uid="28b7e6993fe94ae384cd4bcff1328692">
<run><![CDATA[import pymel.core as pm
import rig_utils

mainCurve = pm.PyNode(@mainCurve)

makeSkinLocalMod = module.child("makeSkinLocal")
attachToCurveMod = module.child("attachToCurve")

def generateJoints(curve, params, layerName):
    curve = pm.PyNode(curve)
    
    sizes = {"major": 0.5, "minor": 0.3}
    
    joints = []
    for i, param in enumerate(params):
        j = pm.createNode("joint", n=f"{@prefix}_{layerName}_{i+1}_joint")
        p = curve.getPointAtParam(param)
        j.t.set(p)    
        j.radius.set(sizes.get(layerName, 1.0))      
        
        joints.append(j)
        
    return joints        

def generateControls(crv, joints, layerName, curveType, *, addTransform=False):
    sizes = {"major": 0.5, "minor": 0.3}
    
    controls = []
    sz = crv.length() / (len(joints)*1.5) * sizes.get(layerName, 1.0)        
    
    for i, j in enumerate(joints):
        ctrl = pm.createNode("transform", n=f"{@prefix}_{layerName}_{i+1}_control")
        pm.matchTransform(ctrl, j)
        pm.parentConstraint(ctrl, j)
        ctrl.s >> j.s
        
        if addTransform:
            t = pm.createNode("transform", n=ctrl+"_transform")
            pm.matchTransform(t, ctrl)
            t | ctrl
        
        rig_utils.setToOffsetParentMatrix(ctrl)
        
        h = rig_utils.curve.makeCurve("helper", curveType)
        pm.matchTransform(h, ctrl)
        h.s.set([sz, sz, sz])
        
        rig_utils.curve.makeFromCurve(ctrl, h)
        pm.delete(h)
        
        if layerName in ["main", "major"]:
            rig_utils.lockTRS(ctrl, [], [], [], 1)
        else:            
            rig_utils.lockTRS(ctrl, [], [1,1,1], [1,1,1], 1)
        
        controls.append(ctrl)        
        
    return controls        
    
mainJoints = generateJoints(mainCurve, @mainParams, "main")
pm.skinCluster(mainJoints, mainCurve, tsb=True, dr=3.0)
mainControls = generateControls(mainCurve, mainJoints, "main", "rect")

# major
majorCurve = mainCurve.duplicate()[0]
majorCurve.rename(@prefix+"_major_curve")
mainCurve.local >> majorCurve.create

majorJoints = generateJoints(majorCurve, @majorParams, "major")
pm.skinCluster(majorJoints, majorCurve, tsb=True, dr=3.0)

majorControls = generateControls(majorCurve, majorJoints, "major", "sphere", addTransform=True)

attachToCurveMod.attr.curve.set(mainCurve.name())
attachToCurveMod.attr.transforms.set([ctrl.getParent().name() for ctrl in majorControls])
attachToCurveMod.run()

makeSkinLocalMod.attr.skinnedGeo.set(majorCurve.name())
makeSkinLocalMod.run()
out_basis = makeSkinLocalMod.attr.out_basis.get()

for i, ctrl in enumerate(majorControls):
    ctrl.getParent() | pm.PyNode(out_basis[i])

# minor
minorCurve = mainCurve.duplicate()[0]
minorCurve.rename(@prefix+"_minor_curve")
majorCurve.local >> minorCurve.create

minorJoints = generateJoints(minorCurve, @minorParams, "minor")
pm.skinCluster(minorJoints, minorCurve, tsb=True, dr=3.0)

minorControls = generateControls(minorCurve, minorJoints, "minor", "sphere", addTransform=True)

attachToCurveMod.attr.curve.set(majorCurve.name())
attachToCurveMod.attr.transforms.set([ctrl.getParent().name() for ctrl in minorControls])
attachToCurveMod.run()

makeSkinLocalMod.attr.skinnedGeo.set(minorCurve.name())
makeSkinLocalMod.run()

out_basis = makeSkinLocalMod.attr.out_basis.get()

for i, ctrl in enumerate(minorControls):
    ctrl.getParent() | pm.PyNode(out_basis[i])

# apply wire    
pm.wire(@edgeCurve, gw=False, ce=0.0, li=0.0, dds=[0, 100], w=minorCurve, name=@edgeCurve+'_wire')

    ]]></run>
<attributes>
<attr name="prefix" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="edgeCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainCurve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_main_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="mainParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.5, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="majorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.3, 0.7, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="minorParams" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": [0, 0.1, 0.5, 0.9, 1], "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="makeSkinLocal" muted="1" uid="c3d086240a8642d5bcd762328d68df91">
<run><![CDATA[import pymel.core as pm

skinned = pm.PyNode(@skinnedGeo)
skin = pm.mel.eval("findRelatedSkinCluster "+skinned)
if not skin:
    error(f"Cannot find skinCluster for {skinned}")
    
skin = pm.PyNode(skin)
basis = []
    
for i, inf in enumerate(skin.influenceObjects()):
    if skin.bindPreMatrix[i].inputs():
        warning(f"bindPreMatrix[{i}] is connected, skipped")
        continue
        
    t = pm.createNode("transform", n=inf+"_basis")
    m = skin.bindPreMatrix[i].get().inverse()
    pm.xform(t, ws=True, m=m)
    t.worldInverseMatrix >> skin.bindPreMatrix[i]
    basis.append(t.name())
    
@set_out_basis(basis)    ]]></run>
<doc><![CDATA[## Summary  
Creates a local basis transform for each influence of a skin cluster, replacing the bindPreMatrix with a world‑inverse matrix that keeps the skin cluster localized to the influence objects. This is useful for cleaning up skinning data or preparing a rig for further manipulation.

## Inputs  
- **`skinned`**: The name of the skinned mesh or transform node that has an associated skinCluster. The module will locate the skinCluster that is related to this node.

## Outputs  
- **Basis Transforms**: For every influence object of the skinCluster, a new transform node named `<influence>_basis` is created.  
- **Updated bindPreMatrix**: The skinCluster’s `bindPreMatrix` attribute for each influence is replaced with a connection to the `worldInverseMatrix` of the corresponding basis transform.  
- **Warnings**: If an influence’s `bindPreMatrix` is already connected, a warning is emitted and that influence is skipped.

## Usage  
1. **Select the skinned mesh** (or provide its name) and set the `skinned` attribute.  
2. **Run the module**. It will automatically find the skinCluster, create basis transforms for each influence, and update the bindPreMatrix connections.  
3. **Verify** that the new `<influence>_basis` nodes appear in the Outliner and that the skinCluster’s bindPreMatrix attributes now point to these nodes.  
4. **Proceed** with any further skinning or rigging steps that rely on localized skin data.]]></doc>
<attributes>
<attr name="skinnedGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_minor_curve", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="out_basis" template="listBox" category="General" connect=""><![CDATA[{"items": ["lower_minor_1_joint_basis", "lower_minor_2_joint_basis", "lower_minor_3_joint_basis", "lower_minor_4_joint_basis", "lower_minor_5_joint_basis"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="attachToCurve" muted="1" uid="b79ce70fe8fc4009a31219c30b5eb506">
<run><![CDATA[import pymel.core as pm
import maya.cmds as cmds

curve = pm.PyNode(@curve)
transforms = [pm.PyNode(t) for t in @transforms]

curveShape = curve.getShape() if curve.type() == "transform" else curve

cpos = pm.createNode("nearestPointOnCurve", n="attachToCurve_cpos_tmp")
curveShape.worldSpace[0] >> cpos.inputCurve

for t in transforms:
	pos = pm.xform(t, q=True, ws=True, t=True)
	cpos.inPosition.set(pos)
	param = cpos.parameter.get()

	# Create pointOnCurveInfo to drive position
	poci = pm.createNode("pointOnCurveInfo", n=t.name() + "_pointOnCurveInfo")
	curveShape.worldSpace[0] >> poci.inputCurve
	poci.parameter.set(param)
	poci.turnOnPercentage.set(False)

	# Connect position to transform translate
	poci.position >> t.translate

pm.delete(cpos)
]]></run>
<doc><![CDATA[## Summary  
The **attachToCurve** module snaps a list of transforms to a NURBS curve by projecting each transform’s world position onto the curve. It uses a `nearestPointOnCurve` node to find the closest curve parameter and a `pointOnCurveInfo` node to drive the transform’s translate, leaving rotation and scale untouched.

## Inputs  
- **`curve`** – Name or reference to the NURBS curve that will serve as the attachment surface.  
- **`transforms`** – List of transform nodes whose world positions will be projected onto the curve.  

## Outputs  
- No explicit output nodes are created.  
- The module directly modifies the **translate** attributes of each transform in the `transforms` list, aligning them to the nearest point on the specified curve.

## Usage  
1. **Select the curve** you want to attach to and set the `curve` attribute (or use the button to pick the selected curve).  
2. **Populate the `transforms` list** with the transforms you wish to snap (e.g., IK handles, control joints, helper objects).  
3. **Run the module**. Each transform’s translate will be driven by a `pointOnCurveInfo` node that follows the curve’s shape.  
4. **Optional**: After execution, the temporary `nearestPointOnCurve` node is automatically deleted, leaving only the `pointOnCurveInfo` nodes connected to the transforms.  
5. **Adjust** the transforms in the viewport if needed; the connections will keep them attached to the curve as you move the curve or the transforms.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>transforms</b> to <b>NURBS curve</b> using closest point (translate only)."}]]></attr>
<attr name="curve" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "lower_major_curve", "placeholder": "NURBS curve name", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="transforms" template="listBox" category="General" connect=""><![CDATA[{"items": ["lower_minor_1_control_transform", "lower_minor_2_control_transform", "lower_minor_3_control_transform", "lower_minor_4_control_transform", "lower_minor_5_control_transform"], "default": "items"}]]></attr>
</attributes>
</module>
</children>
</module>