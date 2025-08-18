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
	Private lblLocation As B4XView
	Private lblState As B4XView
	Private flp As FusedLocationProvider
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	flp.Initialize("flp")
	flp.Connect
End Sub

Private Sub flp_ConnectionSuccess
	Log("Connected to location provider")
End Sub

Private Sub flp_ConnectionFailed(ConnectionResult1 As Int)
	Log("Failed to connect to location provider")
End Sub

Private Sub CheckLocationSettingStatus As ResumableSub
	Dim f As LocationSettingsRequestBuilder
	f.Initialize
	f.AddLocationRequest(CreateLocationRequest)
	flp.CheckLocationSettings(f.Build)
	Wait For flp_LocationSettingsChecked(LocationSettingsResult1 As LocationSettingsResult)
	Return LocationSettingsResult1
End Sub

Public Sub StartLocationUpdates
	flp.RequestLocationUpdates(CreateLocationRequest)
End Sub

Private Sub flp_LocationChanged (Location1 As Location)
	lblLocation.Text = $"$1.2{Location1.Latitude} / $1.2{Location1.Longitude}"$
End Sub

Private Sub CreateLocationRequest As LocationRequest
	Dim lr As LocationRequest
	lr.Initialize
	lr.SetInterval(0)
	Return lr
End Sub

Sub btnStart_Click
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If flp.IsConnected = False Then
		SetState("Location provider not available")
	End If
	If Result Then
		Wait For (CheckLocationSettingStatus) Complete (SettingsResult As LocationSettingsResult)
		Dim sc As StatusCodes
		Select SettingsResult.GetLocationSettingsStatus.GetStatusCode
			Case sc.SUCCESS
				SettingsAreGood
			Case sc.RESOLUTION_REQUIRED
				SetState("RESOLUTION_REQUIRED")
				Dim rs As ResumableSub = CallSub2(Main, "ShowResolutionDialog", SettingsResult.GetLocationSettingsStatus)
				Dim Result As Boolean
				If rs.IsInitialized Then
					Wait For (rs) Complete (LocationSettingsUpdated As Boolean)
					Result = LocationSettingsUpdated
				End If
				If Result Then
					SettingsAreGood
				Else
					SetState("Not enabled")
				End If
			Case Else
				SetState("Not available")
		End Select
	Else
		SetState("No permission")
	End If
End Sub

Sub SettingsAreGood
	SetState("Location enabled - waiting for updates")
	StartLocationUpdates
End Sub

Sub SetState (msg As String)
	lblState.Text = "State: " & msg
	Log(lblState.Text)
End Sub