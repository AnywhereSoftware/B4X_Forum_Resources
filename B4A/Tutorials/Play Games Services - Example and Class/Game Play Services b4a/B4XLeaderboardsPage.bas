B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.66
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Dim MainPage As B4XMainPage
	Private Button_ShowLeaderBoards As Button
	Private Button_SubmitScoreToLeaderboard As Button
	Private Spinner_LeaderBoards As Spinner
	Private EditText_Score As EditText
	Private Button_ShowLeaderboard As Button
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	MainPage=B4XPages.GetManager.GetPage("MainPage")
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("LeaderboardExamples")
	PopulateSpinners
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub PopulateSpinners
	LogColor($"PopulateSpinners"$, Colors.Cyan)
	For Each lb As String In MainPage.GamePlaySvcClass.LeaderBoardMapB4X.Values
		LogColor($"Adding leaderboard ${lb}"$, Colors.Green)
		Spinner_LeaderBoards.Add(lb)
	Next
End Sub

Private Sub Button_SubmitScoreToLeaderboard_Click
	If EditText_Score.Text="" Then
		ToastMessageShow("Please enter a score to submit.", True)
	Else
		MainPage.GamePlaySvcClass.Leaderboard_Send_Score_ByTitle(Me, Spinner_LeaderBoards.SelectedItem, EditText_Score.Text)
		ToastMessageShow($"Submitting score of ${EditText_Score.Text} to ${Spinner_LeaderBoards.SelectedItem} leaderboard."$, True)

		Wait for GPGS_LeaderboardScoreSubmitted(NewBest As Boolean, Score As Int)

		Dim ExtraText As String = IIf(NewBest, CRLF & "New high score!", "")

		Log("After callback")
		ToastMessageShow($"Your score was submitted to the leaderboard.  Score = ${Score}.  ${ExtraText}"$, True)
		
'		If NewBest Then
'			ToastMessageShow("New high score for you!  Your score is "&Score, True)
'		Else
'			ToastMessageShow($"Your score was submitted to the leaderboard.  Score = ${Score}"$, True)
'		End If
	End If	
End Sub

Private Sub Button_ShowLeaderBoards_Click
	MainPage.GamePlaySvcClass.ShowAllLeaderboards
End Sub

Private Sub Button_ShowLeaderboard_Click
	MainPage.GamePlaySvcClass.ShowLeaderboardByTitle(Spinner_LeaderBoards.SelectedItem)
End Sub


