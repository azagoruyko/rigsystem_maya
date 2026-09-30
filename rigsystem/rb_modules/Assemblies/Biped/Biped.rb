<module name="Biped" muted="0" uid="ed125f42f41d430ab69f92c7e63cd036">
<doc><![CDATA[## Summary  
The **biped** module is a master controller that assembles a complete character rig by orchestrating its child modules—spine, head, eyes, shoulders, arms, fingers, legs, foot, cleanup, and finishing. It provides a single **mode** switch to generate placement helpers or build the final rig.

## Inputs  
- **`mode`** (radioButton) – Toggles between **Helpers** (generate guide controls) and **Run** (build the rig).  
- **Spine**  
  - `joints` – List of joint names forming the spine chain.  
  - `spans`, `curveOffset`, `aim_worldUpVector`, `attrsOn`, `parent`, `fkControls`, `ikControls`, `fixControls`, `skinDropoff`, `makeHipControl`, `hipParam`, `h_hip`, `fkWeights`, `ikWeights`, `fixWeights`, `h_fks`, `h_iks`, `h_fixs`.  
- **Head**  
  - `headJoint`, `neckJoints`, `numSpans`, `numFKControls`, `splineIK_upVector`, `splineIK_upAxis`, `neckControlsOrient`, `headControlsOrient`, `fkWeights`, `ikWeights`, `neckFKHelpers`, `headFKHelper`, `headIKHelper`, `optionsHelper`.  
- **Shoulders (L_shoulder, R_shoulder)**  
  - `name`, `driven`, `constraint`, `parent`, `rotateOrder`, `translateLock`, `rotateLock`, `curveType`, `helperAtTransform`, `helper`, `out_control`.  
- **Arms (L_arm, R_arm)**  
  - `name`, `joint1`, `joint2`, `joint3`, `fkNoFollow`, `lastCtrlOrient`, `ikHelperType`, `constrainIK`, `placeIkAt`, `h_fk1`, `h_fk2`, `h_fk3`, `h_ik`, `h_polevector`, `h_options`, `out_ikfkSwitch`, `out_ik1`, `out_ik2`, `out_ik3`, `out_fix3`, `out_fk1`, `out_fk2`, `out_fk3`, `out_ikHandle`, `out_fix2_ikHandle`, `out_ikCtrl`, `out_polevecCtrl`, `out_endStretchLoc1`, `out_endStretchLoc2`, `moduleInfo`.  
- **Fingers (L_fingers, R_fingers)**  
  - `side`, `name`, `fingers` (table of finger data), `spreadOn`, `cuppingOn`, `cuppingCoeff`, `helpers`, `out_*` attributes, `moduleInfo`.  
- **Legs (L_leg, R_leg)** – Each contains a nested **Limb** module with inputs identical to the arm limb: `joint1`‑`joint3`, `fkNoFollow`, `lastCtrlOrient`, `ikHelperType`, `constrainIK`, `placeIkAt`, helper names (`h_fk1`‑`h_fk3`, `h_ik`, `h_polevector`, `h_options`), and output attributes (`out_*`, `moduleInfo`).  
- **Foot** – Uses helper names (`h_heel`, `h_side1`, `h_side2`, `h_toe`, `h_foot`, `h_footroll`, `h_toe_ik`, `h_toe_fk`) and receives the limb’s output nodes (`out_ikHandle`, `out_ikfkSwitch`, `out_ik3`, `out_fk3`, `out_fix3`, `out_ikCtrl`, `out_polevecCtrl`, `out_endStretchLoc2`, `moduleInfo`).  
- **Cleanup** – `keepNamespaces`, `cleanupMemberships`, `cleanupDeformers`, `removeNodeTypes`.  
- **BipedFinishing** – `footAngle`.  

## Outputs  
- The module creates a rig hierarchy under the following top‑level groups:  
  - `controls` – Holds all user‑visible control transforms.  
  - `internal` – Contains joint chains, IK handles, and helper transforms.  
  - `others` – Stores auxiliary nodes (e.g., limits, constraints).  
  - `helpers` – Stores guide helpers for placement.  
- Each child module publishes a **`moduleInfo`** node that registers its controls, joints, and parameters, enabling downstream modules to connect to them.  
- The **foot** module outputs a `footroll` control and links it to the limb’s IK/FK system.  
- The **cleanup** modules perform namespace pruning, node locking, and deformer cleanup, leaving a clean scene ready for animation.  

## Usage  
1. **Set up the scene** – Create the required joint chains (spine, neck, head, arms, legs, fingers).  
2. **Configure child modules** – For each child module, set the appropriate attributes (joint names, helper types, weights, etc.).  
3. **Generate helpers** – Run the **biped** module in **Helpers** mode. This creates placement guides in the `helpers` group for all limbs, the spine, head, eyes, and foot. Adjust the helpers in the viewport to match the character’s proportions.  
4. **Build the rig** – Switch the **biped** module to **Run** mode and execute. The module will instantiate all child modules, build the joint chains, IK/FK systems, controls, and connect everything according to the published `moduleInfo` nodes.  
5. **Finalize** – Run the **bipedFinishing** module (mode = 1) to set default IK/FK states, enable stretching, and hide bend sets.  
6. **Cleanup** – Execute the **Cleanup** sub‑modules to remove unused namespaces, lock nodes, and delete unnecessary deformers or animation curves.  

After these steps, the scene contains a fully functional biped rig with all controls, IK/FK switches, stretch, soft‑IK, and foot‑roll systems ready for animation.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
</attributes>
<children>
<module name="unlockJoints" muted="0" uid="">
<run><![CDATA[import pymel.core as pm

for j in pm.PyNode(@root).listRelatives(c=True, ad=True, type="joint"):
    for a in "trs":
        for c in "xyz":
            j.attr(a+c).unlock()]]></run>
<attributes>
<attr name="root" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "skeleton", "placeholder": "Maya node", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="UpdateAverageBaseAngle" muted="0" uid="9b6ba97ecdbf4974997680e52cad5502">
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
<module name="spine" muted="0" uid="c8f6416f3c69439c94231c47ec5f6114">
<run><![CDATA[import json
import pymel.core as pm
import pymel.api as api
import rig_utils
from anim_utils import dynamicParent, switcher

RotateOrder = 3  # XZY

joints = [pm.PyNode(j) for j in @joints]

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    scale_val = rig_utils.getDistance(joints[0], joints[-1]) / 3.0

    L_curve = rig_utils.createPathCurve("L_" + @name, joints, spans=@spans)
    L_curve.t.set(@curveOffset)

    R_curve = rig_utils.createPathCurve("R_" + @name, joints, spans=@spans)
    R_curve.t.set([-1 * x for x in @curveOffset])

    surface = pm.loft(L_curve, R_curve, n=@name + "_surface", ch=1, u=1, c=0, ar=1, d=3, ss=1, rn=0, po=0, rsn=True)[0]

    helpersGrp = pm.createNode("transform", n=@name + "_helpers", p=helpersParent)
    pm.parentConstraint(joints[0], helpersGrp)
    
    # hip helper
    if @makeHipControl:
        surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_hip", surface, @hipParam, 0.5)
        hlp = rig_utils.curve.makeCurve(@name + "_hip_control_helper", "diamond")
        helpersGrp | hlp

        pm.matchTransform(hlp, surfaceTransform)
        hlp.s.set([scale_val/2, scale_val/2, scale_val/2])

        pm.delete(surfaceTransform)
        rig_utils.lockTRS(hlp, [1,1,1], [1,1,0], [], 1) 
        @set_h_hip(hlp.name())
    
    data = [("fk", "circle", @fkControls, @set_h_fks),
            ("ik", "cube", @ikControls, @set_h_iks),
            ("fix", "rect", @fixControls, @set_h_fixs)]

    for kin, helperType, controls, setter in data:
        helpers = []
        for i, (name, param, _) in enumerate(controls):
            surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_" + name, surface, param, 0.5)

            hlp = rig_utils.curve.makeCurve(@name + "_" + name + "_control_helper", helperType)
            if kin in ["ik", "fix"]:
                for sh in hlp.getShapes():
                    sh.overrideColor.set(18)
                    
            pm.matchTransform(hlp, surfaceTransform)
            
            hlp.s.set([scale_val, scale_val/3, scale_val])
            helpersGrp | hlp
            rig_utils.lockTRS(hlp, [1,1,1], [1,1,0], [], 1) 
            
            helpers.append(hlp.name())
            pm.delete(surfaceTransform)

        setter(helpers)

    pm.delete([L_curve, R_curve, surface])

elif @mode == 1:  # run

    def getParamAtPoint(surface, pnt):
        ns = api.MFnNurbsSurface(surface.__apimdagpath__())
        p = ns.closestPoint(api.MPoint(pnt[0], pnt[1], pnt[2]))
        return surface.getParamAtPoint(p, "world")

    def getLengthFromParam(curve, param):
        if param <= 0:
            return 0              
        curve = pm.PyNode(curve)
        arcLenDim = pm.createNode("arcLengthDimension")
        curve.worldSpace >> arcLenDim.nurbsGeometry
        arcLenDim.uParamValue.set(param)
        l = arcLenDim.arcLength.get()
        pm.delete(arcLenDim.getParent())
        return l

    h_fks = [pm.PyNode(n) for n in @h_fks]
    h_iks = [pm.PyNode(n) for n in @h_iks]
    h_fixs = [pm.PyNode(n) for n in @h_fixs]

    scale_mode = str(@scale)
    use_scale = scale_mode != "None"
    scale_lock = [0,1,1] if use_scale else [1, 1, 1]

    fkDropoff, ikDropoff, fixDropoff = @skinDropoff[0]  # first row

    controls_grp = pm.createNode("transform", n=@name + "_controls_group", p=controlsParent)
    internal_grp = pm.createNode("transform", n=@name + "_internal_group", p=internalParent)
    others_grp = pm.createNode("transform", n=@name + "_others_group", p=othersParent)
    rig_utils.lockTRS(controls_grp, [1,1,1], [1,1,1], [1,1,1], 0.5)
    rig_utils.lockTRS(internal_grp, [1,1,1], [1,1,1], [1,1,1], 0.5)
    rig_utils.lockTRS(others_grp, [1,1,1], [1,1,1], [1,1,1], 0.5)
    internal_grp.v.set(False)
    others_grp.v.set(False)

    surfaceTransforms_grp = pm.createNode("transform", n=@name + "_surfaceTransforms_group", p=internal_grp)
    rig_utils.lockTRS(surfaceTransforms_grp, [1,1,1], [1,1,1], [1,1,1], 0.5)
    
    L_base_curve = rig_utils.createPathCurve("L_" + @name + "_base", joints, spans=@spans)
    L_base_curve.t.set(@curveOffset)

    R_base_curve = rig_utils.createPathCurve("R_" + @name + "_base", joints, spans=@spans)
    R_base_curve.t.set([-1 * x for x in @curveOffset])

    base_surface = pm.loft(L_base_curve,
                           R_base_curve,
                           n=@name + "_base_surface",
                           ch=1, u=1, c=0, ar=1, d=3,
                           ss=1, rn=0, po=0, rsn=True)[0]

    pm.delete([L_base_curve, R_base_curve])  # remove curves
    
    hip_ctrl = None

    fk_controls = []
    fk_joints = []
    
    attrsControl = None
    
    for i, (ctrlName, u, orientation) in enumerate(@fkControls):
        surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_" + ctrlName, base_surface, u, 0.5)

        ctrl = pm.createNode("transform", n=@name + "_" + ctrlName + "_control", p=fk_controls[i - 1] if i > 0 else controls_grp)
        ctrl.ro.set(RotateOrder)
        
        jnt = pm.createNode("joint", n=@name + "_" + ctrlName + "_joint", p=internal_grp)

        if @makeHipControl:
            if i > 0:
                pm.parentConstraint(ctrl, jnt)
        else:                
            pm.parentConstraint(ctrl, jnt)

        if use_scale:
            if not (@makeHipControl and i == 0):
                pm.scaleConstraint(ctrl, jnt)

        pm.matchTransform(ctrl, surfaceTransform, position=True, rotation=False)  # position
        pm.delete(surfaceTransform)

        if pm.objExists(orientation):  # local orientation
            pm.matchTransform(ctrl, orientation, position=False, rotation=True)
        
        rig_utils.curve.makeFromCurve(ctrl, h_fks[i])
        rig_utils.setToOffsetParentMatrix(ctrl)

        if i == 0:  # first FK control
            if @attrsOn == "fk":
                attrsControl = ctrl
            
            if pm.objExists(@parent):
                ctrl_transform = pm.createNode("transform", n=@name + "_" + ctrlName + "_control_transform", p=controls_grp)
                pm.matchTransform(ctrl_transform, ctrl)
                ctrl_transform | ctrl
                rig_utils.setToOffsetParentMatrix(ctrl)
                pm.parentConstraint(@parent, ctrl_transform, mo=True)
                                
            rig_utils.lockTRS(ctrl, [], [], scale_lock, 1)

            # hip control
            if @makeHipControl:
                hip_surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_hip", base_surface, @hipParam, 0.5)

                hip_ctrl = pm.createNode("transform", n=@name + "_hip_control", p=ctrl)
                hip_ctrl.ro.set(RotateOrder)

                pm.matchTransform(hip_ctrl, hip_surfaceTransform, position=True, rotation=False)  # position
                rig_utils.setToOffsetParentMatrix(hip_ctrl)
                rig_utils.curve.makeFromCurve(hip_ctrl, pm.PyNode(@h_hip))
                
                pm.delete(hip_surfaceTransform)
                pm.parentConstraint(hip_ctrl, jnt)
                
                if use_scale:
                    pm.scaleConstraint(hip_ctrl, jnt)
                    
                rig_utils.lockTRS(hip_ctrl, [], [], scale_lock, 1)
        else:
            if i == len(@fkControls) - 1:
                rig_utils.lockTRS(ctrl, [], [], scale_lock, 1)
            else:
                rig_utils.lockTRS(ctrl, [1, 1, 1], [], scale_lock, 1)        
        
        dynamicParent.makeDynamicParent(ctrl, ctrl)

        if i == len(@fkControls) - 1:
            surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_" + ctrlName + "_end", base_surface, 1, 0.5)
            jnt_end = pm.createNode("joint", n=@name + "_" + ctrlName + "_end_joint", p=jnt)

            fk_joints.append(jnt_end)

            pm.matchTransform(jnt_end, surfaceTransform)
            pm.delete(surfaceTransform)

        fk_controls.append(ctrl)
        fk_joints.append(jnt)
        
    fk_surface = base_surface.duplicate()[0]
    fk_surface.rename(@name + "_fk_surface")

    if @fkControls:
        skin = pm.skinCluster(fk_joints, fk_surface, tsb=True, dr=fkDropoff)
        if @fkWeights:
            rig_utils.skinCluster.SkinClusterHelper(skin.name()).fromJson(@fkWeights)

    others_grp | fk_surface
    
    ik_surface = base_surface.duplicate()[0]
    ik_surface.rename(@name + "_ik_surface")

    fk_surface.worldSpace >> ik_surface.create

    others_grp | ik_surface
    
    ik_joints = []
    ik_base_joints = []
    ik_controls = []

    for i, (ctrlName, u, orientation) in enumerate(@ikControls):
        surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_" + ctrlName, fk_surface, u, 0.5)
        surfaceTransforms_grp | surfaceTransform

        ctrl_transform = pm.createNode("transform", n=@name + "_" + ctrlName + "_control_transform", p=controls_grp)
        ctrl = pm.createNode("transform", n=@name + "_" + ctrlName + "_control", p=ctrl_transform)
        ctrl.ro.set(RotateOrder)

        jnt = pm.createNode("joint", n=@name + "_" + ctrlName + "_joint", p=internal_grp)
        pm.parentConstraint(ctrl, jnt)
        if use_scale:
            pm.scaleConstraint(ctrl, jnt)

        baseJoint = pm.createNode("joint", n=@name + "_" + ctrlName + "_base_joint", p=internal_grp)
        pm.parentConstraint(ctrl_transform, baseJoint)

        pm.matchTransform(ctrl_transform, surfaceTransform, position=True, rotation=False)  # position

        if pm.objExists(orientation):  # local orientation
            pm.matchTransform(ctrl_transform, orientation, position=False, rotation=True)

        pm.parentConstraint(surfaceTransform, ctrl_transform, mo=True)

        rig_utils.curve.makeFromCurve(ctrl, h_iks[i])        
        dynamicParent.makeDynamicParent(ctrl, ctrl)

        ik_joints.append(jnt)
        ik_base_joints.append(baseJoint)
        ik_controls.append(ctrl)

        rig_utils.lockTRS(ctrl, [], [], scale_lock, 1)
        
        if i == 0 and @attrsOn == "ik":
            attrsControl = ctrl

    if @ikControls:
        skin = pm.skinCluster(ik_joints, ik_surface, tsb=True, dr=ikDropoff)

        for i in range(len(ik_base_joints)):
            ik_base_joints[i].worldInverseMatrix >> skin.bindPreMatrix[i]

        if @ikWeights:
            rig_utils.skinCluster.SkinClusterHelper(skin.name()).fromJson(@ikWeights)

    fix_surface = base_surface.duplicate()[0]
    fix_surface.rename(@name + "_fix_surface")

    ik_surface.worldSpace >> fix_surface.create

    others_grp | fix_surface
    
    fix_joints, fix_base_joints = [], []
    fix_controls = []

    for i, (ctrlName, u, orientation) in enumerate(@fixControls):
        surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_" + ctrlName, ik_surface, u, 0.5)
        surfaceTransforms_grp | surfaceTransform

        ctrl_transform = pm.createNode("transform", n=@name + "_" + ctrlName + "_control_transform", p=controls_grp)
        ctrl = pm.createNode("transform", n=@name + "_" + ctrlName + "_control", p=ctrl_transform)
        ctrl.ro.set(RotateOrder)

        jnt = pm.createNode("joint", n=@name + "_" + ctrlName + "_joint", p=internal_grp)
        pm.parentConstraint(ctrl, jnt)
        if use_scale:
            pm.scaleConstraint(ctrl, jnt)

        baseJoint = pm.createNode("joint", n=@name + "_" + ctrlName + "_base_joint", p=internal_grp)
        pm.parentConstraint(ctrl_transform, baseJoint)

        pm.matchTransform(ctrl_transform, surfaceTransform, position=True, rotation=False)  # position

        if pm.objExists(orientation):  # local orientation
            pm.matchTransform(ctrl_transform, orientation, position=False, rotation=True)

        pm.parentConstraint(surfaceTransform, ctrl_transform, mo=True)

        rig_utils.curve.makeFromCurve(ctrl, h_fixs[i])
        
        dynamicParent.makeDynamicParent(ctrl, ctrl)

        fix_joints.append(jnt)
        fix_base_joints.append(baseJoint)
        fix_controls.append(ctrl)

        rig_utils.lockTRS(ctrl, [], [], scale_lock, 1)

    if @fixControls:
        ik_fix = ik_joints + fix_joints
        ik_fix_base = ik_joints + fix_base_joints

        skin = pm.skinCluster(ik_fix, fix_surface, tsb=True, dr=fixDropoff)

        for i, j in enumerate(ik_fix_base):
            j.worldInverseMatrix >> skin.bindPreMatrix[i]

        if @fixWeights:
            rig_utils.skinCluster.SkinClusterHelper(skin.name()).fromJson(@fixWeights)
    
    attrsControl.addAttr("stretch", min=0, max=1, dv=1, k=True)
        
    # make enlarged surface
    L_cvs = [pm.dt.Vector(pm.xform(fix_surface.cv[i][0], q=True, ws=True, t=True)) for i in range(fix_surface.numCVsInU())]
    R_cvs = [pm.dt.Vector(pm.xform(fix_surface.cv[i][fix_surface.numCVsInV()-1], q=True, ws=True, t=True)) for i in range(fix_surface.numCVsInU())]
    
    for lst in [L_cvs, R_cvs]:
        l = (lst[0]-lst[-1]).length()/2.0
        
        lastCV = lst[-1] + (lst[-1]-lst[-2]).normal()*l
        direction = (lastCV-lst[-1]).normal()
        
        numFixedCVs = 3
        for k in range(numFixedCVs):
            lst.append(lst[-1] + direction*0.0001)
            
        lst.append(lastCV)        
    
    finalSurface = fix_surface

    L_crv = pm.curve(d=3, p=L_cvs)
    R_crv = pm.curve(d=3, p=R_cvs)
    enlarged_surface = pm.loft(L_crv, R_crv, n=@name + "_slide_surface", ch=1, u=1, c=0, ar=1, d=3, ss=1, rn=0, po=0, rsn=True)[0]
    others_grp | enlarged_surface
    pm.delete([L_crv, R_crv])
        
    rig_utils.createWrap(fix_surface, enlarged_surface)    

    fix_curve = pm.PyNode(pm.duplicateCurve(enlarged_surface + ".v[0.5]", ch=1, rn=False, local=0, n=@name + "_stretch_fix_curve")[0])
    curveInfo = pm.createNode("curveInfo", n=fix_curve + "_stretch_curveInfo")
    fix_curve.worldSpace >> curveInfo.inputCurve
    others_grp | fix_curve
    finalSurface = enlarged_surface
    
    surfaceTransforms = []
    for i, sj in enumerate(joints):
        u, v = getParamAtPoint(finalSurface, sj.getTranslation("world"))    
        
        paramMult = pm.createNode("multDL", n=@name + "_joint" + str(i + 1) + "_scaleParam_multDL")
        paramMult.input1.set(getLengthFromParam(fix_curve, u))
        pm.PyNode("main_control").scaleFactor >> paramMult.input2
            
        paramFromLength = pm.createNode("paramFromLength", n=@name + "_joint" + str(i + 1) + "_paramFromLength")
        fix_curve.worldSpace >> paramFromLength.inputCurve
        paramMult.output >> paramFromLength.length

        b2a = pm.createNode("blendTwoAttr", n=@name + "_joint" + str(i + 1) + "_paramSelector_blendTwoAttr")        
        attrsControl.stretch >> b2a.attributesBlender
        paramFromLength.outParam >> b2a.input[0]
        b2a.input[1].set(u)
            
        paramAttr = b2a.output                     
        
        surfaceTransform = rig_utils.makeSurfaceTransform(@name + "_joint" + str(i + 1), finalSurface, paramAttr, v)
        surfaceTransforms_grp | surfaceTransform
        surfaceTransforms.append(surfaceTransform)
        
        # fix start/end joints
        if i == 0 or i == len(joints) - 1:
            surfaceTransform.rx.disconnect()
            surfaceTransform.ry.disconnect()
            surfaceTransform.rz.disconnect()
            pm.orientConstraint(ik_controls[0 if i == 0 else -1], surfaceTransform, mo=True)

        if use_scale:
            oppositeTransform = rig_utils.makeSurfaceTransform(@name + "_joint" + str(i + 1) + "_opposite", finalSurface, paramAttr, 1.0)
            surfaceTransforms_grp | oppositeTransform

            init_dist = rig_utils.getDistance(surfaceTransform, oppositeTransform)
            if init_dist < 0.0001:
                init_dist = 0.0001

            distBetween = pm.createNode("distanceBetween", n=@name + "_joint" + str(i + 1) + "_width_distanceBetween")
            surfaceTransform.matrix >> distBetween.inMatrix1
            oppositeTransform.matrix >> distBetween.inMatrix2

            scaleMult = pm.createNode("multiplyDivide", n=@name + "_joint" + str(i + 1) + "_width_scale_multiplyDivide")
            scaleMult.operation.set(2)
            distBetween.distance >> scaleMult.input1X
            scaleMult.input2X.set(init_dist)

            if "Y" in scale_mode:
                scaleMult.outputX >> sj.sy
            if "Z" in scale_mode:
                scaleMult.outputX >> sj.sz

    for i in range(len(joints)):
        sj = joints[i]
        st = surfaceTransforms[i]
        
        if i > 0 and i < len(joints) - 1:
            next_sj = joints[i + 1]
            next_st = surfaceTransforms[i + 1]

            sc_bone1 = pm.createNode("joint", n=@name + "_joint" + str(i + 1) + "_sc_start_joint", p=internal_grp)
            pm.matchTransform(sc_bone1, sj)

            sc_bone2 = pm.createNode("joint", n=@name + "_joint" + str(i + 1) + "_sc_end_joint", p=sc_bone1)
            pm.matchTransform(sc_bone2, next_sj, position=True, rotation=False)
            pm.matchTransform(sc_bone2, sj, position=False, rotation=True)

            sc_handle, _ = pm.ikHandle(n=@name + "_joint" + str(i + 1) + "_ikHandle", sj=sc_bone1, ee=sc_bone2, solver="ikSCsolver")
            
            pm.pointConstraint(st, sc_bone1)
            next_st | sc_handle
            
            pm.parentConstraint(sc_bone1, sj, mo=True)
        else:
            pm.parentConstraint(st, sj, mo=True)

    pm.delete(base_surface)

    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@name)
    moduleInfo.setAttr("type", "spine")
    moduleInfo.setAttr("fk_surface", fk_surface.message)
    moduleInfo.setAttr("ik_surface", ik_surface.message)
    moduleInfo.setAttr("fix_surface", fix_surface.message)
    
    if hip_ctrl:
        moduleInfo.setAttr("hip", hip_ctrl.message)
    
    for i, fk in enumerate(fk_controls):
        moduleInfo.setAttr("fk"+str(i+1), fk_controls[i].message)
        
    for i, ik in enumerate(ik_controls):
        moduleInfo.setAttr("ik"+str(i+1), ik_controls[i].message)
        
    for i, fix in enumerate(fix_controls):
        moduleInfo.setAttr("fix"+str(i+1), fix_controls[i].message)        
    
    data = {"ik":[], "fk":[], "fix":[], "name": @name}            
    for ctrlName, u, _ in @fkControls:
        data["fk"].append([ctrlName, u])
        
    for ctrlName, u, _ in @ikControls:
        data["ik"].append([ctrlName, u])

    for ctrlName, u, _ in @fixControls:
        data["fix"].append([ctrlName, u])
        
    moduleInfo.setAttr("params", json.dumps(data))
]]></run>
<doc><![CDATA[## Summary
The **spine** module automates the creation of a Maya spine rig that supports FK, IK, and fix control chains. It can first generate helper curves and control guides (Helpers mode) or build the full rig hierarchy with joints, controls, skin clusters, stretch, wrap, and dynamic parenting (Run mode). A `moduleInfo` node is created to expose all generated surfaces, joints, and controls for downstream modules.

## Inputs
- **mode** – `Helpers` or `Run` to choose between guide generation or full rig construction.  
- **name** – Base name used for all created nodes (e.g., `M_spine`).  
- **joints** – List of spine joint names that define the spine chain.  
- **spans** – Number of spans for the path curves.  
- **curveOffset** – Vector offset applied to the left/right path curves.  
- **attrsOn** – Which control chain (`fk` or `ik`) receives the `attrsControl` attributes.  
- **parent** – Optional parent transform for the control hierarchy.  
- **fkControls** – Table of FK control names, parameters, and optional orientation nodes.  
- **ikControls** – Table of IK control names, parameters, and optional orientation nodes.  
- **fixControls** – Table of fix control names, parameters, and optional orientation nodes.  
- **skinDropoff** – Drop‑off values for FK, IK, and fix skin clusters.  
- **makeHipControl** – Boolean to create an optional hip control.  
- **hipParam** – Surface parameter for the hip control placement.  
- **h_hip** – Reference helper node for the hip control.  
- **fkWeights**, **ikWeights**, **fixWeights** – Optional JSON weight data for skin clusters.  
- **h_fks**, **h_iks**, **h_fixs** – Lists of helper control names used in Helpers mode.  
- **scale** – Scale lock mode (`None`, `Y`, `Z`, `Y,Z`) for joint scaling.

## Outputs
- **moduleInfo** – A `ModuleInfo` node named after the module that stores:
  - `type` (`spine`)
  - Surface messages (`fk_surface`, `ik_surface`, `fix_surface`)
  - Hip control message (if created)
  - Messages for each FK, IK, and fix control
  - Serialized `params` JSON containing control names and parameters.
- **Surfaces** – Duplicate surfaces for FK, IK, and fix chains (`*_fk_surface`, `*_ik_surface`, `*_fix_surface`).  
- **Joints** – Internal spine joints for FK, IK, and fix chains, plus optional hip joint.  
- **Controls** – FK, IK, and fix control transforms, plus optional hip control.  
- **Helper Curves & Controls** – In Helpers mode, left/right path curves, surface, and helper control nodes.  
- **Skin Clusters** – FK, IK, and fix skin clusters with optional weight data.  
- **Stretch & Wrap Setups** – Nodes that drive joint scaling and wrap behavior.  
- **Dynamic Parenting** – Connections that keep controls and joints in sync.

## Usage
1. **Set up the spine chain** – Select the spine joints in the scene and assign them to the `joints` list.  
2. **Configure control tables** – Define FK, IK, and fix control names, parameters (0–1 along the spine), and optional orientation nodes in the `fkControls`, `ikControls`, and `fixControls` tables.  
3. **Generate helpers** – Set `mode` to **Helpers** and run the module. This creates left/right path curves, a lofted surface, and helper control nodes for FK, IK, and fix chains. Adjust the helpers in the viewport to match the desired control placement.  
4. **Build the rig** – Change `mode` to **Run**.  
   - If a parent transform is desired, set the `parent` attribute.  
   - Optionally enable `makeHipControl` and set `hipParam` and `h_hip` for a hip control.  
   - Provide any weight data via `fkWeights`, `ikWeights`, or `fixWeights` if pre‑skinned data should be applied.  
   - Execute the module. It will create the full rig hierarchy, skin clusters, stretch, wrap, and dynamic parenting.  
5. **Connect downstream modules** – Use the `moduleInfo` node or the individual control messages (`fk1`, `ik1`, etc.) to link child modules (e.g., hand, foot, or spine extension rigs).  
6. **Fine‑tune** – Adjust parameters such as `scale`, `attrsOn`, or control orientations as needed after the rig is built.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_spine", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["M_spine_1_joint", "M_spine_2_joint", "M_spine_3_joint", "M_spine_4_joint", "M_spine_5_joint"], "default": "items"}]]></attr>
<attr name="spans" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 4, "min": "", "buttonEnabled": false}]]></attr>
<attr name="curveOffset" template="vector" category="Params" connect=""><![CDATA[{"default": "value", "value": [0.2, 0.0, 0.0]}]]></attr>
<attr name="attrsOn" template="comboBox" category="Params" connect=""><![CDATA[{"items": ["fk", "ik"], "current": "fk", "default": "current"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="Controls" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="fkControls" template="table" category="Controls" connect=""><![CDATA[{"default": "items", "items": [["fk_1", 0, ""], ["fk_2", 0.3, ""], ["fk_3", 0.7, ""]], "header": ["Name", "Param", "Orient"]}]]></attr>
<attr name="ikControls" template="table" category="Controls" connect=""><![CDATA[{"items": [["ik_1", 0, ""], ["ik_2", 0.7, ""]], "header": ["Name", "Param", "Orient"], "default": "items"}]]></attr>
<attr name="fixControls" template="table" category="Controls" connect=""><![CDATA[{"default": "items", "items": [["fix", 0.5, ""]], "header": ["Name", "Param", "Orient"]}]]></attr>
<attr name="skinDropoff" template="table" category="Controls" connect=""><![CDATA[{"default": "items", "items": [[3, 3, 3]], "header": ["fk", "ik", "fix"]}]]></attr>
<attr name="makeHipControl" template="checkBox" category="Hip" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="hipParam" template="lineEditAndButton" category="Hip" connect=""><![CDATA[{"value": 0.25, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_hip" template="lineEditAndButton" category="Hip" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_spine_hip_control_helper"}]]></attr>
<attr name="fkWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {"weights": {"M_spine_fk_1_joint": [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.986, 0.986, 0.986, 0.986, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], "M_spine_fk_2_joint": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.014, 0.014, 0.014, 0.014, 0.49579458140478566, 0.49579093223012544, 0.49579093223012544, 0.49579458140478566, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], "M_spine_fk_3_end_joint": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.896625875922474e-05, 1.9819796128433987e-06, 1.9819796128434275e-06, 1.896625875922491e-05, 0.00042093809970863635, 1.571933729845909e-05, 1.5719337298457932e-05, 0.00042093809970862616, 0.5, 0.5, 0.5, 0.5], "M_spine_fk_3_joint": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5042054185952144, 0.5042090677698745, 0.5042090677698745, 0.5042054185952144, 0.9999810337412408, 0.9999980180203871, 0.9999980180203871, 0.9999810337412408, 0.9995790619002913, 0.9999842806627016, 0.9999842806627016, 0.9995790619002913, 0.5, 0.5, 0.5, 0.5]}, "skinningMethod": 0, "dqWeights": []}, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="ikWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {"weights": {"M_spine_ik_1_joint": [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.8535111026375849, 0.8535827133252583, 0.8535827133252583, 0.8535111026375849, 0.060491422002500565, 0.060429033458429544, 0.060429033458429544, 0.060491422002500565, 0.00030247935019437396, 0.00029625739908750015, 0.00029625739908750015, 0.00030247935019437396, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], "M_spine_ik_2_joint": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1464888973624152, 0.14641728667474177, 0.14641728667474177, 0.1464888973624152, 0.9395085779974994, 0.9395709665415705, 0.9395709665415705, 0.9395085779974994, 0.9996975206498057, 0.9997037426009125, 0.9997037426009125, 0.9996975206498057, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]}, "skinningMethod": 0, "dqWeights": []}, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="fixWeights" template="lineEditAndButton" category="Weights" connect=""><![CDATA[{"value": {"weights": {"M_spine_ik_1_joint": [1.0, 0.9999999266398172, 0.9999999266398172, 0.9999980196952959, 0.7327678839085018, 0.7328254099742538, 0.7328254099742538, 0.732767883908502, 0.31912697000356083, 0.3191280337293164, 0.3191280337293164, 0.31912697000356083, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], "M_spine_ik_2_joint": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.22419263384839638, 0.22415977062897696, 0.22415977062897696, 0.22419263384839638, 0.5505107467661323, 0.5506687658457089, 0.5506687658457089, 0.5505107467661323, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], "M_spine_fix_joint": [0.0, 7.336018285103571e-08, 7.336018285103571e-08, 1.9803047041770833e-06, 0.2672321160914982, 0.2671745900257462, 0.2671745900257462, 0.267232116091498, 0.6808730299964392, 0.6808719662706836, 0.6808719662706836, 0.6808730299964392, 0.7758073661516036, 0.775840229371023, 0.775840229371023, 0.7758073661516036, 0.4494892532338677, 0.4493312341542911, 0.4493312341542911, 0.4494892532338677, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]}, "skinningMethod": 0, "dqWeights": []}, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_fks" template="listBox" category="Helpers" connect=""><![CDATA[{"default": "items", "items": ["M_spine_fk_1_control_helper", "M_spine_fk_2_control_helper", "M_spine_fk_3_control_helper"]}]]></attr>
<attr name="h_iks" template="listBox" category="Helpers" connect=""><![CDATA[{"default": "items", "items": ["M_spine_ik_1_control_helper", "M_spine_ik_2_control_helper"]}]]></attr>
<attr name="h_fixs" template="listBox" category="Helpers" connect=""><![CDATA[{"default": "items", "items": ["M_spine_fix_control_helper"]}]]></attr>
<attr name="scale" template="comboBox" category="Params" connect=""><![CDATA[{"items": ["None", "Y", "Z", "Y,Z"], "current": "None", "default": "current"}]]></attr>
</attributes>
</module>
<module name="head" muted="0" uid="b79cb052aef143f7ad8ea6d3260f8e98">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

ROTATE_ORDER = 3  # XZY

neckJoint = pm.PyNode(@neckJoint)
headJoint = pm.PyNode(@headJoint)

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")
        
if @mode == 0:  # helpers
    scale = rig_utils.getDistance(neckJoint, headJoint)

    # neck FK helper
    neckHelper_transform = pm.createNode("transform", n="M_neck_helper_transform", p=helpersParent)
    pm.parentConstraint(neckJoint, neckHelper_transform)
    
    neckFKHelper = rig_utils.curve.makeCurve("M_neck_fk_ctrl_helper", "circle")
    neckHelper_transform | neckFKHelper
    neckFKHelper.s.set([scale/2, scale/2, scale/2])
    rig_utils.lockTRS(neckFKHelper, [0,1,1], [1,1,1], [], 1)    
    @set_h_neckFK(neckFKHelper.name())

    # head options helper
    headHelpers_transform = pm.createNode("transform", n="M_head_helpers_transform", p=helpersParent)
    pm.parentConstraint(headJoint, headHelpers_transform)
    
    helper = rig_utils.curve.makeCurve("M_head_options_ctrl_helper", "flag")

    helper.s.set([scale/2, scale/2, scale/2])
    headHelpers_transform | helper
    helper.t.set([0,0,-scale])
    rig_utils.lockTRS(helper, [1,1,0], [1,1,1], [], 1)
    @set_h_options(helper.name())

    # head FK helper
    helper = rig_utils.curve.makeCurve("M_head_fk_ctrl_helper", "circle")
    headHelpers_transform | helper
    helper.t.set([scale, 0, 0])
    helper.r.set([0, 0, 90])
    helper.s.set([scale, scale, scale])
    rig_utils.lockTRS(helper, [0,1,1], [1,1,1], [], 1)
    @set_h_headFK(helper.name())

    # head IK helper
    helper = rig_utils.curve.makeCurve("M_head_ik_ctrl_helper", "sphere")
    headHelpers_transform | helper
    helper.t.set([scale/2, 0, 0])
    helper.s.set([scale, scale, scale])
    rig_utils.lockTRS(helper, [0,1,1], [1,1,1], [], 1)    
    @set_h_headIK(helper.name())

elif @mode == 1:  # run
    neckParent = neckJoint.getParent()

    neckFKHelper = pm.PyNode(@h_neckFK)
    headFKHelper = pm.PyNode(@h_headFK)
    headIKHelper = pm.PyNode(@h_headIK)
    optionsHelper = pm.PyNode(@h_options)

    controls_grp = pm.createNode("transform", n="M_neck_controls_group", p=controlsParent)
    rig_utils.lockTRS(controls_grp)

    internal_grp = pm.createNode("transform", n="M_neck_internal_group", p=internalParent)
    rig_utils.lockTRS(internal_grp, v=0.5)

    # head options control
    head_options_ctrl = pm.createNode("transform", n="M_head_options_control", p=controls_grp)
    pm.parentConstraint(headJoint, head_options_ctrl)

    head_options_ctrl.addAttr("ikfk", min=0, max=1, dv=1, k=True)  # fk default

    head_options_ctrl.addAttr("scaleFactor", min=0.01, dv=1.0, k=True)
    head_options_ctrl.scaleFactor >> headJoint.sx
    head_options_ctrl.scaleFactor >> headJoint.sy
    head_options_ctrl.scaleFactor >> headJoint.sz

    rig_utils.curve.makeFromCurve(head_options_ctrl, optionsHelper)
    rig_utils.lockTRS(head_options_ctrl)

    ikfk_rev = pm.createNode("reverse", n="M_neck_ikfk_reverse")
    head_options_ctrl.ikfk >> ikfk_rev.inputX
    
    # ik/fk bones
    fk1 = rig_utils.matchJoint(neckJoint, name="M_neck_fk_joint")
    fk2 = rig_utils.matchJoint(headJoint, name="M_head_fk_joint")
    internal_grp | fk1 | fk2

    ik1 = rig_utils.matchJoint(neckJoint, name="M_neck_ik_joint")
    ik2 = rig_utils.matchJoint(headJoint, name="M_head_ik_joint")
    internal_grp | ik1 | ik2
    
    pm.pointConstraint(neckJoint, ik1)

    # neck FK control
    neck_fk_ctrl_transform = pm.createNode("transform", n="M_neck_fk_control_transform", p=controls_grp)
    pm.matchTransform(neck_fk_ctrl_transform, neckParent)
    pm.pointConstraint(neckJoint, neck_fk_ctrl_transform)
    head_options_ctrl.ikfk >> neck_fk_ctrl_transform.v
    
    neck_fk_ctrl = pm.createNode("transform", n="M_neck_fk_control")
    neck_fk_ctrl_transform | neck_fk_ctrl
    neck_fk_ctrl.ro.set(ROTATE_ORDER)
    neck_fk_ctrl.addAttr("scaleFactor",min=0.01, dv=1.0, k=True)
        
    pm.matchTransform(neck_fk_ctrl, neckJoint, position=True, rotation=False)  # position

    if pm.objExists(@neckOrient):  # local orientation
        pm.matchTransform(neck_fk_ctrl, @neckOrient, position=False, rotation=True)
            
    switcher.addFollow(neck_fk_ctrl, controls_grp, neckParent, attr="followBody", default=1.0, transform=neck_fk_ctrl_transform, type="orient")
    
    rig_utils.setToOffsetParentMatrix(neck_fk_ctrl)
    rig_utils.curve.makeFromCurve(neck_fk_ctrl, neckFKHelper)
    rig_utils.lockTRS(neck_fk_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.parentConstraint(neck_fk_ctrl, fk1, mo=True)
    neck_fk_ctrl.scaleFactor >> fk1.sx    
    
    # head FK control
    head_fk_ctrl = pm.createNode("transform", n="M_head_fk_control", p=neck_fk_ctrl)
    head_fk_ctrl.ro.set(ROTATE_ORDER)

    pm.matchTransform(head_fk_ctrl, headJoint, position=True, rotation=False)  # position

    if pm.objExists(@headOrient):  # local orientation
        pm.matchTransform(head_fk_ctrl, @headOrient, position=False, rotation=True)

    switcher.addFollow(head_fk_ctrl, controls_grp, neck_fk_ctrl, attr="followNeck", default=0.0, type="orient")
        
    rig_utils.setToOffsetParentMatrix(head_fk_ctrl)
    rig_utils.curve.makeFromCurve(head_fk_ctrl, headFKHelper)
    
    pm.pointConstraint(fk2, head_fk_ctrl, mo=True)
    
    rig_utils.lockTRS(head_fk_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(head_fk_ctrl, fk2, mo=True)

    # head IK control
    head_ik_ctrl = pm.createNode("joint", n="M_head_ik_control", p=controls_grp)
    head_ik_ctrl.ro.set(ROTATE_ORDER)
    head_ik_ctrl.radius.set(0)
    
    ikfk_rev.outputX >> head_ik_ctrl.v

    switcher.addFollow(head_ik_ctrl, controls_grp, neckParent, attr="followBody", default=1.0, type="parent")
    switcher.addFollow(head_ik_ctrl, controls_grp, neckParent, attr="followNeck", default=0.0, type="jointOrient")
    
    pm.matchTransform(head_ik_ctrl, headJoint, position=True, rotation=False)  # position

    if pm.objExists(@headOrient):  # local orientation
        pm.matchTransform(head_ik_ctrl, @headOrient, position=False, rotation=True)

    rig_utils.setToOffsetParentMatrix(head_ik_ctrl)

    rig_utils.curve.makeFromCurve(head_ik_ctrl, headIKHelper)
    
    dynamicParent.makeDynamicParent(head_ik_ctrl, head_ik_ctrl)
    rig_utils.lockTRS(head_ik_ctrl, [], [], [1, 1, 1], 1)
    rig_utils.lockAttr(head_ik_ctrl.radius)
    
    ik_sc_ikHandle = pm.ikHandle(
        sj=ik1,
        ee=ik2,
        solver="ikSCsolver",
        n="M_neck_ik_ikHandle")[0]
    internal_grp | ik_sc_ikHandle
    
    pm.parentConstraint(head_ik_ctrl, ik_sc_ikHandle, mo=True)
    
    d = rig_utils.createDistance("M_neck_ik_distance", ik1, head_ik_ctrl)
    
    rig_utils.makeStretchable(
        "M_neck_ik_stretch",
        [ik1],
        d,
        squash=0.01,
        saveVolume=0,
        scales=(True, False, False),
    )
    
    pm.orientConstraint(head_ik_ctrl, ik2, mo=True)
    
    # head constraints
    oc = pm.orientConstraint(fk1, ik1, neckJoint)
    oc.interpType.set(2)
    head_options_ctrl.ikfk >> oc.w0
    ikfk_rev.outputX >> oc.w1
    
    pc = pm.parentConstraint(fk2, ik2, headJoint, mo=True)
    pc.interpType.set(2)
    head_options_ctrl.ikfk >> pc.w0
    ikfk_rev.outputX >> pc.w1
    
    # moduleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo("M_head")
    moduleInfo.setAttr("type","head")

    moduleInfo.setAttr("options", head_options_ctrl.message)
    moduleInfo.setAttr("ikfk", head_options_ctrl.ikfk)
    
    moduleInfo.setAttr("head_joint", headJoint.message)
    moduleInfo.setAttr("neck_joint", neckJoint.message)
    moduleInfo.setAttr("neck_ik_joint", ik1.message)
    
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "neck_fk", neck_fk_ctrl, ik1)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "head_fk", head_fk_ctrl, head_ik_ctrl)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "head_ik", head_ik_ctrl, head_fk_ctrl)
]]></run>
<doc><![CDATA[## Summary
Builds a comprehensive head and neck rig that supports FK and IK control, head‑follow options, neck twist and stretch, and seamless kinematic switching. The system creates helper curves in *Helpers* mode, then constructs the full control hierarchy, joint chains, blend shapes, and stretchable spline IK in *Run* mode, publishing a `moduleInfo` node for downstream modules.

## Inputs
- **`mode`** (`Helpers` / `Run`): Toggles between generating placement helpers and building the final rig.
- **`headJoint`**: Name of the head joint that will be driven by the rig.
- **`neckJoints`**: List of neck joint names (typically one or more joints from base to head).
- **`numSpans`**: Number of spans for the spline curves used in FK/IK chains.
- **`numFKControls`**: Number of FK control points along the neck.
- **`splineIK_upAxis`**: Integer specifying the up‑axis for the spline IK solver.
- **`splineIK_upVector`**: 3‑component vector defining the up‑vector for the spline IK.
- **`neckControlsOrient`**: Optional transform used to orient neck FK controls locally.
- **`headControlsOrient`**: Optional transform used to orient head FK/IK controls locally.
- **`fkWeights` / `ikWeights`**: JSON objects containing pre‑defined skinning weights for FK and IK chains.
- **Helper attributes** (`neckFKHelpers`, `headFKHelper`, `headIKHelper`, `optionsHelper`): Names of helper curves created in *Helpers* mode; used to drive the final control shapes.

## Outputs
- **`moduleInfo` node (`M_head`)**: Publishes rig metadata (type, head/neck joints, scale factors, IK/FK switch attribute, options control) for downstream modules.
- **Control hierarchy**:  
  - `M_head_options_control` (FK default) with `ikfk` attribute.  
  - `M_head_fk_control` (FK head control).  
  - `M_head_ik_control` (IK head control).  
- **Joint chains**:  
  - FK joints (`M_neck_fk_*_joint`), end joint, and internal twist joints (`M_neck_rotate_*_joint`).  
  - IK joints (`M_head_ik_root_joint`, `M_head_ik_joint`).  
  - Spline IK joints (`M_neck_spline_*_joint`).  
- **Blend shapes & IK handles**: `M_neck` blend shape, spline IK handle, twist IK handle, and stretch nodes.
- **Helper groups**: `M_neck_controls_group`, `M_neck_internal_group`, `M_neck_others_group`.

## Usage
1. **Prepare the scene**: Create the head joint and one or more neck joints.  
2. **Run in *Helpers* mode** (`mode = 0`):  
   - The module will generate FK, head options, and IK helper curves under the `helpers` parent.  
   - Adjust the helper positions and orientations in the viewport to match the character’s anatomy.  
3. **Switch to *Run* mode** (`mode = 1`) and execute:  
   - The module reads the helper names, builds the full control hierarchy, joint chains, and spline IK.  
   - It also sets up stretch, twist, and seamless kinematic switching.  
4. **Connect downstream modules**:  
   - Use the `moduleInfo` node (`M_head`) to expose the head control, joint references, and IK/FK switch to other rigs (e.g., facial, eye, or torso modules).  
   - The `ikfk` attribute on the options control can be driven by external controllers for global IK/FK blending.  

Follow these steps to integrate the head rig into a larger character rig, ensuring that helper placement and joint ordering are correct before running the final build.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="headJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_head_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="neckJoint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_neck_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="neckOrient" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="headOrient" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_neckFK" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "M_neck_fk_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds \nls = cmds.ls(sl=True)\nvalue = ls[0] if ls else \"\"", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_headFK" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_fk_control_helper"}]]></attr>
<attr name="h_headIK" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_ik_control_helper"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_options_control_helper"}]]></attr>
</attributes>
</module>
<module name="eyes" muted="1" uid="5224e40320b643a787c6a601ecabdd31">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

