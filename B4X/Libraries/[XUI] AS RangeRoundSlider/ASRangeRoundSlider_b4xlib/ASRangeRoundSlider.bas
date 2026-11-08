B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
'ASRangeRoundSlider
'Author: Alexander Stolte
#If Documentation
V1.00
	-Release
V1.01
	-Add an icon gap
	-The connection between 2 points is now better calculated
	-The button that is pressed is moved to the foreground and does not disappear when you hover over the other button
	-Removed RollOver Property
V1.02
	-Add get and set MinValue
	-Add get and set MaxValue
V1.03
	-Add OverScrollMultiplier - The value multiplies the max value when you have scrolled over step by step
	-Add get and set CurrentOverScrollMultiplier1 - This value adjusts internally when the "OverScrollMultiplier" is greater than 1
		-Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier
	-Add get and set CurrentOverScrollMultiplier2 - This value adjusts internally when the "OverScrollMultiplier" is greater than 1
		-Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier
V1.04
	-B4A BugFix
V1.05
	-BugFix - Value1 and Value2 were connected in the wrong direction
	-Add get and set Steps - In how many steps does the slider move
		-Default: 1
	-Add Designer Property HapticFeedback
		-Default: False
V1.06
	-Add Event TouchDown
	-Add Event TouchUp
#End If

#DesignerProperty: Key: InnerCircleColor, DisplayName: Inner Circle Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ReachedColor, DisplayName: Reached Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: UnreachedColor, DisplayName: Unreached Color, FieldType: Color, DefaultValue: 0xFFA9A9A9
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ThumbCornerColor, DisplayName: Thumb Corner Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: StrokeWidth, DisplayName: Stroke Width, FieldType: Int, DefaultValue: 40
#DesignerProperty: Key: ThumbCornerWidth, DisplayName: Thumb Corner Width, FieldType: Int, DefaultValue: 4, MinRange: 2
#DesignerProperty: Key: Min, DisplayName: Minimum, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: Max, DisplayName: Maximum, FieldType: Int, DefaultValue: 100
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: False

