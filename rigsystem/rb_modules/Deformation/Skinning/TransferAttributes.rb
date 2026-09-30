<module name="transferAttributes" muted="0" uid="c878100bf5724b20a74098b3a9340a04">
<run><![CDATA[import pymel.core as pm

sourceGeoList = [pm.PyNode(geo) for geo in @sourceGeoList]

# sampleSpace: 0 is world space, 1 is model space, 4 is component-based, 5 is topology-based. 
# the default is world space.
sampleSpace = {"world": 0, "local": 1, "component": 4, "topology": 5}

def findOrig(geo):
    geo = pm.PyNode(geo)
    origs = [sh for sh in geo.getShapes() 
             if not (sh.inMesh.inputs() or sh.worldMesh.inputs()) and\
             geo.numVertices() == sh.numVertices()]
    if origs:
        return origs[0]
    else:
        warning(f"Cannot find orig shape for '{geo}'")

def transferMeshAttributes(shape, newShape):    
    intermediateObject = shape.intermediateObject.get()    
    shape.intermediateObject.set(False)
    
    pm.transferAttributes(
                newShape, shape, 
                transferPositions=@positions, transferNormals=@normals, transferUVs=2 if @uv else 0, # 0, 1-current, 2-all
                transferColors=2 if @colors else 0, sampleSpace=sampleSpace.get(@sampleSpace, 0), searchMethod=3,
                flipUVs=0, colorBorders=0)
                
    if @uv:
        shape.currentUVSet.set(newShape.currentUVSet.get())
                
    pm.delete(shape, ch=True)
    shape.intermediateObject.set(intermediateObject)                          
            
for newMesh in sourceGeoList:
    namespace = newMesh.namespace()
    
    localMesh = str(newMesh.stripNamespace())
    if pm.objExists(localMesh):
        localMesh = pm.PyNode(localMesh)
        origShape = findOrig(localMesh)
        if not origShape:
            error(f"Cannot find orig shape for {localMesh}")
            continue
            
        newShape = newMesh.getShape()
        
        print(f"{newShape} -> {origShape}")        
        transferMeshAttributes(origShape, newMesh)            
    else:        
        warning(f"Cannot find {localMesh}")
]]></run>
<doc><![CDATA[## Summary  
Transfers vertex positions, normals, UVs, and vertex colors from an original mesh shape to a new mesh shape while preserving the original mesh’s intermediate state. The module locates the original shape that matches the new mesh’s topology and applies Maya’s `transferAttributes` command to copy the selected attributes.

## Inputs  
- **`sourceGeoList`** – List of new mesh objects whose attributes will be updated.  
- **`positions`** – Boolean flag (`True`/`False`) to transfer vertex positions.  
- **`normals`** – Boolean flag to transfer vertex normals.  
- **`uv`** – Boolean flag to transfer UV sets (all UVs if `True`).  
- **`colors`** – Boolean flag to transfer vertex colors (all colors if `True`).  
- **`sampleSpace`** – Integer specifying the sampling space for the transfer (0 = world, 1 = local, 2 = world space).  

## Outputs  
- The module does not create new nodes; it modifies the existing meshes in place.  
- It prints a mapping of each new shape to its original shape and logs warnings or errors if an original shape cannot be found.

## Usage  
1. **Set the inputs** in the module’s attribute panel:  
   - Provide the list of new meshes in `sourceGeoList`.  
   - Toggle `positions`, `normals`, `uv`, and `colors` to indicate which attributes should be copied.  
   - Choose an appropriate `sampleSpace` value.  
2. **Execute the module**.  
   - The script will iterate over each mesh, locate the matching original shape, and transfer the selected attributes.  
   - Any issues (missing original shape, mismatched topology) will be reported via warnings or errors.  
3. **Verify the results** by inspecting the new meshes; the transferred attributes should now match those of the original shapes.]]></doc>
<attributes>
<attr name="sourceGeoList" template="listBox" category="General" connect=""><![CDATA[{"items": ["chr_abendis_MDL_Model_v018:shoulders_geo", "chr_abendis_MDL_Model_v018:shoulders_belt_geo", "chr_abendis_MDL_Model_v018:sleeve_geo", "chr_abendis_MDL_Model_v018:bracelet_geo", "chr_abendis_MDL_Model_v018:bracers_geo", "chr_abendis_MDL_Model_v018:body_geo"], "default": "items"}]]></attr>
<attr name="positions" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="normals" template="checkBox" category="General" connect=""><![CDATA[{"default": "checked", "checked": true}]]></attr>
<attr name="uv" template="checkBox" category="General" connect=""><![CDATA[{"checked": true, "default": "checked"}]]></attr>
<attr name="colors" template="checkBox" category="General" connect=""><![CDATA[{"checked": false, "default": "checked"}]]></attr>
<attr name="sampleSpace" template="comboBox" category="General" connect=""><![CDATA[{"items": ["world", "local", "component", "topology"], "current": "component", "default": "current"}]]></attr>
</attributes>
</module>