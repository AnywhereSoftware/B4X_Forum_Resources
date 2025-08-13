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
	Private Fused As FusedLocationProviderClient
	Private rp As RuntimePermissions
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
	
	'Initialize FusedLocationProviderClient
	Fused.Initialize("FusedLocation")
End Sub

Private Sub btnStartFused_Click
	DefineFused
End Sub

Private Sub DefineFused
	If Fused.IsLocationEnabledInSettings Then
		Fused.GetLocationAvailability
		Wait For FusedLocation_LocationAvailabilityRequestCompleted (Available As Boolean)
		Log("LocationAvailable=" & Available)
		If Available Then
			Fused.GetLastLocation
			Wait For FusedLocation_LocationRequestCompleted (Result As LocationResult)
			If Result.Status=LocationResult.STATUS_SUCCESSFUL Then
				If Result.Location.IsInitialized Then
					Dim LastLocation As LocationF = Result.Location
					Log("LastLocation Latitude = " & LastLocation.Latitude)
					Log("LastLocation Longitude = " & LastLocation.Longitude)
					'Do whatever you want with other LocatioF properties and methods
				Else
					Log("Unknown last location")
				End If
			End If
		End If
	
		'Initiate FusedLocation's LocationRequest which will allow events to be fired and it will continue to work in background
		Dim LocationRequest1 As LocationRequest
		LocationRequest1.Initialize(1000) 'Refresh interval is 1000 miliseconds
		LocationRequest1.SetMinUpdateIntervalMillis(100) 'Minimum refresh interval is 100 miliseconds
		LocationRequest1.SetPriority(Priority.PRIORITY_HIGH_ACCURACY) 'Request high accuracy location
		LocationRequest1.SetMinUpdateDistanceMeters(0) 'Minimum distance in meters to fire location change event (0 is default)
		LocationRequest1.SetGranularity(Granularity.GRANULARITY_FINE)
		Fused.RequestLocationUpdates(LocationRequest1) 'Set location request to FusedLocationProviderClient and start FusedLocation
	Else
		MsgboxAsync("Location is turned off in devices's settings. Turn it on.","Warning")
		StartActivity(Fused.LocationSettingsIntent)
	End If
End Sub

Private Sub btnFusedStop_Click
	Fused.RemoveLocationUpdates ' This will stop FusedLocation to work and events will not be fired anymore. It will stop FusedLocation to work in background. You can start it again anytime you want
End Sub

Private Sub btnGetCurrentLocation_Click
	Fused.GetCurrentLocation(Priority.PRIORITY_HIGH_ACCURACY)
	Wait For FusedLocation_LocationRequestCompleted (Result As LocationResult)
	If Result.Status=LocationResult.STATUS_SUCCESSFUL Then
		If Result.Location.IsInitialized Then
			MsgboxAsync("Your current location is:" & CRLF & "Latitude=" & Result.Location.Latitude & CRLF & "Longitude=" & Result.Location.Longitude,"Current Location")
		End If
	End If
End Sub

Private Sub Msgbox_Result (Result As Int)
	Log("Msgbox_Result")
End Sub

Private Sub btnGetLastKnownLocation_Click
	Fused.GetLastLocation
	Wait For FusedLocation_LocationRequestCompleted (Result As LocationResult)
	If Result.Status=LocationResult.STATUS_SUCCESSFUL Then
		If Result.Location.IsInitialized Then
			MsgboxAsync("Your last known location is:" & CRLF & "Latitude=" & Result.Location.Latitude & CRLF & "Longitude=" & Result.Location.Longitude,"Current Location")
		End If
	End If
End Sub

Private Sub FusedLocation_LocationAvailabilityChanged (Available As Boolean)
	'This event will be fired when location availability is changed
	'For example on signal lost or when location is turned off.
	Log("LocationAvailabile = " & Available)
End Sub

Private Sub FusedLocation_LocationChanged (mLocation As LocationF)
	'This event will be fired anytime your actual location is changed and if it meets the criteria of the defined LocationRequest
	Log("Lat=" & mLocation.Latitude & CRLF & "Lng=" & mLocation.Longitude)
End Sub

Private Sub FusedLocation_LocationEnabledInSettingsChanged (Enabled As Boolean)
	'This event will be fired if user turn off or turn on Location in device's settings
	Log("LocationEnabled = " & Enabled)
	If Enabled=False Then
		StartActivity(Fused.LocationSettingsIntent)
	End If
End Sub



