B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=8.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	Private nid As Int = 1
	Private GPS As GPS
	Private Tracking As Boolean
	Private LastUpdateTime As Long
	Private lock As PhoneWakeState
End Sub

Sub Service_Create
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_NEVER 'we are handling it ourselves
	GPS.Initialize("gps")
	lock.PartialLock
End Sub

Sub Service_Start (StartingIntent As Intent)
	
	Service.StartForeground(nid, CreateNotification("..."))
	Track
End Sub

Public Sub Track
	If Tracking Then Return
	If Starter.rp.Check(Starter.rp.PERMISSION_ACCESS_FINE_LOCATION) = False Then
		Log("No permission")
		Return
	End If
	GPS.Start(0, 0)
	Tracking = True
End Sub

Sub GPS_LocationChanged (Location1 As Location)
	If DateTime.Now > LastUpdateTime + 10 * DateTime.TicksPerSecond Then
		Dim body As String = $"$2.5{Location1.Latitude} / $2.5{Location1.Longitude}"$
		Dim n As Notification = CreateNotification(body)
		n.Notify(nid)
		Log(body)
		LastUpdateTime = DateTime.Now
	End If
End Sub

Sub CreateNotification (Body As String) As Notification
	Dim notification As Notification
	notification.Initialize2(notification.IMPORTANCE_LOW)
	notification.Icon = "icon"
	notification.SetInfo("Tracking location", Body, Main)
	Return notification
End Sub

Sub Service_Destroy
	If Tracking Then
		GPS.Stop
	End If
	Tracking = False
	lock.ReleasePartialLock
End Sub
