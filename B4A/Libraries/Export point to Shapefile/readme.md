### Export point to Shapefile by sigster
### 04/09/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170778/)

I was looking for a way to export points to a shape file, I couldn't find anything here and used <https://www.deepseek.com/en/> to help me out, this is the file if anyone needs it, I just needed points so I won't add to this other options  
  
Anyway, this code works fine for me.  
  
the source code are in the ZIP file  
  

```B4X
' Simple Shapefile Export Example - COMPLETE WORKING SAMPLE  
Sub ExportSamplePoints  
    ' 1. Initialize exporter  
    Dim Exporter As ShapefileExporter  
    Exporter.Initialize  
     
    ' 2. Create 3 sample points (Longitude, Latitude, ID, Name)  
    Dim points As List  
    points.Initialize  
    points.Add(Array(-21.942635, 64.146583, 1, "Point A"))  
    points.Add(Array(-21.940000, 64.148000, 2, "Point B"))  
    points.Add(Array(-21.938000, 64.150000, 3, "Point C"))  
     
    ' 3. Define fields (ID and Name)  
    Dim fields As List  
    fields.Initialize  
    fields.Add(Array("ID", "N", 10, 0))    ' Numeric, 10 digits, 0 decimals  
    fields.Add(Array("NAME", "C", 50, 0))  ' Text, 50 characters  
     
    ' 4. WGS84 projection (standard GPS coordinate system)  
    Dim wkt As String = "GEOGCS[""WGS84"",DATUM[""WGS84"",SPHEROID[""WGS84"",6378137,298.257223563]]]"  
     
    ' 5. Create shapefile  
    Dim success As Boolean = Exporter.CreateShapefileFinal(File.DirInternal, "sample_points", points, fields, "UTF-8", wkt)  
     
    ' 6. Check result  
    If success Then  
        Log("Shapefile created successfully in: " & File.DirInternal)  
        Log("Files created:")  
        Log("  - sample_points.shp")  
        Log("  - sample_points.shx")  
        Log("  - sample_points.dbf")  
        Log("  - sample_points.prj")  
        Log("  - sample_points.cpg")  
    Else  
        Log("Failed to create shapefile")  
    End If  
End Sub  
  
' Field definition explanation:  
' fields.Add(Array("NAME", "C", 50, 0))  
'  
' "NAME"  - Field name (appears as column header in GIS)  
'           Maximum 10 characters  
'  
' "C"     - Field Type: C = Character/Text, N = Numeric  
'  
' 50      - Maximum characters this field can store (1-255)  
'           10 = Short names like "P1"  
'           50 = Medium text like "Main Street North"  
'           255 = Maximum length (paragraph)  
'  
' 0       - Decimal places (always 0 for Text fields)
```