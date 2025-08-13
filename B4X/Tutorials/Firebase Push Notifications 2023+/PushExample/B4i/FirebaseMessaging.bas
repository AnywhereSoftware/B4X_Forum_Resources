B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.3
@EndOfDesignText@
'Code module

Sub Process_Globals
	Private fm As FirebaseMessaging
	Private FirstTime As Boolean = True
End Sub

Public Sub SubscribeToTopics (Topics() As Object)
	If FirstTime Then
		FirstTime = False
		fm.Initialize("fm")
		fm.FCMConnect
		Wait For fm_FCMConnected
		Log("FCMConnected")
	End If
	For Each topic As String In Topics
		fm.SubscribeToTopic("ios_" & topic)
	Next
	Log("Token: " & GetToken)
End Sub


Private Sub GetToken As String
	Dim FIRMessaging As NativeObject
	FIRMessaging = FIRMessaging.Initialize("FIRMessaging").GetField("messaging")
	Dim token As NativeObject = FIRMessaging.GetField("FCMToken")
	If token.IsInitialized = False Then Return "" Else Return token.AsString
End Sub

Public Sub MessageReceivedWhileInTheForeground (Message As Map)
	Log($"Message arrived while app is in the foreground: ${Message}"$)
	Dim aps As Map = Message.Get("aps")
	Dim alert As Map = aps.Get("alert")
	Log(alert.Get("body"))
	Log(alert.Get("title"))
End Sub