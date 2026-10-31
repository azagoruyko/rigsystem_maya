<module name="attachToMesh" type="Tools/AttachToMesh" muted="0" uid="4d2ae87b98374c2db77440111d83a5a0">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy

cmds = proxy.cmds

sourceGeo = proxy.node(@sourceGeo)
sourceShape = sourceGeo.getShapes(type="mesh")[0]
objects = proxy.nodes(@objects)

class Rivet():
    def create(self, name, mesh, edge1, edge2, parent):
        self.input = {
            "name": name,
            "oMesh": proxy.node(mesh),
            "edgeIndex1": edge1,
            "edgeIndex2": edge2}

        self.createNodes()
        self.createConnections()
        self.setAttributes()
        
        if parent:
            cmds.parent(
                str(self.output["locator"].getParent()), str(parent)
            )
            
        self.output["locator"].getParent().rename(
            self.input["name"] + "_locator"
        )

        return self.output["locator"].getParent()

    def createNodes(self, *args):
        self.output = {
            "meshEdgeNode1": proxy.create("curveFromMeshEdge", self.input["name"] + "_edge1"),
            "meshEdgeNode2": proxy.create("curveFromMeshEdge", self.input["name"] + "_edge2"),
            "ptOnSurfaceIn": proxy.create("pointOnSurfaceInfo", self.input["name"] + ""),
            "matrixNode": proxy.create("fourByFourMatrix", self.input["name"] + ""),
            "decomposeMatrix": proxy.create("decomposeMatrix", self.input["name"] + ""),
            "loftNode": proxy.create("loft", self.input["name"] + ""),
            "locator": proxy.create("locator")}

    def createConnections(self, *args):
        meshWorld = self.input["oMesh"].worldMesh[0]
        meshWorld >> self.output["meshEdgeNode1"].inputMesh
        meshWorld >> self.output["meshEdgeNode2"].inputMesh
        self.output["meshEdgeNode1"].outputCurve >> self.output["loftNode"].inputCurve[0]
        self.output["meshEdgeNode2"].outputCurve >> self.output["loftNode"].inputCurve[1]
        self.output["loftNode"].outputSurface >> self.output["ptOnSurfaceIn"].inputSurface
        for source, target in (
            ("normalizedNormalX", "in00"),
            ("normalizedNormalY", "in01"),
            ("normalizedNormalZ", "in02"),
            ("normalizedTangentUX", "in10"),
            ("normalizedTangentUY", "in11"),
            ("normalizedTangentUZ", "in12"),
            ("normalizedTangentVX", "in20"),
            ("normalizedTangentVY", "in21"),
            ("normalizedTangentVZ", "in22"),
            ("positionX", "in30"),
            ("positionY", "in31"),
            ("positionZ", "in32"),
        ):
            self.output["ptOnSurfaceIn"].attr(source) >> self.output["matrixNode"].attr(target)
        self.output["matrixNode"].output >> self.output["decomposeMatrix"].inputMatrix
        locatorTransform = self.output["locator"].getParent()
        self.output["decomposeMatrix"].outputTranslate >> locatorTransform.translate
        self.output["decomposeMatrix"].outputRotate >> locatorTransform.rotate
        self.output["locator"].attr("visibility").set(False)

    def setAttributes(self):
        self.output["meshEdgeNode1"].edgeIndex[0].set(self.input["edgeIndex1"])
        self.output["meshEdgeNode2"].edgeIndex[0].set(self.input["edgeIndex2"])

        self.output["loftNode"].reverseSurfaceNormals.set(1)
        cmds.setAttr(str(self.output["loftNode"].inputCurve), size=2)
        self.output["loftNode"].uniform.set(True)
        self.output["loftNode"].sectionSpans.set(3)
        self.output["loftNode"].caching.set(True)

        self.output["ptOnSurfaceIn"].turnOnPercentage.set(True)
        self.output["ptOnSurfaceIn"].parameterU.set(0.5)
        self.output["ptOnSurfaceIn"].parameterV.set(0.5)
        self.output["ptOnSurfaceIn"].caching.set(True)

def findEdges(geo, p):
    meshFn = om.MFnMesh(sourceShape.dagPath)
    _, faceIndex = meshFn.getClosestPoint(om.MPoint(*p), om.MSpace.kWorld)
    faceIt = om.MItMeshPolygon(sourceShape.dagPath)
    faceIt.setIndex(faceIndex)
    edges = faceIt.getEdges()

    separatedEdges = []
    for e1 in edges:
        edge1 = om.MItMeshEdge(sourceShape.dagPath)
        edge1.setIndex(e1)
        vertices1 = {edge1.vertexId(0), edge1.vertexId(1)}
        for e2 in edges:
            edge2 = om.MItMeshEdge(sourceShape.dagPath)
            edge2.setIndex(e2)
            vertices2 = {edge2.vertexId(0), edge2.vertexId(1)}
            diff = vertices1 - vertices2
            if len(diff)==2:
                separatedEdges.append((e1, e2))

    return separatedEdges[0] if separatedEdges else edges[:2]

for obj in objects:     
    print(obj)               
    p = cmds.xform(str(obj), q=True, ws=True, t=True)
    e1, e2 = findEdges(sourceGeo, p)
    rivet = Rivet()
    rivet.create(str(obj).rsplit("|", 1)[-1], sourceShape, e1, e2, None)
    cmds.parentConstraint(
        str(rivet.output["locator"].getParent()), str(obj), mo=True
    )
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
