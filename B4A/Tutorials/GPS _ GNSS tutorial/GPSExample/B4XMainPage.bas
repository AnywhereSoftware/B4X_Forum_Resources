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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=GPSExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private lblLon As B4XView
	Private lblLat As B4XView
	Private lblSpeed As B4XView
	Private lblSatellites As B4XView
	Private rp As RuntimePermissions
	Private Gnss1 As GNSS
	Private lblState As B4XView
	Private btnStartStop As B4XView
	Private GpsWorking As Boolean
	Private ConstellationToString As Map
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Gnss1.Initialize("Gnss1")
	Dim gs As GnssStatus 'ignore
	ConstellationToString = CreateMap(gs.CONSTELLATION_BEIDOU: "BEIDOU", gs.CONSTELLATION_GALILEO: "GALILEO", _
		gs.CONSTELLATION_GLONASS: "GLONASS", gs.CONSTELLATION_GPS: "GPS", gs.CONSTELLATION_QZSS: "QZSS", gs.CONSTELLATION_SBAS: "SBAS")
End Sub

Private Sub btnStartStop_Click
	If GpsWorking Then
		Gnss1.Stop
		GpsWorking = False
		btnStartStop.Text = "Start"
	Else
		If Gnss1.GPSEnabled = False Then
			ToastMessageShow("Please enable location services", True)
			StartActivity(Gnss1.LocationSettingsIntent)
		Else
			rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
			Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
			If Result Then
				Gnss1.Start(0, 0)
				GpsWorking = True
				btnStartStop.Text = "Stop"
			Else
				ToastMessageShow("No permission for fine location", True)
			End If
		End If
	End If
End Sub

Private Sub Gnss1_LocationChanged (Location1 As Location)
	lblLat.Text = "Lat = " & Location1.ConvertToMinutes(Location1.Latitude)
	lblLon.Text = "Lon = " & Location1.ConvertToMinutes(Location1.Longitude)
	lblSpeed.Text = $"Speed = $1.2{Location1.Speed} m/s "$
End Sub


Private Sub Gnss1_GnssStatus  (SatelliteInfo As GnssStatus)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("Satellites:").Append(CRLF)
	For i = 0 To SatelliteInfo.SatelliteCount - 1
		sb.Append(CRLF).Append(SatelliteInfo.Svid(i)).Append($" $1.2{SatelliteInfo.Cn0DbHz(i)}"$).Append(" ").Append(SatelliteInfo.UsedInFix(i))
		sb.Append($" $1.2{SatelliteInfo.Azimuth(i)}"$).Append($" $1.2{SatelliteInfo.Elevation(i)}"$)
		sb.Append($" $1.2{SatelliteInfo.CarrierFrequencyHz(i) / 1000000} MHz"$)
		sb.Append(" ").Append(ConstellationToString.GetDefault(SatelliteInfo.ConstellationType(i), "unknown"))
	Next
	lblSatellites.Text = sb.ToString
End Sub