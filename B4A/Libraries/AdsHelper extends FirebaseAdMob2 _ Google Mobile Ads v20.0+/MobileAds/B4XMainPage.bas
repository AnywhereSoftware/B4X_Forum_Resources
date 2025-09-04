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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=AdsHelper.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private BannerAd As AdView
	Private iAd As InterstitialAd
	Private Ads As AdsHelper
	Private AppOpenAdUnit As String = "ca-app-pub-3940256099942544/9257395921"
	Private Button1 As B4XView
End Sub

Public Sub Initialize
	Ads.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	B4XPages.GetManager.LogEvents = True
	Root = Root1
	Root.LoadLayout("MainPage")
	Button1.Enabled = False
	CheckConsentAndAddAds
End Sub

Private Sub CheckConsentAndAddAds
	Dim m As MobileAds
	Wait For (m.Initialize) MobileAds_Ready
	'optional. Array with test device ids. See unfiltered logs to find correct id. Look for setTestDeviceIds.
	m.SetConfiguration(m.CreateRequestConfigurationBuilder(Array("8A2BC683096DA70A5AB35C9F69DA8B52"))) 
	
'	Ads.ResetConsentStatus
'	Ads.SetConsentDebugParameters("8A2BC683096DA70A5AB35C9F69DA8B52", True) 'same id as above
	
	If Ads.GetConsentStatus = "UNKNOWN" Or Ads.GetConsentStatus = "REQUIRED" Then
		Wait For (Ads.RequestConsentInformation(False)) Complete (Success As Boolean)
	End If
	If Ads.GetConsentStatus = "REQUIRED" And Ads.GetConsentFormAvailable Then
		Wait For (Ads.ShowConsentForm) Complete (Success As Boolean)
	End If
	Log("Consent: " & Ads.GetConsentStatus)
	Dim AdaptiveSize As Map = Ads.GetAdaptiveAdSize
	BannerAd.Initialize2("BannerAd", "ca-app-pub-3940256099942544/6300978111",AdaptiveSize.Get("native"))
	Root.AddView(BannerAd, 0, 0,  AdaptiveSize.Get("width"), AdaptiveSize.Get("height"))
	BannerAd.LoadAd
	iAd.Initialize("iad", "ca-app-pub-3940256099942544/1033173712")
	iAd.LoadAd
	Ads.FetchOpenAd(AppOpenAdUnit)
	Button1.Enabled = True
End Sub

Private Sub Button1_Click
	If iAd.Ready Then
		iAd.Show
	Else
		Log("no ad is available")
	End If
	iAd.LoadAd
End Sub


Private Sub B4XPage_Foreground
	Ads.ShowOpenAdIfAvailable
End Sub

Private Sub B4XPage_Background
	Ads.Background
End Sub

Sub BannerAd_ReceiveAd
	Log("Adview received")
End Sub

Sub BannerAd_FailedToReceiveAd (ErrorCode As String)
	Log("Failed: " & ErrorCode)
End Sub

Sub BannerAd_AdClosed
	Log("Closed")
End Sub

Sub BannerAd_AdOpened
	Log("Opened")
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


