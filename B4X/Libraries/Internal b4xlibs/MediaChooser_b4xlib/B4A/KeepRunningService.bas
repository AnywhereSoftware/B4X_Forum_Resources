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
	Private Const NotificationId As Int = 2323
	Public NotificationTitle As String = "Taking picture"
End Sub

Sub Service_Create
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_NEVER
End Sub

Sub Service_Start (StartingIntent As Intent)
	
End Sub

Public Sub Start
	Dim n As Notification
	n.Initialize2(n.IMPORTANCE_LOW)
	n.Icon = "icon"
	n.SetInfo(Application.LabelName, NotificationTitle, Main)
	Service.StartForeground(NotificationId, n)
End Sub

Public Sub Stop
	Service.StopForeground(NotificationId)
End Sub

Private Sub Service_Timeout(Params As Map)
	Service.StopForeground(NotificationId)
End Sub

Sub Service_Destroy
End Sub

