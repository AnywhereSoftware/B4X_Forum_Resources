B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12
@EndOfDesignText@
Sub Process_Globals
	Private client As RecognitionClient
End Sub

Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	client.Initialize(False) 'Connect to client = false
	Dim events As List = client.GetTransitionEvents(StartingIntent)
	If events.Size = 0 Then Return
	Dim notif As Notification
	notif.Initialize2(notif.IMPORTANCE_HIGH)
	notif.Icon = "icon"
	Dim ev As TransitionEvent = events.Get(0)
	notif.SetInfo(ev.ActivityType, "" & ev, Main) 'ignore
	Log(ev) 'ignore
	notif.Notify(100)
End Sub
