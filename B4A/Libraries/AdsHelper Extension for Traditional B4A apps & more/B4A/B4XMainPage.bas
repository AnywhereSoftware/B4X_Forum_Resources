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
	Private BannerAd As AdView
	Private BannerAdFixedSize As AdView
	Private iAd As InterstitialAd
	Private Ads As AdsHelper
	Private AppOpenAdUnit As String = "ca-app-pub-3940256099942544/3419835294"
	Public Page2 As B4XNative2
End Sub

Public Sub Initialize
	Ads.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	B4XPages.GetManager.LogEvents = True
	Root = Root1
	Dim ButtonPanel As Panel
	ButtonPanel.Initialize("")
	Root.AddView(ButtonPanel, 0, 250dip, 100%x, 150dip)
	ButtonPanel.LoadLayout("MainPage")
	Page2.Initialize
	B4XPages.AddPage("B4XNative2", Page2)
	Root.Color=Colors.Black
	CheckConsentAndAddAds

End Sub

Private Sub CheckConsentAndAddAds
	Dim m As MobileAds
	
	Wait For (m.Initialize) MobileAds_Ready
	LogColor("After MobileAds_Ready", Colors.Magenta)
'	m.SetConfigutation(m.CreateRequestConfigurationBuilder(Array("77A04EE40B2AFED2AFC67701365187EC"))) 'optional. Array with test device ids. See unfiltered logs to find correct id.
	
	'Ads.ResetConsentStatus
	'Ads.SetConsentDebugParameters("77A04EE40B2AFED2AFC67701365187EC", True) 'same id as above
	
	If Ads.GetConsentStatus = "UNKNOWN" Or Ads.GetConsentStatus = "REQUIRED" Then
		Wait For (Ads.RequestConsentInformation(False)) Complete (Success As Boolean)
	End If
	If Ads.GetConsentStatus = "REQUIRED" And Ads.GetConsentFormAvailable Then
		Wait For (Ads.ShowConsentForm) Complete (Success As Boolean)
	End If
	Log("Consent: " & Ads.GetConsentStatus)
	LoadAds

End Sub

Sub LoadAds
	Dim AdaptiveSize As Map = Ads.GetAdaptiveAdSize
	'AdaptiveSize.Get("native")
	'load a fixed size banner ad
	BannerAdFixedSize.Initialize2("BannerAdFixedSize", "ca-app-pub-3940256099942544/6300978111", BannerAd.SIZE_IAB_MRECT)
	Root.AddView(BannerAdFixedSize, (100%x-300dip)/2, 0, 300dip, 250dip)
	BannerAdFixedSize.LoadAd
	
	BannerAd.Initialize2("BannerAd", "ca-app-pub-3940256099942544/6300978111", AdaptiveSize.Get("native"))
	Root.AddView(BannerAd, 0, 100%y-AdaptiveSize.Get("height"), AdaptiveSize.Get("width"), AdaptiveSize.Get("height"))
	BannerAd.LoadAd
	
	iAd.Initialize("iad", "ca-app-pub-3940256099942544/1033173712")
	iAd.LoadAd
	
	Ads.FetchRewardedInterstitialAd("ca-app-pub-3940256099942544/5354046379", Me, "RewardedInterstitialAd")
	Ads.FetchRewardedVideoAd("ca-app-pub-3940256099942544/5224354917", Me, "RewardAd")
	Ads.FetchOpenAd(AppOpenAdUnit, Me, "OpenAd")
End Sub

Private Sub B4XPage_Foreground
	Ads.ShowOpenAdIfAvailable(2)
End Sub

Private Sub B4XPage_Background
	Ads.Background
End Sub

#Region Button Click Events
Private Sub Button1_Click
	If iAd.Ready Then
		iAd.Show
	Else
		Log("no Iad is available")
	End If
	iAd.LoadAd
End Sub

Private Sub Button2_Click
	If Ads.isAvailableRewardedInterstitialAd Then
		Ads.ShowRewardedInterstitialAd
	Else
		Log("wait... loading reward ad")
		Ads.FetchRewardedInterstitialAd("ca-app-pub-3940256099942544/5354046379", Me, "RewardedInterstitialAd")
	End If
End Sub


Private Sub Button_Native_Click
	B4XPages.ShowPage("B4XNative2")
End Sub

Private Sub Button_RewardedVideo_Click
	If Ads.isAvailableRewardedVideoAd Then
		Ads.ShowRewardedVideoAd
	Else
		Log("wait... loading reward ad")
		Ads.FetchRewardedVideoAd("ca-app-pub-3940256099942544/5224354917", Me, "RewardAd")
	End If
End Sub
#End Region

#Region Ad Events
Sub BannerAd_ReceiveAd
	Log("BannerAd_ReceiveAd")
End Sub

Sub BannerAd_FailedToReceiveAd (ErrorCode As String)
	Log("BannerAd_FailedToReceiveAd ErrorCode=" & ErrorCode)
End Sub

Sub BannerAd_AdClosed
	Log("BannerAd_AdClosed")
End Sub

Sub BannerAd_AdOpened
	Log("BannerAd_AdOpened")
End Sub

Sub BannerAdFixedSize_ReceiveAd
	Log("BannerAdFixedSize_ReceiveAd")
End Sub

Sub BannerAdFixedSize_FailedToReceiveAd (ErrorCode As String)
	Log("BannerAdFixedSize_FailedToReceiveAd ErrorCode=" & ErrorCode)
End Sub

Sub BannerAdFixedSize_AdClosed
	Log("BannerAdFixedSize_AdClosed")
End Sub

Sub BannerAdFixedSize_AdOpened
	Log("BannerAdFixedSize_AdOpened")
End Sub


Sub iAd_ReceiveAd
	Log("IAd received. Now wait for the right moment to show the ad.")
End Sub

Sub iAd_FailedToReceiveAd (ErrorCode As String)
	Log("Failed: " & ErrorCode)
End Sub

Sub iAd_AdClosed
	Log("Closed")
End Sub

Sub iAd_AdOpened
	Log("Opened")
End Sub

'Open Ad Events
Sub OpenAd_ReceiveAd
	LogColor($"OpenAd_ReceiveAd"$, Colors.Green)
End Sub

Sub OpenAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"OpenAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

'rewarded video ad events
Sub RewardAd_ReceiveAd
	LogColor($"RewardAd_ReceiveAd"$, Colors.Green)
End Sub

Sub RewardAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

Sub RewardAd_Rewarded (Item As Object)
	LogColor("RewardAd_Rewarded",Colors.Green)
	Dim Reward As JavaObject = Item
	Dim Amount As Int = Reward.RunMethod("getAmount", Null)
	Dim RewardType As String = Reward.RunMethod("getType", Null)
	Log("Rewarded: " & Amount & " -> " & RewardType)
End Sub

'rewarded interstitial events
Sub RewardedInterstitialAd_ReceiveAd
	LogColor($"RewardInterstitialAd_ReceiveAd"$, Colors.Green)
End Sub

Sub RewardedInterstitialAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardedInterstitialAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

Sub RewardedInterstitialAd_Rewarded (Item As Object)
	LogColor("RewardedInterstitialAd_Rewarded",Colors.Green)
	Dim Reward As JavaObject = Item
	Dim Amount As Int = Reward.RunMethod("getAmount", Null)
	Dim RewardType As String = Reward.RunMethod("getType", Null)
	Log("Rewarded: " & Amount & " -> " & RewardType)
End Sub

#End Region