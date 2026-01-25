### [XUI]   xSD_OpenMaps by Star-Dust
### 01/21/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169391/)

**NOTE**  
In **B4A** add in manifest  

```B4X
CreateResourceFromFile(Macro, Core.NetworkClearText)
```

  
   
B4J Version [**here**](https://www.b4x.com/android/forum/threads/jsd_openmaps.166066/)  
  
**xSD\_OpenMaps  
  
Author:** Star-Dust  
**Version:** 1.01  

- **CameraPosition**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (Lat As Double, Lng As Double, Zoom As Float) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Target** As String
- **ToString** As String

- **Properties:**

- **Lat** As Double [read only]
- **Lng** As Double [read only]
- **Zoom** As Float [read only]

- **LatLng**

- **Fields:**

- **Latitude** As Double
- **Longitude** As Double

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (Lat As Double, Lng As Double) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **MapCircle**

- **Functions:**

- **Class\_Globals** As String
- **GetCenter** As ResumableSub
*<code>wait for (Circle.GetCenter) COMPLETE (Position As LatLng)</code>*- **GetRadius** As ResumableSub
*<code>wait for (Circle.GetRadius) COMPLETE (Radius As Double)</code>*- **Initialize** (vCenter As LatLng, vRadius As Double, Visble As Boolean, id As String, WebView As WebView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **ID** As String [read only]
- **Visible** As Boolean

- **MapInfoWindow**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (vContent As String, vPosition As LatLng, ID As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **Content** As String [read only]
- **ID** As String [read only]
- **Position** As LatLng [read only]

- **MapLabel**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (vPosition As LatLng, vText As String, vPermanent As Boolean, vID As String, WebView As WebView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **ID** As String [read only]
- **Permanent** As Boolean [read only]
- **Position** As LatLng [read only]
- **Text** As String

- **MapPolygon**

- **Functions:**

- **Class\_Globals** As String
- **GetFillColor** As ResumableSub
*<code>wait for (MapPolygon.GetFillColor) COMPLETE(FillColor As Int)</code>*- **GetLineColor** As ResumableSub
*<code>wait for (MapPolygon.GetLineColor) COMPLETE(LineColor As Int)</code>*- **GetLineWidth** As ResumableSub
*<code>wait for (MapPolygon.GetLineWidth) COMPLETE(LineWidth As Int)</code>*- **GetPoints** As ResumableSub
 *List of LatLng  
 <code>wait for (MapPolygon.GetPoints) COMPLETE(Points As List)</code>*- **Initialize** (Visble As Boolean, ID As String, Point As List, StrokeWidth As Int, StrokeColor As Int, FillColor As Int, Opacity As Double, WebView As WebView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **ID** As String [read only]
- **Opacity** As Float [read only]
- **Visible** As Boolean

- **MapPolyline**

- **Functions:**

- **Class\_Globals** As String
- **GetLineColor** As ResumableSub
 *<code>Wait For (MapPoly.GetLineColor) COMPLETE (Color As Int)</code>*- **GetLineWidth** As ResumableSub
 *<code>Wait For (MapPoly.GetLineWidth) COMPLETE (LineWidth As Int)</code>*- **GetPoints** As ResumableSub
 *List of LatLng  
 <code>Wait For (MapPoly.GetPoints) COMPLETE (ListPoints As List)</code>*- **Initialize** (Visble As Boolean, ID As String, Point As List, StrokeWidth As Int, StrokeColor As Int, WebView As WebView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **ID** As String [read only]
- **Visible** As Boolean

- **Marker**

- **Functions:**

- **Class\_Globals** As String
- **CreateLabel** (Text As String) As String
 *Create Label on Marker*- **GetIconUrl** As ResumableSub
*<code>wait for (MK.GetIconUrl) COMPLETE (URL As String)</code>*- **GetPosition** As ResumableSub
*<code>wait for (MK.GetPosition) COMPLETE (Position As LatLng)</code>*- **GetTitle** As ResumableSub
*<code>wait for (Mk.GetTitle) COMPLETE (Title As String)</code>*- **Initialize** (vPosition As LatLng, vTitle As String, vIconUri As String, vVisible As Boolean, vID As String, WebView As WebView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **UpdateLabel** (Text As String) As String
 *Set Text empty for remove*
- **Properties:**

- **IconUri** As String [read only]
- **ID** As String [read only]
- **Visible** As Boolean

- **OpenMaps**

- **Events:**

- **CameraChange** (CamPosition As CameraPosition)
- **CircleClick** (SelectedCircle As MapCircle)
- **Click** (Point As LatLng)
- **DblClick** (Point As LatLng)
- **MarkerClick** (SelectedMarker As Marker)
- **PolygonClick** (SelectedPolygon As MapPolygon)
- **PolylineClick** (SelectedPolyline As MapPolyline)
- **Ready**
- **TouchMove** (Point As LatLng)

- **Fields:**

- **MAP\_TYPE\_CARTO** As Int
- **MAP\_TYPE\_ESI** As Int
- **MAP\_TYPE\_ESI\_SATELLITE** As Int
- **MAP\_TYPE\_HYBRID** As Int
- **MAP\_TYPE\_NORMAL** As Int
- **MAP\_TYPE\_SATELLITE** As Int
- **MAP\_TYPE\_TERRAIN** As Int
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddCircle** (ll As LatLng, Radius As Double, StrokeWidth As Float, StrokeColor As Int, FillColor As Int, Opacity As Double) As MapCircle
*Adds a circle To the map.  
 Center - Position of the circle center.  
 Radius - Circle radius.  
 StrokeWidth - Stroke width.  
 StrokeColor - Stroke color.  
 FillColor - Inner color.  
 Opacity - Inner color opacity. Value between 0 To 1.*- **AddInfoWindow** (Content As String, Position As LatLng) As MapInfoWindow
*Opens an info window with the given HTML content at the specified position.*- **AddInfoWindow2** (Content As String, Position As LatLng, MaxWidth As Int) As MapInfoWindow
*Opens an info window with the given HTML content at the specified position. It cannot be larger than MaxWidth (in pixels).*- **AddMarker** (Lat As Double, Lng As Double, Title As String) As Marker
 *Adds a marker to the map.*- **AddMarker2** (Lat As Double, Lng As Double, Title As String, IconUri As String) As ResumableSub
*Adds a marker To the map with a custom icon.  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>WAIT FOR (gmap.AddMarker2(10, 10, "This is a test", IconUrl)) COMPLETE (MK as Marker)</code>  
see <https://kml4earth.appspot.com/icons.html> for icons*- **AddMarker2Label** (Lat As Double, Lng As Double, Title As String, Label As String, IconUri As String) As ResumableSub
*Adds a marker To the map with a custom icon and label  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>WAIT FOR (gmap.AddMarker2(10, 10, "This is a test", "http:address.ico")) COMPLETE (Mk As Marker)</code>*- **AddMarker3** (Lat As Double, Lng As Double, Title As String, IconUri As String, Width As Int, Height As Int) As Marker
*Adds a marker To the map with a custom icon.  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>gmap.AddMarker2(10, 10, "This is a test", File.GetUri(File.DirAssets, "SomeIcon.png",32,32))</code>  
see <https://kml4earth.appspot.com/icons.html> for icons*- **AddMarker3Label** (Lat As Double, Lng As Double, Title As String, Label As String, IconUri As String, Width As Int, Height As Int) As Marker
*Adds a marker To the map with a custom icon and label.  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>gmap.AddMarker2(10, 10, "This is a test", File.GetUri(File.DirAssets, "SomeIcon.png",32,32))</code>*- **AddPolygon** (Points As List, StrokeWidth As Float, StrokeColor As Int, FillColor As Int, Opacity As Double) As MapPolygon
*Adds a polygon To the map.  
 Points - A list Or Array of LatLng points.  
 es. array(array(41.90, 12.49),array(41.80, 12.50),array(41.85, 12.60))  
 StrokeWidth - Stroke width.  
 StrokeColor - Stroke color.  
 FillColor - Inner color.  
 Opacity - Inner color opacity. Value between 0 To 1.*- **AddPolyline** (Points As List, StrokeWidth As Float, StrokeColor As Int) As MapPolyline
*Adds a polyline To the map.  
 Points - A list Or Array of LatLng points.  
 Width - Line width.  
 Color - Line color.  
 CloseInfoWindow (InfoWindow As InfoWindow)  
 Closes the specified info window.*- **AllVisibleMapObjects** As String
- **AlternativeMap** (url As String, maxZoom As Int, attribution As String) As String
- **CameraPosition** As ResumableSub
*Returns the current camera position.  
 <code>wait for (OM.GetTitle) CameraPosition (cp As CameraPosition)</code>*- **Class\_Globals** As String
- **ClearMap** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **EditConfigure** (Offset As Double, Tollerance As Int) As String
 *Offset -> Map difference; Tollerance -> Editing Poly point*- **EditingActive** As Boolean
- **EditingCircle** (Circle As MapCircle, Active As Boolean) As ResumableSub
*<code>wait for (OM.EditingCircle(Circle,True)) COMPLETE (Success As Boolean)</code>  
 OR  
 <code>OM.EditingCircle(Circle,True)</code>*- **EditingPolygon** (Polygon As MapPolygon, Active As Boolean) As ResumableSub
 *If an element is already in editing, it is not possible to edit another at the same time.  
 Dim Success As Boolean = OpenMap.EditingPolygon(Polygon,True)  
 <code>Wai For (OpenMaps.EditingPolygon(Polygon, True)) COMPLETE (Success As Boolean)</code>*- **EditingPolyline** (Polyline As MapPolyline, Active As Boolean) As ResumableSub
*<code>Wait For (OM.EditingPolyline(PolyLine,True)) COMPLETE (Success As Boolean)</code>*- **filterVisibleMapObjects** As String
 *Makes only the objects visible inside the visible map (Bounds)*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **IsReady** As Boolean
- **LatLonToXY** (ll As LatLng) As ResumableSub
*<code>wait for (OM.LatLonToXY(ll)) COMPLETE (XY() As Double)</code>  
 {XY(0) = x (XY(1) = y}*- **LoadImageFromUrl** (Url As String) As ResumableSub
- **LoadMKL** (Path As String, FileName As String) As ResumableSub
 *Return Map as Object  
 Key is ID , Value is Object (Marker,MapPolygon,MapPolyline)  
 <code>WAIT FOR (OpenMap.LoadMKL(Path, FileName)) COMPLETE (ObjectMap As Map)</code>*- **MapLoaded** As Boolean
- **MessageToPanel** (Text As String) As String
- **MoveCamera** (cp As CameraPosition) As String
- **MoveCamera2** (ll As LatLng) As String
- **ObjectIsEditing** (IDobject As String) As Boolean
- **PanelOff** As String
- **PanelOn** As String
- **RedrawAllObj** As String
- **RemoveCircle** (vCircle As MapCircle) As String
*Removes the specified circle from the map.*- **RemoveInfoWindow** (InfoWindow As MapInfoWindow) As String
- **RemoveMarker** (vMarker As Marker) As String
*Removes the specified marker from the map.*- **RemovePolygon** (vPolygon As MapPolygon) As String
*Removes the specified polygon from the map.*- **RemovePolyline** (vPolyline As MapPolyline) As String
*Removes the specified polyline from the map.*- **SaveKML** (MapObj As Map, Path As String, FileName As String)
- **SetZoom** (z As Int) As String
*Sets the zoom level.*- **UpdateCircleCenter** (id As String, Lat As Double, Lng As Double) As String
 *Update position Radius*- **UpdateCircleRadius** (id As String, Radius As Double) As String
 *New Radius*- **UpdateMarkerPosition** (id As String, Lat As Double, Lng As Double) As String
*update marker posizion*- **UpdatePolygon** (Plg As MapPolygon, NewPoints As List) As String
 *NewPoint as List of LatLng*- **UpdatePolygonColor** (Plg As MapPolygon, Color As Int) As String
 *Change color*- **UpdatePolygonFillColor** (Plg As MapPolygon, Color As Int, Opacity As Float) As String
 *1.12  
 Update FillColor - Opacity 0-1*- **UpdatePolygonStroke** (Plg As MapPolygon, Width As Int) As String
 *Change StrokeWidth*- **UpdatePolyline** (Pll As MapPolyline, NewPoints As List) As String
 *NewPoint as List of LatLng*- **UpdatePolylineColor** (Pll As MapPolyline, Color As Int) As String
 *Change color*- **UpdatePolylineStroke** (Pll As MapPolyline, Width As Int) As String
 *Change StrokeWidth*- **visibleObject** (ID As String, Visible As Boolean) As String
 *es. OpenMap.visibleObject(Polygon.ID)*- **ww** As WebView
- **XYToLatLng** (x As Double, y As Double) As ResumableSub
*<code>wait for (OM.XYToLatLng(x,y)) COMPLETE (Position As LatLng)</code>*
- **Properties:**

- **MapBound** As ResumableSub [read only]
*<code>wait for (OM.getMapBound) COMPLETE (Bound As Map)</code>  
 Return bound in map format: {"northEast":{"lat":45.123,"lon":12.456},"southWest":{"lat":40.987,"lon":10.321}}*- **MapType**
*get or set the zoom level.*- **NumberOfElements** As ResumableSub [read only]
 *Number Of Elements added  
 <code>wait for (OM.getNumberOfElements) COMPLETE (N As Int)</code>*
- **OpenMapsExt**

- **Functions:**

- **AddressToLatLon** (address As String) As ResumableSub
*<code>wait for (GMapExt.AddressToLatLon("Address number, City")) COMPLETE (ll as LatLng)</code>*- **bestRouteTSP** (points As List) As List
 *Algoritm Nearest Neighbor  
 points array as LatLng*- **Class\_Globals** As String
- **GetBearing** (Point1 As LatLng, Point2 As LatLng) As Double
*Returns the bearing between two points, from point1 to point2*- **GetDistance** (Point1 As LatLng, Point2 As LatLng) As Double
*Returns the distance between two points in meters*- **GetMarkerLabel** (m As Marker) As String
 *not available*- **GetMarkerPosition** (m As Marker) As ResumableSub
*<code>wait for (OME.GetMarkerPosition) COMPLETE (Position As LatLng)</code>*- **GetMarkerTitle** (m As Marker) As ResumableSub
*<code>wait for (OME.GetMarkerTitle) COMPLETE (Title As String)</code>*- **Initialize** (OpenMap As OpenMaps) As String
*Initializes the object. You can add parameters to this method if needed.*- **InsidePath** (point As LatLng, LatLngList As List) As Boolean
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LatLonToAddress** (lat As Double, lon As Double) As ResumableSub
- **LatLonToXY** (ll As LatLng) As ResumableSub
*<code>wait for (OME.LatLonToXY(ll)) COMPLETE (XY As Double)</code>*- **ObjectIsEditing** (IDobject As String) As Boolean
- **RemoveMarkerLabel** (m As Marker) As String
 *not available  
 Removes the Marker Label for the given Marker*- **RouteDistance** (route As List) As Double
 *Calcola la distanza totale di un percorso*- **SetMarkerClickable** (m As Marker, Clickable As Boolean) As String
 *Always clickable - not necessary  
 Sets the marker clickable property*- **SetMarkerIcon** (m As Marker, URL As String) As String
 *not available*- **SetMarkerLabel** (m As Marker, Text As String, Color As String, TextSize As Double) As String
 *not available  
 Sets a MarkerLabel with the given values.  
 Posible color values.*- **SetMarkerLabel2** (m As Marker, Text As String, Color As String, BackgroundColor As String, TextSize As Double) As String
 *not available*- **SetMarkerOrigin** (m As Marker, X As Double, y As Double) As String
 *not available  
 Sets the marker origin 'doesn't work!!!*- **SetPolygonClickable** (pg As MapPolygon, Clickable As Boolean) As String
 *Always clickable - not necessary  
 Sets the polygon clickable property 'doesn't work!!!*- **XYToLatLng** (x As Double, y As Double) As ResumableSub
*Returns the Lat/Lng coordinates for the given screen coordinates 'doesn't work!!!  
 <code>wait for (OME.XYToLatLng(x,y)) COMPLETE (ll As LatLng)</code>*
  
**![](https://www.b4x.com/android/forum/attachments/168491)  
  
Update**   

- 1.01 - Fix Bugs