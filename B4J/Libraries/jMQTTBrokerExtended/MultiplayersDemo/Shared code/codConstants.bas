B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.31
@EndOfDesignText@
#Region Project Attributes 
	#IgnoreWarnings: 9
#End Region

Public Sub Process_Globals
	Dim Const PORT As Int = 1883

	Dim Const MSG_TYPE_STATE As Byte = 0
	Dim Const MSG_TYPE_WAIT As Byte = 1
	Dim Const MSG_TYPE_JOIN As Byte = 2
	Dim Const MSG_TYPE_REJOIN As Int = 3
	Dim Const MSG_TYPE_PLAY As Byte = 4
	Dim Const MSG_TYPE_MISS As Byte = 5
	Dim Const MSG_TYPE_BACK As Byte = 6
	Dim Const MSG_TYPE_QUIT As Byte = 7
	Dim Const MSG_TYPE_END As Byte = 8

	Dim Const STATE_CONNECTING As Int = 0
	Dim Const STATE_CONNECTING_TXT As String = "Connecting to @..."
	Dim Const STATE_CONNECTED As Int = 1
	Dim Const STATE_CONNECTED_TXT As String = "Connected. Waiting for current state..."
	Dim Const STATE_CONNECTION_FAILED As Int = 2
	Dim Const STATE_CONNECTION_FAILED_TXT As String = "Connection failed."
	Dim Const STATE_SUBSCRIBE_WAITING As Int = 5
	Dim Const STATE_SUBSCRIBE_WAITING_TXT As String = "Entering the waiting room..."
	Dim Const STATE_SUBSCRIBE_GAMETOPIC As Int = 6
	Dim Const STATE_SUBSCRIBE_GAMETOPIC_TXT As String = "Waiting for the other participants to start the game..."
	Dim Const STATE_MUST_WAIT As Int = 10
	Dim Const STATE_MUST_WAIT_TXT As String = "You have no game in progress. You have to wait for other players to start a game."
	Dim Const STATE_WAITING As Int = 11
	Dim Const STATE_WAITING_TXT As String = "Waiting for other players..."
	Dim Const STATE_JOINING As Int = 12
	Dim Const STATE_JOINING_TXT As String = "Joining a game..."
	Dim Const STATE_PLAYING As Int = 13
	Dim Const STATE_PLAYING_TXT As String = "The game has started with all the participants."
	Dim Const STATE_CANCELING As Int = 15
	Dim Const STATE_CANCELING_TXT As String = "A player has left the game or lost his connection. Returning to the waiting room..."
	Dim Const STATE_LEAVING As Int = 16
	Dim Const STATE_LEAVING_TXT As String = "Leaving the game..."
	Dim Const STATE_GAMEOVER As Int = 20
	Dim Const STATE_GAMEOVER_TXT As String = "Game over."
	Dim Const STATE_TOO_LATE As Int = 21
	Dim Const STATE_TOO_LATE_TXT As String = "The game ended while you were disconnected."
	Dim Const STATE_DISCONNECTED As Int = 99
	Dim Const STATE_DISCONNECTED_TXT As String = "Disconnected."

	Dim Const TOPIC_WAITING As String = "waiting"
End Sub
