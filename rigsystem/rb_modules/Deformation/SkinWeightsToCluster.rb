<module name="SkinWeightsToCluster" muted="0" uid="3a23aeeaaeab4e46b893c1e5725b0f72">
<run><![CDATA[import maya.cmds as cmds
import pymel.core as pm
import rig_utils.skinCluster as skin_utils

mesh = @mesh
bone = pm.PyNode(@bone)
cluster = @cluster

if cmds.nodeType(cluster) != "cluster":
    error(f"'{cluster}' is not a cluster deformer.")

meshShape = (cmds.listRelatives(mesh, shapes=True, noIntermediate=True, fullPath=True) or [mesh])[0]
if cmds.nodeType(meshShape) != "mesh":
    error(f"'{mesh}' is not a polygon mesh.")
if not pm.mel.findRelatedSkinCluster(mesh):
    error(f"'{mesh}' has no skin cluster.")

skinHelper = skin_utils.SkinClusterHelper(mesh)
if skinHelper.getInfluencePhysicalIndex(bone) is None:
    error(f"'{bone}' is not an influence of '{skinHelper.node()}'.")

weights = skinHelper.getInfluenceWeights(bone)
if len(weights) != cmds.polyEvaluate(meshShape, vertex=True):
    error("Skin weight count does not match the mesh vertex count.")

geometries = cmds.deformer(cluster, query=True, geometry=True) or []
geometryIndices = cmds.getAttr(f"{cluster}.outputGeometry", multiIndices=True) or []
if len(geometries) != 1 or len(geometryIndices) != 1:
    error(f"'{cluster}' must deform exactly one geometry.")

clusterGeometry = geometries[0]
clusterShape = (cmds.listRelatives(clusterGeometry, shapes=True, noIntermediate=True, fullPath=True) or
                cmds.ls(clusterGeometry, long=True))[0]
if cmds.nodeType(clusterShape) != "mesh":
    error(f"'{clusterGeometry}' is not a polygon mesh.")
if len(weights) != cmds.polyEvaluate(clusterShape, vertex=True):
    error("The skinned mesh and cluster geometry have different vertex counts.")

geometryIndex = geometryIndices[0]

cmds.setAttr(
    f"{cluster}.weightList[{geometryIndex}].weights[0:{len(weights) - 1}]",
    *weights,
    size=len(weights),
)]]></run>
<doc><![CDATA[## Summary
Copies one bone's skin weights on a polygon mesh to an existing cluster deformer. The skin cluster and its weights remain unchanged.

## Inputs
- `mesh`: Polygon mesh transform or shape with a skin cluster.
- `bone`: Joint influence whose weights will be copied.
- `cluster`: Existing cluster deformer on a target polygon mesh.

## Outputs
- The cluster's per-vertex weights on its target mesh are overwritten with the bone's skin weights.

## Usage
Set the skinned mesh, bone, and cluster node names, then run the module. The cluster must deform exactly one polygon mesh, with the same vertex count and vertex order as the skinned mesh. The target mesh can be separate from the skinned mesh. The cluster must include all target vertices in its deformer set; vertices outside its membership will not deform even if their weights are written.]]></doc>
<attributes>
<attr name="mesh" template="lineEditAndButton" category="Input" connect=""><![CDATA[{"value": "shirt_sleeves_rig_geo", "placeholder": "mesh", "buttonCommand": "import maya.cmds as cmds\nvalue = (cmds.ls(selection=True) or [''])[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="bone" template="lineEditAndButton" category="Input" connect=""><![CDATA[{"value": "L_shirt_sleeve_upper_joint", "placeholder": "bone", "buttonCommand": "import maya.cmds as cmds\nvalue = (cmds.ls(selection=True) or [''])[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
<attr name="cluster" template="lineEditAndButton" category="Input" connect=""><![CDATA[{"value": "L_shirt_sleeve_upper_cluster", "placeholder": "cluster", "buttonCommand": "import maya.cmds as cmds\nvalue = (cmds.ls(selection=True) or [''])[0]", "buttonLabel": "<", "buttonEnabled": true, "min": 0, "max": 100, "validator": 0, "default": "value"}]]></attr>
</attributes>
</module>