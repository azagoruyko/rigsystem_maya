<module name="attachToMesh" type="Tools/AttachToMesh" muted="0" uid="4d2ae87b98374c2db77440111d83a5a0">
<run><![CDATA[import pymel.core as pm

sourceGeo = pm.PyNode(@sourceGeo)
objects = [pm.PyNode(o) for o in @objects]

class Rivet():
    def create(self, name, mesh, edge1, edge2, parent):
        self.input = {
            "name": name,
            "oMesh": mesh,
            "edgeIndex1": edge1,
            "edgeIndex2": edge2}

        self.createNodes()
        self.createConnections()
        self.setAttributes()
        
        if parent:
            pm.parent(self.output["locator"].getParent(), parent)
            
        pm.rename(self.output["locator"].getParent(), self.input["name"]+"_locator")

        return self.output["locator"].getParent()

    def createNodes(self, *args):
        self.output = {
            "meshEdgeNode1": pm.createNode("curveFromMeshEdge", n=self.input["name"]+"_edge1_curveFromMeshEdge"),
            "meshEdgeNode2": pm.createNode("curveFromMeshEdge", n=self.input["name"]+"_edge2_curveFromMeshEdge"),
            "ptOnSurfaceIn": pm.createNode("pointOnSurfaceInfo", n=self.input["name"]+"_pointOnSurfaceInfo"),
            "matrixNode": pm.createNode("fourByFourMatrix", n=self.input["name"]+"_fourByFourMatrix"),
            "decomposeMatrix": pm.createNode("decomposeMatrix", n=self.input["name"]+"_decomposeMatrix"),
            "loftNode": pm.createNode("loft", n=self.input["name"]+"_loft"),
            "locator": pm.createNode("locator")}

    def createConnections(self, *args):
        self.input["oMesh"].worldMesh.connect(self.output["meshEdgeNode1"].inputMesh)
        self.input["oMesh"].worldMesh.connect(self.output["meshEdgeNode2"].inputMesh)
        self.output["meshEdgeNode1"].outputCurve.connect(self.output["loftNode"].inputCurve[0])
        self.output["meshEdgeNode2"].outputCurve.connect(self.output["loftNode"].inputCurve[1])
        self.output["loftNode"].outputSurface.connect(self.output["ptOnSurfaceIn"].inputSurface)
        self.output["ptOnSurfaceIn"].normalizedNormalX.connect(self.output["matrixNode"].in00)
        self.output["ptOnSurfaceIn"].normalizedNormalY.connect(self.output["matrixNode"].in01)
        self.output["ptOnSurfaceIn"].normalizedNormalZ.connect(self.output["matrixNode"].in02)
        self.output["ptOnSurfaceIn"].normalizedTangentUX.connect(self.output["matrixNode"].in10)
        self.output["ptOnSurfaceIn"].normalizedTangentUY.connect(self.output["matrixNode"].in11)
        self.output["ptOnSurfaceIn"].normalizedTangentUZ.connect(self.output["matrixNode"].in12)
        self.output["ptOnSurfaceIn"].normalizedTangentVX.connect(self.output["matrixNode"].in20)
        self.output["ptOnSurfaceIn"].normalizedTangentVY.connect(self.output["matrixNode"].in21)
        self.output["ptOnSurfaceIn"].normalizedTangentVZ.connect(self.output["matrixNode"].in22)
        self.output["ptOnSurfaceIn"].positionX.connect(self.output["matrixNode"].in30)
        self.output["ptOnSurfaceIn"].positionY.connect(self.output["matrixNode"].in31)
        self.output["ptOnSurfaceIn"].positionZ.connect(self.output["matrixNode"].in32)
        self.output["matrixNode"].output.connect(self.output["decomposeMatrix"].inputMatrix)
        self.output["decomposeMatrix"].outputTranslate.connect(self.output["locator"].getParent().translate)
        self.output["decomposeMatrix"].outputRotate.connect(self.output["locator"].getParent().rotate)
        self.output["locator"].attr("visibility").set(False)

    def setAttributes(self):
        self.output["meshEdgeNode1"].edgeIndex[0].set(self.input["edgeIndex1"])
        self.output["meshEdgeNode2"].edgeIndex[0].set(self.input["edgeIndex2"])

        self.output["loftNode"].reverseSurfaceNormals.set(1)
        self.output["loftNode"].inputCurve.set(size=2)
        self.output["loftNode"].uniform.set(True)
        self.output["loftNode"].sectionSpans.set(3)
        self.output["loftNode"].caching.set(True)

        self.output["ptOnSurfaceIn"].turnOnPercentage.set(True)
        self.output["ptOnSurfaceIn"].parameterU.set(0.5)
        self.output["ptOnSurfaceIn"].parameterV.set(0.5)
        self.output["ptOnSurfaceIn"].caching.set(True)

def findEdges(geo, p):
    _, f = geo.getClosestPoint(p)
    edges = geo.f[f].getEdges()

    separatedEdges = []
    for e1 in edges:
        for e2 in edges:
            diff = set(geo.e[e1].connectedVertices()) - set(geo.e[e2].connectedVertices())
            if len(diff)==2:
                separatedEdges.append((e1, e2))

    return separatedEdges[0] if separatedEdges else edges[:2]

for obj in objects:     
    print(obj)               
    p = pm.xform(obj, q=True, ws=True, t=True)
    e1, e2 = findEdges(sourceGeo, p)
    rivet = Rivet()
    rivet.create(obj.name(), sourceGeo, e1, e2, None)
    pm.parentConstraint(rivet.output["locator"].getParent(), obj, mo=True)
]]></run>
<doc><![CDATA[## Summary
Creates a rivet system that attaches each selected object to a specified mesh surface. For every object, a hidden locator is generated at the nearest mesh edge and a parent constraint is applied so the object follows the mesh deformation.

## Inputs
- **`sourceGeo`** – The mesh node that will serve as the attachment surface.  
- **`objects`** – A list of transform nodes (e.g., joints, controls, or helpers) that should be bound to the mesh.

## Outputs
- **Locator nodes** – For each object, a locator named `<object>_locator` is created and positioned on the mesh surface.  
- **Parent constraints** – Each object is parent‑constrained to its corresponding locator (maintaining the object's world transform).  
- **Internal nodes** – The module internally creates `curveFromMeshEdge`, `pointOnSurfaceInfo`, `fourByFourMatrix`, `decomposeMatrix`, and `loft` nodes to drive the locator’s position and orientation.

## Usage
1. Select the mesh you want to attach to and set it in the **`sourceGeo`** field.  
2. Populate the **`objects`** list with the transforms you wish to bind.  
3. Run the module. It will generate a hidden locator for each object and apply a parent constraint so the object follows the mesh deformation.  
4. Use the created locators as reference points for further rigging or animation tasks.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Attach <b>objects</b> to <b>source</b> mesh using rivet."}]]></attr>
<attr name="sourceGeo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "outputCloth1"}]]></attr>
<attr name="objects" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["skirt_A_1_joint", "skirt_A_2_joint", "skirt_A_3_joint", "skirt_A_4_joint", "skirt_A_5_joint", "skirt_A_6_joint", "skirt_A_7_joint", "skirt_A_8_joint", "skirt_B_1_joint", "skirt_B_2_joint", "skirt_B_3_joint", "skirt_B_4_joint", "skirt_B_5_joint", "skirt_B_6_joint", "skirt_B_7_joint", "skirt_B_8_joint", "skirt_C_1_joint", "skirt_C_2_joint", "skirt_C_3_joint", "skirt_C_4_joint", "skirt_C_5_joint", "skirt_C_6_joint", "skirt_C_7_joint", "skirt_C_8_joint", "skirt_D_1_joint", "skirt_D_2_joint", "skirt_D_3_joint", "skirt_D_4_joint", "skirt_D_5_joint", "skirt_D_6_joint", "skirt_D_7_joint", "skirt_D_8_joint"]}]]></attr>
</attributes>
<children>
</children>
</module>