B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'xRotaryTimeLimitbar CustomView
'
'Author Klaus CHRISTL
'
'Version 1.0

#Event: TimeChanged(Times() As String, TimeInterval As String)
#RaisesSynchronousEvents: TimeChanged(Times() As String, TimeInterval As String)

#DesignerProperty: Key: StartTime, DisplayName: StartTime, FieldType: String, DefaultValue: 08:00, Description: Start time
#DesignerProperty: Key: EndTime, DisplayName: EndTime, FieldType: String, DefaultValue: 16:00, Description: End time
#DesignerProperty: Key: EarliestStartTime, DisplayName: EarliestStartTime, FieldType: String, DefaultValue: 06:00, Description: Earliest start time.
#DesignerProperty: Key: LatestStartTime, DisplayName: LatestStartTime, FieldType: String, DefaultValue: 16:00, Description: Latest Start time.
#DesignerProperty: Key: EarliestEndTime, DisplayName: EarliestEndTime, FieldType: String, DefaultValue: 08:00, Description: Earliest end time.
#DesignerProperty: Key: LatestEndTime, DisplayName: LatestEndTime, FieldType: String, DefaultValue: 18:00, Description: Latest end time.
#DesignerProperty: Key: MinTimeInterval, DisplayName: MinTimeInterval, FieldType: Int, DefaultValue: 30, Description: Minimum time interval between start and end time in minutes.
#DesignerProperty: Key: MaxTimeInterval, DisplayName: MaxTimeInterval, FieldType: Int, DefaultValue: 960, Description: Maximum time interval between start and end time in minutes.
#DesignerProperty: Key: MinuteResolution, DisplayName: MinuteResolution, FieldType: String, DefaultValue: 5, List: 2|5|10|15|20|30|60, Description: Resolution of minutes.
#DesignerProperty: Key: CheckTimeSettingsOnlyToFuture, DisplayName: CheckTimeSettingsOnlyToFuture, FieldType: Boolean, DefaultValue: False, Description: Start and End times can only be set to the future.
#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Background color.
#DesignerProperty: Key: Mode24Hours, DisplayName: Mode24Hours, FieldType: Boolean, DefaultValue: True, Description: Time display mode; True = 24 hours; False = AM / PM .
#DesignerProperty: Key: NotUsedTimeColor, DisplayName: NotUsedTimeColor, FieldType: Color, DefaultValue: 0xFF242424, Description: Color of the ring outsides the possible work hours.
#DesignerProperty: Key: TimeIntervalColor, DisplayName: imeIntervalColor, FieldType: Color, DefaultValue: 0xFF008B8B, Description: Color of the ring between the two sliders.
#DesignerProperty: Key: OverTimeColor, DisplayName: OverTimeColor, FieldType: Color, DefaultValue: 0xFF0000FF, Description: Color of the ring overlapping zone of the two sliders.
#DesignerProperty: Key: SliderBeginColor, DisplayName: SliderBeginColor, FieldType: Color, DefaultValue: 0xFF32CD32, Description: Color of the begin time slider.
#DesignerProperty: Key: SliderBeginBitmapFileName, DisplayName: SliderBeginBitmapFileName, FieldType: String, DefaultValue: , Description: Begin slider bitmap file name.
#DesignerProperty: Key: SliderEndColor, DisplayName: SliderEndColor, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Color of the end time slider.
#DesignerProperty: Key: SliderEndBitmapFileName, DisplayName: SliderEndBitmapFileName, FieldType: String, DefaultValue: , Description: End slider bitmap file name.
#DesignerProperty: Key: TimeColor, DisplayName: TimeColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: TColor of the right upper and lower time display.
#DesignerProperty: Key: ScaleBackgroundColor, DisplayName: ScaleBackgroundColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the inner circle.
#DesignerProperty: Key: ScaleColor, DisplayName: ScaleColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of the scale and time in the inner circle.

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private pnlBackground As B4XView
	Private cvsBackground As B4XCanvas
	Private pnlSliders As B4XView
	Private cvsSliders As B4XCanvas
	Private bmcBackground, bmcSliders As BitmapCreator
	
	Private rectMain As B4XRect
	Private mTextBigFont, mTextScaleFont  As B4XFont
	Private bmpStart, bmpEnd As B4XBitmap
	
	Public SliderAngle(2) As Double
	Public SliderTimeMinutes(2) As Int
	Public SliderTime(2) As String
	Private TimeInterval As String
	Private SliderX(2), SliderY(2) As Int
	Private CurrentSliderIndex As Int
	
	Private mBackgroundColor, mNotUsedTimeColor, mTimeIntervalColor, mOverTimeColor, mSliderColor(2) , mSliderBeginColor, mSliderEndColor As Int
	Private mScaleBackgroundColor, mScaleColor As Int
	Private mStartTime, mEndTime, mEarliestStartTime, mLatestStartTime, mEarliestEndTime, mLatestEndTime, mMinTimeInterval, mMaxTimeInterval As Double
	Private mCheckTimeSettingsOnlyToFuture As Boolean
	Private mWidth As Int
	Private mTextScaleSize, mTextBigSize As Float
	Private mTextBigDelta, mTextScaleDelta As Int
	Private mTextBigHeight As Int
	Private mRadiusExt, mRadiusMid, mStrokeWidth, mStrokeWidth_2 As Int
	Private xc, yc, x0, y0 As Int
	Private mMinuteResolution As Int
	Private TimeNow As Double
	Private mSliderBeginBitmapFileName, mSliderEndBitmapFileName As String
	Private mSliderBitmaps As Boolean
	Private PM, mMode24Hours As Boolean
	Private Angle0, PrevAngle As Double
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	mMode24Hours = True
	mStartTime = ConvertTimeToAngle("08:00")
	mEndTime = ConvertTimeToAngle("16:00")
	mEarliestStartTime = ConvertTimeToAngle("06:00")
	mLatestStartTime = ConvertTimeToAngle("16:00")
	mEarliestEndTime = ConvertTimeToAngle("08:00")
	mLatestEndTime = ConvertTimeToAngle("18:00")
	mMinTimeInterval = 15
	mMaxTimeInterval = 480
	mMinuteResolution = 5
	mBackgroundColor = 0x00FFFFFF
	mNotUsedTimeColor = 0xFF242424
	mTimeIntervalColor = 0xFF008B8B
	mOverTimeColor = 0xFF0000FF
	mSliderBeginColor = 0xFF32CD32
	mSliderEndColor = 0xFFFF0000
	mSliderBitmaps = False
	mScaleBackgroundColor = 0xFF000000
	mScaleColor = 0xFFFFFFFF
	
	CurrentSliderIndex = -1
	mCheckTimeSettingsOnlyToFuture = False
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_White, 0)
	mWidth = Max(mBase.Width, mBase.Height)
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor", 0x00FFFFFF))
	If mBackgroundColor = 0x00FFFFFF Then
		mBackgroundColor = xui.Color_Transparent
	End If
	
	mMode24Hours = Props.GetDefault("Mode24Hours", True)
	mStartTime = ConvertTimeToAngle(Props.GetDefault("StartTime", "08:00"))
	mEndTime = ConvertTimeToAngle(Props.GetDefault("EndTime", "16:00"))
	mEarliestStartTime = ConvertTimeToAngle(Props.GetDefault("EarliestStartTime", "06:00"))
	mLatestStartTime = ConvertTimeToAngle(Props.GetDefault("LatestStartTime", "16:00"))
	mEarliestEndTime = ConvertTimeToAngle(Props.GetDefault("EarliestEndTime", "08:00"))
	mLatestEndTime = ConvertTimeToAngle(Props.GetDefault("LatestEndTime", "18:00"))
	mMinTimeInterval = Props.GetDefault("MinTimeInterval", 30) / 2
	mMaxTimeInterval = Props.GetDefault("MaxTimeInterval", 960) / 2
	mMinuteResolution = Props.GetDefault("MinuteResolution", 5)
	mCheckTimeSettingsOnlyToFuture = Props.GetDefault("CheckTimeSettingsOnlyToFuture", False)
	mNoneWorkTimeColor = xui.PaintOrColorToColor(Props.GetDefault("NoneWorkTimeColor", 0xFFA9A9A9))
	mNotUsedTimeColor = xui.PaintOrColorToColor(Props.GetDefault("NotUsedTimeColor", 0xFF424242))
	mTimeIntervalColor = xui.PaintOrColorToColor(Props.GetDefault("TimeIntervalColor", 0xFF008B8B))
	mOverTimeColor = xui.PaintOrColorToColor(Props.GetDefault("mOverTimeColor", 0xFF0000FF))
	mSliderBeginColor = xui.PaintOrColorToColor(Props.GetDefault("SliderBeginColor", 0xFF32CD32))
	mSliderColor(0) = mSliderBeginColor
	mSliderEndColor	 = xui.PaintOrColorToColor(Props.GetDefault("SliderEndColor", 0xFFFF0000))
	mSliderColor(1) = mSliderEndColor
	mSliderEndBitmapFileName = Props.GetDefault("SliderEndBitmapFileName", "")
	If mSliderBeginBitmapFileName <> "" And mSliderEndBitmapFileName <> "" Then
		mSliderBitmaps = True
	End If
	
	mScaleBackgroundColor	= xui.PaintOrColorToColor(Props.GetDefault("ScaleBackgroundColor", 0xFF000000))
	mScaleColor = xui.PaintOrColorToColor(Props.GetDefault("ScaleColor", 0xFFFFFFFF))

	Sleep(0)
