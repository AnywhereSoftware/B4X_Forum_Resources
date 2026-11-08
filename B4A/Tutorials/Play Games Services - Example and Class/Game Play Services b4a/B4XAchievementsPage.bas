B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.66
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private Button_UnlockAchievement As Button
	Private Button_UnlockOrRevealAchievement As Button
	Private Button_Achievements As Button
	Private Spinner_StandardAchievements As Spinner
	Private Spinner_IncrementalAchievements As Spinner
	Private Button_IncrementAchievement As Button
	
	Dim MainPage As B4XMainPage
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
	Root.LoadLayout("AchievementExamples")
	PopulateSpinners
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub PopulateSpinners
	LogColor($"PopulateSpinners"$, Colors.Cyan)
	For Each ach As AchievementIncrementalType In MainPage.GamePlaySvcClass.AchievementsIncrementalTypeMapB4X.Values
		LogColor($"Incremental achName=${ach.AchievementName}"$, Colors.Cyan)
		Spinner_IncrementalAchievements.Add(ach.AchievementName)
	Next
	For Each achName As String In MainPage.GamePlaySvcClass.AchievementsStandardTypeMapB4X.Values
		LogColor($"Standard achName=${achName}"$, Colors.Green)
		Spinner_StandardAchievements.Add(achName)
	Next
End Sub

Private Sub Button_IncrementAchievement_Click
	Dim SelectedAchievement As AchievementIncrementalType = MainPage.GamePlaySvcClass.AchievementsIncrementalTypeMapB4X.GetValueAt(Spinner_IncrementalAchievements.SelectedIndex)
	MainPage.GamePlaySvcClass.Achievement_Increment(Me, SelectedAchievement, 1)
	Wait For GPGS_AchievementIncremented(Achievement As AchievementIncrementalType, NumSteps As Int)
	Log("Button_IncrementAchievement_Click after callback")
	ToastMessageShow($"Congratulations! You have achieved ${MainPage.GamePlaySvcClass.IfGreaterThan_MakeEqual(Achievement.FormattedCurrentSteps+1,Achievement.TotalSteps)} out of ${Achievement.TotalSteps} on ${Achievement.AchievementName}"$, True)
End Sub

Private Sub Button_Achievements_Click
	MainPage.GamePlaySvcClass.ShowAllAchievements
End Sub

'this one needs some work
Private Sub Button_UnlockOrRevealAchievement_Click
	Dim SelectedAchievementId As String = MainPage.GamePlaySvcClass.AchievementsStandardTypeMapB4X.Keys.Get(Spinner_StandardAchievements.SelectedIndex)
	MainPage.GamePlaySvcClass.Achievement_UnlockAndReveal(Me,  SelectedAchievementId)
	Wait For GPGS_AchievementUnlockedOrRevealed(AchievementId As String, statusCode As Int)
	Log("Button_UnlockOrRevealAchievement_Click after callback")
	ToastMessageShow($"Congratulations! You have unlocked ${Spinner_StandardAchievements.SelectedItem}"$, True)
End Sub