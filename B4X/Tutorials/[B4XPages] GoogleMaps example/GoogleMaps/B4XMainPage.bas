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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private gmap As GoogleMap
	#if B4A
	Private Mapfragment1 As MapFragment
	Private rp As RuntimePermissions
	#else if B4J
	#else if B4i
	#end if
	Private pnlMap As B4XView
	Private btnJumpToParis As B4XView
	Private MapReady As Boolean
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	btnJumpToParis.Enabled = False
	Wait For (InitializeMap) Complete (Success As Boolean)
	MapReady = Success
	If MapReady Then
		Log("map ready")
		btnJumpToParis.Enabled = True
		gmap.AddMarker(0, 0, "Center")
	End If
End Sub

Private Sub InitializeMap As ResumableSub
	#if B4J
	gmap.Initialize2("gmap", Null, Main.API_KEY)
	pnlMap.AddView(gmap.AsPane, 0, 0, pnlMap.Width, pnlMap.Height)
	Wait For gmap_Ready
	Return gmap.IsReady
	#Else If B4i
	gmap.Initialize("gmap", Main.API_KEY)
	pnlMap.AddView(gmap, 0, 0, pnlMap.Width, pnlMap.Height)
	gmap.GetUiSettings.CompassEnabled = True
	gmap.GetUiSettings.MyLocationButtonEnabled = True
	gmap.MyLocationEnabled = True
	Return True
	#Else if B4A
	Wait For gmap_Ready
	gmap = Mapfragment1.GetMap
	If gmap.IsInitialized Then
		rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result Then
			gmap.MyLocationEnabled = True
		End If
	End If
	Return gmap.IsInitialized	
	#End If
End Sub


Private Sub B4XPage_Resize (Width As Int, Height As Int)
	#if B4J
	gmap.AsPane.SetSize(pnlMap.Width, pnlMap.Height)
	#Else If B4i
	If gmap.IsInitialized Then gmap.SetLayoutAnimated(0, 1, 0, 0, pnlMap.Width, pnlMap.Height)
	#end if
End Sub

Sub btnJumpToParis_Click
	Dim cp As CameraPosition
	cp.Initialize(48.8566, 2.3522, 10)
	gmap.MoveCamera(cp)
End Sub