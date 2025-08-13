B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Dim AdViewSmart As AdView
	Dim AdViewBanner As AdView
	Dim AdViewRect As AdView
	Dim AdViewIAB As AdView
	Dim AdViewAdaptive As AdView
	Dim AdViewPanel As AdView
	Private PanelBanner As Panel
	
	Private Ads As AdsHelper
End Sub

'You can add more parameters here.
Public Sub Initialize
	Ads.Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
'	Test Banner Ad:
'	https://developers.google.com/admob/android/test-ads
'	Banner : ca-app-pub-3940256099942544/6300978111
	
	Root.LoadLayout("LayAdmob1")
	
	'ADAPTIVE BANNER
	'https://www.b4x.com/android/forum/threads/admob-adaptive-banners.111525/#content
	'https://developers.google.com/admob/android/banner/adaptive
	Dim size As AdSize = Utils.GetAdaptiveAdSize
	
	Dim iheight As Int 
	iheight = size.Height
	
	'SIZE_IAB_MRECT : 300 x 250
	AdViewRect.Initialize2("AdViewRect","ca-app-pub-3940256099942544/6300978111", AdViewRect.SIZE_IAB_MRECT)
	Root.AddView(AdViewRect, 0, 5dip, 100%x, 250dip)
	AdViewRect.LoadAd
	
	'SIZE_IAB_BANNER : 468x60
	AdViewIAB.Initialize2("AdViewIAB","ca-app-pub-3940256099942544/6300978111", AdViewIAB.SIZE_IAB_BANNER)
	Root.AddView(AdViewIAB, 0, 270dip, 100%x, 60dip)
	AdViewIAB.LoadAd
	
	'SIZE_BANNER : 320x50
	'TEST ** AdUnitId WRONG ***  RETURN ERRO = 0 -> ERROR_CODE_INTERNAL_ERROR or 1 -> ERROR_CODE_INVALID_REQUEST
	AdViewBanner.Initialize2("AdViewBanner","ca-app-pub-39402", size.Native)
	Root.AddView(AdViewBanner, 0, 50%y, 100%x, 50dip)
	AdViewBanner.LoadAd
	
	AdViewAdaptive.Initialize2("adap", "ca-app-pub-3940256099942544/6300978111", size.Native)
	Root.AddView(AdViewAdaptive, 0, 60%y, size.Width, size.Height)
	AdViewAdaptive.LoadAd
	
	PanelBanner.Height = iheight + 2%y
	
'	Another example of Adaptive Banner using AdsHelper

	Dim AdaptiveSize As Map = Ads.GetAdaptiveAdSize
	
	'Banner in a Panel
	AdViewPanel.Initialize2("AdViewPanel","ca-app-pub-3940256099942544/6300978111", AdaptiveSize.Get("native"))
	PanelBanner.AddView(AdViewPanel, 0, 3dip, 100%x, iheight)
	AdViewPanel.LoadAd
	
	'SIZE_SMART_BANNER (bottom)
	AdViewSmart.Initialize2("AdViewSmart","ca-app-pub-3940256099942544/6300978111", AdaptiveSize.Get("native"))
	Root.AddView(AdViewSmart, 0, 100%y - iheight, 100%x, iheight)
	AdViewSmart.LoadAd
End Sub

'resume
Private Sub B4XPage_Appear
	Log("B4XPageBanner Appeared")
	If AdViewRect.IsInitialized Then AdViewRect.Resume
	AdViewIAB.Resume
	AdViewBanner.Resume
	AdViewSmart.Resume
	AdViewAdaptive.Resume
	AdViewPanel.Resume
End Sub

'pause
Sub B4XPage_Disappear
	Log("B4XPageBanner Disappeared")
	If AdViewRect.IsInitialized Then AdViewRect.Pause
	AdViewIAB.Pause
	AdViewBanner.Pause
	AdViewSmart.Pause
	AdViewAdaptive.Pause
	AdViewPanel.Pause
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub AdViewBanner_FailedToReceiveAd (ErrorCode As String)
	'Errors Code:
'	https://developers.google.com/android/reference/com/google/android/gms/ads/AdRequest.html#ERROR_CODE_INTERNAL_ERROR

'	ERROR_CODE_INTERNAL_ERROR
'	Something happened internally; For instance, an invalid response was received from the ad server.
'	Constant Value: 0
'	
'	ERROR_CODE_INVALID_REQUEST
'	The ad request was invalid; For instance, the ad unit ID was incorrect.
'	Constant Value: 1
'	
'	ERROR_CODE_NETWORK_ERROR
'	The ad request was unsuccessful due To network connectivity.
'	Constant Value: 2
'	
'	ERROR_CODE_NO_FILL
'	The ad request was successful, but no ad was returned due To lack of ad inventory.
'	Constant Value: 3
	
	Log("(TEST) AdViewBanner FailedToReceiveAd: " & Utils.GetErrorCodeAd(ErrorCode))	
End Sub

Sub AdViewBanner_ReceiveAd
	Log("AdViewBanner ReceiveAd")
End Sub

Sub AdViewBanner_AdScreenDismissed
	Log("AdViewBanner AdScreenDismissed")
End Sub
