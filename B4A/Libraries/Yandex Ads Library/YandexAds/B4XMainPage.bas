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
	
	Private btnShowDebug As B4XView
	Private btnLoadInterstitial As B4XView
	Private btnShowInterstitial As B4XView
	Private btnLoadRewarded As B4XView
	Private btnShowRewarded As B4XView
	
	Private Yandex As Pnd_YandexAds
	Private YandexInterstitial As  Pnd_YandexAdsInterstitial
	Private YandexRewarded As Pnd_YandexAdsRewarded
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
		
	' You can use Msgbox2Async to get consent as Yandex show in example app.
	' Text for Consent is here: https://github.com/yandexmobile/yandex-ads-sdk-android/blob/aa188614cb56fe86639449d68323c20a79a757ae/YandexMobileAdsExample/app/src/main/res/values/strings.xml#L69
	' I am not a lawyer, so better read documentation: https://ads.yandex.com/helpcenter/en/dev/android/gdpr
	' You can see User Privacy settings in debug panel. Open debug panel and scroll to the bottom.
	
		
	' These 6 setting need to be executed before initialize SDK
	Yandex.EnableDebugErrorIndicator = True
	Yandex.AgeRestrictedUser = True
	Yandex.LocationConsent = False
	Yandex.EnableLogging = True
	Yandex.UserConsent = False
	Yandex.AppAdAnalyticsReporting = False
	
	
	Yandex.Initialize("Yandex")   ' Initialize Yandex SDK. This is first steps, no matter what type of ads you are using.
End Sub



' SDK event
Private Sub Yandex_OnSdkInitializationComplete                                      ' On this event Yandex SDK initialization is complete, you can now initialize Ads.
	Log("OnSdkInitializationComplete")
	Yandex.InitializeBanner("demo-banner-yandex", 100%x)                            ' Always initialize Banner Ad after Yandex SDK complete initialization (on this event)
	Dim BannerHeight As Int = DipToCurrent(Yandex.BannerHeight)                     ' Yandex.BannerHeight = dimension in pixels, we need to convert it to DIP
	Root.AddView(Yandex, 0, 100%y - BannerHeight, 100%x, BannerHeight)
	Yandex.LoadBanner
	YandexInterstitial.Initialize("YandexInterstitial", "demo-interstitial-yandex") ' Always initialize Interstitial Ad after Yandex SDK complete initialization (on this event)
	YandexRewarded.Initialize("YandexRewarded", "demo-rewarded-yandex")             ' Always initialize Rewarded Ad after Yandex SDK complete initialization (on this event)
	btnLoadInterstitial.Enabled = True
	btnLoadRewarded.Enabled = True
End Sub



' Banner events
Private Sub Yandex_OnBannerAdLoaded
	Log("OnBannerAdLoaded")
End Sub

Private Sub Yandex_OnBannerAdFailedToLoad (AdRequestError As String)
	Log("OnBannerAdFailedToLoad: " & AdRequestError)
End Sub

Private Sub Yandex_OnBannerAdImpression (ImpressionData As String)
	' ImpressionData can be empty string ""
	Log("OnBannerAdImpression: " & ImpressionData)
End Sub

Private Sub Yandex_OnBannerAdClicked
	Log("OnBannerAdClicked")
End Sub

Private Sub Yandexe_OnLeftApplication
	Log("OnLeftApplication")
End Sub

Private Sub Yandex_OnReturnedToApplication
	Log("OnReturnedToApplication")
End Sub



'Interstitial events
Private Sub YandexInterstitial_OnInterstitialAdLoaded
	Log("OnInterstitialAdLoaded")
	btnLoadInterstitial.Enabled = False
	btnShowInterstitial.Enabled = True
End Sub

Private Sub YandexInterstitial_OnInterstitialAdFailedToLoad (AdRequestError As String)
	Log("OnInterstitialAdFailedToLoad: " & AdRequestError)
	btnLoadInterstitial.Enabled = True
End Sub

Private Sub YandexInterstitial_OnInterstitialAdShown
	Log("OnInterstitialAdShown")
	btnShowInterstitial.Enabled = False
End Sub

Private Sub YandexInterstitial_OnInterstitialAdImpression (ImpressionData As String)
	' ImpressionData can be empty string ""
	Log("OnInterstitialAdImpression: " & ImpressionData)
End Sub

Private Sub YandexInterstitial_OnInterstitialAdFailedToShow (AdError As String)
	Log("OnInterstitialAdFailedToShow: " & AdError)
	btnLoadInterstitial.Enabled = True
End Sub

Private Sub YandexInterstitial_OnInterstitialAdDismissed
	Log("OnInterstitialAdDismissed")
	btnLoadInterstitial.Enabled = True
End Sub

Private Sub YandexInterstitial_OnInterstitialAdClicked
	Log("OnInterstitialAdClicked")
End Sub



' Rewarded events
Private Sub YandexRewarded_OnRewardedAdLoaded
	Log("OnRewardedAdLoaded")
	btnLoadRewarded.Enabled = False
	btnShowRewarded.Enabled = True
End Sub

Private Sub YandexRewarded_OnRewardedAdFailedToLoad (AdRequestError As String)
	btnLoadRewarded.Enabled = True
	Log("OnRewardedAdFailedToLoad: " & AdRequestError)
End Sub

Private Sub YandexRewarded_OnRewardedAdShown
	Log("OnRewardedAdShown")
	btnShowRewarded.Enabled = False
End Sub

Private Sub YandexRewarded_OnRewardedAdFailedToShow (AdError As String)
	Log("OnRewardedAdFailedToShow: " & AdError)
	btnLoadRewarded.Enabled = True
End Sub

Private Sub YandexRewarded_OnRewardedAdDismissed
	Log("OnRewardedAdDismissed")
	btnLoadRewarded.Enabled = True
End Sub

Private Sub YandexRewarded_OnRewardedAdClicked
	Log("OnRewardedAdClicked")
End Sub

Private Sub YandexRewarded_OnRewardedAdImpression (ImpressionData As String)
	' ImpressionData can be empty string ""
	Log("OnRewardedAdImpression: " & ImpressionData)
End Sub

Private Sub YandexRewarded_OnRewardedAdReward (RewardType As String, RewardAmount As Int)
	Log("OnRewardedAdReward - RewardType: " & RewardType & "   -   RewardAmount: " & RewardAmount)
End Sub



' Buttons
Private Sub btnShowDebug_Click
	Yandex.ShowDebugPanel
End Sub

Private Sub btnLoadInterstitial_Click
	YandexInterstitial.Load
End Sub

Private Sub btnShowInterstitial_Click
	YandexInterstitial.Show
End Sub

Private Sub btnLoadRewarded_Click
	YandexRewarded.Load
End Sub

Private Sub btnShowRewarded_Click
	YandexRewarded.Show
End Sub