### jSD_OpenMaps by Star-Dust
### 05/27/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166066/)

As many currently know Googlemaps' Webapi do not work correctly on the webview because the latest versions use webgl  
   
I decided to do a new library that uses OpenMap and Leaflet with the same methods and events of the Googlemaps bookshop. I also created a second OpenMapext class that adds some Googlemapsext commands to maintain compatibility and minimize changes to the existing code. The code we used with GMAPS with Javaobject to obtain extra functions is no longer usable. Tested with Java 19,  
  
**jSD\_OpenMaps  
  
Author:** Star-Dust  
**Version:** 1.15  

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
- **Initialize** (vCenter As LatLng, vRadius As Double, Visble As Boolean, id As String, WebView As JavaObject) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **Center** As LatLng [read only]
- **ID** As String [read only]
- **Radius** As Double [read only]
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
- **Initialize** (vPosition As LatLng, vText As String, vPermanent As Boolean, vID As String, WebView As JavaObject) As String
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
- **Initialize** (Visble As Boolean, ID As String, Point As List, StrokeWidth As Int, StrokeColor As Paint, FillColor As Paint, Opacity As Double, WebView As JavaObject) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **FillColor** As Paint [read only]
- **ID** As String [read only]
- **LineColor** As Paint [read only]
- **LineWidth** As Int [read only]
- **Opacity** As Float [read only]
- **Points** As List [read only]
 *List of LatLng*- **Visible** As Boolean

- **MapPolyline**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (Visble As Boolean, ID As String, Point As List, StrokeWidth As Int, StrokeColor As Paint, WebView As JavaObject) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **ID** As String [read only]
- **LineColor** As Paint [read only]
- **LineWidth** As Int [read only]
- **Points** As List [read only]
 *List of LatLng*- **Visible** As Boolean

- **Marker**

- **Functions:**

- **Class\_Globals** As String
- **CreateLabel** (Text As String) As String
 *Create Label on Marker*- **Initialize** (vPosition As LatLng, vTitle As String, vIconUri As String, vVisible As Boolean, vID As String, WebView As JavaObject) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **UpdateLabel** (Text As String) As String
 *Set Text empty for remove*
- **Properties:**

- **Draggable**
- **IconUri** As String [read only]
- **IconUrl** As String [read only]
- **ID** As String [read only]
- **Position** As LatLng [read only]
- **Title** As String [read only]
- **Visible** As Boolean

- **OpenMaps**

- **Events:**

- **CameraChange** (CamPosition As CameraPosition)
- **CircleClick** (SelectedCircle As MapCircle)
- **Click** (Point As LatLng)
- **MarkerClick** (SelectedMarker As Marker)
- **MouseMove** (Point As LatLng)
- **PolygonClick** (SelectedPolygon As MapPolygon)
- **PolylineClick** (SelectedPolyline As MapPolyline)
- **Ready**
- **RightClick** (Point As LatLng)

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

- **AddCircle** (ll As LatLng, Radius As Double, StrokeWidth As Float, StrokeColor As Paint, FillColor As Paint, Opacity As Double) As MapCircle
*Adds a circle To the map.  
 Center - Position of the circle center.  
 Radius - Circle radius.  
 StrokeWidth - Stroke width.  
 StrokeColor - Stroke color.  
 FillColor - Inner color.  
 Opacity - Inner color opacity. Value between 0 To 1.*- **AddInfoWindow** (Content As String, Position As LatLng) As MapInfoWindow
*Opens an info window with the given HTML content at the specified position.*- **AddInfoWindow2** (Content As String, Position As LatLng, MaxWidth As Int) As MapInfoWindow
*Opens an info window with the given HTML content at the specified position. It cannot be larger than MaxWidth (in pixels).*- **AddMarker** (Lat As Double, Lng As Double, Title As String) As Marker
 *Adds a marker to the map.*- **AddMarker2** (Lat As Double, Lng As Double, Title As String, IconUri As String) As Marker
