B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Public GamePlaySvcClass As GamePlayLeaderboardsAndAchievements
	
'	Private Button_SignIn,Button_ShowLeaderBoards_Click As Button
	
	Private Button_SignIn As Button
	Private Button_SignOut As Button
	Private Button_LeaderBoards As Button
	Private Button_Achievements As Button

End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Achievements & Leaderboards")
	If Not(GamePlaySvcClass.IsInitialized) Then GamePlaySvcClass.Initialize(Me, "GPGS", True, False, True, True)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub GPGS_Connected
	LogColor($"B4XMainPage GPGS_Connected"$, Colors.Magenta)
	Button_SignIn.Enabled=False
	Button_SignOut.Enabled=True
	Button_Achievements.Enabled=True
	Button_LeaderBoards.Enabled=True
End Sub

Sub GPGS_Disconnected
	Button_SignIn.Enabled=True
	Button_SignOut.Enabled=False
	Button_Achievements.Enabled=False
	Button_LeaderBoards.Enabled=False
End Sub

#Region Button Clicks
Private Sub Button_SignIn_Click
	GamePlaySvcClass.SignIn(False)
End Sub

Private Sub Button_SignOut_Click
	Log("Button_SignOut_Click")
	GamePlaySvcClass.SignOut
End Sub

Private Sub Button_Achievements_Click 'show achievements
	B4XPages.GetManager.ShowPage("Achievements Page")
End Sub

Private Sub Button_LeaderBoards_Click
	Log("Button_ShowLeaderBoards_Click")
	B4XPages.GetManager.ShowPage("Leaderboards Page")
End Sub

#end region



