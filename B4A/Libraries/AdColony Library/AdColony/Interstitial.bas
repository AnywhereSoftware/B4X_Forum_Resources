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
	Private AdColony As AdColonyInterstitial
	Private btnShow As Button
	Private lblStatus As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' Please check manifest if you want to show Interstitial or Rewarded Interstitial Ads.
	Activity.LoadLayout("Interstitial")
	
	'GDPR, COPPA, CCPA https://github.com/AdColony/AdColony-Android-SDK/wiki/Privacy-Laws
	AdColony.InitializeInterstitial("AdColony", "app185a7e71e1714831a49ec7", "vz06e8c32a037749699e7050", False, "1", False, "1", False, "1")
	btnShow.Enabled = False
End Sub

Sub Activity_Resume
	lblStatus.Text = "Requesting..."
	AdColony.RequestInterstitial
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub btnShow_Click
	Log("btnShow_Click")
	btnShow.Enabled = False
	AdColony.Show
End Sub

Sub AdColony_OnRequestFilled	
	Log("OnRequestFilled")
	lblStatus.Text = "Now you can show Interstitial Ad."
	' DO NOT call AdColony.Show before this event fire
	btnShow.Enabled = True
End Sub

Sub AdColony_OnExpiring
	Log("OnExpiring")
	lblStatus.Text = "Ad is expiring... Requesting new Ad..."
	btnShow.Enabled = False
	' Request a new ad if ad is expiring
	AdColony.RequestInterstitial
End Sub

Sub AdColony_OnOpened
	Log("OnOpened")
	btnShow.Enabled = False
End Sub

Sub AdColony_OnRequestNotFilled	
	Log("OnRequestNotFilled")
	btnShow.Enabled = False
End Sub