#If B4A
	SetupTimeLimitbar
	ResizeLimitSeekbar
#End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mWidth = Max(Width, Height)
	If pnlBackground.IsInitialized = False Then
		SetupTimeLimitbar
		ResizeLimitSeekbar
	End If

'	ResizeLimitSeekbar
End Sub

Private Sub SetupTimeLimitbar
	pnlBackground = xui.CreatePanel("")
	mBase.AddView(pnlBackground, 0, 0, mWidth, mWidth)
	cvsBackground.Initialize(pnlBackground)
	bmcBackground.Initialize(mWidth, mWidth)

	pnlSliders = xui.CreatePanel("pnlSliders")
	mBase.AddView(pnlSliders, 0, 0, mWidth, mWidth)
	cvsSliders.Initialize(pnlSliders)
	bmcSliders.Initialize(mWidth, mWidth)	
End Sub

Private Sub ResizeLimitSeekbar
	mRadiusExt = mWidth / 2 - 4dip
	mWidth = 2 * mRadiusExt + 4dip

	mBase.Width = mWidth
	mBase.Height = mWidth

	pnlBackground.Width = mWidth
	pnlBackground.Height = mWidth
	cvsBackground.Resize(mWidth, mWidth)
	bmcBackground.Initialize(mWidth, mWidth)
	
	pnlSliders.Width = mWidth
	pnlSliders.Height = mWidth
	cvsSliders.Resize(mWidth, mWidth)
	bmcSliders.Initialize(mWidth, mWidth)
	
	xc = mWidth / 2
	yc = mWidth / 2
	
	mStrokeWidth = 0.3 * mRadiusExt
	mStrokeWidth_2 = mStrokeWidth / 2
	mRadiusMid = mRadiusExt - mStrokeWidth / 2

	mTextScaleSize = mWidth * 0.06 / xui.Scale
	mTextBigSize = mWidth * 0.08 / xui.Scale

	mTextScaleFont = xui.CreateDefaultBoldFont(mTextScaleSize)
	mTextBigFont = xui.CreateDefaultBoldFont(mTextBigSize)

	Private rect As B4XRect
	rect = cvsBackground.MeasureText("M", mTextScaleFont)
	mTextScaleDelta = rect.CenterY

	rect = cvsBackground.MeasureText("M", mTextBigFont)
	mTextBigDelta = rect.CenterY
	mTextBigHeight = rect.Height * 1.8
	
	DrawBackground
	
	SliderAngle(0) = mStartTime
	SliderX(0) = xc + mRadiusMid * SinD(SliderAngle(0))
	SliderY(0) = yc - mRadiusMid * CosD(SliderAngle(0))
	SliderAngle(1) = mEndTime
	SliderX(1) = xc + mRadiusMid * SinD(SliderAngle(1))
	SliderY(1) = yc - mRadiusMid * CosD(SliderAngle(1))
	
	If mSliderBitmaps Then
		GetSliderBitmaps
	End If
	
	CalcTimes
	DrawSliders
