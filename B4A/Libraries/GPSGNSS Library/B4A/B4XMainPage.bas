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
	Private GPS As GPSGNSS
	Private rp As RuntimePermissions
	Private lblNumOfSattelites As Label
	Private lblAverageSignal As Label
	Private lblLatitude As Label
	Private lblLongitude As Label
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Requesting Location's runtime permissions
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_COARSE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result=False Then
		ExitApplication
	End If
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result=False Then
		ExitApplication
	End If
	
	If GPS.IsInitialized=False Then
		GPS.Initialize("GPS")
	End If
End Sub

Private Sub B4XPage_Disappear
	If GPS.IsInitialized Then
		If GPS.IsStarted Then
			GPS.Stop
		End If
	End If
	ExitApplication
End Sub

Private Sub btnStartGPSGNSS_Click
	
	If GPS.IsStarted=False Then
		GPS.Start(0,0)
	End If
End Sub

Private Sub btnStopGPSGNSS_Click
	If GPS.IsStarted=True Then
		GPS.Stop
	End If
End Sub

Private Sub Msgbox_Result (Result As Int)
	
End Sub

Private Sub btnGetLastKnownLocation_Click
	Dim loc As ALocation=GPS.LastKnownLocation
	If loc.IsInitialized Then
		MsgboxAsync("Your last known location is:" & CRLF & "Latitude=" & loc.Latitude & CRLF & "Longitude=" & loc.Longitude,"Last Known Location")
	End If
End Sub

Private Sub btnCurrentLocation_Click
	ProgressDialogShow("Collecting information...")
	Sleep(20)
	GPS.GetCurrentLocation
	Wait For GPS_CurrentLocationResult (Location1 As ALocation)
	ProgressDialogHide
	If Location1.IsInitialized Then
		MsgboxAsync("Your current location is:" & CRLF & "Latitude=" & Location1.Latitude & CRLF & "Longitude=" & Location1.Longitude,"Current Location")
	End If
End Sub

Private Sub GPS_GpsStatus (Satellites As List)
	If GPS.IsStarted Then
		Dim NumOfSat As Int=0
		Dim Signal As Float=0
		For Each sat As GPSSatellite In Satellites
			If sat.UsedInFix Then
'			Log("--------SATTELITE " & Satellites.IndexOf(sat) & "-----------------------")
'			Log("Azimuth=" & sat.Azimuth)
'			Log("Elevation=" & sat.Elevation)
'			Log("Prn=" & sat.Prn)
'			Log("Snr=" & sat.Snr)
'			Log("HasAlmanac=" & sat.HasAlmanac)
'			Log("HasEphemeris=" & sat.HasEphemeris)
'			Log("UsedInFix=" & sat.UsedInFix)
'			Log("-------------------------------------------------------------------------")
				NumOfSat=NumOfSat+1
				Signal=Signal+sat.Snr
			End If
		Next
		lblNumOfSattelites.Text="Satelites in use: " & NumOfSat
		lblAverageSignal.Text="Average signal: " & Round2(Signal/NumOfSat,2)
	End If
End Sub

Private Sub GPS_LocationChanged (Location1 As ALocation)
	If GPS.IsStarted Then
		lblLatitude.Text="Latitude: " & Round2(Location1.Latitude,8)
		lblLongitude.Text="Longitude: " & Round2(Location1.Longitude,8)
	End If	
End Sub

Private Sub GPS_UserEnabled (Enabled As Boolean)
	Log("LocationEnabled = " & Enabled)
'	If Enabled=False Then
'		StartActivity(GPS.LocationSettingsIntent)
'	End If
End Sub

Private Sub GPS_NMEA (TimeStamp As Long, Sentence As String)
	'Log("NMEA: Sentence=" & Sentence & "    TimeStamp=" & TimeStamp)
End Sub

Private Sub GPS_LocationChanged2 (Locations() As ALocation) 'Works on SDK31 and up
	'Log(Locations.Length)
End Sub

Private Sub GPS_Started
	Log("GPS_Started    GPS.IsStarted=" & GPS.IsStarted)
	lblNumOfSattelites.Text="Satelites in use: calculting"
	lblAverageSignal.Text="Average signal: calculting"
	lblLatitude.Text="Latitude: calculting"
	lblLongitude.Text="Longitude: calculting"
End Sub

Private Sub GPS_Stopped
	Log("GPS_Stopped    GPS.IsStarted=" & GPS.IsStarted)
	lblNumOfSattelites.Text="Satelites in use: unknown"
	lblAverageSignal.Text="Average signal: unknown"
	lblLatitude.Text="Latitude: unknown"
	lblLongitude.Text="Longitude: unknown"
End Sub
