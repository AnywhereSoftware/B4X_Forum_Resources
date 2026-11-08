B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
#ModuleVisibility: B4XLib
Sub Class_Globals
	Type SMMView (CustomView As Object, mBase As B4XView, ViewType As Int, Key As String)
	Private TargetToSMMViews As Map
	Private Const VIEW_TYPE_B4XIMAGEVIEW = 1, VIEW_TYPE_GIFVIEW = 2, VIEW_TYPE_VIDEOPLAYER = 3, VIEW_TYPE_NONE = 4, VIEW_TYPE_WEBVIEW = 5, VIEW_TYPE_ZOOMIMAGEVIEW = 6 As Int
	Public Const MEDIA_TYPE_IMAGE = 1, MEDIA_TYPE_GIF = 2, MEDIA_TYPE_VIDEO = 3, MEDIA_TYPE_NONE = 4, MEDIA_TYPE_WEBP = 5, MEDIA_TYPE_HTML = 6 As Int
	Private UnusedViews As B4XSet
	Private xui As XUI
	Private Panel As B4XView
	#if SMM_GIF
	Private Const GIF_SUPPORTED As Boolean = True
	#else
	Private Const GIF_SUPPORTED As Boolean = False
	#end if
	#if SMM_VIDEO
	Private Const VIDEO_SUPPORTED As Boolean = True
		#if B4A 
		Private SimpleExoPlayerView1 As SimpleExoPlayerView
		#else if B4i
		Private VideoPlayer1 As VideoPlayer
		#end if
	#Else
	Private Const VIDEO_SUPPORTED As Boolean = False
	#End If
	#if SMM_WEBP
	Private Const WEBP_SUPPORTED As Boolean = True
	#else
	Private Const WEBP_SUPPORTED As Boolean = False
	#End If
	Private mManager As SimpleMediaManager
End Sub

Public Sub Initialize (Manager As SimpleMediaManager)
	mManager = Manager
	TargetToSMMViews.Initialize
	UnusedViews.Initialize
	Panel = xui.CreatePanel("")
	Panel.SetLayoutAnimated(0, 0, 0, 100dip, 100dip)
End Sub

Public Sub CancelRequest (Target As B4XView)
	If TargetToSMMViews.ContainsKey(Target) Then
		ReturnViewToCache(TargetToSMMViews.Get(Target))
		TargetToSMMViews.Remove(Target)
	End If
End Sub

