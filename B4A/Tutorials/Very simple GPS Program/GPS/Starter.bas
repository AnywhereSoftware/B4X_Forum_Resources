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
	Public GPS1 As GPS
	Private gpsStarted As Boolean
	Private context As JavaObject
	Dim lat As String
	Dim lon As String
	Dim location As String
End Sub

Sub Service_Create
	GPS1.Initialize("GPS")
	context.InitializeContext
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Public Sub StartGps
	If gpsStarted = False Then
		GPS1.Start(0, 0)
		gpsStarted = True
	End If
End Sub


Public Sub LocationChanged(Location1 As Location)
	lat = Location1.ConvertToMinutes(Location1.Latitude)
	lon = Location1.ConvertToMinutes(Location1.Longitude)
	location = lat&"/"&lon
	Log(location)
	ToastMessageShow(location,False)
	If location = "" Then
		Else
		StopGps
	End If
End Sub

Public Sub StopGps
	If gpsStarted Then
		GPS1.Stop
		gpsStarted = False
	End If
End Sub

Sub GPS_LocationChanged (Location1 As Location)
	LocationChanged(Location1)
End Sub

Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
	StopGps
End Sub