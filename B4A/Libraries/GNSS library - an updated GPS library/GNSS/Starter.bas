B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=6.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public rp As RuntimePermissions
	Public GNSS1 As GNSS
	Private gpsStarted As Boolean
	Public GnssStatus1 As GnssStatus
End Sub

Sub Service_Create
	GNSS1.Initialize("GNSS")
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
	StopGNSS
End Sub


Public Sub StartGNSS
	If gpsStarted = False Then
		GNSS1.Start(0, 0)
		gpsStarted = True
	End If
End Sub

Public Sub StopGNSS
	If gpsStarted Then
		GNSS1.Stop
		gpsStarted = False
	End If
End Sub

Sub GNSS_LocationChanged (Location1 As Location)
	CallSub2(Main, "LocationChanged", Location1)
End Sub


Sub GNSS_GpsStatus (Satellites As List)
	CallSub2(Main, "GpsStatus", Satellites)
End Sub


Private Sub GNSS_GNSSStatus (Status As GnssStatus)
	CallSub2(Main, "GnssStatus", Status)
End Sub
