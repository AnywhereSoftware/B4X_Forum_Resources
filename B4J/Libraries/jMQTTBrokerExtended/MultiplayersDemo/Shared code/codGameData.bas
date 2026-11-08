B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.31
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private PlayerID As String
	Private MatchID As String
	Private GameData As typGameData
	Private Players As List
End Sub

Public Sub Initialize(ID As String)
	PlayerID = ID
	MatchID = ""
	GameData.Initialize
	Players.Initialize
End Sub

Public Sub GetGameData As typGameData
	Return GameData
End Sub
Public Sub SetGameData(NewGameData As typGameData) As Boolean
	If GameData.Timestamp < NewGameData.Timestamp Then
		GameData = NewGameData
		Log("Game data updated (round_nbr=" & GameData.RoundNbr & " current_player_idx=" & GameData.CurrentPlayer & ")")
		Return True
	End If
	Return False
End Sub

Public Sub GetMatchID As String
	Return MatchID
End Sub
Public Sub SetMatchID(ID As String)
	MatchID = ID
	Log("MatchID is set to " & MatchID)
End Sub

Public Sub GetPlayerID As String
	Return PlayerID
End Sub

Public Sub GetPlayers As List
	Return Players
End Sub
Public Sub SetPlayers(L As List)
	Players.Clear
	Players.AddAll(L)
End Sub

Public Sub GetCurrentPlayer As String
	If Players.Size > 0 Then
		Return Players.Get(GameData.CurrentPlayer)
	End If
	Return ""
End Sub

Public Sub UpdateTimeStamp
	'DateTime.Now is not reliable enough because different devices may have different times, so we make sure that the timestamp is higher than the previous one
	GameData.Timestamp = Max(GameData.Timestamp + 100, DateTime.Now)
End Sub

Private Sub CheckNewRound
	'If the last player has just played, starts a new game round with the first player
	If GameData.CurrentPlayer >= Players.Size Then
		GameData.RoundNbr = GameData.RoundNbr + 1
		GameData.CurrentPlayer = 0
	End If
End Sub

Public Sub SimulGameTurn
	'Simulates a game action and hands over to the next player
	GameData.Data = Rnd(0, 100000) 'To be replaced with real game data
	GameData.CurrentPlayer = GameData.CurrentPlayer + 1
	CheckNewRound
	Main.MQTT.PublishGameData
End Sub

Public Sub RemovePlayer(IdToRemove As String)
	'Removes the given player from the list of participants
	Dim Index As Int = Players.IndexOf(IdToRemove)
	If Index > -1 Then Players.RemoveAt(Index)

	'Ensures that the current player's index is within bounds
	Dim CurrentPlayer As Int = GameData.CurrentPlayer
	CheckNewRound
	If CurrentPlayer <> GameData.CurrentPlayer Then
		Main.MQTT.PublishGameData
	End If
End Sub
