### [BAX] [XUI] SD XUI_View3D by Star-Dust
### 08/18/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/94809/)

I created a library to display polygons in 3D. It is also possible to use it to create 3D XUI views.  
This library can be used to create 3D models from code or load them from obj files.  
To create a 2D drawing app, to create games, animations, introductions, and 3D effects  
You can find a detailed description of the methods and algorithms used in this **[thread](https://www.b4x.com/android/forum/threads/xui-3d-rotations-and-pivots.93152/)**.  
  
**At the same time I do not authorize to open or decompile in order to obtain the original source. I do not authorize any changes to the source.  
You can use the library in your applications, including commercial ones, by inserting the author's acknowledgment of this library.  
  
The examples must be updated to select the complete version of the library (no longer SD\_XUIView3D\_DEMO but SD\_XUIView3D)  
If you want you can make a donation for this library, I would be grateful.  
  
SD\_XUI\_View3D  
  
Author:** Star-Dust  
**Version:** 0.26  

- **Object3D**

- **Fields:**

- **DrawTime** As Int
- **light\_intensity** As Int
- **ListVerticesOnScreen** As List
- **LoadTime** As Int
- **RotateTime** As Int
- **SortTime** As Int

- **Functions:**

- **AddArcX** (ID As Int, StartDegree As Int, EndDegree As Int, X As Float, Y As Float, Z As Float, R As Int, BorderColor As Int, FillColor As Int) As Object3D
 *Add Arc or Circle (StartDegree=0, EndDegree=360) - round X axis*- **AddArcY** (ID As Int, StartDegree As Int, EndDegree As Int, X As Float, Y As Float, Z As Float, R As Int, BorderColor As Int, FillColor As Int) As Object3D
 *Add Arc or Circle (StartDegree=0, EndDegree=360) - round Y axis*- **AddArcZ** (ID As Int, StartDegree As Int, EndDegree As Int, X As Float, Y As Float, Z As Float, R As Int, BorderColor As Int, FillColor As Int) As Object3D
 *Add Arc or Circle (StartDegree=0, EndDegree=360) - round Z axis*- **AddBitmapCreator** (ID As Int, Bmc As b4a.example.bitmapcreator, P\_TopLeft As Point3D\_Type, P\_TopRight As Point3D\_Type, P\_DownLeft As Point3D\_Type, P\_DownRight As Point3D\_Type) As Object3D
- **AddCube** (ID As Int, X1 As Float, Y1 As Float, Z1 As Float, X2 As Float, Y2 As Float, Z2 As Float, BorderColor As Int, FillColor As Int()) As Object3D
 *Create Cube - Add 6 Polygon - Set Array as Color (min 1, max 6 Color)  
 AddCube(121,10,10,10,-10,-10,-10,xui.Color\_Black,array as int(xui.Color\_White))  
 AddCube(121,10,10,10,-10,-10,-10,xui.Color\_Black,array as int(xui.Color\_White,xui.Color\_Black))*- **AddImage** (ID As Int, Image As B4XBitmap, P\_TopLeft As Point3D\_Type, P\_TopRight As Point3D\_Type, P\_DownLeft As Point3D\_Type, P\_DownRight As Point3D\_Type) As Object3D
 *Add Image - Set Coordinate*- **AddObj3D** (Obj3d As Type\_Polygon) As String
 *For internal use*- **AddPolygon** (ID As Int, PointList As Point3D\_Type(), BorderColor As Int, FillColor As Int) As Object3D
 *Add Polygon, trace path*- **AddRec** (ID As Int, X1 As Float, Y1 As Float, Z1 As Float, X2 As Float, Y2 As Float, Z2 As Float, BorderColor As Int, FillColor As Int) As Object3D
 *Add rectangle, Set TopLeft and DownRight*- **AddSpere** (ID\_Start As Int, X As Float, Y As Float, Z As Float, R As Int, BorderColor As Int, FillColor As Int) As Object3D
 *Create Sphere - Add 300 Polygon*- **AddSpere2** (IDStart As Int, X As Float, Y As Float, Z As Float, R As Int, BorderColor As Int, FillColor As Int, StartLatitude As Int, StopLatitude As Int, StartLongitude As Int, StopLongitude As Int, OrizontalStep As Int, VerticalStep As Int) As Object3D
 *Create Sphere - Add 300 Polygon  
 Latitude : 0-360  
 Longitude: 0-180*- **Class\_Globals** As String
- **Clear** As String
 *Clear all Object*- **CtP** (X As Float, Y As Float, Z As Float) As Point3D\_Type
 *Coordinate To Point*- **CutObj** (IDlist As List) As Object3D
 *Erase Object List, and returns a new list. If the ID list is empty, it does not perform any operation*- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LoadObiectj3D** (Path As String, FileName As String) As Boolean
 *e.g. LoadObiectj3D(File.DirInternal,"object.ddd")*- **LoadObjFile** (ID As Int, Path As String, filename As String, BorderColor As Int, FillColor As Int, LimitsPolygon As Int) As String
 *LimitsPolygon Set 0 to no-limit*- **LoadStlFile** (ID As Int, Path As String, filename As String, BorderColor As Int, FillColor As Int, RatioOfSize As Float) As String
- **MoveObj** (IDlist As List, X As Int, Y As Int, Z As Int) As Object3D
*Move Object List, set IDList to null for rotate all Polygon*- **PointClick** (x As Int, y As Int, Advise As Boolean) As Int
 *Vwerify if point is internal of any Polygon/object - Response -1 if is external*- **RenderToView** (V As B4XView, CenterX As Int, CenterY As Int, ZoomValue As Float, DrawMode As Int) As String
*Select the most suitable method for the draw based on the number of polygons contained  
 DrawMode 0-Traslucent  
 1-Canvas without depth color 2-BitmapCreator without depth color 10-Automatic (Canvas if less 20mil polygon)  
 3-Canvas with depth color 4-BitmapCreator with depth color 20-Automatic (Canvas if less 20mil polygon)*- **Rotate** (IDList As List, DegreeX As Int, DegreeY As Int, DegreeZ As Int) As Object3D
- **Rotate2** (IDList As List, DegreeX As Int, DegreeY As Int, DegreeZ As Int) As Object3D
 *Rotate Polygon List, Set IDList to null for rotate all Polygon (Alternative formulas)*- **RotateX** (IDList As List, Degree As Int) As Object3D
- **RotateY** (IDList As List, Degree As Int) As Object3D
- **RotateZ** (IDList As List, Degree As Int) As Object3D
- **SaveObiectj3D** (Path As String, FileName As String) As Boolean
 *e.g. SaveObiectj3D(File.DirInternal,"object.ddd")*- **setColor** (IDList As List, BorderColor As Int, FillColor As Int) As Object3D
- **setVertices** (OriginalVertices As Point3D\_Type, X As Float, Y As Float, Z As Float) As String
 *Set New Values of Vertices*
- **Properties:**

- **ListObject** As List [read only]
 *return List of Type\_Polygon*- **Obj3DCount** As Int [read only]
 *Count of Object*
  
*![](https://www.b4x.com/android/forum/attachments/69690) ![](https://www.b4x.com/android/forum/attachments/69691) ![](https://www.b4x.com/android/forum/attachments/69692)  
![](https://www.b4x.com/android/forum/attachments/69723) ![](https://www.b4x.com/android/forum/attachments/69766) ![](https://www.b4x.com/android/forum/attachments/69943)  
![](https://www.b4x.com/android/forum/attachments/70150)*