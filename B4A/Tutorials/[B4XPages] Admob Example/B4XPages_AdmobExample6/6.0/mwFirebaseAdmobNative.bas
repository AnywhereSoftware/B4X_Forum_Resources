B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
'FirebaseAdmob Native Ad Class
'https://www.b4x.com/android/forum/threads/firebaseadmob-native-ad-class.107423/#post-671894

Sub Class_Globals
	Private AdID As String
	Private CallingPanel As Panel
	Private ImageMain As ImageView
	Private ImageLogo As ImageView
	Private Headline As Label
	Private Body As Label
	Private CallToActionLabel As Label
	Private Price As Label
	Private pLeft, pTop, pWidth, pHeight As Int
	Private AdPanelHolder As Panel
	Private ParentModule As Object
	Private images As List
	Private isTesting As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallingModule As Object, AdIdString As String,Left As Int, Top As Int, Width As Int, _
			 Height As Int, ParentPanel As Panel, Testing As Boolean)
	If Testing Then Log("Native Ad initializing. This will be a test ad.")
	isTesting=Testing
	AdID=AdIdString
	If Testing Then AdID="ca-app-pub-3940256099942544/2247696110" 'this is the test id for native ads
	CallingPanel=ParentPanel
	pLeft=Left
	pTop=Top
	pWidth=Width
	pHeight=Height
	ParentModule=CallingModule
	
End Sub

Sub LoadNativeAd
	If isTesting Then LogColor("Trying to load unified native ad",Colors.Yellow)
	Dim AdUnitId As String = AdID
	
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	
	Dim builder As JavaObject
	builder.InitializeNewInstance("com.google.android.gms.ads.AdLoader.Builder", Array(ctxt, AdUnitId))
	
	Dim onUnifiedAdLoadedListener As Object = builder.CreateEventFromUI("com/google/android/gms/ads/nativead/NativeAd.OnNativeAdLoadedListener".Replace("/", "."), _
       "UnifiedAdLoaded", Null)
	builder.RunMethod("forNativeAd", Array(onUnifiedAdLoadedListener))
   
	Dim AdLoader As JavaObject = builder.RunMethod("build", Null)
	
	Dim AdrequestBuilder As JavaObject
	AdrequestBuilder.InitializeNewInstance("com/google/android/gms/ads/AdRequest.Builder".Replace("/", "."), Null)
	AdLoader.RunMethod("loadAd", Array(AdrequestBuilder.RunMethod("build", Null)))
	
	Wait For (builder) UnifiedAdLoaded_Event (MethodName As String, Args() As Object)
	If SubExists(ParentModule,"nativead_ReceiveAd") Then CallSubDelayed(ParentModule,"nativead_ReceiveAd")
	If isTesting Then Log("UnifiedAdLoaded_Event")
	
	Try
		Dim NativeAd As JavaObject = Args(0)
				
		Log(NativeAd.RunMethod("getHeadline", Null))
		Log(NativeAd.RunMethod("getBody", Null))
		Log(NativeAd.RunMethod("getAdvertiser", Null))
		Log(NativeAd.RunMethod("getCallToAction", Null))		
		Log(NativeAd.RunMethod("getPrice", Null))
		Log(NativeAd.RunMethod("getStarRating", Null))
		Log(NativeAd.RunMethod("getStore", Null))
		Log(NativeAd.RunMethod("getExtras", Null))

		If isTesting Then Log(NativeAd.RunMethod("getHeadline", Null))
		Dim NativeAdView As JavaObject
		NativeAdView.InitializeNewInstance("com/google/android/gms/ads/nativead/NativeAdView".Replace("/", "."), _
        Array(ctxt))
	   
		Dim pNativeAdView As Panel = NativeAdView
		AdPanelHolder = pNativeAdView
		Dim content As Panel
		content.Initialize("")
		pNativeAdView.AddView(content, 0, 0, pWidth, pHeight)
		content.LoadLayout("NativeUnifiedAd2")
	
		GetAndSetText(NativeAd,NativeAdView,"Headline",Headline,22)
		GetAndSetText(NativeAd,NativeAdView,"Body",Body,22)
		GetAndSetText(NativeAd,NativeAdView,"CallToAction",CallToActionLabel,22)

		GetAndSetImage(NativeAdView, content, ctxt)

		images = NativeAd.RunMethod("getImages", Null)
'		SetExtraImage(NativeUnifiedAdView,ImageMain,0,True)

		'Check if has video
'		Dim vid As JavaObject = NativeUnifiedAd.RunMethod("getVideoController", Null)
'		If vid.IsInitialized Then
'			Dim MediaView As JavaObject
'			MediaView.InitializeNewInstance("com/google/android/gms/ads/formats/MediaView".Replace("/", "."), Array(ctxt))
'			content.AddView(MediaView, 10dip, 60dip, 200dip, 200dip)
'			NativeUnifiedAdView.RunMethod("setMediaView", Array(MediaView))
'		Else
'			'If don't has video, check if is there are images
'			Dim images As List = NativeUnifiedAd.RunMethod("getImages", Null)
'			If images.IsInitialized And images.Size > 0 Then
'				Dim MediaView As JavaObject
'				MediaView.InitializeNewInstance("com/google/android/gms/ads/formats/MediaView".Replace("/", "."), Array(ctxt))
'				content.AddView(MediaView, 10dip, 60dip, 200dip, 200dip)
'				NativeUnifiedAdView.RunMethod("setImageView", Array(MediaView))
'			End If
'		End If

		NativeAdView.RunMethod("setNativeAd", Array(NativeAd))
		
		CallingPanel.AddView(pNativeAdView, pLeft, pTop, pWidth, pHeight)
	Catch
		Log(LastException.Message)
	End Try

