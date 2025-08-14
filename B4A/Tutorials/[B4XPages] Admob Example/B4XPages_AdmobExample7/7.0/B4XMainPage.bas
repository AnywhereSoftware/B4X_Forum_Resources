B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\b4xpages_admob_example7.zip

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
		
	Dim BannerAdView1 As AdView
	
	Public PageNative As B4XPageNative
	Public PageBanner As B4XPageBanner
	Public PageBannerCLV As B4XPageBannerCLV
	Public PageBannerMenu As PageBannerMenu
	Public PageInter As B4XPageInter
	Public PageRewardInter As B4XPageRewardedInterstitial
	Public PageRewardVideo As B4XPageRewardedVideo
	
	Private mwAdInterstitial As InterstitialAd
	
	Public Ads As AdsHelper
	Private AppOpenAdUnit As String = "ca-app-pub-3940256099942544/3419835294"
End Sub

'You can add more parameters here.
Public Sub Initialize
	Ads.Initialize
	
	B4XPages.GetManager.TransitionAnimationDuration = 0  'disable animation between pages
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("main")
		
	PageNative.Initialize
	B4XPages.AddPage("Page Native", PageNative)
	
	PageBannerMenu.Initialize
	B4XPages.AddPage("Page Banner Menu", PageBannerMenu)
	
	PageBannerCLV.Initialize
	B4XPages.AddPage("Page Banner CLV", PageBannerCLV)
	
	PageBanner.Initialize
	B4XPages.AddPage("Page Banner", PageBanner)	
	
	PageInter.Initialize
	B4XPages.AddPage("Page Inter", PageInter)
	
	PageRewardInter.Initialize
	B4XPages.AddPage("Page Reward Inter", PageRewardInter)
	
	PageRewardVideo.Initialize
	B4XPages.AddPage("Page Reward Video", PageRewardVideo)
		
	'(OLD Admob-Consents)
'	CheckConsentAndAddAds
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub CheckConsentAndAddAds
	Try		
		Dim m As MobileAds
		Wait For (m.Initialize) MobileAds_Ready
'	m.SetConfiguration(m.CreateRequestConfigurationBuilder(Array("0BAB27F6EE97F9B5FA3B8C59548E8A34"))) 'optional. Array with test device ids. See unfiltered logs to find correct id.
		m.SetConfiguration(m.CreateRequestConfigurationBuilder(Array("528A88F244A0246D2B5B12A725C04D19")))'	Catch
	Catch
		Log(LastException)
	End Try
	
'	'Mute Ad Sound
'	Dim jo As JavaObject
'	jo.InitializeStatic("com.google.android.gms.ads.MobileAds")
'	jo.RunMethod("setAppMuted", Array(True))
	
'	'EXAMPLE code to ADJUST VOLUME level - remove the "setAppMuted" line above
'	Dim volume As Float = 0.5
'	jo.RunMethod("setAppVolume", Array(volume))
	
	Ads.ResetConsentStatus
'	Ads.SetConsentDebugParameters("0BAB27F6EE97F9B5FA3B8C59548E8A34", True) 'same id as above
	Ads.SetConsentDebugParameters("528A88F244A0246D2B5B12A725C04D19", True) 'same id as above
	
	If Ads.GetConsentStatus = "UNKNOWN" Or Ads.GetConsentStatus = "REQUIRED" Then
		Wait For (Ads.RequestConsentInformation(False)) Complete (Success As Boolean)
	End If
	
	If Ads.GetConsentStatus = "REQUIRED" And Ads.GetConsentFormAvailable Then
		Wait For (Ads.ShowConsentForm) Complete (Success As Boolean)
	End If
	
	Log("Consent: " & Ads.GetConsentStatus)
	
	Dim AdaptiveSize As Map = Ads.GetAdaptiveAdSize
	
	Dim size As AdSize = Utils.GetAdaptiveAdSize
	
'	Test Ads
'	https://developers.google.com/admob/android/test-ads

	BannerAdView1.Initialize2("BannerAdView1","ca-app-pub-3940256099942544/6300978111", AdaptiveSize.Get("native"))
	Root.AddView(BannerAdView1, 0, 100%y - size.Height, 100%x, size.Height)
	BannerAdView1.LoadAd
	
	'Interstitial that's show when click the button "Interstitial"
	mwAdInterstitial.Initialize("mwadi","ca-app-pub-3940256099942544/1033173712")  'TEST AD UNIT
	mwAdInterstitial.LoadAd
	
'	Ads.FetchOpenAd(AppOpenAdUnit)
End Sub

Private Sub B4XPage_Foreground
'	Ads.ShowOpenAdIfAvailable
End Sub

Private Sub B4XPage_Background
'	Ads.Background
End Sub

Sub pnlBanner_Click	
	B4XPages.ShowPage("Page Banner Menu")
End Sub

Sub pnlInterstitial_Click	
	Msgbox2Async("An Interstitial will be show before open the page." & CRLF & CRLF & "When you close/dismiss the Ad the page will be opened", "Interstitial Transition", "", "", "OK", Null, True)
	Wait For Msgbox_Result (Result As Int)
	
	If (mwAdInterstitial.IsInitialized) And (mwAdInterstitial.Ready) Then
		mwAdInterstitial.Show
	End If
End Sub

Sub pnlNative_Click
	B4XPages.ShowPage("Page Native")
End Sub

Private Sub pnlOpenAd_Click
	Msgbox2Async("Follow the App Open Ad guidance to implement correctly the ad in your app and avoid issues with Admob policy.", "AppOpenAd", "Guide", "Cancel", "Show Ad", Null, False)
	Wait For Msgbox_Result (Result As Int)
	If Result = DialogResponse.POSITIVE Then
		Dim p As PhoneIntents
		StartActivity(p.OpenBrowser("https://support.google.com/admob/answer/9341964?hl=en"))
	Else If Result = DialogResponse.NEGATIVE Then
		Ads.ShowOpenAdIfAvailable
	End If
End Sub

Private Sub pnlRewardVideo_Click
	B4XPages.ShowPage("Page Reward Video")
	
End Sub

Private Sub pnlRewardInter_Click
	B4XPages.ShowPage("Page Reward Inter")
	
End Sub

#Region Ad Events
Sub mwadi_AdFailedToLoad (ErrorMessage As String)
	Log("mwadi AdFailedToLoad: " & Utils.GetErrorCodeAd(ErrorMessage))
End Sub

Sub mwadi_AdClosed
	Log("mwadi AdClosed")
	mwAdInterstitial.LoadAd 'prepare a new ad
		
	B4XPages.ShowPage("Page Inter")  'open the page after close the ad
End Sub

Sub mwadi_AdLoaded
	Log("mwadi Adloaded")
End Sub

Sub mwadi_ReceiveAd
	Log("mwadi ReceiveAd")
	ToastMessageShow("Interstitial Received", False) 'show only in the example
End Sub

Sub mwadi_AdScreenDismissed
	Log("mwadi AdScreenDismissed")
End Sub

Sub BannerAdView1_ReceiveAd
	Log("Adview received")
End Sub

Sub BannerAdView1_FailedToReceiveAd (ErrorCode As String)
	Log("Failed: " & ErrorCode)
End Sub

Sub BannerAdView1_AdClosed
	Log("Closed")
End Sub

Sub BannerAdView1_AdOpened
	Log("Opened")
End Sub
#End Region