Public Sub AddMedia(RequestSet As SMMediaRequestSet, MEDIA As SMMedia, Request As SMMediaRequest)
	#if SMM_DEBUG
	Log("AddMedia: " & MEDIA.Meta.Key)
	#End If
	Dim Target As B4XView = RequestSet.Target
	CancelRequest(Target)
	Dim ViewType As Int = MediaTypeToViewType(MEDIA.Meta.MediaType, Request)
	Dim sm As SMMView = GetView(ViewType, MEDIA.Meta.Key)
	Target.Color = Request.Extra.GetDefault(mManager.REQUEST_BACKGROUND, mManager.DefaultBackgroundColor)
	TargetToSMMViews.Put(Target, sm)
	Target.AddView(sm.mBase, 0, 0, Target.Width, Target.Height)
	Dim FadeAnimation As Int = Request.Extra.GetDefault(mManager.REQUEST_FADE_ANIMATION_DURATION, mManager.DefaultFadeAnimationDuration)
	If FadeAnimation > 0 Then
		sm.mBase.Visible = False
		sm.mBase.SetVisibleAnimated(FadeAnimation, True)
	Else
		sm.mBase.Visible = True
	End If
	Select ViewType
		Case VIEW_TYPE_B4XIMAGEVIEW
			Dim x As B4XImageView = sm.CustomView
			x.RoundedImage = Request.Extra.GetDefault(mManager.REQUEST_ROUNDIMAGE, False)
			x.CornersRadius = Request.Extra.GetDefault(mManager.REQUEST_CORNERS_RADIUS, 0)			
			x.ResizeMode = Request.Extra.GetDefault(mManager.REQUEST_RESIZE_MODE, mManager.DefaultResizeMode)
			x.Bitmap = MediaToBitmap(MEDIA)
			#if B4A
			If mManager.IsWebPAnimated (MEDIA) Then
				Dim decoder As JavaObject
				Dim Drawable As JavaObject = decoder.InitializeStatic("android.graphics.ImageDecoder").RunMethod("decodeDrawable", Array(MEDIA.Media))
				x.mBase.GetView(0).As(View).Background = Drawable
				If GetType(Drawable) = "android.graphics.drawable.AnimatedImageDrawable" Then
					Drawable.RunMethod("start", Null)
				End If
			End If
			#End If
		Case VIEW_TYPE_GIFVIEW
			#IF SMM_GIF
			Dim gif As B4XGifView = sm.CustomView
			gif.SetGif2(MEDIA.Media)
			#End If
		Case VIEW_TYPE_ZOOMIMAGEVIEW
			#if SMM_ZOOM
			ParentResized(Target)
			Dim zoom As ZoomImageView = sm.CustomView
			zoom.SetBitmap(MediaToBitmap(MEDIA))
			#End If
		Case VIEW_TYPE_VIDEOPLAYER
			#if SMM_VIDEO
			ParentResized(Target)
			#if B4J
			Dim controller As MediaViewController = sm.CustomView
			controller.mMediaView.Source = MEDIA.Media
			Sleep(0)
			Dim ForegroundColor As Int = Request.Extra.GetDefault(mManager.REQUEST_FOREGROUND, mManager.DefaultForegroundColor)
			For Each v As B4XView In sm.mBase.GetAllViewsRecursive
				If v Is Label Then
					v.TextColor = ForegroundColor
				End If
			Next
			#else if B4A
			Dim PlayerView As SimpleExoPlayerView = sm.CustomView
			Dim player As SimpleExoPlayer = PlayerView.Tag
			If MEDIA.Meta.Mime = "application/vnd.apple.mpegurl" Then
				player.Prepare(player.CreateHLSSource(MEDIA.Media))
			Else
				player.Prepare(player.CreateUriSource(MEDIA.Media))
			End If
			#Else If B4i
			Dim player As VideoPlayer = sm.CustomView
			player.LoadVideoUrl(MEDIA.Media)
			#End If
			#end if
		Case VIEW_TYPE_WEBVIEW
			ParentResized(Target)
			sm.CustomView.As(WebView).LoadUrl(MEDIA.Media)
	End Select
	If RequestSet.Callback <> Null And RequestSet.RequestState <> mManager.STATE_LOADING Then
		Dim params() As Object = Array(RequestSet.RequestState = mManager.STATE_READY, MEDIA)
		If FadeAnimation > 0 Then
			Sleep(FadeAnimation + 10)
		End If
	#if B4I
		Dim l As List = params
		RequestSet.Callback.As(NativeObject).GetField("bi").RunMethod("raiseUIEvent:event:params:", Array(Target, "smm_mediaready::", l))
	#else
		RequestSet.Callback.As(JavaObject).RunMethodJO("getBA", Null).RunMethod("raiseEventFromUI", _
			Array(Target, "smm_mediaready", params))
	#End If
	End If
End Sub

Private Sub MediaToBitmap(MEDIA As SMMedia) As B4XBitmap
	#if B4A
	If mManager.IsWebPAnimated(MEDIA) Then
		Dim decoder As JavaObject
		Return decoder.InitializeStatic("android.graphics.ImageDecoder").RunMethod("decodeBitmap", Array(MEDIA.Media))
	End If
	#End If
	Return MEDIA.Media
End Sub

Public Sub MimeToMediaType (Mime As String) As Int
	If Mime.StartsWith("image/gif") Then
		If GIF_SUPPORTED = False Then Log("*** Add a reference to B4XGIfView and add SMM_GIF to the build configuration ***")
		Return IIf(GIF_SUPPORTED, MEDIA_TYPE_GIF, MEDIA_TYPE_NONE)
	Else If Mime.StartsWith("image/webp") Then
		If WEBP_SUPPORTED = False Then Log("*** Add a reference to WebP library and add SMM_WEBP to the build configuration ***")
		Return IIf(WEBP_SUPPORTED, MEDIA_TYPE_WEBP, MEDIA_TYPE_NONE)
	Else If Mime.StartsWith("image/") Then
		Return MEDIA_TYPE_IMAGE
	Else if Mime.StartsWith("video/") Or Mime = "application/vnd.apple.mpegurl" Then
		If VIDEO_SUPPORTED = False Then Log("*** Add a reference to the video library and add SMM_VIDEO to the build configuration ***")
		Return IIf(VIDEO_SUPPORTED, MEDIA_TYPE_VIDEO, MEDIA_TYPE_NONE)
	Else If Mime.StartsWith("text/") Then
		Return MEDIA_TYPE_HTML
	Else
		Return MEDIA_TYPE_NONE
	End If
