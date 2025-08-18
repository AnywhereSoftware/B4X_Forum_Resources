B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=10.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private nid As Int = 1
	
End Sub

Sub Service_Create
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_NEVER 'we are handling it ourselves
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StartForeground(nid, CreateNotification("..."))
	StartServiceAt(Me, DateTime.Now + 30 * DateTime.TicksPerMinute, True)
End Sub

Sub Service_Destroy
	Starter.rec.StopRecording
	B4XPages.MainPage.Recording = False
End Sub

Sub CreateNotification (Body As String) As Notification
	Dim notification As Notification
	notification.Initialize2(notification.IMPORTANCE_LOW)
	notification.Icon = "icon"
	notification.SetInfo("B4XPages ScreenRecording", Body, Main)
	Return notification
End Sub
