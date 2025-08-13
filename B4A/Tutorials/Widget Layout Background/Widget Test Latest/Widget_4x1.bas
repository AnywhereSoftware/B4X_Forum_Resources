B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12.8
@EndOfDesignText@
Sub Process_Globals
	Private rv As RemoteViews
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		rv = ConfigureHomeWidget("4x1", "rv", 30, "Time in Letters", True)
	End If
	
	rv.HandleWidgetEvents(StartingIntent)
End Sub

Private Sub rv_RequestUpdate
	Scrivi
End Sub

Sub Scrivi
	rv.SetText("Label1", DateTime.Time(DateTime.Now))
	rv.SetText("Label2", DateTime.Date(DateTime.Now))
	rv.SetTextColor("Label1", 0xFFFFD700)
	rv.UpdateWidget
End Sub

Sub Label1_Click
	Scrivi
End Sub

Private Sub Label3_Click
	StartActivity(Activity2)
End Sub

Public Sub SetLabel3(text As String)
	rv.SetText("Label3", text)
	Scrivi
End Sub