End Sub

Private Sub MediaTypeToViewType(MediaType As Int, Request As SMMediaRequest) As Int
	Select MediaType
		Case MEDIA_TYPE_IMAGE, MEDIA_TYPE_WEBP
			#IF SMM_ZOOM
			If Request.Extra.GetDefault(mManager.REQUEST_ZOOMIMAGEVIEW, False) = True Then
				Return VIEW_TYPE_ZOOMIMAGEVIEW
			End If
			#end if
			Return VIEW_TYPE_B4XIMAGEVIEW
		Case MEDIA_TYPE_GIF
			Return VIEW_TYPE_GIFVIEW
		Case MEDIA_TYPE_VIDEO
			Return VIEW_TYPE_VIDEOPLAYER
		Case MEDIA_TYPE_NONE
			Return VIEW_TYPE_NONE
		Case MEDIA_TYPE_HTML
			Return VIEW_TYPE_WEBVIEW
		Case Else
			Log("Unexpected media type: " & MediaType)
			Return VIEW_TYPE_NONE
	End Select
End Sub

Private Sub ReturnViewToCache (sm As SMMView)
	#if SMM_DEBUG
	Log("ReturnViewToCache: " & sm.Key)
	#End If
	sm.mBase.RemoveViewFromParent
	Select sm.ViewType
		Case VIEW_TYPE_B4XIMAGEVIEW
			sm.CustomView.As(B4XImageView).Clear
		Case VIEW_TYPE_GIFVIEW
			sm.mBase.GetView(0).SetBitmap(Null)
			#if B4A and SMM_GIF
			sm.CustomView.As(B4XGifView).GifDrawable.RunMethod("recycle", Null)
			#End If
		Case VIEW_TYPE_VIDEOPLAYER
			#if SMM_VIDEO
			#if B4J
			sm.CustomView.As(MediaViewController).mMediaView.Dispose
			#else if B4A
			sm.CustomView.As(SimpleExoPlayerView).Tag.As(SimpleExoPlayer).Pause
			#else if B4I
			sm.CustomView.As(VideoPlayer).Pause
			#End If
			#end if
		Case VIEW_TYPE_WEBVIEW
			#if B4J
			sm.CustomView.As(JavaObject).RunMethodJO("getEngine", Null).RunMethod("load", Array(Null))
			#else if b4i
			sm.CustomView.As(NativeObject).RunMethod("stopLoading", Null)
			#else if B4A
			sm.CustomView.As(JavaObject).RunMethod("stopLoading", Null)
			#End If
			sm.CustomView.As(WebView).LoadHtml("")
		Case VIEW_TYPE_ZOOMIMAGEVIEW
			#if SMM_ZOOM
			sm.CustomView.As(ZoomImageView).SetBitmap(Null)
			#End If
	End Select
	UnusedViews.Add(sm)
End Sub

Private Sub GetView (ViewType As Int, Key As String) As SMMView
	For Each sview As SMMView In UnusedViews.AsList
		If sview.ViewType = ViewType Then
			UnusedViews.Remove(sview)
			#if SMM_DEBUG
			Log($"Reusing view: (${TypeToString(ViewType)}) ${sview.Key} -> ${Key}"$)
			#End If
			Return CreateSMMView(sview.CustomView, sview.mBase, sview.ViewType, Key)
		End If
	Next
	#if SMM_DEBUG
	Log($"Creating view: ${Key}, type: ${TypeToString(ViewType)}"$)
	#End If
	Dim mBase As B4XView
	Dim CustomView As Object
	Select ViewType
		Case VIEW_TYPE_B4XIMAGEVIEW
			Dim x As B4XImageView = XUIViewsUtils.CreateB4XImageView
			x.mBackgroundColor = xui.Color_Transparent
			CustomView = x
			mBase = x.mBase
		Case VIEW_TYPE_NONE
			Dim p As B4XView = xui.CreatePanel("")
			CustomView = p
			mBase = p
		Case VIEW_TYPE_GIFVIEW
			Panel.LoadLayout("SMMGifView")
			CustomView = Panel.GetView(0).Tag
			mBase = Panel.GetView(0)
			mBase.RemoveViewFromParent
		Case VIEW_TYPE_ZOOMIMAGEVIEW
			Panel.LoadLayout("SMMZoomImageView")
			CustomView = Panel.GetView(0).Tag
			mBase = Panel.GetView(0)
			mBase.RemoveViewFromParent
		Case VIEW_TYPE_VIDEOPLAYER
			#if SMM_VIDEO
			Dim p As B4XView = xui.CreatePanel("")
			p.SetLayoutAnimated(0, 0, 0, 100dip, 100dip)
			p.LoadLayout("SMMVideoPlayer")
			mBase = p
			#if B4J
			p.GetView(0).Color = xui.Color_Transparent
			CustomView = p.GetView(1).Tag
			CustomView.As(MediaViewController).SetMediaView(p.GetView(0).Tag)
			#Else If B4A
			Dim player As SimpleExoPlayer
			player.Initialize("")
			SimpleExoPlayerView1.Player = player
			SimpleExoPlayerView1.Tag = player
			SimpleExoPlayerView1.UseController = True
			CustomView = SimpleExoPlayerView1
			#Else If B4i
			CustomView = VideoPlayer1
			#end if
			#end if
		Case VIEW_TYPE_WEBVIEW
			Dim p As B4XView = xui.CreatePanel("")
			p.SetLayoutAnimated(0, 0, 0, 100dip, 100dip)
			Dim wv As WebView
			wv.Initialize("")
			p.AddView(wv, 0, 0, p.Width,p.Height)
			CustomView = wv
			mBase = p
	End Select
	Return CreateSMMView(CustomView, mBase, ViewType, Key)
End Sub


Private Sub TypeToString (ViewType As Int) As String 'ignore
	Select ViewType
		Case VIEW_TYPE_B4XIMAGEVIEW
			Return "B4XImageView"
		Case VIEW_TYPE_GIFVIEW
			Return "B4XGifView"
		Case VIEW_TYPE_NONE
			Return "Panel"
		Case VIEW_TYPE_VIDEOPLAYER
			Return "video player"
		Case VIEW_TYPE_WEBVIEW
			Return "WebView"
		Case VIEW_TYPE_ZOOMIMAGEVIEW
			Return "ZoomImageView"
	End Select
End Sub

Public Sub ParentResized (Target As B4XView)
	If TargetToSMMViews.ContainsKey(Target) Then
		Dim sm As SMMView = TargetToSMMViews.Get(Target)
		sm.mBase.SetLayoutAnimated(0, 0, 0, Target.Width, Target.Height)
		Select sm.ViewType
			Case VIEW_TYPE_B4XIMAGEVIEW
				Dim x As B4XImageView = sm.CustomView
				x.Update
			Case VIEW_TYPE_VIDEOPLAYER
				#if SMM_VIDEO
				#if B4J
				Dim controller As MediaViewController = sm.CustomView
				controller.mMediaView.mBase.SetLayoutAnimated(0, 0, 0, Target.Width, Target.Height)
				controller.mBase.SetLayoutAnimated(0, 0, 0, Target.Width, Target.Height)
				#else if B4A
				Dim view As SimpleExoPlayerView = sm.CustomView
				view.SetLayoutAnimated(0, 0, 0, Target.Width, Target.Height)
				#else if B4i
				Dim view As VideoPlayer = sm.CustomView
				view.BaseView.SetLayoutAnimated(0, 1, 0, 0, Target.Width, Target.Height)
				#End If
				#end if
			Case VIEW_TYPE_WEBVIEW
				sm.CustomView.As(B4XView).SetLayoutAnimated(0, 0, 0, Target.Width, Target.Height)
			Case VIEW_TYPE_ZOOMIMAGEVIEW
				#if SMM_ZOOM
				#if B4A
				sm.CustomView.As(ZoomImageView).Base_Resize(Target.Width, Target.Height)
				#End If
				#End If
		End Select
	End If
End Sub

Private Sub CreateSMMView (CustomView As Object, mBase As B4XView, ViewType As Int, Key As String) As SMMView
	Dim t1 As SMMView
	t1.Initialize
	t1.CustomView = CustomView
	t1.mBase = mBase
	t1.ViewType = ViewType
	t1.Key = Key
	Return t1
End Sub
