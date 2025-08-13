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
	Private rp As RuntimePermissions
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	AddGeofence
End Sub

Sub AddGeofence
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result Then
		Dim p As Phone
		If p.SdkVersion >= 29 Then
			rp.CheckAndRequest("android.permission.ACCESS_BACKGROUND_LOCATION")
			Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		End If
		If Result Then
			Dim geo As Geofence
			geo.Initialize
			geo.Id = "Test2"
			geo.Center.Initialize2(32.83722, 35.26981) 'change location!
			geo.RadiusMeters = 100
			geo.ExpirationMs = DateTime.TicksPerDay 'expire after one day
			CallSubDelayed3(GeofenceReceiver, "AddGeofence", Me, geo)
			Wait For Geofence_Added (Success As Boolean)
			Log("Geofence added: " & Success)
		End If
	End If
End Sub
