B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region
 
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Example_AC_LeafletView.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI 
	Private AC_LeafletView1 As AC_LeafletView
	Private CustomListView1 As CustomListView
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage") 
	CustomListView1.Clear
	' --- ROUTE TESTS ---
	CustomListView1.AddTextItem("Test: Route Maputo to Xai-Xai (Blue)", "route_1")
	CustomListView1.AddTextItem("Test: Route Xai-Xai to Chissano (Green)", "route_2")

	' --- MARKER TESTS (With Extra Data) ---
	CustomListView1.AddTextItem("Test: Add Marker Manhiça (with Note)", "marker_1")
	CustomListView1.AddTextItem("Test: Add Marker Macia (with ID)", "marker_2")

	' --- CAMERA & ZOOM TESTS ---
	CustomListView1.AddTextItem("Test: Zoom Out (Country View)", "zoom_out")
	CustomListView1.AddTextItem("Test: Focus on Maputo City", "focus_maputo")

	' --- DELETION TESTS ---
	CustomListView1.AddTextItem("Test: Remove Manhiça Marker Only", "remove_m1")
	CustomListView1.AddTextItem("Test: Clear All (Routes & Markers)", "clear_all")
End Sub

Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Dim cmd As String = Value
	Log("Testing Command: " & cmd)
	
	Select cmd
		' --- ROUTE TESTS ---
		Case "route_1"
			' Draws Route from Maputo to Xai-Xai
			' ID: "RT_001" | Color: Blue
			' Note: If you click this twice, the class ignores the second call to avoid duplicates.
			AC_LeafletView1.DrawRoadRoute("RT_001", -25.9653, 32.5892, -25.0445, 33.6441, "blue")
			
		Case "route_2"
			' Draws Route from Xai-Xai to Chissano
			' ID: "RT_002" | Color: Green
			AC_LeafletView1.DrawRoadRoute("RT_002", -25.0445, 33.6441, -25.1322, 33.3155, "green")

			' --- MARKER TESTS ---
		Case "marker_1"
			' Marker with detailed Extra Data
			' Note: This data is returned when you click the marker icon or the popup.
			Dim extra1 As Map = CreateMap("db_id": 101, "status": "Active", "note": "High police presence", "time": DateTime.Time(DateTime.Now))
			AC_LeafletView1.AddMarker("M1", -25.4022, 32.8011, "Manhiça Checkpoint", extra1)
			
			' Auto-focus on the marker
			AC_LeafletView1.SetPosition(-25.4022, 32.8011, True)
			AC_LeafletView1.SetZoom(12)

		Case "marker_2"
			' Another marker to test multiple objects on map
			Dim extra2 As Map = CreateMap("db_id": 102, "status": "Warning", "note": "Fuel station and rest area")
			AC_LeafletView1.AddMarker("M2", -25.0264, 33.0921, "Macia Gas Station", extra2)

			' --- CAMERA & ZOOM TESTS ---
		Case "zoom_out"
			' Global view of Mozambique
			AC_LeafletView1.SetZoom(6)

		Case "focus_maputo"
			' Smooth pan to Maputo with high detail zoom
			AC_LeafletView1.SetPosition(-25.9653, 32.5892, True)
			AC_LeafletView1.SetZoom(15)

			' --- DELETION TESTS ---
		Case "remove_m1"
			' Test: Only the Manhiça marker should disappear
			AC_LeafletView1.RemoveMarker("M1")
			Log("Removed Marker M1")

		Case "clear_all"
			' Bulk removal test
			AC_LeafletView1.ClearAllMarkers
			AC_LeafletView1.ClearAllRoutes
			Log("Map cleared")
			
	End Select
End Sub
#region events
 
 ' Triggered when the route calculation is successfully finished
Sub AC_LeafletView1_RoutingFound (Data As Map)
	Dim routeId As String = Data.Get("id")
	Dim distance As String = Data.Get("distance")
	Dim eta As String = Data.Get("car_eta") ' Now fixed: returns "HH:mm" instead of null
    
	Log($"[Route Found] ID: ${routeId} | Distance: ${distance} km | ETA: ${eta}"$)
End Sub

' Triggered when the user clicks anywhere on the route line
Sub AC_LeafletView1_RouteClick (Data As Map)
	Log("AC_LeafletView1_RouteClick:")
	Log(Data)
'	Dim id As String = Data.Get("id")
'	Dim dist As String = Data.Get("distance")
'    
'	Log($"[Route Clicked] User selected Route ID: ${id} (${dist} km)"$)
End Sub
' Triggered when the user clicks the marker icon
Sub AC_LeafletView1_MarkerClick (Data As Map) 
	Log("AC_LeafletView1_MarkerClick:")
	Log(Data)
End Sub

' Triggered when the user clicks inside the Popup bubble of a marker
Sub AC_LeafletView1_MarkerPopupClick (Data As Map)
	Log("AC_LeafletView1_MarkerPopupClick: "&Data)
'	Dim id As String = Data.Get("id")
'	Dim extras As Map = Data.Get("extra")
'    
'	' Example: Show a message box with the extra data
''	xui.MsgboxAsync("Details for: " & id & CRLF & "Status: " & extras.Get("status"), "Point Info")
End Sub

' Confirms that a marker was successfully added to the map
Sub AC_LeafletView1_MarkerAdded (Data As Map)
	Log("Marker " & Data.Get("id") & " is now visible at " & Data.Get("lat") & ", " & Data.Get("lon"))
End Sub

' Triggered when the zoom level changes (via code or user pinch)
Sub AC_LeafletView1_ZoomChanged (Data As Map)
	' Note: The public variable AC_LeafletView1.CurrentZoom is already updated
	Log("Map Zoom Level changed to: " & Data.Get("zoom"))
End Sub

' Triggered when the user clicks on an empty space on the map
Sub AC_LeafletView1_MapClick (Data As Map)
	Dim lat As Double = Data.Get("lat")
	Dim lon As Double = Data.Get("lon")
    
	Log($"[Map Click] Coordinates: ${lat}, ${lon}"$)
	' Tip: You could use this to add a new marker at the clicked position
End Sub
#end region

Private Sub MainForm_AnimationCompleted
	
End Sub