#Event: ValueChanged (Value1 As Int,Value2 As Int)
#Event: TouchDown
#Event: TouchUp

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cvs As B4XCanvas
	Private mValue1 As Int = 20
	Private mValue2 As Int = 60
	Private mMin, mMax As Int
	'Private thumb As B4XBitmap
	Private pnl As B4XView
	Private CircleRect As B4XRect
	
	Private mStrokeWidth As Int
	Private ThumbSize As Int
	Public Tag As Object
	
	Private mReachedColor As Int
	Private mUnreachedColor As Int
	Private mThumbBorderColor As Int
	Private mThumbInnerColor As Int
	Private mInnerCircleColor As Int
	Private mSteps As Int = 1
	Private mHapticFeedback As Boolean

	Private mThumbCornerWidth As Float
	Private mTouchIsRight As Boolean = False
	
	Private mIcon1 As B4XBitmap = Null
	Private mIcon2 As B4XBitmap = Null
	
	Private xpnl_Thumb_1 As B4XView
	Private xpnl_Thumb_2 As B4XView
	Private xiv_ThumbIcon_1 As B4XView
	Private xiv_ThumbIcon_2 As B4XView
	
	Private mOverScrollMultiplier As Int = 1
	
	Private mCurrentOverScrollMultiplier1,mCurrentOverScrollMultiplier2 As Int = 1
	
	Private OldAngle1,OldAngle2 As Int
	
	Private TouchedPanel1 As Boolean = True
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	cvs.Initialize(mBase)
	mMin = Props.Get("Min")
	mMax = Props.Get("Max")
	mValue1 = mMin
	mValue2 = mMin
	pnl = xui.CreatePanel("pnl")
	xpnl_Thumb_1 = xui.CreatePanel("")
	xpnl_Thumb_2 = xui.CreatePanel("")
	mReachedColor = xui.PaintOrColorToColor(Props.Get("ReachedColor"))
	mUnreachedColor = xui.PaintOrColorToColor(Props.Get("UnreachedColor"))
	mThumbBorderColor = xui.PaintOrColorToColor(Props.Get("ThumbColor"))
	mThumbInnerColor = xui.PaintOrColorToColor(Props.Get("ThumbCornerColor"))
	mInnerCircleColor = xui.PaintOrColorToColor(Props.Get("InnerCircleColor"))
	mStrokeWidth = DipToCurrent(Props.GetDefault("StrokeWidth", 40))
	mThumbCornerWidth = DipToCurrent(Props.GetDefault("ThumbCornerWidth", 4))
	mHapticFeedback = Props.GetDefault("HapticFeedback",False)
	mBase.AddView(xpnl_Thumb_1, 0, 0, mStrokeWidth, mStrokeWidth)
	mBase.AddView(xpnl_Thumb_2, 0, 0, mStrokeWidth, mStrokeWidth)
	mBase.AddView(pnl, 0, 0, 0, 0)
	
	xpnl_Thumb_1.BringToFront
	
	Dim tmp_iv As ImageView : tmp_iv.Initialize("") : xiv_ThumbIcon_1 = tmp_iv
	Dim tmp_iv As ImageView : tmp_iv.Initialize("") : xiv_ThumbIcon_2 = tmp_iv
	#If B4I
	tmp_iv.UserInteractionEnabled = False
	xpnl_Thumb_1.As(Panel).UserInteractionEnabled = False
	xpnl_Thumb_2.As(Panel).UserInteractionEnabled = False
	xiv_ThumbIcon_1.As(ImageView).UserInteractionEnabled = False
	xiv_ThumbIcon_2.As(ImageView).UserInteractionEnabled = False
	#Else if B4J
	Dim jo As JavaObject = xpnl_Thumb_1
	jo.RunMethod("setMouseTransparent", Array(True))
	Dim jo As JavaObject = xpnl_Thumb_2
	jo.RunMethod("setMouseTransparent", Array(True))
	#End If
	
	xpnl_Thumb_1.AddView(xiv_ThumbIcon_1,0,0,0,0)
	xpnl_Thumb_2.AddView(xiv_ThumbIcon_2,0,0,0,0)
	
	CreateThumb
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub CreateThumb
'	Dim bc As BitmapCreator
'	bc.Initialize(mStrokeWidth / xui.Scale,mStrokeWidth / xui.Scale)
'	bc.DrawCircle(mStrokeWidth/2,mStrokeWidth/2,mStrokeWidth/2,mThumbInnerColor, True, 0)
'	'bc.DrawCircle(mStrokeWidth/2,mStrokeWidth/2,mStrokeWidth/2,mThumbBorderColor, False, mThumbCornerWidth)
'	If mIcon1.IsInitialized = True And mIcon1 <> Null Then
'		'cvs.DrawBitmap(mIcon1,dest)
'		Dim Rect As B4XRect
'		Rect.Initialize(1dip,1dip,mStrokeWidth,mStrokeWidth)
'		bc.DrawBitmap(mIcon1,Rect,False)
'	End If
'	
'	thumb = bc.Bitmap
'	ThumbSize = thumb.Height/2
	xpnl_Thumb_1.SetColorAndBorder(mThumbInnerColor,mThumbCornerWidth,mThumbBorderColor,mStrokeWidth/2)
	xpnl_Thumb_2.SetColorAndBorder(mThumbInnerColor,mThumbCornerWidth,mThumbBorderColor,mStrokeWidth/2)
	ThumbSize = mStrokeWidth/2
	
	If mIcon1.IsInitialized = True And mIcon1 <> Null Then
		xiv_ThumbIcon_1.SetBitmap(mIcon1.Resize(xiv_ThumbIcon_1.Width,xiv_ThumbIcon_1.Height,True))
	End If
	If mIcon2.IsInitialized = True And mIcon2 <> Null Then
		xiv_ThumbIcon_2.SetBitmap(mIcon2.Resize(xiv_ThumbIcon_2.Width,xiv_ThumbIcon_2.Height,True))
	End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	pnl.SetLayoutAnimated(0, 0, 0, Width, Height)
	xpnl_Thumb_1.SetLayoutAnimated(0,xpnl_Thumb_1.Left,xpnl_Thumb_1.Top,mStrokeWidth,mStrokeWidth)
	xpnl_Thumb_2.SetLayoutAnimated(0,xpnl_Thumb_2.Left,xpnl_Thumb_2.Top,mStrokeWidth,mStrokeWidth)
	
	Dim ThumbGap As Float = 4dip
	
	xiv_ThumbIcon_1.SetLayoutAnimated(0,ThumbGap,ThumbGap,mStrokeWidth - ThumbGap*2,mStrokeWidth - ThumbGap*2)
	xiv_ThumbIcon_2.SetLayoutAnimated(0,ThumbGap,ThumbGap,mStrokeWidth - ThumbGap*2,mStrokeWidth - ThumbGap*2)
	CircleRect.Initialize(mStrokeWidth/2,mStrokeWidth/2,Width - mStrokeWidth/2,Height - mStrokeWidth/2)
	Draw
End Sub
'Draws the view new
Public Sub Draw
	cvs.ClearRect(cvs.TargetRect)
	Dim radius As Int = CircleRect.Width / 2
	cvs.DrawCircle(CircleRect.CenterX, CircleRect.CenterY, radius, mUnreachedColor , False, mStrokeWidth)
	Dim p As B4XPath
'	Dim angle1 As Int = (mValue1 - mMin) / (mMax - mMin) * 360
'	Dim angle2 As Int = (mValue2 - mMin) / (mMax - mMin) * 360
	
	Dim angle1 As Int = (mValue1 - (mValue1 Mod mSteps) - mMin) / (mMax - mMin) * 360
	Dim angle2 As Int = (mValue2 - (mValue2 Mod mSteps) - mMin) / (mMax - mMin) * 360
	

	'p.InitializeArc(CircleRect.CenterX, CircleRect.CenterY,IIf(xui.IsB4J,mBase.Width/2,radius + mStrokeWidth/2), angle2-90,IIf(angle2 < angle1,angle1-angle2,360-angle2+angle1))
	p.InitializeArc(CircleRect.CenterX, CircleRect.CenterY,IIf(xui.IsB4J,mBase.Width/2,radius + mStrokeWidth/2), angle2-90,IIf(angle1 < angle2,angle1-angle2,0-angle2+angle1))
	cvs.DrawPath(p, mReachedColor, True, 40dip)

	cvs.DrawCircle(CircleRect.CenterX, CircleRect.CenterY, radius - mStrokeWidth/2, mInnerCircleColor, True, 0)
	
	'Dim dest As B4XRect
	Dim r As Int = mBase.Height/2 - mStrokeWidth/2
	Dim cx1 As Int = CircleRect.CenterX + r * CosD(angle1-90)
	Dim cy1 As Int = CircleRect.CenterY + r * SinD(angle1-90)
	
	Dim cx2 As Int = CircleRect.CenterX + r * CosD(angle2-90)
	Dim cy2 As Int = CircleRect.CenterY + r * SinD(angle2-90)
	
	'dest.Initialize(cx - ThumbSize,cy - ThumbSize,cx + ThumbSize,cy + ThumbSize)
	'cvs.DrawBitmapRotated(thumb, dest, angle1)
	
	xpnl_Thumb_1.SetLayoutAnimated(0,cx1 - ThumbSize,cy1 - ThumbSize,mStrokeWidth,mStrokeWidth)
	xpnl_Thumb_2.SetLayoutAnimated(0,cx2 - ThumbSize,cy2 - ThumbSize,mStrokeWidth,mStrokeWidth)
	
	cvs.Invalidate
	
	If mOverScrollMultiplier = 1 Then Return
	If TouchedPanel1 = True Then
		If OldAngle1 <= 360 And OldAngle1 >= 270 And angle1 >= 0 And angle1 <= 90 Then
			If mOverScrollMultiplier = mCurrentOverScrollMultiplier1 And mCurrentOverScrollMultiplier1 <> 1 Then
				mCurrentOverScrollMultiplier1 = mCurrentOverScrollMultiplier1 -1
			Else If mCurrentOverScrollMultiplier1 < mOverScrollMultiplier Then
				mCurrentOverScrollMultiplier1 = mCurrentOverScrollMultiplier1 +1
			End If
		else If OldAngle1 >= 0 And OldAngle1 <= 90 And angle1 <= 360 And angle1 >= 270 Then
			If mOverScrollMultiplier = mCurrentOverScrollMultiplier1 And mCurrentOverScrollMultiplier1 <> 1 Then
				mCurrentOverScrollMultiplier1 = mCurrentOverScrollMultiplier1 -1
			Else If mCurrentOverScrollMultiplier1 < mOverScrollMultiplier Then
				mCurrentOverScrollMultiplier1 = mCurrentOverScrollMultiplier1 +1
			End If
		End If
	Else
		If OldAngle2 <= 360 And OldAngle2 >= 270 And angle2 >= 0 And angle2 <= 90 Then
			If mOverScrollMultiplier = mCurrentOverScrollMultiplier2 And mCurrentOverScrollMultiplier2 <> 1 Then
				mCurrentOverScrollMultiplier2 = mCurrentOverScrollMultiplier2 -1
			Else If mCurrentOverScrollMultiplier2 < mOverScrollMultiplier Then
				mCurrentOverScrollMultiplier2 = mCurrentOverScrollMultiplier2 +1
			End If
		else If OldAngle2 >= 0 And OldAngle2 <= 90 And angle2 <= 360 And angle2 >= 270 Then
			If mOverScrollMultiplier = mCurrentOverScrollMultiplier2 And mCurrentOverScrollMultiplier2 <> 1 Then
				mCurrentOverScrollMultiplier2 = mCurrentOverScrollMultiplier2 -1
			Else If mCurrentOverScrollMultiplier2 < mOverScrollMultiplier Then
				mCurrentOverScrollMultiplier2 = mCurrentOverScrollMultiplier2 +1
			End If
		End If
	End If
	
	OldAngle1 = angle1
	OldAngle2 = angle2
	
End Sub

Private Sub pnl_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnl.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	Dim dx As Int = x - CircleRect.CenterX
	Dim dy As Int = y - CircleRect.CenterY
	Dim dist As Float = Sqrt(Power(dx, 2) + Power(dy, 2))
	'If dist > CircleRect.Width / 2 Then
	If Action = pnl.TOUCH_ACTION_DOWN Then
		TouchDown
		If dist > (CircleRect.Width/4 + mStrokeWidth/2) And dist < (CircleRect.Width/2 + mStrokeWidth/2) Then
			mTouchIsRight = True
		End If
		
		If (x >= xpnl_Thumb_1.Left And x <= xpnl_Thumb_1.Left + xpnl_Thumb_1.Width) Or (y >= xpnl_Thumb_1.Top And y <= xpnl_Thumb_1.Height) Then
			xpnl_Thumb_1.BringToFront
			TouchedPanel1 = True
		Else If (x >= xpnl_Thumb_2.Left And x <= xpnl_Thumb_2.Left + xpnl_Thumb_2.Width) Or (y >= xpnl_Thumb_2.Top And y <= xpnl_Thumb_2.Height) Then
			xpnl_Thumb_2.BringToFront
			TouchedPanel1 = False
		End If
		
	else If Action = pnl.TOUCH_ACTION_UP Then
		TouchUp
		mTouchIsRight = False
	End If
	
	If mTouchIsRight = True Then
		SetValueBasedOn(IIf(TouchedPanel1 = True,mValue1,mValue2),X,Y)
	End If
	
End Sub

Private Sub SetValueBasedOn(mValue As Int,X As Float,Y As Float)
	Dim dx As Int = x - CircleRect.CenterX
	Dim dy As Int = y - CircleRect.CenterY
	'Dim dist As Float = Sqrt(Power(dx, 2) + Power(dy, 2))
	Dim angle As Int = Round(ATan2D(dy, dx))
	angle = angle + 90
	angle = (angle + 360) Mod 360
	Dim NewValue As Int = mMin + angle / 360 * (mMax - mMin)
	NewValue = Max(mMin, Min(mMax, NewValue))
	Dim OldValue As Int = mValue
	If NewValue <> mValue Then
'		If mRollOver = False Then
'			If Abs(NewValue - mValue) > (mMax - mMin) / 2 Then
'				If mValue >= (mMax + mMin) / 2 Then
'					mValue = mMax
'				Else
'					mValue = mMin
'				End If
'			Else
'				mValue = NewValue
'			End If
'		Else


		mValue = NewValue - (NewValue Mod mSteps)
		'End If
		
		If TouchedPanel1 = True Then mValue1 = mValue Else mValue2 = mValue
		
		If OldValue <> mValue Then 
			ValueChanged
		End If
	End If
	
	If TouchedPanel1 = True Then mValue1 = mValue Else mValue2 = mValue
	
	Draw
End Sub

Private Sub ValueChanged
	If mHapticFeedback Then XUIViewsUtils.PerformHapticFeedback(mBase)
	If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 2) Then
		CallSub3(mCallBack, mEventName & "_ValueChanged", IIf(mOverScrollMultiplier > 1,(mMax*mCurrentOverScrollMultiplier1)+mValue1,mValue1),IIf(mOverScrollMultiplier > 1,(mMax*mCurrentOverScrollMultiplier2)+mValue2,mValue2))
	End If
End Sub

Private Sub TouchDown
	If xui.SubExists(mCallBack, mEventName & "_TouchDown", 0) Then
	CallSub(mCallBack, mEventName & "_TouchDown")
	End If
End Sub

Private Sub TouchUp
	If xui.SubExists(mCallBack, mEventName & "_TouchUp", 0) Then
		CallSub(mCallBack, mEventName & "_TouchUp")
	End If
End Sub

#if B4J
Private Sub pnl_MousePressed (EventData As MouseEvent)
	EventData.Consume
End Sub

Private Sub pnl_MouseClicked(EventData As MouseEvent)
	EventData.Consume
End Sub

Private Sub pnl_MouseReleased(EventData As MouseEvent)
	EventData.Consume
End Sub
#End If
'Gets or sets the current scroll multiplier
'This value adjusts internally when the "OverScrollMultiplier" is greater than 1
'Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier
Public Sub setCurrentOverScrollMultiplier1(CurrentMultiplier As Int)
	If CurrentMultiplier < 1 Then
		CurrentMultiplier = 1
	else if CurrentMultiplier > mOverScrollMultiplier Then
		CurrentMultiplier = mOverScrollMultiplier
	End If
	mCurrentOverScrollMultiplier1 = CurrentMultiplier
End Sub

Public Sub getCurrentOverScrollMultiplier1 As Int
	Return mCurrentOverScrollMultiplier1
End Sub
'Gets or sets the current scroll multiplier
'This value adjusts internally when the "OverScrollMultiplier" is greater than 1
'Default: 1 on start , Minimum: 1 Maximum: OverScrollMultiplier
Public Sub setCurrentOverScrollMultiplier2(CurrentMultiplier As Int)
	If CurrentMultiplier < 1 Then
		CurrentMultiplier = 1
	else if CurrentMultiplier > mOverScrollMultiplier Then
		CurrentMultiplier = mOverScrollMultiplier
	End If
	mCurrentOverScrollMultiplier2 = CurrentMultiplier
End Sub

Public Sub getCurrentOverScrollMultiplier2 As Int
	Return mCurrentOverScrollMultiplier2
End Sub

'The value multiplies the max value when you have scrolled over step by step
'Default: 1 - Minimum: 1
Public Sub setOverScrollMultiplier(Multiplier As Int)
	If Multiplier < 1 Then Multiplier = 1
	mOverScrollMultiplier = Multiplier
End Sub

Public Sub getOverScrollMultiplier As Int
	Return mOverScrollMultiplier
End Sub

Public Sub getMinValue As Int
	Return mMin
End Sub

Public Sub getMaxValue As Int
	Return mMax
End Sub

Public Sub setMinValue(Value As Int)
	mMin = Value
	Draw
End Sub

Public Sub setMaxValue(Value As Int)
	mMax = Value
	Draw
End Sub

'Gets or sets the value 1
Public Sub setValue1 (v As Int)
	mValue1 = Max(mMin, Min(mMax, v))
	Draw
End Sub

Public Sub getValue1 As Int
	Return mValue1
End Sub

'Gets or sets the value 2
Public Sub setValue2 (v As Int)
	mValue2 = Max(mMin, Min(mMax, v))
	Draw
End Sub

Public Sub getValue2 As Int
	Return mValue2
End Sub

'Gets or sets the Thumb Icon 1
Public Sub getThumbIcon1 As B4XBitmap
	Return mIcon1
End Sub

Public Sub setThumbIcon1(Icon As B4XBitmap)
	mIcon1 = Icon
	CreateThumb
	Draw
End Sub

'Gets or sets the Thumb Icon 2
Public Sub getThumbIcon2 As B4XBitmap
	Return mIcon2
End Sub

Public Sub setThumbIcon2(Icon As B4XBitmap)
	mIcon2 = Icon
	CreateThumb
	Draw
End Sub

'Gets or sets the Inner Circle Color
Public Sub getInnerCircleColor As Int
	Return mInnerCircleColor
End Sub

Public Sub setInnerCircleColor(Color As Int)
	mInnerCircleColor = Color
	Draw
End Sub
'Gets or sets the Reached Color
Public Sub getReachedColor As Int
	Return mReachedColor
End Sub

Public Sub setReachedColor(Color As Int)
	mReachedColor = Color
	Draw
End Sub
'Gets or sets the Unreached Color
Public Sub getUnreachedColor As Int
	Return mUnreachedColor
End Sub

Public Sub setUnreachedColor(Color As Int)
	mUnreachedColor = Color
	Draw
End Sub
'Gets or sets the Thumb Border Color
Public Sub getThumbBorderColor  As Int
	Return mThumbBorderColor
End Sub

Public Sub setThumbBorderColor (Color As Int)
	mThumbBorderColor = Color
	CreateThumb
	Draw
End Sub
'Gets or sets the Thumb Inner Color
Public Sub getThumbInnerColor  As Int
	Return mThumbInnerColor
End Sub

Public Sub setThumbInnerColor (Color As Int)
	mThumbInnerColor = Color
	CreateThumb
	Draw
End Sub
'Gets or sets the Stroke Width
Public Sub getStrokeWidth As Int
	Return mStrokeWidth
End Sub

Public Sub setStrokeWidth(Width As Int)
	mStrokeWidth = Width
	CreateThumb
	Draw
End Sub

Public Sub getThumb1View As B4XView
	Return xpnl_Thumb_1
End Sub

Public Sub getThumb2View As B4XView
	Return xpnl_Thumb_2
End Sub

Public Sub getSteps As Int
	Return mSteps
End Sub

Public Sub setSteps(Steps As Int)
	mSteps = Steps
End Sub

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub