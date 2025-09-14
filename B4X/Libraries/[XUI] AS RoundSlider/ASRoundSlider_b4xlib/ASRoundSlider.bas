B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
'ASRoundSlider
'Author: Alexander Stolte
#If Documentation
V1.00
	-Release
V1.01
	-Add get and set MinValue
	-Add get and set MaxValue
	-Add Icon Gap
#End If
	
#DesignerProperty: Key: InnerCircleColor, DisplayName: Inner Circle Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ReachedColor, DisplayName: Reached Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: UnreachedColor, DisplayName: Unreached Color, FieldType: Color, DefaultValue: 0xFFA9A9A9
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ThumbCornerColor, DisplayName: Thumb Corner Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: StrokeWidth, DisplayName: Stroke Width, FieldType: Int, DefaultValue: 40
#DesignerProperty: Key: ThumbCornerWidth, DisplayName: Thumb Corner Width, FieldType: Int, DefaultValue: 4, MinRange: 2
#DesignerProperty: Key: RollOver, DisplayName: Roll Over, FieldType: Boolean, DefaultValue: False, Description: If checked then it is possible to drag from the max value to the min value. 
#DesignerProperty: Key: Min, DisplayName: Minimum, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: Max, DisplayName: Maximum, FieldType: Int, DefaultValue: 100

#Event: ValueChanged (Value As Int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cvs As B4XCanvas
	Private mValue As Int = 75
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

	Private mThumbCornerWidth As Float
	Private mRollOver As Boolean
	Private mTouchIsRight As Boolean = False
	
	Private mIcon1 As B4XBitmap = Null
	
	Private xpnl_Thumb As B4XView
	Private xiv_ThumbIcon As B4XView
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
	mValue = mMin
	pnl = xui.CreatePanel("pnl")
	xpnl_Thumb = xui.CreatePanel("")
	mReachedColor = xui.PaintOrColorToColor(Props.Get("ReachedColor"))
	mUnreachedColor = xui.PaintOrColorToColor(Props.Get("UnreachedColor"))
	mThumbBorderColor = xui.PaintOrColorToColor(Props.Get("ThumbColor"))
	mThumbInnerColor = xui.PaintOrColorToColor(Props.Get("ThumbCornerColor"))
	mInnerCircleColor = xui.PaintOrColorToColor(Props.Get("InnerCircleColor"))
	mRollOver = Props.GetDefault("RollOver", False)
	mStrokeWidth = DipToCurrent(Props.GetDefault("StrokeWidth", 40))
	mThumbCornerWidth = DipToCurrent(Props.GetDefault("ThumbCornerWidth", 4))
	mBase.AddView(xpnl_Thumb, 0, 0, mStrokeWidth, mStrokeWidth)
	mBase.AddView(pnl, 0, 0, 0, 0)
	
	Dim tmp_iv As ImageView : tmp_iv.Initialize("") : xiv_ThumbIcon = tmp_iv
	#If B4I
	tmp_iv.UserInteractionEnabled = False
	xpnl_Thumb.As(Panel).UserInteractionEnabled = False
	#Else If B4J
	Dim jo As JavaObject = xpnl_Thumb
	jo.RunMethod("setMouseTransparent", Array(True))
	#End If
	
	xpnl_Thumb.AddView(xiv_ThumbIcon,0,0,0,0)
	
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
	xpnl_Thumb.SetColorAndBorder(mThumbInnerColor,mThumbCornerWidth,mThumbBorderColor,mStrokeWidth/2)
	ThumbSize = mStrokeWidth/2
	
	If mIcon1.IsInitialized = True And mIcon1 <> Null Then
		xiv_ThumbIcon.SetBitmap(mIcon1.Resize(xiv_ThumbIcon.Width,xiv_ThumbIcon.Height,True))
	End If
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	pnl.SetLayoutAnimated(0, 0, 0, Width, Height)
	xpnl_Thumb.SetLayoutAnimated(0,xpnl_Thumb.Left,xpnl_Thumb.Top,mStrokeWidth,mStrokeWidth)
	
	Dim ThumbGap As Float = 4dip
	
	xiv_ThumbIcon.SetLayoutAnimated(0,ThumbGap,ThumbGap,mStrokeWidth - ThumbGap*2,mStrokeWidth - ThumbGap*2)
	CircleRect.Initialize(mStrokeWidth/2,mStrokeWidth/2,Width - mStrokeWidth/2,Height - mStrokeWidth/2)
	Draw
End Sub
'Draws the view new
Public Sub Draw
	cvs.ClearRect(cvs.TargetRect)
	Dim radius As Int = CircleRect.Width / 2
	cvs.DrawCircle(CircleRect.CenterX, CircleRect.CenterY, radius, mUnreachedColor , False, mStrokeWidth)
	Dim p As B4XPath
	Dim angle As Int = (mValue - mMin) / (mMax - mMin) * 360
	
	If mValue = mMax Then
		cvs.DrawCircle(CircleRect.CenterX, CircleRect.CenterY, radius, mReachedColor , False, mStrokeWidth)
	Else
		#If B4J
		p.InitializeArc(CircleRect.CenterX, CircleRect.CenterY, mBase.Width/2, -90,angle )
		cvs.DrawPath(p, mReachedColor, False, 40dip)
		#Else
		p.InitializeArc(CircleRect.CenterX, CircleRect.CenterY, radius + mStrokeWidth/2, -90,angle)
		cvs.DrawPath(p, mReachedColor, True, 40dip)
		#End If

	End If

	cvs.DrawCircle(CircleRect.CenterX, CircleRect.CenterY, radius - mStrokeWidth/2, mInnerCircleColor, True, 0)
	
	'Dim dest As B4XRect
	Dim r As Int = mBase.Height/2 - mStrokeWidth/2
	Dim cx As Int = CircleRect.CenterX + r * CosD(angle-90)
	Dim cy As Int = CircleRect.CenterY + r * SinD(angle-90)
	'dest.Initialize(cx - ThumbSize,cy - ThumbSize,cx + ThumbSize,cy + ThumbSize)
	'cvs.DrawBitmapRotated(thumb, dest, angle)
	
	xpnl_Thumb.SetLayoutAnimated(0,cx - ThumbSize,cy - ThumbSize,mStrokeWidth,mStrokeWidth)
	
	cvs.Invalidate
End Sub

Private Sub pnl_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnl.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	Dim dx As Int = x - CircleRect.CenterX
	Dim dy As Int = y - CircleRect.CenterY
	Dim dist As Float = Sqrt(Power(dx, 2) + Power(dy, 2))
	'If dist > CircleRect.Width / 2 Then
	
	If Action = pnl.TOUCH_ACTION_DOWN Then
		If dist > (CircleRect.Width/4 + mStrokeWidth/2) And dist < (CircleRect.Width/2 + mStrokeWidth/2) Then
			mTouchIsRight = True
		End If
	else If Action = pnl.TOUCH_ACTION_UP Then
		mTouchIsRight = False
	End If
	
	If mTouchIsRight = True Then
		Dim angle As Int = Round(ATan2D(dy, dx))
		angle = angle + 90
		angle = (angle + 360) Mod 360
		Dim NewValue As Int = mMin + angle / 360 * (mMax - mMin)
		NewValue = Max(mMin, Min(mMax, NewValue))
		Dim OldValue As Int = mValue
		If NewValue <> mValue Then
			If mRollOver = False Then
				If Abs(NewValue - mValue) > (mMax - mMin) / 2 Then
					If mValue >= (mMax + mMin) / 2 Then
						mValue = mMax
					Else
						mValue = mMin
					End If
				Else
					mValue = NewValue
				End If
			Else
				mValue = NewValue
			End If
			If OldValue <> mValue Then ValueChanged
		End If
		Draw
	End If
	
End Sub

Private Sub ValueChanged
	If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_ValueChanged", mValue)
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

'Gets or sets the value
Public Sub setValue (v As Int)
	mValue = Max(mMin, Min(mMax, v))
	Draw
End Sub

Public Sub getValue As Int
	Return mValue
End Sub
'Gets or sets the Thumb Icon
Public Sub getThumbIcon As B4XBitmap
	Return mIcon1
End Sub

Public Sub setThumbIcon(Icon As B4XBitmap)
	mIcon1 = Icon
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

Public Sub getThumbView As B4XView
	Return xpnl_Thumb
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