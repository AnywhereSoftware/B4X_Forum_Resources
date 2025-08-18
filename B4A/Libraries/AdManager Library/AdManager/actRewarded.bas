B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.17
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private AdManagerRewarded1 As AdManagerRewarded
	Private btnLoad As Button
	Private btnShow As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'***************************************************************************************************************
	'***************************************************************************************************************
	'
	'   CHECK MANIFEST - you should replace "ca-app-pub-3940256099942544~3347511713" in manifest with your APP ID
	'
	'***************************************************************************************************************
	'***************************************************************************************************************
	Activity.LoadLayout("2")
	Activity.Title = "Rewarded Example"
	btnShow.Enabled = False
	AdManagerRewarded1.Initialize("AdManagerRewarded1", "ca-app-pub-3940256099942544/5354046379")
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub btnLoad_Click
	btnLoad.Enabled = False
	If AdManagerRewarded1.IsLoaded = False Then
		AdManagerRewarded1.LoadPersonalized  ' You can use Consent dialog from AdMob library to determine if user is in EEA zone or not.
		'AdManagerRewarded1.LoadNonPersonalized
	End If
End Sub

Sub btnShow_Click
	If AdManagerRewarded1.IsLoaded Then
		AdManagerRewarded1.Show
	End If
End Sub

Sub AdManagerRewarded1_AdLoaded
	btnLoad.Enabled = False
	btnShow.Enabled = True
	Log("AdLoaded - event fire")
End Sub

Sub AdManagerRewarded1_AdFailedToLoad (Error As String)
	btnLoad.Enabled = True
	btnShow.Enabled = False
	Log("AdFailedToLoad: " & Error)
End Sub

Sub AdManagerRewarded1_AdDismissedFullScreenContent
	Log("AdDismissedFullScreenContent - event fire")
End Sub

Sub AdManagerRewarded1_AdFailedToShowFullScreenContent (Error As String)
	Log("AdFailedToShowFullScreenContent: " & Error)
End Sub

Sub AdManagerRewarded1_AdShowedFullScreenContent
	btnLoad.Enabled = True
	btnShow.Enabled = False
	Log("AdShowedFullScreenContent - event fire")
End Sub

Sub AdManagerRewarded1_UserEarnedReward (RewardType As String, RewardAmount As Int)
	Log("UserEarnedReward - event fire")
	Log("Reward Type: " & RewardType)
	Log("Reward Amount: " & RewardAmount)
End Sub


