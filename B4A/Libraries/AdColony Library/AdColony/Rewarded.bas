B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private AdColony As AdColonyRewardedInterstitial
	Private lblStatus As Label
	Private btnShow As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Please check manifest if you want to show Interstitial or Rewarded Interstitial Ads.
	Activity.LoadLayout("Rewarded")
	
	'GDPR, COPPA, CCPA https://github.com/AdColony/AdColony-Android-SDK/wiki/Privacy-Laws
	AdColony.InitializeRewarded("AdColony", "app185a7e71e1714831a49ec7", "vz1fd5a8b2bf6841a0a4b826", False, "1", False, "1", False, "1")
	btnShow.Enabled = False
End Sub

Sub Activity_Resume
	lblStatus.Text = "Requesting..."
	AdColony.RequestRewarded
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub btnShow_Click
	AdColony.Show
End Sub

Sub AdColony_OnRequestFilled
	Log("OnRequestFilled")
	lblStatus.Text = "Now you can show Rewarded Ad."
	' DO NOT call AdColony.Show before this event fire
	btnShow.Enabled = True
End Sub

Sub AdColony_OnReward (Reward As Map)
	' if Success is true, you can reward user
	Log("RewardAmount: " & Reward.Get("RewardAmount"))
	Log("RewardName: " & Reward.Get("RewardName"))
	Log("ZoneID: " & Reward.Get("ZoneID"))
	Log("Success: " & Reward.Get("Success"))
End Sub

Sub AdColony_OnExpiring
	Log("OnExpiring")
	lblStatus.Text = "Ad is expiring... Requesting new Ad..."
	btnShow.Enabled = False
	' Request a new ad if ad is expiring
	AdColony.RequestRewarded
End Sub

Sub AdColony_OnOpened
	Log("OnOpened")
	btnShow.Enabled = False
End Sub

Sub AdColony_OnRequestNotFilled
	Log("OnRequestNotFilled")
	btnShow.Enabled = False
End Sub

