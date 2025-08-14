B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=13.1
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: true
	#StartCommandReturnValue: android.app.Service.START_STICKY	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Service_Create
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_NEVER 'we are handling it ourselves
End Sub

Sub Service_Start (StartingIntent As Intent)
	'others.Notif("Started", False, False, "")
	Service.StartForeground(1, others.Notif1)
End Sub

Sub Service_Destroy
	Service.StopForeground(1)
End Sub
