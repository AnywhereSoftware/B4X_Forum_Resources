B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=10
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	Private fm As FirebaseMessaging
End Sub

Sub Service_Create
	fm.Initialize("fm")
	Log(fm.Token)
End Sub

Public Sub SubscribeToTopics
	fm.SubscribeToTopic("general") 'you can subscribe to more topics
	fm.SubscribeToTopic("ios_general")
End Sub

Sub Service_Start (StartingIntent As Intent)
	If StartingIntent.IsInitialized Then fm.HandleIntent(StartingIntent)
	Sleep(0)
	Service.StopAutomaticForeground 'remove if not using B4A v8+.
End Sub

Sub fm_MessageArrived (Message As RemoteMessage)
	Log("Message arrived")
	Log("From: " & Message.From)
	Log("ID  : " & Message.MessageId)
	Log("Time: " & DateTime.Time(Message.SentTime))
	Log("KeyC:" & Message.CollapseKey)
	Log($"Message data: ${Message.GetData}"$)
	
	Dim n As Notification
	n.Initialize
	n.Icon = "icon"
	n.SetInfo(Message.GetData.Get("title"), Message.GetData.Get("body"), Main)
	n.Notify(1)
End Sub

Sub Service_Destroy

End Sub
