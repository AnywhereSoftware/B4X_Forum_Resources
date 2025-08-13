B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private btnLoadInterstitial As B4XView
	Private btnShowInterstitial As B4XView
	Private btnLoadRewarded As B4XView
	Private btnShowRewarded As B4XView
	
	Private PangleAds As Pnd_PangleAds   ' https://www.pangleglobal.com/zh/integration/integrate-pangle-sdk-for-android
	Private PangleInterstitialAds As Pnd_PangleInterstitialAds
	Private PangleRewardedAds As Pnd_PangleRewardedAds
End Sub


Public Sub Initialize
End Sub


' https://ads.tiktok.com/help/article/available-locations-for-pangle-ads?lang=en


Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	' 8025677 = AppId for testing   https://www.pangleglobal.com/zh/integration/How-to-Test-Pangle-Ads-with-Ad-ID
	PangleAds.InitializeSdk("PangleAds", "8025677", PangleAds.PAG_GDPR_CONSENT_TYPE_NO_CONSENT, PangleAds.PAG_PA_CONSENT_TYPE_NO_CONSENT, True)
End Sub



Private Sub btnLoadInterstitial_Click
	' 980088188 = Interstitial watterfall test SlotId   https://www.pangleglobal.com/zh/integration/How-to-Test-Pangle-Ads-with-Ad-ID
	PangleInterstitialAds.LoadInterstitial("980088188")
	End Sub

Private Sub btnShowInterstitial_Click
	PangleInterstitialAds.Show
	btnShowInterstitial.Enabled = False
End Sub



Private Sub btnLoadRewarded_Click
	' 980088192 = Rewarded vertical watterfall test SlotId    https://www.pangleglobal.com/zh/integration/How-to-Test-Pangle-Ads-with-Ad-ID
	PangleRewardedAds.LoadRewarded("980088192")
End Sub

Private Sub btnShowRewarded_Click
	PangleRewardedAds.Show
	btnShowRewarded.Enabled = False
End Sub



' SDK Events
Private Sub PangleAds_OnInitializeSdkSuccess
	Log("OnInitializeSdkSuccess")
	' 980099802 = Banner 320x50 watterfall test SlotId   https://www.pangleglobal.com/zh/integration/How-to-Test-Pangle-Ads-with-Ad-ID
	PangleAds.LoadBanner("980099802", PangleAds.BANNER_W_320_H_50)
	PangleInterstitialAds.Initialize("PangleAds")
	PangleRewardedAds.Initialize("PangleAds")
	btnLoadInterstitial.Enabled = True
	btnLoadRewarded.Enabled = True
End Sub

Private Sub PangleAds_OnInitializeSdkFail (Error As String)
	btnLoadInterstitial.Enabled = False
	btnLoadRewarded.Enabled = False
	Log("OnInitializeSdkFail: " & Error)
End Sub



' Banner Events
Private Sub PangleAds_OnLoadBannerAdLoaded
	Log("OnLoadBannerAdLoaded")	
	Root.AddView(PangleAds.BannerView, 100%x/2-160dip, 100%y-50dip, 320dip, 50dip)	
End Sub

Private Sub PangleAds_OnLoadBannerAdFailed
	Log("OnLoadBannerAdFailed")
End Sub

Private Sub PangleAds_OnLoadBannerAdError (Error As String)
	'Error Codes: https://www.pangleglobal.com/integration/error-code
	Log("OnLoadBannerAdError: " & Error)                      
End Sub

Private Sub PangleAds_OnBannerAdShowed
	Log("OnBannerAdShowed")
End Sub

Private Sub PangleAds_OnBannerAdClicked
	Log("OnBannerAdClicked")
End Sub

Private Sub PangleAds_OnBannerAdDismissed
	Log("OnBannerAdDismissed")
End Sub



' Interstitial Events
Private Sub PangleAds_OnLoadInterstitialAdLoaded
	Log("OnLoadInterstitialAdLoaded")
	btnShowInterstitial.Enabled = True
End Sub

Private Sub PangleAds_OnLoadInterstitialAdError (Error As String)
	btnShowInterstitial.Enabled = False
	Log("OnLoadInterstitialAdError: " & Error)
End Sub

Private Sub PangleAds_OnInterstitialAdShowed
	Log("OnInterstitialAdShowed")
End Sub

Private Sub PangleAds_OnInterstitialAdClicked
	Log("OnInterstitialAdClicked")
End Sub

Private Sub PangleAds_OnInterstitialAdDismissed
	btnShowInterstitial.Enabled = False
	Log("OnInterstitialAdDismissed")
End Sub



' Rewarded Events
Private Sub PangleAds_OnLoadRewardedAdLoaded
	Log("OnLoadRewardedAdLoaded")
	btnShowRewarded.Enabled = True
End Sub

Private Sub PangleAds_OnLoadRewardedAdError (Error As String)
	btnShowRewarded.Enabled = False
	Log("OnLoadRewardedAdError: " & Error)
End Sub

Private Sub PangleAds_OnRewardedAdShowed
	Log("OnRewardedAdShowed")
End Sub

Private Sub PangleAds_OnRewardedAdClicked
	Log("OnRewardedAdClicked")
End Sub

Private Sub PangleAds_OnRewardedAdDismissed
	btnShowRewarded.Enabled = False
	Log("OnRewardedAdDismissed")
End Sub

Private Sub PangleAds_OnRewardedAdUserEarnedReward (RewardName As String, RewardAmount As Int)
	Log("OnRewardedAdUserEarnedReward (RewardName: " & RewardName & "  -   RewardAmount: " & RewardAmount & ")")
End Sub

Private Sub PangleAds_OnRewardedAdUserEarnedRewardFail (Error As String)
	Log("OnRewardedAdUserEarnedRewardFail: " & Error)
End Sub