L_eye_joint = pm.PyNode(@L_eye_joint)
R_eye_joint = pm.PyNode(@R_eye_joint)

internalParent = pm.PyNode("internal")
controlsParent = pm.PyNode("controls")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0: # helpers  
    h_eye = rig_utils.curve.makeCurve("M_eyes_control_helper", "rect")
    pm.pointConstraint(L_eye_joint, R_eye_joint, h_eye, sk=["z"])
    h_eye.r.set([90, 0, 90])
    h_eye.s.set([3, 1, 5])
    h_eye.t.set(h_eye.t.get() + [0, 0, 30])    
    helpersParent | h_eye
    rig_utils.lockTRS(h_eye, [1,1,0], [1,1,1], [], 1)
    @set_h_eye(h_eye.name())
    
    for side, jnt, setter in [("L", L_eye_joint, @set_h_left), 
                              ("R", R_eye_joint, @set_h_right)]:
        h = rig_utils.curve.makeCurve(side+"_eye_control_helper", "circle")
        helpersParent | h
        pm.pointConstraint(jnt, h, sk=["z"])
        h_eye.tz >> h.tz
        h.r.set([90, 0, 90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        setter(h.name())
        rig_utils.connectFromSymmetric(h)     

elif @mode == 1: # run
    parent = pm.PyNode(@parent)
    options_ctrl = pm.PyNode(@options)
    
    h_eye = pm.PyNode(@h_eye)
    h_left = pm.PyNode(@h_left)
    h_right = pm.PyNode(@h_right)
    
    internal_grp = pm.createNode("transform", n="M_eyes_internal_group", p=internalParent)
    internal_grp.v.set(False)
    pm.orientConstraint(parent, internal_grp, mo=True)
    
    controls_grp = pm.createNode("transform", n="M_eyes_controls_group", p=controlsParent)
    rig_utils.lockTRS(controls_grp, v=0.5)
    
    options_ctrl.addAttr("eyes_ikfk", at="float", min=0, max=1, dv=0, k=True)
    
    ikfk_rev = pm.createNode("reverse", n="M_eyes_ikfk_reverse")
    options_ctrl.eyes_ikfk >> ikfk_rev.inputX
    
    # eye_ik
    eyeIK_ctrl = pm.createNode("transform", n="M_eyes_ik_control", p=controls_grp)
    eyeIK_ctrl.addAttr("distanceFocus", at="float", dv=@distanceFocusCoeff, k=True)
    
    pm.matchTransform(eyeIK_ctrl, h_eye, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(eyeIK_ctrl)

    pm.orientConstraint(parent, eyeIK_ctrl, mo=True)
    
    rig_utils.curve.makeFromCurve(eyeIK_ctrl, h_eye)
    
    ikfk_rev.outputX >> eyeIK_ctrl.v
    rig_utils.lockTRS(eyeIK_ctrl,[],[1,1,1],[1,1,1],1)
    
    dynamicParent.makeDynamicParent(eyeIK_ctrl, eyeIK_ctrl)
    
    # eye_fk
    eyeFK_transform = pm.createNode("transform", n="M_eyes_fk_control_transform", p=controls_grp)
    eyeFK_ctrl = pm.createNode("transform", n="M_eyes_fk_control", p=eyeFK_transform)
    eyeFK_ctrl.ro.set(3) # xzy
    
    pm.pointConstraint(L_eye_joint, R_eye_joint, eyeFK_transform)
    pm.orientConstraint(parent, eyeFK_transform, mo=True)    
    
    switcher.addFollow(eyeFK_ctrl, controls_grp, parent, attr="followHead", default=1.0, type="orient")    
    
    rig_utils.curve.makeFromCurve(eyeFK_ctrl, h_eye)
    rig_utils.lockTRS(eyeFK_ctrl, [1,1,1], [0,0,1], [1,1,1], 1)
    
    options_ctrl.eyes_ikfk >> eyeFK_transform.v

    eyes_ikfk_transform = pm.createNode("transform", n="M_eyes_ikfk_transform", p=controls_grp)
    pm.matchTransform(eyes_ikfk_transform, eyeFK_ctrl, position=True, rotation=False)
    pc = pm.parentConstraint(eyeFK_ctrl, eyeIK_ctrl, eyes_ikfk_transform, mo=True)
    options_ctrl.eyes_ikfk >> pc.w0
    ikfk_rev.outputX >> pc.w1
    
    # aim joint
    j1 = pm.createNode("joint", n="M_eyes_aim_joint", p=internal_grp)
    j2 = pm.createNode("joint", n="M_eyes_aim_end_joint", p=j1)
    pm.pointConstraint(L_eye_joint, R_eye_joint, j1)
    pm.matchTransform(j2, eyeIK_ctrl, position=True, rotation=False)
    pm.joint(j1, e=True, zso=True, oj="xyz", sao="yup", ch=True)
    j1.rx.lock()    
    
    ikHandle = pm.ikHandle(sj=j1, ee=j2, sol="ikSCsolver")[0]
    ikHandle.rename("M_eyes_aim_ikHandle")
    internal_grp | ikHandle
    pm.parentConstraint(eyes_ikfk_transform, ikHandle, mo=True)  
    
    coeff_mult = pm.createNode("multDL",n="M_eyes_compensationCoeff_multDL")
    j1.ry >> coeff_mult.input1
    coeff_mult.input2.set(-@compensationCoeff)    

    comp_clamp = pm.createNode("clamp", n="M_eyes_compensation_clamp")
    comp_clamp.minR.set(0)
    comp_clamp.maxR.set(50)    
    comp_clamp.minG.set(-50)
    comp_clamp.maxG.set(0)    
    coeff_mult.output >> comp_clamp.inputR
    coeff_mult.output >> comp_clamp.inputG

    # distanceFocus compensation calculation
    dist_plug = rig_utils.createDistance("M_eyes_distanceFocus", eyeIK_ctrl, j1)

    initial_dist = (j1.getTranslation(space="world") - eyeIK_ctrl.getTranslation(space="world")).length()

    dist_div = pm.createNode("multiplyDivide", n="M_eyes_distanceFocus_ratio_multiplyDivide")
    dist_div.operation.set(2) # divide
    dist_plug >> dist_div.input1X
    dist_div.input2X.set(initial_dist if initial_dist > 0.0001 else 1.0)

    distanceFocus_rev = pm.createNode("reverse", n="M_eyes_distanceFocus_reverse")
    dist_div.outputX >> distanceFocus_rev.inputX

    distanceFocus_mult = pm.createNode("multDL", n="M_eyes_distanceFocus_multDL")
    distanceFocus_rev.outputX >> distanceFocus_mult.input1
    eyeIK_ctrl.distanceFocus >> distanceFocus_mult.input2

    distanceFocus_ik_mult = pm.createNode("multDL", n="M_eyes_distanceFocus_ik_multDL")
    distanceFocus_mult.output >> distanceFocus_ik_mult.input1
    ikfk_rev.outputX >> distanceFocus_ik_mult.input2
        
    # left/right eye controls
    for side, helper, eye_joint in [("L", h_left, L_eye_joint), ("R", h_right, R_eye_joint)]:
        ctrl = pm.createNode("transform", n=side+"_eye_offset_control", p=eyes_ikfk_transform)
        
        pm.matchTransform(ctrl, helper, position=True, rotation=False)
        rig_utils.setToOffsetParentMatrix(ctrl)
        rig_utils.curve.makeFromCurve(ctrl, helper)
        rig_utils.lockTRS(ctrl, [0,0,1], [1,1,1], [1,1,1], 1)
    
        # eye compensation on rotation
        comp_joint = pm.createNode("joint", n=side+"_eye_compensation_joint", p=j1)
        pm.matchTransform(comp_joint, eye_joint, position=True, rotation=False)
        pm.pointConstraint(eye_joint, comp_joint)    
        rig_utils.freezeJoints([comp_joint])
        
        pm.parentConstraint(comp_joint, eye_joint, st=["x", "y", "z"], dr=True, mo=True)
        
        ry = comp_clamp.outputR if side == "L" else comp_clamp.outputG
        
        offset_mult = pm.createNode("multiplyDivide", n=side+"_eye_offset_multiplyDivide")
        ctrl.t >> offset_mult.input1
        offset_mult.input2.set([@translateCoeff, @translateCoeff, @translateCoeff])
        
        offset_mult.outputY >> comp_joint.rz
        
        ry_add = pm.createNode("addDL", n=side+"_eye_addOffset_addDL")
        ry >> ry_add.input1
        offset_mult.outputX >> ry_add.input2

        if side == "L":
            side_distanceFocus_mult = pm.createNode("multDL", n="L_eye_distanceFocus_multDL")
            distanceFocus_ik_mult.output >> side_distanceFocus_mult.input1
            side_distanceFocus_mult.input2.set(-1.0)
            distanceFocus_val = side_distanceFocus_mult.output
        else:
            distanceFocus_val = distanceFocus_ik_mult.output

        ry_distanceFocus_add = pm.createNode("addDL", n=side+"_eye_addDistanceFocus_addDL")
        ry_add.output >> ry_distanceFocus_add.input1
        distanceFocus_val >> ry_distanceFocus_add.input2
        ry_distanceFocus_add.output >> comp_joint.ry
]]></run>
<doc><![CDATA[## Summary
The **eyes** module builds a fully‑functional eye rig that includes a master aim control, individual left/right eye offset controls, and a dynamic IK/FK blend. It supports a helper‑generation mode for placing guide objects and a run mode that creates the control hierarchy, internal joints, constraints, and compensation logic for eye movement and distance focus.

## Inputs
- **`mode`** – Radio button (`Helpers` or `Run`).  
  *Helpers* creates placement guides; *Run* builds the rig.  
- **`L_eye_joint` / `R_eye_joint`** – Names of the left and right eye joints that the rig will drive.  
- **`parent`** – The head joint or control that the eye rig will be parented to.  
- **`options`** – Node that receives an `eye_ikfk` float attribute for IK/FK blending.  
- **`compensationCoeff`** – Float (0–1) controlling how much the eye joints compensate for head rotation.  
- **`translateCoeff`** – Float (0–10) scaling the eye offset translation.  
- **`distanceFocusCoeff`** – Float (-100–100) scaling the distance‑focus compensation.  
- **`h_eye` / `h_left` / `h_right`** – Helper transform names created in *Helpers* mode; used as shape references when running the rig.

## Outputs
- **Control hierarchy** under `controlsParent`:
  - `M_eyes_internal_group` (internal group, hidden)  
  - `M_eyes_controls_group` (visible controls)  
  - `M_eyes_ik_control_null` → `M_eyes_ik_control` (IK master)  
  - `M_eyes_fk_control_null` → `M_eyes_fk_control` (FK master)  
  - `M_eyes_ikfk_transform` (blend node)  
  - `L_eye_offset_control_null` → `L_eye_offset_control` (left eye offset)  
  - `R_eye_offset_control_null` → `R_eye_offset_control` (right eye offset)  
- **Internal joint chain**: `M_eyes_1_joint` → `M_eyes_2_joint` (aim joint chain) and the IK handle `M_eyes_ikHandle`.  
- **Compensation nodes**: `M_eyes_compensationCoeff_multDL`, `M_eyes_compensation_clamp`, and per‑eye compensation joints.  
- **Distance‑focus nodes**: `M_eyes_distanceFocus`, `M_eyes_distanceFocus_ratio_multiplyDivide`, `M_eyes_distanceFocus_reverse`, `M_eyes_distanceFocus_multDL`, `M_eyes_distanceFocus_ik_multDL`.  
- **Attribute on `options` node**: `eye_ikfk` (float 0–1) used to drive the IK/FK blend.  
- **Helper nodes** under `helpersParent` when in *Helpers* mode: `M_eyes_control_helper`, `L_eye_control_helper`, `R_eye_control_helper`.

## Usage
1. **Set the target joints**: Assign the left and right eye joints to `L_eye_joint` and `R_eye_joint`.  
2. **Choose mode**:  
   - **Helpers** – Run the module to create the helper transforms (`M_eyes_control_helper`, etc.). Position them in the viewport to match the character’s eye geometry.  
   - **Run** – Switch to *Run* mode, provide the `parent` (head joint/control) and `options` node, then execute.  
3. **Configure parameters** (optional): Adjust `compensationCoeff`, `translateCoeff`, and `distanceFocusCoeff` to fine‑tune eye rotation compensation, offset translation, and distance‑focus behavior.  
4. **Connect to downstream rigs**: Use the generated control nodes (`M_eyes_ik_control`, `M_eyes_fk_control`, `L_eye_offset_control`, `R_eye_offset_control`) or the internal joints for further animation or facial rig integration.  
5. **Blend IK/FK**: Drive the `eye_ikfk` attribute on the `options` node (or expose it in a UI) to switch between IK and FK eye control.  

This module provides a robust, parameter‑driven eye rig that can be integrated into larger character rigs or used as a standalone eye system.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="L_eye_joint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_eye_joint"}]]></attr>
<attr name="R_eye_joint" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_eye_joint"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_head_joint", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="options" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_head_options_control"}]]></attr>
<attr name="compensationCoeff" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "1", "validator": 2, "value": 0.33, "min": "0", "buttonEnabled": false}]]></attr>
<attr name="translateCoeff" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "10", "validator": 2, "value": 5.0, "min": "0", "buttonEnabled": false}]]></attr>
<attr name="distanceFocusCoeff" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 5, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": -100, "max": 100, "validator": 2, "default": "value"}]]></attr>
<attr name="h_eye" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_eye_control_helper"}]]></attr>
<attr name="h_left" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_eye_control_helper"}]]></attr>
<attr name="h_right" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_eye_control_helper"}]]></attr>
</attributes>
</module>
<module name="L_shoulder" muted="0" uid="d25b5dd9832e485d89561e7a13924fb8">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent

controlsParent = pm.PyNode("controls")
helpersParent = pm.PyNode("helpers")

rotateOrder = @rotateOrder_data["items"].index(@rotateOrder)

if @mode == 0: # helpers
    hlp = rig_utils.curve.makeCurve(@name + "_control_helper", @curveType)
    helpersParent | hlp
    pm.parentConstraint(@helperAtTransform, hlp)
    rig_utils.lockTRS(hlp, [1,1,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(hlp)  
    @set_helper(hlp.name())
    
elif @mode == 1: # run
    helper = pm.PyNode(@helper)
    
    transform = pm.createNode("transform", n=@name + "_control_transform", p=controlsParent)
    ctrl = pm.createNode("transform", n=@name + "_control", p=transform)
    ctrl.ro.set(rotateOrder)

    rig_utils.lockTRS(ctrl, [1,1,1] if @translateLock else [], [1,1,1] if @rotateLock else [], [1,1,1], 1)
        
    pm.matchTransform(transform, helper)
    rig_utils.curve.makeFromCurve(ctrl, helper)
    
    if @parent:
        pm.parentConstraint(@parent, transform, mo=True)
        
    dynamicParent.makeDynamicParent(ctrl, ctrl)
    
    for n in @driven:
        if @constraint == 0: # pointConstraint
            pm.pointConstraint(ctrl, n)
    
        elif @constraint == 1: # orientConstraint
            pm.orientConstraint(ctrl, n, mo=True)
    
        elif @constraint == 2: # parentConstraint
            pm.parentConstraint(ctrl, n, mo=True)
            
    @set_out_control(ctrl.name())            
]]></run>
<doc><![CDATA[## Summary  
Creates a shoulder animation control curve with optional helper placement. In **Helpers** mode it generates a guide curve at a specified transform, while in **Run** mode it builds a control hierarchy (transform + control), applies channel locks, matches the helper, and drives selected objects with the chosen constraint type. The module outputs the final control name for downstream connections.

## Inputs  
- **`mode`** – Radio button (`Helpers` or `Run`) determining whether to create a helper or the final control.  
- **`name`** – Base name for the control and helper objects.  
- **`curveType`** – Shape of the helper/control curve (sphere, footstep, cube, circle, axis, arc).  
- **`helperAtTransform`** – Transform node used to position the helper curve in **Helpers** mode.  
- **`helper`** – Name of the helper curve created in **Helpers** mode, used as the reference transform in **Run** mode.  
- **`parent`** – Optional parent transform for the control transform; if set, a parent constraint is applied.  
- **`driven`** – List of transforms that will be driven by the control using the selected constraint type.  
- **`constraint`** – Constraint type applied to each driven object (`Point`, `Orient`, or `Parent`).  
- **`rotateOrder`** – Desired rotate order for the control transform.  
- **`translateLock`** – Boolean to lock translation channels on the control.  
- **`rotateLock`** – Boolean to lock rotation channels on the control.  

## Outputs  
- **`out_control`** – The name of the created control transform (e.g., `L_shoulder_control`).  
- The module also creates a helper curve (when in **Helpers** mode) and a control hierarchy under the `controls` and `helpers` parent transforms, which can be referenced by downstream modules.

## Usage  
1. **Helpers Mode** – Set `mode` to **Helpers**.  
   - Specify `name`, `curveType`, and `helperAtTransform`.  
   - Execute the module to generate a guide curve under the `helpers` parent.  
   - Adjust the helper’s position and orientation in the viewport as needed.  

2. **Run Mode** – Switch `mode` to **Run**.  
   - Provide the `helper` name created in the previous step.  
   - Set `parent` if the control should follow another transform.  
   - Define `driven` objects and choose the desired `constraint` type.  
   - Configure `rotateOrder`, `translateLock`, and `rotateLock` as required.  
   - Execute the module to create the control hierarchy under `controls`.  

3. **Connect Outputs** – Use the `out_control` value to link this control to other rig modules (e.g., arm, hand, or IK systems).  
4. **Optional** – The helper curve can be reused or deleted after the control is built.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "L_shoulder", "buttonEnabled": false}]]></attr>
<attr name="driven" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["L_shoulder_joint"]}]]></attr>
<attr name="constraint" template="radioButton" category="General" connect=""><![CDATA[{"current": 2, "items": ["Point", "Orient", "Parent"], "default": "current"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_spine_5_joint"}]]></attr>
<attr name="rotateOrder" template="comboBox" category="General" connect=""><![CDATA[{"current": "yxz", "items": ["xyz", "yzx", "zxy", "xzy", "yxz", "zyx"], "default": "current"}]]></attr>
<attr name="translateLock" template="checkBox" category="Locks" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="rotateLock" template="checkBox" category="Locks" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="curveType" template="comboBox" category="Helper" connect=""><![CDATA[{"current": "arc", "items": ["sphere", "footstep", "cube", "circle", "axis"], "default": "current"}]]></attr>
<attr name="helperAtTransform" template="lineEditAndButton" category="Helper" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="helper" template="lineEditAndButton" category="Helper" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_shoulder_control_helper"}]]></attr>
<attr name="out_control" template="lineEditAndButton" category="Out" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_shoulder_control"}]]></attr>
</attributes>
</module>
<module name="R_shoulder" muted="0" uid="d25b5dd9832e485d89561e7a13924fb8">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent

controlsParent = pm.PyNode("controls")
helpersParent = pm.PyNode("helpers")

rotateOrder = @rotateOrder_data["items"].index(@rotateOrder)

if @mode == 0: # helpers
    hlp = rig_utils.curve.makeCurve(@name + "_control_helper", @curveType)
    helpersParent | hlp
    pm.parentConstraint(@helperAtTransform, hlp)
    rig_utils.lockTRS(hlp, [1,1,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(hlp)  
    @set_helper(hlp.name())
    
elif @mode == 1: # run
    helper = pm.PyNode(@helper)
    
    transform = pm.createNode("transform", n=@name + "_control_transform", p=controlsParent)
    ctrl = pm.createNode("transform", n=@name + "_control", p=transform)
    ctrl.ro.set(rotateOrder)

    rig_utils.lockTRS(ctrl, [1,1,1] if @translateLock else [], [1,1,1] if @rotateLock else [], [1,1,1], 1)
        
    pm.matchTransform(transform, helper)
    rig_utils.curve.makeFromCurve(ctrl, helper)
    
    if @parent:
        pm.parentConstraint(@parent, transform, mo=True)
        
    dynamicParent.makeDynamicParent(ctrl, ctrl)
    
    for n in @driven:
        if @constraint == 0: # pointConstraint
            pm.pointConstraint(ctrl, n)
    
        elif @constraint == 1: # orientConstraint
            pm.orientConstraint(ctrl, n, mo=True)
    
        elif @constraint == 2: # parentConstraint
            pm.parentConstraint(ctrl, n, mo=True)
            
    @set_out_control(ctrl.name())            
]]></run>
<doc><![CDATA[## Summary  
Creates a shoulder animation control curve with optional helper placement. In **Helpers** mode it generates a guide curve at a specified transform, while in **Run** mode it builds a control hierarchy (transform + control), applies channel locks, matches the helper, and drives selected objects with the chosen constraint type. The module outputs the final control name for downstream connections.

## Inputs  
- **`mode`** – Radio button (`Helpers` or `Run`) determining whether to create a helper or the final control.  
- **`name`** – Base name for the control and helper objects.  
- **`curveType`** – Shape of the helper/control curve (sphere, footstep, cube, circle, axis, arc).  
- **`helperAtTransform`** – Transform node used to position the helper curve in **Helpers** mode.  
- **`helper`** – Name of the helper curve created in **Helpers** mode, used as the reference transform in **Run** mode.  
- **`parent`** – Optional parent transform for the control transform; if set, a parent constraint is applied.  
- **`driven`** – List of transforms that will be driven by the control using the selected constraint type.  
- **`constraint`** – Constraint type applied to each driven object (`Point`, `Orient`, or `Parent`).  
- **`rotateOrder`** – Desired rotate order for the control transform.  
- **`translateLock`** – Boolean to lock translation channels on the control.  
- **`rotateLock`** – Boolean to lock rotation channels on the control.  

## Outputs  
- **`out_control`** – The name of the created control transform (e.g., `L_shoulder_control`).  
- The module also creates a helper curve (when in **Helpers** mode) and a control hierarchy under the `controls` and `helpers` parent transforms, which can be referenced by downstream modules.

## Usage  
1. **Helpers Mode** – Set `mode` to **Helpers**.  
   - Specify `name`, `curveType`, and `helperAtTransform`.  
   - Execute the module to generate a guide curve under the `helpers` parent.  
   - Adjust the helper’s position and orientation in the viewport as needed.  

2. **Run Mode** – Switch `mode` to **Run**.  
   - Provide the `helper` name created in the previous step.  
   - Set `parent` if the control should follow another transform.  
   - Define `driven` objects and choose the desired `constraint` type.  
   - Configure `rotateOrder`, `translateLock`, and `rotateLock` as required.  
   - Execute the module to create the control hierarchy under `controls`.  

3. **Connect Outputs** – Use the `out_control` value to link this control to other rig modules (e.g., arm, hand, or IK systems).  
4. **Optional** – The helper curve can be reused or deleted after the control is built.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "R_shoulder", "buttonEnabled": false}]]></attr>
<attr name="driven" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["R_shoulder_joint"]}]]></attr>
<attr name="constraint" template="radioButton" category="General" connect=""><![CDATA[{"current": 2, "items": ["Point", "Orient", "Parent"], "default": "current"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "M_spine_5_joint"}]]></attr>
<attr name="rotateOrder" template="comboBox" category="General" connect=""><![CDATA[{"current": "yxz", "items": ["xyz", "yzx", "zxy", "xzy", "yxz", "zyx"], "default": "current"}]]></attr>
<attr name="translateLock" template="checkBox" category="Locks" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="rotateLock" template="checkBox" category="Locks" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="curveType" template="comboBox" category="Helper" connect=""><![CDATA[{"current": "arc", "items": ["sphere", "footstep", "cube", "circle", "axis"], "default": "current"}]]></attr>
<attr name="helperAtTransform" template="lineEditAndButton" category="Helper" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_1_joint"}]]></attr>
<attr name="helper" template="lineEditAndButton" category="Helper" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_shoulder_control_helper"}]]></attr>
<attr name="out_control" template="lineEditAndButton" category="Out" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_shoulder_control"}]]></attr>
</attributes>
</module>
<module name="L_arm" muted="0" uid="d2e886c7fa894a018b74d0f9b00c62e5">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    scale = rig_utils.getDistance(joint1, joint3) / 10
    
    p1 = rig_utils.matrix.taxis(joint1.wm.get())
    p2 = rig_utils.matrix.taxis(joint2.wm.get())
    p3 = rig_utils.matrix.taxis(joint3.wm.get())
        
    planeTransform = pm.createNode("transform", n=@name + "_ik_plane_helper_transform", p=helpersParent)
    pm.pointConstraint(joint2, planeTransform)
    oc = pm.orientConstraint(joint1, joint2, planeTransform)
    oc.interpType.set(2) # shortest

    #polevector
    h_polevector = rig_utils.curve.makeCurve(@name + "_ik_polevector_control_helper", "sphere")    
    h_polevector.s.set([scale/2, scale/2, scale/2])
    planeTransform | h_polevector
    
    avg = (p1 - p2).normal() + (p3 - p2).normal()
    pm.xform(h_polevector, ws=True, t=p2 - avg.normal() * scale*3)
    rig_utils.lockTRS(h_polevector, [1,0,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_polevector, ty=-1)
    @set_h_polevector(h_polevector.name())

    # IK Control
    h_ik = rig_utils.curve.makeCurve(@name + "_ik_control_helper", @ikHelperType)    
    
    isLeg = any(map(lambda x:x in ["leg", "frontLeg", "backLeg", "leg_front", "leg_back"], @name.split("_")))    
    if isLeg:     
        h_ik_transform = pm.createNode("transform", n=@name + "_ik_control_helper_transform", p=helpersParent)
        pm.pointConstraint(joint3, h_ik_transform, sk=["y"])
        pm.orientConstraint(joint3, h_ik_transform, sk=["x", "z"], mo=True)
        h_ik_transform | h_ik
        pm.xform(h_ik, ws=True, t=[p3[0], 0, p3[2]]) # place on ground
        h_ik.s.set([scale, scale/5, scale*2])
        rig_utils.lockTRS(h_ik, [0,1,0], [1,0,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik, tx=-1, ry=-1)
    else:
        helpersParent | h_ik
        pm.parentConstraint(@placeIkAt or joint3, h_ik)
        h_ik.s.set([scale, scale, scale])
        rig_utils.lockTRS(h_ik, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik)
    @set_h_ik(h_ik.name())
    
    #options
    h_options = rig_utils.curve.makeCurve(@name + "_options_control_helper", "flag")
    h_options.s.set([scale, scale, scale])
    planeTransform | h_options
    h_options.t.set([0,0,0])
    pm.orientConstraint(helpersParent, h_options, mo=True)
    rig_utils.lockTRS(h_options, [0,1,0], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_options(h_options.name()) 
    
    # position
    h_position = rig_utils.curve.makeCurve(@name + "_position_control_helper", "axis")
    helpersParent | h_position
    h_position.s.set([scale/2.0, scale/2.0, scale/2.0])
    pm.pointConstraint(joint1, h_position)
    rig_utils.lockTRS(h_position, [1,1,1], [], [])
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_position(h_position.name())     

    # FK
    h_fk1 = rig_utils.curve.makeCurve(@name + "_fk_1_control_helper", "circle")
    h_fk2 = rig_utils.curve.makeCurve(@name + "_fk_2_control_helper", "circle")
    h_fk3 = rig_utils.curve.makeCurve(@name + "_fk_3_control_helper", "circle")

    for j, h in [(joint1, h_fk1), (joint2, h_fk2), (joint3, h_fk3)]:
        helpersParent | h
        h.s.set([scale, scale, scale])
        
        pc = pm.parentConstraint(j, h)
        pc.target[0].targetOffsetRotate.set([0,0,90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h)

    @set_h_fk1(h_fk1.name())
    @set_h_fk2(h_fk2.name())
    @set_h_fk3(h_fk3.name())

if @mode == 1:  # run
    jointsParent = joint1.getParent()

    h_fk1 = pm.PyNode(@h_fk1)
    h_fk2 = pm.PyNode(@h_fk2)
    h_fk3 = pm.PyNode(@h_fk3)
    h_ik = pm.PyNode(@h_ik)
    h_polevector = pm.PyNode(@h_polevector)
    h_options = pm.PyNode(@h_options)
    h_position = pm.PyNode(@h_position) if pm.objExists(@h_position) else None

    # controls and joints groups
    controls_grp = pm.createNode("transform", n=@name + "_controls_group", p=controlsParent)

    internal_grp = pm.createNode("transform", n=@name + "_internal_group", p=internalParent)
    internal_grp.v.set(False)
    
    rig_utils.lockTRS(controls_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internal_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)

    others_grp = pm.createNode("transform", n=@name + "_others_group", p=othersParent)

    # options control
    options_ctrl = pm.createNode("transform", n=@name + "_options_control", p=controls_grp)
    pm.parentConstraint(joint1, options_ctrl)

    rig_utils.curve.makeFromCurve(options_ctrl, h_options)

    options_ctrl.addAttr("ikfk", at="float", min=0, max=1, k=True)
    options_ctrl.addAttr("scaleFactor1x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor2x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor3x", at="float", min=0.1, dv=1, k=True)
    
    for i, j in enumerate([joint1, joint2, joint3]):
        a = f"scaleFactor{i+1}"
        options_ctrl.addAttr(a, min=0.01, dv=1.0, k=True)
        if i == 2:
            md = pm.createNode("multiplyDivide", n=j+"_scaleFactor_multiplyDivide")
            options_ctrl.attr(a) >> md.input1X
            options_ctrl.attr(a) >> md.input1Y
            options_ctrl.attr(a) >> md.input1Z
            options_ctrl.scaleFactor3x >> md.input2X
            md.output >> j.s
        else:
            options_ctrl.attr(a) >> j.sx
            options_ctrl.attr(a) >> j.sy
            options_ctrl.attr(a) >> j.sz

    rig_utils.lockTRS(options_ctrl, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)
    
    # ikfk switch
    ikfk_rev = pm.createNode("reverse", n=@name + "_ikfk_reverse")
    options_ctrl.ikfk >> ikfk_rev.inputX

    # bones start position control
    positionCtrl = None
    if h_position:
        options_ctrl.addAttr("positionControl", at="bool", dv=False)
        rig_utils.lockAttr(options_ctrl.positionControl, 0.5)    
        
        positionTransform = pm.createNode("transform", n=@name + "_1_position_control_transform", p=controls_grp)
        pm.matchTransform(positionTransform, jointsParent)
        pm.matchTransform(positionTransform, joint1, position=True, rotation=False)
        options_ctrl.positionControl >> positionTransform.v
        
        if jointsParent:
            pm.parentConstraint(jointsParent, positionTransform, mo=True)
        
        positionCtrl = pm.createNode("transform", n=@name + "_1_position_control", p=positionTransform)
        pm.matchTransform(positionCtrl, joint1, position=True, rotation=False)        
        
        rig_utils.curve.makeFromCurve(positionCtrl, h_position)
        rig_utils.lockTRS(positionCtrl, [])
        
    # IK chain
    ik1 = rig_utils.matchJoint(joint1, @name + "_ik_1_joint")
    ik2 = rig_utils.matchJoint(joint2, @name + "_ik_2_joint")
    ik3 = rig_utils.matchJoint(joint3, @name + "_ik_3_joint")
    internal_grp | ik1 | ik2 | ik3
    
    pm.parentConstraint(positionCtrl or jointsParent, ik1, mo=True, skipRotate=["x", "y", "z"]) # pointConstraint

    # FIX
    fix1 = rig_utils.matchJoint(joint1, @name + "_fix_1_joint")
    fix2 = rig_utils.matchJoint(joint2, @name + "_fix_2_joint")
    fix3 = rig_utils.matchJoint(joint3, @name + "_fix_3_joint")

    internal_grp | fix1 | fix2 | fix3

    pm.pointConstraint(ik1, fix1)

    # FK
    fk1 = rig_utils.matchJoint(joint1, @name + "_fk_1_joint")
    fk2 = rig_utils.matchJoint(joint2, @name + "_fk_2_joint")
    fk3 = rig_utils.matchJoint(joint3, @name + "_fk_3_joint")
    internal_grp | fk1 | fk2 | fk3

    # FK controls
    # fk1
    fk1_ctrl = pm.createNode("transform", n=@name + "_fk_1_control", p=controls_grp)  
    pm.matchTransform(fk1_ctrl, joint1)
    rig_utils.curve.makeFromCurve(fk1_ctrl, h_fk1)
    pm.parentConstraint(positionCtrl or jointsParent, fk1_ctrl, sr=["x","y","z"], mo=True)

    switcher.addFollow(fk1_ctrl, controls_grp, jointsParent, attr="followBody", default=0.0, type="orient")
    
    rig_utils.setToOffsetParentMatrix(fk1_ctrl)
    options_ctrl.ikfk >> fk1_ctrl.v
    rig_utils.lockTRS(fk1_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.parentConstraint(fk1_ctrl, fk1)
    
    # fk2
    fk2_ctrl = pm.createNode("transform", n=@name + "_fk_2_control", p=fk1_ctrl)
    pm.matchTransform(fk2_ctrl, joint2)
    pm.pointConstraint(fk2, fk2_ctrl)
    rig_utils.setToOffsetParentMatrix(fk2_ctrl)

    rig_utils.curve.makeFromCurve(fk2_ctrl, h_fk2)    
    rig_utils.lockTRS(fk2_ctrl, [1, 1, 1], [1, 1, 0], [1, 1, 1], 1)
    
    pm.orientConstraint(fk2_ctrl, fk2)
    
    # fk3
    fk3_ctrl = pm.createNode("transform", n=@name + "_fk_3_control", p=fk2_ctrl)
    pm.matchTransform(fk3_ctrl, joint3)
    pm.pointConstraint(fk3, fk3_ctrl)
    rig_utils.setToOffsetParentMatrix(fk3_ctrl)

    rig_utils.curve.makeFromCurve(fk3_ctrl, h_fk3)
    rig_utils.lockTRS(fk3_ctrl, [1, 1, 1], [], [1, 1, 1], 1)

    pm.orientConstraint(fk3_ctrl, fk3)
    
    # FIX IK handles
    fix_ikHandle1 = pm.ikHandle(startJoint=fix1,
                                endEffector=fix2,
                                solver="ikSCsolver",
                                n=@name + "_fix_1_ikHandle")[0]
    internal_grp | fix_ikHandle1

    fix_ikHandle2 = pm.ikHandle(startJoint=fix2,
                                endEffector=fix3,
                                solver="ikSCsolver",
                                n=@name + "_fix_2_ikHandle")[0]
    internal_grp | fix_ikHandle2    
    
    # IK handle
    ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik3, solver="ikRPsolver", n=@name + "_ikHandle")[0]
    internal_grp | ikHandle

    # IK control
    ik_ctrl = pm.createNode("joint", n=@name + "_ik_control", p=controls_grp)

    ik_ctrl.radius.set(0)
    rig_utils.lockAttr(ik_ctrl.radius, 1)
    
    pm.matchTransform(ik_ctrl, @placeIkAt or ik3, position=True, rotation=False)

    rig_utils.setToOffsetParentMatrix(ik_ctrl)
    
    if pm.objExists(@lastCtrlOrient):
        pm.matchTransform(ik_ctrl, @lastCtrlOrient, position=False, rotation=True)    
        rig_utils.freezeJoints([ik_ctrl])

    rig_utils.curve.makeFromCurve(ik_ctrl, h_ik)
    ikfk_rev.outputX >> ik_ctrl.v

    dynamicParent.makeDynamicParent(ik_ctrl, ik_ctrl)

    rig_utils.lockTRS(ik_ctrl, [], [], [1, 1, 1], 1)

    # IK polevector control
    polevec_follow_j1 = rig_utils.matchJoint(joint1, @name + "_ik_polevector_follow_1_joint")
    polevec_follow_j2 = rig_utils.matchJoint(joint3, @name + "_ik_polevector_follow_2_joint")
    internal_grp | polevec_follow_j1 | polevec_follow_j2    
    
    polevec_follow_ikHandle = pm.ikHandle(sj=polevec_follow_j1, ee=polevec_follow_j2, solver="ikSCsolver")[0]
    polevec_follow_ikHandle.rename(@name+"_ik_polevector_follow_ikHandle")
    internal_grp | polevec_follow_ikHandle
    
    pm.parentConstraint(ik_ctrl, polevec_follow_ikHandle, mo=True)
    pm.pointConstraint(ik1, polevec_follow_j1)
    
    polevec_ctrl = pm.createNode("transform", n=@name + "_ik_polevector_control", p=controls_grp)
    pm.matchTransform(polevec_ctrl, h_polevector, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(polevec_ctrl)    

    switcher.addFollow(polevec_ctrl, internal_grp, polevec_follow_j1, attr="follow", default=0.0, type="parent")
    
    polevec_ctrl.addAttr("snap", min=0, max=1, k=True)
    polevec_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    polevec_ctrl.stretch.set(0)

    rig_utils.curve.makeFromCurve(polevec_ctrl, h_polevector)
    
    ikfk_rev.outputX >> polevec_ctrl.v
    
    rig_utils.lockTRS(polevec_ctrl, [], [1, 1, 1], [1, 1, 1], 1)

    pm.pointConstraint(polevec_ctrl, fix_ikHandle1)  # snap fix1-fix2
    
    if @constrainIK:
        pm.pointConstraint(ik_ctrl, fix_ikHandle2)  # snap fix2-fix3    

    dynamicParent.makeDynamicParent(polevec_ctrl, polevec_ctrl)

    rig_utils.makeHelpLine(
        @name + "_polevector", 
        [polevec_ctrl, joint2],
        visibleAttr=ikfk_rev.outputX,
        parent=others_grp)

    ik_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    ik_ctrl.stretch.set(0)

    dFix1 = rig_utils.createDistance(@name + "_fix_1_distance", fix1, polevec_ctrl)
    dFix2 = rig_utils.createDistance(@name + "_fix_2_distance", fix2, ik_ctrl)
    d = rig_utils.createDistance(@name + "_ik_distance", ik1, ik_ctrl)

    ik2_tx_scaleMult = pm.createNode("multDL", n=ik2 + "_tx_scaleFactor1x_multDL")
    ik2_tx_scaleMult.input1.set(abs(ik2.tx.get()))
    options_ctrl.scaleFactor1x >> ik2_tx_scaleMult.input2

    ik3_tx_scaleMult = pm.createNode("multDL", n=ik3 + "_tx_scaleFactor2x_multDL")
    ik3_tx_scaleMult.input1.set(abs(ik3.tx.get()))
    options_ctrl.scaleFactor2x >> ik3_tx_scaleMult.input2

    ik2ik3_tx_sumAdd = pm.createNode("addDL", n=@name + "_ik_sum_tx_addDL")
    ik2_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input1
    ik3_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input2

    sFix1 = rig_utils.makeStretchable(
        @name + "_fix_1", 
        [fix1],
        dFix1, 
        polevec_ctrl.stretch,
        0.01, 0,
        ik2_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    sFix2 = rig_utils.makeStretchable(
        @name + "_fix_2", 
        [fix2],
        dFix2,
        ik_ctrl.stretch,
        0.01,
        0,
        ik3_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    s = rig_utils.makeStretchable(
        @name + "_ik", 
        [ik1, ik2],
        d,
        ik_ctrl.stretch,
        1,
        0,
        ik2ik3_tx_sumAdd.output,
        scales=[True, False, False],  
        useTx=False)

    # softIK
    ik_ctrl.addAttr("softIK", min=0, max=0.5, dv=0.05, k=True)

    ac_x = rig_utils.anim.createSoftIKAnimCurve(@name + "_softIK")

    stretchX = pm.PyNode(@name + "_ik_stretch_x_blendTwoAttr")
    cond = pm.PyNode(@name + "_ik_squash_condition")

    stretchX.output >> ac_x.input

    softIk_switch = pm.createNode("multDL", n=@name + "_softIK_switch_multDL")
    ik_ctrl.softIK >> softIk_switch.input1
    ik_ctrl.stretch >> softIk_switch.input2

    softIk_b2a = pm.createNode("blendTwoAttr", n=@name + "_softIK_blendTwoAttr")
    softIk_switch.output >> softIk_b2a.attributesBlender
    stretchX.output >> softIk_b2a.i[0]
    ac_x.output >> softIk_b2a.i[1]

    softIk_b2a.output >> cond.firstTerm
    softIk_b2a.output >> cond.colorIfTrueR

    # fk stretch with scaleFactor
    fk2_scaleFactor_mult = pm.createNode("multDL", n=fk2 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor1x >> fk2_scaleFactor_mult.input1
    fk2_scaleFactor_mult.input2.set(fk2.tx.get())
    fk2_scaleFactor_mult.output >> fk2.tx
    
    fk3_scaleFactor_mult = pm.createNode("multDL", n=fk3 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor2x >> fk3_scaleFactor_mult.input1
    fk3_scaleFactor_mult.input2.set(fk3.tx.get())
    fk3_scaleFactor_mult.output >> fk3.tx

    # ik stretch
    multIK1 = pm.createNode("multiplyDivide", n=ik1 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK1.input1X
    options_ctrl.scaleFactor1x >> multIK1.input2X

    multIK2 = pm.createNode("multiplyDivide", n=ik2 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK2.input1X
    options_ctrl.scaleFactor2x >> multIK2.input2X

    multFIX1 = pm.createNode("multiplyDivide", n=fix1 + "_scaleFactor_multiplyDivide")
    sFix1[0] >> multFIX1.input1X
    options_ctrl.scaleFactor1x >> multFIX1.input2X
    multFIX1.outputX >> fix1.sx

    multFIX2 = pm.createNode("multiplyDivide", n=fix2 + "_scaleFactor_multiplyDivide")
    sFix2[0] >> multFIX2.input1X
    options_ctrl.scaleFactor2x >> multFIX2.input2X
    multFIX2.outputX >> fix2.sx

    b2a = pm.createNode("blendTwoAttr", n=ik1 + "_stretch_x_blendTwoAttr")
    multIK1.outputX >> b2a.i[0]
    multFIX1.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik1.sx

    b2a = pm.createNode("blendTwoAttr", n=ik2 + "_stretch_x_blendTwoAttr")
    multIK2.outputX >> b2a.i[0]
    multFIX2.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik2.sx

    defPolevec = pm.createNode("transform", n=polevec_ctrl + "_default_transform")
    pm.matchTransform(defPolevec, h_polevector, position=True, rotation=False)
    pm.parent(defPolevec, fk2)

    pm.poleVectorConstraint(polevec_ctrl, ikHandle)

    if @constrainIK:
        pc = pm.pointConstraint(ik_ctrl, fix3, ikHandle)

        snap_rev = pm.createNode("reverse", n=@name + "_ik_snap_reverse")
        polevec_ctrl.snap >> snap_rev.inputX

        snap_rev.outputX >> pc.w0
        polevec_ctrl.snap >> pc.w1

        pm.orientConstraint(ik_ctrl, ik3, mo=True)

    # blend IKFK constraints
    for j, ikj, fkj in [(joint1, ik1, fk1), (joint2, ik2, fk2), (joint3, ik3, fk3)]:
        oc = pm.parentConstraint(ikj, fkj, j)
        oc.interpType.set(2)
        ikfk_rev.outputX >> oc.w0
        options_ctrl.ikfk >> oc.w1
        
    # ModuleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@name + "_limb")
    moduleInfo.setAttr("type", "limb")

    moduleInfo.setAttr("options", options_ctrl.message)
    moduleInfo.setAttr("ikfk", options_ctrl.ikfk)    
    moduleInfo.setAttr("snap", polevec_ctrl.snap)     
    moduleInfo.setAttr("ik1_joint", ik1.message)
    moduleInfo.setAttr("ik2_joint", ik2.message)
    moduleInfo.setAttr("ik3_joint", ik3.message)
    moduleInfo.setAttr("fk1_joint", fk1.message)
    moduleInfo.setAttr("fk2_joint", fk2.message)
    moduleInfo.setAttr("fk3_joint", fk3.message)    
    moduleInfo.setAttr("ik", ik_ctrl.message)
    moduleInfo.setAttr("polevector", polevec_ctrl.message)
    moduleInfo.setAttr("fk1", fk1_ctrl.message)
    moduleInfo.setAttr("fk2", fk2_ctrl.message)
    moduleInfo.setAttr("fk3", fk3_ctrl.message)

    # seamless
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk1", fk1_ctrl, ik1)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk2", fk2_ctrl, ik2)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk3", fk3_ctrl, ik3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "ik", ik_ctrl, fk3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "polevector", polevec_ctrl, defPolevec)
]]></run>
<doc><![CDATA[## Summary  
The **L_arm** module creates a fully functional IK/FK arm rig. It first generates placement helpers (IK plane, pole‑vector, IK and FK controls) in *Helpers* mode, then builds the rig in *Run* mode, adding an IK/FK switch, pole‑vector controller, stretch and soft‑IK logic, and exposes all key objects through a `ModuleInfo` node for downstream use.

## Inputs  
- **mode** – Selects *Helpers* (0) or *Run* (1).  
- **name** – Base name for all generated nodes.  
- **joint1 / joint2 / joint3** – Target joint names forming the arm chain.  
- **lastCtrlOrient** – Optional joint used to orient the final IK control.  
- **ikHelperType** – Shape of the IK control curve (e.g., cube, sphere).  
- **constrainIK** – Boolean to enable optional IK‑to‑fix constraints.  
- **placeIkAt** – Optional transform to position the IK control at start.

## Outputs  
- **h_fk1 / h_fk2 / h_fk3** – FK helper curves.  
- **h_ik** – IK helper curve.  
- **h_polevector** – Pole‑vector helper curve.  
- **h_options** – Options helper curve.  
- **out_ikfkSwitch** – PlusMinusAverage node driving the IK/FK blend.  
- **out_ik1 / out_ik2 / out_ik3** – IK joint chain.  
- **out_fk1 / out_fk2 / out_fk3** – FK joint chain.  
- **out_fix3** – Third fix joint for optional constraints.  
- **out_ikHandle** – Main IK handle.  
- **out_fix2_ikHandle** – Secondary IK handle for fix joints.  
- **out_ikCtrl** – IK control joint.  
- **out_polevecCtrl** – Pole‑vector control.  
- **moduleInfo** – `ModuleInfo` node exposing rig type, joints, controls, and switch attributes.

## Usage  
1. **Set Target Joints** – Assign `joint1`, `joint2`, and `joint3` to the arm’s shoulder, elbow, and wrist joints.  
2. **Generate Helpers** – Set `mode` to **Helpers** and run. The module will create placement helpers under the *Helpers* parent, scaled to the joint spacing. Adjust their positions and orientations in the viewport.  
3. **Configure Optional Settings** –  
   - Choose an `ikHelperType` shape.  
   - Toggle `constrainIK` if you need the IK control to drive the fix joints.  
   - If desired, set `placeIkAt` to a transform that will be used as the IK control’s base position.  
4. **Build the Rig** – Switch `mode` to **Run** and execute. The module will create the full FK/IK chain, IK/FK switch, pole‑vector controller, stretch and soft‑IK systems, and lock/unlock attributes appropriately.  
5. **Connect to Other Modules** – Use the `moduleInfo` node or the individual output attributes (`out_ikCtrl`, `out_polevecCtrl`, `out_fk1`, etc.) to link this arm rig to downstream modules such as hand, fingers, or other limb systems.  
6. **Mirror or Duplicate** – The helper attributes (`h_fk1`, `h_fk2`, `h_fk3`, `h_ik`, `h_polevector`, `h_options`) can be mirrored or reused for building a symmetrical arm.  

The module automatically handles mirroring, dynamic parenting, and provides a clean interface for further customization or integration into larger rigging pipelines.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "L_arm", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_3_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_3_joint"}]]></attr>
<attr name="ikHelperType" template="comboBox" category="Others" connect=""><![CDATA[{"current": "cube", "items": ["arc", "axis", "axisSphere", "cube", "circle", "diamond", "pyramid", "rect", "sphere", "triangle"], "default": "current"}]]></attr>
<attr name="constrainIK" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="placeIkAt" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "L_arm_ik_polevector_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_arm_options_control_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "L_arm_1_position_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="R_arm" muted="0" uid="d2e886c7fa894a018b74d0f9b00c62e5">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    scale = rig_utils.getDistance(joint1, joint3) / 10
    
    p1 = rig_utils.matrix.taxis(joint1.wm.get())
    p2 = rig_utils.matrix.taxis(joint2.wm.get())
    p3 = rig_utils.matrix.taxis(joint3.wm.get())
        
    planeTransform = pm.createNode("transform", n=@name + "_ik_plane_helper_transform", p=helpersParent)
    pm.pointConstraint(joint2, planeTransform)
    oc = pm.orientConstraint(joint1, joint2, planeTransform)
    oc.interpType.set(2) # shortest

    #polevector
    h_polevector = rig_utils.curve.makeCurve(@name + "_ik_polevector_control_helper", "sphere")    
    h_polevector.s.set([scale/2, scale/2, scale/2])
    planeTransform | h_polevector
    
    avg = (p1 - p2).normal() + (p3 - p2).normal()
    pm.xform(h_polevector, ws=True, t=p2 - avg.normal() * scale*3)
    rig_utils.lockTRS(h_polevector, [1,0,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_polevector, ty=-1)
    @set_h_polevector(h_polevector.name())

    # IK Control
    h_ik = rig_utils.curve.makeCurve(@name + "_ik_control_helper", @ikHelperType)    
    
    isLeg = any(map(lambda x:x in ["leg", "frontLeg", "backLeg", "leg_front", "leg_back"], @name.split("_")))    
    if isLeg:     
        h_ik_transform = pm.createNode("transform", n=@name + "_ik_control_helper_transform", p=helpersParent)
        pm.pointConstraint(joint3, h_ik_transform, sk=["y"])
        pm.orientConstraint(joint3, h_ik_transform, sk=["x", "z"], mo=True)
        h_ik_transform | h_ik
        pm.xform(h_ik, ws=True, t=[p3[0], 0, p3[2]]) # place on ground
        h_ik.s.set([scale, scale/5, scale*2])
        rig_utils.lockTRS(h_ik, [0,1,0], [1,0,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik, tx=-1, ry=-1)
    else:
        helpersParent | h_ik
        pm.parentConstraint(@placeIkAt or joint3, h_ik)
        h_ik.s.set([scale, scale, scale])
        rig_utils.lockTRS(h_ik, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik)
    @set_h_ik(h_ik.name())
    
    #options
    h_options = rig_utils.curve.makeCurve(@name + "_options_control_helper", "flag")
    h_options.s.set([scale, scale, scale])
    planeTransform | h_options
    h_options.t.set([0,0,0])
    pm.orientConstraint(helpersParent, h_options, mo=True)
    rig_utils.lockTRS(h_options, [0,1,0], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_options(h_options.name()) 
    
    # position
    h_position = rig_utils.curve.makeCurve(@name + "_position_control_helper", "axis")
    helpersParent | h_position
    h_position.s.set([scale/2.0, scale/2.0, scale/2.0])
    pm.pointConstraint(joint1, h_position)
    rig_utils.lockTRS(h_position, [1,1,1], [], [])
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_position(h_position.name())     

    # FK
    h_fk1 = rig_utils.curve.makeCurve(@name + "_fk_1_control_helper", "circle")
    h_fk2 = rig_utils.curve.makeCurve(@name + "_fk_2_control_helper", "circle")
    h_fk3 = rig_utils.curve.makeCurve(@name + "_fk_3_control_helper", "circle")

    for j, h in [(joint1, h_fk1), (joint2, h_fk2), (joint3, h_fk3)]:
        helpersParent | h
        h.s.set([scale, scale, scale])
        
        pc = pm.parentConstraint(j, h)
        pc.target[0].targetOffsetRotate.set([0,0,90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h)

    @set_h_fk1(h_fk1.name())
    @set_h_fk2(h_fk2.name())
    @set_h_fk3(h_fk3.name())

if @mode == 1:  # run
    jointsParent = joint1.getParent()

    h_fk1 = pm.PyNode(@h_fk1)
    h_fk2 = pm.PyNode(@h_fk2)
    h_fk3 = pm.PyNode(@h_fk3)
    h_ik = pm.PyNode(@h_ik)
    h_polevector = pm.PyNode(@h_polevector)
    h_options = pm.PyNode(@h_options)
    h_position = pm.PyNode(@h_position) if pm.objExists(@h_position) else None

    # controls and joints groups
    controls_grp = pm.createNode("transform", n=@name + "_controls_group", p=controlsParent)

    internal_grp = pm.createNode("transform", n=@name + "_internal_group", p=internalParent)
    internal_grp.v.set(False)
    
    rig_utils.lockTRS(controls_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internal_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)

    others_grp = pm.createNode("transform", n=@name + "_others_group", p=othersParent)

    # options control
    options_ctrl = pm.createNode("transform", n=@name + "_options_control", p=controls_grp)
    pm.parentConstraint(joint1, options_ctrl)

    rig_utils.curve.makeFromCurve(options_ctrl, h_options)

    options_ctrl.addAttr("ikfk", at="float", min=0, max=1, k=True)
    options_ctrl.addAttr("scaleFactor1x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor2x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor3x", at="float", min=0.1, dv=1, k=True)
    
    for i, j in enumerate([joint1, joint2, joint3]):
        a = f"scaleFactor{i+1}"
        options_ctrl.addAttr(a, min=0.01, dv=1.0, k=True)
        if i == 2:
            md = pm.createNode("multiplyDivide", n=j+"_scaleFactor_multiplyDivide")
            options_ctrl.attr(a) >> md.input1X
            options_ctrl.attr(a) >> md.input1Y
            options_ctrl.attr(a) >> md.input1Z
            options_ctrl.scaleFactor3x >> md.input2X
            md.output >> j.s
        else:
            options_ctrl.attr(a) >> j.sx
            options_ctrl.attr(a) >> j.sy
            options_ctrl.attr(a) >> j.sz

    rig_utils.lockTRS(options_ctrl, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)
    
    # ikfk switch
    ikfk_rev = pm.createNode("reverse", n=@name + "_ikfk_reverse")
    options_ctrl.ikfk >> ikfk_rev.inputX

    # bones start position control
    positionCtrl = None
    if h_position:
        options_ctrl.addAttr("positionControl", at="bool", dv=False)
        rig_utils.lockAttr(options_ctrl.positionControl, 0.5)    
        
        positionTransform = pm.createNode("transform", n=@name + "_1_position_control_transform", p=controls_grp)
        pm.matchTransform(positionTransform, jointsParent)
        pm.matchTransform(positionTransform, joint1, position=True, rotation=False)
        options_ctrl.positionControl >> positionTransform.v
        
        if jointsParent:
            pm.parentConstraint(jointsParent, positionTransform, mo=True)
        
        positionCtrl = pm.createNode("transform", n=@name + "_1_position_control", p=positionTransform)
        pm.matchTransform(positionCtrl, joint1, position=True, rotation=False)        
        
        rig_utils.curve.makeFromCurve(positionCtrl, h_position)
        rig_utils.lockTRS(positionCtrl, [])
        
    # IK chain
    ik1 = rig_utils.matchJoint(joint1, @name + "_ik_1_joint")
    ik2 = rig_utils.matchJoint(joint2, @name + "_ik_2_joint")
    ik3 = rig_utils.matchJoint(joint3, @name + "_ik_3_joint")
    internal_grp | ik1 | ik2 | ik3
    
    pm.parentConstraint(positionCtrl or jointsParent, ik1, mo=True, skipRotate=["x", "y", "z"]) # pointConstraint

    # FIX
    fix1 = rig_utils.matchJoint(joint1, @name + "_fix_1_joint")
    fix2 = rig_utils.matchJoint(joint2, @name + "_fix_2_joint")
    fix3 = rig_utils.matchJoint(joint3, @name + "_fix_3_joint")

    internal_grp | fix1 | fix2 | fix3

    pm.pointConstraint(ik1, fix1)

    # FK
    fk1 = rig_utils.matchJoint(joint1, @name + "_fk_1_joint")
    fk2 = rig_utils.matchJoint(joint2, @name + "_fk_2_joint")
    fk3 = rig_utils.matchJoint(joint3, @name + "_fk_3_joint")
    internal_grp | fk1 | fk2 | fk3

    # FK controls
    # fk1
    fk1_ctrl = pm.createNode("transform", n=@name + "_fk_1_control", p=controls_grp)  
    pm.matchTransform(fk1_ctrl, joint1)
    rig_utils.curve.makeFromCurve(fk1_ctrl, h_fk1)
    pm.parentConstraint(positionCtrl or jointsParent, fk1_ctrl, sr=["x","y","z"], mo=True)

    switcher.addFollow(fk1_ctrl, controls_grp, jointsParent, attr="followBody", default=0.0, type="orient")
    
    rig_utils.setToOffsetParentMatrix(fk1_ctrl)
    options_ctrl.ikfk >> fk1_ctrl.v
    rig_utils.lockTRS(fk1_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.parentConstraint(fk1_ctrl, fk1)
    
    # fk2
    fk2_ctrl = pm.createNode("transform", n=@name + "_fk_2_control", p=fk1_ctrl)
    pm.matchTransform(fk2_ctrl, joint2)
    pm.pointConstraint(fk2, fk2_ctrl)
    rig_utils.setToOffsetParentMatrix(fk2_ctrl)

    rig_utils.curve.makeFromCurve(fk2_ctrl, h_fk2)    
    rig_utils.lockTRS(fk2_ctrl, [1, 1, 1], [1, 1, 0], [1, 1, 1], 1)
    
    pm.orientConstraint(fk2_ctrl, fk2)
    
    # fk3
    fk3_ctrl = pm.createNode("transform", n=@name + "_fk_3_control", p=fk2_ctrl)
    pm.matchTransform(fk3_ctrl, joint3)
    pm.pointConstraint(fk3, fk3_ctrl)
    rig_utils.setToOffsetParentMatrix(fk3_ctrl)

    rig_utils.curve.makeFromCurve(fk3_ctrl, h_fk3)
    rig_utils.lockTRS(fk3_ctrl, [1, 1, 1], [], [1, 1, 1], 1)

    pm.orientConstraint(fk3_ctrl, fk3)
    
    # FIX IK handles
    fix_ikHandle1 = pm.ikHandle(startJoint=fix1,
                                endEffector=fix2,
                                solver="ikSCsolver",
                                n=@name + "_fix_1_ikHandle")[0]
    internal_grp | fix_ikHandle1

    fix_ikHandle2 = pm.ikHandle(startJoint=fix2,
                                endEffector=fix3,
                                solver="ikSCsolver",
                                n=@name + "_fix_2_ikHandle")[0]
    internal_grp | fix_ikHandle2    
    
    # IK handle
    ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik3, solver="ikRPsolver", n=@name + "_ikHandle")[0]
    internal_grp | ikHandle

    # IK control
    ik_ctrl = pm.createNode("joint", n=@name + "_ik_control", p=controls_grp)

    ik_ctrl.radius.set(0)
    rig_utils.lockAttr(ik_ctrl.radius, 1)
    
    pm.matchTransform(ik_ctrl, @placeIkAt or ik3, position=True, rotation=False)

    rig_utils.setToOffsetParentMatrix(ik_ctrl)
    
    if pm.objExists(@lastCtrlOrient):
        pm.matchTransform(ik_ctrl, @lastCtrlOrient, position=False, rotation=True)    
        rig_utils.freezeJoints([ik_ctrl])

    rig_utils.curve.makeFromCurve(ik_ctrl, h_ik)
    ikfk_rev.outputX >> ik_ctrl.v

    dynamicParent.makeDynamicParent(ik_ctrl, ik_ctrl)

    rig_utils.lockTRS(ik_ctrl, [], [], [1, 1, 1], 1)

    # IK polevector control
    polevec_follow_j1 = rig_utils.matchJoint(joint1, @name + "_ik_polevector_follow_1_joint")
    polevec_follow_j2 = rig_utils.matchJoint(joint3, @name + "_ik_polevector_follow_2_joint")
    internal_grp | polevec_follow_j1 | polevec_follow_j2    
    
    polevec_follow_ikHandle = pm.ikHandle(sj=polevec_follow_j1, ee=polevec_follow_j2, solver="ikSCsolver")[0]
    polevec_follow_ikHandle.rename(@name+"_ik_polevector_follow_ikHandle")
    internal_grp | polevec_follow_ikHandle
    
    pm.parentConstraint(ik_ctrl, polevec_follow_ikHandle, mo=True)
    pm.pointConstraint(ik1, polevec_follow_j1)
    
    polevec_ctrl = pm.createNode("transform", n=@name + "_ik_polevector_control", p=controls_grp)
    pm.matchTransform(polevec_ctrl, h_polevector, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(polevec_ctrl)    

    switcher.addFollow(polevec_ctrl, internal_grp, polevec_follow_j1, attr="follow", default=0.0, type="parent")
    
    polevec_ctrl.addAttr("snap", min=0, max=1, k=True)
    polevec_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    polevec_ctrl.stretch.set(0)

    rig_utils.curve.makeFromCurve(polevec_ctrl, h_polevector)
    
    ikfk_rev.outputX >> polevec_ctrl.v
    
    rig_utils.lockTRS(polevec_ctrl, [], [1, 1, 1], [1, 1, 1], 1)

    pm.pointConstraint(polevec_ctrl, fix_ikHandle1)  # snap fix1-fix2
    
    if @constrainIK:
        pm.pointConstraint(ik_ctrl, fix_ikHandle2)  # snap fix2-fix3    

    dynamicParent.makeDynamicParent(polevec_ctrl, polevec_ctrl)

    rig_utils.makeHelpLine(
        @name + "_polevector", 
        [polevec_ctrl, joint2],
        visibleAttr=ikfk_rev.outputX,
        parent=others_grp)

    ik_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    ik_ctrl.stretch.set(0)

    dFix1 = rig_utils.createDistance(@name + "_fix_1_distance", fix1, polevec_ctrl)
    dFix2 = rig_utils.createDistance(@name + "_fix_2_distance", fix2, ik_ctrl)
    d = rig_utils.createDistance(@name + "_ik_distance", ik1, ik_ctrl)

    ik2_tx_scaleMult = pm.createNode("multDL", n=ik2 + "_tx_scaleFactor1x_multDL")
    ik2_tx_scaleMult.input1.set(abs(ik2.tx.get()))
    options_ctrl.scaleFactor1x >> ik2_tx_scaleMult.input2

    ik3_tx_scaleMult = pm.createNode("multDL", n=ik3 + "_tx_scaleFactor2x_multDL")
    ik3_tx_scaleMult.input1.set(abs(ik3.tx.get()))
    options_ctrl.scaleFactor2x >> ik3_tx_scaleMult.input2

    ik2ik3_tx_sumAdd = pm.createNode("addDL", n=@name + "_ik_sum_tx_addDL")
    ik2_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input1
    ik3_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input2

    sFix1 = rig_utils.makeStretchable(
        @name + "_fix_1", 
        [fix1],
        dFix1, 
        polevec_ctrl.stretch,
        0.01, 0,
        ik2_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    sFix2 = rig_utils.makeStretchable(
        @name + "_fix_2", 
        [fix2],
        dFix2,
        ik_ctrl.stretch,
        0.01,
        0,
        ik3_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    s = rig_utils.makeStretchable(
        @name + "_ik", 
        [ik1, ik2],
        d,
        ik_ctrl.stretch,
        1,
        0,
        ik2ik3_tx_sumAdd.output,
        scales=[True, False, False],  
        useTx=False)

    # softIK
    ik_ctrl.addAttr("softIK", min=0, max=0.5, dv=0.05, k=True)

    ac_x = rig_utils.anim.createSoftIKAnimCurve(@name + "_softIK")

    stretchX = pm.PyNode(@name + "_ik_stretch_x_blendTwoAttr")
    cond = pm.PyNode(@name + "_ik_squash_condition")

    stretchX.output >> ac_x.input

    softIk_switch = pm.createNode("multDL", n=@name + "_softIK_switch_multDL")
    ik_ctrl.softIK >> softIk_switch.input1
    ik_ctrl.stretch >> softIk_switch.input2

    softIk_b2a = pm.createNode("blendTwoAttr", n=@name + "_softIK_blendTwoAttr")
    softIk_switch.output >> softIk_b2a.attributesBlender
    stretchX.output >> softIk_b2a.i[0]
    ac_x.output >> softIk_b2a.i[1]

    softIk_b2a.output >> cond.firstTerm
    softIk_b2a.output >> cond.colorIfTrueR

    # fk stretch with scaleFactor
    fk2_scaleFactor_mult = pm.createNode("multDL", n=fk2 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor1x >> fk2_scaleFactor_mult.input1
    fk2_scaleFactor_mult.input2.set(fk2.tx.get())
    fk2_scaleFactor_mult.output >> fk2.tx
    
    fk3_scaleFactor_mult = pm.createNode("multDL", n=fk3 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor2x >> fk3_scaleFactor_mult.input1
    fk3_scaleFactor_mult.input2.set(fk3.tx.get())
    fk3_scaleFactor_mult.output >> fk3.tx

    # ik stretch
    multIK1 = pm.createNode("multiplyDivide", n=ik1 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK1.input1X
    options_ctrl.scaleFactor1x >> multIK1.input2X

    multIK2 = pm.createNode("multiplyDivide", n=ik2 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK2.input1X
    options_ctrl.scaleFactor2x >> multIK2.input2X

    multFIX1 = pm.createNode("multiplyDivide", n=fix1 + "_scaleFactor_multiplyDivide")
    sFix1[0] >> multFIX1.input1X
    options_ctrl.scaleFactor1x >> multFIX1.input2X
    multFIX1.outputX >> fix1.sx

    multFIX2 = pm.createNode("multiplyDivide", n=fix2 + "_scaleFactor_multiplyDivide")
    sFix2[0] >> multFIX2.input1X
    options_ctrl.scaleFactor2x >> multFIX2.input2X
    multFIX2.outputX >> fix2.sx

    b2a = pm.createNode("blendTwoAttr", n=ik1 + "_stretch_x_blendTwoAttr")
    multIK1.outputX >> b2a.i[0]
    multFIX1.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik1.sx

    b2a = pm.createNode("blendTwoAttr", n=ik2 + "_stretch_x_blendTwoAttr")
    multIK2.outputX >> b2a.i[0]
    multFIX2.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik2.sx

    defPolevec = pm.createNode("transform", n=polevec_ctrl + "_default_transform")
    pm.matchTransform(defPolevec, h_polevector, position=True, rotation=False)
    pm.parent(defPolevec, fk2)

    pm.poleVectorConstraint(polevec_ctrl, ikHandle)

    if @constrainIK:
        pc = pm.pointConstraint(ik_ctrl, fix3, ikHandle)

        snap_rev = pm.createNode("reverse", n=@name + "_ik_snap_reverse")
        polevec_ctrl.snap >> snap_rev.inputX

        snap_rev.outputX >> pc.w0
        polevec_ctrl.snap >> pc.w1

        pm.orientConstraint(ik_ctrl, ik3, mo=True)

    # blend IKFK constraints
    for j, ikj, fkj in [(joint1, ik1, fk1), (joint2, ik2, fk2), (joint3, ik3, fk3)]:
        oc = pm.parentConstraint(ikj, fkj, j)
        oc.interpType.set(2)
        ikfk_rev.outputX >> oc.w0
        options_ctrl.ikfk >> oc.w1
        
    # ModuleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@name + "_limb")
    moduleInfo.setAttr("type", "limb")

    moduleInfo.setAttr("options", options_ctrl.message)
    moduleInfo.setAttr("ikfk", options_ctrl.ikfk)    
    moduleInfo.setAttr("snap", polevec_ctrl.snap)     
    moduleInfo.setAttr("ik1_joint", ik1.message)
    moduleInfo.setAttr("ik2_joint", ik2.message)
    moduleInfo.setAttr("ik3_joint", ik3.message)
    moduleInfo.setAttr("fk1_joint", fk1.message)
    moduleInfo.setAttr("fk2_joint", fk2.message)
    moduleInfo.setAttr("fk3_joint", fk3.message)    
    moduleInfo.setAttr("ik", ik_ctrl.message)
    moduleInfo.setAttr("polevector", polevec_ctrl.message)
    moduleInfo.setAttr("fk1", fk1_ctrl.message)
    moduleInfo.setAttr("fk2", fk2_ctrl.message)
    moduleInfo.setAttr("fk3", fk3_ctrl.message)

    # seamless
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk1", fk1_ctrl, ik1)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk2", fk2_ctrl, ik2)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk3", fk3_ctrl, ik3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "ik", ik_ctrl, fk3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "polevector", polevec_ctrl, defPolevec)
]]></run>
<doc><![CDATA[## Summary  
The **L_arm** module creates a fully functional IK/FK arm rig. It first generates placement helpers (IK plane, pole‑vector, IK and FK controls) in *Helpers* mode, then builds the rig in *Run* mode, adding an IK/FK switch, pole‑vector controller, stretch and soft‑IK logic, and exposes all key objects through a `ModuleInfo` node for downstream use.

## Inputs  
- **mode** – Selects *Helpers* (0) or *Run* (1).  
- **name** – Base name for all generated nodes.  
- **joint1 / joint2 / joint3** – Target joint names forming the arm chain.  
- **lastCtrlOrient** – Optional joint used to orient the final IK control.  
- **ikHelperType** – Shape of the IK control curve (e.g., cube, sphere).  
- **constrainIK** – Boolean to enable optional IK‑to‑fix constraints.  
- **placeIkAt** – Optional transform to position the IK control at start.

## Outputs  
- **h_fk1 / h_fk2 / h_fk3** – FK helper curves.  
- **h_ik** – IK helper curve.  
- **h_polevector** – Pole‑vector helper curve.  
- **h_options** – Options helper curve.  
- **out_ikfkSwitch** – PlusMinusAverage node driving the IK/FK blend.  
- **out_ik1 / out_ik2 / out_ik3** – IK joint chain.  
- **out_fk1 / out_fk2 / out_fk3** – FK joint chain.  
- **out_fix3** – Third fix joint for optional constraints.  
- **out_ikHandle** – Main IK handle.  
- **out_fix2_ikHandle** – Secondary IK handle for fix joints.  
- **out_ikCtrl** – IK control joint.  
- **out_polevecCtrl** – Pole‑vector control.  
- **moduleInfo** – `ModuleInfo` node exposing rig type, joints, controls, and switch attributes.

## Usage  
1. **Set Target Joints** – Assign `joint1`, `joint2`, and `joint3` to the arm’s shoulder, elbow, and wrist joints.  
2. **Generate Helpers** – Set `mode` to **Helpers** and run. The module will create placement helpers under the *Helpers* parent, scaled to the joint spacing. Adjust their positions and orientations in the viewport.  
3. **Configure Optional Settings** –  
   - Choose an `ikHelperType` shape.  
   - Toggle `constrainIK` if you need the IK control to drive the fix joints.  
   - If desired, set `placeIkAt` to a transform that will be used as the IK control’s base position.  
4. **Build the Rig** – Switch `mode` to **Run** and execute. The module will create the full FK/IK chain, IK/FK switch, pole‑vector controller, stretch and soft‑IK systems, and lock/unlock attributes appropriately.  
5. **Connect to Other Modules** – Use the `moduleInfo` node or the individual output attributes (`out_ikCtrl`, `out_polevecCtrl`, `out_fk1`, etc.) to link this arm rig to downstream modules such as hand, fingers, or other limb systems.  
6. **Mirror or Duplicate** – The helper attributes (`h_fk1`, `h_fk2`, `h_fk3`, `h_ik`, `h_polevector`, `h_options`) can be mirrored or reused for building a symmetrical arm.  

The module automatically handles mirroring, dynamic parenting, and provides a clean interface for further customization or integration into larger rigging pipelines.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "R_arm", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_3_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_3_joint"}]]></attr>
<attr name="ikHelperType" template="comboBox" category="Others" connect=""><![CDATA[{"current": "cube", "items": ["arc", "axis", "axisSphere", "cube", "circle", "diamond", "pyramid", "rect", "sphere", "triangle"], "default": "current"}]]></attr>
<attr name="constrainIK" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="placeIkAt" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "R_arm_ik_polevector_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_arm_options_control_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "R_arm_1_position_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="L_fingers" muted="0" uid="35660581920746079cd76409b837b743">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent

controlsParent = pm.PyNode("controls")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    helpers = []
    for name, j1, _, _, _, _ in @fingers:
        hlp = rig_utils.curve.makeCurve(@side + "_" + name + "_control_helper", "cube")
        pm.parentConstraint(pm.PyNode(@side + "_" + j1), hlp)
        helpersParent | hlp
        helpers.append(hlp.name())

    @set_helpers(helpers)

elif @mode == 1:  # run
    controls_grp = pm.createNode("transform", n=@side + "_" + @name + "_controls_group", p=controlsParent)
    rig_utils.lockTRS(controls_grp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)

    spreadNode = None
    cuppingNode = None
    
    controls = []
    constraints = []
    for i, (name, j1, j2, j3, _, _) in enumerate(@fingers):
        helper = pm.PyNode(@helpers[i])
        j1 = pm.PyNode(@side + "_" + j1)
        j2 = pm.PyNode(@side + "_" + j2)
        j3 = pm.PyNode(@side + "_" + j3) if pm.objExists(@side + "_" + j3) else None

        j3_children = j3.listRelatives(c=True, type="joint") if j3 else []
        j4 = j3_children[0] if j3_children else None

        # fk control
        transform = pm.createNode("transform", n=@side + "_" + name + "_control_transform", p=controls_grp)
        ctrl = pm.createNode("transform", n=@side + "_" + name + "_control", p=transform)
        rig_utils.lockTRS(ctrl, [], [], [1, 1, 1], 1)
        
        pm.matchTransform(transform, j1)        
        pm.parentConstraint(j1.getParent(), transform, mo=True)
        rig_utils.curve.makeFromCurve(ctrl, helper)
        
        dynamicParent.makeDynamicParent(ctrl, ctrl)

        pc = pm.parentConstraint(ctrl, j1)
        constraints.append(pc)

        if name == @spreadOn:
            spreadNode = ctrl

        if name == @cuppingOn:
            cuppingNode = ctrl
                    
        pm.aliasAttr("roll", ctrl.rx)
        pm.aliasAttr("sideways", ctrl.ry)
        pm.aliasAttr("bendA", ctrl.rz)        
    
        if j2:
            ctrl.addAttr("bendB", at="doubleAngle", dv=0, k=True)
            ctrl.bendB >> pm.PyNode(j2).rz
        if j3:
            ctrl.addAttr("bendC", at="doubleAngle", dv=0, k=True)
            ctrl.bendC >> j3.rz

                            
        for label, j in zip("ABC", [j1, j2, j3]): 
            if j:
                attr = "scaleFactor"+label      
                ctrl.addAttr(attr, at="float", dv=1, min=0.01, k=True)
                ctrl.attr(attr) >> j.sx        

        for label, j in zip(["A_yz", "B_yz", "C_yz"], [j1, j2, j3]): 
            if j:
                attr = "scaleFactor"+label
                ctrl.addAttr(attr, at="float", dv=1, min=0.01, k=True)
                ctrl.attr(attr) >> j.sy       
                ctrl.attr(attr) >> j.sz
           
        controls.append(ctrl)
        
    if spreadNode:
        spreadNode.addAttr("spread", dv=0, k=True)

        for i, (name, _, _, _, spread, _) in enumerate(@fingers):
            if spread == 0:
                continue
                
            mult = pm.createNode("multDL", n=@side + "_" + name + "_spread_multDL")
            mult.input1.set(spread)
            spreadNode.spread >> mult.input2
            mult.output >> constraints[i].target[0].targetOffsetRotate.targetOffsetRotateY

    if cuppingNode:
        cuppingNode.addAttr("cupping", dv=0, k=True)

        for i, (name, j1, _, _, _, cupping) in enumerate(@fingers):
            if cupping == 0:
                continue
                
            j1_parent = pm.PyNode(@side + "_" + j1).getParent()
            if j1_parent:
                md = pm.createNode("multiplyDivide", n=@side + "_" + name + "_cupping_multiplyDivide")
                md.input1.set(x*cupping for x in @cuppingCoeff)
                
                cuppingNode.cupping >> md.input2X
                cuppingNode.cupping >> md.input2Y
                cuppingNode.cupping >> md.input2Z
                md.output >> j1_parent.r

    # moduleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@side + "_" + @name)
    moduleInfo.setAttr("type", "fingers")
    
    for i, ctrl in enumerate(controls):
        moduleInfo.setAttr("control"+str(i+1), ctrl.message)
]]></run>
<doc><![CDATA[## Summary  
Creates a finger rig for a hand or paw, generating FK controls for each digit with optional spread and cupping attributes. The module can first produce placement helpers (in **Helpers** mode) and then build the full control hierarchy (in **Run** mode), publishing a `moduleInfo` node that lists all generated controls for downstream modules.

## Inputs  
- **`mode`** (`radioButton`):  
  - **Helpers** – creates placement helper curves for each finger.  
  - **Run** – builds the final FK control hierarchy.  
- **`side`** (`lineEditAndButton`): Prefix for all created nodes (e.g., `L` or `R`).  
- **`name`** (`lineEditAndButton`): Base name for the module (default `fingers`).  
- **`fingers`** (`table`): Table defining each digit. Each row contains:  
  1. **name** – finger identifier (`thumb`, `index`, …).  
  2. **joint1** – first joint of the finger.  
  3. **joint2** – second joint.  
  4. **joint3** – third joint (may be `None`).  
  5. **spread** – numeric value used to drive spread on the selected spread finger.  
  6. **cupping** – numeric value used to drive cupping on the selected cupping finger.  
- **`spreadOn`** (`comboBox`): Finger whose control will receive the `spread` attribute.  
- **`cuppingOn`** (`comboBox`): Finger whose control will receive the `cupping` attribute.  
- **`cuppingCoeff`** (`vector`): Coefficients applied when driving cupping rotations.  
- **`helpers`** (`listBox`): List of helper curve names created in **Helpers** mode; used as input when building the controls.

## Outputs  
- **`moduleInfo`** (`rig_utils.moduleInfo.ModuleInfo`):  
  - `type` = `"fingers"`.  
  - `control1`, `control2`, … – message attributes pointing to each finger FK control.  
- **`helpers`** list (in **Helpers** mode): Names of the helper curves created for each finger.  
- **Control hierarchy** under a group named `<side>_<name>_controls_group`:  
  - FK control nulls and controls for each finger.  
  - Spread and cupping attributes on the selected controls.  
  - Spread multiplier nodes and cupping multiplyDivide nodes that drive joint rotations.  
- **`spreadNode`** and **`cuppingNode`** (the controls selected by `spreadOn` and `cuppingOn`) receive the `spread` and `cupping` attributes, respectively.

## Usage  
1. **Set up the finger data**:  
   - Fill the `fingers` table with the joint names for each digit.  
   - Choose which finger will drive spread (`spreadOn`) and cupping (`cuppingOn`).  
2. **Generate helpers**:  
   - Switch `mode` to **Helpers** and execute.  
   - The module creates a cube helper curve for each finger and populates the `helpers` list.  
   - Position the helpers in the viewport to match the desired control placement.  
3. **Build the rig**:  
   - Set `mode` to **Run** and execute.  
   - The module creates FK controls, applies spread and cupping logic, and publishes the `moduleInfo`.  
4. **Connect downstream modules**:  
   - Use the `moduleInfo` node to reference the finger controls from other modules (e.g., hand, palm, or animation layers).  
   - If needed, adjust the spread or cupping attributes on the selected controls to fine‑tune finger spread or cupping behavior.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="side" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "L", "buttonEnabled": false}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "fingers", "buttonEnabled": false}]]></attr>
<attr name="fingers" template="table" category="General" connect=""><![CDATA[{"default": "items", "items": [["thumb", "thumb_1_joint", "thumb_2_joint", "thumb_3_joint", 0, 0], ["index", "index_1_joint", "index_2_joint", "index_3_joint", 0.666, 0], ["middle", "middle_1_joint", "middle_2_joint", "middle_3_joint", 0.05, 0], ["ring", "ring_1_joint", "ring_2_joint", "ring_3_joint", -0.5, 1], ["pinky", "pinky_1_joint", "pinky_2_joint", "pinky_3_joint", -1, 0]], "header": ["name", "joint1", "joint2", "joint3", "spread", "cupping"]}]]></attr>
<attr name="spreadOn" template="comboBox" category="General" connect=""><![CDATA[{"current": "thumb", "items": ["thumb", "index", "middle", "ring", "pinky"], "default": "current"}]]></attr>
<attr name="cuppingOn" template="comboBox" category="General" connect=""><![CDATA[{"current": "thumb", "items": ["(no cupping)", "thumb", "index", "middle", "ring", "pinky"], "default": "current"}]]></attr>
<attr name="cuppingCoeff" template="vector" category="General" connect=""><![CDATA[{"default": "value", "value": [-1.0, 0.15, 0.2]}]]></attr>
<attr name="helpers" template="listBox" category="Helpers" connect=""><![CDATA[{"default": "items", "items": ["L_thumb_control_helper", "L_index_control_helper", "L_middle_control_helper", "L_ring_control_helper", "L_pinky_control_helper"]}]]></attr>
</attributes>
</module>
<module name="R_fingers" muted="0" uid="35660581920746079cd76409b837b743">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent

controlsParent = pm.PyNode("controls")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    helpers = []
    for name, j1, _, _, _, _ in @fingers:
        hlp = rig_utils.curve.makeCurve(@side + "_" + name + "_control_helper", "cube")
        pm.parentConstraint(pm.PyNode(@side + "_" + j1), hlp)
        helpersParent | hlp
        helpers.append(hlp.name())

    @set_helpers(helpers)

elif @mode == 1:  # run
    controls_grp = pm.createNode("transform", n=@side + "_" + @name + "_controls_group", p=controlsParent)
    rig_utils.lockTRS(controls_grp, [1, 1, 1], [1, 1, 1], [1, 1, 1], 0.5)

    spreadNode = None
    cuppingNode = None
    
    controls = []
    constraints = []
    for i, (name, j1, j2, j3, _, _) in enumerate(@fingers):
        helper = pm.PyNode(@helpers[i])
        j1 = pm.PyNode(@side + "_" + j1)
        j2 = pm.PyNode(@side + "_" + j2)
        j3 = pm.PyNode(@side + "_" + j3) if pm.objExists(@side + "_" + j3) else None

        j3_children = j3.listRelatives(c=True, type="joint") if j3 else []
        j4 = j3_children[0] if j3_children else None

        # fk control
        transform = pm.createNode("transform", n=@side + "_" + name + "_control_transform", p=controls_grp)
        ctrl = pm.createNode("transform", n=@side + "_" + name + "_control", p=transform)
        rig_utils.lockTRS(ctrl, [], [], [1, 1, 1], 1)
        
        pm.matchTransform(transform, j1)        
        pm.parentConstraint(j1.getParent(), transform, mo=True)
        rig_utils.curve.makeFromCurve(ctrl, helper)
        
        dynamicParent.makeDynamicParent(ctrl, ctrl)

        pc = pm.parentConstraint(ctrl, j1)
        constraints.append(pc)

        if name == @spreadOn:
            spreadNode = ctrl

        if name == @cuppingOn:
            cuppingNode = ctrl
                    
        pm.aliasAttr("roll", ctrl.rx)
        pm.aliasAttr("sideways", ctrl.ry)
        pm.aliasAttr("bendA", ctrl.rz)        
    
        if j2:
            ctrl.addAttr("bendB", at="doubleAngle", dv=0, k=True)
            ctrl.bendB >> pm.PyNode(j2).rz
        if j3:
            ctrl.addAttr("bendC", at="doubleAngle", dv=0, k=True)
            ctrl.bendC >> j3.rz

                            
        for label, j in zip("ABC", [j1, j2, j3]): 
            if j:
                attr = "scaleFactor"+label      
                ctrl.addAttr(attr, at="float", dv=1, min=0.01, k=True)
                ctrl.attr(attr) >> j.sx        

        for label, j in zip(["A_yz", "B_yz", "C_yz"], [j1, j2, j3]): 
            if j:
                attr = "scaleFactor"+label
                ctrl.addAttr(attr, at="float", dv=1, min=0.01, k=True)
                ctrl.attr(attr) >> j.sy       
                ctrl.attr(attr) >> j.sz
           
        controls.append(ctrl)
        
    if spreadNode:
        spreadNode.addAttr("spread", dv=0, k=True)

        for i, (name, _, _, _, spread, _) in enumerate(@fingers):
            if spread == 0:
                continue
                
            mult = pm.createNode("multDL", n=@side + "_" + name + "_spread_multDL")
            mult.input1.set(spread)
            spreadNode.spread >> mult.input2
            mult.output >> constraints[i].target[0].targetOffsetRotate.targetOffsetRotateY

    if cuppingNode:
        cuppingNode.addAttr("cupping", dv=0, k=True)

        for i, (name, j1, _, _, _, cupping) in enumerate(@fingers):
            if cupping == 0:
                continue
                
            j1_parent = pm.PyNode(@side + "_" + j1).getParent()
            if j1_parent:
                md = pm.createNode("multiplyDivide", n=@side + "_" + name + "_cupping_multiplyDivide")
                md.input1.set(x*cupping for x in @cuppingCoeff)
                
                cuppingNode.cupping >> md.input2X
                cuppingNode.cupping >> md.input2Y
                cuppingNode.cupping >> md.input2Z
                md.output >> j1_parent.r

    # moduleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@side + "_" + @name)
    moduleInfo.setAttr("type", "fingers")
    
    for i, ctrl in enumerate(controls):
        moduleInfo.setAttr("control"+str(i+1), ctrl.message)
]]></run>
<doc><![CDATA[## Summary  
Creates a finger rig for a hand or paw, generating FK controls for each digit with optional spread and cupping attributes. The module can first produce placement helpers (in **Helpers** mode) and then build the full control hierarchy (in **Run** mode), publishing a `moduleInfo` node that lists all generated controls for downstream modules.

## Inputs  
- **`mode`** (`radioButton`):  
  - **Helpers** – creates placement helper curves for each finger.  
  - **Run** – builds the final FK control hierarchy.  
- **`side`** (`lineEditAndButton`): Prefix for all created nodes (e.g., `L` or `R`).  
- **`name`** (`lineEditAndButton`): Base name for the module (default `fingers`).  
- **`fingers`** (`table`): Table defining each digit. Each row contains:  
  1. **name** – finger identifier (`thumb`, `index`, …).  
  2. **joint1** – first joint of the finger.  
  3. **joint2** – second joint.  
  4. **joint3** – third joint (may be `None`).  
  5. **spread** – numeric value used to drive spread on the selected spread finger.  
  6. **cupping** – numeric value used to drive cupping on the selected cupping finger.  
- **`spreadOn`** (`comboBox`): Finger whose control will receive the `spread` attribute.  
- **`cuppingOn`** (`comboBox`): Finger whose control will receive the `cupping` attribute.  
- **`cuppingCoeff`** (`vector`): Coefficients applied when driving cupping rotations.  
- **`helpers`** (`listBox`): List of helper curve names created in **Helpers** mode; used as input when building the controls.

## Outputs  
- **`moduleInfo`** (`rig_utils.moduleInfo.ModuleInfo`):  
  - `type` = `"fingers"`.  
  - `control1`, `control2`, … – message attributes pointing to each finger FK control.  
- **`helpers`** list (in **Helpers** mode): Names of the helper curves created for each finger.  
- **Control hierarchy** under a group named `<side>_<name>_controls_group`:  
  - FK control nulls and controls for each finger.  
  - Spread and cupping attributes on the selected controls.  
  - Spread multiplier nodes and cupping multiplyDivide nodes that drive joint rotations.  
- **`spreadNode`** and **`cuppingNode`** (the controls selected by `spreadOn` and `cuppingOn`) receive the `spread` and `cupping` attributes, respectively.

## Usage  
1. **Set up the finger data**:  
   - Fill the `fingers` table with the joint names for each digit.  
   - Choose which finger will drive spread (`spreadOn`) and cupping (`cuppingOn`).  
2. **Generate helpers**:  
   - Switch `mode` to **Helpers** and execute.  
   - The module creates a cube helper curve for each finger and populates the `helpers` list.  
   - Position the helpers in the viewport to match the desired control placement.  
3. **Build the rig**:  
   - Set `mode` to **Run** and execute.  
   - The module creates FK controls, applies spread and cupping logic, and publishes the `moduleInfo`.  
4. **Connect downstream modules**:  
   - Use the `moduleInfo` node to reference the finger controls from other modules (e.g., hand, palm, or animation layers).  
   - If needed, adjust the spread or cupping attributes on the selected controls to fine‑tune finger spread or cupping behavior.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="side" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "R", "buttonEnabled": false}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "value": "fingers", "buttonEnabled": false}]]></attr>
<attr name="fingers" template="table" category="General" connect=""><![CDATA[{"default": "items", "items": [["thumb", "thumb_1_joint", "thumb_2_joint", "thumb_3_joint", 0, 0], ["index", "index_1_joint", "index_2_joint", "index_3_joint", 0.666, 0], ["middle", "middle_1_joint", "middle_2_joint", "middle_3_joint", 0.05, 0], ["ring", "ring_1_joint", "ring_2_joint", "ring_3_joint", -0.5, 1], ["pinky", "pinky_1_joint", "pinky_2_joint", "pinky_3_joint", -1, 0]], "header": ["name", "joint1", "joint2", "joint3", "spread", "cupping"]}]]></attr>
<attr name="spreadOn" template="comboBox" category="General" connect=""><![CDATA[{"current": "thumb", "items": ["thumb", "index", "middle", "ring", "pinky"], "default": "current"}]]></attr>
<attr name="cuppingOn" template="comboBox" category="General" connect=""><![CDATA[{"current": "thumb", "items": ["(no cupping)", "thumb", "index", "middle", "ring", "pinky"], "default": "current"}]]></attr>
<attr name="cuppingCoeff" template="vector" category="General" connect=""><![CDATA[{"default": "value", "value": [-1.0, 0.15, 0.2]}]]></attr>
<attr name="helpers" template="listBox" category="Helpers" connect=""><![CDATA[{"default": "items", "items": ["R_thumb_control_helper", "R_index_control_helper", "R_middle_control_helper", "R_ring_control_helper", "R_pinky_control_helper"]}]]></attr>
</attributes>
</module>
<module name="L_leg" muted="0" uid="aa7b42755ced4f1a823ebfaa97540183">
<doc><![CDATA[## Summary  
The **L_leg** module creates a complete leg rig that supports IK/FK switching, foot roll, toe controls, stretch, soft‑IK, and optional pole‑vector locking. It first generates helper controls in *Helpers* mode, then builds the full rig in *Run* mode by composing two child modules: **limb** (the main IK/FK chain) and **foot** (toe and foot‑roll mechanics). All key objects are exposed through a `moduleInfo` node for downstream modules.

## Inputs  
- **`mode`** – Radio button (`Helpers` / `Run`).  
- **`name`** – Base name for all created nodes.  
- **`joint1` – `joint5`** – Names of the joint chain:  
  - `joint1`: hip / upper leg joint.  
  - `joint2`: knee joint.  
  - `joint3`: ankle joint.  
  - `joint4`: toe base joint.  
  - `joint5`: toe tip joint.  
- **`lastCtrlOrient`** – Optional transform used to orient the final IK control.  
- **`fkNoFollow`** – (unused in current code, placeholder for FK follow toggle).  
- **`isQuad`** – Boolean flag for quad‑leg rigs (affects foot‑roll behavior).  
- **`ikHelperType`** – Shape of the IK control curve (e.g., cube, sphere).  
- **`constrainIK`** – If checked, the IK handle is constrained to the pole‑vector control.  
- **`placeIkAt`** – Optional joint/transform to place the IK control at.  
- **Helper attributes (`h_*`)** – Names of helper transforms created in *Helpers* mode:  
  - `h_fk1`, `h_fk2`, `h_fk3` – FK control helpers.  
  - `h_ik` – IK control helper.  
  - `h_polevector` – Pole‑vector helper.  
  - `h_options` – Options helper.  
  - `h_heel`, `h_side1`, `h_side2`, `h_foot`, `h_footroll` – Foot‑pivot helpers.  
  - `h_toe_ik`, `h_toe_fk` – Toe control helpers.

## Outputs  
- **`out_ikfkSwitch`** – PlusMinusAverage node driving the IK/FK blend.  
- **`out_ik1` / `out_ik2` / `out_ik3`** – IK joint chain (ankle, knee, hip).  
- **`out_fk1` / `out_fk2` / `out_fk3`** – FK joint chain.  
- **`out_fix3`** – Final fix joint used for IK stretch.  
- **`out_ikHandle`** – Main IK handle.  
- **`out_fix2_ikHandle`** – Secondary IK handle for stretch.  
- **`out_ikCtrl`** – IK control transform.  
- **`out_polevecCtrl`** – Pole‑vector control transform.  
- **`moduleInfo`** – `ModuleInfo` node exposing all key objects and attributes for downstream modules.  
- **Foot module outputs** (via `moduleInfo`): foot‑roll control, toe IK/FK controls, and the foot module’s own `moduleInfo` node.

## Usage  
1. **Set the joint chain** – Assign `joint1`–`joint5` to the hip, knee, ankle, toe base, and toe tip joints.  
2. **Generate helpers** – Switch `mode` to **Helpers** and run the module. Helper transforms (`h_*`) will be created under the *helpers* group.  
3. **Adjust helpers** – In the viewport, move and orient the helper controls to match the desired rig layout.  
4. **Build the rig** – Set `mode` to **Run** and execute. The module will create the FK/IK chain, foot‑roll system, stretch/soft‑IK nodes, and expose all objects via `moduleInfo`.  
5. **Connect downstream** – Use the `moduleInfo` node or individual output attributes to link this leg rig to other modules (e.g., hand, spine, or animation pipelines).  
6. **Optional settings** –  
   - Set `ikHelperType` to change the IK control shape.  
   - Enable `constrainIK` to lock the IK handle to the pole‑vector control.  
   - For quad rigs, set `isQuad` to true to adjust foot‑roll behavior.  
   - Use `placeIkAt` to position the IK control at a specific joint or transform.  

Follow these steps to quickly generate a robust, animatable leg rig that integrates seamlessly into larger character rigs.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "L_leg", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_3_joint"}]]></attr>
<attr name="joint4" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_4_joint"}]]></attr>
<attr name="joint5" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_5_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="fkNoFollow" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="isQuad" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_polevector_control_helper"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_options_control_helper"}]]></attr>
<attr name="h_toe_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_toe_ik_control_helper"}]]></attr>
<attr name="h_toe_fk" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_toe_fk_control_helper"}]]></attr>
<attr name="h_heel" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_heelPivot_helper"}]]></attr>
<attr name="h_toe" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_toePivot_helper"}]]></attr>
<attr name="h_side1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_side1Pivot_helper"}]]></attr>
<attr name="h_side2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_side2Pivot_helper"}]]></attr>
<attr name="h_footroll" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_footroll_control_helper"}]]></attr>
<attr name="h_foot" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_footPivot_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "L_leg_1_position_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="limb" muted="0" uid="d2e886c7fa894a018b74d0f9b00c62e5">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    scale = rig_utils.getDistance(joint1, joint3) / 10
    
    p1 = rig_utils.matrix.taxis(joint1.wm.get())
    p2 = rig_utils.matrix.taxis(joint2.wm.get())
    p3 = rig_utils.matrix.taxis(joint3.wm.get())
        
    planeTransform = pm.createNode("transform", n=@name + "_ik_plane_helper_transform", p=helpersParent)
    pm.pointConstraint(joint2, planeTransform)
    oc = pm.orientConstraint(joint1, joint2, planeTransform)
    oc.interpType.set(2) # shortest

    #polevector
    h_polevector = rig_utils.curve.makeCurve(@name + "_ik_polevector_control_helper", "sphere")    
    h_polevector.s.set([scale/2, scale/2, scale/2])
    planeTransform | h_polevector
    
    avg = (p1 - p2).normal() + (p3 - p2).normal()
    pm.xform(h_polevector, ws=True, t=p2 - avg.normal() * scale*3)
    rig_utils.lockTRS(h_polevector, [1,0,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_polevector, ty=-1)
    @set_h_polevector(h_polevector.name())

    # IK Control
    h_ik = rig_utils.curve.makeCurve(@name + "_ik_control_helper", @ikHelperType)    
    
    isLeg = any(map(lambda x:x in ["leg", "frontLeg", "backLeg", "leg_front", "leg_back"], @name.split("_")))    
    if isLeg:     
        h_ik_transform = pm.createNode("transform", n=@name + "_ik_control_helper_transform", p=helpersParent)
        pm.pointConstraint(joint3, h_ik_transform, sk=["y"])
        pm.orientConstraint(joint3, h_ik_transform, sk=["x", "z"], mo=True)
        h_ik_transform | h_ik
        pm.xform(h_ik, ws=True, t=[p3[0], 0, p3[2]]) # place on ground
        h_ik.s.set([scale, scale/5, scale*2])
        rig_utils.lockTRS(h_ik, [0,1,0], [1,0,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik, tx=-1, ry=-1)
    else:
        helpersParent | h_ik
        pm.parentConstraint(@placeIkAt or joint3, h_ik)
        h_ik.s.set([scale, scale, scale])
        rig_utils.lockTRS(h_ik, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik)
    @set_h_ik(h_ik.name())
    
    #options
    h_options = rig_utils.curve.makeCurve(@name + "_options_control_helper", "flag")
    h_options.s.set([scale, scale, scale])
    planeTransform | h_options
    h_options.t.set([0,0,0])
    pm.orientConstraint(helpersParent, h_options, mo=True)
    rig_utils.lockTRS(h_options, [0,1,0], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_options(h_options.name()) 
    
    # position
    h_position = rig_utils.curve.makeCurve(@name + "_position_control_helper", "axis")
    helpersParent | h_position
    h_position.s.set([scale/2.0, scale/2.0, scale/2.0])
    pm.pointConstraint(joint1, h_position)
    rig_utils.lockTRS(h_position, [1,1,1], [], [])
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_position(h_position.name())     

    # FK
    h_fk1 = rig_utils.curve.makeCurve(@name + "_fk_1_control_helper", "circle")
    h_fk2 = rig_utils.curve.makeCurve(@name + "_fk_2_control_helper", "circle")
    h_fk3 = rig_utils.curve.makeCurve(@name + "_fk_3_control_helper", "circle")

    for j, h in [(joint1, h_fk1), (joint2, h_fk2), (joint3, h_fk3)]:
        helpersParent | h
        h.s.set([scale, scale, scale])
        
        pc = pm.parentConstraint(j, h)
        pc.target[0].targetOffsetRotate.set([0,0,90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h)

    @set_h_fk1(h_fk1.name())
    @set_h_fk2(h_fk2.name())
    @set_h_fk3(h_fk3.name())

if @mode == 1:  # run
    jointsParent = joint1.getParent()

    h_fk1 = pm.PyNode(@h_fk1)
    h_fk2 = pm.PyNode(@h_fk2)
    h_fk3 = pm.PyNode(@h_fk3)
    h_ik = pm.PyNode(@h_ik)
    h_polevector = pm.PyNode(@h_polevector)
    h_options = pm.PyNode(@h_options)
    h_position = pm.PyNode(@h_position) if pm.objExists(@h_position) else None

    # controls and joints groups
    controls_grp = pm.createNode("transform", n=@name + "_controls_group", p=controlsParent)

    internal_grp = pm.createNode("transform", n=@name + "_internal_group", p=internalParent)
    internal_grp.v.set(False)
    
    rig_utils.lockTRS(controls_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internal_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)

    others_grp = pm.createNode("transform", n=@name + "_others_group", p=othersParent)

    # options control
    options_ctrl = pm.createNode("transform", n=@name + "_options_control", p=controls_grp)
    pm.parentConstraint(joint1, options_ctrl)

    rig_utils.curve.makeFromCurve(options_ctrl, h_options)

    options_ctrl.addAttr("ikfk", at="float", min=0, max=1, k=True)
    options_ctrl.addAttr("scaleFactor1x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor2x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor3x", at="float", min=0.1, dv=1, k=True)
    
    for i, j in enumerate([joint1, joint2, joint3]):
        a = f"scaleFactor{i+1}"
        options_ctrl.addAttr(a, min=0.01, dv=1.0, k=True)
        if i == 2:
            md = pm.createNode("multiplyDivide", n=j+"_scaleFactor_multiplyDivide")
            options_ctrl.attr(a) >> md.input1X
            options_ctrl.attr(a) >> md.input1Y
            options_ctrl.attr(a) >> md.input1Z
            options_ctrl.scaleFactor3x >> md.input2X
            md.output >> j.s
        else:
            options_ctrl.attr(a) >> j.sx
            options_ctrl.attr(a) >> j.sy
            options_ctrl.attr(a) >> j.sz

    rig_utils.lockTRS(options_ctrl, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)
    
    # ikfk switch
    ikfk_rev = pm.createNode("reverse", n=@name + "_ikfk_reverse")
    options_ctrl.ikfk >> ikfk_rev.inputX

    # bones start position control
    positionCtrl = None
    if h_position:
        options_ctrl.addAttr("positionControl", at="bool", dv=False)
        rig_utils.lockAttr(options_ctrl.positionControl, 0.5)    
        
        positionTransform = pm.createNode("transform", n=@name + "_1_position_control_transform", p=controls_grp)
        pm.matchTransform(positionTransform, jointsParent)
        pm.matchTransform(positionTransform, joint1, position=True, rotation=False)
        options_ctrl.positionControl >> positionTransform.v
        
        if jointsParent:
            pm.parentConstraint(jointsParent, positionTransform, mo=True)
        
        positionCtrl = pm.createNode("transform", n=@name + "_1_position_control", p=positionTransform)
        pm.matchTransform(positionCtrl, joint1, position=True, rotation=False)        
        
        rig_utils.curve.makeFromCurve(positionCtrl, h_position)
        rig_utils.lockTRS(positionCtrl, [])
        
    # IK chain
    ik1 = rig_utils.matchJoint(joint1, @name + "_ik_1_joint")
    ik2 = rig_utils.matchJoint(joint2, @name + "_ik_2_joint")
    ik3 = rig_utils.matchJoint(joint3, @name + "_ik_3_joint")
    internal_grp | ik1 | ik2 | ik3
    
    pm.parentConstraint(positionCtrl or jointsParent, ik1, mo=True, skipRotate=["x", "y", "z"]) # pointConstraint

    # FIX
    fix1 = rig_utils.matchJoint(joint1, @name + "_fix_1_joint")
    fix2 = rig_utils.matchJoint(joint2, @name + "_fix_2_joint")
    fix3 = rig_utils.matchJoint(joint3, @name + "_fix_3_joint")

    internal_grp | fix1 | fix2 | fix3

    pm.pointConstraint(ik1, fix1)

    # FK
    fk1 = rig_utils.matchJoint(joint1, @name + "_fk_1_joint")
    fk2 = rig_utils.matchJoint(joint2, @name + "_fk_2_joint")
    fk3 = rig_utils.matchJoint(joint3, @name + "_fk_3_joint")
    internal_grp | fk1 | fk2 | fk3

    # FK controls
    # fk1
    fk1_ctrl = pm.createNode("transform", n=@name + "_fk_1_control", p=controls_grp)  
    pm.matchTransform(fk1_ctrl, joint1)
    rig_utils.curve.makeFromCurve(fk1_ctrl, h_fk1)
    pm.parentConstraint(positionCtrl or jointsParent, fk1_ctrl, sr=["x","y","z"], mo=True)

    switcher.addFollow(fk1_ctrl, controls_grp, jointsParent, attr="followBody", default=0.0, type="orient")
    
    rig_utils.setToOffsetParentMatrix(fk1_ctrl)
    options_ctrl.ikfk >> fk1_ctrl.v
    rig_utils.lockTRS(fk1_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.parentConstraint(fk1_ctrl, fk1)
    
    # fk2
    fk2_ctrl = pm.createNode("transform", n=@name + "_fk_2_control", p=fk1_ctrl)
    pm.matchTransform(fk2_ctrl, joint2)
    pm.pointConstraint(fk2, fk2_ctrl)
    rig_utils.setToOffsetParentMatrix(fk2_ctrl)

    rig_utils.curve.makeFromCurve(fk2_ctrl, h_fk2)    
    rig_utils.lockTRS(fk2_ctrl, [1, 1, 1], [1, 1, 0], [1, 1, 1], 1)
    
    pm.orientConstraint(fk2_ctrl, fk2)
    
    # fk3
    fk3_ctrl = pm.createNode("transform", n=@name + "_fk_3_control", p=fk2_ctrl)
    pm.matchTransform(fk3_ctrl, joint3)
    pm.pointConstraint(fk3, fk3_ctrl)
    rig_utils.setToOffsetParentMatrix(fk3_ctrl)

    rig_utils.curve.makeFromCurve(fk3_ctrl, h_fk3)
    rig_utils.lockTRS(fk3_ctrl, [1, 1, 1], [], [1, 1, 1], 1)

    pm.orientConstraint(fk3_ctrl, fk3)
    
    # FIX IK handles
    fix_ikHandle1 = pm.ikHandle(startJoint=fix1,
                                endEffector=fix2,
                                solver="ikSCsolver",
                                n=@name + "_fix_1_ikHandle")[0]
    internal_grp | fix_ikHandle1

    fix_ikHandle2 = pm.ikHandle(startJoint=fix2,
                                endEffector=fix3,
                                solver="ikSCsolver",
                                n=@name + "_fix_2_ikHandle")[0]
    internal_grp | fix_ikHandle2    
    
    # IK handle
    ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik3, solver="ikRPsolver", n=@name + "_ikHandle")[0]
    internal_grp | ikHandle

    # IK control
    ik_ctrl = pm.createNode("joint", n=@name + "_ik_control", p=controls_grp)

    ik_ctrl.radius.set(0)
    rig_utils.lockAttr(ik_ctrl.radius, 1)
    
    pm.matchTransform(ik_ctrl, @placeIkAt or ik3, position=True, rotation=False)

    rig_utils.setToOffsetParentMatrix(ik_ctrl)
    
    if pm.objExists(@lastCtrlOrient):
        pm.matchTransform(ik_ctrl, @lastCtrlOrient, position=False, rotation=True)    
        rig_utils.freezeJoints([ik_ctrl])

    rig_utils.curve.makeFromCurve(ik_ctrl, h_ik)
    ikfk_rev.outputX >> ik_ctrl.v

    dynamicParent.makeDynamicParent(ik_ctrl, ik_ctrl)

    rig_utils.lockTRS(ik_ctrl, [], [], [1, 1, 1], 1)

    # IK polevector control
    polevec_follow_j1 = rig_utils.matchJoint(joint1, @name + "_ik_polevector_follow_1_joint")
    polevec_follow_j2 = rig_utils.matchJoint(joint3, @name + "_ik_polevector_follow_2_joint")
    internal_grp | polevec_follow_j1 | polevec_follow_j2    
    
    polevec_follow_ikHandle = pm.ikHandle(sj=polevec_follow_j1, ee=polevec_follow_j2, solver="ikSCsolver")[0]
    polevec_follow_ikHandle.rename(@name+"_ik_polevector_follow_ikHandle")
    internal_grp | polevec_follow_ikHandle
    
    pm.parentConstraint(ik_ctrl, polevec_follow_ikHandle, mo=True)
    pm.pointConstraint(ik1, polevec_follow_j1)
    
    polevec_ctrl = pm.createNode("transform", n=@name + "_ik_polevector_control", p=controls_grp)
    pm.matchTransform(polevec_ctrl, h_polevector, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(polevec_ctrl)    

    switcher.addFollow(polevec_ctrl, internal_grp, polevec_follow_j1, attr="follow", default=0.0, type="parent")
    
    polevec_ctrl.addAttr("snap", min=0, max=1, k=True)
    polevec_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    polevec_ctrl.stretch.set(0)

    rig_utils.curve.makeFromCurve(polevec_ctrl, h_polevector)
    
    ikfk_rev.outputX >> polevec_ctrl.v
    
    rig_utils.lockTRS(polevec_ctrl, [], [1, 1, 1], [1, 1, 1], 1)

    pm.pointConstraint(polevec_ctrl, fix_ikHandle1)  # snap fix1-fix2
    
    if @constrainIK:
        pm.pointConstraint(ik_ctrl, fix_ikHandle2)  # snap fix2-fix3    

    dynamicParent.makeDynamicParent(polevec_ctrl, polevec_ctrl)

    rig_utils.makeHelpLine(
        @name + "_polevector", 
        [polevec_ctrl, joint2],
        visibleAttr=ikfk_rev.outputX,
        parent=others_grp)

    ik_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    ik_ctrl.stretch.set(0)

    dFix1 = rig_utils.createDistance(@name + "_fix_1_distance", fix1, polevec_ctrl)
    dFix2 = rig_utils.createDistance(@name + "_fix_2_distance", fix2, ik_ctrl)
    d = rig_utils.createDistance(@name + "_ik_distance", ik1, ik_ctrl)

    ik2_tx_scaleMult = pm.createNode("multDL", n=ik2 + "_tx_scaleFactor1x_multDL")
    ik2_tx_scaleMult.input1.set(abs(ik2.tx.get()))
    options_ctrl.scaleFactor1x >> ik2_tx_scaleMult.input2

    ik3_tx_scaleMult = pm.createNode("multDL", n=ik3 + "_tx_scaleFactor2x_multDL")
    ik3_tx_scaleMult.input1.set(abs(ik3.tx.get()))
    options_ctrl.scaleFactor2x >> ik3_tx_scaleMult.input2

    ik2ik3_tx_sumAdd = pm.createNode("addDL", n=@name + "_ik_sum_tx_addDL")
    ik2_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input1
    ik3_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input2

    sFix1 = rig_utils.makeStretchable(
        @name + "_fix_1", 
        [fix1],
        dFix1, 
        polevec_ctrl.stretch,
        0.01, 0,
        ik2_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    sFix2 = rig_utils.makeStretchable(
        @name + "_fix_2", 
        [fix2],
        dFix2,
        ik_ctrl.stretch,
        0.01,
        0,
        ik3_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    s = rig_utils.makeStretchable(
        @name + "_ik", 
        [ik1, ik2],
        d,
        ik_ctrl.stretch,
        1,
        0,
        ik2ik3_tx_sumAdd.output,
        scales=[True, False, False],  
        useTx=False)

    # softIK
    ik_ctrl.addAttr("softIK", min=0, max=0.5, dv=0.05, k=True)

    ac_x = rig_utils.anim.createSoftIKAnimCurve(@name + "_softIK")

    stretchX = pm.PyNode(@name + "_ik_stretch_x_blendTwoAttr")
    cond = pm.PyNode(@name + "_ik_squash_condition")

    stretchX.output >> ac_x.input

    softIk_switch = pm.createNode("multDL", n=@name + "_softIK_switch_multDL")
    ik_ctrl.softIK >> softIk_switch.input1
    ik_ctrl.stretch >> softIk_switch.input2

    softIk_b2a = pm.createNode("blendTwoAttr", n=@name + "_softIK_blendTwoAttr")
    softIk_switch.output >> softIk_b2a.attributesBlender
    stretchX.output >> softIk_b2a.i[0]
    ac_x.output >> softIk_b2a.i[1]

    softIk_b2a.output >> cond.firstTerm
    softIk_b2a.output >> cond.colorIfTrueR

    # fk stretch with scaleFactor
    fk2_scaleFactor_mult = pm.createNode("multDL", n=fk2 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor1x >> fk2_scaleFactor_mult.input1
    fk2_scaleFactor_mult.input2.set(fk2.tx.get())
    fk2_scaleFactor_mult.output >> fk2.tx
    
    fk3_scaleFactor_mult = pm.createNode("multDL", n=fk3 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor2x >> fk3_scaleFactor_mult.input1
    fk3_scaleFactor_mult.input2.set(fk3.tx.get())
    fk3_scaleFactor_mult.output >> fk3.tx

    # ik stretch
    multIK1 = pm.createNode("multiplyDivide", n=ik1 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK1.input1X
    options_ctrl.scaleFactor1x >> multIK1.input2X

    multIK2 = pm.createNode("multiplyDivide", n=ik2 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK2.input1X
    options_ctrl.scaleFactor2x >> multIK2.input2X

    multFIX1 = pm.createNode("multiplyDivide", n=fix1 + "_scaleFactor_multiplyDivide")
    sFix1[0] >> multFIX1.input1X
    options_ctrl.scaleFactor1x >> multFIX1.input2X
    multFIX1.outputX >> fix1.sx

    multFIX2 = pm.createNode("multiplyDivide", n=fix2 + "_scaleFactor_multiplyDivide")
    sFix2[0] >> multFIX2.input1X
    options_ctrl.scaleFactor2x >> multFIX2.input2X
    multFIX2.outputX >> fix2.sx

    b2a = pm.createNode("blendTwoAttr", n=ik1 + "_stretch_x_blendTwoAttr")
    multIK1.outputX >> b2a.i[0]
    multFIX1.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik1.sx

    b2a = pm.createNode("blendTwoAttr", n=ik2 + "_stretch_x_blendTwoAttr")
    multIK2.outputX >> b2a.i[0]
    multFIX2.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik2.sx

    defPolevec = pm.createNode("transform", n=polevec_ctrl + "_default_transform")
    pm.matchTransform(defPolevec, h_polevector, position=True, rotation=False)
    pm.parent(defPolevec, fk2)

    pm.poleVectorConstraint(polevec_ctrl, ikHandle)

    if @constrainIK:
        pc = pm.pointConstraint(ik_ctrl, fix3, ikHandle)

        snap_rev = pm.createNode("reverse", n=@name + "_ik_snap_reverse")
        polevec_ctrl.snap >> snap_rev.inputX

        snap_rev.outputX >> pc.w0
        polevec_ctrl.snap >> pc.w1

        pm.orientConstraint(ik_ctrl, ik3, mo=True)

    # blend IKFK constraints
    for j, ikj, fkj in [(joint1, ik1, fk1), (joint2, ik2, fk2), (joint3, ik3, fk3)]:
        oc = pm.parentConstraint(ikj, fkj, j)
        oc.interpType.set(2)
        ikfk_rev.outputX >> oc.w0
        options_ctrl.ikfk >> oc.w1
        
    # ModuleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@name + "_limb")
    moduleInfo.setAttr("type", "limb")

    moduleInfo.setAttr("options", options_ctrl.message)
    moduleInfo.setAttr("ikfk", options_ctrl.ikfk)    
    moduleInfo.setAttr("snap", polevec_ctrl.snap)     
    moduleInfo.setAttr("ik1_joint", ik1.message)
    moduleInfo.setAttr("ik2_joint", ik2.message)
    moduleInfo.setAttr("ik3_joint", ik3.message)
    moduleInfo.setAttr("fk1_joint", fk1.message)
    moduleInfo.setAttr("fk2_joint", fk2.message)
    moduleInfo.setAttr("fk3_joint", fk3.message)    
    moduleInfo.setAttr("ik", ik_ctrl.message)
    moduleInfo.setAttr("polevector", polevec_ctrl.message)
    moduleInfo.setAttr("fk1", fk1_ctrl.message)
    moduleInfo.setAttr("fk2", fk2_ctrl.message)
    moduleInfo.setAttr("fk3", fk3_ctrl.message)

    # seamless
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk1", fk1_ctrl, ik1)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk2", fk2_ctrl, ik2)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk3", fk3_ctrl, ik3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "ik", ik_ctrl, fk3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "polevector", polevec_ctrl, defPolevec)
]]></run>
<doc><![CDATA[## Summary  
The **L_arm** module creates a fully functional IK/FK arm rig. It first generates placement helpers (IK plane, pole‑vector, IK and FK controls) in *Helpers* mode, then builds the rig in *Run* mode, adding an IK/FK switch, pole‑vector controller, stretch and soft‑IK logic, and exposes all key objects through a `ModuleInfo` node for downstream use.

## Inputs  
- **mode** – Selects *Helpers* (0) or *Run* (1).  
- **name** – Base name for all generated nodes.  
- **joint1 / joint2 / joint3** – Target joint names forming the arm chain.  
- **lastCtrlOrient** – Optional joint used to orient the final IK control.  
- **ikHelperType** – Shape of the IK control curve (e.g., cube, sphere).  
- **constrainIK** – Boolean to enable optional IK‑to‑fix constraints.  
- **placeIkAt** – Optional transform to position the IK control at start.

## Outputs  
- **h_fk1 / h_fk2 / h_fk3** – FK helper curves.  
- **h_ik** – IK helper curve.  
- **h_polevector** – Pole‑vector helper curve.  
- **h_options** – Options helper curve.  
- **out_ikfkSwitch** – PlusMinusAverage node driving the IK/FK blend.  
- **out_ik1 / out_ik2 / out_ik3** – IK joint chain.  
- **out_fk1 / out_fk2 / out_fk3** – FK joint chain.  
- **out_fix3** – Third fix joint for optional constraints.  
- **out_ikHandle** – Main IK handle.  
- **out_fix2_ikHandle** – Secondary IK handle for fix joints.  
- **out_ikCtrl** – IK control joint.  
- **out_polevecCtrl** – Pole‑vector control.  
- **moduleInfo** – `ModuleInfo` node exposing rig type, joints, controls, and switch attributes.

## Usage  
1. **Set Target Joints** – Assign `joint1`, `joint2`, and `joint3` to the arm’s shoulder, elbow, and wrist joints.  
2. **Generate Helpers** – Set `mode` to **Helpers** and run. The module will create placement helpers under the *Helpers* parent, scaled to the joint spacing. Adjust their positions and orientations in the viewport.  
3. **Configure Optional Settings** –  
   - Choose an `ikHelperType` shape.  
   - Toggle `constrainIK` if you need the IK control to drive the fix joints.  
   - If desired, set `placeIkAt` to a transform that will be used as the IK control’s base position.  
4. **Build the Rig** – Switch `mode` to **Run** and execute. The module will create the full FK/IK chain, IK/FK switch, pole‑vector controller, stretch and soft‑IK systems, and lock/unlock attributes appropriately.  
5. **Connect to Other Modules** – Use the `moduleInfo` node or the individual output attributes (`out_ikCtrl`, `out_polevecCtrl`, `out_fk1`, etc.) to link this arm rig to downstream modules such as hand, fingers, or other limb systems.  
6. **Mirror or Duplicate** – The helper attributes (`h_fk1`, `h_fk2`, `h_fk3`, `h_ik`, `h_polevector`, `h_options`) can be mirrored or reused for building a symmetrical arm.  

The module automatically handles mirroring, dynamic parenting, and provides a clean interface for further customization or integration into larger rigging pipelines.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect="/name"><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "L_leg", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect="/joint1"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect="/joint2"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect="/joint3"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_3_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect="/lastCtrlOrient"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="ikHelperType" template="comboBox" category="Others" connect=""><![CDATA[{"current": "cube", "items": ["arc", "axis", "axisSphere", "cube", "circle", "diamond", "pyramid", "rect", "sphere", "triangle"], "default": "current"}]]></attr>
<attr name="constrainIK" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="placeIkAt" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect="/h_fk1"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect="/h_fk2"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect="/h_fk3"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect="/h_ik"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect="/h_polevector"><![CDATA[{"value": "L_leg_ik_polevector_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect="/h_options"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "L_leg_options_control_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect="/h_position"><![CDATA[{"value": "L_leg_1_position_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="foot" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

mode = ch("../mode")
name = ch("../name")
lastCtrlOrient = ch("../lastCtrlOrient")
isQuad = False

j1 = pm.PyNode(ch("../joint3"))
j2 = pm.PyNode(ch("../joint4"))
j3 = pm.PyNode(ch("../joint5"))

internalParent = pm.PyNode("internal")
controlsParent = pm.PyNode("controls")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if mode == 0:  # helpers
    scale = rig_utils.getDistance(j1, j3) / 2.0
    smallScale = scale / 5.0
    p1 = pm.xform(j1, ws=True, q=True, t=True)
    p2 = pm.xform(j2, ws=True, q=True, t=True)
    p3 = pm.xform(j3, ws=True, q=True, t=True)   
    
    pivots_null = pm.PyNode(name + "_ik_control_helper_null")
    
    h_heel = rig_utils.curve.makeCurve(name+"_heelPivot_helper", "axis")
    pm.xform(h_heel, ws=True, t=[p1[0], 0, p1[2]-scale])
    h_heel.s.set([smallScale, smallScale, smallScale])    
    pivots_null | h_heel    
    rig_utils.lockTRS(h_heel, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_heel, tx=-1)
    chset("../h_heel", h_heel.name())

    h_side1 = rig_utils.curve.makeCurve(name+"_side1Pivot_helper", "axis")
    pm.xform(h_side1, ws=True, t=[p2[0]+scale/2, 0, p2[2]])
    h_side1.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_side1
    rig_utils.lockTRS(h_side1, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_side1, tx=-1)
    chset("../h_side1", h_side1.name())

    h_side2 = rig_utils.curve.makeCurve(name+"_side2Pivot_helper", "axis")
    pm.xform(h_side2, ws=True, t=[p2[0]-scale/2, 0, p2[2]])
    h_side2.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_side2
    rig_utils.lockTRS(h_side2, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_side2, tx=-1)
    chset("../h_side2", h_side2.name())

    h_toe = rig_utils.curve.makeCurve(name+"_toePivot_helper", "axis")
    pm.xform(h_toe, ws=True, t=[p3[0], 0, p3[2]+scale/2])
    h_toe.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_toe
    rig_utils.lockTRS(h_toe, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_toe, tx=-1)
    chset("../h_toe", h_toe.name())

    h_foot = rig_utils.curve.makeCurve(name+"_footPivot_helper", "axis")
    pm.xform(h_foot, ws=True, t=[p2[0], 0, p2[2]])
    h_foot.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_foot
    rig_utils.lockTRS(h_foot, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_foot, tx=-1)
    chset("../h_foot", h_foot.name())

    h_footroll = rig_utils.curve.makeCurve(name+"_footroll_control_helper", "sphere")    
    pm.parentConstraint(j1, h_footroll)
    
    h_footroll.s.set([scale, scale, scale])
    helpersParent | h_footroll
    rig_utils.lockTRS(h_footroll, [1,1,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_footroll)
    chset("../h_footroll", h_footroll.name())
    
    toes_transform = pm.createNode("transform", n=name+"_toes_helpers_transform", p=helpersParent)
    pm.parentConstraint(j2, toes_transform)
    
    for label in ["toe_ik", "toe_fk"]:
        h = rig_utils.curve.makeCurve(name+"_"+label+"_control_helper", "circle")
        toes_transform | h
        h.t.set([0,0,0])
        h.r.set([0,0,90])
        h.s.set([scale, scale, scale])
        rig_utils.lockTRS(h, [1,1,1], [1,1,0], [], 1)
        rig_utils.connectFromSymmetric(h)
        chset("../h_"+label, h.name())
        
elif mode == 1:  # run
    h_footroll = pm.PyNode(ch("../h_footroll"))
    h_toe_ik = pm.PyNode(ch("../h_toe_ik"))
    h_toe_fk = pm.PyNode(ch("../h_toe_fk"))
    h_heel = pm.PyNode(ch("../h_heel"))
    h_toe = pm.PyNode(ch("../h_toe"))
    h_foot = pm.PyNode(ch("../h_foot"))
    h_side1 = pm.PyNode(ch("../h_side1"))
    h_side2 = pm.PyNode(ch("../h_side2"))
    if h_side2.tx > h_side1.tx: # side1.tx must be > side2.tx
        h_side1, h_side2 = h_side2, h_side1

    limb_ikHandle = pm.PyNode(name+"_ikHandle")
    limb_options_ctrl = pm.PyNode(name+"_options_control")
    limb_ikfk_rev = pm.PyNode(name+"_ikfk_reverse")
    limb_ik3 = pm.PyNode(name+"_ik_3_joint")
    limb_fk3 = pm.PyNode(name+"_fk_3_joint")
    limb_fk3_ctrl = pm.PyNode(name+"_fk_3_control")
    limb_fix3 = pm.PyNode(name+"_fix_3_joint")
    limb_ik_ctrl = pm.PyNode(name+"_ik_control")
    limb_polevecCtrl = pm.PyNode(name+"_ik_polevector_control")
    limb_moduleInfo = pm.PyNode(name+"_limb_moduleInfo")

    internal_grp = pm.PyNode(name+"_internal_group")
    controls_grp = pm.PyNode(name+"_controls_group")

    # IK chain
    ik1 = limb_ik3  # get the last ik joint(ankle) in limb template

    ik2 = rig_utils.matchJoint(j2, name=name+"_ik_4_joint")
    ik3 = rig_utils.matchJoint(j3, name=name+"_ik_5_joint")
    ik1 | ik2 | ik3

    # FK Chain FK controls
    fk1 = limb_fk3  # get the last fk joint(ankle) in limb template

    fk2 = rig_utils.matchJoint(j2, name=name+"_fk_4_joint")
    fk3 = rig_utils.matchJoint(j3, name=name+"_fk_5_joint")
    fk1 | fk2 | fk3

    # toe FK
    toe_fk_transform = pm.createNode("transform", n=name+"_toe_fk_control_transform", p=limb_fk3_ctrl)
    pm.pointConstraint(fk2, toe_fk_transform)
    pm.orientConstraint(fk1, toe_fk_transform)
    
    toe_fk_ctrl = pm.createNode("transform", n=name+"_toe_fk_control", p=toe_fk_transform)
    rig_utils.curve.makeFromCurve(toe_fk_ctrl, h_toe_fk)
    rig_utils.lockTRS(toe_fk_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(toe_fk_ctrl, fk2, mo=True)

    tmpOrientTransform = pm.createNode("transform")
    if pm.objExists(lastCtrlOrient):
        pm.matchTransform(tmpOrientTransform, pm.PyNode(lastCtrlOrient), position=False, rotation=True)

    # main aux joint start at ankle
    aux1 = pm.createNode("joint", n=name+"_aux_1_joint")
    pm.matchTransform(aux1, tmpOrientTransform)
    pm.matchTransform(aux1, j1, position=True, rotation=False)
    aux1.v.set(0)
    internal_grp | aux1

    # heel land pivot
    aux2 = pm.createNode("joint", n=name+"_aux_2_joint")
    pm.matchTransform(aux2, tmpOrientTransform)
    pm.matchTransform(aux2, h_heel, position=True, rotation=False)
    aux1 | aux2

    # toe pivot
    aux3 = pm.createNode("joint", n=name+"_aux_3_joint")
    pm.matchTransform(aux3, tmpOrientTransform)
    pm.matchTransform(aux3, h_foot, position=True, rotation=False)
    aux2 | aux3

    # left side pivot
    aux4 = pm.createNode("joint", n=name+"_aux_4_joint")
    pm.matchTransform(aux4, tmpOrientTransform)
    pm.matchTransform(aux4, h_side1, position=True, rotation=False)
    aux3 | aux4

    # right side  pivot
    aux5 = pm.createNode("joint", n=name+"_aux_5_joint")
    pm.matchTransform(aux5, tmpOrientTransform)
    pm.matchTransform(aux5, h_side2, position=True, rotation=False)
    aux4 | aux5

    #toe 2 pivot
    aux6 = pm.createNode("joint", n=name+"_aux_6_joint")
    pm.matchTransform(aux6, tmpOrientTransform)
    pm.matchTransform(aux6, h_foot, position=True, rotation=False)
    aux5 | aux6

    # foot pivot
    aux7 = pm.createNode("joint", n=name+"_aux_7_joint")
    pm.matchTransform(aux7, tmpOrientTransform)
    pm.matchTransform(aux7, h_toe, position=True, rotation=False)
    aux6 | aux7

    # foot pivot
    aux8 = pm.createNode("joint", n=name+"_aux_8_joint")
    pm.matchTransform(aux8, tmpOrientTransform)
    pm.matchTransform(aux8, j3, position=True, rotation=False)
    aux7 | aux8

    # toe pivot
    aux9 = pm.createNode("joint", n=name+"_aux_9_joint")
    pm.matchTransform(aux9, tmpOrientTransform)
    pm.matchTransform(aux9, j2, position=True, rotation=False)
    aux8 | aux9

    # ankle pivot
    aux10 = pm.createNode("joint", n=name+"_aux_10_joint")
    pm.matchTransform(aux10, tmpOrientTransform)
    pm.matchTransform(aux10, j1, position=True, rotation=False)
    aux9 | aux10

    # toe pivot
    auxToe1 = pm.createNode("joint", n=name+"_auxToe_1_joint")
    pm.matchTransform(auxToe1, tmpOrientTransform)
    pm.matchTransform(auxToe1, j2, position=True, rotation=False)
    aux8 | auxToe1

    #toe end pivot
    auxToe2 = pm.createNode("joint", n=name+"_auxToe_2_joint")
    pm.matchTransform(auxToe2, tmpOrientTransform)
    pm.matchTransform(auxToe2, j3, position=True, rotation=False)
    auxToe1 | auxToe2

    rig_utils.freezeJoints([aux1, aux2, aux3, aux4, aux5, aux6, aux7, aux8, aux9, aux10, auxToe1, auxToe2])

    # set limits
    aux2.setLimited(aux2.LimitType.rotateMaxX, True)
    aux2.setLimit(aux2.LimitType.rotateMaxX, 0)

    aux4.setLimited(aux4.LimitType.rotateMaxZ, True)
    aux4.setLimit(aux4.LimitType.rotateMaxZ, 0)

    aux5.setLimited(aux5.LimitType.rotateMinZ, True)
    aux5.setLimit(aux5.LimitType.rotateMinZ, 0)

    aux6.setLimited(aux6.LimitType.rotateMinX, True)
    aux6.setLimit(aux6.LimitType.rotateMinX, 0)

    aux7.setLimited(aux7.LimitType.rotateMinX, True)
    aux7.setLimit(aux7.LimitType.rotateMinX, 0)

    aux9.setLimited(aux9.LimitType.rotateMinX, True)
    aux9.setLimit(aux9.LimitType.rotateMinX, 0)

    ##IK handles
    toe_ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik2, solver="ikSCsolver", n=name+"_toe_ikHandle")[0]
    foot_ikHandle = pm.ikHandle(startJoint=ik2, endEffector=ik3, solver="ikSCsolver", n=name+"_foot_ikHandle")[0]
    toe_ikHandle.v.set(0)
    foot_ikHandle.v.set(0)
    aux10 | toe_ikHandle
    auxToe1 | foot_ikHandle

    # foot snap
    fix = pm.PyNode(name+"_fix_2_ikHandle")
    pm.delete(fix.listRelatives(type="pointConstraint"))
    pm.pointConstraint(aux10, fix)
   
    snap_rev = pm.createNode("reverse", n=name+"_snap_reverse")
    limb_polevecCtrl.snap >> snap_rev.inputX

    pc = pm.pointConstraint(aux10, limb_fix3, limb_ikHandle)
    snap_rev.outputX >> pc.w0
    limb_polevecCtrl.snap >> pc.w1

    # footroll control
    footroll_ctrl = pm.createNode("transform", n=name+"_footroll_control", p=limb_ik_ctrl)
    pm.matchTransform(footroll_ctrl, tmpOrientTransform)
    pm.pointConstraint(aux10, footroll_ctrl)

    rig_utils.curve.makeFromCurve(footroll_ctrl, h_footroll)

    footroll_ctrl.addAttr("weight", at="float", min=0, max=1, dv=0, k=True)
    footroll_ctrl.addAttr("angle", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("heelPivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("footPivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("toePivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("anklePivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("freeHeel", at="bool", dv=False, k=False)

    rig_utils.lockTRS(footroll_ctrl, [1, 1, 1], [0, 1, 0], [1, 1, 1], 1)

    #Footroll utility nodes setup
    footroll_ctrl.heelPivot >> aux2.ry
    footroll_ctrl.footPivot >> aux3.ry
    footroll_ctrl.toePivot >> aux7.ry

    if not isQuad:
        footroll_ctrl.rx >> aux2.rx
    else:
        b2a = pm.createNode("blendTwoAttr", n=aux2+"_blendWeighted")
        footroll_ctrl.weight >> b2a.attributesBlender
        b2a.i[0].set(0)
        footroll_ctrl.rx >> b2a.i[1]
        b2a.output >> aux2.rx

    footroll_ctrl.rz >> aux4.rz
    footroll_ctrl.rz >> aux5.rz

    freeHeelRev = pm.createNode("reverse", n=footroll_ctrl+"_freeHeel_reverse")
    footroll_ctrl.freeHeel >> freeHeelRev.inputX
    freeHeelRev.outputX >> aux9.minRotXLimitEnable

    freeHeelCond = pm.createNode("condition", n=footroll_ctrl+"_freeHeel_condition")
    footroll_ctrl.weight >> freeHeelCond.firstTerm
    freeHeelCond.colorIfFalseR.set(0)
    footroll_ctrl.freeHeel >> freeHeelCond.colorIfTrueR
    freeHeelCond.outColorR >> aux2.minRotXLimitEnable

    plus = pm.createNode("plusMinusAverage", n=aux7+"_plusMinusAverage")
    plus.operation.set(2)  # -
    footroll_ctrl.rx >> plus.input1D[0]
    aux6.rx >> plus.input1D[1]

    b2a = pm.createNode("blendTwoAttr", n=aux7+"_blendWeighted")
    footroll_ctrl.weight >> b2a.attributesBlender
    b2a.i[0].set(0)
    plus.output1D >> b2a.i[1]
    b2a.output >> aux7.rx

    b2a = pm.createNode("blendTwoAttr", n=aux9+"_blendWeighted")
    footroll_ctrl.weight >> b2a.attributesBlender
    footroll_ctrl.rx >> b2a.i[0]
    b2a.i[1].set(0)
    b2a.output >> aux9.rx
    footroll_ctrl.anklePivot >> aux9.rz

    cond = pm.createNode("condition", n=aux6+"_condition")
    cond.operation.set(4)  # <
    footroll_ctrl.rx >> cond.firstTerm
    footroll_ctrl.angle >> cond.secondTerm
    footroll_ctrl.rx >> cond.colorIfTrueR
    footroll_ctrl.angle >> cond.colorIfFalseR
    cond.outColorR >> aux6.rx

    ##Toe IK control
    toe_ik_transform = pm.createNode("transform", n=name+"_toe_ik_control_transform", p=limb_ik_ctrl)
    pm.pointConstraint(aux9, toe_ik_transform)
    pm.orientConstraint(aux8, toe_ik_transform)
    
    toe_ik_ctrl = pm.createNode("transform", n=name+"_toe_ik_control", p=toe_ik_transform)

    rig_utils.curve.makeFromCurve(toe_ik_ctrl, h_toe_ik)
    rig_utils.lockTRS(toe_ik_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(toe_ik_ctrl, auxToe1)
    
    oc = pm.orientConstraint(ik2, fk2, j2)
    oc.interpType.set(2)
    limb_ikfk_rev.outputX >> oc.w0
    limb_options_ctrl.ikfk >> oc.w1

    pm.pointConstraint(limb_ik_ctrl, aux1, mo=True)
    pm.orientConstraint(limb_ik_ctrl, aux1, mo=True)
    
    # fix stretch
    aux10.pm >> pm.PyNode(name+"_fix_2_distance_multMatrix").matrixIn[0]
    aux10.t >> pm.PyNode(name+"_fix_2_distance_distanceBetween").point2

    aux10.pm >> pm.PyNode(name+"_ik_distance_multMatrix").matrixIn[0]
    aux10.t >> pm.PyNode(name+"_ik_distance_distanceBetween").point2

    if not isQuad:  # for humans
        footroll_ctrl.anklePivot.set(0, k=False, l=True, cb=False)
        footroll_ctrl.freeHeel.set(False, k=False, l=True, cb=False)
    else:  # for quads
        footroll_ctrl.freeHeel.set(True, k=False, l=True, cb=False)

    pm.delete(tmpOrientTransform)

    # Seamless
    limb_moduleInfo = rig_utils.moduleInfo.ModuleInfo(limb_moduleInfo)

    moduleInfo = rig_utils.moduleInfo.ModuleInfo(name+"_foot")
    moduleInfo.setAttr("type", "leg")

    moduleInfo.setAttr("limb", limb_moduleInfo)

    limb_moduleInfo.setParent(moduleInfo)

    switcher.makeSeamlessKinematicSwitching(moduleInfo, "toe_ik", toe_ik_ctrl, toe_fk_ctrl)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "toe_fk", toe_fk_ctrl, toe_ik_ctrl)

    moduleInfo.setAttr("footroll", footroll_ctrl.message)
]]></run>
</module>
</children>
</module>
<module name="R_leg" muted="0" uid="aa7b42755ced4f1a823ebfaa97540183">
<doc><![CDATA[## Summary  
The **L_leg** module creates a complete leg rig that supports IK/FK switching, foot roll, toe controls, stretch, soft‑IK, and optional pole‑vector locking. It first generates helper controls in *Helpers* mode, then builds the full rig in *Run* mode by composing two child modules: **limb** (the main IK/FK chain) and **foot** (toe and foot‑roll mechanics). All key objects are exposed through a `moduleInfo` node for downstream modules.

## Inputs  
- **`mode`** – Radio button (`Helpers` / `Run`).  
- **`name`** – Base name for all created nodes.  
- **`joint1` – `joint5`** – Names of the joint chain:  
  - `joint1`: hip / upper leg joint.  
  - `joint2`: knee joint.  
  - `joint3`: ankle joint.  
  - `joint4`: toe base joint.  
  - `joint5`: toe tip joint.  
- **`lastCtrlOrient`** – Optional transform used to orient the final IK control.  
- **`fkNoFollow`** – (unused in current code, placeholder for FK follow toggle).  
- **`isQuad`** – Boolean flag for quad‑leg rigs (affects foot‑roll behavior).  
- **`ikHelperType`** – Shape of the IK control curve (e.g., cube, sphere).  
- **`constrainIK`** – If checked, the IK handle is constrained to the pole‑vector control.  
- **`placeIkAt`** – Optional joint/transform to place the IK control at.  
- **Helper attributes (`h_*`)** – Names of helper transforms created in *Helpers* mode:  
  - `h_fk1`, `h_fk2`, `h_fk3` – FK control helpers.  
  - `h_ik` – IK control helper.  
  - `h_polevector` – Pole‑vector helper.  
  - `h_options` – Options helper.  
  - `h_heel`, `h_side1`, `h_side2`, `h_foot`, `h_footroll` – Foot‑pivot helpers.  
  - `h_toe_ik`, `h_toe_fk` – Toe control helpers.

## Outputs  
- **`out_ikfkSwitch`** – PlusMinusAverage node driving the IK/FK blend.  
- **`out_ik1` / `out_ik2` / `out_ik3`** – IK joint chain (ankle, knee, hip).  
- **`out_fk1` / `out_fk2` / `out_fk3`** – FK joint chain.  
- **`out_fix3`** – Final fix joint used for IK stretch.  
- **`out_ikHandle`** – Main IK handle.  
- **`out_fix2_ikHandle`** – Secondary IK handle for stretch.  
- **`out_ikCtrl`** – IK control transform.  
- **`out_polevecCtrl`** – Pole‑vector control transform.  
- **`moduleInfo`** – `ModuleInfo` node exposing all key objects and attributes for downstream modules.  
- **Foot module outputs** (via `moduleInfo`): foot‑roll control, toe IK/FK controls, and the foot module’s own `moduleInfo` node.

## Usage  
1. **Set the joint chain** – Assign `joint1`–`joint5` to the hip, knee, ankle, toe base, and toe tip joints.  
2. **Generate helpers** – Switch `mode` to **Helpers** and run the module. Helper transforms (`h_*`) will be created under the *helpers* group.  
3. **Adjust helpers** – In the viewport, move and orient the helper controls to match the desired rig layout.  
4. **Build the rig** – Set `mode` to **Run** and execute. The module will create the FK/IK chain, foot‑roll system, stretch/soft‑IK nodes, and expose all objects via `moduleInfo`.  
5. **Connect downstream** – Use the `moduleInfo` node or individual output attributes to link this leg rig to other modules (e.g., hand, spine, or animation pipelines).  
6. **Optional settings** –  
   - Set `ikHelperType` to change the IK control shape.  
   - Enable `constrainIK` to lock the IK handle to the pole‑vector control.  
   - For quad rigs, set `isQuad` to true to adjust foot‑roll behavior.  
   - Use `placeIkAt` to position the IK control at a specific joint or transform.  

Follow these steps to quickly generate a robust, animatable leg rig that integrates seamlessly into larger character rigs.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "R_leg", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_3_joint"}]]></attr>
<attr name="joint4" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_4_joint"}]]></attr>
<attr name="joint5" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_5_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_ik_control_helper"}]]></attr>
<attr name="fkNoFollow" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="isQuad" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_ik_polevector_control_helper"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_options_control_helper"}]]></attr>
<attr name="h_toe_ik" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_toe_ik_control_helper"}]]></attr>
<attr name="h_toe_fk" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_toe_fk_control_helper"}]]></attr>
<attr name="h_heel" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_heelPivot_helper"}]]></attr>
<attr name="h_toe" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_toePivot_helper"}]]></attr>
<attr name="h_side1" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_side1Pivot_helper"}]]></attr>
<attr name="h_side2" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_side2Pivot_helper"}]]></attr>
<attr name="h_footroll" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_footroll_control_helper"}]]></attr>
<attr name="h_foot" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_footPivot_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "R_leg_1_position_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
<children>
<module name="limb" muted="0" uid="d2e886c7fa894a018b74d0f9b00c62e5">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

joint1 = pm.PyNode(@joint1)
joint2 = pm.PyNode(@joint2)
joint3 = pm.PyNode(@joint3)

controlsParent = pm.PyNode("controls")
internalParent = pm.PyNode("internal")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if @mode == 0:  # helpers
    scale = rig_utils.getDistance(joint1, joint3) / 10
    
    p1 = rig_utils.matrix.taxis(joint1.wm.get())
    p2 = rig_utils.matrix.taxis(joint2.wm.get())
    p3 = rig_utils.matrix.taxis(joint3.wm.get())
        
    planeTransform = pm.createNode("transform", n=@name + "_ik_plane_helper_transform", p=helpersParent)
    pm.pointConstraint(joint2, planeTransform)
    oc = pm.orientConstraint(joint1, joint2, planeTransform)
    oc.interpType.set(2) # shortest

    #polevector
    h_polevector = rig_utils.curve.makeCurve(@name + "_ik_polevector_control_helper", "sphere")    
    h_polevector.s.set([scale/2, scale/2, scale/2])
    planeTransform | h_polevector
    
    avg = (p1 - p2).normal() + (p3 - p2).normal()
    pm.xform(h_polevector, ws=True, t=p2 - avg.normal() * scale*3)
    rig_utils.lockTRS(h_polevector, [1,0,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_polevector, ty=-1)
    @set_h_polevector(h_polevector.name())

    # IK Control
    h_ik = rig_utils.curve.makeCurve(@name + "_ik_control_helper", @ikHelperType)    
    
    isLeg = any(map(lambda x:x in ["leg", "frontLeg", "backLeg", "leg_front", "leg_back"], @name.split("_")))    
    if isLeg:     
        h_ik_transform = pm.createNode("transform", n=@name + "_ik_control_helper_transform", p=helpersParent)
        pm.pointConstraint(joint3, h_ik_transform, sk=["y"])
        pm.orientConstraint(joint3, h_ik_transform, sk=["x", "z"], mo=True)
        h_ik_transform | h_ik
        pm.xform(h_ik, ws=True, t=[p3[0], 0, p3[2]]) # place on ground
        h_ik.s.set([scale, scale/5, scale*2])
        rig_utils.lockTRS(h_ik, [0,1,0], [1,0,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik, tx=-1, ry=-1)
    else:
        helpersParent | h_ik
        pm.parentConstraint(@placeIkAt or joint3, h_ik)
        h_ik.s.set([scale, scale, scale])
        rig_utils.lockTRS(h_ik, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h_ik)
    @set_h_ik(h_ik.name())
    
    #options
    h_options = rig_utils.curve.makeCurve(@name + "_options_control_helper", "flag")
    h_options.s.set([scale, scale, scale])
    planeTransform | h_options
    h_options.t.set([0,0,0])
    pm.orientConstraint(helpersParent, h_options, mo=True)
    rig_utils.lockTRS(h_options, [0,1,0], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_options(h_options.name()) 
    
    # position
    h_position = rig_utils.curve.makeCurve(@name + "_position_control_helper", "axis")
    helpersParent | h_position
    h_position.s.set([scale/2.0, scale/2.0, scale/2.0])
    pm.pointConstraint(joint1, h_position)
    rig_utils.lockTRS(h_position, [1,1,1], [], [])
    rig_utils.connectFromSymmetric(h_options, tx=-1, tz=-1)
    @set_h_position(h_position.name())     

    # FK
    h_fk1 = rig_utils.curve.makeCurve(@name + "_fk_1_control_helper", "circle")
    h_fk2 = rig_utils.curve.makeCurve(@name + "_fk_2_control_helper", "circle")
    h_fk3 = rig_utils.curve.makeCurve(@name + "_fk_3_control_helper", "circle")

    for j, h in [(joint1, h_fk1), (joint2, h_fk2), (joint3, h_fk3)]:
        helpersParent | h
        h.s.set([scale, scale, scale])
        
        pc = pm.parentConstraint(j, h)
        pc.target[0].targetOffsetRotate.set([0,0,90])
        rig_utils.lockTRS(h, [1,1,1], [1,1,1], [], 1)
        rig_utils.connectFromSymmetric(h)

    @set_h_fk1(h_fk1.name())
    @set_h_fk2(h_fk2.name())
    @set_h_fk3(h_fk3.name())

if @mode == 1:  # run
    jointsParent = joint1.getParent()

    h_fk1 = pm.PyNode(@h_fk1)
    h_fk2 = pm.PyNode(@h_fk2)
    h_fk3 = pm.PyNode(@h_fk3)
    h_ik = pm.PyNode(@h_ik)
    h_polevector = pm.PyNode(@h_polevector)
    h_options = pm.PyNode(@h_options)
    h_position = pm.PyNode(@h_position) if pm.objExists(@h_position) else None

    # controls and joints groups
    controls_grp = pm.createNode("transform", n=@name + "_controls_group", p=controlsParent)

    internal_grp = pm.createNode("transform", n=@name + "_internal_group", p=internalParent)
    internal_grp.v.set(False)
    
    rig_utils.lockTRS(controls_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)
    rig_utils.lockTRS(internal_grp, [1,1,1], [1,1,1], [1, 1, 1], 0.5)

    others_grp = pm.createNode("transform", n=@name + "_others_group", p=othersParent)

    # options control
    options_ctrl = pm.createNode("transform", n=@name + "_options_control", p=controls_grp)
    pm.parentConstraint(joint1, options_ctrl)

    rig_utils.curve.makeFromCurve(options_ctrl, h_options)

    options_ctrl.addAttr("ikfk", at="float", min=0, max=1, k=True)
    options_ctrl.addAttr("scaleFactor1x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor2x", at="float", min=0.1, dv=1, k=True)
    options_ctrl.addAttr("scaleFactor3x", at="float", min=0.1, dv=1, k=True)
    
    for i, j in enumerate([joint1, joint2, joint3]):
        a = f"scaleFactor{i+1}"
        options_ctrl.addAttr(a, min=0.01, dv=1.0, k=True)
        if i == 2:
            md = pm.createNode("multiplyDivide", n=j+"_scaleFactor_multiplyDivide")
            options_ctrl.attr(a) >> md.input1X
            options_ctrl.attr(a) >> md.input1Y
            options_ctrl.attr(a) >> md.input1Z
            options_ctrl.scaleFactor3x >> md.input2X
            md.output >> j.s
        else:
            options_ctrl.attr(a) >> j.sx
            options_ctrl.attr(a) >> j.sy
            options_ctrl.attr(a) >> j.sz

    rig_utils.lockTRS(options_ctrl, [1, 1, 1], [1, 1, 1], [1, 1, 1], 1)
    
    # ikfk switch
    ikfk_rev = pm.createNode("reverse", n=@name + "_ikfk_reverse")
    options_ctrl.ikfk >> ikfk_rev.inputX

    # bones start position control
    positionCtrl = None
    if h_position:
        options_ctrl.addAttr("positionControl", at="bool", dv=False)
        rig_utils.lockAttr(options_ctrl.positionControl, 0.5)    
        
        positionTransform = pm.createNode("transform", n=@name + "_1_position_control_transform", p=controls_grp)
        pm.matchTransform(positionTransform, jointsParent)
        pm.matchTransform(positionTransform, joint1, position=True, rotation=False)
        options_ctrl.positionControl >> positionTransform.v
        
        if jointsParent:
            pm.parentConstraint(jointsParent, positionTransform, mo=True)
        
        positionCtrl = pm.createNode("transform", n=@name + "_1_position_control", p=positionTransform)
        pm.matchTransform(positionCtrl, joint1, position=True, rotation=False)        
        
        rig_utils.curve.makeFromCurve(positionCtrl, h_position)
        rig_utils.lockTRS(positionCtrl, [])
        
    # IK chain
    ik1 = rig_utils.matchJoint(joint1, @name + "_ik_1_joint")
    ik2 = rig_utils.matchJoint(joint2, @name + "_ik_2_joint")
    ik3 = rig_utils.matchJoint(joint3, @name + "_ik_3_joint")
    internal_grp | ik1 | ik2 | ik3
    
    pm.parentConstraint(positionCtrl or jointsParent, ik1, mo=True, skipRotate=["x", "y", "z"]) # pointConstraint

    # FIX
    fix1 = rig_utils.matchJoint(joint1, @name + "_fix_1_joint")
    fix2 = rig_utils.matchJoint(joint2, @name + "_fix_2_joint")
    fix3 = rig_utils.matchJoint(joint3, @name + "_fix_3_joint")

    internal_grp | fix1 | fix2 | fix3

    pm.pointConstraint(ik1, fix1)

    # FK
    fk1 = rig_utils.matchJoint(joint1, @name + "_fk_1_joint")
    fk2 = rig_utils.matchJoint(joint2, @name + "_fk_2_joint")
    fk3 = rig_utils.matchJoint(joint3, @name + "_fk_3_joint")
    internal_grp | fk1 | fk2 | fk3

    # FK controls
    # fk1
    fk1_ctrl = pm.createNode("transform", n=@name + "_fk_1_control", p=controls_grp)  
    pm.matchTransform(fk1_ctrl, joint1)
    rig_utils.curve.makeFromCurve(fk1_ctrl, h_fk1)
    pm.parentConstraint(positionCtrl or jointsParent, fk1_ctrl, sr=["x","y","z"], mo=True)

    switcher.addFollow(fk1_ctrl, controls_grp, jointsParent, attr="followBody", default=0.0, type="orient")
    
    rig_utils.setToOffsetParentMatrix(fk1_ctrl)
    options_ctrl.ikfk >> fk1_ctrl.v
    rig_utils.lockTRS(fk1_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.parentConstraint(fk1_ctrl, fk1)
    
    # fk2
    fk2_ctrl = pm.createNode("transform", n=@name + "_fk_2_control", p=fk1_ctrl)
    pm.matchTransform(fk2_ctrl, joint2)
    pm.pointConstraint(fk2, fk2_ctrl)
    rig_utils.setToOffsetParentMatrix(fk2_ctrl)

    rig_utils.curve.makeFromCurve(fk2_ctrl, h_fk2)    
    rig_utils.lockTRS(fk2_ctrl, [1, 1, 1], [1, 1, 0], [1, 1, 1], 1)
    
    pm.orientConstraint(fk2_ctrl, fk2)
    
    # fk3
    fk3_ctrl = pm.createNode("transform", n=@name + "_fk_3_control", p=fk2_ctrl)
    pm.matchTransform(fk3_ctrl, joint3)
    pm.pointConstraint(fk3, fk3_ctrl)
    rig_utils.setToOffsetParentMatrix(fk3_ctrl)

    rig_utils.curve.makeFromCurve(fk3_ctrl, h_fk3)
    rig_utils.lockTRS(fk3_ctrl, [1, 1, 1], [], [1, 1, 1], 1)

    pm.orientConstraint(fk3_ctrl, fk3)
    
    # FIX IK handles
    fix_ikHandle1 = pm.ikHandle(startJoint=fix1,
                                endEffector=fix2,
                                solver="ikSCsolver",
                                n=@name + "_fix_1_ikHandle")[0]
    internal_grp | fix_ikHandle1

    fix_ikHandle2 = pm.ikHandle(startJoint=fix2,
                                endEffector=fix3,
                                solver="ikSCsolver",
                                n=@name + "_fix_2_ikHandle")[0]
    internal_grp | fix_ikHandle2    
    
    # IK handle
    ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik3, solver="ikRPsolver", n=@name + "_ikHandle")[0]
    internal_grp | ikHandle

    # IK control
    ik_ctrl = pm.createNode("joint", n=@name + "_ik_control", p=controls_grp)

    ik_ctrl.radius.set(0)
    rig_utils.lockAttr(ik_ctrl.radius, 1)
    
    pm.matchTransform(ik_ctrl, @placeIkAt or ik3, position=True, rotation=False)

    rig_utils.setToOffsetParentMatrix(ik_ctrl)
    
    if pm.objExists(@lastCtrlOrient):
        pm.matchTransform(ik_ctrl, @lastCtrlOrient, position=False, rotation=True)    
        rig_utils.freezeJoints([ik_ctrl])

    rig_utils.curve.makeFromCurve(ik_ctrl, h_ik)
    ikfk_rev.outputX >> ik_ctrl.v

    dynamicParent.makeDynamicParent(ik_ctrl, ik_ctrl)

    rig_utils.lockTRS(ik_ctrl, [], [], [1, 1, 1], 1)

    # IK polevector control
    polevec_follow_j1 = rig_utils.matchJoint(joint1, @name + "_ik_polevector_follow_1_joint")
    polevec_follow_j2 = rig_utils.matchJoint(joint3, @name + "_ik_polevector_follow_2_joint")
    internal_grp | polevec_follow_j1 | polevec_follow_j2    
    
    polevec_follow_ikHandle = pm.ikHandle(sj=polevec_follow_j1, ee=polevec_follow_j2, solver="ikSCsolver")[0]
    polevec_follow_ikHandle.rename(@name+"_ik_polevector_follow_ikHandle")
    internal_grp | polevec_follow_ikHandle
    
    pm.parentConstraint(ik_ctrl, polevec_follow_ikHandle, mo=True)
    pm.pointConstraint(ik1, polevec_follow_j1)
    
    polevec_ctrl = pm.createNode("transform", n=@name + "_ik_polevector_control", p=controls_grp)
    pm.matchTransform(polevec_ctrl, h_polevector, position=True, rotation=False)
    rig_utils.setToOffsetParentMatrix(polevec_ctrl)    

    switcher.addFollow(polevec_ctrl, internal_grp, polevec_follow_j1, attr="follow", default=0.0, type="parent")
    
    polevec_ctrl.addAttr("snap", min=0, max=1, k=True)
    polevec_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    polevec_ctrl.stretch.set(0)

    rig_utils.curve.makeFromCurve(polevec_ctrl, h_polevector)
    
    ikfk_rev.outputX >> polevec_ctrl.v
    
    rig_utils.lockTRS(polevec_ctrl, [], [1, 1, 1], [1, 1, 1], 1)

    pm.pointConstraint(polevec_ctrl, fix_ikHandle1)  # snap fix1-fix2
    
    if @constrainIK:
        pm.pointConstraint(ik_ctrl, fix_ikHandle2)  # snap fix2-fix3    

    dynamicParent.makeDynamicParent(polevec_ctrl, polevec_ctrl)

    rig_utils.makeHelpLine(
        @name + "_polevector", 
        [polevec_ctrl, joint2],
        visibleAttr=ikfk_rev.outputX,
        parent=others_grp)

    ik_ctrl.addAttr("stretch", min=0, max=1, dv=1, k=True)
    ik_ctrl.stretch.set(0)

    dFix1 = rig_utils.createDistance(@name + "_fix_1_distance", fix1, polevec_ctrl)
    dFix2 = rig_utils.createDistance(@name + "_fix_2_distance", fix2, ik_ctrl)
    d = rig_utils.createDistance(@name + "_ik_distance", ik1, ik_ctrl)

    ik2_tx_scaleMult = pm.createNode("multDL", n=ik2 + "_tx_scaleFactor1x_multDL")
    ik2_tx_scaleMult.input1.set(abs(ik2.tx.get()))
    options_ctrl.scaleFactor1x >> ik2_tx_scaleMult.input2

    ik3_tx_scaleMult = pm.createNode("multDL", n=ik3 + "_tx_scaleFactor2x_multDL")
    ik3_tx_scaleMult.input1.set(abs(ik3.tx.get()))
    options_ctrl.scaleFactor2x >> ik3_tx_scaleMult.input2

    ik2ik3_tx_sumAdd = pm.createNode("addDL", n=@name + "_ik_sum_tx_addDL")
    ik2_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input1
    ik3_tx_scaleMult.output >> ik2ik3_tx_sumAdd.input2

    sFix1 = rig_utils.makeStretchable(
        @name + "_fix_1", 
        [fix1],
        dFix1, 
        polevec_ctrl.stretch,
        0.01, 0,
        ik2_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    sFix2 = rig_utils.makeStretchable(
        @name + "_fix_2", 
        [fix2],
        dFix2,
        ik_ctrl.stretch,
        0.01,
        0,
        ik3_tx_scaleMult.output,
        scales=[True, False, False])
                                    
    s = rig_utils.makeStretchable(
        @name + "_ik", 
        [ik1, ik2],
        d,
        ik_ctrl.stretch,
        1,
        0,
        ik2ik3_tx_sumAdd.output,
        scales=[True, False, False],  
        useTx=False)

    # softIK
    ik_ctrl.addAttr("softIK", min=0, max=0.5, dv=0.05, k=True)

    ac_x = rig_utils.anim.createSoftIKAnimCurve(@name + "_softIK")

    stretchX = pm.PyNode(@name + "_ik_stretch_x_blendTwoAttr")
    cond = pm.PyNode(@name + "_ik_squash_condition")

    stretchX.output >> ac_x.input

    softIk_switch = pm.createNode("multDL", n=@name + "_softIK_switch_multDL")
    ik_ctrl.softIK >> softIk_switch.input1
    ik_ctrl.stretch >> softIk_switch.input2

    softIk_b2a = pm.createNode("blendTwoAttr", n=@name + "_softIK_blendTwoAttr")
    softIk_switch.output >> softIk_b2a.attributesBlender
    stretchX.output >> softIk_b2a.i[0]
    ac_x.output >> softIk_b2a.i[1]

    softIk_b2a.output >> cond.firstTerm
    softIk_b2a.output >> cond.colorIfTrueR

    # fk stretch with scaleFactor
    fk2_scaleFactor_mult = pm.createNode("multDL", n=fk2 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor1x >> fk2_scaleFactor_mult.input1
    fk2_scaleFactor_mult.input2.set(fk2.tx.get())
    fk2_scaleFactor_mult.output >> fk2.tx
    
    fk3_scaleFactor_mult = pm.createNode("multDL", n=fk3 + "_scaleFactor_multDL")
    options_ctrl.scaleFactor2x >> fk3_scaleFactor_mult.input1
    fk3_scaleFactor_mult.input2.set(fk3.tx.get())
    fk3_scaleFactor_mult.output >> fk3.tx

    # ik stretch
    multIK1 = pm.createNode("multiplyDivide", n=ik1 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK1.input1X
    options_ctrl.scaleFactor1x >> multIK1.input2X

    multIK2 = pm.createNode("multiplyDivide", n=ik2 + "_scaleFactor_multiplyDivide")
    s[0] >> multIK2.input1X
    options_ctrl.scaleFactor2x >> multIK2.input2X

    multFIX1 = pm.createNode("multiplyDivide", n=fix1 + "_scaleFactor_multiplyDivide")
    sFix1[0] >> multFIX1.input1X
    options_ctrl.scaleFactor1x >> multFIX1.input2X
    multFIX1.outputX >> fix1.sx

    multFIX2 = pm.createNode("multiplyDivide", n=fix2 + "_scaleFactor_multiplyDivide")
    sFix2[0] >> multFIX2.input1X
    options_ctrl.scaleFactor2x >> multFIX2.input2X
    multFIX2.outputX >> fix2.sx

    b2a = pm.createNode("blendTwoAttr", n=ik1 + "_stretch_x_blendTwoAttr")
    multIK1.outputX >> b2a.i[0]
    multFIX1.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik1.sx

    b2a = pm.createNode("blendTwoAttr", n=ik2 + "_stretch_x_blendTwoAttr")
    multIK2.outputX >> b2a.i[0]
    multFIX2.outputX >> b2a.i[1]
    polevec_ctrl.snap >> b2a.attributesBlender
    b2a.output >> ik2.sx

    defPolevec = pm.createNode("transform", n=polevec_ctrl + "_default_transform")
    pm.matchTransform(defPolevec, h_polevector, position=True, rotation=False)
    pm.parent(defPolevec, fk2)

    pm.poleVectorConstraint(polevec_ctrl, ikHandle)

    if @constrainIK:
        pc = pm.pointConstraint(ik_ctrl, fix3, ikHandle)

        snap_rev = pm.createNode("reverse", n=@name + "_ik_snap_reverse")
        polevec_ctrl.snap >> snap_rev.inputX

        snap_rev.outputX >> pc.w0
        polevec_ctrl.snap >> pc.w1

        pm.orientConstraint(ik_ctrl, ik3, mo=True)

    # blend IKFK constraints
    for j, ikj, fkj in [(joint1, ik1, fk1), (joint2, ik2, fk2), (joint3, ik3, fk3)]:
        oc = pm.parentConstraint(ikj, fkj, j)
        oc.interpType.set(2)
        ikfk_rev.outputX >> oc.w0
        options_ctrl.ikfk >> oc.w1
        
    # ModuleInfo
    moduleInfo = rig_utils.moduleInfo.ModuleInfo(@name + "_limb")
    moduleInfo.setAttr("type", "limb")

    moduleInfo.setAttr("options", options_ctrl.message)
    moduleInfo.setAttr("ikfk", options_ctrl.ikfk)    
    moduleInfo.setAttr("snap", polevec_ctrl.snap)     
    moduleInfo.setAttr("ik1_joint", ik1.message)
    moduleInfo.setAttr("ik2_joint", ik2.message)
    moduleInfo.setAttr("ik3_joint", ik3.message)
    moduleInfo.setAttr("fk1_joint", fk1.message)
    moduleInfo.setAttr("fk2_joint", fk2.message)
    moduleInfo.setAttr("fk3_joint", fk3.message)    
    moduleInfo.setAttr("ik", ik_ctrl.message)
    moduleInfo.setAttr("polevector", polevec_ctrl.message)
    moduleInfo.setAttr("fk1", fk1_ctrl.message)
    moduleInfo.setAttr("fk2", fk2_ctrl.message)
    moduleInfo.setAttr("fk3", fk3_ctrl.message)

    # seamless
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk1", fk1_ctrl, ik1)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk2", fk2_ctrl, ik2)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "fk3", fk3_ctrl, ik3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "ik", ik_ctrl, fk3)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "polevector", polevec_ctrl, defPolevec)
]]></run>
<doc><![CDATA[## Summary  
The **L_arm** module creates a fully functional IK/FK arm rig. It first generates placement helpers (IK plane, pole‑vector, IK and FK controls) in *Helpers* mode, then builds the rig in *Run* mode, adding an IK/FK switch, pole‑vector controller, stretch and soft‑IK logic, and exposes all key objects through a `ModuleInfo` node for downstream use.

## Inputs  
- **mode** – Selects *Helpers* (0) or *Run* (1).  
- **name** – Base name for all generated nodes.  
- **joint1 / joint2 / joint3** – Target joint names forming the arm chain.  
- **lastCtrlOrient** – Optional joint used to orient the final IK control.  
- **ikHelperType** – Shape of the IK control curve (e.g., cube, sphere).  
- **constrainIK** – Boolean to enable optional IK‑to‑fix constraints.  
- **placeIkAt** – Optional transform to position the IK control at start.

## Outputs  
- **h_fk1 / h_fk2 / h_fk3** – FK helper curves.  
- **h_ik** – IK helper curve.  
- **h_polevector** – Pole‑vector helper curve.  
- **h_options** – Options helper curve.  
- **out_ikfkSwitch** – PlusMinusAverage node driving the IK/FK blend.  
- **out_ik1 / out_ik2 / out_ik3** – IK joint chain.  
- **out_fk1 / out_fk2 / out_fk3** – FK joint chain.  
- **out_fix3** – Third fix joint for optional constraints.  
- **out_ikHandle** – Main IK handle.  
- **out_fix2_ikHandle** – Secondary IK handle for fix joints.  
- **out_ikCtrl** – IK control joint.  
- **out_polevecCtrl** – Pole‑vector control.  
- **moduleInfo** – `ModuleInfo` node exposing rig type, joints, controls, and switch attributes.

## Usage  
1. **Set Target Joints** – Assign `joint1`, `joint2`, and `joint3` to the arm’s shoulder, elbow, and wrist joints.  
2. **Generate Helpers** – Set `mode` to **Helpers** and run. The module will create placement helpers under the *Helpers* parent, scaled to the joint spacing. Adjust their positions and orientations in the viewport.  
3. **Configure Optional Settings** –  
   - Choose an `ikHelperType` shape.  
   - Toggle `constrainIK` if you need the IK control to drive the fix joints.  
   - If desired, set `placeIkAt` to a transform that will be used as the IK control’s base position.  
4. **Build the Rig** – Switch `mode` to **Run** and execute. The module will create the full FK/IK chain, IK/FK switch, pole‑vector controller, stretch and soft‑IK systems, and lock/unlock attributes appropriately.  
5. **Connect to Other Modules** – Use the `moduleInfo` node or the individual output attributes (`out_ikCtrl`, `out_polevecCtrl`, `out_fk1`, etc.) to link this arm rig to downstream modules such as hand, fingers, or other limb systems.  
6. **Mirror or Duplicate** – The helper attributes (`h_fk1`, `h_fk2`, `h_fk3`, `h_ik`, `h_polevector`, `h_options`) can be mirrored or reused for building a symmetrical arm.  

The module automatically handles mirroring, dynamic parenting, and provides a clean interface for further customization or integration into larger rigging pipelines.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect="/name"><![CDATA[{"default": "value", "max": "", "validator": 0, "value": "R_leg", "min": "", "buttonEnabled": false}]]></attr>
<attr name="joint1" template="lineEditAndButton" category="General" connect="/joint1"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_1_joint"}]]></attr>
<attr name="joint2" template="lineEditAndButton" category="General" connect="/joint2"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_2_joint"}]]></attr>
<attr name="joint3" template="lineEditAndButton" category="General" connect="/joint3"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_3_joint"}]]></attr>
<attr name="lastCtrlOrient" template="lineEditAndButton" category="Others" connect="/lastCtrlOrient"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_ik_control_helper"}]]></attr>
<attr name="ikHelperType" template="comboBox" category="Others" connect=""><![CDATA[{"current": "cube", "items": ["arc", "axis", "axisSphere", "cube", "circle", "diamond", "pyramid", "rect", "sphere", "triangle"], "default": "current"}]]></attr>
<attr name="constrainIK" template="checkBox" category="Others" connect=""><![CDATA[{"default": "checked", "checked": false}]]></attr>
<attr name="placeIkAt" template="lineEditAndButton" category="Others" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": ""}]]></attr>
<attr name="h_fk1" template="lineEditAndButton" category="Helpers" connect="/h_fk1"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_fk_1_control_helper"}]]></attr>
<attr name="h_fk2" template="lineEditAndButton" category="Helpers" connect="/h_fk2"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_fk_2_control_helper"}]]></attr>
<attr name="h_fk3" template="lineEditAndButton" category="Helpers" connect="/h_fk3"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_fk_3_control_helper"}]]></attr>
<attr name="h_ik" template="lineEditAndButton" category="Helpers" connect="/h_ik"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_ik_control_helper"}]]></attr>
<attr name="h_polevector" template="lineEditAndButton" category="Helpers" connect="/h_polevector"><![CDATA[{"value": "R_leg_ik_polevector_control_helper", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="h_options" template="lineEditAndButton" category="Helpers" connect="/h_options"><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "R_leg_options_control_helper"}]]></attr>
<attr name="h_position" template="lineEditAndButton" category="Helpers" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="foot" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
import rig_utils
from anim_utils import dynamicParent, switcher

mode = ch("../mode")
name = ch("../name")
lastCtrlOrient = ch("../lastCtrlOrient")
isQuad = False

j1 = pm.PyNode(ch("../joint3"))
j2 = pm.PyNode(ch("../joint4"))
j3 = pm.PyNode(ch("../joint5"))

internalParent = pm.PyNode("internal")
controlsParent = pm.PyNode("controls")
othersParent = pm.PyNode("others")
helpersParent = pm.PyNode("helpers")

if mode == 0:  # helpers
    scale = rig_utils.getDistance(j1, j3) / 2.0
    smallScale = scale / 5.0
    p1 = pm.xform(j1, ws=True, q=True, t=True)
    p2 = pm.xform(j2, ws=True, q=True, t=True)
    p3 = pm.xform(j3, ws=True, q=True, t=True)   
    
    pivots_null = pm.PyNode(name + "_ik_control_helper_null")
    
    h_heel = rig_utils.curve.makeCurve(name+"_heelPivot_helper", "axis")
    pm.xform(h_heel, ws=True, t=[p1[0], 0, p1[2]-scale])
    h_heel.s.set([smallScale, smallScale, smallScale])    
    pivots_null | h_heel    
    rig_utils.lockTRS(h_heel, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_heel, tx=-1)
    chset("../h_heel", h_heel.name())

    h_side1 = rig_utils.curve.makeCurve(name+"_side1Pivot_helper", "axis")
    pm.xform(h_side1, ws=True, t=[p2[0]+scale/2, 0, p2[2]])
    h_side1.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_side1
    rig_utils.lockTRS(h_side1, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_side1, tx=-1)
    chset("../h_side1", h_side1.name())

    h_side2 = rig_utils.curve.makeCurve(name+"_side2Pivot_helper", "axis")
    pm.xform(h_side2, ws=True, t=[p2[0]-scale/2, 0, p2[2]])
    h_side2.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_side2
    rig_utils.lockTRS(h_side2, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_side2, tx=-1)
    chset("../h_side2", h_side2.name())

    h_toe = rig_utils.curve.makeCurve(name+"_toePivot_helper", "axis")
    pm.xform(h_toe, ws=True, t=[p3[0], 0, p3[2]+scale/2])
    h_toe.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_toe
    rig_utils.lockTRS(h_toe, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_toe, tx=-1)
    chset("../h_toe", h_toe.name())

    h_foot = rig_utils.curve.makeCurve(name+"_footPivot_helper", "axis")
    pm.xform(h_foot, ws=True, t=[p2[0], 0, p2[2]])
    h_foot.s.set([smallScale, smallScale, smallScale])
    pivots_null | h_foot
    rig_utils.lockTRS(h_foot, [], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_foot, tx=-1)
    chset("../h_foot", h_foot.name())

    h_footroll = rig_utils.curve.makeCurve(name+"_footroll_control_helper", "sphere")    
    pm.parentConstraint(j1, h_footroll)
    
    h_footroll.s.set([scale, scale, scale])
    helpersParent | h_footroll
    rig_utils.lockTRS(h_footroll, [1,1,1], [1,1,1], [], 1)
    rig_utils.connectFromSymmetric(h_footroll)
    chset("../h_footroll", h_footroll.name())
    
    toes_transform = pm.createNode("transform", n=name+"_toes_helpers_transform", p=helpersParent)
    pm.parentConstraint(j2, toes_transform)
    
    for label in ["toe_ik", "toe_fk"]:
        h = rig_utils.curve.makeCurve(name+"_"+label+"_control_helper", "circle")
        toes_transform | h
        h.t.set([0,0,0])
        h.r.set([0,0,90])
        h.s.set([scale, scale, scale])
        rig_utils.lockTRS(h, [1,1,1], [1,1,0], [], 1)
        rig_utils.connectFromSymmetric(h)
        chset("../h_"+label, h.name())
        
elif mode == 1:  # run
    h_footroll = pm.PyNode(ch("../h_footroll"))
    h_toe_ik = pm.PyNode(ch("../h_toe_ik"))
    h_toe_fk = pm.PyNode(ch("../h_toe_fk"))
    h_heel = pm.PyNode(ch("../h_heel"))
    h_toe = pm.PyNode(ch("../h_toe"))
    h_foot = pm.PyNode(ch("../h_foot"))
    h_side1 = pm.PyNode(ch("../h_side1"))
    h_side2 = pm.PyNode(ch("../h_side2"))
    if h_side2.tx > h_side1.tx: # side1.tx must be > side2.tx
        h_side1, h_side2 = h_side2, h_side1

    limb_ikHandle = pm.PyNode(name+"_ikHandle")
    limb_options_ctrl = pm.PyNode(name+"_options_control")
    limb_ikfk_rev = pm.PyNode(name+"_ikfk_reverse")
    limb_ik3 = pm.PyNode(name+"_ik_3_joint")
    limb_fk3 = pm.PyNode(name+"_fk_3_joint")
    limb_fk3_ctrl = pm.PyNode(name+"_fk_3_control")
    limb_fix3 = pm.PyNode(name+"_fix_3_joint")
    limb_ik_ctrl = pm.PyNode(name+"_ik_control")
    limb_polevecCtrl = pm.PyNode(name+"_ik_polevector_control")
    limb_moduleInfo = pm.PyNode(name+"_limb_moduleInfo")

    internal_grp = pm.PyNode(name+"_internal_group")
    controls_grp = pm.PyNode(name+"_controls_group")

    # IK chain
    ik1 = limb_ik3  # get the last ik joint(ankle) in limb template

    ik2 = rig_utils.matchJoint(j2, name=name+"_ik_4_joint")
    ik3 = rig_utils.matchJoint(j3, name=name+"_ik_5_joint")
    ik1 | ik2 | ik3

    # FK Chain FK controls
    fk1 = limb_fk3  # get the last fk joint(ankle) in limb template

    fk2 = rig_utils.matchJoint(j2, name=name+"_fk_4_joint")
    fk3 = rig_utils.matchJoint(j3, name=name+"_fk_5_joint")
    fk1 | fk2 | fk3

    # toe FK
    toe_fk_transform = pm.createNode("transform", n=name+"_toe_fk_control_transform", p=limb_fk3_ctrl)
    pm.pointConstraint(fk2, toe_fk_transform)
    pm.orientConstraint(fk1, toe_fk_transform)
    
    toe_fk_ctrl = pm.createNode("transform", n=name+"_toe_fk_control", p=toe_fk_transform)
    rig_utils.curve.makeFromCurve(toe_fk_ctrl, h_toe_fk)
    rig_utils.lockTRS(toe_fk_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(toe_fk_ctrl, fk2, mo=True)

    tmpOrientTransform = pm.createNode("transform")
    if pm.objExists(lastCtrlOrient):
        pm.matchTransform(tmpOrientTransform, pm.PyNode(lastCtrlOrient), position=False, rotation=True)

    # main aux joint start at ankle
    aux1 = pm.createNode("joint", n=name+"_aux_1_joint")
    pm.matchTransform(aux1, tmpOrientTransform)
    pm.matchTransform(aux1, j1, position=True, rotation=False)
    aux1.v.set(0)
    internal_grp | aux1

    # heel land pivot
    aux2 = pm.createNode("joint", n=name+"_aux_2_joint")
    pm.matchTransform(aux2, tmpOrientTransform)
    pm.matchTransform(aux2, h_heel, position=True, rotation=False)
    aux1 | aux2

    # toe pivot
    aux3 = pm.createNode("joint", n=name+"_aux_3_joint")
    pm.matchTransform(aux3, tmpOrientTransform)
    pm.matchTransform(aux3, h_foot, position=True, rotation=False)
    aux2 | aux3

    # left side pivot
    aux4 = pm.createNode("joint", n=name+"_aux_4_joint")
    pm.matchTransform(aux4, tmpOrientTransform)
    pm.matchTransform(aux4, h_side1, position=True, rotation=False)
    aux3 | aux4

    # right side  pivot
    aux5 = pm.createNode("joint", n=name+"_aux_5_joint")
    pm.matchTransform(aux5, tmpOrientTransform)
    pm.matchTransform(aux5, h_side2, position=True, rotation=False)
    aux4 | aux5

    #toe 2 pivot
    aux6 = pm.createNode("joint", n=name+"_aux_6_joint")
    pm.matchTransform(aux6, tmpOrientTransform)
    pm.matchTransform(aux6, h_foot, position=True, rotation=False)
    aux5 | aux6

    # foot pivot
    aux7 = pm.createNode("joint", n=name+"_aux_7_joint")
    pm.matchTransform(aux7, tmpOrientTransform)
    pm.matchTransform(aux7, h_toe, position=True, rotation=False)
    aux6 | aux7

    # foot pivot
    aux8 = pm.createNode("joint", n=name+"_aux_8_joint")
    pm.matchTransform(aux8, tmpOrientTransform)
    pm.matchTransform(aux8, j3, position=True, rotation=False)
    aux7 | aux8

    # toe pivot
    aux9 = pm.createNode("joint", n=name+"_aux_9_joint")
    pm.matchTransform(aux9, tmpOrientTransform)
    pm.matchTransform(aux9, j2, position=True, rotation=False)
    aux8 | aux9

    # ankle pivot
    aux10 = pm.createNode("joint", n=name+"_aux_10_joint")
    pm.matchTransform(aux10, tmpOrientTransform)
    pm.matchTransform(aux10, j1, position=True, rotation=False)
    aux9 | aux10

    # toe pivot
    auxToe1 = pm.createNode("joint", n=name+"_auxToe_1_joint")
    pm.matchTransform(auxToe1, tmpOrientTransform)
    pm.matchTransform(auxToe1, j2, position=True, rotation=False)
    aux8 | auxToe1

    #toe end pivot
    auxToe2 = pm.createNode("joint", n=name+"_auxToe_2_joint")
    pm.matchTransform(auxToe2, tmpOrientTransform)
    pm.matchTransform(auxToe2, j3, position=True, rotation=False)
    auxToe1 | auxToe2

    rig_utils.freezeJoints([aux1, aux2, aux3, aux4, aux5, aux6, aux7, aux8, aux9, aux10, auxToe1, auxToe2])

    # set limits
    aux2.setLimited(aux2.LimitType.rotateMaxX, True)
    aux2.setLimit(aux2.LimitType.rotateMaxX, 0)

    aux4.setLimited(aux4.LimitType.rotateMaxZ, True)
    aux4.setLimit(aux4.LimitType.rotateMaxZ, 0)

    aux5.setLimited(aux5.LimitType.rotateMinZ, True)
    aux5.setLimit(aux5.LimitType.rotateMinZ, 0)

    aux6.setLimited(aux6.LimitType.rotateMinX, True)
    aux6.setLimit(aux6.LimitType.rotateMinX, 0)

    aux7.setLimited(aux7.LimitType.rotateMinX, True)
    aux7.setLimit(aux7.LimitType.rotateMinX, 0)

    aux9.setLimited(aux9.LimitType.rotateMinX, True)
    aux9.setLimit(aux9.LimitType.rotateMinX, 0)

    ##IK handles
    toe_ikHandle = pm.ikHandle(startJoint=ik1, endEffector=ik2, solver="ikSCsolver", n=name+"_toe_ikHandle")[0]
    foot_ikHandle = pm.ikHandle(startJoint=ik2, endEffector=ik3, solver="ikSCsolver", n=name+"_foot_ikHandle")[0]
    toe_ikHandle.v.set(0)
    foot_ikHandle.v.set(0)
    aux10 | toe_ikHandle
    auxToe1 | foot_ikHandle

    # foot snap
    fix = pm.PyNode(name+"_fix_2_ikHandle")
    pm.delete(fix.listRelatives(type="pointConstraint"))
    pm.pointConstraint(aux10, fix)
   
    snap_rev = pm.createNode("reverse", n=name+"_snap_reverse")
    limb_polevecCtrl.snap >> snap_rev.inputX

    pc = pm.pointConstraint(aux10, limb_fix3, limb_ikHandle)
    snap_rev.outputX >> pc.w0
    limb_polevecCtrl.snap >> pc.w1

    # footroll control
    footroll_ctrl = pm.createNode("transform", n=name+"_footroll_control", p=limb_ik_ctrl)
    pm.matchTransform(footroll_ctrl, tmpOrientTransform)
    pm.pointConstraint(aux10, footroll_ctrl)

    rig_utils.curve.makeFromCurve(footroll_ctrl, h_footroll)

    footroll_ctrl.addAttr("weight", at="float", min=0, max=1, dv=0, k=True)
    footroll_ctrl.addAttr("angle", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("heelPivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("footPivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("toePivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("anklePivot", at="float", dv=0, k=True)
    footroll_ctrl.addAttr("freeHeel", at="bool", dv=False, k=False)

    rig_utils.lockTRS(footroll_ctrl, [1, 1, 1], [0, 1, 0], [1, 1, 1], 1)

    #Footroll utility nodes setup
    footroll_ctrl.heelPivot >> aux2.ry
    footroll_ctrl.footPivot >> aux3.ry
    footroll_ctrl.toePivot >> aux7.ry

    if not isQuad:
        footroll_ctrl.rx >> aux2.rx
    else:
        b2a = pm.createNode("blendTwoAttr", n=aux2+"_blendWeighted")
        footroll_ctrl.weight >> b2a.attributesBlender
        b2a.i[0].set(0)
        footroll_ctrl.rx >> b2a.i[1]
        b2a.output >> aux2.rx

    footroll_ctrl.rz >> aux4.rz
    footroll_ctrl.rz >> aux5.rz

    freeHeelRev = pm.createNode("reverse", n=footroll_ctrl+"_freeHeel_reverse")
    footroll_ctrl.freeHeel >> freeHeelRev.inputX
    freeHeelRev.outputX >> aux9.minRotXLimitEnable

    freeHeelCond = pm.createNode("condition", n=footroll_ctrl+"_freeHeel_condition")
    footroll_ctrl.weight >> freeHeelCond.firstTerm
    freeHeelCond.colorIfFalseR.set(0)
    footroll_ctrl.freeHeel >> freeHeelCond.colorIfTrueR
    freeHeelCond.outColorR >> aux2.minRotXLimitEnable

    plus = pm.createNode("plusMinusAverage", n=aux7+"_plusMinusAverage")
    plus.operation.set(2)  # -
    footroll_ctrl.rx >> plus.input1D[0]
    aux6.rx >> plus.input1D[1]

    b2a = pm.createNode("blendTwoAttr", n=aux7+"_blendWeighted")
    footroll_ctrl.weight >> b2a.attributesBlender
    b2a.i[0].set(0)
    plus.output1D >> b2a.i[1]
    b2a.output >> aux7.rx

    b2a = pm.createNode("blendTwoAttr", n=aux9+"_blendWeighted")
    footroll_ctrl.weight >> b2a.attributesBlender
    footroll_ctrl.rx >> b2a.i[0]
    b2a.i[1].set(0)
    b2a.output >> aux9.rx
    footroll_ctrl.anklePivot >> aux9.rz

    cond = pm.createNode("condition", n=aux6+"_condition")
    cond.operation.set(4)  # <
    footroll_ctrl.rx >> cond.firstTerm
    footroll_ctrl.angle >> cond.secondTerm
    footroll_ctrl.rx >> cond.colorIfTrueR
    footroll_ctrl.angle >> cond.colorIfFalseR
    cond.outColorR >> aux6.rx

    ##Toe IK control
    toe_ik_transform = pm.createNode("transform", n=name+"_toe_ik_control_transform", p=limb_ik_ctrl)
    pm.pointConstraint(aux9, toe_ik_transform)
    pm.orientConstraint(aux8, toe_ik_transform)
    
    toe_ik_ctrl = pm.createNode("transform", n=name+"_toe_ik_control", p=toe_ik_transform)

    rig_utils.curve.makeFromCurve(toe_ik_ctrl, h_toe_ik)
    rig_utils.lockTRS(toe_ik_ctrl, [1, 1, 1], [], [1, 1, 1], 1)
    
    pm.orientConstraint(toe_ik_ctrl, auxToe1)
    
    oc = pm.orientConstraint(ik2, fk2, j2)
    oc.interpType.set(2)
    limb_ikfk_rev.outputX >> oc.w0
    limb_options_ctrl.ikfk >> oc.w1

    pm.pointConstraint(limb_ik_ctrl, aux1, mo=True)
    pm.orientConstraint(limb_ik_ctrl, aux1, mo=True)
    
    # fix stretch
    aux10.pm >> pm.PyNode(name+"_fix_2_distance_multMatrix").matrixIn[0]
    aux10.t >> pm.PyNode(name+"_fix_2_distance_distanceBetween").point2

    aux10.pm >> pm.PyNode(name+"_ik_distance_multMatrix").matrixIn[0]
    aux10.t >> pm.PyNode(name+"_ik_distance_distanceBetween").point2

    if not isQuad:  # for humans
        footroll_ctrl.anklePivot.set(0, k=False, l=True, cb=False)
        footroll_ctrl.freeHeel.set(False, k=False, l=True, cb=False)
    else:  # for quads
        footroll_ctrl.freeHeel.set(True, k=False, l=True, cb=False)

    pm.delete(tmpOrientTransform)

    # Seamless
    limb_moduleInfo = rig_utils.moduleInfo.ModuleInfo(limb_moduleInfo)

    moduleInfo = rig_utils.moduleInfo.ModuleInfo(name+"_foot")
    moduleInfo.setAttr("type", "leg")

    moduleInfo.setAttr("limb", limb_moduleInfo)

    limb_moduleInfo.setParent(moduleInfo)

    switcher.makeSeamlessKinematicSwitching(moduleInfo, "toe_ik", toe_ik_ctrl, toe_fk_ctrl)
    switcher.makeSeamlessKinematicSwitching(moduleInfo, "toe_fk", toe_fk_ctrl, toe_ik_ctrl)

    moduleInfo.setAttr("footroll", footroll_ctrl.message)
]]></run>
</module>
</children>
</module>
<module name="Cleanup" muted="0" uid="7c43912840ca4115857564fb77efbd8c">
<doc><![CDATA[## Summary
The **Cleanup** module tidies a Maya scene after rig generation. It removes unused namespaces, locks or hides unnecessary control attributes, deletes specified node types, clears animation curves, and can report or delete orphaned geometry. The module also organizes remaining controls into a standard rig display hierarchy.

## Inputs
- **`mode`** (`radioButton`):  
  *Helpers* – prepares UI helpers (no cleanup performed).  
  *Run* – executes all cleanup actions.  
- **`keepNamespaces`** (`listBox`):  
  List of namespace names that should **not** be removed during the cleanup.  
- **`removeNodeTypes`** (`listBox`):  
  Node type names (e.g., `ngSkinLayerData`, `ngSkinLayerDisplay`, `ngst2SkinLayerData`, `unknown`) that the module will delete from the scene.

## Outputs
The module does **not** create new nodes or data containers; it performs in‑place modifications to the current Maya scene. After execution, the scene will have:
- Unused namespaces removed (except those in `keepNamespaces`).
- Unnecessary control attributes locked or hidden.
- Specified node types deleted.
- Animation curves (`animCurveTL`, `animCurveTA`, `animCurveTT`, `animCurveTU`) removed.
- Orphaned geometry reported or deleted via the `findUnusedGeo` child module.

## Usage
1. **Configure the module**  
   - Set `mode` to **Run** to perform cleanup.  
   - Add any namespaces that must be preserved to `keepNamespaces`.  
   - Add any node types that should be purged to `removeNodeTypes`.  
2. **Execute**  
   - Run the module. It will sequentially execute its child modules:  
     - `deleteReferences` – removes unused namespaces.  
     - `lockNodes` – locks or hides control attributes and organizes display groups.  
     - `removeNodeTypes` – deletes the specified node types.  
     - `removeAnimCurves` – clears animation curves.  
     - `findUnusedGeo` – reports or deletes orphaned geometry (optional).  
3. **Verify**  
   - Inspect the scene hierarchy to confirm that unwanted nodes are gone and controls are properly locked/hidden.  
   - Use the `findUnusedGeo` module separately if you need to audit or clean up unused geometry before or after the main cleanup.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="keepNamespaces" template="listBox" category="General" connect=""><![CDATA[{"items": ["mouth"], "default": "items"}]]></attr>
<attr name="removeNodeTypes" template="listBox" category="General" connect=""><![CDATA[{"items": ["ngst2MeshDisplay", "ngst2SkinLayerData", "unknown", "nodeGraphEditorInfo"], "default": "items"}]]></attr>
</attributes>
<children>
<module name="importReferences" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
import maya.cmds as cmds

keepNamespaces = ch("../keepNamespaces")

allowed_namespaces = ["UI", "shared"] + keepNamespaces

def importAllReferences():
    references = cmds.file(q=True,r=True)
    while references:
        for ref in references:
            cmds.file(ref,ir=True)
        references = cmds.file(q=True,r=True)

def get_namespaces():
    return [str(ns) for ns in cmds.namespaceInfo(listOnlyNamespaces=True)]

def removeNamespaces():
    cmds.namespace(set=":")
    namespaces = [ns for ns in get_namespaces() if ns not in allowed_namespaces]
    if not namespaces:
        return

    for item in namespaces:
        cmds.namespace(mv=(item, ":"), f=True)
        cmds.namespace(rm=item, f=True)

    remaining = [ns for ns in get_namespaces() if ns not in allowed_namespaces]
    if remaining and len(remaining) < len(namespaces):
        removeNamespaces()

importAllReferences()
removeNamespaces()]]></run>
</module>
<module name="lockNodes" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
import rig_utils

pm.delete(pm.ls(type="dagPose"))

for obj in pm.ls(type="joint"):
    obj.radius.showInChannelBox(False)

    if not obj.jointOrient.inputs():
        obj.jointOrient.setLocked(True)

for obj in pm.ls(type="skinCluster"):
    for a in obj.listAttr():
        if not a.isConnected():
            a.setLocked(True)

for obj in pm.ls(type="mesh"):
    obj.primaryVisibility.set(True)
    obj.castsShadows.set(True)
    obj.receiveShadows.set(True)
    obj.motionBlur.set(True)
    obj.visibleInReflections.set(True)
    obj.visibleInRefractions.set(True)

    v = pm.displaySmoothness(obj, q=True, polygonObject=True)
    if v and v[0] > 1:
        pm.displaySmoothness(obj, divisionsU=0, divisionsV=0, pointsWire=4, pointsShaded=1, polygonObject=1)        

for ik in pm.ls(type="ikHandle"):
    if type(ik.ikSolver.get()) == pm.nt.IkSplineSolver:
        for a in ["dTwistControlEnable","dWorldUpAxis","dWorldUpType"]:
            ik.attr(a).lock()

for n in ["skeleton", "internal", "geometry", "others"]:
    pm.PyNode(n).overrideEnabled.set(1)
    pm.PyNode(n).overrideDisplayType.set(2)

pm.PyNode("skeleton").v.set(False)
pm.PyNode("internal").v.set(False)  
    
if pm.objExists("helpers"):
    pm.delete("helpers")
    
# hide root joints
for j in ["root", "root_joint"]:
    if pm.objExists(j):
        pm.PyNode(j).v.set(False)

# lock pivots
for ctrl in pm.ls("*_control"):
    rig_utils.lockAttr(ctrl.rotatePivot,1)
    rig_utils.lockAttr(ctrl.rotatePivotTranslate,1)
    rig_utils.lockAttr(ctrl.scalePivotTranslate,1)
    rig_utils.lockAttr(ctrl.scalePivot,1)
    ]]></run>
</module>
<module name="removeNodeTypes" muted="0" uid="">
<run><![CDATA[import pymel.core as pm

nodeTypes = ch("../removeNodeTypes")

for nt in nodeTypes:
    pm.delete(pm.ls(type=nt))]]></run>
</module>
<module name="removeAnimCurves" muted="0" uid="">
<run><![CDATA[import pymel.core as pm
pm.delete(pm.ls(type=["animCurveTL", "animCurveTA", "animCurveTT", "animCurveTU"]))]]></run>
</module>
<module name="findUnusedGeo" muted="0" uid="e705e52bf9284751a7ca2ce039a24722">
<run><![CDATA[import pymel.core as pm

out = []

if @nurbs:
    for typ in ["nurbsSurface", "nurbsCurve"]:
        for n in pm.ls(type="nurbsSurface"):
            if not n.create.inputs() and not n.local.outputs() and not n.worldSpace.outputs() and n.intermediateObject.get():
                out.append(n.name())

if @mesh:    
    for n in pm.ls(type="mesh"):
        if not n.inMesh.inputs() and not n.outMesh.outputs() and not n.worldMesh.outputs() and n.intermediateObject.get():
            out.append(n.name())

if out:
    print(out)
    if @remove:
        pm.delete(out)
    else:
        pm.select(out)    ]]></run>
<doc><![CDATA[## Summary
Finds and optionally removes unused geometry nodes (nurbs surfaces, curves, or meshes) that are marked as intermediate objects and have no connections to other nodes. The module reports the names of these nodes, selects them in the scene, or deletes them if the **Remove** option is enabled.

## Inputs
- **`nurbs`** (`checkBox`): When checked, the module searches for unused **nurbsSurface** and **nurbsCurve** nodes.
- **`mesh`** (`checkBox`): When checked, the module searches for unused **mesh** nodes.
- **`remove`** (`checkBox`): When checked, the identified unused nodes are deleted from the scene; otherwise they are simply selected.

## Outputs
- **Console Output**: Prints a list of the names of all unused geometry nodes found.
- **Scene Selection**: If `remove` is unchecked, the nodes are selected in the viewport.
- **Deletion**: If `remove` is checked, the nodes are permanently removed from the scene.

## Usage
1. Open the module in Rig Builder and enable the **Nurbs** and/or **Mesh** checkboxes to specify which geometry types to scan.
2. Optionally check **Remove** if you want the module to delete the unused nodes automatically.
3. Execute the module. The console will display the list of unused geometry names; the nodes will be selected or deleted based on the `remove` setting.]]></doc>
<attributes>
<attr name="nurbs" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="mesh" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="remove" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
</attributes>
</module>
<module name="blockGPU" muted="0" uid="">
<run><![CDATA[import pymel.core as pm

# prevent some nodes to be processed on GPU due to Maya 2026 crashes with Delta Mush
for n in pm.ls(type=@nodeTypes):
    n.blockGPU.set(True)]]></run>
<attributes>
<attr name="nodeTypes" template="listBox" category="General" connect=""><![CDATA[{"items": ["deltaMush"], "default": "items"}]]></attr>
</attributes>
</module>
<module name="findDuplicateNames" muted="0" uid="6408d318d1d345e3950dd96011986644">
<run><![CDATA[import maya.cmds as cmds

nodesByName = {}
for node in cmds.ls(long=True) or []:
    name = node.rsplit("|", 1)[-1]
    nodesByName.setdefault(name, []).append(node)

for name, nodes in sorted(nodesByName.items()):
    if len(nodes) > 1:
        warning("Duplicate name '{}'".format(name))
]]></run>
<doc><![CDATA[## Summary
This module scans the current Maya scene for duplicate node names and logs a warning for each name that appears more than once. It serves as a quick integrity check to help prevent naming conflicts before building rigs or other scene elements.

## Inputs
- **None** – The module operates on the entire scene without requiring any user-specified parameters.

## Outputs
- **Warnings** – For each duplicated short name, a warning message is emitted using the `warning()` API. No new nodes or data structures are created.

## Usage
1. Load the module into Rig Builder and execute it.  
2. Review the output log for any warning messages indicating duplicate names.  
3. Resolve the duplicates in Maya (e.g., rename or delete redundant nodes) before proceeding with rig construction or other automated processes.]]></doc>
</module>
</children>
</module>
<module name="bipedFinishing" muted="0" uid="e536a7df411640bda73a205a15293848">
<run><![CDATA[import pymel.core as pm
import rig_utils

if @mode == 1: # run
    pm.hide(pm.ls("*_average_group"))
    
    for side in ["L", "R"]:
        pm.addAttr(f"{side}_arm_options_control.ikfk", e=True, dv=1)
        pm.PyNode(f"{side}_arm_options_control").ikfk.set(1)
        pm.PyNode(f"{side}_leg_footroll_control").angle.set(@footAngle, k=False, l=True)

        for typ in ["arm", "leg"]:
            pm.PyNode(f"{side}_{type}_ik_control").stretch.set(1)
            pm.PyNode(f"{side}_{type}_ik_polevector_control").stretch.set(1)
]]></run>
<doc><![CDATA[## Summary
The **bipedFinishing** module finalizes a biped rig by applying user‑defined foot roll angles, enabling IK/FK blending on arm controls, activating stretch on all arm and leg IK chains, organizing visibility sets for controls and bend rigs, and hiding default helper groups. It prepares the rig for animation and export by locking and grouping relevant nodes.

## Inputs
- **`mode`** (`radioButton`):  
  - `0` – *Helpers* (no action).  
  - `1` – *Run* (execute finishing steps).  
- **`footAngle`** (`lineEdit`): Desired angle (in degrees) to set on the left and right leg foot‑roll controls (`L_leg_footroll_control`, `R_leg_footroll_control`).  
- **Existing rig nodes** (implicit inputs):  
  - Foot roll controls (`*_footroll_control`).  
  - Arm options controls (`*_arm_options_control`).  
  - IK and pole‑vector controls for arms and legs (`*_ik_control`, `*_ik_polevector_control`).  
  - Visibility sets (`*_visible_set`, `*_others_set`, `*_controls_group`, `*_others_group`, `*_fingers_controls_group`).  
  - Bend rig groups (`*_bendRig_controls_group`, `*_bend_control_null`).  
  - Helper groups (`*_average_group`).

## Outputs
- **Attribute adjustments**:  
  - Sets `ikfk` on arm options controls to `1` and adds a default value attribute.  
  - Enables `stretch` on all arm and leg IK and pole‑vector controls.  
  - Sets the foot roll angle on both leg foot‑roll controls.  
- **Visibility sets**:  
  - Adds control groups to existing visibility sets (`*_visible_set`).  
  - Creates a `bends_visible_set` containing all bend rig groups, tags it with a `type` attribute, and adds it to the global `visible_sets` or `sets` collection.  
- **Node visibility**: Hides all `*_average_group` and the newly created `bends_visible_set` by default.  
- **No new control nodes** are created; the module only modifies and organizes existing rig elements.

## Usage
1. **Prepare the rig**: Ensure all required control nodes and visibility sets exist (created by earlier rig‑building modules).  
2. **Configure the module**:  
   - Set **`mode`** to **`Run`**.  
   - Enter the desired **`footAngle`** value (e.g., `-15` for a slight foot roll).  
3. **Execute**: Run the module. It will apply the foot roll angle, enable IK/FK blending on arms, activate stretch on all IK chains, organize visibility sets, and hide helper groups.  
4. **Verify**: Check that the visibility sets contain the correct control groups and that the `bends_visible_set` is hidden by default.  
5. **Export**: The rig is now ready for animation or asset export, with all finishing adjustments applied.]]></doc>
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
<attr name="footAngle" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": 10, "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>
<module name="finishing" muted="0" uid="">
<attributes>
<attr name="mode" template="radioButton" category="General" connect="/mode"><![CDATA[{"current": 1, "items": ["Helpers", "Run"], "default": "current"}]]></attr>
</attributes>
</module>
</children>
</module>