End Sub

Private Sub GetAndSetText(ad As JavaObject, adv As JavaObject, var As String, l As Label, maxTextSize As Int)
	l.Text=ad.RunMethod("get"&var, Null)
	AutoSizeTextWithMax(l,l.Text,maxTextSize)
	adv.RunMethod("set"&var&"View",Array(l))
End Sub

Private Sub GetAndSetImage(adv As JavaObject, content As Panel, ctxt As JavaObject)

	Dim MediaView As JavaObject
	MediaView.InitializeNewInstance("com/google/android/gms/ads/nativead/MediaView".Replace("/", "."), Array(ctxt))
	Dim l=ImageMain.Left, t=ImageMain.Top, w=ImageMain.Width, h=ImageMain.Height As Int
'	imgv.RemoveView
	content.AddView(MediaView, l, t, w, h)
	ImageMain.RemoveView
	'
	adv.RunMethod("setMediaView", Array(MediaView))
End Sub

'Private Sub SetExtraImage(NativeAdView As JavaObject, imgv As ImageView, imgnum As Int, TopAlign As Boolean)
'	Log("setextraimage")
'	Log("images.IsInitialized "&images.IsInitialized&" images.Size "&images.Size)
'	If images.IsInitialized And images.Size >= imgnum+1 Then
'		Log("adding image")
'		Log("Do something with extra images? "&images.Size)
''		Dim imgView As Panel
''		imgView.Initialize("")
'		Dim image As JavaObject = images.Get(imgnum) '<-- these 2 lines were updated
'		Dim imgdrawable As BitmapDrawable = image.RunMethod("getDrawable", Null)
'		Dim bmp = imgdrawable.Bitmap As Bitmap
'		LogColor(bmp.Width & ", " &bmp.Height, Colors.Red)
'		imgv.Background = imgdrawable
'		imgv.Height=imgv.Height * bmp.Height / bmp.Width
'		If imgv.Height>imgv.Width Then imgv.Height=imgv.Width
''		content.AddView(ImageMain, 200dip, 100dip, 100dip, 100dip)
'		If Not(TopAlign) Then imgv.Top=pHeight-imgv.Height-5dip
'		NativeAdView.RunMethod("setImageView", Array(imgv))
'	End If
'End Sub

Sub RemoveView
	Try
		AdPanelHolder.RemoveView
	Catch
		Log(LastException.Message)
	End Try
End Sub

'label functions - partly taken from a modified version of the labelsextra code module

Private Sub AutoSizeText(mlbl As Label,value As String)
	Dim HighValue As Float  = 2
	Dim LowValue As Float = 1
	Dim CurrentValue As Float

	mlbl.Text = value
	Dim multipleLines As Boolean = mlbl.Text.Contains(CRLF)
	'need to set actual start values so find Gross Start/Stop values
	'first is linear Growth with some arbitrary 'large' value 'going with 30
	'this can be fine tuned based on size of the display that you are aiming for/have available vs size of your CustomViews

	Do While Not(CheckSize(mlbl,HighValue, multipleLines))
		LowValue = HighValue
		HighValue = HighValue + 100
	Loop

	CurrentValue = (HighValue + LowValue)/2

	'initial sizes set, now for binary approach


	'adjust this to taste.  I like it at 1, and I think it looks very nice... can go a little larger for even faster times
	'smaller for closer hit to actual optimum, but sacrificing a little speed

	Dim ToleranceValue As Float
	ToleranceValue = 1

	Dim currentResult As Boolean
	Do While (CurrentValue - LowValue) > ToleranceValue Or (HighValue - CurrentValue) > ToleranceValue
	
		currentResult = CheckSize(mlbl,CurrentValue, multipleLines)
	
		If currentResult Then 'this means currentvalue is too large
			HighValue = CurrentValue
		Else 'currentValue is too small
			LowValue = CurrentValue
		End If
		CurrentValue = (HighValue + LowValue)/2
	Loop
	mlbl.TextSize = CurrentValue - ToleranceValue
	mlbl.Invalidate
End Sub

Private Sub AutoSizeTextWithMax(mlbl As Label,value As String,maxheight As Int)
	AutoSizeText(mlbl,value)
	If mlbl.TextSize>maxheight Then mlbl.TextSize=maxheight
End Sub

'returns true if the size is too large
Private Sub CheckSize(mlbl As Label,size As Float, MultipleLines As Boolean) As Boolean
	mlbl.TextSize = size
	Dim su As StringUtils

	If MultipleLines Then
		Try
			Return su.MeasureMultilineTextHeight(mlbl, mlbl.Text) > mlbl.Height
		Catch
			Return True
		End Try
	Else
		Return su.MeasureMultilineTextHeight(mlbl, mlbl.Text) > mlbl.Height
	End If
End Sub