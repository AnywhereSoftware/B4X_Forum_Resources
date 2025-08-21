### Load and Save KML file (kmz) by Star-Dust
### 05/26/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/118226/)

Several have asked how to create a KML file (or KMZ if compressed) starting from a map generated with the GMap library.  
  
A KMZ specification is not simply a compressed KML file, but it can also contain other files, such as marker images if they are customized.  
  
I started from a precious [**example**](https://www.b4x.com/android/forum/threads/googlemapsdemo.91906/#post-580520) created by [USER=904]@klaus[/USER] in [**this thread**](https://www.b4x.com/android/forum/threads/googlemapsdemo.91906/#post-580520). Indeed I take this opportunity and thank him warmly, because in addition to making his project available, it allowed him to know the GoogleMapExt class code and was very instructive.  
  
Starting from this project, I can save the polygons created in a **KML** with this sub and be opened by **Google Earth** or absorbed in **Google Map** or **My Map**.  
  
You can extend this library to add PolyLine, Markers and other shapes. This then is up to you. I believe that giving the starting point and then allowing others to develop on it is more useful than giving everything ready.  
  
I omitted some function that allow you to find the name and the color of the Polygon, but I am sure you will be able to do it yourself.  
  

```B4X
SaveKml(file.DirApp,"mypol.kml")  
  
Sub SaveKml(Path As String, NameFile As String)  
    Dim PolygonColor As String = "ff0f0f0f" ' gray  
  
    ' KML String  
    Dim Kml As String = $"<?xml version="1.0" encoding="UTF-8"?>  
<kml xmlns="http://www.opengis.net/kml/2.2">  
    <Document>  
     <name>${NameFile.Replace(".kml","")}</name>  
####  
[[]]  
    </Document>  
</kml>"$  
  
        'Style Polygon  
        Dim Style As String =""  
        For ii= 0 To ListPolygon.Size-1  
            ' If possible, the color of the polygons should be different  
            Style=$"${Style}  
            <Style id="poly-${ii}">  
                  <LineStyle>  
                    <color>ff000000</color>  
                    <width>1.2</width>  
                  </LineStyle>  
                  <PolyStyle>  
                    <color>${PolygonColor}</color>  
                    <fill>1</fill>  
                    <outline>1</outline>  
                  </PolyStyle>  
            </Style>"$  
        Next  
  
        'Polygon  
        Dim PolygonKml As String = $"  
    <Folder>  
     <name>Congregazioni</name>"$  
        Private joPoint, joCurrentDrawPath As JavaObject  
        Private joCurrentDrawPath As JavaObject  
        joCurrentMapShape = joCurrentMapShape.InitializeNewInstance("com.lynden.gmapsfx.shapes.Polygon", Null)  
        Dim NumeroPoligono As Int = 0  
        For Each mpg As MapPolygon In ListPolygon  
            joCurrentMapShape = mpg  
            joCurrentDrawPath = joCurrentDrawPath.InitializeNewInstance("com.lynden.gmapsfx.javascript.object.MVCArray", Null)  
            joCurrentDrawPath = joCurrentMapShape.RunMethod("getPath", Null)  
  
        PolygonKml=$"${Poligoni}  
      <Placemark>  
        <name>${NamePolygon.get(i))}</name>  
        <styleUrl>#poly-$1.0{NumeroPoligono}</styleUrl>  
        <Polygon>  
            <outerBoundaryIs>  
            <LinearRing>  
            <tessellate>1</tessellate>  
            <coordinates>"$  
     
            Private i As Int  
            Private Size As Int = joCurrentDrawPath.RunMethod("getLength", Null)  
   
            For i = 0 To Size - 1  
                joPoint = joCurrentDrawPath.RunMethod("getAt", Array As Object (i))  
                Private ll As LatLng = joPoint.InitializeNewInstance("com.lynden.gmapsfx.javascript.object.LatLong", Array(joPoint))  
                PolygonKml=$"${PolygonKml}  
                ${ll.Longitude},${ll.Latitude},0"$  
            Next  
            PolygonKml=$"${PolygonKml}  
            </coordinates>  
            </LinearRing>  
              </outerBoundaryIs>  
      </Polygon>  
    </Placemark>"$  
            NumeroPoligono=NumeroPoligono+1  
        Next  
        PolygonKml=$"${PolygonKml}  
        </Folder>"$  
  
  
        Kml=Kml.Replace("[[]]",PolygonKml).Replace("####",Style)  
        File.WriteString(Path,NameFile,Kml)  
  
End Sub
```

  
  
**P.S:** A little note:  
The characters #### and [[]] inserted in the KML string, are inserted to be subsequently replaced by the style and coordinates of the polygons. (see row 76)  
  
Each style will be assigned an ID. Each polygon can recall a style by indicating its ID. In this example I numbered them with poly-nn… to facilitate the example.