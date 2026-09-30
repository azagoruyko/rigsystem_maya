<module name="Spine" muted="0" uid="c8f6416f3c69439c94231c47ec5f6114">
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
<attr name="mode" template="radioButton" category="General" connect=""><![CDATA[{"items": ["Helpers", "Run"], "current": 1, "columns": 2, "default": "current"}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_spine", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="joints" template="listBox" category="General" connect=""><![CDATA[{"items": ["M_spine_1_joint", "M_spine_2_joint", "M_spine_3_joint", "M_spine_4_joint", "M_spine_5_joint"], "default": "items"}]]></attr>
<attr name="spans" template="lineEditAndButton" category="Params" connect=""><![CDATA[{"default": "value", "max": "", "validator": 0, "value": 4, "min": "", "buttonEnabled": false}]]></attr>
<attr name="curveOffset" template="vector" category="Params" connect=""><![CDATA[{"default": "value", "value": [0.2, 0.0, 0.0]}]]></attr>
<attr name="attrsOn" template="comboBox" category="Params" connect=""><![CDATA[{"items": ["fk", "ik"], "current": "fk", "default": "current"}]]></attr>
<attr name="parent" template="lineEditAndButton" category="Controls" connect=""><![CDATA[{"value": "", "placeholder": "", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="fkControls" template="table" category="Controls" connect=""><![CDATA[{"default": "items", "items": [["fk_1", 0, ""], ["fk_2", 0.3, ""], ["fk_3", 0.7, ""]], "header": ["Name", "Param", "Orient"]}]]></attr>
<attr name="ikControls" template="table" category="Controls" connect=""><![CDATA[{"items": [["ik_1", 0, ""], ["ik_2", 0.75, ""]], "header": ["Name", "Param", "Orient"], "default": "items"}]]></attr>
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