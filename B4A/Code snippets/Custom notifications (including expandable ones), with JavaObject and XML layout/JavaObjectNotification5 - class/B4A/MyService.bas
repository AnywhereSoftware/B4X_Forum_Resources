B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=13.4
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public CONST notificationId As Int = 2001
End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	
	'In this case, it's because the service is always active:
	'We initialize the class
	Dim cn As CustomNotification
	cn.Initialize
	
	' We generate the notification by passing data if we want
	Dim notifObj As JavaObject = cn.Build("Sound Profile", "Normal")
    
	' We started Foreground
	Service.StartForeground(notificationId, notifObj)
	
	
'	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub


' It must be Public for the Receiver to see it
Public Sub ProcessActionButton(Accion As String)
	Log("Processing action: " & Accion)
	Select Accion
		Case "ACTION_1"
			' Logic
		Case "ACTION_2"
			' Logic
		Case "ACTION_3"
			' Logic
		Case "ACTION_4"
			' Logic
		Case "ACTION_5"
			' Logic
		Case "ACTION_11"
			' Logic
		Case "ACTION_12"
			' Logic
		Case "ACTION_13"
			' Logic
		Case "ACTION_14"
			' Logic
		Case "ACTION_15"
			' Logic
	End Select
End Sub
