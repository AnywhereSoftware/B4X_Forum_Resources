B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=13.1
@EndOfDesignText@
Sub Process_Globals
	
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	StartForegroundService(serv)
End Sub

Public Sub StartForegroundService(Service As Object)
	Dim p As Phone
	If p.SdkVersion <= 26 Then
		StartService(Service)
		Return
	End If
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim intent As JavaObject
	intent.InitializeNewInstance("android.content.Intent", Array(ctxt, Service))
	ctxt.RunMethod("startForegroundService", Array(intent))
End Sub
