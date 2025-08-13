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
	Private UnityAdsInterstitial As UnityAdsInterstitial
	Private btnLoadAd As Button
	Private btnShow As Button	
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("inter")
	btnShow.Enabled = False
	' This activity is example for both Interstitial and Rewarded video ads, depend on PlacementID
	' Please check manifest if you want to show Interstitial or Rewarded video Ads.
	UnityAdsInterstitial.InitializeInterstitial("InterstitialAds", "14851", True, "rewardedVideo")     ' Ad can't be skipped
	'UnityAdsInterstitial.InitializeInterstitial("InterstitialAds", "14851", True, "video")            ' Ad can be skipped
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Private Sub btnLoadAd_Click
	UnityAdsInterstitial.LoadAd
End Sub

Sub btnShow_Click
	UnityAdsInterstitial.ShowAd
End Sub

Sub InterstitialAds_OnUnityAdsAdLoaded (PlacementID As String)
	Log ("OnUnityAdsAdLoaded: " & PlacementID)
	btnLoadAd.Enabled = False
	btnShow.Enabled = True
End Sub

Sub InterstitialAds_OnUnityAdsFailedToLoad (Error As String)
	Log ("OnUnityAdsFailedToLoad: " & Error)
	btnShow.Enabled = False
	btnLoadAd.Enabled = True
End Sub

Sub InterstitialAds_OnUnityAdsShowClick (PlacementID As String)
	Log ("OnUnityAdsShowClick: " & PlacementID)
End Sub

Sub InterstitialAds_OnUnityAdsShowComplete (PlacementID As String, State As String)
	Log ("OnUnityAdsShowComplete: " & PlacementID & " - State: " & State)
	' If using rewarded ad
	If State = "COMPLETED" Then
		Log ("Reward the user for watching the ad to completion")
	Else
		Log("Do not reward the user For skipping the ad")
	End If
End Sub

Sub InterstitialAds_OnUnityAdsShowFailure (Error As String)
	Log ("OnUnityAdsShowFailure: " & Error)
	btnLoadAd.Enabled = True
	btnShow.Enabled = False
End Sub

Sub InterstitialAds_OnUnityAdsShowStart (PlacementID As String)
	Log ("OnUnityAdsShowStart: " & PlacementID)
	btnLoadAd.Enabled = True
	btnShow.Enabled = False
End Sub