*Adds a marker To the map with a custom icon.  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>gmap.AddMarker2(10, 10, "This is a test", File.GetUri(File.DirAssets, "SomeIcon.png"))</code>  
see <https://kml4earth.appspot.com/icons.html> for icons*- **AddMarker2Label** (Lat As Double, Lng As Double, Title As String, Label As String, IconUri As String) As Marker
*Adds a marker To the map with a custom icon and label  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>gmap.AddMarker2(10, 10, "This is a test", File.GetUri(File.DirAssets, "SomeIcon.png"))</code>*- **AddMarker3** (Lat As Double, Lng As Double, Title As String, IconUri As String, Width As Int, Height As Int) As Marker
*Adds a marker To the map with a custom icon.  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>gmap.AddMarker2(10, 10, "This is a test", File.GetUri(File.DirAssets, "SomeIcon.png",32,32))</code>  
see <https://kml4earth.appspot.com/icons.html> for icons*- ***AddMarker3bis** (Lat As Double, Lng As Double, Title As String, IconUri As String, Width As Int, Height As Int) As Marker*
Adds the marker, hitting it in height in the coordinate indicated- **AddMarker3Label** (Lat As Double, Lng As Double, Title As String, Label As String, IconUri As String, Width As Int, Height As Int) As Marker
*Adds a marker To the map with a custom icon and label.  
 The IconUri must point To an online image Or an image from the assets folder.  
 In the later Case the custom icon will only appear in Release mode.  
 Example: <code>gmap.AddMarker2(10, 10, "This is a test", File.GetUri(File.DirAssets, "SomeIcon.png",32,32))</code>*- **AddPolygon** (Points As List, StrokeWidth As Float, StrokeColor As Paint, FillColor As Paint, Opacity As Double) As MapPolygon
*Adds a polygon To the map.  
 Points - A list Or Array of LatLng points.  
 es. array(array(41.90, 12.49),array(41.80, 12.50),array(41.85, 12.60))  
 StrokeWidth - Stroke width.  
 StrokeColor - Stroke color.  
 FillColor - Inner color.  
 Opacity - Inner color opacity. Value between 0 To 1.*- **AddPolyline** (Points As List, StrokeWidth As Float, StrokeColor As Paint) As MapPolyline
*Adds a polyline To the map.  
 Points - A list Or Array of LatLng points.  
 Width - Line width.  
 Color - Line color.  
 CloseInfoWindow (InfoWindow As InfoWindow)  
 Closes the specified info window.*- **AllVisibleMapObjects** As String
- **AlternativeMap** (url As String, maxZoom As Int, attribution As String) As String
- **CameraPosition** As CameraPosition
*Returns the current camera position.*- **Class\_Globals** As String
- **ClearMap** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **EditConfigure** (Offset As Double, Tollerance As Int) As String
 *Offset -> Map difference; Tollerance -> Editing Poly point*- **EditingActive** As Boolean
- **EditingCircle** (Circle As MapCircle, Active As Boolean) As Boolean
- **EditingPolygon** (Polygon As MapPolygon, Active As Boolean) As Boolean
 *If an element is already in editing, it is not possible to edit another at the same time.  
 Dim Success As Boolean = OpenMap.EditingPolygon(Polygon,True)*- **EditingPolyline** (Polyline As MapPolyline, Active As Boolean) As Boolean
- **filterVisibleMapObjects** As String
 *Makes only the objects visible inside the visible map (Bounds)*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **IsReady** As Boolean
- **LatLonToXY** (ll As LatLng) As Double()
- **LoadMKL** (Path As String, FileName As String) As Map
 *Return Map as Object  
 Key is ID , Value is Object (Marker,MapPolygon,MapPolyline)  
 <code>ObjectMap = OpenMap.LoadMKL(Path, FileName)</code>*- **MapLoaded** As Boolean
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
*Removes the specified polyline from the map.*- **SaveKML** (MapObj As Map, Path As String, FileName As String) As String
- **UpdateCircleCenter** (id As String, Lat As Double, Lng As Double) As String
 *Update position Radius*- **UpdateCircleRadius** (id As String, Radius As Double) As String
 *New Radius*- **UpdateMarkerPosition** (id As String, Lat As Double, Lng As Double) As String
