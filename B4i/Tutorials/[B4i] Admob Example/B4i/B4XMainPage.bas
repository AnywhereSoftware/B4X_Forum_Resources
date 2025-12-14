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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	#If B4i	
	Public ump As UMPConsentInformation
	#End If
	
	Public PageBanner As B4XPageBanner
	Public PageInter As B4XPageInter
	Public PageRewarded As B4XPageRewardedVideo
	
	'https://developers.google.com/admob/ios/interstitial
	Private mwAdInterstitial As InterstitialAd
	
	'https://developers.google.com/admob/ios/app-open
	Public OpenAd As OpenAdManager
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	CheckConsentAndAddAds
	
	PageBanner.Initialize
	B4XPages.AddPage("Page_Banner", PageBanner)
	
	PageInter.Initialize
	B4XPages.AddPage("Page_Inter", PageInter)
	
	PageRewarded.Initialize
	B4XPages.AddPage("Page_Rewarded", PageRewarded)
	
	#If B4i
	mwAdInterstitial.Initialize("mwadi","ca-app-pub-3940256099942544/1033173712")  'TEST AD UNIT
	LogColor("mwAdInterstitial.IsReady: " & mwAdInterstitial.IsReady, xui.Color_Cyan)
	If mwAdInterstitial.IsReady = False Then
		mwAdInterstitial.RequestAd
	End If
    #End If
	
	OpenAd.Initialize("ca-app-pub-3940256099942544/5575463023") 'test id	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub CheckConsentAndAddAds
	#If B4i
	ump.Initialize("ump")
	ump.Reset
'	'<UMP SDK> To enable debug mode for this device, set: UMPDebugSettings.testDeviceIdentifiers = @[ 000 ];
	ump.UpdateAndRequestIfNeededNative(B4XPages.GetNativeParent(Me), Null)
	Wait For ump_Update (Success As Boolean)
	Log("success: " & Success)
	Log("canRequestAds: " & ump.CanRequestAds)
	#End If	
End Sub

Sub mwadi_AdClosed
	Log("mwadi AdClosed")
	LogColor("mwAdInterstitial.IsReady: " & mwAdInterstitial.IsReady, xui.Color_Cyan)
		
	B4XPages.ShowPage("Page_Inter")  'open the page after close the ad
End Sub

Sub mwadi_AdLoaded
	Log("mwadi Adloaded")
End Sub

Sub mwadi_ReceiveAd
	Log("mwadi ReceiveAd")
'	ToastMessageShow("Interstitial Received", False) 'show only in the example
End Sub

Sub mwadi2_AdScreenDismissed
	Log("mwadi2 AdScreenDismissed")
End Sub

Sub pnlBanner_Click
	B4XPages.ShowPage("Page_Banner")
End Sub

Private Sub pnlInterstitial_Click
	xui.MsgboxAsync("An Interstitial will be show before open the page." & CRLF & CRLF & "When you close/dismiss the Ad the page will be opened", "Interstitial Transition")
	Wait For Msgbox_Result (Result As Int)
		
	#If B4i
	If mwAdInterstitial.IsReady Then mwAdInterstitial.Show(B4XPages.GetNativeParent(Me))
	#End If
End Sub

Private Sub pnlOpenAd_Click
	xui.Msgbox2Async("Follow the App Open Ad guidance to implement correctly the ad in your app and avoid issues with Admob policy.", "AppOpenAd", "Guide", "Cancel", "Show Ad", Null)
	Wait For Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_POSITIVE Then
		Main.App.OpenURL("https://developers.google.com/admob/ios/app-open")         ' This line is executed but nothing happened
	Else If Result = xui.DialogResponse_NEGATIVE Then
		If OpenAd.IsInitialized Then OpenAd.ShowAdIfAvailable
	End If	
End Sub

Private Sub pnlRewardVideo_Click
	B4XPages.ShowPage("Page_Rewarded")
End Sub