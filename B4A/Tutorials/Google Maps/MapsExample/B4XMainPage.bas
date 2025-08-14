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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=MapExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private MapFragment1 As MapFragment
	Private gmap As GoogleMap
	Private rp As RuntimePermissions
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Wait For MapFragment1_Ready
	gmap = MapFragment1.GetMap
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result Or rp.Check(rp.PERMISSION_ACCESS_COARSE_LOCATION) Then
		gmap.MyLocationEnabled = True
	Else
		Log("No permission!")
	End If
End Sub

Private Sub MapFragment1_Click (Point As LatLng)
	gmap.AddMarker(Point.Latitude, Point.Longitude, "new marker")
End Sub

Private Sub MapFragment1_MarkerClick (SelectedMarker As Marker) As Boolean 'Return True to consume the click
	Log($"Marker clicked: ${SelectedMarker.Title}"$)
	Return True
End Sub
