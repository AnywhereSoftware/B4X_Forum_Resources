B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.31
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Dim Client As MqttClient
	Dim ClientID As String
	Dim Serializator As B4XSerializator
	Dim Msg1() As Byte
	Dim Msg2() As Byte
	Dim FinalTopic As String

	Dim Const WITH_LOG As Boolean = False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ID As String)
	If WITH_LOG Then Log("Connecting " & ID)
	ClientID = ID
	FinalTopic = "final" & ID
	Msg1 = Serializator.ConvertObjectToBytes("Hello world1")
	Msg2 = Serializator.ConvertObjectToBytes("Hello world2")
	Client.Initialize("Monitor", Main.ServerURI, ID)
	Client.Connect
End Sub

Private Sub SubscribeAndPublish
	If WITH_LOG Then Log("Subscribing for " & ClientID)
	Client.Subscribe(Main.Topic(0), Client.QOS_0_MOST_ONCE)
	Sleep(Main.SLEEP_DURATION)
	Client.Subscribe(Main.Topic(1), Client.QOS_1_LEAST_ONCE)
	Sleep(Main.SLEEP_DURATION)
	Client.Subscribe(Main.Topic(2), Client.QOS_2_EXACTLY_ONCE)
	If WITH_LOG Then Log("Publishing from " & ClientID)
	Try
		For i = 1 To 5
			Sleep(Main.SLEEP_DURATION)
			Client.Publish2(Main.Topic(0), Msg1, Client.QOS_0_MOST_ONCE, False)
			Sleep(Main.SLEEP_DURATION)
			Client.Publish2(Main.Topic(1), Msg1, Client.QOS_1_LEAST_ONCE, False)
			Sleep(Main.SLEEP_DURATION)
			Client.Publish2(Main.Topic(2), Msg1, Client.QOS_2_EXACTLY_ONCE, False)
			Sleep(Main.SLEEP_DURATION)
			Client.Publish2(Main.Topic(0), Msg2, Client.QOS_0_MOST_ONCE, True)
			Sleep(Main.SLEEP_DURATION)
			Client.Publish2(Main.Topic(1), Msg2, Client.QOS_1_LEAST_ONCE, True)
			Sleep(Main.SLEEP_DURATION)
			Client.Publish2(Main.Topic(2), Msg2, Client.QOS_2_EXACTLY_ONCE, True)
		Next
	Catch
		LogError(ClientID & " PUBLISH FAILED: " & LastException)
	End Try
	If ClientID.StartsWith("LAST") Then
		Sleep(Main.SLEEP_DURATION * 5)
		If WITH_LOG Then Log("LAST MESSAGE from " & ClientID)
		Client.Subscribe(FinalTopic, Client.QOS_2_EXACTLY_ONCE)
		Sleep(Main.SLEEP_DURATION)
		Client.Publish2(FinalTopic, Msg2, Client.QOS_2_EXACTLY_ONCE, True)
	End If
End Sub

Private Sub Monitor_Connected (Success As Boolean)
	If WITH_LOG Then Log("Connected=" & Success & " " & ClientID)
	If Success Then
		SubscribeAndPublish
	Else
		LogError(ClientID & " NOT CONNECTED")
	End If
End Sub

Private Sub Monitor_MessageArrived (Topic As String, Payload() As Byte)
	If Topic = FinalTopic Then
		Main.Stop_Counting = True
		Main.IncMessageCount
		Log("LAST MESSAGE " & Main.GlobalCount)
	Else
		If Not(Main.Stop_Counting) Then Main.IncMessageCount
		If WITH_LOG Then Log("Message for " & ClientID & ": Topic=" & Topic & " / Length=" & Payload.Length & " / GC=" & Main.GlobalCount)
	End If
End Sub

Private Sub Monitor_Disconnected
End Sub

Sub Close
	Client.Close
End Sub
