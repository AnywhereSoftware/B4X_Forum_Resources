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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=b4xpages_nativead.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Public Page2 As B4XNative2
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Page2.Initialize
	B4XPages.AddPage("B4XNative2", Page2)

	'ca-app-pub-3940256099942544/2247696110  'Native Advanced TEST
	LoadNativeAd("NativeAd", "ca-app-pub-3940256099942544/1044960115")  'Native Advanced with Video TEST
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub NativeAd_FailedToReceiveAd (ErrorCode As String)
	Log("NativeAd_FailedToReceiveAd: " & ErrorCode)
End Sub

Sub NativeAd_AdOpened
	Log("NativeAd_AdOpened")
End Sub

Sub NativeAd_ReceiveAd
	LogColor("NativeAd_ReceiveAd", Colors.Cyan)
End Sub

Sub LoadNativeAd(AdName As String, IdAd As String)
	LogColor("LoadNativeAd: " & AdName, Colors.Green)

	Dim AdUnitId As String = IdAd
	
	Dim ctxt As JavaObject
	ctxt.InitializeContext
   
	Dim builder As JavaObject
	builder.InitializeNewInstance("com.google.android.gms.ads.AdLoader.Builder", Array(ctxt, AdUnitId))
   
	Dim onUnifiedAdLoadedListener As Object = builder.CreateEventFromUI("com/google/android/gms/ads/nativead/NativeAd.OnNativeAdLoadedListener".Replace("/", "."), _
       "UnifiedAdLoaded", Null)
	builder.RunMethod("forNativeAd", Array(onUnifiedAdLoadedListener))
   
	Dim Listener As JavaObject
'	Listener.InitializeNewInstance(Application.PackageName & ".main$MyAdListener", Array(AdName))  'change 'main' with the current activity module name
	Listener.InitializeNewInstance(Application.PackageName & ".main$MyAdListener", Array(AdName, Me))
	builder.RunMethod("withAdListener", Array(Listener))
   
'	Sends a request To AdMob, requesting an ad.
	Dim AdLoader As JavaObject = builder.RunMethod("build", Null)
	
	Dim AdRequestBuilder As JavaObject
	AdRequestBuilder.InitializeNewInstance("com/google/android/gms/ads/AdRequest.Builder".Replace("/", "."), Null)
	AdLoader.RunMethod("loadAd", Array(AdRequestBuilder.RunMethod("build", Null)))
   
	Wait For (builder) UnifiedAdLoaded_Event (MethodName As String, Args() As Object)
	
	Dim NativeAd As JavaObject = Args(0)
	
'	Log(GetType(NativeAd))
'	Log("getHeadline: " & NativeAd.RunMethod("getHeadline", Null))
'	Log("getBody: " & NativeAd.RunMethod("getBody", Null))
'	Log("getAdvertiser: " & NativeAd.RunMethod("getAdvertiser", Null))
'	Log("getCallToAction: " & NativeAd.RunMethod("getCallToAction", Null))
'	Log("getPrice: " & NativeAd.RunMethod("getPrice", Null))
'	Log("getStarRating: " & NativeAd.RunMethod("getStarRating", Null))
'	Log("getStore: " & NativeAd.RunMethod("getStore", Null))
'	Log("getExtras: " & NativeAd.RunMethod("getExtras", Null))
   
	Dim NativeAdView As JavaObject
   	
	NativeAdView.InitializeNewInstance("com/google/android/gms/ads/nativead/NativeAdView".Replace("/", "."), _
       Array(ctxt))   
	   	        
	Dim pNativeAdView As Panel = NativeAdView
   
	Dim content As Panel
	content.Initialize("")
	pNativeAdView.AddView(content, 0, 0, 100%x, 70%y)
	
	Dim lblAd As Label
	lblAd.Initialize("")
	lblAd.TextSize = 14
	lblAd.TextColor = xui.Color_White
	lblAd.Color = xui.Color_RGB(255,140,0) 'Dark Orange
	lblAd.Text = "AD"
	lblAd.Padding = Array As Int (0,0,0,0)
	lblAd.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
	content.AddView(lblAd, 10dip, 1dip, 25dip, 16dip)
   
	Dim lbl As Label
	lbl.Initialize("")
	lbl.TextSize = 20
	lbl.TextColor = xui.Color_Black
	lbl.Text = NativeAd.RunMethod("getHeadline", Null)
	content.AddView(lbl, 10dip, 15dip, 300dip, 50dip)
	NativeAdView.RunMethod("setHeadlineView", Array(lbl))
   
	Dim lbl2 As Label
	lbl2.Initialize("")
	lbl2.TextColor = xui.Color_Black
	lbl2.Text = NativeAd.RunMethod("getBody", Null)
	content.AddView(lbl2, 10dip, 65dip, 300dip, 50dip)
	NativeAdView.RunMethod("setBodyView", Array(lbl2))
   
	Dim logo As JavaObject = NativeAd.RunMethod("getIcon", Null)
	If logo.IsInitialized Then
		Dim logoView As Panel
		logoView.Initialize("")
		logoView.Background = logo.RunMethod("getDrawable", Null)
		content.AddView(logoView, 250dip, 10dip, 80dip, 80dip)
		NativeAdView.RunMethod("setIconView", Array(logoView))
	End If
	
	Dim MediaContent As JavaObject = NativeAd.RunMethod("getMediaContent", Null)
	If MediaContent.IsInitialized Then
		Dim vid As JavaObject = MediaContent.RunMethod("getVideoController", Null)
	End If
		
	Log("vid.IsInitialized: " & vid.IsInitialized)
	'check if ad has a video	
	If vid.IsInitialized Then
		Dim MediaView As JavaObject
		MediaView.InitializeNewInstance("com/google/android/gms/ads/nativead/MediaView".Replace("/", "."), Array(ctxt))
		content.AddView(MediaView, 10dip, 100dip, 280dip, 180dip)
		NativeAdView.RunMethod("setMediaView", Array(MediaView))
	Else
		'If don't has video, check if is there are images
		Dim images As List = NativeAd.RunMethod("getImages", Null)
		If images.IsInitialized And images.Size > 0 Then
			Dim MediaView As JavaObject
			MediaView.InitializeNewInstance("com/google/android/gms/ads/nativead/MediaView".Replace("/", "."), Array(ctxt))
			content.AddView(MediaView, 10dip, 100dip, 200dip, 200dip)
			NativeAdView.RunMethod("setImageView", Array(MediaView))
		End If
	End If
	   
	'*** new button to action
	Dim btAction As Button
	btAction.Initialize("")
	Dim cd As ColorDrawable
	cd.Initialize(Colors.RGB(65,105,225),3dip)
	btAction.Background = cd
	btAction.Text = NativeAd.RunMethod("getCallToAction", Null)
	content.AddView(btAction, 10dip, 275dip, 100dip, 50dip)
	NativeAdView.RunMethod("setCallToActionView", Array(btAction))
   
	NativeAdView.RunMethod("setNativeAd", Array(NativeAd))
   
	Root.AddView(pNativeAdView, 0, 0, 100%x, 70%y)
End Sub

Private Sub Button1_Click
	B4XPages.ShowPage("B4XNative2")
End Sub