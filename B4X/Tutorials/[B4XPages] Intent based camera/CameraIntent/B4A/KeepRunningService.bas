B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=12.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Service_Create
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_NEVER
End Sub

Sub Service_Start (StartingIntent As Intent)
	
End Sub

Public Sub Start As ResumableSub
	Dim n As Notification
	n.Initialize2(n.IMPORTANCE_LOW)
	n.Icon = "icon"
	n.SetInfo(Application.LabelName, "Taking picture", Main)
	Service.StartForeground(1, n)
	Return True
End Sub

Public Sub Stop
	Service.StopForeground(1)
End Sub

Sub Service_Destroy
End Sub
