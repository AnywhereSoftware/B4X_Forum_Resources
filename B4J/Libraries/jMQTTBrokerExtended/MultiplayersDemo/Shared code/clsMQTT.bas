B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.31
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private Client As MqttClient
	Private Const IPAddress As String = "192.168.1.7" 'Broker IP Address
	Public Const ServerURI As String = "tcp://" & IPAddress & ":" & codConstants.PORT
	Private Serializator As B4XSerializator
End Sub

Public Sub Initialize
End Sub

Private Sub ChangeState(NewState As Int)
	CallSub2(Main, "ChangeState", NewState)
End Sub

Private Sub ShowTurnState(Text As String)
	CallSub2(Main, "ShowTurnState", Text)
End Sub

Public Sub Connect(ID As String)
	'Connects the MQTT client to the broker with the given ID
	Client.Initialize("Monitor", ServerURI, ID)
	ChangeState(codConstants.STATE_CONNECTING)
	Client.Connect
End Sub

Public Sub EnterWaitingRoom
	'Subscribes to the waiting topic
	ChangeState(codConstants.STATE_SUBSCRIBE_WAITING)
	Client.Subscribe(codConstants.TOPIC_WAITING, Client.QOS_2_EXACTLY_ONCE)
End Sub

Public Sub JoinGame
	'Confirms that the player wants to play a game with the current participants
	ChangeState(codConstants.STATE_SUBSCRIBE_GAMETOPIC)
	Client.Subscribe(codGameData.GetMatchID, Client.QOS_2_EXACTLY_ONCE)
End Sub

Public Sub PublishGameData
	'Sends time-stamped game data to other participants
	codGameData.UpdateTimeStamp
	Dim Msg As typMsg
	Msg.Initialize
	Msg.MsgType = codConstants.MSG_TYPE_PLAY
	Msg.Message = codGameData.GetGameData
	Client.Publish2(codGameData.GetMatchID, Serializator.ConvertObjectToBytes(Msg), Client.QOS_1_LEAST_ONCE, False)
End Sub

Public Sub LeaveGame
	'Abandons the game in progress
	ChangeState(codConstants.STATE_LEAVING)
	Client.Unsubscribe(codGameData.GetMatchID)
End Sub

Private Sub Monitor_Connected (Success As Boolean)
	If Success = True Then
		'The player must subscribe to his private topic
		ChangeState(codConstants.STATE_CONNECTED)
		Client.Subscribe(codGameData.GetPlayerID, Client.QOS_1_LEAST_ONCE)
	Else
		ChangeState(codConstants.STATE_CONNECTION_FAILED)
	End If
End Sub

Private Sub Monitor_MessageArrived (Topic As String, Payload() As Byte)
	Log("Message arrived: Topic=" & Topic & " / Length=" & Payload.Length)
	If Payload.Length = 0 Then
		'Ignores the message
		Return
	Else
		Dim Msg As typMsg = Serializator.ConvertBytesToObject(Payload)
		If Topic = codGameData.GetPlayerID Then
			'Private message
			If Msg.MsgType = codConstants.MSG_TYPE_STATE Then
				Dim State As Int = Msg.Message
				ChangeState(State)
				Select State
					Case codConstants.STATE_JOINING
						'The player is joining a game
						Client.Unsubscribe(codConstants.TOPIC_WAITING)
					Case codConstants.STATE_CANCELING
						'A player left the joining process -> back to the waiting room
						Client.Subscribe(codConstants.TOPIC_WAITING, Client.QOS_2_EXACTLY_ONCE)
				End Select
			Else If Msg.MsgType = codConstants.MSG_TYPE_JOIN Or Msg.MsgType = codConstants.MSG_TYPE_REJOIN Then
				'Retrieves the match ID
				Dim JoinMsg As typJoin = Msg.Message
				codGameData.SetMatchID(JoinMsg.MatchID)

				'Retrieves and displays the participants
				codGameData.SetPlayers(JoinMsg.Players)
				CallSub2(Main, "UpdatePlayersList", Msg.MsgType = codConstants.MSG_TYPE_JOIN)

				'If rejoining...
				If Msg.MsgType = codConstants.MSG_TYPE_REJOIN Then
					'Updates the game data
					codGameData.SetGameData(JoinMsg.Data)
					ShowTurnState("")

					'Subscribes directly to the game topic
					Client.Subscribe(codGameData.GetMatchID, Client.QOS_2_EXACTLY_ONCE)
				End If
			Else If Msg.MsgType = codConstants.MSG_TYPE_END Then
				'The player comes back after the end of the game
				ChangeState(codConstants.STATE_TOO_LATE)
				codGameData.SetMatchID(Msg.Message)
			Else
				Log("??? " & Topic & " " & Msg.MsgType & " " & Msg.Message)
			End If
		Else If Topic = codConstants.TOPIC_WAITING Then
			'Displays the waiting players
			If Msg.MsgType = codConstants.MSG_TYPE_WAIT Then
				Dim WPlayers As List = Msg.Message
				CallSub2(Main, "UpdateWaitingRoom", WPlayers)
			End If
		Else If Topic = codGameData.GetMatchID Then
			Select Msg.MsgType
				Case codConstants.MSG_TYPE_PLAY
					'Updates the game data (if newer)
					codGameData.SetGameData(Msg.Message)
					ShowTurnState("")
				Case codConstants.MSG_TYPE_MISS
					'Another player is no longer active (the game continues until he comes back)
					Dim Player As String = Msg.Message
					Dim AdditionalInfo As String = Player & " is no longer active (disconnected ?)."
					ShowTurnState(AdditionalInfo)
				Case codConstants.MSG_TYPE_BACK
					'A player who was missing is back
					Dim Player As String = Msg.Message
					Dim AdditionalInfo As String = Player & " is back in the game."
					ShowTurnState(AdditionalInfo)
				Case codConstants.MSG_TYPE_QUIT
					'A player has left the game (he's removed from the list of participants)
					Dim IdToRemove As String = Msg.Message
					codGameData.RemovePlayer(IdToRemove)
					CallSub2(Main, "UpdatePlayersList", False)
					Dim AdditionalInfo As String = IdToRemove & " has left the game."
					ShowTurnState(AdditionalInfo)
				Case codConstants.MSG_TYPE_END
					'Game over
					ChangeState(codConstants.STATE_GAMEOVER)
			End Select
		Else
			Log("??? " & Topic & " " & Msg.MsgType & " " & Msg.Message)
		End If
	End If
End Sub

Private Sub Monitor_Disconnected
	'Resets the UI
	ChangeState(codConstants.STATE_DISCONNECTED)
End Sub

Public Sub Close
	Client.Close
End Sub
