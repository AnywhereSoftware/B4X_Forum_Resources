B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
'Author: Biswajit
'Version: 2.02

#DesignerProperty: Key: DotShow, DisplayName: Show Indicator Dots, FieldType: String, DefaultValue: OUTSIDE, Description: Show indicator dots.,List: OUTSIDE|INSIDE|HIDE
#DesignerProperty: Key: DotColor, DisplayName: Dots Color, FieldType: Color, DefaultValue: 0xFFCCCCCC, Description: Dots color.
#DesignerProperty: Key: ActiveDotColor, DisplayName: Active Dots Color, FieldType: Color, DefaultValue: 0xFF4286f4, Description: Active Dots color.
#DesignerProperty: Key: ScaleContent, DisplayName: Scale Content, FieldType: String, DefaultValue: FIT, Description: Slider item scale type., List:FIT|FILL|STRETCH 
#DesignerProperty: Key: CoverFreeSpace, DisplayName: Cover Free Space, FieldType: Boolean, DefaultValue: True, Description: Show a blurry image around the slide image if there is any free space. Only applicable for image item and if FIT scale type is selected. 
#DesignerProperty: Key: FreeSpaceColor, DisplayName: Free Space Color, FieldType: Color, DefaultValue: 0xFFF4F4F4, Description: Show a solid color around the slide item if there is any free space. Only applicable if Cover Free Space is unchecked for image items. 
#DesignerProperty: Key: ImageCount, DisplayName: Item Count, FieldType: Boolean, DefaultValue: True, Description: Show item count label (Eg. 5/10). 
#DesignerProperty: Key: dotTransitionDuration, DisplayName: Dot Transition Duration, FieldType: Int, DefaultValue: 500, Description: Dots transition time in milliseconds.
#DesignerProperty: Key: ZoomActualSlide, DisplayName: Zoom Actual View, FieldType: Boolean, DefaultValue: True, Description: If checked the item will be hidden while zooming (Like Instagram).

#DesignerProperty: Key: AutoPlayVideo, DisplayName: Autoplay Video, FieldType: Boolean, DefaultValue: True, Description: If checked the video will be autoplayed on loading completion.
#DesignerProperty: Key: StartVideoMuted, DisplayName: Start Video Muted, FieldType: Boolean, DefaultValue: True, Description: If checked the video will start muted on loading completion.

#Event: PageChanged(CurrentIndex As Int)
#Event: VideoPlaying(CurrentIndex As Int)
#Event: VideoPaused(CurrentIndex As Int)
#Event: SingleTap(CurrentIndex As Int, Data As Object)
#Event: DoubleTap(CurrentIndex As Int, Data As Object)

private Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	#if b4i
	Private ImgCont As ScrollView
	Private ximageslider_videoview As VideoPlayer
	#else if b4a
	Private Imgcont As AHViewPager
	Private imgLayout As AHPageContainer
	Private GesturePanel As Panel
	#end if
	Private ImgCount As Label
	Private ImgList As List
	
	Public CurrentIndex As Int = 0
	Private PrevIndex As Int = 0
	Private dotTransitionDuration As Int
	
	Private dotCont As B4XView
	Private dotColor,activeDotColor As Int
	Private dotSize As Int = 6dip
	Private dotSizeM As Int = 5dip
	Private dotSizeS As Int = 3dip
	Private dotgap As Int = dotSize
	Private ShowDots,scale As String
	Private ImageCount,CoverFreeSpace,ZoomActualSlide,AutoPlayVideo,StartVideoMuted As Boolean
	Private FreeSpaceColor As Int
	Private actHasActionBar As Boolean = False
	
	Private LblTimer As Timer
	Private videoplayer As List
	
	#if b4a
	Private GD As GestureDetector
	Private JO As JavaObject
	#else if b4i
	Private GD As NativeObject=Me
	Private ximageslider_videoview As VideoPlayer
	#End If
	
	Private ZoomContainer,ZoomPanel As B4XView
	Private PinchStartDistance,PinchFixX,PinchFixY,ZoomWindowFix As Double = 0
End Sub

private Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ImgList.Initialize
	ZoomPanel = xui.CreatePanel("ZoomPanel")
	
	ImgCount.Initialize("")
	dotCont = xui.CreatePanel("")
	LblTimer.Initialize("LblTimer",2000)
End Sub

'Base type must be Object
private Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	ShowDots = Props.Get("DotShow")
	dotColor = xui.PaintOrColorToColor(Props.Get("DotColor"))
	activeDotColor = xui.PaintOrColorToColor(Props.Get("ActiveDotColor"))
	scale = Props.Get("ScaleContent")
	ImageCount = Props.Get("ImageCount")
	CoverFreeSpace = Props.Get("CoverFreeSpace")
	FreeSpaceColor = Props.Get("FreeSpaceColor")
	ZoomActualSlide = Props.Get("ZoomActualSlide")
	dotTransitionDuration = Props.Get("dotTransitionDuration")
	AutoPlayVideo = Props.Get("AutoPlayVideo")
	StartVideoMuted = Props.Get("StartVideoMuted")
	
	mBase = Base
	mBase.Color = xui.Color_Transparent
	#if b4i
	If ShowDots = "OUTSIDE" Then
		ImgCont.Initialize("ImgCont",mBase.Width,(mBase.Height-30dip))
	Else
		ImgCont.Initialize("ImgCont",mBase.Width,(mBase.Height))
	End If
	ImgCont.PagingEnabled=True
	ImgCont.Bounces = False
	ImgCont.ShowsHorizontalIndicator = False
	#else if b4a
	Imgcont.Initialize("ImgCont")
	#end if
	
	If ShowDots = "OUTSIDE" Then 
		mBase.AddView(Imgcont,0,0,mBase.Width,(mBase.Height-30dip))
	Else
		mBase.AddView(Imgcont,0,0,mBase.Width,mBase.Height)
	End If
		
	
	#if b4a
	GesturePanel = xui.CreatePanel("")
	mBase.addview(GesturePanel,0,0,mBase.Width,Imgcont.Height)
	GD.SetOnGestureListener(GesturePanel,"ImgCont_GD")
	
	JO = mBase
	#End If
	zoomfix
	mBase.AddView(xui.CreatePanel(""),(mBase.Width - 10dip) + 1dip,10dip,1dip,25dip)
	mBase.GetView(mBase.NumberOfViews-1).AddView(ImgCount,0,0,1dip,25dip)
	Private tempView As B4XView = ImgCount
	tempView.TextColor = xui.Color_White
	tempView.TextSize = 12
	tempView.SetTextAlignment("CENTER","CENTER")
	tempView.Parent.Visible = False
	
	mBase.AddView(dotCont,0,mBase.Height - 30dip, mBase.Width,30dip)
	
	ZoomPanel.Color = xui.Color_ARGB(30,0,0,0)
End Sub

Private Sub zoomfix
	#if b4a
	Dim j As JavaObject
	j.InitializeContext
	If actHasActionBar Then
		ZoomWindowFix = j.RunMethodJO("getActionBar",Null).RunMethod("getHeight",Null)
	Else
		ZoomWindowFix=0
	End If
	ZoomWindowFix = ZoomWindowFix + j.RunMethodJO("getResources",Null).RunMethod("getDimensionPixelSize",Array As Object (j.RunMethodJO("getResources",Null).RunMethod("getIdentifier",Array As Object ("status_bar_height", "dimen", "android"))))
	#else if b4i
	Dim NO As NativeObject = Main.NavControl
	If actHasActionBar Then
		ZoomWindowFix = NO.ArrayFromRect(NO.GetField("navigationBar").GetField("frame").RunMethod("CGRectValue", Null))(3)
	Else
		ZoomWindowFix=0
	End If
	ZoomWindowFix = ZoomWindowFix + GD.RunMethod("statusBarHeight",Null).AsNumber
	#End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

End Sub

#if b4a
Private Sub ImgCont_GD_onSingleTapConfirmed(X As Float, Y As Float, MotionEvent As Object)
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	If imagedata.ContainsKey("player") Then
		If x < 45dip And y < 45dip Then
			ToggleMute
		Else
			Dim vo As JavaObject = imagedata.Get("player")
			If vo.GetFieldJO("player").RunMethod("isPlaying",Null) = True Then
				i.GetView(0).Tag=False
				PauseCurrentVideo
			Else
				i.GetView(0).Tag=True
				PlayCurrentVideo
			End If
		End If
	Else
		If xui.SubExists(mCallBack, mEventName & "_SingleTap",2) Then
			Private currentView As B4XView = ImgList.Get(CurrentIndex)
			Private tagmap As Map = currentView.Tag
			CallSub3(mCallBack, mEventName & "_SingleTap",CurrentIndex,tagmap.Get("data"))
		End If
	End If
	
End Sub

Private Sub ImgCont_GD_onDoubleTap(X As Float, Y As Float, MotionEvent As Object)
	If xui.SubExists(mCallBack, mEventName & "_DoubleTap",2) Then
		Private currentView As B4XView = ImgList.Get(CurrentIndex)
		Private tagmap As Map = currentView.Tag
		CallSub3(mCallBack, mEventName & "_DoubleTap",CurrentIndex,tagmap.Get("data"))
	End If
End Sub
#else if b4i
Private Sub uigesture_tap(numTaps As Int, numTouch As Int, x As Float, y As Float)
	If numTaps = 2 Then
		If xui.SubExists(mCallBack, mEventName & "_DoubleTap",2) Then
			Private currentView As B4XView = ImgList.Get(CurrentIndex)
			Private tagmap As Map = currentView.Tag
			CallSub3(mCallBack, mEventName & "_DoubleTap",CurrentIndex,tagmap.Get("data"))
		End If
	else if numTaps =1 Then
		Dim i As B4XView = ImgList.Get(CurrentIndex)
		Dim imagedata As Map = i.Tag
		If imagedata.ContainsKey("player") Then
			If x < 45dip And y < 45dip Then
				ToggleMute
			Else
				Dim vo As NativeObject = getPlayer(imagedata.Get("player"))
				If vo.getField("timeControlStatus").AsNumber = 2 Then
					i.GetView(0).Tag=False
					PauseCurrentVideo
				Else If vo.getField("timeControlStatus").AsNumber = 0 Then
					i.GetView(0).Tag=True
					PlayCurrentVideo
				End If
			End If
		Else
			If xui.SubExists(mCallBack, mEventName & "_SingleTap",2) Then
				Private currentView As B4XView = ImgList.Get(CurrentIndex)
				Private tagmap As Map = currentView.Tag
				CallSub3(mCallBack, mEventName & "_SingleTap",CurrentIndex,tagmap.Get("data"))
			End If
		End If
	End If
End Sub
#end if

#if b4a

Private Sub ImgCont_GD_onTouch(Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean	
	If Action = mBase.TOUCH_ACTION_UP Then
		Dim i As B4XView = ImgList.Get(CurrentIndex)
		Dim imagedata As Map = i.Tag
		If imagedata.ContainsKey("player") = False Then
			ZoomPanel.RemoveViewFromParent
			ZoomPanel.RemoveAllViews
			If ZoomActualSlide Then
				Private actualView As B4XView = ImgList.Get(CurrentIndex)
				actualView.SetVisibleAnimated(200,True)
			End If
		End If
		StopPropagation(False)
	End If
	GD.PassTouchEventTo(MotionEvent,Imgcont)
	Return True
End Sub

Private Sub ImgCont_GD_onPinchClose(NewDistance As Float, PreviousDistance As Float, MotionEvent As Object)
	StopPropagation(True)
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	If imagedata.ContainsKey("player") = False Then
		If ZoomContainer.IsInitialized Then
			If ZoomPanel.Parent.IsInitialized Then
				ZoomImage(NewDistance,MotionEvent)
			End If
		End If
	End If
End Sub

Private Sub ImgCont_GD_onPinchOpen(NewDistance As Float, PreviousDistance As Float, MotionEvent As Object)
	StopPropagation(True)
#else if b4i
Private Sub uigesture_pinch(NewDistance As Float, x As Float,y As Float, action As Int)
#end if
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	If imagedata.ContainsKey("player") = False Then
		If ZoomContainer.IsInitialized Then
			If Not(ZoomPanel.Parent.IsInitialized) Then
				ZoomContainer.AddView(ZoomPanel,0,0,ZoomContainer.width,ZoomContainer.Height)
				Private actualView As B4XView = ImgList.Get(CurrentIndex)
				#if b4i
				Private tempView As ImageView
				tempView.Initialize("")
				tempView.ContentMode = tempView.MODE_FILL
				tempView.Bitmap = actualView.Snapshot
				PinchFixX = (actualView.Width/2) - x
				PinchFixY = (actualView.Height/2) - y
				Private NO As NativeObject = Me
				Private location(2) As Float = NO.ArrayFromPoint(NO.RunMethod("getLocationInWindow::",Array(ImgCont,actualView)))
				#else if b4a
				Private location(2) As Int
				JO.RunMethod("getLocationInWindow",Array As Object(location))
				Private tempView As Panel = xui.CreatePanel("yy")
				tempView.SetBackgroundImage(actualView.Snapshot).Gravity = Gravity.FILL
				PinchFixX = (actualView.Width/2) - (Min(GD.getX(MotionEvent,1),GD.getX(MotionEvent,0)) + Abs(GD.getX(MotionEvent,0) - GD.getX(MotionEvent,1))/2)
				PinchFixY = (actualView.Height/2) - (Min(GD.getY(MotionEvent,1),GD.getY(MotionEvent,0)) + Abs(GD.getY(MotionEvent,0) - GD.getY(MotionEvent,1))/2)
				#End If
				ZoomPanel.AddView(tempView,location(0),location(1) - ZoomWindowFix,actualView.Width,actualView.Height)
				PinchStartDistance = NewDistance
			Else
				#if b4a
				ZoomImage(NewDistance,MotionEvent)
				#else if b4i
				ZoomImage(NewDistance,x,y)
				If action = 3 Then
					Dim i As B4XView = ImgList.Get(CurrentIndex)
					Dim imagedata As Map = i.Tag
					If imagedata.ContainsKey("player") = False Then
						ZoomPanel.RemoveViewFromParent
						ZoomPanel.RemoveAllViews
						If ZoomActualSlide Then
							Private actualView As B4XView = ImgList.Get(CurrentIndex)
							actualView.SetVisibleAnimated(200,True)
						End If
					End If
				End If
				#End If
			End If
		End If
	
	End If
End Sub

Private Sub LblTimer_tick
	Private i As B4XView = ImgCount.parent
	i.SetVisibleAnimated(500,False)
	LblTimer.Enabled = False
End Sub

#Region Functions
#if b4a
Private Sub StopPropagation(Enable As Boolean)
	Private j As JavaObject = GesturePanel
	j.RunMethod("requestDisallowInterceptTouchEvent",Array As Object(Enable))
End Sub
#end if

#if b4a
Private Sub ZoomImage(Distance As Float, MotionEvent As Object)
	Private centerX As Int = Min(GD.getX(MotionEvent,1),GD.getX(MotionEvent,0)) + Abs(GD.getX(MotionEvent,0) - GD.getX(MotionEvent,1))/2
	Private centerY As Int = Min(GD.getY(MotionEvent,1),GD.getY(MotionEvent,0)) + Abs(GD.getY(MotionEvent,0) - GD.getY(MotionEvent,1))/2
	Private location(2) As Int
	JO.RunMethod("getLocationInWindow",Array As Object(location))
	Private actualView As B4XView = ImgList.Get(CurrentIndex)
#else if b4i
Private Sub ZoomImage(Distance As Float, centerX As Int, centerY As Int)
	Private actualView As B4XView = ImgList.Get(CurrentIndex)
	Private NO As NativeObject = Me
	Private location(2) As Float = NO.ArrayFromPoint(NO.RunMethod("getLocationInWindow::",Array(ImgCont,actualView)))
#end if
	If ZoomActualSlide Then actualView.Visible = False
	Private newWidth As Int = Max(actualView.Width,(Distance/PinchStartDistance)*actualView.Width)
	Private newHeight As Int = Max(actualView.Height,(Distance/PinchStartDistance)*actualView.Height)
	ZoomPanel.GetView(0).SetLayoutAnimated(10,(centerX+location(0)) - (newWidth/2) + (PinchFixX * (Distance/PinchStartDistance)),(centerY+location(1)) - (newHeight/2) + (PinchFixY * (Distance/PinchStartDistance)) - ZoomWindowFix,newWidth,newHeight)
End Sub

Private Sub SlideImage(centerIndex As Int)
	#if b4i
	ImgCont.ScrollTo(ImgCont.Width*centerIndex,0,True)
	#else b4a
	Imgcont.GotoPage(centerIndex,True)
	#end if
End Sub

#if b4i
Private Sub ImgCont_ScrollChanged (OffsetX As Int, OffsetY As Int)
	Dim centerIndex As Int = 0
	If OffsetX > 0 Then 
		centerIndex = OffsetX/ImgCont.width
	End If
	
	If OffsetX = centerIndex*ImgCont.width Then
#else if b4a
Private Sub ImgCont_PageChanged (Position As Int)
	Dim centerIndex As Int = Position
#end if
	If CurrentIndex > -1 Then
		Dim i As B4XView = ImgList.Get(CurrentIndex)
		Dim imagedata As Map = i.Tag
		If imagedata.ContainsKey("player") Then
			PauseCurrentVideo
		End If
	End If
	

	If CurrentIndex <> centerIndex Then
		PrevIndex = CurrentIndex
		CurrentIndex = centerIndex
		ShowCount
		UpdatePlayback
		If ShowDots <> "HIDE" Then UpdateDots
	End If
#if b4i
	End If
#end if

	If xui.SubExists(mCallBack, mEventName & "_PageChanged",1) Then
		CallSub2(mCallBack, mEventName & "_PageChanged",CurrentIndex)
	End If
	ShowImage
End Sub

Private Sub ShowCount
	If ImageCount Then
		Private tempView As B4XView = ImgCount
		tempView.Text = (CurrentIndex+1) & "/" & ImgList.Size
		Private tempCanvas As B4XCanvas
		tempCanvas.Initialize(ImgCount) 
		Private textSize As B4XRect = tempCanvas.MeasureText(tempView.Text,tempView.Font)
		
		tempView.parent.SetLayoutAnimated(100,(Imgcont.Width - 10dip)-(textSize.Width+20dip),tempView.Parent.Top,(textSize.Width+20dip),tempView.parent.Height)
		tempView.SetLayoutAnimated(0,0,0,(textSize.Width+20dip),tempView.Height)
		tempView.SetColorAndBorder(xui.Color_ARGB(150,0,0,0),0,xui.Color_Transparent,tempView.Height)
		#if b4i
		ImgCount.SetBorder(0,xui.Color_Transparent,ImgCount.Height/2)
		#End If
		tempView.Parent.SetVisibleAnimated(500,True)
		LblTimer.Enabled = False
		LblTimer.Enabled = True
	End If
End Sub

Private Sub UpdateDots
	Private shift As Int = dotSize+dotgap
	If (CurrentIndex = 5 Or CurrentIndex = dotCont.NumberOfViews -1 Or CurrentIndex = dotCont.NumberOfViews -6) And dotCont.GetView(CurrentIndex).Tag = "s" Then
		'shift = (shift/2)
	End If
	For i=0 To dotCont.NumberOfViews-1
		Private dot As B4XView = dotCont.GetView(i)
		Private dotCir As B4XView = dot.getview(0)
		dotCir.SetColorAndBorder(dotColor,0,xui.Color_Transparent,dotSize)
		
		If CurrentIndex > PrevIndex Then
			If dotCont.GetView(CurrentIndex).Tag = "s" Then
				
				If i = CurrentIndex Then
					SetActive(dot)
				Else If i = CurrentIndex-5 Or i = CurrentIndex+1 Then
					SetSmall(dot)
				Else If i < CurrentIndex-5 Or i > CurrentIndex+1 Then
					SetHidden(dot)
				Else
					SetDefault(dot)
				End If
				dot.SetLayoutAnimated(dotTransitionDuration,dot.left-shift,dot.top,dotSize,dotSize)
			Else
				If i = CurrentIndex Then
					SetActive(dot)
				Else if dot.tag = "b" Then
					SetDefault(dot)
				End If
			End If
		Else If CurrentIndex < PrevIndex Then
			If dotCont.GetView(CurrentIndex).tag = "s" Then
				If i = CurrentIndex Then
					SetActive(dot)
				Else If i = CurrentIndex-1 Or i = CurrentIndex+5 Then
					SetSmall(dot)
				Else If i < CurrentIndex-1 Or i > CurrentIndex+5 Then
					SetHidden(dot)
				Else
					SetDefault(dot)
				End If
				dot.SetLayoutAnimated(dotTransitionDuration,dot.left+shift,dot.top,dotSize,dotSize)
			Else
				If i = CurrentIndex Then
					SetActive(dot)
				Else if dot.tag = "b" Then
					SetDefault(dot)
				End If
			End If
		End If
	Next
	
	dotCont.GetView(CurrentIndex).Tag = "b"
End Sub

Private Sub SetActive(dot As B4XView)
	Private dotCir As B4XView = dot.GetView(0)
	dotCir.SetColorAndBorder(activeDotColor,0,xui.Color_Transparent,dotSize)
	dotCir.SetLayoutAnimated(dotTransitionDuration,0,0,dotSize,dotSize)
End Sub

Private Sub SetDefault(dot As B4XView)
	Private dotCir As B4XView = dot.GetView(0)
	dotCir.SetLayoutAnimated(dotTransitionDuration,(dotSize-dotSizeM)/2,(dotSize-dotSizeM)/2,dotSizeM,dotSizeM)
End Sub

Private Sub SetSmall(dot As B4XView)
	Private dotCir As B4XView = dot.GetView(0)
	dotCir.SetLayoutAnimated(dotTransitionDuration,(dotSize/2)-(dotSizeS/2),(dotSize/2)-(dotSizeS/2),dotSizeS,dotSizeS)
	dotCir.SetVisibleAnimated(dotTransitionDuration,True)
	
	dot.tag = "s"
End Sub

Private Sub SetHidden(dot As B4XView)
	Private dotCir As B4XView = dot.GetView(0)
	dotCir.SetLayoutAnimated(dotTransitionDuration,dotSize/2,dotSize/2,1,1)
	dotCir.SetVisibleAnimated(dotTransitionDuration,False)
	dot.tag = "h"
End Sub

Private Sub removeProgressView(i As B4XView)
	If i.GetView(i.NumberOfViews-1) Is Label Then
		Dim l As Label = i.GetView(i.NumberOfViews-1)
		#if b4a
			l.RemoveView
		#else if b4i
			l.RemoveViewFromParent
		#end if
	End If
	#if b4a
	If i.GetView(i.NumberOfViews-1) Is ProgressBar Then
		Dim p As ProgressBar = i.GetView(i.NumberOfViews-1)
		p.RemoveView
	#else if b4i
	If i.GetView(i.NumberOfViews-1) Is ActivityIndicator Then
		Dim p As ActivityIndicator = i.GetView(i.NumberOfViews-1)
		p.RemoveViewFromParent
	#End If
	End If
End Sub

#if b4i
Private Sub getPlayer(viewcontroller As VideoPlayer) As NativeObject
	Dim no As NativeObject = viewcontroller
	Return no.GetField("controller").GetField("player")
End Sub

Private Sub getPlayerController(viewcontroller As VideoPlayer) As NativeObject
	Dim no As NativeObject = viewcontroller
	Return no.GetField("controller")
End Sub
#End If

Private Sub ShowImage
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	Dim img As B4XBitmap
	
	If imagedata.ContainsKey("video") Then
		If imagedata.ContainsKey("player") = False Then
			removeProgressView(i)
			#if b4a
			Dim p As ProgressBar
			#else if b4i
			Dim p As ActivityIndicator
			#End If
			#if b4a
			p.Initialize("")
			p.Indeterminate = True
			#else if b4i
			p.Initialize
			p.Style = p.STYLE_WHITE
			#end if
			i.AddView(p,Imgcont.Width/2 - 20dip,Imgcont.height/2 - 20dip,40dip,40dip)
			
			#if b4a
			Private v As SimpleExoPlayer
			v.Initialize("vplayer")
			videoplayer.Add(CreateMap("id":CurrentIndex,"player":v))
			
			If imagedata.Get("type") = "file" Then v.Prepare(v.CreateLoopSource(v.CreateFileSource(imagedata.Get("video"),""),-1))
			If imagedata.Get("type") = "uri" Then v.Prepare(v.CreateLoopSource(v.CreateUriSource(imagedata.Get("video")),-1))
			If imagedata.Get("type") = "dash" Then v.Prepare(v.CreateLoopSource(v.CreateDashSource(imagedata.Get("video")),-1))
			If imagedata.Get("type") = "hls" Then v.Prepare(v.CreateLoopSource(v.CreateHLSSource(imagedata.Get("video")),-1))
			If imagedata.Get("type") = "smoothstream" Then v.Prepare(v.CreateLoopSource(v.CreateSmoothStreamingSource(imagedata.Get("video")),-1))
				
			If StartVideoMuted Then
				v.Volume = 0
			Else
				v.Volume = 1
			End If
				
			Dim vv As SimpleExoPlayerView = i.GetView(0)
			Select scale
					Case "FILL": vv.resizemode="ZOOM"
					Case "FIT": vv.resizemode="FIT"
					Case "STRETCH": vv.resizemode="FILL"
			End Select
			
			vv.Player=v
			vv.Tag = AutoPlayVideo
			#else if b4i
			
			Dim v As VideoPlayer = videoplayer.Get(CurrentIndex)
			v.ShowControls=False
			If imagedata.Get("type") = "file" Then
				v.LoadVideo(imagedata.Get("video"),"")
			Else
				v.LoadVideoUrl(imagedata.Get("video"))
			End If

			If StartVideoMuted Then
				Dim vol As Float = 0
			Else
				Dim vol As Float = 1
			End If
			getPlayer(v).SetField("volume", vol)
			
			Select scale
				Case "FILL": getPlayerController(v).setField("videoGravity","AVLayerVideoGravityResizeAspectFill")
				Case "FIT": getPlayerController(v).setField("videoGravity","AVLayerVideoGravityResizeAspect")
				Case "STRETCH": getPlayerController(v).setField("videoGravity","AVLayerVideoGravityResize")
			End Select
			v.BaseView.Tag = AutoPlayVideo
			#end if
			imagedata.Put("player",v)
		End If
		UpdatePlayback
	Else
		If imagedata.Get("image") Is String Then
			removeProgressView(i)
			
			#if b4a
			Dim p As ProgressBar
			#else if b4i
			Dim p As ActivityIndicator
			#End If
			#if b4a
			p.Initialize("")
			p.Indeterminate = True
			#else if b4i
			p.Initialize
			#end if
			i.AddView(p,Imgcont.Width/2 - 20dip,Imgcont.height/2 - 20dip,40dip,40dip)
			
			Dim j As HttpJob
			j.Initialize("",Me)
			j.Download(imagedata.Get("image"))
			Wait For (j) JobDone(j As HttpJob)
			#if b4a
			p.RemoveView
			#else if b4i
			p.RemoveViewFromParent
			#end if
			If j.Success Then
				Dim img As B4XBitmap = j.GetBitmap
				imagedata.Put("image",img)
				i.tag = imagedata
			End If
		Else
			Dim img As B4XBitmap = imagedata.Get("image")
		End If
		
		If i.GetView(i.NumberOfViews-1) Is Label Then
			Dim l As Label = i.GetView(i.NumberOfViews-1)
			#if b4a
			l.RemoveView
			#else if b4i
			l.RemoveViewFromParent
			#end if
		End If
		
		If img.IsInitialized Then
			
			
			#if b4a
			Dim JOo As JavaObject=i.GetView(0)
			JOo.RunMethod("setImageBitmap",Array(img))
			Select scale
				Case "FILL": JOo.RunMethod("setScaleType",Array("CENTER_CROP"))
				Case "FIT": JOo.RunMethod("setScaleType",Array("CENTER_INSIDE"))
				Case "STRETCH": JOo.RunMethod("setScaleType",Array("FIT_XY"))
			End Select
			#else if b4i
			Dim no As NativeObject=i.GetView(1)
			Dim iv As ImageView = i.GetView(1)
			Select scale
				Case "FILL": no.SetField("contentMode",2)
				Case "FIT": no.SetField("contentMode",1)
				Case "STRETCH": iv.ContentMode=iv.MODE_FILL
			End Select
			iv.Bitmap = img.Resize(ImgCont.Width,ImgCont.Height,True)
			#end if
			
			If CoverFreeSpace Then
				#if b4a
				Dim bo As JavaObject=Me
				Dim jc As JavaObject
				jc.InitializeContext
				img = bo.RunMethod("blur",Array(jc,img))
				i.SetBitmap(img.Resize(Imgcont.Width,Imgcont.Height,False))
				#else if b4i
				Dim no As NativeObject=Me
				img = no.RunMethod("blur:",Array(img))
				i.GetView(0).SetBitmap(img.Resize(ImgCont.Width,ImgCont.Height,False))
				#End If
			End If
		Else
			Dim tp As Label
			tp.Initialize("trypanel")
			i.AddView(tp,0,0,Imgcont.Width,Imgcont.Height)
			tp.Text = "Couldn't load the image. Tap to retry."
			tp.Color = Colors.White
			tp.TextColor = Colors.Black
			#if b4a
				tp.Gravity = Gravity.CENTER_HORIZONTAL+Gravity.CENTER_VERTICAL
				tp.TextSize = 15
			#else if b4i
				tp.TextAlignment = tp.ALIGNMENT_CENTER
				tp.Font = Font.CreateNew(15)
			#End If
		End If
	End If
End Sub

Private Sub trypanel_Click
	Dim l As Label = Sender
	#if b4a
	l.RemoveView
	#else if b4i
	l.RemoveViewFromParent
	#end if
	ShowImage
End Sub

#if b4a
Private Sub vplayer_Error (Message As String)
	Dim v As SimpleExoPlayer=Sender
	Dim index As Int=-1
	For Each player As Map In videoplayer
		If v = player.Get("player") Then index = player.get("id")
	Next
	If index > -1 Then
		Dim i As B4XView = ImgList.Get(index)
		Dim imagedata As Map = i.Tag
		
		imagedata.Remove("player")
		i.Tag = imagedata
		v.Release
		
		Log(Message)
		
		Dim tp As Label
		tp.Initialize("trypanel")
		i.AddView(tp,0,0,Imgcont.Width,Imgcont.Height)
		tp.Text = "Couldn't load the video. Tap to retry."
		tp.Color = Colors.White
		tp.TextColor = Colors.Black
		tp.Gravity = Gravity.CENTER_HORIZONTAL+Gravity.CENTER_VERTICAL
		tp.TextSize = 15
	End If
	
End Sub

Private Sub vplayer_Ready
	Dim v As SimpleExoPlayer=Sender
	Dim index As Int=-1
	For Each player As Map In videoplayer
		If v = player.Get("player") Then index = player.get("id")
	Next
	If index > -1 Then
		Dim i As B4XView = ImgList.Get(index)
		i.GetView(2).Visible=True
		If i.GetView(i.NumberOfViews-1) Is ProgressBar Then
			Dim p As ProgressBar = i.GetView(i.NumberOfViews-1)
			p.RemoveView
		End If
	End If
	UpdatePlayback
End Sub
#end if
#if b4i
Private Sub ximageslider_videoview_Ready (Success As Boolean)
	Dim v As NativeObject=Sender
	Dim i As B4XView = v.GetField("view").GetField("superview")
	i=i.Parent
	If Success Then
		removeProgressView(i)
		i.GetView(2).Visible=True
		UpdatePlayback
	Else
		Log("error")
		Dim tp As Label
		tp.Initialize("trypanel")
		i.AddView(tp,0,0,ImgCont.Width,ImgCont.Height)
		tp.Text = "Couldn't load the video. Tap to retry."
		tp.Color = Colors.White
		tp.TextColor = Colors.Black
		tp.TextAlignment = tp.ALIGNMENT_CENTER
		tp.Font = Font.CreateNew(15)
	End If
End Sub

Private Sub ximageslider_videoview_Complete
	Dim v As NativeObject=Sender
	Dim loopv As NativeObject = Me
	loopv.RunMethod("loopVideo:",Array(v.GetField("player")))
End Sub

#End If
#End Region

#Region UserFunctions
Public Sub setActivityHasActionBar(value As Boolean)
	actHasActionBar = value
	zoomfix
End Sub

'Set/Update items as a list to the slider along with the value as map you want to receive on tap events
'<b>Image item map format:</b>
'data: your data that will be returned on tap
'image: bitmap / url
'<b>Video item map format:</b>
'data: your data that will be returned on tap
'video: url / path (combined)
'type: file/uri/dash/hls/smoothstream
'Eg: <code>
'Dim items as list
'items.Initialize
''for image items
'items.Add(CreateMap("data":"your-data", "image":LoadBitmap(File.DirAssets,"localfile"))) 'for local image
'items.Add(CreateMap("data":"your-data", "image":"url of the image")) 'for remote image
''for video items
'items.Add(CreateMap("data":"your-data", "video":File.Combine(File.DirAssets,"localfile"), "type":"file")) 'for local video
'items.Add(CreateMap("data":"your-data", "video":"url of the video", "type":"file/uri/dash/hls/smoothstream")) 'for remote video
'</code>
Public Sub SetItems(imgs As List)
	videoplayer.Initialize
	CurrentIndex = 0
	dotCont.RemoveAllViews
	ImgList.Initialize
	#if b4a
	imgLayout.Initialize
	For Each img As Map In imgs
		
		Private i As B4XView = xui.CreatePanel("")

		Dim  tempi As Panel = xui.createPanel("")
		tempi.SetLayoutAnimated(0,0,0,Imgcont.Width,Imgcont.Height)
		tempi.addView(i,0,0,Imgcont.Width,Imgcont.Height)
		imgLayout.AddPage(tempi,"")
		
	#else if b4i
	ImgCont.Panel.RemoveAllViews
	Dim index As Int = 0
	For Each img As Map In imgs
		Private i As B4XView = xui.CreatePanel("")
		GD.RunMethod("gestureTap::",Array(1,i))'single & double
		GD.RunMethod("gesturePinch:",Array(i))
		i.Tag = img
		
		ImgCont.Panel.AddView(i,(ImgCont.Width * ImgList.Size),0,ImgCont.Width,ImgCont.Height)
	#end if
	
		If img.ContainsKey("video") Then
			i.LoadLayout("ximageslider_video")
			
			#if b4i
			videoplayer.Add(ximageslider_videoview)
			#End If
			Dim soundBtn As Panel = xui.CreatePanel("sound")
			i.AddView(soundBtn,0,0,45dip,45dip)
			
			Dim l As Label
			l.Initialize("")
			soundBtn.AddView(l,10dip,10dip,25dip,25dip)
			
			Dim b4xv As B4XView = l
			b4xv.TextSize=12
			b4xv.TextColor=Colors.White
			b4xv.Font = xui.CreateMaterialIcons(17)
			b4xv.SetColorAndBorder(xui.Color_ARGB(150,50,50,50),0,xui.Color_Transparent,b4xv.Height/2)
			b4xv.SetTextAlignment("CENTER","CENTER")
			
			If StartVideoMuted Then
				b4xv.Text = Chr(0xE04F)
			Else
				b4xv.Text = Chr(0xE050)
			End If
			
			Dim pbtn As B4XView=xui.CreatePanel("pbtn")
			i.AddView(pbtn,i.Width/2 - 30dip,i.height/2 - 30dip,60dip,60dip)
			pbtn.SetColorAndBorder(Colors.ARGB(150,50,50,50),0,xui.Color_Transparent,pbtn.Height/2)
			Dim pbl As Label
			pbl.Initialize("")
			Dim b4xv As B4XView = pbl
			b4xv.Text=Chr(0xE037)
			b4xv.font=xui.CreateMaterialIcons(40)
			b4xv.TextColor=Colors.White
			b4xv.Color=Colors.Transparent
			b4xv.SetTextAlignment("CENTER","CENTER")
			
			pbtn.AddView(pbl,0,0,pbtn.Width,pbtn.Height)
			pbtn.Visible=False
			
		Else
			#if b4a
			Private ii As ImageView:ii.Initialize("")
			#else if b4i
			videoplayer.Add("")
			Private itmp As ImageView
			itmp.Initialize("")
			i.AddView(itmp,0,0,ImgCont.Width,ImgCont.Height)
			
			Private iitmp As ImageView:iitmp.Initialize("")
			Private ii As B4XView = iitmp
			#End If
			i.AddView(ii,0,0,Imgcont.Width,Imgcont.Height)
		End If
		i.Color = FreeSpaceColor
		
		i.Tag = img
		ImgList.Add(i)
		#if b4i
		index=index+1
		#end if
	Next
	#if b4i
	ImgCont.ContentWidth = imgs.Size*ImgCont.width
	ImgCont.ScrollOffsetX = 0
	#else if b4a
	Imgcont.PageContainer = imgLayout
	#end if
	
	If ShowDots <> "HIDE" Then
		If imgs.Size > 1 Then
			Private dotStartX As Int = (dotCont.width/2) - ((((Min(6,imgs.Size)*dotSize) + (Min(6,imgs.Size)*dotgap))-dotgap)/2)
			For j=0 To imgs.Size-1
				Private p As B4XView = xui.CreatePanel("")
				Private size As Int = dotSizeM
				p.Tag = "b"
				If j=5 Then
					size = dotSizeS
					p.Tag = "s"
				else if j > 5 Then
					size = 0
					p.Tag = "h"
				End If
				
				dotCont.AddView(p,dotStartX + (j*(dotSize+dotgap)),((dotCont.Height/2)-(dotSize/2)),dotSize,dotSize)
				Private q As B4XView = xui.CreatePanel("")
				
				If j=0 Then
					q.SetColorAndBorder(activeDotColor,0,xui.Color_Transparent,dotSize)
					p.AddView(q,0,0,dotSize,dotSize)
				Else
					q.SetColorAndBorder(dotColor,0,xui.Color_Transparent,dotSize)
					p.AddView(q,(dotSize-size)/2,(dotSize-size)/2,size,size)
				End If
			Next
		End If
	End If
	
	ShowCount
	ShowImage
End Sub

'Set zoom panel (Usually Activity / Root panel) to enable the pinch zoom feature
Public Sub SetZoomPanel(ZoomPanelContainer As B4XView)
	ZoomContainer=ZoomPanelContainer
End Sub

'Show the next item
Public Sub ShowNext
	If CurrentIndex < ImgList.Size-1 Then
		SlideImage(CurrentIndex + 1)
	End If
End Sub

'Show the previous item
Public Sub ShowPrev
	If CurrentIndex > 0 Then
		SlideImage(CurrentIndex - 1)
	End If
End Sub

'Pause the current video item
Public Sub PauseCurrentVideo
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	If imagedata.ContainsKey("player") Then
		#if b4a
		Dim v As SimpleExoPlayer = imagedata.Get("player")
		v.pause
		#Else If b4i
		Dim v As VideoPlayer = imagedata.Get("player")
		Dim vo As NativeObject = getPlayer(imagedata.Get("player"))
		If vo.getField("timeControlStatus").AsNumber = 2 Then
			v.pause
		End If
		#End If
		i.GetView(2).Visible=True
		
		If xui.SubExists(mCallBack, mEventName & "_VideoPaused",1) Then
			CallSub2(mCallBack, mEventName & "_VideoPaused",CurrentIndex)
		End If
	End If
End Sub

'Play the current video item
Public Sub PlayCurrentVideo
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	If imagedata.ContainsKey("player") Then
		#if b4a
		Dim v As SimpleExoPlayer = imagedata.Get("player")
		v.play
		#Else If b4i
		Dim v As VideoPlayer = imagedata.Get("player")
		Dim vo As NativeObject = getPlayer(imagedata.Get("player"))
		If vo.getField("timeControlStatus").AsNumber = 0 Then
			v.Play
		End If
		#End If
		i.GetView(2).Visible=False
		
		If xui.SubExists(mCallBack, mEventName & "_VideoPlaying",1) Then
			CallSub2(mCallBack, mEventName & "_VideoPlaying",CurrentIndex)
		End If
	End If
End Sub

'Toggle mute of the current video item
Public Sub ToggleMute
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	If imagedata.ContainsKey("player") Then
		#if b4a
		Dim v As SimpleExoPlayer = imagedata.Get("player")
		If v.Volume = 0 Then
			v.Volume = 1
			i.GetView(1).GetView(0).Text = Chr(0xE050)
		Else
			v.Volume = 0
			i.GetView(1).GetView(0).Text = Chr(0xE04F)
		End If
		#Else If b4i
		Dim v As VideoPlayer = imagedata.Get("player")
		If getPlayer(v).GetField("volume").AsNumber = 0 Then
			Dim vol As Float=1
			i.GetView(1).GetView(0).Text = Chr(0xE050)
		Else
			Dim vol As Float=0
			i.GetView(1).GetView(0).Text = Chr(0xE04F)
		End If
		getPlayer(v).SetField("volume", vol)
		#End If
	End If
	
End Sub

'Update the current playback state
'Required to pause the playback on activity_pause / page_disappear
'And to resume the playback on activity_resume / page_appear
Public Sub UpdatePlayback
	Dim i As B4XView = ImgList.Get(CurrentIndex)
	Dim imagedata As Map = i.Tag
	If imagedata.ContainsKey("player") Then
		#if b4a
		Dim vv As SimpleExoPlayerView = i.getview(0)
		If vv.Tag Then
		#Else If b4i
		If i.getview(0).Tag Then
		#End If
			#if b4a
			Private location(2) As Int
			JO.RunMethod("getLocationInWindow",Array As Object(location))
			#Else if b4i
			Private NO As NativeObject = Me
			Private location(2) As Float = NO.ArrayFromPoint(NO.RunMethod("getLocationInWindow::",Array(ImgCont,i)))
			#End If
			If (location(1) - ZoomWindowFix) < 0 Or  (location(1) - ZoomWindowFix + mBase.Height) > GetDeviceLayoutValues.Height Then
				PauseCurrentVideo
			else If (location(1) - ZoomWindowFix) > 0 Or (location(1) - ZoomWindowFix + mBase.Height) < GetDeviceLayoutValues.Height Then
				PlayCurrentVideo
			End If
		End If
	End If
	
End Sub

#End Region


#If OBJC

-(void) loopVideo: (AVPlayer*) player{
	[player seekToTime:kCMTimeZero];
	[player play];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{return TRUE;}

-(void)gestureTap: (int)numtouch :(UIView*)v
{
	UITapGestureRecognizer *SingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	SingleTap.delegate=self;
	[SingleTap setNumberOfTapsRequired:1];
	[SingleTap setNumberOfTouchesRequired:numtouch];
	[v addGestureRecognizer:SingleTap];
	
	UITapGestureRecognizer *DoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	DoubleTap.delegate=self;
	[DoubleTap setNumberOfTapsRequired:2];
	[DoubleTap setNumberOfTouchesRequired:numtouch];
	[v addGestureRecognizer:DoubleTap];
	
	[SingleTap requireGestureRecognizerToFail:DoubleTap];
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    int numtouch =gestureRecognizer.numberOfTouchesRequired;
    int numtap =gestureRecognizer.numberOfTapsRequired;
	float x= [gestureRecognizer locationInView:(gestureRecognizer.view)].x;
	float y= [gestureRecognizer locationInView:(gestureRecognizer.view)].y;
    [self.bi raiseEvent:nil event:@"uigesture_tap::::" params:@[@((int)numtap),@((int)numtouch),@((float)x),@((float)y)]];

}  

-(void)gesturePinch :(UIView*)v
{
	UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePinch:)];
	pinch.delegate=self;
 	[v addGestureRecognizer:pinch];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer 
{  
	float x= [gestureRecognizer locationInView:(gestureRecognizer.view)].x;
	float y= [gestureRecognizer locationInView:(gestureRecognizer.view)].y;
	float sc=gestureRecognizer.scale;
	int st =gestureRecognizer.state;
    [self.bi raiseEvent:nil event:@"uigesture_pinch::::" params:@[@((float)sc),@((float)x),@((float)y),@((int)st)]];
}  

- (CGPoint) getLocationInWindow:(UIView*)contView :(UIView*)element{
 	CGPoint convertedPoint = [contView convertPoint:element.frame.origin toView:nil];
	return convertedPoint;
}
 
-(float) statusBarHeight
{
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return statusBarSize.height;
}

- (UIImage *)blur:(UIImage *)sourceImage{

    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
	
	CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
	CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
	[affineClampFilter setValue:[NSValue valueWithBytes:&xform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
	[affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
	CIImage *outputImage = [affineClampFilter valueForKey:kCIOutputImageKey];
	
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:outputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:7.5f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];

    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];

    UIImage *retVal = [UIImage imageWithCGImage:cgImage];

    if (cgImage) {
        CGImageRelease(cgImage);
    }

    return retVal;
}

#End If

#if java
import android.graphics.Bitmap;
import android.content.Context;
import android.renderscript.*;

public static Bitmap blur(Context context, Bitmap image) {
    int width = Math.round(image.getWidth() * 0.4f);
    int height = Math.round(image.getHeight() * 0.4f);

    Bitmap inputBitmap = Bitmap.createScaledBitmap(image, width, height,
        false);
    Bitmap outputBitmap = Bitmap.createBitmap(inputBitmap);

    RenderScript rs = RenderScript.create(context);
    ScriptIntrinsicBlur theIntrinsic = ScriptIntrinsicBlur.create(rs,
        Element.U8_4(rs));
    Allocation tmpIn = Allocation.createFromBitmap(rs, inputBitmap);
    Allocation tmpOut = Allocation.createFromBitmap(rs, outputBitmap);
    theIntrinsic.setRadius(7.5f);
    theIntrinsic.setInput(tmpIn);
    theIntrinsic.forEach(tmpOut);
    tmpOut.copyTo(outputBitmap);

    return outputBitmap;
}
#End If