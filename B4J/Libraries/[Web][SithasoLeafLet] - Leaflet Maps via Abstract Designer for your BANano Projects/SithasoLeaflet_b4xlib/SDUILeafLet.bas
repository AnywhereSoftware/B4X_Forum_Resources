B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
#IgnoreWarnings:12

#Event: BaseLayerChange (e As Map)
#Event: OverlayAdd (e As Map)
#Event: OverlayRemove (e As Map)
#Event: LayerAdd (e As Map)
#Event: LayerRemove (e As Map)
#Event: ZoomLevelsChange (e As Map)
#Event: Resize (e As Map)
#Event: Unload (e As Map)
#Event: ViewReset (e As Map)
#Event: Load (e As Map)
#Event: ZoomStart (e As Map)
#Event: MoveStart (e As Map)
#Event: Zoom (e As Map)
#Event: Move (e As Map)
#Event: ZoomEnd (e As Map)
#Event: MoveEnd (e As Map)
#Event: PopupOpen (e As Map)
#Event: PopupClose (e As Map)
#Event: AutopanStart (e As Map)
#Event: TooltipOpen (e As Map)
#Event: TooltipClose (e As Map)
#Event: LocationError (e As Map)
#Event: LocationFound (e As Map)
#Event: Click (e As Map)
#Event: DblClick (e As Map)
#Event: MouseDown (e As Map)
#Event: MouseUp (e As Map)
#Event: MouseOver (e As Map)
#Event: MouseOut (e As Map)
#Event: MouseMove (e As Map)
#Event: ContextMenu (e As Map)
#Event: Keypress (e As Map)
#Event: PreClick (e As Map)
#Event: ZoomAnim (e As Map)
#Event: MarkerDragStart (e As Map)
#Event: MarkerDrag (e As Map)
#Event: MarkerDragEnd (e As Map)
#Event: MarkerClick (e As Map)
#Event: MarkerDblclick (e As Map)
#Event: MarkerMouseDown (e As Map)
#Event: MarkerMouseUp (e As Map)
#Event: MarkerMouseOver (e As Map)
#Event: MarkerMouseOut (e As Map)
#Event: MarkerContextMenu (e As Map)
#Event: MarkerAdd (e As Map)
#Event: MarkerRemove (e As Map)
#Event: MarkerPopupOpen (e As Map)
#Event: MarkerPopupClose (e As Map)
#Event: MarkerTooltipOpen (e As Map)
#Event: MarkerTooltipClose (e As Map)

#DesignerProperty: Key: ParentID, DisplayName: ParentID, FieldType: String, DefaultValue: , Description: The ParentID of this component
#DesignerProperty: Key: LayerType, DisplayName: Layer Type, FieldType: String, DefaultValue: openstreetmap, Description: Layer Type, List: openstreetmap|google-roadmap|google-satellite|google-hybrid|google-terrain|other
#DesignerProperty: Key: MapType, DisplayName: Map Type, FieldType: String, DefaultValue: , Description: Map Type, List: dark|light|wheatpaste|streets-basic|comic|outdoors|satellite|streets-satellite|streets|run-bike-hike|pencil|pirates|emerald|high-contrast
#DesignerProperty: Key: AutoScale, DisplayName: Auto Scale, FieldType: Boolean, DefaultValue: False, Description: Auto Scale
#DesignerProperty: Key: Geonames, DisplayName: Geonames, FieldType: Boolean, DefaultValue: False, Description: Geonames
#DesignerProperty: Key: Height, DisplayName: Height, FieldType: String, DefaultValue: 500px, Description: Height
#DesignerProperty: Key: Width, DisplayName: Width, FieldType: String, DefaultValue: 500px, Description: Width
#DesignerProperty: Key: Lat, DisplayName: Lat, FieldType: String, DefaultValue: 0, Description: Lat
#DesignerProperty: Key: Lng, DisplayName: Lng, FieldType: String, DefaultValue: 0, Description: Lng
#DesignerProperty: Key: MaxZoom, DisplayName: Max Zoom, FieldType: Int, DefaultValue: 19, Description: Max Zoom
#DesignerProperty: Key: Zoom, DisplayName: Zoom, FieldType: Int, DefaultValue: 5, Description: Zoom
#DesignerProperty: Key: Visible, DisplayName: Visible, FieldType: Boolean, DefaultValue: True, Description: If visible.
#DesignerProperty: Key: Enabled, DisplayName: Enabled, FieldType: Boolean, DefaultValue: True, Description: If enabled.
#DesignerProperty: Key: PositionStyle, DisplayName: Position Style, FieldType: String, DefaultValue: none, Description: Position, List: absolute|fixed|none|relative|static|sticky
#DesignerProperty: Key: Position, DisplayName: Position Locations, FieldType: String, DefaultValue: t=?; b=?; r=?; l=?, Description: Position Locations
#DesignerProperty: Key: MarginAXYTBLR, DisplayName: Margins, FieldType: String, DefaultValue: a=?; x=?; y=?; t=?; b=?; l=?; r=? , Description: Margins A(all)-X(LR)-Y(TB)-T-B-L-R
#DesignerProperty: Key: PaddingAXYTBLR, DisplayName: Paddings, FieldType: String, DefaultValue: a=?; x=?; y=?; t=?; b=?; l=?; r=? , Description: Paddings A(all)-X(LR)-Y(TB)-T-B-L-R
#DesignerProperty: Key: RawClasses, DisplayName: Classes (;), FieldType: String, DefaultValue: , Description: Classes added to the HTML tag.
#DesignerProperty: Key: RawStyles, DisplayName: Styles (JSON), FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String use = and ;
#DesignerProperty: Key: RawAttributes, DisplayName: Attributes (JSON), FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String use = and ;

'global variables in this module
Sub Class_Globals
	Public UI As UIShared 'ignore
	Public CustProps As Map 'ignore
	Private mCallBack As Object 'ignore
	Private mEventName As String 'ignore
	Private mElement As BANanoElement 'ignore
	Private mTarget As BANanoElement 'ignore
	Private mName As String 'ignore
	Private BANano As BANano   'ignore
	Private sPosition As String = "t=?; b=?; r=?; l=?"
	Private sPositionStyle As String = "none"
	Private sRawClasses As String = ""
	Private sRawStyles As String = ""
	Private sRawAttributes As String = ""
	Private sMarginAXYTBLR As String = "a=?; x=?; y=?; t=?; b=?; l=?; r=?"
	Private sPaddingAXYTBLR As String = "a=?; x=?; y=?; t=?; b=?; l=?; r=?"
	Private sParentID As String = ""
	Private bVisible As Boolean = True	'ignore
	Private bEnabled As Boolean = True	'ignore
	Public Tag As Object
	Private bAutoScale As Boolean = False
	Private bGeonames As Boolean = False
	Private sHeight As String = "500px"
	Private sMapType As String = ""
	Private iMaxZoom As Int = 19
	Private sWidth As String = "500px"
	Private iZoom As Int = 5
	Private dLat As Double = 0
	Private dLng As Double = 0
	Private markers As Map
	Private circles As Map
	Private polygons As Map
	Private rectangles As Map
	Private polylines As Map
	Private popups As Map
	Private OpenPopUpMap As Map
	Private shapeFiles As Map
	Private xMapType As String = ""		'ignore
	Private L As BANanoObject
	Private MapObject As BANanoObject
	Private sTileLayer As String = "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
	Private sAttribution As String = $"&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>"$
	Private sLayerType As String = "openstreetmap"
	'
'	Private Const TileLayerType_OpenStreetMap As Int = 1
'	Private Const TileLayerType_GoogleMapRoadmap As Int = 2
'	Private Const TileLayerType_GoogleMapSatellite As Int = 3
'	Private Const TileLayerType_GoogleMapHybrid As Int = 4
'	Private Const TileLayerType_GoogleMapTerrain As Int = 5
'	Private Const TileLayerType_Custom As Int = 6
	Private icons As Map
	Private images As Map
End Sub

'initialize the custom view class
Public Sub Initialize (Callback As Object, Name As String, EventName As String)
	UI.Initialize(Me)
	mElement = Null
	mEventName = UI.CleanID(EventName)
	mName = UI.CleanID(Name)
	mCallBack = Callback
	CustProps.Initialize
	markers.Initialize
	circles.Initialize
	polygons.Initialize
	polylines.Initialize
	popups.Initialize
	OpenPopUpMap.Initialize
	shapeFiles.Initialize
	rectangles.Initialize
	icons.Initialize
	images.Initialize
End Sub

' returns the element id
Public Sub getID() As String
	Return mName
End Sub
'add this element to an existing parent element using current props
Public Sub AddComponent
	If sParentID = "" Then Return
	sParentID = UI.CleanID(sParentID)
	mTarget = BANano.GetElement("#" & sParentID)
	DesignerCreateView(mTarget, CustProps)
End Sub
'remove this element from the dom
Public Sub Remove()
	mElement.Remove
	BANano.SetMeToNull
End Sub
'set the parent id
Sub setParentID(s As String)
	s = UI.CleanID(s)
	sParentID = s
	CustProps.Put("ParentID", sParentID)
End Sub
'get the parent id
Sub getParentID As String
	Return sParentID
End Sub
'return the #ID of the element
Public Sub getHere() As String
	Return $"#${mName}"$
End Sub
'set Visible
Sub setVisible(b As Boolean)
	bVisible = b
	CustProps.Put("Visible", b)
	If mElement = Null Then Return
	UI.SetVisible(mElement, b)
End Sub
'get Visible
Sub getVisible As Boolean
	bVisible = UI.GetVisible(mElement)
	Return bVisible
End Sub
'set Enabled
Sub setEnabled(b As Boolean)
	bEnabled = b
	CustProps.Put("Enabled", b)
	If mElement = Null Then Return
	UI.SetEnabled(mElement, b)
End Sub
'get Enabled
Sub getEnabled As Boolean
	bEnabled = UI.GetEnabled(mElement)
	Return bEnabled
End Sub
'use to add an event to the element
Sub OnEvent(event As String, methodName As String)
	UI.OnEvent(mElement, event, mCallBack, methodName)
End Sub
'set Position Style
'options: static|relative|fixed|absolute|sticky|none
Sub setPositionStyle(s As String)
	sPositionStyle = s
	CustProps.put("PositionStyle", s)
	If mElement = Null Then Return
	If s <> "" Then UI.AddStyle(mElement, "position", s)
End Sub
Sub getPositionStyle As String
	Return sPositionStyle
End Sub
'set raw positions
Sub setPosition(s As String)
	sPosition = s
	CustProps.Put("Position", sPosition)
	If mElement = Null Then Return
	If s <> "" Then UI.SetPosition(mElement, sPosition)
End Sub
Sub getPosition As String
	Return sPosition
End Sub
Sub setAttributes(s As String)
	sRawAttributes = s
	CustProps.Put("RawAttributes", s)
	If mElement = Null Then Return
	If s <> "" Then UI.SetAttributes(mElement, sRawAttributes)
End Sub
'
Sub setStyles(s As String)
	sRawStyles = s
	CustProps.Put("RawStyles", s)
	If mElement = Null Then Return
	If s <> "" Then UI.SetStyles(mElement, sRawStyles)
End Sub
'
Sub setClasses(s As String)
	sRawClasses = s
	CustProps.put("RawClasses", s)
	If mElement = Null Then Return
	If s <> "" Then UI.SetClasses(mElement, sRawClasses)
End Sub
'
Sub setPaddingAXYTBLR(s As String)
	sPaddingAXYTBLR = s
	CustProps.Put("PaddingAXYTBLR", s)
	If mElement = Null Then Return
	If s <> "" Then UI.SetPaddingAXYTBLR(mElement, sPaddingAXYTBLR)
End Sub
'
Sub setMarginAXYTBLR(s As String)
	sMarginAXYTBLR = s
	CustProps.Put("MarginAXYTBLR", s)
	If mElement = Null Then Return
	If s <> "" Then UI.SetMarginAXYTBLR(mElement, sMarginAXYTBLR)
End Sub
'
Sub getAttributes As String
	Return sRawAttributes
End Sub
'
Sub getStyles As String
	Return sRawStyles
End Sub
'
Sub getClasses As String
	Return sRawClasses
End Sub
'
Sub getPaddingAXYTBLR As String
	Return sPaddingAXYTBLR
End Sub
'
Sub getMarginAXYTBLR As String
	Return sMarginAXYTBLR
End Sub

'code to design the view
Public Sub DesignerCreateView (Target As BANanoElement, Props As Map)
	mTarget = Target
	If Props <> Null Then
		CustProps = Props
		UI.SetProps(Props)
		UI.ExcludeBackgroundColor = True
		UI.ExcludeTextColor = True
		'UI.ExcludeVisible = True
		'UI.ExcludeEnabled = True
		bAutoScale = Props.GetDefault("AutoScale", False)
		bAutoScale = UI.CBool(bAutoScale)
		bGeonames = Props.GetDefault("Geonames", False)
		bGeonames = UI.CBool(bGeonames)
		sHeight = Props.GetDefault("Height", "500px")
		sHeight = UI.CStr(sHeight)
		sMapType = Props.GetDefault("MapType", "")
		sMapType = UI.CStr(sMapType)
		iMaxZoom = Props.GetDefault("MaxZoom", 19)
		iMaxZoom = UI.CInt(iMaxZoom)
		sWidth = Props.GetDefault("Width", "500px")
		sWidth = UI.CStr(sWidth)
		iZoom = Props.GetDefault("Zoom", 5)
		iZoom = UI.CInt(iZoom)
		dLat = Props.GetDefault("Lat", 0)
		dLat = UI.CDbl(dLat)
		dLng = Props.GetDefault("Lng", 0)
		dLng = UI.CDbl(dLng)
		sLayerType = Props.GetDefault("LayerType", "openstreetmap")
		sLayerType = UI.CStr(sLayerType)
	End If
	'
	If sHeight <> "" Then UI.AddStyleDT("height", sHeight)
	If sWidth <> "" Then UI.AddStyleDT("width", sWidth)
	'
	Dim xattrs As String = UI.BuildExAttributes
	Dim xstyles As String = UI.BuildExStyle
	Dim xclasses As String = UI.BuildExClass
	If sParentID <> "" Then
		'does the parent exist
		If BANano.Exists($"#${sParentID}"$) = False Then
			BANano.Throw($"${mName}.DesignerCreateView: '${sParentID}' parent does not exist!"$)
			Return
		End If
		mTarget.Initialize($"#${sParentID}"$)
	End If
	mElement = mTarget.Append($"[BANCLEAN]<div id="${mName}" class="${xclasses}" ${xattrs} style="${xstyles}"></div>"$).Get("#" & mName)
	'initialize the leaflet object
	L.Initialize("L")
	Dim extraData As Map = CreateMap()
	mElement.SetField("extraData", extraData)
	MapObject = L.RunMethod("map", mElement.ToObject)
	mElement.GetField("extraData").SetField("storedMap", MapObject)
	'
	Dim coOpt As Map = CreateMap()
	coOpt.Put("position", "bottomleft")
	coOpt.Put("decimals", 2)
	coOpt.Put("decimalSeperator", ",")
	coOpt.Put("labelTemplateLat",  $"Latitude: {y}"$)
	coOpt.Put("labelTemplateLng", $"Longitude: {x}"$)
	'
	Dim coordinates As BANanoObject = L.GetField("control").RunMethod("coordinates", coOpt)
	coordinates.RunMethod("addTo", MapObject)
	'
	Dim copt1 As Map = CreateMap()
	copt1.Put("position", "topright")
	copt1.Put("useDMS", True)
	copt1.Put("labelTemplateLat",  $"N {y}"$)
	copt1.Put("labelTemplateLng", $"E {x}"$)
	copt1.Put("useLatLngOrder", True)
	Dim coordinates1 As BANanoObject = L.GetField("control").RunMethod("coordinates", copt1)
	coordinates1.RunMethod("addTo", MapObject)
	
	'add map events
	BindEvent("baselayerchange", Me, "LeafletMapEvent")
	BindEvent("overlayadd", Me, "LeafletMapEvent")
	BindEvent("overlayremove", Me, "LeafletMapEvent")
	BindEvent("layeradd", Me, "LeafletMapEvent")
	BindEvent("layerremove", Me, "LeafletMapEvent")
	BindEvent("zoomlevelschange", Me, "LeafletMapEvent")
	BindEvent("resize", Me, "LeafletMapEvent")
	BindEvent("unload", Me, "LeafletMapEvent")
	BindEvent("viewreset", Me, "LeafletMapEvent")
	BindEvent("load", Me, "LeafletMapEvent")
	BindEvent("zoomstart", Me, "LeafletMapEvent")
	BindEvent("movestart", Me, "LeafletMapEvent")
	BindEvent("zoom", Me, "LeafletMapEvent")
	BindEvent("move", Me, "LeafletMapEvent")
	BindEvent("zoomend", Me, "LeafletMapEvent")
	BindEvent("moveend", Me, "LeafletMapEvent")
	BindEvent("popupopen", Me, "LeafletMapEvent")
	BindEvent("popupclose", Me, "LeafletMapEvent")
	BindEvent("autopanstart", Me, "LeafletMapEvent")
	BindEvent("tooltipopen", Me, "LeafletMapEvent")
	BindEvent("tooltipclose", Me, "LeafletMapEvent")
	BindEvent("locationerror", Me, "LeafletMapEvent")
	BindEvent("locationfound", Me, "LeafletMapEvent")
	BindEvent("click", Me, "LeafletMapEvent")
	BindEvent("dblclick", Me, "LeafletMapEvent")
	BindEvent("mousedown", Me, "LeafletMapEvent")
	BindEvent("mouseup", Me, "LeafletMapEvent")
	BindEvent("mouseover", Me, "LeafletMapEvent")
	BindEvent("mouseout", Me, "LeafletMapEvent")
	BindEvent("mousemove", Me, "LeafletMapEvent")
	BindEvent("contextmenu", Me, "LeafletMapEvent")
	BindEvent("keypress", Me, "LeafletMapEvent")
	BindEvent("preclick", Me, "LeafletMapEvent")
	BindEvent("zoomanim", Me, "LeafletMapEvent")
	
	BANano.Await(setLayerType(sLayerType))
	BANano.Await(SetView(dLat, dLng, iZoom))
End Sub

'Sets the CSS-Style of the HTML-Element, that contains the Map.
Sub SetStyle(m As Map)
	Dim JsonString As String = BANano.ToJson(m)
	BANano.ToElement(MapObject.RunMethod("getContainer", Null)).SetStyle(JsonString)
End Sub

'get the container that hosts the map
Sub getContainer As BANanoElement
	Dim el As BANanoElement = BANano.ToElement(MapObject.RunMethod("getContainer", Null))
	Return el
End Sub

Sub SetMarkerStyle(markerID As String, m As Map)
	markerID = UI.cleanid(markerID)
	If markers.ContainsKey(markerID) = False Then Return
	Dim MarkerObject As BANanoObject = markers.Get(markerID)
	Dim JsonString As String = BANano.ToJson(m)
	MarkerObject.RunMethod("setStyle", BANano.FromJson(JsonString))
End Sub

Sub SetCircleStyle(markerID As String, m As Map)
	markerID = UI.cleanid(markerID)
	If markers.ContainsKey(markerID) = False Then Return
	Dim MarkerObject As BANanoObject = circles.Get(markerID)
	Dim JsonString As String = BANano.ToJson(m)
	MarkerObject.RunMethod("setStyle", BANano.FromJson(JsonString))
End Sub

'Pans the map to a given center (Lat/Lng).
Sub PanTo(Lat As Double, Lng As Double)
	MapObject.RunMethod("panTo", L.RunMethod("latLng", Array(Lat, Lng)))
End Sub

'set the layer type for the map
Sub setLayerType(s As String)				'ignoredeadcode
	sLayerType = s
	CustProps.Put("LayerType", s)
	Select Case sLayerType
		Case "openstreetmap"
			sTileLayer = "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
		Case "google-roadmap"
			sTileLayer = "http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}"
		Case "google-satellite"
			sTileLayer = "http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}"
		Case "google-hybrid"
			sTileLayer = "http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}"
		Case "google-terrain"
			sTileLayer = "http://{s}.google.com/vt/lyrs=p&x={x}&y={y}&z={z}"
		Case "other"
			sTileLayer = ""
	End Select
	'
	If sTileLayer = "" Then Return
	Dim opt As Map = CreateMap()
	opt.Put("minZoom", iZoom)
	opt.Put("maxZoom", iMaxZoom)
	opt.Put("attribution", sAttribution)
	Dim TileLayerObject As BANanoObject = L.RunMethod("tileLayer", Array(sTileLayer, opt))
	TileLayerObject.RunMethod("addTo", MapObject)
End Sub

'Sets the view of the map (geographical center (Lat/Lng) and zoom).
Sub SetView(Lat As Double, Lng As Double, Zoom As Int)					'ignoredeadcode
	If mElement = Null Then Return
	Dim latlng As Object = L.RunMethod("latLng", Array(Lat, Lng))
	MapObject.RunMethod("setView", Array(latlng, Zoom))
End Sub

'get the distance between two points in meters
Sub GetDistance(lat1 As Double, lng1 As Double, lat2 As Double, lng2 As Double) As Object
	Dim latlng1 As Object = L.RunMethod("latLng", Array(lat1, lng1))
	Dim latlng2 As Object = L.RunMethod("latLng", Array(lat2, lng2))
	Dim obj As Object = MapObject.RunMethod("distance", Array(latlng1, latlng2)).result
	Return obj
End Sub

Sub FlyTo(Lat As Double, Lng As Double, Zoom As Int)					'ignoredeadcode
	If mElement = Null Then Return
	Dim latlng As Object = L.RunMethod("latLng", Array(Lat, Lng))
	MapObject.RunMethod("flyTo", Array(latlng, Zoom))
End Sub

Sub getLayerType As String
	Return sLayerType
End Sub

'destroy the map and kill all events
Sub Destroy
	MapObject.RunMethod("remove", Null)
	Clear
End Sub

Sub Clear
	markers.Initialize
	circles.Initialize
	polygons.Initialize
	polylines.Initialize
	popups.Initialize
	OpenPopUpMap.Initialize
	shapeFiles.Initialize
	icons.Initialize
	images.Initialize
End Sub

'add shape file
Sub AddShapeFile(shpID As String, shpPath As String)
	shpID = UI.CleanID(shpID)
	shapeFiles.Put(shpID,shpPath)
End Sub

'remove markers
Sub RemoveMarkers
	markers.Initialize
End Sub

'remove shapefiles
Sub RemoveShapeFiles
	shapeFiles.Initialize
End Sub

'remove a shapefile
Sub RemoveShapeFile(shpID As String)
	shpID = UI.CleanID(shpID)
	If shapeFiles.ContainsKey(shpID) Then
		shapeFiles.Remove(shpID)
	End If
End Sub

'remove circles
Sub RemoveCircles
	circles.Initialize
End Sub

'remove polylines
Sub RemovePolyLines
	polylines.Initialize
End Sub

'remove polygons
Sub RemovePolyGons
	polygons.Initialize
End Sub

'remove popups
Sub RemovePopUps
	popups.Initialize
End Sub

'remove a pop up
Sub RemovePopUp(markerID As String)
	markerID = UI.CleanID(markerID)
	If popups.ContainsKey(markerID) Then
		popups.Remove(markerID)
	End If
End Sub

'set Auto Scale
Sub setAutoScale(b As Boolean)
	bAutoScale = b
	CustProps.put("AutoScale", b)
End Sub

'set Geonames
Sub setGeonames(b As Boolean)
	bGeonames = b
	CustProps.put("Geonames", b)
End Sub

'set Height
Sub setHeight(s As String)
	sHeight = s
	CustProps.put("Height", s)
	If mElement = Null Then Return
	If s <> "" Then UI.AddStyle(mElement, "height", s)
End Sub

'set Map Type
Sub setMapType(s As String)
	sMapType = s
	xMapType = s
	CustProps.put("MapType", s)
	Select Case sMapType
		Case "dark"
			xMapType ="mapbox.dark"
		Case "light"
			xMapType = "mapbox.light"
		Case "wheatpaste"
			xMapType= "mapbox.wheatpaste"
		Case "streets-basic"
			xMapType = "mapbox.streets-basic"
		Case "comic"
			xMapType = "mapbox.comic"
		Case "outdoors"
			xMapType = "mapbox.outdoors"
		Case "satellite"
			xMapType = "mapbox.satellite"
		Case "streets-satellite"
			xMapType = "mapbox.streets-satellite"
		Case "streets"
			xMapType = "mapbox.streets"
		Case "run-bike-hike"
			xMapType = "mapbox.run-bike-hike"
		Case "pencil"
			xMapType = "mapbox.pencil"
		Case "pirates"
			xMapType = "mapbox.pirates"
		Case "emerald"
			xMapType = "mapbox.emerald"
		Case "high-contrast"
			xMapType = "mapbox.high-contrast"
	End Select
End Sub

'set Max Zoom
Sub setMaxZoom(i As Int)
	iMaxZoom = i
	CustProps.put("MaxZoom", i)
End Sub

'set Width
Sub setWidth(s As String)
	sWidth = s
	CustProps.put("Width", s)
	If mElement = Null Then Return
	If s <> "" Then UI.AddStyle(mElement, "width", s)
End Sub

'set Zoom
Sub setZoom(i As Int)
	iZoom = UI.CInt(i)
	CustProps.put("Zoom", i)
	If mElement = Null Then Return
	MapObject.RunMethod("setZoom", iZoom)
End Sub

'get Auto Scale
Sub getAutoScale As Boolean
	Return bAutoScale
End Sub

'get Geonames
Sub getGeonames As Boolean
	Return bGeonames
End Sub
'get Height
Sub getHeight As String
	Return sHeight
End Sub
'get Map Type
Sub getMapType As String
	Return sMapType
End Sub
'get Max Zoom
Sub getMaxZoom As Int
	Return iMaxZoom
End Sub
'get Width
Sub getWidth As String
	Return sWidth
End Sub
'get Zoom
Sub getZoom As Int
	Return iZoom
End Sub

Sub AddRectangle(markerID As String, lat1 As Double, lng1 As Double, lat2 As Double, lng2 As Double) As BANanoObject
	markerID = UI.CleanID(markerID)
	If rectangles.ContainsKey(markerID) Then Return Null
	Dim MarkerObject As BANanoObject = L.RunMethod("rectangle", Array(Array(Array(lat1, lng1), Array(lat2, lng2))))
	MarkerObject.SetField("id", markerID)
	rectangles.Put(markerID, MarkerObject)
	MarkerObject.RunMethod("addTo", MapObject)
	Return MarkerObject
End Sub

'add a circle to the map
Sub AddCircle(markerID As String, markerLat As Double, markerLng As Double, Color As String, fillColor As String, fillOpacity As Double, Radius As Int) As BANanoObject
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject
	If circles.ContainsKey(markerID) Then
		MarkerObject = circles.Get(markerID)
		Return MarkerObject
	End If
	Dim obj As Map = CreateMap()
	obj.Put("radius", Radius)
	If Color <> "" Then obj.Put("color", Color)
	If fillColor <> "" Then obj.Put("fillColor", fillColor)
	obj.put("fillOpacity", fillOpacity)
	MarkerObject = L.RunMethod("circle", Array(Array(markerLat, markerLng), obj))
	MarkerObject.SetField("id", markerID)
	circles.Put(markerID, MarkerObject)
	MarkerObject.RunMethod("addTo", MapObject)
	Return MarkerObject
End Sub

Sub AddIcon(iconID As String, iconURL As String, widthPx As Int, heightPx As Int, anchorX As Int, anchorY As Int, popupAnchorX As Int, popupAnchorY As Int) As BANanoObject
	iconID = UI.CleanID(iconID)
	Dim iconObject As BANanoObject
	If icons.ContainsKey(iconID) Then
		iconObject = icons.Get(iconID)
		Return iconObject
	End If
	Dim opt As Map = CreateMap()
	opt.Put("iconUrl", iconURL)
	Dim iconSize As List
	iconSize.Initialize
	iconSize.Add(widthPx)
	iconSize.Add(heightPx)
	Dim iconAnchor As List
	iconAnchor.Initialize
	iconAnchor.Add(anchorX)
	iconAnchor.Add(anchorY)
	Dim popupAnchor As List
	popupAnchor.Initialize
	popupAnchor.Add(popupAnchorX)
	popupAnchor.Add(popupAnchorY)
	opt.Put("iconSize", iconSize)
	opt.Put("iconAnchor", iconAnchor)
	opt.Put("popupAnchor", popupAnchor)
	iconObject = L.RunMethod("icon", opt)
	iconObject.SetField("id", iconID)
	icons.Put(iconID, iconObject)
	Return iconObject
End Sub

Sub AddImage(imgID As String, imgURL As String, southWestLat As Double, southWestLon As Double, northEastLat As Double, northEastLon As Double) As BANanoObject
	imgID = UI.CleanID(imgID)
	Dim imgObject As BANanoObject
	If images.ContainsKey(imgID) Then
		imgObject = icons.Get(imgID)
		Return imgObject
	End If
	Dim latlng1 As Object = L.RunMethod("latLng", Array(southWestLat, southWestLon))
	Dim latlng2 As Object = L.RunMethod("latLng", Array(northEastLat, northEastLon))
	Dim imageBounds As List
	imageBounds.Initialize
	imageBounds.Add(latlng1)
	imageBounds.Add(latlng2)
	imgObject = L.RunMethod("imageOverlay", Array(imgURL, imageBounds))
	imgObject.SetField("id", imgID)
	images.Put(imgID, imgObject)
	imgObject.RunMethod("addTo", MapObject)
	Return imgObject
End Sub


Sub SetMarkerIcon(markerID As String, iconID As String)
	markerID = UI.CleanID(markerID)
	iconID = UI.CleanID(iconID)
	If markers.ContainsKey(markerID) = False Then Return
	If icons.ContainsKey(iconID) = False Then Return
	Dim mark As BANanoObject = markers.Get(markerID)
	Dim icon As BANanoObject = icons.Get(iconID)
	mark.RunMethod("setIcon", icon)
End Sub

'add a simple marker to the map
Sub AddMarker(markerID As String, markerLat As Double, markerLng As Double) As BANanoObject
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject
	If markers.ContainsKey(markerID) Then
		MarkerObject = markers.Get(markerID)
		Return MarkerObject
	End If
	MarkerObject = L.RunMethod("marker", Array(Array(markerLat, markerLng)))
	MarkerObject.SetField("id", markerID)
	markers.Put(markerID, MarkerObject)
	MarkerObject.RunMethod("addTo", MapObject)
	'
	BindMarkerEvent(MarkerObject, "dragstart", Me, "MarkerEvent")
	' BindMarkerEvent(MarkerObject,("movestart", Me, "MarkerEvent") ' similar to dragstart
	BindMarkerEvent(MarkerObject, "drag", Me, "MarkerEvent")
	' BindMarkerEvent(MarkerObject,("move", Me, "MarkerEvent") ' similar to drag
	BindMarkerEvent(MarkerObject, "dragend", Me, "MarkerEvent")
	' BindMarkerEvent(MarkerObject,("moveend", Me, "MarkerEvent") ' similar to dragend
	BindMarkerEvent(MarkerObject, "click", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "dblclick", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "mousedown", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "mouseup", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "mouseover", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "mouseout", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "contextmenu", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "add", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "remove", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "popupopen", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "popupclose", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "tooltipopen", Me, "MarkerEvent")
	BindMarkerEvent(MarkerObject, "tooltipclose", Me, "MarkerEvent")
	Return MarkerObject
End Sub

Sub AddPolygon(polygonID As String, color As String, fillColor As String, fillOpacity As Double) As BANanoObject
	polygonID = UI.CleanID(polygonID)
	Dim MarkerObject As BANanoObject
	If polygons.ContainsKey(polygonID) Then
		MarkerObject = polygons.Get(polygonID)
		Return MarkerObject
	End If
	Dim opt As Map = CreateMap()
	If color <> "" Then opt.Put("color", color)
	If fillColor <> "" Then opt.put("fillColor", fillColor)
	opt.put("fillOpacity", fillOpacity)
	MarkerObject = L.RunMethod("polygon", Array(Array(0, 0), opt))
	'clear the polygon
	MarkerObject.RunMethod("setLatLngs", Array(Array()))
	MarkerObject.SetField("id", polygonID)
	polygons.Put(polygonID, MarkerObject)
	Return MarkerObject
End Sub

Sub AddPolyline(polyID As String, color As String, weight As Int, opacity As Double) As BANanoObject
	polyID = UI.CleanID(polyID)
	Dim MarkerObject As BANanoObject
	If polylines.ContainsKey(polyID) Then
		MarkerObject = polylines.Get(polyID)
		Return MarkerObject
	End If
	Dim opt As Map = CreateMap()
	If color <> "" Then opt.Put("color", color)
	opt.put("weight", weight)
	opt.put("opacity", opacity)
	MarkerObject = L.RunMethod("polyline", Array(Array(0, 0), opt))
	'clear the polygon
	MarkerObject.RunMethod("setLatLngs", Array(Array()))
	MarkerObject.SetField("id", polyID)
	polylines.Put(polyID, MarkerObject)
	Return MarkerObject
End Sub

Sub AddPolylineMarker(polyID As String, Lat As Double, Lng As Double)
	polyID = UI.CleanID(polyID)
	If polylines.ContainsKey(polyID) = False Then Return
	Dim latlng As Object = L.RunMethod("latLng", Array(Lat, Lng))
	Dim poly As BANanoObject = polylines.Get(polyID)
	'get existing polygons
	Dim latlngs As List = poly.RunMethod("getLatLngs", Null).Result
	latlngs.Add(latlng)
	poly.RunMethod("setLatLngs", Array(latlngs))
End Sub

Sub RefreshPolyline(polyID As String) As BANanoObject
	polyID = UI.CleanID(polyID)
	If polylines.ContainsKey(polyID) = False Then Return Null
	Dim poly As BANanoObject = polylines.Get(polyID)
	poly.RunMethod("addTo", MapObject)
	Return poly
End Sub

'clear polygon points
Sub ClearPolygon(polygonID As String)
	polygonID = UI.CleanID(polygonID)
	If polygons.ContainsKey(polygonID) Then Return
	Dim MarkerObj As BANanoObject = polygons.Get(polygonID)
	MarkerObj.RunMethod("setLatLngs", Array(Array()))
End Sub

Sub ClearPolygonObj(poly As BANanoObject)
	poly.RunMethod("setLatLngs", Array(Array()))
End Sub

Sub ClearPolylineObj(poly As BANanoObject)
	poly.RunMethod("setLatLngs", Array(Array()))
End Sub

'clear polygon points
Sub ClearPolyline(ID As String)
	ID = UI.CleanID(ID)
	If polylines.ContainsKey(ID) Then Return
	Dim MarkerObj As BANanoObject = polylines.Get(ID)
	MarkerObj.RunMethod("setLatLngs", Array(Array()))
End Sub

'add a simple polygon marker
Sub AddPolygonMarker(polygonID As String, Lat As Double, Lng As Double)
	polygonID = UI.CleanID(polygonID)
	If polygons.ContainsKey(polygonID) = False Then Return
	Dim latlng As Object = L.RunMethod("latLng", Array(Lat, Lng))
	Dim poly As BANanoObject = polygons.Get(polygonID)
	'get existing polygons
	Dim latlngs As List = poly.RunMethod("getLatLngs", Null).Result
	latlngs.Get(0).As(List).Add(latlng)
	poly.RunMethod("setLatLngs", Array(latlngs))
End Sub

Sub AddPolygonMarkerObj(poly As BANanoObject, Lat As Double, Lng As Double)
	Dim latlng As Object = L.RunMethod("latLng", Array(Lat, Lng))
	'get existing polygons
	Dim latlngs As List = poly.RunMethod("getLatLngs", Null).Result
	'add point
	latlngs.Get(0).As(List).Add(latlng)
	poly.RunMethod("setLatLngs", Array(latlngs))
End Sub

Sub AddPolylineMarkerObj(poly As BANanoObject, Lat As Double, Lng As Double)
	Dim latlng As Object = L.RunMethod("latLng", Array(Lat, Lng))
	'get existing polygons
	Dim latlngs As List = poly.RunMethod("getLatLngs", Null).Result
	'add point
	latlngs.Get(0).As(List).Add(latlng)
	poly.RunMethod("setLatLngs", Array(latlngs))
End Sub

'executes adding a polygon to the map
Sub RefreshPolygonObj(poly As BANanoObject)
	poly.RunMethod("addTo", MapObject)
End Sub

'executes adding a polyline to the map
Sub RefreshPolylineObj(poly As BANanoObject)
	poly.RunMethod("addTo", MapObject)
End Sub

'executes adding a polygon to the map
Sub RefreshPolygon(polygonID As String) As BANanoObject
	polygonID = UI.CleanID(polygonID)
	If polygons.ContainsKey(polygonID) = False Then Return Null
	Dim poly As BANanoObject = polygons.Get(polygonID)
	poly.RunMethod("addTo", MapObject)
	Return poly
End Sub

'Removes a Marker from the map.
Sub RemoveMarker(markerID As String)
	markerID = UI.CleanID(markerID)
	If markers.ContainsKey(markerID) = False Then Return
	Dim MarkerObject As BANanoObject = markers.Get(markerID)
	MapObject.RunMethod("removeLayer", MarkerObject)
	markers.Remove(markerID)
End Sub

Sub RemoveImage(imgID As String)
	imgID = UI.CleanID(imgID)
	If images.ContainsKey(imgID) = False Then Return
	Dim imgObj As BANanoObject = images.Get(imgID)
	MapObject.RunMethod("removeLayer", imgObj)
	images.Remove(imgID)
End Sub

Sub RemoveCircle(markerID As String)
	markerID = UI.CleanID(markerID)
	If circles.ContainsKey(markerID) = False Then Return
	Dim MarkerObject As BANanoObject = circles.Get(markerID)
	MapObject.RunMethod("removeLayer", MarkerObject)
	circles.Remove(markerID)
End Sub

Sub RemovePolygon(markerID As String)
	markerID = UI.CleanID(markerID)
	If polygons.ContainsKey(markerID) = False Then Return
	Dim MarkerObject As BANanoObject = polygons.Get(markerID)
	MapObject.RunMethod("removeLayer", MarkerObject)
	polygons.Remove(markerID)
End Sub

Sub RemovePolyline(markerID As String)
	markerID = UI.CleanID(markerID)
	If polylines.ContainsKey(markerID) = False Then Return
	Dim MarkerObject As BANanoObject = polylines.Get(markerID)
	MapObject.RunMethod("removeLayer", MarkerObject)
	polylines.Remove(markerID)
End Sub

Sub RemoveMarkerObj(MarkerObject As BANanoObject)
	Dim markerID As String = MarkerObject.GetField("id").result
	MapObject.RunMethod("removeLayer", MarkerObject)
	markers.Remove(markerID)
	
End Sub

Sub RemoveCircleObj(MarkerObject As BANanoObject)
	Dim markerID As String = MarkerObject.GetField("id").result
	MapObject.RunMethod("removeLayer", MarkerObject)
	circles.Remove(markerID)
	
End Sub

Sub RemovePolygonObj(MarkerObject As BANanoObject)
	Dim markerID As String = MarkerObject.GetField("id").result
	MapObject.RunMethod("removeLayer", MarkerObject)
	polygons.Remove(markerID)
	
End Sub

Sub PolylineFitToBounds(polyID As String)
	polyID = UI.CleanID(polyID)
	If polylines.ContainsKey(polyID) = False Then Return
	Dim pol As BANanoObject = polylines.Get(polyID)
	Dim obj As Object = pol.RunMethod("getBounds", Null).result
	MapObject.RunMethod("fitBounds", obj)
End Sub

Sub CircleFitToBounds(polyID As String)
	polyID = UI.CleanID(polyID)
	If circles.ContainsKey(polyID) = False Then Return
	Dim pol As BANanoObject = circles.Get(polyID)
	Dim obj As Object = pol.RunMethod("getBounds", Null).result
	MapObject.RunMethod("fitBounds", obj)
End Sub

Sub PolygonFitToBounds(polyID As String)
	polyID = UI.CleanID(polyID)
	If polygons.ContainsKey(polyID) = False Then Return
	Dim pol As BANanoObject = polygons.Get(polyID)
	Dim obj As Object = pol.RunMethod("getBounds", Null).result
	MapObject.RunMethod("fitBounds", obj)
End Sub

Sub GetPolylineBounds(polyID As String) As Object
	polyID = UI.CleanID(polyID)
	If polylines.ContainsKey(polyID) = False Then Return Null
	Dim pol As BANanoObject = polylines.Get(polyID)
	Dim obj As Object = pol.RunMethod("getBounds", Null).result
	Return obj
End Sub

Sub GetCircleBounds(id As String) As Object
	id = UI.CleanID(id)
	If circles.ContainsKey(id) = False Then Return Null
	Dim pol As BANanoObject = circles.Get(id)
	Dim obj As Object = pol.RunMethod("getBounds", Null).result
	Return obj
End Sub

Sub GetMarkerBounds(id As String) As Object
	id = UI.CleanID(id)
	If markers.ContainsKey(id) = False Then Return Null
	Dim mark As BANanoObject = markers.Get(id)
	Dim latlng As Object = mark.RunMethod("getLatLng", Null)
	Dim obj As Object = L.RunMethod("latLngBounds", latlng).result
	Return obj
End Sub

public Sub SetMarkerRotationOrigin(id As String, rotationOrigin As Float)
	id = UI.CleanID(id)
	If markers.ContainsKey(id) = False Then Return
	Dim mark As BANanoObject = markers.Get(id)
	mark.GetField("options").SetField("rotationOrigin", rotationOrigin)
End Sub

public Sub SetMarkerRotationAngle(id As String, rotationAngle As Float)
	id = UI.CleanID(id)
	If markers.ContainsKey(id) = False Then Return
	Dim mark As BANanoObject = markers.Get(id)
	mark.GetField("options").SetField("rotationAngle", rotationAngle)
End Sub

Sub GetCircleRadius(id As String) As Int
	id = UI.CleanID(id)
	If circles.ContainsKey(id) = False Then Return Null
	Dim pol As BANanoObject = circles.Get(id)
	Dim obj As Object = pol.RunMethod("getRadius", Null).result
	Return obj
End Sub

'execute fitBounds to the map
Sub FitBounds(target As Object)
	MapObject.RunMethod("fitBounds", target)
End Sub

Sub RemovePolylineObj(MarkerObject As BANanoObject)
	Dim markerID As String = MarkerObject.GetField("id").result
	MapObject.RunMethod("removeLayer", MarkerObject)
	polylines.Remove(markerID)
	
End Sub

'Whether the marker is draggable with mouse/touch or not.
Public Sub SetMarkerDraggable(markerID As String, Draggable As Boolean)
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = markers.Get(markerID)
	MarkerObject.GetField("options").SetField("draggable", Draggable)
	
End Sub

Public Sub SetDraggableObj(MarkerObject As BANanoObject, Draggable As Boolean) 
	MarkerObject.GetField("options").SetField("draggable", Draggable)
	
End Sub

'Whether to pan the map when dragging this marker near its edge or not.
Public Sub SetMarkerAutoPan(markerID As String, AutoPan As Boolean) 
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = markers.Get(markerID)
	MarkerObject.GetField("options").SetField("autoPan", AutoPan)
	
End Sub

Public Sub SetAutoPanObj(MarkerObject As BANanoObject, AutoPan As Boolean) 
	MarkerObject.GetField("options").SetField("autoPan", AutoPan)
	
End Sub

Public Sub SetMarkerTooltip(markerID As String, Tooltip As String) 
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = markers.Get(markerID)
	If Tooltip = "" Then
		MarkerObject.RunMethod("unbindTooltip", Null)
	Else
		MarkerObject.RunMethod("bindTooltip", Tooltip)
	End If
	
End Sub

Public Sub SetPolygonTooltip(markerID As String, Tooltip As String) 
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = polygons.Get(markerID)
	If Tooltip = "" Then
		MarkerObject.RunMethod("unbindTooltip", Null)
	Else
		MarkerObject.RunMethod("bindTooltip", Tooltip)
	End If
	
End Sub

Public Sub SetCircleTooltip(markerID As String, Tooltip As String) 
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = circles.Get(markerID)
	If Tooltip = "" Then
		MarkerObject.RunMethod("unbindTooltip", Null)
	Else
		MarkerObject.RunMethod("bindTooltip", Tooltip)
	End If
	
End Sub

Public Sub SetTooltipObj(MarkerObject As BANanoObject, Tooltip As String) 
	If Tooltip = "" Then
		MarkerObject.RunMethod("unbindTooltip", Null)
	Else
		MarkerObject.RunMethod("bindTooltip", Tooltip)
	End If
	
End Sub
	
'Sets the popup of this marker
Public Sub SetMarkerPopup(markerID As String, Popup As String) 
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = markers.Get(markerID)
	If Popup = "" Then
		MarkerObject.RunMethod("unbindPopup", Null)
	Else
		MarkerObject.RunMethod("bindPopup", Popup)
	End If
	
End Sub

Public Sub SetPopupObj(MarkerObject As BANanoObject, Popup As String) 
	If Popup = "" Then
		MarkerObject.RunMethod("unbindPopup", Null)
	Else
		MarkerObject.RunMethod("bindPopup", Popup)
	End If
	
End Sub

Public Sub SetCirclePopup(markerID As String, Popup As String) 
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = circles.Get(markerID)
	If Popup = "" Then
		MarkerObject.RunMethod("unbindPopup", Null)
	Else
		MarkerObject.RunMethod("bindPopup", Popup)
	End If
	
End Sub

'Sets the popup of this marker
Public Sub SetPolygonPopup(markerID As String, Popup As String) 
	markerID = UI.CleanID(markerID)
	Dim MarkerObject As BANanoObject = polygons.Get(markerID)
	If Popup = "" Then
		MarkerObject.RunMethod("unbindPopup", Null)
	Else
		MarkerObject.RunMethod("bindPopup", Popup)
	End If
	
End Sub

Sub RemoveRectangle(markerID As String)
	markerID = UI.CleanID(markerID)
	If rectangles.ContainsKey(markerID) = False Then Return
	Dim MarkerObject As BANanoObject = rectangles.Get(markerID)
	MapObject.RunMethod("removeLayer", MarkerObject)
	rectangles.Remove(markerID)
End Sub

''add a polyline
'Sub AddPolyLine(polyLineID As String, polyLineTitle As String, polyLinefitBounds As Boolean,polyLineColor As String, polyLineWeight As String, polyLineOpacity As String, polyLineFillColor As String, polyLineFillOpacity As String)
'	polyLineID = polyLineID.tolowercase
'	Dim pe As LL_PolyLine
'	pe.Initialize
'	pe.id = polyLineID
'	pe.Title = polyLineTitle
'	pe.Color = polyLineColor
'	pe.Weight = polyLineWeight
'	pe.Opacity = polyLineOpacity
'	pe.FillColor = polyLineFillColor
'	pe.FillOpacity = polyLineFillOpacity
'	pe.fitBounds = polyLinefitBounds
'	pe.points.Initialize
'	polylines.Put(polyLineID,pe)
'End Sub

''add a simple polyline marker
'Sub AddPolyLineMarker(polyLineID As String, markerLat As String, markerLng As String)
'	polyLineID = polyLineID.tolowercase
'	If polylines.ContainsKey(polyLineID) Then
'		Dim mark As Map = CreateMap("lat": markerLat, "lng": markerLng)
'		Dim pe As LL_PolyLine = polylines.Get(polyLineID)
'		pe.points.Add(mark)
'		polylines.Put(polyLineID,pe)
'	End If
'End Sub

'build the polygons
'private Sub BuildPolygons() As String
'	Dim sb As StringBuilder
'	sb.Initialize
'	Dim rsCnt As Int
'	Dim rsTot As Int = polygons.Size - 1
'	For rsCnt = 0 To rsTot
'		Dim pe As LL_PolyLine = polygons.GetValueAt(rsCnt)
'		Dim polid As String = polygons.GetKeyAt(rsCnt)
'		Dim marks As List = pe.points
''		Dim pLine As String = $"var p${polid} = L.polygon([${BuildPolygonMarkers(marks)}],{opacity:${pe.Opacity},color:'${pe.Color}',fillColor:'${pe.FillColor}',fillOpacity:${pe.FillOpacity},weight:${pe.Weight}}).addTo(map${ID});"$
''		sb.Append(pLine).Append(CRLF)
''		If pe.Title.Length > 0 Then
''			pLine = $"p${polid}.bindPopup("${pe.Title}");"$
''			sb.Append(pLine).Append(CRLF)
''		End If
''		'ensure the popup is opened where necessary
''		If OpenPopUpMap.ContainsKey(polid) Then
''			Dim ml As String = $"p${polid}.openPopup();"$
''			sb.Append(ml).Append(CRLF)
''		End If
''		If pe.fitBounds = True Then
''			sb.Append($"map${ID}.fitBounds(p${polid}.getBounds());"$).Append(CRLF)
''		End If
'	Next
'	Return sb.tostring
'End Sub

'build the polylines
'private Sub BuildPolyLines() As String
'	Dim sb As StringBuilder
'	sb.Initialize
'	Dim rsCnt As Int
'	Dim rsTot As Int = polylines.Size - 1
'	For rsCnt = 0 To rsTot
'		Dim pe As LL_PolyLine = polylines.GetValueAt(rsCnt)
'		Dim polid As String = polylines.GetKeyAt(rsCnt)
'		Dim marks As List = pe.points
''		Dim pLine As String = $"var pl${polid} = L.polyline([${BuildPolygonMarkers(marks)}],{opacity:${pe.Opacity},color:'${pe.Color}',fillColor:'${pe.FillColor}',fillOpacity:${pe.FillOpacity},weight:${pe.Weight}}).addTo(map${ID});"$
''		sb.Append(pLine).Append(CRLF)
''		If pe.Title.Length > 0 Then
''			pLine = $"pl${polid}.bindPopup("${pe.Title}");"$
''			sb.Append(pLine).Append(CRLF)
''		End If
''		'ensure the popup is opened where necessary
''		If OpenPopUpMap.ContainsKey(polid) Then
''			Dim ml As String = $"pl${polid}.openPopup();"$
''			sb.Append(ml).Append(CRLF)
''		End If
''		If pe.fitBounds = True Then
''			sb.Append($"map${ID}.fitBounds(pl${polid}.getBounds());"$).Append(CRLF)
''		End If
'	Next
'	Return sb.tostring
'End Sub


'build the polygon marker points
'private Sub BuildPolygonMarkers(marks As List) As String
'	Dim themMarks As List
'	themMarks.Initialize
'	Dim rsCnt As Int
'	Dim rsTot As Int = marks.Size - 1
'	For rsCnt = 0 To rsTot
'		Dim mark As Map = marks.Get(rsCnt)
'		Dim lat As String = mark.Get("lat")
'		Dim lng As String = mark.Get("lng")
'		Dim pm As String = $"[${lat},${lng}]"$
'		themMarks.Add(pm)
'	Next
''	Return Join(",",themMarks)
'End Sub


'build the markers for the map
'private Sub BuildMarkers() As String
'	Dim sb As StringBuilder
'	sb.Initialize
'	Dim rsCnt As Int
'	Dim rsTot As Int = markers.Size - 1
'	For rsCnt = 0 To rsTot
'		Dim mt As LL_Marker = markers.GetValueAt(rsCnt)
''		'Dim drag As String = Page.iif(mt.MarkerDraggable=True,"true","false")
''		If mt.MarkerHasIcon = False Then
''			If UseMakiMarkers = True Then
''				Dim ml As String = $"var i${mt.markerid} = L.MakiMarkers.icon({icon: null, color: null});"$
''				sb.Append(ml).Append(CRLF)
''				Dim ml As String = $"var m${mt.MarkerId} = L.marker([${mt.MarkerLatitude}, ${mt.MarkerLongitude}], {icon: i${mt.MarkerId}}).addTo(map${ID});"$
''				sb.Append(ml).Append(CRLF)
''			Else
''				Dim ml As String = $"var m${mt.MarkerId} = L.marker([${mt.MarkerLatitude}, ${mt.MarkerLongitude}]).addTo(map${ID});"$
''				sb.Append(ml).Append(CRLF)
''			End If
''		Else
''			If mt.MarkerIcon = "" Then mt.MarkerIcon = "null"
''			If mt.markercolor = "" Then mt.MarkerColor = "null"
''			If mt.MarkerIconSize = "" Then mt.MarkerIconSize = "null"
''			Dim ml As String = $"var i${mt.markerid} = L.MakiMarkers.icon({icon: "${mt.markericon}",color: "${mt.markercolor}", size: "${mt.MarkerIconSize}"});"$
''			ml = ml.Replace(QUOTE & "null" & QUOTE, "null")
''			sb.Append(ml).Append(CRLF)
''			Dim ml As String = $"var m${mt.MarkerId} = L.marker([${mt.MarkerLatitude}, ${mt.MarkerLongitude}], {icon: i${mt.MarkerId}}).addTo(map${ID});"$
''			sb.Append(ml).Append(CRLF)
''		End If
''		If mt.MarkerTitle.Length > 0 Then
''			ml = $"m${mt.MarkerId}.bindPopup("${mt.MarkerTitle}");"$
''			sb.Append(ml).Append(CRLF)
''		End If
''		'ensure the popup is opened where necessary
''		If OpenPopUpMap.ContainsKey(mt.MarkerId) Then
''			Dim ml As String = $"m${mt.markerid}.openPopup();"$
''			sb.Append(ml).Append(CRLF)
''		End If
'	Next
'	Return sb.tostring
'End Sub

'build the popups for the map
'private Sub BuildPopUps() As String
'	Dim sb As StringBuilder
'	sb.Initialize
'	Dim rsCnt As Int
'	Dim rsTot As Int = popups.Size - 1
'	For rsCnt = 0 To rsTot
''		Dim mt As UOEMBMarkerType = popups.GetValueAt(rsCnt)
''		Dim ml As String = $"var pop${mt.MarkerId} = L.popup().setLatLng([${mt.MarkerLatitude}, ${mt.MarkerLongitude}]).setContent("${mt.MarkerTitle}").openOn(map${ID});"$
''		sb.Append(ml).Append(CRLF)
''	Next
'	Return sb.tostring
'End Sub

'build the circles
'private Sub BuildCircles() As String
'	Dim sb As StringBuilder
'	sb.Initialize
'	Dim rsCnt As Int
'	Dim rsTot As Int = circles.Size - 1
'	For rsCnt = 0 To rsTot
''		Dim mc As UOEMBCircle = circles.GetValueAt(rsCnt)
''		Dim mmc As String = $"var c${mc.CircleId} = L.circle([${mc.CircleLatitude}, ${mc.CircleLongitude}],{color:'${mc.CircleColor}',fillColor:'${mc.CircleFillColor}',fillOpacity:${mc.CircleFillOpacity},radius:${mc.CircleRadius},weight:${mc.CircleWeight}}).addTo(map${ID});"$
''		sb.Append(mmc).Append(CRLF)
''		If mc.circletitle.Length > 0 Then
''			mmc = $"c${mc.circleid}.bindPopup("${mc.circletitle}");"$
''			sb.Append(mmc).Append(CRLF)
''		End If
''		'ensure the popup is opened where necessary
''		If OpenPopUpMap.ContainsKey(mc.CircleId) Then
''			Dim ml As String = $"c${mc.CircleId}.openPopup();"$
''			sb.Append(ml).Append(CRLF)
''		End If
'	Next
'	Return sb.tostring
'End Sub

'build the code to geolocate user location
'private Sub BuildGeoLocate() As String
'	Dim script As String = $"function onLocationFound${ID}(e) {
'		var radius = e.accuracy / 2;
'        var location = e.latlng
'        L.marker(location).addTo(map${ID})
'        L.circle(location, radius).addTo(map${ID});
'		$('#${txtBox}').val(e.latlng);  
'	}
'	function onLocationError${ID}(e) {
'	}
'	map${ID}.on('locationfound', onLocationFound${ID});
'	map${ID}.on('locationerror', onLocationError${ID});
'	map${ID}.locate({setView: true, maxZoom: ${MaxZoom}});"$
'	Return script
'End Sub

'build the shapefiles
'private Sub BuildShapeFiles() As String
'	Dim sb As StringBuilder
'	sb.Initialize
'	For Each shpKey As String In shapeFiles.Keys
'		Dim shpFile As String = shapeFiles.Get(shpKey)
'		Dim script As String = $"var shpfile${shpKey} = new L.Shapefile('${shpFile}');
'		shpfile${shpKey}.addTo(map${ID});"$
'		
'		
'		Dim script As String = $"var geo${shpKey} = L.geoJson({features:[]},{onEachFeature:function popUp(f,l){
'    		var out = [];
'    		if (f.properties){
'        		for(var key in f.properties){
'            	out.push(key+": "+f.properties[key]);
'        }
'        l.bindPopup(out.join("<br />"));
'    }
'}}).addTo(map${ID});
'      var base${shpKey} = '${shpFile}';
'		shp(base${shpKey}).then(function(data){
'		geo${shpKey}.addData(data);
'		});"$
'		sb.Append(script).Append(CRLF)
'	Next
'	Return sb.tostring
'End Sub


'Binds an Event to the map.
private Sub BindEvent(Event As String, EventHandler As Object, Callback As String)
	BANano.ToElement(MapObject).On(Event.ToLowerCase, EventHandler, Callback.ToLowerCase)
End Sub

'
'Unbinds a Event from the map.
private Sub UnbindEvent(Event As String, EventHandler As Object, Callback As String)			'ignore
	BANano.ToElement(MapObject).Off(Event.ToLowerCase)
End Sub

private Sub LeafletMapEvent(Event As Map)
	Dim seventType As String = Event.Get("type")
	Dim clientEvent As String = $"${mName}_${seventType}"$
	BANano.CallSub(mCallBack, clientEvent, Array(Event))
End Sub

private Sub MarkerEvent(Event As Map)
	Dim seventType As String = Event.Get("type")
	Dim clientEvent As String = $"${mName}_Marker${seventType}"$
	BANano.CallSub(mCallBack, clientEvent, Array(Event))
End Sub

'Binds an Event
Public Sub BindMarkerEvent(MarkerObject As BANanoObject, Event As String, EventHandler As Object, Callback As String)
	BANano.ToElement(MarkerObject).On(Event.ToLowerCase, EventHandler, Callback.ToLowerCase)
End Sub

'Unbinds an Event
Public Sub UnbindMarkerEvent(MarkerObject As BANanoObject, Event As String, EventHandler As Object, Callback As String)
	BANano.ToElement(MarkerObject).Off(Event.ToLowerCase)
End Sub

'start geo location
Sub Locate(bWatch As Boolean, bSetView As Boolean, bEnableHighAccuracy As Boolean)
	Dim opt As Map = CreateMap()
	opt.Put("watch", bWatch)
	opt.Put("setView", bSetView)
	opt.Put("enableHighAccuracy", bEnableHighAccuracy)
	MapObject.RunMethod("locate", opt)
End Sub

'stop geo location
Sub StopLocate
	MapObject.RunMethod("stopLocate", Null)
End Sub
