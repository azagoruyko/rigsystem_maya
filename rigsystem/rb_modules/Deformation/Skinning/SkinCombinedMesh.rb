<module name="skinCombinedMesh" type="Tools/SkinCombinedMesh" muted="0" uid="37735561d9e24f75844d02b30031a38d">
<run><![CDATA[import maya.api.OpenMaya as om
from rigsystem import proxy
import time

cmds = proxy.cmds

geo = proxy.node(@geo)
fromMeshList = proxy.nodes(@fromMeshList)

class FindClosestVertexData:
    def __init__(self, mesh):
        meshShape = proxy.node(mesh).getShapes(type="mesh")[0]
        self.meshDagPath = meshShape.mdagpath
        self.meshFn = meshShape.mfn(shape=True)

        self.meshIntersector = om.MMeshIntersector()
        self.meshIntersector.create(self.meshDagPath.node(), self.meshDagPath.inclusiveMatrix())

def calculateGeoIndexList(proxyGeo, fromGeoList):
    fromGeoClosestData = []
    t = time.time()
    for m in fromGeoList:
        data = FindClosestVertexData(m)
        fromGeoClosestData.append(data)

    proxyShape = proxyGeo.getShapes(type="mesh")[0]
    proxyFn = proxyShape.mfn(shape=True)
    proxyPoints = proxyFn.getPoints(om.MSpace.kWorld)

    N = len(proxyPoints)

    geoIndexList = [[] for i in range(len(fromGeoList))]
    beginProgress("Calculating mesh indices", N, 0.05)
    for i in range(N):
        stepProgress(i)
        p = proxyPoints[i]

        geoIndex = -1
        dist = 99999
        for k in range(len(fromGeoList)):
            pointOnMesh = fromGeoClosestData[k].meshIntersector.getClosestPoint(
                proxyPoints[i]
            )
            d = (om.MPoint(pointOnMesh.point) - proxyPoints[i]).length()
            if d < dist:
                dist  = d
                geoIndex = k

        geoIndexList[geoIndex].append(i)
        
    endProgress()
    return geoIndexList
                
geoIndexList = calculateGeoIndexList(geo, fromMeshList)
for geoIdx, verticesList in enumerate(geoIndexList):
    cmds.select(str(fromMeshList[geoIdx]))
    cmds.select(
        ["{}.vtx[{}]".format(geo, index) for index in verticesList],
        add=True,
    )
    cmds.copySkinWeights(
        noMirror=True,
        surfaceAssociation="closestPoint",
        influenceAssociation=["oneToOne", "closestJoint"],
    )
    
cmds.select(clear=True)]]></run>
<doc><![CDATA[## Summary  
The **skinCombinedMesh** tool merges skin weight data from several source meshes onto a single target geometry. It calculates the closest vertex mapping between each source mesh and the target, then copies skin weights using Maya’s `copySkinWeights` command, preserving joint influences and weight distribution.

## Inputs  
- **`geo`** – *Target geometry* (the mesh that will receive the combined skin weights).  
- **`fromMeshList`** – *List of source geometries* whose skin weight data will be transferred to `geo`. Each item should be a mesh that already has a skinCluster applied.

## Outputs  
- The **target geometry (`geo`)** will have its skinCluster updated to include the combined weight data from all meshes in `fromMeshList`.  
- No explicit output attributes are created; the operation modifies the existing skinCluster in place.

## Usage  
1. **Select the target geometry** in the viewport or specify its name in the `geo` field.  
2. **Populate `fromMeshList`** with the names of all source meshes that contain the skin weights you want to merge.  
3. Click **Run** (or execute the module). The tool will:
   - Compute the closest vertex mapping between each source mesh and the target.  
   - Copy skin weights from each source to the target using the `closestPoint` strategy, preserving joint influences.  
4. After execution, the target geometry’s skinCluster will reflect the combined weight data, ready for further rigging or animation work.]]></doc>
<attributes>
<attr name="geo" template="lineEditAndButton" category="General" connect=""><![CDATA[{"default": "value", "buttonCommand": "import maya.cmds as cmds\nls = cmds.ls(sl=True)\nif ls: value = ls[0]", "buttonLabel": "<", "value": "cloth_proxy_geo"}]]></attr>
<attr name="fromMeshList" template="listBox" category="General" connect=""><![CDATA[{"default": "items", "items": ["webbing_geo", "ammo_01_geo", "vest_geo", "bags_01_geo", "belt_vest_geo", "vest_back_geo", "belt_back_geo", "shirt_geo"]}]]></attr>
</attributes>
<children>
</children>
</module>
