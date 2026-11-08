B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.31
@EndOfDesignText@
Sub Process_Globals
	Dim Serializator As B4XSerializator
End Sub

Sub ConvertToBlob(Obj As Object) As Byte()
	Return Serializator.ConvertObjectToBytes(Obj)
End Sub

Sub ConvertFromBlob(Blob() As Byte) As Object
	Return Serializator.ConvertBytesToObject(Blob)
End Sub

Private Sub CreateGenericMsg(MsgType As Byte, Message As Object) As Byte()
	Dim Msg As typMsg
	Msg.Initialize
	Msg.MsgType = MsgType
	Msg.Message = Message
	Return Serializator.ConvertObjectToBytes(Msg)
End Sub

Sub CreateStateMsg(State As Int) As Byte()
	Return CreateGenericMsg(codConstants.MSG_TYPE_STATE, State)
End Sub

Sub CreateWaitingMsg(Players As List) As Byte()
	Return CreateGenericMsg(codConstants.MSG_TYPE_WAIT, Players)
End Sub

Sub CreateJoiningMsg(MatchID As String, Players As Map) As Byte()
	Dim JoinMsg As typJoin
	JoinMsg.Initialize
	JoinMsg.MatchID = MatchID
	JoinMsg.Players.Initialize
	For Each JPlayerID As String In Players.Keys
		JoinMsg.Players.Add(JPlayerID)
	Next
	JoinMsg.Data = Null
	Return CreateGenericMsg(codConstants.MSG_TYPE_JOIN, JoinMsg)
End Sub

Sub CreateRejoiningMsg(MatchID As String, Players As List, GameMsg As typMsg) As Byte()
	Dim JoinMsg As typJoin
	JoinMsg.Initialize
	JoinMsg.MatchID = MatchID
	JoinMsg.Players = Players
	JoinMsg.Data = GameMsg.Message
	Return CreateGenericMsg(codConstants.MSG_TYPE_REJOIN, JoinMsg)
End Sub

Sub CreateGameMsg(RoundNbr As Int, CurrentPlayer As Int, Data As Object) As Byte()
	Dim GameData As typGameData
	GameData.Initialize
	GameData.RoundNbr = RoundNbr
	GameData.CurrentPlayer = CurrentPlayer
	GameData.Data = Data
	GameData.Timestamp = DateTime.Now
	Return CreateGenericMsg(codConstants.MSG_TYPE_PLAY, GameData)
End Sub

Sub CreateMissingMsg(PlayerID As String) As Byte()
	Return CreateGenericMsg(codConstants.MSG_TYPE_MISS, PlayerID)
End Sub

Sub CreateBackMsg(PlayerID As String) As Byte()
	Return CreateGenericMsg(codConstants.MSG_TYPE_BACK, PlayerID)
End Sub

Sub CreateQuitMsg(PlayerID As String) As Byte()
	Return CreateGenericMsg(codConstants.MSG_TYPE_QUIT, PlayerID)
End Sub

Sub CreateEndMsg(MatchID As String) As Byte()
	Return CreateGenericMsg(codConstants.MSG_TYPE_END, MatchID)
End Sub

Sub IsPlayMsg(Payload() As Byte) As Object
	Dim Msg As typMsg = Serializator.ConvertBytesToObject(Payload)
	Return Msg.MsgType = codConstants.MSG_TYPE_PLAY
End Sub
