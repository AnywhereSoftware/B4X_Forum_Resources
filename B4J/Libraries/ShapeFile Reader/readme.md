### ShapeFile Reader by tchart
### 11/18/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/164180/)

A wrap of this library;  
  
<https://github.com/diwi/diewald_shapeFileReader>  
  
Should work on B4A as well (but not tested) since its pure Java.  
  
Zip contains library, some test Shapefiles as well as a B4J project with the code below.  
  
Super simple;  
  

```B4X
Dim shp As ShapeFileReader  
    shp.Initialize("C:\Temp\ShapeFiles","ne_110m_admin_0_countries")  
    'shp.Initialize("C:\Temp\ShapeFiles","ne_110m_populated_places")  
    'shp.Initialize("C:\Temp\ShapeFiles","ne_110m_rivers_lake_centerlines")  
          
    Log(shp.ShapeType)  
    Log(shp.FieldCount)  
    Log(shp.ShapeCount)  
    Log(shp.BoundingBox)  
      
    ' Log attribute name, length and type for the first field  
    Log(shp.getFieldName(0))  
    Log(shp.getFieldLength(0))     
    Log(shp.getFieldType(0))  
      
    ' Log first attribute record  
    Log(shp.getRecord(0))  
      
    ' Shape or Geometry is an list of lists of list  
    ' the list is the list of parts (becuase polygons and polylines can consiste of multiple parts)  
    ' within each part is a list of coordinates where coordinates are x,y,z,m  
    ' NOTE the order and direction (eg clockwise) of the parts for polygons determines if the part if a hole or not  
    ' it is up to the client to interpret the order and draw accordingly  
    Dim geom As List = shp.getShape(0)  
      
    Log($"This shape has ${geom.Size} parts"$)  
      
    Dim partzero As List = geom.Get(0)  
      
    Log($"First part has ${partzero.Size} coordinates"$)  
      
    Log("List of coordinates for part")  
    For Each xyzm As List In partzero  
        Log($" - x: ${xyzm.Get(0)} y: ${xyzm.Get(1)} z: ${xyzm.Get(2)} m: ${xyzm.Get(3)}"$)  
    Next
```