*update marker posizion*- **UpdatePolygon** (Plg As MapPolygon, NewPoints As List) As String
 *NewPoint as List of LatLng*- **UpdatePolygonColor** (Plg As MapPolygon, Color As Paint) As String
 *Change color*- **UpdatePolygonFillColor** (Plg As MapPolygon, Color As Paint, Opacity As Float) As String
 *1.12  
 Update FillColor - Opacity 0-1*- **UpdatePolygonStroke** (Plg As MapPolygon, Width As Int) As String
 *Change StrokeWidth*- **UpdatePolyline** (Pll As MapPolyline, NewPoints As List) As String
 *NewPoint as List of LatLng*- **UpdatePolylineColor** (Pll As MapPolyline, Color As Paint) As String
 *Change color*- **UpdatePolylineStroke** (Pll As MapPolyline, Width As Int) As String
 *Change StrokeWidth*- **visibleObject** (ID As String, Visible As Boolean) As String
 *es. OpenMap.visibleObject(Polygon.ID)*- **ww** As JavaObject
- **XYToLatLng** (x As Double, y As Double) As LatLng

- **Properties:**

- **MapBound** As Map [read only]
 *Return bound in map format:  
 {"northEast":{"lat":45.123,"lon":12.456},"southWest":{"lat":40.987,"lon":10.321}}  
 Dim Bound As Map = OMaps.MapBound*- **MapType**
*get or set the zoom level.*- **NumberOfElements** As Int [read only]
 *Number Of Elements added*- **Zoom** As Int
*Sets the zoom level.*
- **OpenMapsExt**

- **Functions:**

- **AddressToLatLon** (address As String) As ResumableSub
*<code>wait for (GMapExt.AddressToLatLon("Address number, City")) COMPLETE (ll as LatLng)</code>*- **bestRouteTSP** (points As List) As List
 *Algoritm Nearest Neighbor  
 points array as LatLng*- **Class\_Globals** As String
- **GetBearing** (Point1 As LatLng, Point2 As LatLng) As Double
*Returns the bearing between two points, from point1 to point2*- **GetCircleIsDraggable** (Cricle As MapCircle) As Boolean
- **GetDistance** (Point1 As LatLng, Point2 As LatLng) As Double
*Returns the distance between two points in meters*- **GetMarkerIsDraggable** (Mk As Marker) As Boolean
- **GetMarkerLabel** (m As Marker) As String
 *not available*- **GetMarkerPosition** (m As Marker) As LatLng
*Returns the marker position as LatLng Object*- **GetMarkerTitle** (m As Marker) As String
*Returns the title of a marker as string*- **GetPolygonIsDraggable** (Polygon As MapPolygon) As Boolean
- **GetPolylineIsDraggable** (Polyline As MapPolyline) As Boolean
- **Initialize** (OpenMap As OpenMaps) As String
*Initializes the object. You can add parameters to this method if needed.*- **InsidePath** (point As LatLng, LatLngList As List) As Boolean
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LatLonToAddress** (lat As Double, lon As Double) As ResumableSub
- **LatLonToXY** (ll As LatLng) As Double()
*Returns the screen coordiantes for the given LatLng coordinates*- **LatLonToXY2** (ll As LatLng) As Double()
- **ObjectIsEditing** (IDobject As String) As Boolean
- **RemoveMarkerLabel** (m As Marker) As String
 *not available  
 Removes the Marker Label for the given Marker*- **RouteDistance** (route As List) As Double
 *Calcola la distanza totale di un percorso*- **SetCircleDraggable** (C As MapCircle, Draggable As Boolean) As String
*Sets the circle draggable property*- **SetGeodesic** (shape As JavaObject) As String
*Sets a polygon or polyline to geodesic points - not exist*- **SetMarkerClickable** (m As Marker, Clickable As Boolean) As String
 *Always clickable - not necessary  
 Sets the marker clickable property*- **SetMarkerDraggable** (m As Marker, Draggable As Boolean) As String
*Sets the marker draggable property*- **SetMarkerIcon** (m As Marker, URL As String) As String
 *not available*- **SetMarkerLabel** (m As Marker, Text As String, Color As String, TextSize As Double) As String
 *not available  
 Sets a MarkerLabel with the given values.  
 Posible color values.*- **SetMarkerLabel2** (m As Marker, Text As String, Color As String, BackgroundColor As String, TextSize As Double) As String
 *not available*- **SetMarkerOrigin** (m As Marker, X As Double, y As Double) As String
 *not available  
 Sets the marker origin 'doesn't work!!!*- **SetPolygonClickable** (pg As MapPolygon, Clickable As Boolean) As String
 *Always clickable - not necessary  
 Sets the polygon clickable property 'doesn't work!!!*- **SetPolygonDraggable** (Polygon As MapPolygon, Draggable As Boolean) As String
*Sets the polygon draggable property*- **SetPolylineDraggable** (Polyline As MapPolyline, Draggable As Boolean) As String
*Sets the polyline draggable property*- **XYToLatLng** (x As Double, y As Double) As LatLng
*Returns the Lat/Lng coordinates for the given screen coordinates 'doesn't work!!!*
  
  

---

  

- 1.01

- Added on OpenMapsExt: **SetCircleDraggable**, **SetPolygonDraggable**, **SetPolylineDraggable**

- 1.02

- Coordinated renewal after movement for circle, polygon and polyline
- Update example

- 1.03

- Removal of lateral sliding bars
- Additions **EditingPolygon** and **EdgingPolyline** Method to change the points
- Added **VisibleObject** method to view or hide an object (markatore, circle, polygon, polyline)
- Add the **PanelOn** and **PanelOff** functions to make a communication panel appear or hide
- Added **MessageToPanel** method to send messages to the communication panel

- 1.04

- Fix bugs
- Added method **GetMarkerIsDraggable**, **GetCircleIsDraggable**, **GetPolygonIsDraggable**, **GetPolylineIsDraggable**
- Added method: **EditingPolyline**, **EditingPolygon** and function **EditingActive**

- 1.05

- Fix Bugs and update Demo

- 1.06

- Added method: **RedrawAllObj**, **ClearMap**, **EditingCircle**, **updateCircleRadius**
- Added new TypeMap: **MAP\_TYPE\_ESI**, **MAP\_TYPE\_CARTO** - As an alternative to OSM tiles if they don't appear

- 1.07

- Added method: **LoadKML**, **SaveKML**
- Removed Hyperlinks, Preserved Maps Elements after change Map\_Type
- Fix bugs
- The algorithm reconstructed for the modification of the polygons, polylines and rims

- 1.08

- Added **getMapBound**, **filterVisibleMapObjects**, **AllVisibleMapObjects**, **NumberOfElements**
- Added **PopUp** on Marker

- 1.09

- Fix bugs for LoadKML, AddMarker, AddCircle, AddPolygon, AddPolyline
- Correct LatLng class field (Lat to Latitude, Lng to Longitude)
- Update Sample

- 1.10

- Added method **UpdatePolyline**, **UpdatePolygon**
- Update class **Polyline**, **Polygon**
- Fix bugs

- 1.11

- Added method **InsidePath, UpdateCircleCenter, UpdateMarkerPosition, ObjectIsEditing**
- Correct LatLng class method Initialize(Lat,Lng)
- Update Sample

- 1.12

- Added method **UpdatePolylineStroke**, **UpdatePolylineColor**, **UpdatePolygonStroke, UpdatePolygonColor**
- Added type map **MAP\_TYPE\_ESI\_SATELLITE** (zoom 20x)

- 1.13

- Added method **UpdatePolygonFillColor, AddMarker3, AddMarker2Label, AddMarker3Label** to OpenMaps class
- Added method **bestRouteTSP** to OpenMapsExt class
- Fix bugs Label / icon marker

- 1.14

- Added **AlternativeMap** method to be able to insert other maps that require API KEY
- Polygon/Polyline editor improve

- 1.15

- added **AddMarker3bis -** Adds the marker, hitting it in height in the coordinate indicated
- The possibility of the escape seques in the panel text (GMap.MessageToPanel)
- Fixed the bug that prevented having more openmaps classes started at the same time