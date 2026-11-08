B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12.5
@EndOfDesignText@
Sub Process_Globals
	Private fm As FirebaseMessaging
End Sub

Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		fm.Initialize("fm")
	End If
	fm.HandleIntent(StartingIntent)
End Sub

Public Sub SubscribeToTopics (Topics() As Object)
	For Each topic As String In Topics
		fm.SubscribeToTopic(topic)
	Next
End Sub

Sub fm_MessageArrived (Message As RemoteMessage)
	Log("Message arrived")
	Log($"Message data: ${Message.GetData}"$)
	If B4XPages.IsInitialized And B4XPages.GetManager.IsForeground Then
		Log("App is in the foreground. In iOS a notification will not appear while the app is in the foreground (unless UserNotificationCenter is used).")
	End If
'	Dim MainPage As B4XMainPage = B4XPages.GetManager.MainPage
'	If MainPage.CurrentPage == "item" Then
'		
'	End If
	
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "HIGH").AutoCancel(True).SmallIcon(Application.Icon)
	n.BigTextStyle(Message.GetData.Get("title"),  Message.GetData.Get("body").As(String),Message.GetData.Get("body"))
	n.Build(Message.GetData.Get("title"),  Message.GetData.Get("body"),  Message.MessageId, Main).Notify(1)
End Sub

Sub fm_TokenRefresh (Token As String)
	Log("TokenRefresh: " & Token)
End Sub

