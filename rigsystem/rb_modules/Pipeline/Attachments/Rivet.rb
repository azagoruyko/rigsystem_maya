<module name="rivet" muted="0" uid="88e30aae9d5745fcb70ee99e215ea28d">
<run><![CDATA[import pymel.core as pm

class Rivet():
    """Create a rivet
    Thanks to http://jinglezzz.tumblr.com for the tutorial :)
    """

    def create(self, mesh, edge1, edge2, parent):
        self.sources = {
            "oMesh": mesh,
            "edgeIndex1": edge1,
            "edgeIndex2": edge2}

        self.createNodes()
        self.createConnections()
        self.setAttributes()
        if parent:
            pm.parent(self.o_node["locator"].getParent(), parent)
            
        pm.rename(self.o_node["locator"].getParent(), @name+"_locator")

        return self.o_node["locator"].getParent()

    def createNodes(self, *args):
        self.o_node = {
            "meshEdgeNode1": pm.createNode("curveFromMeshEdge", n=@name+"_edge1_curveFromMeshEdge"),
            "meshEdgeNode2": pm.createNode("curveFromMeshEdge", n=@name+"_edge2_curveFromMeshEdge"),
            "ptOnSurfaceIn": pm.createNode("pointOnSurfaceInfo", n=@name+"_pointOnSurfaceInfo"),
            "matrixNode": pm.createNode("fourByFourMatrix", n=@name+"_fourByFourMatrix"),
            "decomposeMatrix": pm.createNode("decomposeMatrix", n=@name+"_decomposeMatrix"),
            "loftNode": pm.createNode("loft", n=@name+"_loft"),
            "locator": pm.createNode("locator")
        }

    def createConnections(self, *args):
        self.sources["oMesh"].worldMesh.connect(
            self.o_node["meshEdgeNode1"].inputMesh)
        self.sources["oMesh"].worldMesh.connect(
            self.o_node["meshEdgeNode2"].inputMesh)
        self.o_node["meshEdgeNode1"].outputCurve.connect(
            self.o_node["loftNode"].inputCurve[0])
        self.o_node["meshEdgeNode2"].outputCurve.connect(
            self.o_node["loftNode"].inputCurve[1])
        self.o_node["loftNode"].outputSurface.connect(
            self.o_node["ptOnSurfaceIn"].inputSurface)
        self.o_node["ptOnSurfaceIn"].normalizedNormalX.connect(
            self.o_node["matrixNode"].in00)
        self.o_node["ptOnSurfaceIn"].normalizedNormalY.connect(
            self.o_node["matrixNode"].in01)
        self.o_node["ptOnSurfaceIn"].normalizedNormalZ.connect(
            self.o_node["matrixNode"].in02)
        self.o_node["ptOnSurfaceIn"].normalizedTangentUX.connect(
            self.o_node["matrixNode"].in10)
        self.o_node["ptOnSurfaceIn"].normalizedTangentUY.connect(
            self.o_node["matrixNode"].in11)
        self.o_node["ptOnSurfaceIn"].normalizedTangentUZ.connect(
            self.o_node["matrixNode"].in12)
        self.o_node["ptOnSurfaceIn"].normalizedTangentVX.connect(
            self.o_node["matrixNode"].in20)
        self.o_node["ptOnSurfaceIn"].normalizedTangentVY.connect(
            self.o_node["matrixNode"].in21)
        self.o_node["ptOnSurfaceIn"].normalizedTangentVZ.connect(
            self.o_node["matrixNode"].in22)
        self.o_node["ptOnSurfaceIn"].positionX.connect(
            self.o_node["matrixNode"].in30)
        self.o_node["ptOnSurfaceIn"].positionY.connect(
            self.o_node["matrixNode"].in31)
        self.o_node["ptOnSurfaceIn"].positionZ.connect(
            self.o_node["matrixNode"].in32)
        self.o_node["matrixNode"].output.connect(
            self.o_node["decomposeMatrix"].inputMatrix)
        self.o_node["decomposeMatrix"].outputTranslate.connect(
            self.o_node["locator"].getParent().translate)
        self.o_node["decomposeMatrix"].outputRotate.connect(
            self.o_node["locator"].getParent().rotate)
        self.o_node["locator"].attr("visibility").set(False)

    def setAttributes(self):
        self.o_node["meshEdgeNode1"].edgeIndex[0].set(
            self.sources["edgeIndex1"])
        self.o_node["meshEdgeNode2"].edgeIndex[0].set(
            self.sources["edgeIndex2"])

        self.o_node["loftNode"].reverseSurfaceNormals.set(1)
        self.o_node["loftNode"].inputCurve.set(size=2)
        self.o_node["loftNode"].uniform.set(True)
        self.o_node["loftNode"].sectionSpans.set(3)
        self.o_node["loftNode"].caching.set(True)

        self.o_node["ptOnSurfaceIn"].turnOnPercentage.set(True)
        self.o_node["ptOnSurfaceIn"].parameterU.set(0.5)
        self.o_node["ptOnSurfaceIn"].parameterV.set(0.5)
        self.o_node["ptOnSurfaceIn"].caching.set(True)

ls = pm.ls(sl=True, fl=True)
if ls and len(ls)==2:
    e1, e2 = ls
   
    rivet = Rivet()
    rivet.create(e1.node(), e1.index(), e2.index(), None)
else:
    error("Select two mesh edges")    ]]></run>
<doc><![CDATA[## Summary
Creates a surface‑constrained locator (rivet) that follows the midpoint of two selected mesh edges. The locator is positioned using a point‑on‑surface node and is hidden by default, ready to be used as a control or reference for deforming geometry.

## Inputs
- **Selection of two mesh edges**: The module operates on the two edges currently selected in the scene.  
- **`name` attribute**: Text entered in the `name` field determines the base name of the created locator transform (`<name>_locator`).

## Outputs
- **Locator transform**: A new transform node named `<name>_locator` that is parented to the created locator shape. It is positioned at the surface point halfway between the two selected edges and is invisible by default.  
- **Internal helper nodes**: `curveFromMeshEdge`, `pointOnSurfaceInfo`, `loft`, `fourByFourMatrix`, and `decomposeMatrix` are created and connected internally but are not exposed as outputs.

## Usage
1. In the viewport, select **exactly two mesh edges**.  
2. Enter a desired base name in the `name` field (e.g., `M_belt_buckle`).  
3. Click **Run**.  
4. A hidden locator named `<name>_locator` will appear at the midpoint of the two edges.  
5. Use this locator as a control, reference, or helper for attaching other objects or driving deformations.]]></doc>
<attributes>
<attr name="" template="label" category="General" connect=""><![CDATA[{"default": "text", "text": "Select two mesh edges and <b>Run</b>."}]]></attr>
<attr name="name" template="lineEditAndButton" category="General" connect=""><![CDATA[{"value": "M_belt_buckle", "placeholder": "", "buttonCommand": "print(\"Hello, world!\")", "buttonLabel": "Button", "buttonEnabled": false, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>