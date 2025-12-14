B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Dim AdViewBanner As AdView
	Dim AdViewRect As AdView
	Dim AdViewIAB As AdView
	Dim AdViewAdaptive As AdView
	
	Private PanelBanner As B4XView
	Private pAd100 As B4XView
	
	Private PanelBannerInline As Panel
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root	
	Root.LoadLayout("LayAdmob1")
	
	'SIZE_IAB_BANNER : 320x100
	AdViewRect.Initialize("Ad100", "ca-app-pub-3940256099942544/2934735716", B4XPages.GetNativeParent(Me), AdViewRect.SIZE_LARGE_BANNER)
			
	'SIZE_IAB_MRECT : 300 x 250
	AdViewIAB.Initialize("Ad250", "ca-app-pub-3940256099942544/2934735716", B4XPages.GetNativeParent(Me), AdViewRect.SIZE_FULL_BANNER)
	
	'SIZE_BANNER : 320x50
	AdViewBanner.Initialize("AdViewBanner", "ca-app-pub-3940256099942544/2934735716", B4XPages.GetNativeParent(Me), AdViewBanner.SIZE_BANNER)
			
	If Root.Width = 0 Or Root.Height = 0 Then
		Wait For B4XPage_Resize (Width As Int, Height As Int)
	End If
	
	pAd100.AddView(AdViewRect, 0, 0, Root.Width, 100dip)
	AdViewRect.LoadAd
	
	Root.AddView(AdViewIAB, 0, 120dip, Root.Width, 250dip)
	AdViewIAB.LoadAd
	
	PanelBanner.AddView(AdViewBanner, 0, 0, PanelBanner.Width, 50dip)			
	AdViewBanner.LoadAd
	
	'https://www.b4x.com/android/forum/threads/admob-adaptive-banners.111896/#post-697865
	Dim no As NativeObject = Me
	Dim sizes As List = no.RunMethod("GetAdaptiveSize:", Array(Root.Width))
	AdViewAdaptive.Initialize("AdViewAdaptive", "ca-app-pub-3940256099942544/2435281174", B4XPages.GetNativeParent(Me), sizes.Get(0))
	Dim w As Float = sizes.Get(1) 'ignore
	Dim h As Float = sizes.Get(2)
	LogColor(w, xui.Color_Blue)
	LogColor(h, xui.Color_Blue)
	PanelBannerInline.Height = h
	PanelBannerInline.AddView(AdViewAdaptive, 0, 0, w, h)
	AdViewAdaptive.LoadAd
End Sub

'resume
Private Sub B4XPage_Appear
	Log("B4XPageBanner Appeared")
End Sub

'pause
Sub B4XPage_Disappear
	Log("B4XPageBanner Disappeared")
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
	
'	Log("(TEST) AdViewBanner FailedToReceiveAd: " & Utils.GetErrorCodeAd(ErrorCode))	

	Log("Ad failed: " & ErrorCode)
End Sub

Sub AdViewBanner_ReceiveAd
	Log("AdViewBanner ReceiveAd")
End Sub

Sub AdViewBanner_AdScreenDismissed
	Log("AdViewBanner AdScreenDismissed")
End Sub

Sub AdViewAdaptive_FailedToReceiveAd (ErrorCode As String)
	Log("AdViewAdaptive failed: " & ErrorCode)
End Sub

Sub AdViewAdaptive_ReceiveAd
	Log("AdViewAdaptive ReceiveAd")
End Sub

Sub AdViewAdaptive_AdScreenDismissed
	Log("AdViewAdaptive AdScreenDismissed")
End Sub

#if OBJC
- (NSArray *)GetAdaptiveSize:(float)width {
   GADAdSize g = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(width);
   CGSize s = g.size;
   return @[[NSValue valueWithBytes: &g
               objCType:@encode(GADAdSize)], @(s.width), @(s.height)];
}
#End If