End Sub

'Add a xRotaryListbar onto a Panel / Pane
'Parent = Panel / Pane which gets the xRotaryListbar
'Left, Top and Width = position and width of xRotaryListbar, there is no Height property
'The xRotaryListbar costum view is a square, therefor no Height property
Public Sub AddToParent(Parent As B4XView, Left As Int, Top As Int, Width As Int)
	mBase = xui.CreatePanel("")
	Parent.AddView(mBase, Left, Top, Width, Width)
	
	mWidth = Width	
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_White, 0)
	SetupTimeLimitbar
	ResizeLimitSeekbar
End Sub

Private Sub pnlSliders_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case pnlSliders.TOUCH_ACTION_DOWN
			x0 = X
			y0 = Y
			If Abs(x0 - SliderX(1)) <= mStrokeWidth_2 And Abs(y0 - SliderY(1)) <= mStrokeWidth_2 Then
				CurrentSliderIndex = 1
				If SliderAngle(1) >= 0 Then
					PM = True
				Else
					PM = False
				End If
				PrevAngle = SliderAngle(1)
			Else If Abs(x0 - SliderX(0)) <= mStrokeWidth_2 And Abs(y0 - SliderY(0)) <= mStrokeWidth_2 Then
				CurrentSliderIndex = 0
				If SliderAngle(0) >= 0 Then
					PM = True
				Else
					PM = False
				End If
				PrevAngle = SliderAngle(0)
			Else
				CurrentSliderIndex = -1
			End If
			CalcNewCoordinates(X, Y)
		Case pnlSliders.TOUCH_ACTION_MOVE
			CalcNewCoordinates(X, Y)
		Case pnlSliders.TOUCH_ACTION_UP
			CurrentSliderIndex = -1
			DrawSliders
	End Select
End Sub

Private Sub CalcNewCoordinates(x As Int, y As Int)
	Private Index As Int
	Private aa As Double
	
	If CurrentSliderIndex > -1 Then
		aa = ATan2D((x - xc), (yc - y))
		Index = Floor(aa / mMinuteResolution * 2 + 0.5)
		aa = Index * mMinuteResolution / 2
		Angle0 = aa
		If PM = True Then
			If Angle0 < 0 Then
				aa = aa + 360
			End If
			If aa - PrevAngle <= -180 And y < yc Then
				aa = 360
			End If
			If Angle0 < 0 And PrevAngle = 0 And y < yc Then
				PM = False
				aa = Angle0
			End If
		Else
			If Angle0 > 0 And y > yc Then
				aa = aa - 360
			End If
			If aa - PrevAngle >= 180 And y < yc Then
				aa = -360
			End If
			If Angle0 > 0 And PrevAngle = 0 And y < yc Then
				PM = True
				aa = Angle0
			End If
		End If
		UpdateCoordinates(aa)
	End If
End Sub

Private Sub UpdateCoordinates(Angle As Double)
	If mCheckTimeSettingsOnlyToFuture Then
		Private strTimeNow As String
		Private TimeNow As Double
		strTimeNow = DateTime.Time(DateTime.Now)
		strTimeNow = strTimeNow.SubString2(0, strTimeNow.Length - 3)
		TimeNow = ConvertTimeToAngle(strTimeNow)
		TimeNow = Ceil(TimeNow / mMinuteResolution * 2) * mMinuteResolution / 2
	End If
	
	If CurrentSliderIndex = 0 Then
		If Angle >= mEarliestStartTime And Angle <= mLatestStartTime  Then
			If mCheckTimeSettingsOnlyToFuture And Angle < TimeNow Then
				Angle = TimeNow
			End If
			SliderAngle(0) = Angle
			SliderX(0) = xc + mRadiusMid * SinD(SliderAngle(0))
			SliderY(0) = yc - mRadiusMid * CosD(SliderAngle(0))
			If SliderAngle(1) - SliderAngle(0) < mMinTimeInterval Then
				SliderAngle(1) = SliderAngle(0) + mMinTimeInterval
				SliderX(1) = xc + mRadiusMid * SinD(SliderAngle(1))
				SliderY(1) = yc - mRadiusMid * CosD(SliderAngle(1))
			Else If SliderAngle(1) - SliderAngle(0) > mMaxTimeInterval Then
				SliderAngle(1) = SliderAngle(0) + mMaxTimeInterval
				SliderX(1) = xc + mRadiusMid * SinD(SliderAngle(1))
				SliderY(1) = yc - mRadiusMid * CosD(SliderAngle(1))
			End If
			CalcTimes
			DrawSliders
		End If
	Else If CurrentSliderIndex = 1 Then
		If Angle >= mEarliestEndTime And Angle <= mLatestEndTime Then
			If mCheckTimeSettingsOnlyToFuture And Angle < TimeNow + mMinTimeInterval Then
				Angle = TimeNow + mMinTimeInterval
			End If
			SliderAngle(1) = Angle
			SliderX(1) = xc + mRadiusMid * SinD(SliderAngle(1))
			SliderY(1) = yc - mRadiusMid * CosD(SliderAngle(1))
			If SliderAngle(1) - SliderAngle(0) < mMinTimeInterval Then
				SliderAngle(0) = SliderAngle(1) - mMinTimeInterval
				SliderX(0) = xc + mRadiusMid * SinD(SliderAngle(0))
				SliderY(0) = yc - mRadiusMid * CosD(SliderAngle(0))
			End If
			If SliderAngle(1) - SliderAngle(0) > mMaxTimeInterval Then
				SliderAngle(0) = SliderAngle(1) - mMaxTimeInterval
				SliderX(0) = xc + mRadiusMid * SinD(SliderAngle(0))
				SliderY(0) = yc - mRadiusMid * CosD(SliderAngle(0))
			End If
			CalcTimes
			DrawSliders
		End If
	End If
	PrevAngle = Angle
End Sub

Private Sub CalcTimes
	Private Hours, Minutes As Int
	Private WorkMinutes As Double
	
	For i = 0 To 1
		SliderTime(i) = ConvertAngleToTime(SliderAngle(i))
		SliderTimeMinutes(i) = 360 + (SliderAngle(i) + 180) * 2
	Next
	WorkMinutes = SliderTimeMinutes(1) - SliderTimeMinutes(0)
	Hours = Floor(WorkMinutes / 60)
	Minutes = Floor(WorkMinutes - Hours * 60)
	TimeInterval = NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False)
	If xui.SubExists(mCallBack, mEventName & "_TimeChanged", 2) Then
		CallSub3(mCallBack, mEventName & "_TimeChanged", SliderTime, TimeInterval)
	End If
End Sub

Private Sub DrawBackground
	cvsBackground.ClearRect(cvsBackground.TargetRect)

	bmcBackground.Initialize(mWidth, mWidth)
	rectMain.Initialize(0, 0, mWidth, mWidth)
	bmcBackground.DrawRect(rectMain, mBackgroundColor, True, 1dip)

	bmcBackground.DrawCircle(xc, yc, mRadiusExt, mNotUsedTimeColor, True, 1dip)
	bmcBackground.DrawArc(xc, yc, mRadiusExt, mNotUsedTimeColor, False, mStrokeWidth, mEarliestStartTime - 90, mLatestEndTime - mEarliestStartTime)
	
	Private xx, yy As Int
	xx = xc + mRadiusMid * SinD(mEarliestStartTime)
	yy = yc - mRadiusMid * CosD(mEarliestStartTime)
	bmcBackground.DrawCircle(xx, yy, mStrokeWidth_2, mNotUsedTimeColor, True , 1dip)
	xx = xc + mRadiusMid * SinD(mLatestEndTime)
	yy = yc - mRadiusMid * CosD(mLatestEndTime)
	bmcBackground.DrawCircle(xx, yy, mStrokeWidth_2, mNotUsedTimeColor, True , 1dip)
	
	bmcBackground.DrawCircle(xc, yc, mRadiusMid - mStrokeWidth_2, mScaleBackgroundColor, True , 1dip)

	DrawScale
	
	cvsBackground.DrawBitmap(bmcBackground.Bitmap, rectMain)
	DrawScaleNumbers
	
	cvsBackground.Invalidate
End Sub

Private Sub DrawScale
	Private i As Int
	Private x1, y1, r1, x2, y2, r2 As Int
	Private aa As Double
	
	r1 = mRadiusExt - mStrokeWidth
	r2 = r1 - 4dip
	For i = 0 To 59
		aa = i * 6
		x1 = xc + r1 * SinD(aa)
		y1 = yc + r1 * CosD(aa)
		x2 = xc + r2 * SinD(aa)
		y2 = yc + r2 * CosD(aa)
		bmcBackground.DrawLine(x1, y1, x2, y2, mScaleColor, 1dip)
	Next
	
	r2 = r2 - 2dip
	For i = 1 To 12
		aa = (i - 3) * 30
		x1 = xc + r1 * SinD(aa)
		y1 = yc + r1 * CosD(aa)
		x2 = xc + r2 * SinD(aa)
		y2 = yc + r2 * CosD(aa)
		bmcBackground.DrawLine(x1, y1, x2, y2, mScaleColor, 2dip)
	Next
End Sub

Private Sub DrawScaleNumbers
	Private i As Int
	Private x1, y1, r1 As Int
	Private aa As Double
	
	For i = 1 To 12
		aa = i * 30
		r1 = mRadiusExt * 0.57
		x1 = xc + r1 * SinD(aa) 
		y1 = yc - r1 * CosD(aa) - mTextScaleDelta
		cvsBackground.DrawText(i, x1, y1, mTextScaleFont, mScaleColor, "CENTER")
	Next
End Sub

Private Sub DrawSliders
	cvsSliders.ClearRect(rectMain)
	bmcSliders.DrawRect(rectMain, xui.Color_Transparent, True, 1dip)
	
	bmcSliders.DrawArc(xc, yc, mRadiusExt, mTimeIntervalColor , False, mStrokeWidth, SliderAngle(0) - 90, SliderAngle(1) - SliderAngle(0))
	If SliderAngle(1) - SliderAngle(0) > 360 Then
		bmcSliders.DrawArc(xc, yc, mRadiusExt, mOverTimeColor , False, mStrokeWidth, SliderAngle(0) - 90, SliderAngle(1) - SliderAngle(0) - 360)
	End If
	If mSliderBitmaps = False Then
		bmcSliders.DrawCircle(SliderX(0), SliderY(0), mStrokeWidth / 2, mSliderBeginColor, True, 1dip)
		bmcSliders.DrawCircle(SliderX(0), SliderY(0), mStrokeWidth / 2, xui.Color_RGB(245, 245, 245), False, 3dip)
		bmcSliders.DrawCircle(SliderX(1), SliderY(1), mStrokeWidth / 2, mSliderEndColor, True, 1dip)
		bmcSliders.DrawCircle(SliderX(1), SliderY(1), mStrokeWidth / 2, xui.Color_RGB(245, 245, 245), False, 3dip)
	End If
	cvsSliders.DrawBitmap(bmcSliders.Bitmap, rectMain)
	
	If mSliderBitmaps = True Then
		Private rect As B4XRect
		rect.Initialize(SliderX(0) - mStrokeWidth_2, SliderY(0) - mStrokeWidth_2, SliderX(0) + mStrokeWidth_2, SliderY(0) + mStrokeWidth_2)
		cvsSliders.DrawBitmap(bmpStart, rect)
		rect.Initialize(SliderX(1) - mStrokeWidth_2, SliderY(1) - mStrokeWidth_2, SliderX(1) + mStrokeWidth_2, SliderY(1) + mStrokeWidth_2)
		cvsSliders.DrawBitmap(bmpEnd, rect)
	End If
	
	cvsSliders.DrawText(SliderTime(0), xc, yc - mTextBigHeight - mTextBigDelta, mTextBigFont, mSliderBeginColor, "CENTER")
	cvsSliders.DrawText(TimeInterval, xc, yc - mTextBigDelta, mTextBigFont, mScaleColor, "CENTER")
	cvsSliders.DrawText(SliderTime(1), xc, yc + mTextBigHeight - mTextBigDelta, mTextBigFont, mSliderEndColor, "CENTER")

	cvsSliders.DrawCircle(xc, yc, mRadiusExt - mStrokeWidth, xui.Color_White, False, 1dip)
	cvsSliders.DrawCircle(xc, yc, mRadiusExt, xui.Color_White, False, 1dip)

	cvsSliders.Invalidate
End Sub

'Converts a time given by HH:MM into the number of minutes
'Examples: 
'"15:00" returns 900
'"03:00 PM" returns 900
Public Sub ConvertTimeToMinutes(Time As String) As Int
	Private str(2) As String
	
	str = Regex.Split(":", Time)
	If str(1).Length = 2 Then
		Return str(0) * 60 + str(1)
	Else
		Private Hours, Minutes As Int
		Minutes = str(1).SubString2(6, 8)
		If str(1).SubString2(8, 9) = "P" Then
			Hours = Hours + 12
		End If
		Return str(0) * 60 + Minutes
	End If
End Sub

'Converts the number of minutes into a time string
'Example: it depends on the Mode24Hours proprty
'900 returns "15:00"
'900 returns "03:00 PM"
Public Sub ConvertMinutesToTime(Minutes As Int) As String
	Private Hours As Int
	Hours = Floor(Minutes / 60)
	Minutes = Minutes - Hours * 60
	If mMode24Hours = True Then
		Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False)
	Else
		If Hours > 12 Then
			Hours = Hours - 12
			If Hours = 0 Then
				Hours = 12
			End If
			Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False) & " PM"
		Else
			Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False) & " AM"
		End If
	End If
End Sub

'Converts a time given by HH:MM into the internal Angle of the slider
'Example: "08:00" or "08:08 AM" returns -120°
Public Sub ConvertTimeToAngle(Time As String) As Double
	Private str(2) As String
	Private Angle As Double
	Private Hours, Minutes As Int
	
	str = Regex.Split(":", Time)
	Hours = str(0)
	If str(1).Length = 2 Then
		Angle = (str(0) * 60 + str(1)) / 2 - 360
	Else
		Hours = str(0)
		If Hours = 0 Then
			Hours = 0
		End If
		Minutes = str(1).SubString2(6, 8)
		If str(1).SubString2(8, 9) = "P" Then
			Hours = Hours + 12
		End If
		Angle = (Hours * 60 + Minutes) / 2 - 360
	End If
	Return Angle
End Sub

'Converts the internal Angle of the slider into a time given by HH:MM 
'Example: -120° returns "08:00" or "08:08 AM" depending on the Mode24Hours property
Public Sub ConvertAngleToTime(Angle As Double) As String
	Private AngleMinute, Minutes, Hours As Int
	
	AngleMinute = Angle * 2 + 720
	Hours = Floor(AngleMinute / 60)
	Minutes = AngleMinute - Hours * 60
	If mMode24Hours = True Then
		Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False)
	Else
		If Hours > 12 Then
			Hours = Hours - 12
			If Hours = 0 Then
				Hours = 12
			End If
			Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False) & " PM"
		Else
			Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False) & " AM"
		End If
	End If
End Sub

'Convert a time string from 24 hours to AM/PM
Public Sub Convert24ToAMPM(Time As String) As String
	Private str(1) As String
	Private Hours, Minutes As Int
	
	If Time.Length < 6 Then
		Log("Wrong time fromat: " & Time)
		Return Time
	End If

	str = Regex.Split(":", Time)
	Hours = str(0)
	Minutes = str(1)
	If Hours > 12 Then
		Hours = Hours - 12
		If Hours = 0 Then
			Hours = 12
		End If
		Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False) & " PM"
	Else
		Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False) & " AM"
	End If
End Sub

'Convert a time string from AM/PM to 24 hours
Public Sub ConvertAMPMTo24(Time As String) As String
	Private str(1) As String
	Private Hours, Minutes As Int
	
	If Time.Length < 7 Then
		Log("Wrong time fromat: " & Time)
		Return Time
	End If
	
	str = Regex.Split(":", Time)
	Hours = str(0)
	Minutes = str(1).SubString2(6, 8)

	If Hours = 12 Then
		Hours = 0
	End If
	If str(1).SubString2(8, 9) = "P" Then
		Hours = Hours + 12
	End If
	
	Return NumberFormat2(Hours, 2, 0, 0, False) & ":" & NumberFormat2(Minutes, 2, 0, 0, False)
End Sub

Private Sub GetSliderBitmaps
	bmpStart = xui.LoadBitmapResize(File.DirAssets, mSliderBeginBitmapFileName, mStrokeWidth, mStrokeWidth, True)
	bmpEnd = xui.LoadBitmapResize(File.DirAssets, mSliderEndBitmapFileName, mStrokeWidth, mStrokeWidth, True)
End Sub

'Sets or get the Left property
Public Sub setLeft(Left As Int)
	mBase.Left = Left
End Sub

Public Sub getLeft As Int
	Return mBase.Left
End Sub

'Sets or get the Top property
Public Sub setTop(Top As Int)
	mBase.Top = Top
End Sub

Public Sub getTop As Int
	Return mBase.Top
End Sub

'Sets or get the Width property
Public Sub setWidth(Width As Int)
	mBase.Width = Width
	If pnlBackground.IsInitialized Then
		
		DrawBackground
	End If
	End Sub

Public Sub getWidth As Int
	Return mBase.Width
End Sub

'Sets or get the StartTime property
'Example: "07:30"
Public Sub setStartTime(StartTime As String)
	mStartTime = ConvertTimeToAngle(StartTime)
'	mStartTime = Floor(mStartTime / mMinuteResolution * 2) * mMinuteResolution / 2	'rounds downwards
'	mStartTime = Floor(mStartTime / mMinuteResolution * 2 + 0.5) * mMinuteResolution / 2  'rounds around the middle
	mStartTime = Ceil(mStartTime / mMinuteResolution * 2) * mMinuteResolution / 2  'rounds upwards
	If pnlBackground.IsInitialized Then
		CurrentSliderIndex = 0
		UpdateCoordinates(mStartTime)
		CalcTimes
		CurrentSliderIndex = -1
		DrawSliders
	End If
End Sub

Public Sub getStartTime As String
	Return ConvertAngleToTime(mStartTime)
End Sub

'Sets or get the EarliestStartTime property
'It is the earliest start time, the slider will stop at this time
'Example: "07:30" or "07:30 AM" 
Public Sub setEarliestStartTime(EarliestStartTime As String)
	mEarliestStartTime = ConvertTimeToAngle(EarliestStartTime)
	If pnlBackground.IsInitialized Then
		CalcTimes
		DrawSliders
	End If
End Sub

Public Sub getEarliestStartTime As String
	Return ConvertAngleToTime(mEarliestStartTime)
End Sub

'Sets or get the LatestStartTime property
'It is the latest start time, the slider will stop at this time
'Example: "18:30" 0t "06:30 PM" 
Public Sub setLatestStartTime(LatestStartTime As String)
	mLatestStartTime = ConvertTimeToAngle(LatestStartTime)
	If pnlBackground.IsInitialized Then
		CalcTimes
		DrawSliders
	End If
End Sub

Public Sub getLatestStartTime As String
	Return ConvertAngleToTime(mLatestStartTime)
End Sub

'Sets or get the EndTime property
'Example: "15:30"
Public Sub setEndTime(EndTime As String)
	mEndTime = ConvertTimeToAngle(EndTime)
'	mEndTime = Floor(mEndTime / mMinuteResolution * 2) * mMinuteResolution / 2	'rounds dowwards
'	mEndTime = Floor(mEndTime / mMinuteResolution * 2 + 0.5) * mMinuteResolution / 2  'rounds um den Mittelwert
	mEndTime = Ceil(mEndTime / mMinuteResolution * 2) * mMinuteResolution / 2  'rounds upwards
	If pnlBackground.IsInitialized Then
		CurrentSliderIndex = 1
		UpdateCoordinates(mEndTime)
		CurrentSliderIndex = -1
		DrawSliders
	End If
End Sub

Public Sub getEndTime As String
	Return ConvertAngleToTime(mEndTime)
End Sub

'Sets or get the EarliestEndTime property
'It is the earliest end time, the slider will stop at this time
'Example: "9:30" or "9:30 PM"
Public Sub setEarliestEndTime(EarliestEndTime As String)
	mEarliestEndTime = ConvertTimeToAngle(EarliestEndTime)
	If pnlBackground.IsInitialized Then
		CalcTimes
		DrawSliders
	End If
End Sub

Public Sub getEarliestEndTime As String
	Return ConvertAngleToTime(mEarliestEndTime)
End Sub

'Sets or get the setLatestEndTime property
'It is the latest end time, the slider will stop at this time
'Example: "21:30" or "09:30 PM"
Public Sub setLatestEndTime(LatestEndTime As String)
	mLatestEndTime = ConvertTimeToAngle(LatestEndTime)
	If pnlBackground.IsInitialized Then
		CalcTimes
		DrawSliders
	End If
End Sub

Public Sub getLatestEndTime As String
	Return ConvertAngleToTime(mLatestEndTime)
End Sub

'Sets or get the MinTimeInterval property
'Minimum time interval between the Start and End times, in minutes
'The End time cannot be smaller than the Start time + MinTimeInterval
Public Sub setMinTimeInterval(MinTimeInterval As Int)
	mMinTimeInterval = MinTimeInterval / 2
End Sub

Public Sub getMinWorktime As Int
	Return mMinTimeInterval * 2
End Sub

'Sets or get the MaxTimeInterval property
'Maximum time interval between the Start and End times, in minutes
'The End time cannot be higher than the Start time + MaxTimeInterval
Public Sub setMaxTimeInterval(MaxTimeInterval As Int)
	mMaxTimeInterval = MaxTimeInterval / 2
End Sub

Public Sub getMaxTimeInterval As Int
	Return mMaxTimeInterval * 2
End Sub

Public Sub SetStartAndEndTimesToFuture
	mCheckTimeSettingsOnlyToFuture = True
	Private strTimeNow As String
	strTimeNow = DateTime.Time(DateTime.Now)
	strTimeNow = strTimeNow.SubString2(0, strTimeNow.Length - 3)
	mStartTime = ConvertTimeToAngle(strTimeNow)
	mStartTime = Ceil(mStartTime / mMinuteResolution * 2) * mMinuteResolution / 2
	mLatestStartTime = 180 - mMinuteResolution
	CurrentSliderIndex = 0
	UpdateCoordinates(mStartTime)
	mEndTime = mStartTime + mMinTimeInterval
	CurrentSliderIndex = 1
	UpdateCoordinates(mEndTime)
	CurrentSliderIndex = -1
	DrawSliders
End Sub

'Sets or get the MinuteResolution property
'These are the stpes of the Sliders mouvements
'Valid values are 2, 5, 10, 15, 20, 30
Public Sub setMinuteResolution(MinuteResolution As Int)
	Select MinuteResolution
		Case 2, 5, 10, 15, 20, 30
			mMinuteResolution = MinuteResolution
		Case Else
			Log("Wrong value: " & MinuteResolution & " only 2, 5, 10, 15, 20, 30 are accepted")
	End Select
End Sub

Public Sub getMinuteResolution As Int
	Return mMinuteResolution
End Sub

'Sets or get the BackgroundColor property
Public Sub setBackgroundColor(BackgroundColor As Int)
	mBackgroundColor = BackgroundColor
	If pnlBackground.IsInitialized Then
		DrawBackground
	End If
End Sub

Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

'Sets or get the NotUsedTimeColor property
'Color of the ring outrides the sliders when the time between the sliders is less than 12 hours
Public Sub setNotUsedTimeColor(NotUsedTimeColor As Int)
	mNotUsedTimeColor = NotUsedTimeColor
	If pnlBackground.IsInitialized Then
		DrawBackground
		DrawSliders
	End If
End Sub

Public Sub getNotUsedTimeColor As Int
	Return mNotUsedTimeColor
End Sub

'Sets or get the TimeIntervalColor property
'Color of the ring between the two sliders
Public Sub setTimeIntervalColor(TimeIntervalColor As Int)
	mTimeIntervalColor = TimeIntervalColor
End Sub

Public Sub getTimeIntervalColor As Int
	Return mTimeIntervalColor
End Sub

'Sets or get the OverTimeColor property
'Color of the ring of the overlapping zone between the two sliders when the time between them is higher than 12 hours
Public Sub setOverTimeColor(OverTimeColor As Int)
	mOverTimeColor = OverTimeColor
End Sub

Public Sub getOverTimeColor As Int
	Return mOverTimeColor
End Sub

'Sets or get the SliderBeginColor property
'Color of the begin time slider
Public Sub setSliderBeginColor(SliderBeginColor As Int)
	mSliderBeginColor = SliderBeginColor
	If pnlBackground.IsInitialized Then
		DrawSliders
	End If
End Sub

Public Sub getSliderBeginColor As Int
	Return mSliderBeginColor
End Sub

'Sets or get the SliderEndColor property
'Color of the end time slider
Public Sub setSliderEndColor(SliderEndColor As Int)
	mSliderEndColor = SliderEndColor
	If pnlBackground.IsInitialized Then
		DrawSliders
	End If
End Sub

Public Sub getSliderEndColor As Int
	Return mSliderEndColor
End Sub

Public Sub SetSliderBitmapFileNames(SliderBeginBitmapFileName As String, SliderEndBitmapFileName As String)
'	If File.Exists(File.DirAssets, SliderBeginBitmapFileName) And File.Exists(File.DirAssets, SliderEndBitmapFileName)Then
		mSliderBeginBitmapFileName = SliderBeginBitmapFileName
		mSliderEndBitmapFileName = SliderEndBitmapFileName
		mSliderBitmaps = True
		GetSliderBitmaps
'	Else
'		Log("One or the two files do not Exist")
'	End If
	If pnlBackground.IsInitialized Then
		DrawSliders
	End If
End Sub

'Sets or get the ScaleBackgroundColor property
'Color of the inner circle
Public Sub setScaleBackgroundColor(ScaleBackgroundColor As Int)
	mScaleBackgroundColor = ScaleBackgroundColor
	If pnlBackground.IsInitialized Then
		DrawBackground
		DrawSliders
	End If
End Sub

Public Sub getScaleBackgroundColor As Int
	Return mScaleBackgroundColor
End Sub

'Sets or get the ScaleColor property
'Color of the scale and time in the inner circle
Public Sub setScaleColor(ScaleColor As Int)
	mScaleColor = ScaleColor
	If pnlBackground.IsInitialized Then
		DrawBackground
		DrawSliders
	End If
End Sub

Public Sub getScaleColor As Int
	Return mScaleColor
End Sub

'Sets or get the Mode24Hours property
'True = 24 hours time display
'False = AM / PM time display
Public Sub setMode24Hours(Mode24Hours As Boolean)
	If mMode24Hours = Mode24Hours Then
		Return
	End If
	
	mMode24Hours = Mode24Hours
	If pnlBackground.IsInitialized Then
		SliderTime(0) = ConvertAngleToTime(mStartTime)
		SliderTime(1) = ConvertAngleToTime(mEndTime)
		DrawSliders
	End If
End Sub

Public Sub getMode24Hours As Boolean
	Return mMode24Hours
End Sub

'Sets or gets the Visible property
Public Sub setVisible(Visible As Boolean)
	mBase.Visible = Visible
End Sub

Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub
