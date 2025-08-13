B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private MapView1 As MapView
	
	Private EventsOverlay As MapEventsOverlay
	Private MarkerOverlay As FolderOverlay
	Private RouteOverlay As FolderOverlay
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub MapView1_MapViewReady 'Event fires when MapView is initialized and ready.
	MapView1.MultiTouchControls=True
	MapView1.ZoomController.SetVisibility(CustomZoomButtons_Constants.ZOOM_CONTROLS_VISIBLE_ALWAYS)
	MapView1.ZoomController.Display.SetPositions(CustomZoomButtons_Constants.ALIGNMENT_VERTICAL,CustomZoomButtons_Constants.HORIZONTAL_POSITION_RIGHT,CustomZoomButtons_Constants.VERTICAL_POSITION_BOTTOM)
	
	MapView1.TileSource=TileSourceFactory.TILE_SOURCE_MAPNIK   'Set Mapnik as map tile source.
	
	EventsOverlay.Initialize(MapView1) 'Overlay required for MapLongPress and MapSingleTap event
	MarkerOverlay.Initialize.SetName("Markers") 'Overlay for Markers
	RouteOverlay.Initialize.SetName("Routes") 'Overlay for Routes
	MapView1.Overlays.AddAll(Array As Overlay(EventsOverlay, MarkerOverlay,RouteOverlay))
	MapView1.MapController.AnimateTo(51.50853, -0.12574) 'Set map center to London (Set where you want). On MapViewReady event always use AnimateTo method, after that you can use SetCenter 
	MapView1.Zoom=18 'Set initial Zoom level.
End Sub


Private Sub btnCreateRoute_Click
	Dim listOfGeo As ListOfGeoPoints
	listOfGeo.Initialize
	For i=0 To MarkerOverlay.Items.Size-1
		Dim TempMarker As Marker=MarkerOverlay.Items.GetAt(i)
		Dim Point As GeoPoint
		Point.Initialize(TempMarker.GetPosition.GetLatitude,TempMarker.GetPosition.GetLongitude)
		listOfGeo.Add(Point)
		Log(Point)
	Next
	Dim OsmRoute As OSRMRoadManager
	OsmRoute.Initialize
	Dim r As Road=OsmRoute.GetRoad(listOfGeo)
	If r.Status=Road_Statuses.STATUS_OK Then
		Dim RoutePoly As Polyline
		RoutePoly.Initialize(MapView1).SetPoints(r.RouteHigh)
		RoutePoly.OutlinePaint.SetColor(Colors.Red).SetAlpha(255)
		RouteOverlay.Items.Add(RoutePoly)
		MapView1.Invalidate
	End If
	'For Walking route you must use MapQuestRoadManager which require free Api key...
End Sub

Private Sub btnClear_Click
	MarkerOverlay.Items.Clear
	RouteOverlay.Items.Clear
	MapView1.Invalidate
End Sub

Private Sub MapView1_MapLongPress (Point As GeoPoint) As Boolean ' Return True to consume event. MapEventsOverlay required.
	Dim mark As Marker
	mark.Initialize(MapView1).SetPosition(Point)
	MarkerOverlay.Items.Add(mark)
	MapView1.Invalidate
	Return True
End Sub

Private Sub MapView1_MapSingleTap (Point As GeoPoint) As Boolean ' Return True to consume event. MapEventsOverlay required.
	Log(Point.GetLatitude)
	Log(Point.GetLongitude)
	Return True
End Sub