B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
'xRotaryKnob CustomView Class
'
'Written by Klaus CHRISTL (klaus)
'
'Version 1.8
'Added CallValueChanged when the Value has been changed by code
'
'Version 1.7
'Added ValueChanged event for all SnapModes
'Changed the Value variable type in the ValueChanged event from Int To Double
'Amended problem of highlighted scale value
'
'Version 1.6	2021.04.02
'Added HandleLineColor property
'Amended error with mAngle0 and B4i
'
'Version 1.5	2020.06.23
'Added following properties:
'SnapToZero when True snaps to ZERO after release.
'SnapToZeroDuration in milliseconds.
'Updated the Tag property according to Erels recommendation:
'https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#post-738358
'
'Version: 1.4 2020.01.19
'Amended CustomKnobFileName property repved variable type Boolean by String
'
'Version: 1.3 2019.04.09
'Added Visible property
'
'Version: 1.2 2019.04.08
'Added Value property, allowing to preset a position
'
'Version: 1.1 2019.01.27
'Added CustomKnob and CustomKnobFileName properties with a given Bitmap
'
'Version: 1.0 2018.09.08
'
'Events declaration
#Event: ValueChanged(Value As Double)
#RaisesSynchronousEvents: ValueChanged

'Designer property declarations
#DesignerProperty: Key: OffsetAngle, DisplayName: OffsetAngle, FieldType: Int, DefaultValue: 45, Description: Offset angle of the first scale value from the bottom
#DesignerProperty: Key: ScaleNbValues, DisplayName: ScaleNbValues, FieldType: Int, DefaultValue: 10, Description: Number of scale values
#DesignerProperty: Key: ScaleMinValue, DisplayName: ScaleMinValue, FieldType: Int, DefaultValue: 1, Description: Min valiue of the scale
#DesignerProperty: Key: ScaleMaxValue, DisplayName: ScaleMaxValue, FieldType: Int, DefaultValue: 10, Description: Max valiue of the scale
#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Knob color
#DesignerProperty: Key: SnapMode, DisplayName: SnapMode, FieldType: String, DefaultValue: AFTERMOVE, List: NEVER|AFTERMOVE|ALLWAYS, Description: Snap mode
#DesignerProperty: Key: SnapToZero, DisplayName: SnapToZero, FieldType: Boolean, DefaultValue: False, Description: Snaps to zero, or the min or max value when the user releases the knob.
#DesignerProperty: Key: SnapToZeroDuration, DisplayName: SnapToZeroDuration, FieldType: Int, DefaultValue: 500, Description: Duration for the snaps to zero in milliseconds.
#DesignerProperty: Key: KnobColor, DisplayName: KnobColor, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Background color
#DesignerProperty: Key: KnobBorderColor, DisplayName: BorderColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Knob border color
#DesignerProperty: Key: TwoLinesColor, DisplayName: TwoLinesColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Color of the two lines
#DesignerProperty: Key: LineColor, DisplayName: LineColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Knob line color
#DesignerProperty: Key: TextColor, DisplayName: TextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Text color
#DesignerProperty: Key: HighlightTextColor, DisplayName: HighlightTextColor, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Text color fo highlighted scale values
#DesignerProperty: Key: CustomKnob, DisplayName: CustomKnob, FieldType: Boolean, DefaultValue: False, Description: CustomKnob with a Bitmap. The file must be in File.DirAsset
#DesignerProperty: Key: CustomKnobFileName, DisplayName: CustomKnobFileName, FieldType: String, DefaultValue: , Description: CustomKnob Bitmap file name. Valid only with CustomKnob = True. The file must be in File.DirAsset

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xBase, xParent As B4XView
	Private xcvsBase As B4XCanvas
	Private xTextFont As B4XFont
	Private xbmpKnob As B4XBitmap
	Private xRectBase, xRectKnob, xRectValue As B4XRect
	Private xPathKnob As B4XPath
	
	Private mLeft, mTop, mWidth, mHeight As Double
	
	Private mCenterX, mCenterY, mRadius As Int
	Private mTextSize As Float
	Private mTextHeight, mTextValueY As Int
	
	Private mBackgroundColor, mTextColor, mHighlightTextColor, mKnobColor, mKnobBorderColor, mLineColor, mTwoLinesColor As Int
	Private mScaleNbValues, mScaleMinValue, mScaleMaxValue, mScaleDivision As Int
	Private mValue As Double
	Private mIndex As Int
	Private mAngle, mAngle0, mCurrentAngle, mOffsetAngle, mDivisionAngle, mBeginAngle, mEndAngle As Double
	Private TouchRadius, mScale As Double
	Private mSnapMode As String
	Private mLineWidth As Int
	
	Private tmrClick As Timer
	Private mTimeDown, mClickTime As Long
	Private mCustomKnob As Boolean
	Private mCustomKnobFileName As String
	Private mSnapToZero = True As Boolean
	Private mSnapToZeroDuration As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	mOffsetAngle = 45
	mScaleNbValues = 10
	mScaleMinValue = 1
	mScaleMaxValue = 10
	mScaleDivision = (mScaleMaxValue - mScaleMinValue) / (mScaleNbValues - 1)
	mSnapMode = "AFTERMOVE"
	
	mBackgroundColor = xui.Color_White
	mKnobColor = xui.Color_Red
	mKnobBorderColor = xui.Color_Black
	mTwoLinesColor = xui.Color_Black
	mLineColor = xui.Color_White
	mTextColor = xui.Color_Black
	mHighlightTextColor = xui.Color_Red
	
	mClickTime = 400
	tmrClick.Initialize("tmrClick", mClickTime)
	mCustomKnob = False
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mLeft = mBase.Left
	mTop = mBase.Top
	mWidth = Max(mBase.Width, mBase.Height)
	mHeight = mWidth
	
	mCenterX = mWidth / 2
	mCenterY = mCenterX
	
	xParent = mBase.Parent

	mOffsetAngle = Props.GetDefault("OffsetAngle", 45)
	mScaleNbValues = Props.GetDefault("ScaleNbValues", 10)
	mScaleMinValue = Props.GetDefault("ScaleMinValue", 1)
	mScaleMaxValue = Props.GetDefault("ScaleMaxValue", 10)
	mScaleDivision = (mScaleMaxValue - mScaleMinValue) / (mScaleNbValues - 1)
	mSnapMode = Props.GetDefault("SnapMode", "AFTERMOVE")
	mSnapToZero = Props.GetDefault("SnapToZero", False)
	mSnapToZeroDuration = Props.GetDefault("SnapToZeroDuration", 500)
	mCustomKnob = Props.GetDefault("CustomKnob", False)
	
	mBackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	mKnobColor = xui.PaintOrColorToColor(Props.Get("KnobColor"))
	mKnobBorderColor = xui.PaintOrColorToColor(Props.Get("KnobBorderColor"))
	mTwoLinesColor = xui.PaintOrColorToColor(Props.Get("TwoLinesColor"))
	mLineColor = xui.PaintOrColorToColor(Props.Get("LineColor"))
	mTextColor = xui.PaintOrColorToColor(Props.Get("TextColor"))
	mHighlightTextColor = xui.PaintOrColorToColor(Props.Get("HighlightTextColor"))
	If mCustomKnob = True Then
		mCustomKnobFileName = Props.Get("CustomKnobFileName")
	End If
	
'#If B4A
	InitClass
'#End If

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
'	Log("Base_Resize")
	mWidth = Max(Width, Height)
	mHeight = mWidth
	
	InitClass
End Sub

Public Sub AddToParent(Parent As B4XView, Left As Double, Top As Double, Width As Double, Height As Double)
	mLeft = Left
	mTop = Top
	mWidth = Max(Width, Height)
	mHeight = mWidth
	
	mCenterX = mWidth / 2
	mCenterY = mCenterX
	
	xParent = Parent
	
	InitClass
End Sub

Private Sub InitClass
	If xBase.IsInitialized = False Then
		mBase = xui.CreatePanel("")
		xBase = xui.CreatePanel("xBase")
		mBase.Tag = Me		'allows to use Parent.GetView(x).Tag
		xParent.AddView(mBase, mLeft, mTop, mWidth, mHeight)
		mBase.AddView(xBase, 0, 0, mWidth, mHeight)
		xcvsBase.Initialize(xBase)
	Else
		xcvsBase.Resize(mWidth, mHeight)
	End If
	
	xRectBase.Initialize(0, 0, mWidth, mHeight)
	mRadius = 0.3 * mWidth
	xRectKnob.Initialize(mCenterX - mRadius, mCenterY - mRadius, mCenterX + mRadius, mCenterY + mRadius)
	Private mBaseWidth As Int
	mBaseWidth = 200 * xui.Scale
	If mWidth / mBaseWidth > 1 Then
		mTextSize = 15 * (1 + 0.5 * (mWidth / mBaseWidth - 1))
	Else
		mTextSize = 15 * (1 +  (mWidth / mBaseWidth - 1))
	End If
	xTextFont = xui.CreateDefaultBoldFont(mTextSize)
	mTextHeight = MeasureTextHeight("0", xTextFont)
	
	xRectValue.Initialize(0, mCenterY + mRadius + 5dip, mWidth, mHeight)
	mTextValueY	= (mHeight + mCenterY + mRadius) / 2 + mTextHeight
	If mWidth / xui.Scale > 200 Then
		mLineWidth = 3dip
	Else
		mLineWidth = 2dip
	End If
	
	mBeginAngle = -270 + mOffsetAngle
	mEndAngle = 90 - mOffsetAngle
	mDivisionAngle = (360 - 2 * mOffsetAngle) / (mScaleNbValues - 1)
	mScale = (mScaleMaxValue - mScaleMinValue) / (360 - 2 * mOffsetAngle)
	If mScaleMinValue >= 0 Then
		mAngle0 =	mBeginAngle
	Else If mScaleMaxValue <= 0 Then
		mAngle0 =	mEndAngle
	Else
#If B4i
		Private val1, val2 As Int
		val1 = (mBeginAngle - mScaleMinValue / mScale)
		val2 =	val1 Mod 360
		mAngle0 = val2
#Else
		mAngle0 =	(mBeginAngle - mScaleMinValue / mScale) Mod 360
#End If
	End If
	
	InitKnobBitmap
	DrawScale
	DrawKnob(mAngle0)
	If mSnapMode <> "NEVER" Then
		DrawScaleDigit(mIndex, mHighlightTextColor)
	Else
		mValue = mScaleMinValue - (mBeginAngle - mBeginAngle) * mScale
		DrawValue(mValue)
	End If
End Sub

Private Sub xBase_Touch (Action As Int, X As Float, Y As Float)
	Private Index As Int
	
	Select Action
		Case xBase.TOUCH_ACTION_DOWN
			mTimeDown = DateTime.Now
			TouchRadius = Sqrt((X - mCenterX) * (X - mCenterX) + (Y - mCenterY) * (Y - mCenterY))
			mAngle = AdjustAngle(ATan2D((Y - mCenterY), (X - mCenterX)))
			If TouchRadius > mRadius / 2 Then
				DrawKnob(mAngle)
			Else
				tmrClick.Enabled = True
			End If
		Case xBase.TOUCH_ACTION_MOVE
			If TouchRadius > mRadius / 2 Then
				mAngle = AdjustAngle(ATan2D((Y - mCenterY), (X - mCenterX)))
				Index = GetIndexAngle(mAngle)
				If Index <> mIndex Then
					DrawScaleDigit(mIndex, mTextColor)
					mIndex = Index
					If mSnapMode = "ALLWAYS" Then
						mValue = mScaleMinValue + mIndex * mScaleDivision
						CallValueChanged
					End If
					If mSnapMode <> "NEVER" Then
						DrawScaleDigit(mIndex, mHighlightTextColor)
					End If
				End If
				Select mSnapMode
					Case "NEVER"
						DrawKnob(mAngle)
						mValue = mScaleMinValue - (mBeginAngle - mAngle) * mScale
						CallValueChanged
						DrawValue(mValue)
					Case "AFTERMOVE"
						DrawKnob(mAngle)
					Case "ALLWAYS"
						mCurrentAngle = mBeginAngle + mIndex * mDivisionAngle
						DrawKnob(mCurrentAngle)
				End Select
			End If
		Case xBase.TOUCH_ACTION_UP
			If TouchRadius > mRadius / 2 Then
				DrawScaleDigit(mIndex, mTextColor)
				mAngle = AdjustAngle(ATan2D((Y - mCenterY), (X - mCenterX)))
				mIndex = GetIndexAngle(mAngle)
				mCurrentAngle = mBeginAngle + mIndex * mDivisionAngle
				Select mSnapMode
					Case "NEVER"
						DrawKnob(mAngle)
						mValue = mScaleMinValue + (mAngle - mBeginAngle) * mScale
						CallValueChanged
						If mSnapToZero = True Then
							AnimateTo(mAngle0, mSnapToZeroDuration)
						End If
					Case "AFTERMOVE", "ALLWAYS"
						mValue = mScaleMinValue + mIndex * mScaleDivision
						DrawKnob(mCurrentAngle)
						DrawScaleDigit(mIndex, mHighlightTextColor)
							CallValueChanged
				End Select
			Else
				If DateTime.Now - mTimeDown <= mClickTime Then
					Log("Touch_UP")
					DrawScaleDigit(mIndex, mTextColor)
					mIndex = mIndex + 1
					mIndex = Min(mIndex, (mScaleNbValues - 1))
					mValue = mScaleMinValue + mIndex * mScaleDivision
					mCurrentAngle = mBeginAngle + mIndex * mDivisionAngle
					tmrClick.Enabled = False
					DrawScaleDigit(mIndex, mHighlightTextColor)
					DrawKnob(mCurrentAngle)
					CallValueChanged
				End If
			End If
		End Select
End Sub

Private Sub tmrClick_Tick
	DrawScaleDigit(mIndex, mTextColor)
	mIndex = mIndex - 1
	mIndex = Max(mIndex, 0)
	mValue = mScaleMinValue + mIndex * mScaleDivision
	mCurrentAngle = mBeginAngle + mIndex * mDivisionAngle
	DrawScaleDigit(mIndex, mHighlightTextColor)
	
	tmrClick.Enabled = False
	DrawKnob(mCurrentAngle)
'	CallValueChanged
End Sub

Private Sub CallValueChanged
	If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
		CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", mValue)
	End If
End Sub

Private Sub InitKnobBitmap
	xPathKnob.InitializeOval(xRectKnob)
	If mCustomKnob = True Then
		xcvsBase.ClearRect(xRectBase)
		xcvsBase.ClipPath(xPathKnob)
		xcvsBase.DrawBitmap(xui.LoadBitmapResize(File.DirAssets, mCustomKnobFileName, xRectKnob.Width, xRectKnob.Height, True), xRectKnob)
'		xbmpKnob = xui.LoadBitmapResize(File.DirAssets, mCustomKnobFileName, xRectKnob.Width, xRectKnob.Height, True)
	Else
	
		xcvsBase.ClearRect(xRectBase)
		xcvsBase.ClipPath(xPathKnob)
		xcvsBase.DrawCircle(mCenterX, mCenterY, mRadius, mKnobColor, True, 1dip)
		xcvsBase.DrawLine(mCenterX + 0.2 * mRadius, mCenterY, mCenterX + mRadius, mCenterY, mLineColor, mLineWidth + 1dip)
		xcvsBase.DrawLine(mCenterX - mRadius, mCenterY - 0.2 * mRadius, mCenterX + mRadius, mCenterY - 0.2 * mRadius, mTwoLinesColor, mLineWidth)
		xcvsBase.DrawLine(mCenterX - mRadius, mCenterY + 0.2 * mRadius, mCenterX + mRadius, mCenterY + 0.2 * mRadius, mTwoLinesColor, mLineWidth)
		xcvsBase.DrawCircle(mCenterX, mCenterY, mRadius - 1dip, mKnobBorderColor, False, mLineWidth)
		xcvsBase.Invalidate
	End If

#If B4A
	xbmpKnob = xBase.Snapshot
	#Else
		xbmpKnob = xcvsBase.CreateBitmap
#End If
		xcvsBase.RemoveClip
		xcvsBase.DrawRect(xRectBase, mBackgroundColor, True, 1dip)
End Sub

Private Sub AdjustAngle(Angle As Double) As Double
	If Angle > 90 Then Angle = Angle - 360
	Angle = Max(Angle, mBeginAngle)
	Angle = Min(Angle, mEndAngle)
	Return Angle
End Sub

Private Sub GetIndexAngle(Angle As Double) As Int
	Private Index As Int
	
	Index = Abs(Floor((mBeginAngle - Angle) / mDivisionAngle + 0.5))
	Return Index
End Sub

Private Sub GetIndexValue(Value As Int) As Int
	Private Index As Int
	
	Index = Abs(Floor((Value - mScaleMinValue) / (mScaleNbValues - 1) + 0.5))
	Return Index
End Sub

Private Sub DrawScale
	Private Index, x1, y1, x2, y2 As Int
	Private Angle, Radius1, Radius2 As Double
	
	For Index = 0 To mScaleNbValues - 1
		Angle = mBeginAngle + Index * mDivisionAngle
		Radius1 = 1.02 * mRadius
		Radius2 = 1.15 * mRadius
		x1 = mCenterX + Radius1 * CosD(Angle)
		y1 = mCenterY + Radius1 * SinD(Angle)
		x2 = mCenterX + Radius2 * CosD(Angle)
		y2 = mCenterY + Radius2 * SinD(Angle)
		
		xcvsBase.DrawLine(x1, y1, x2, y2, mTextColor, mLineWidth)
		DrawScaleDigit(Index, mTextColor)
	Next
	xcvsBase.Invalidate
End Sub

Private Sub DrawKnob(Angle As Double)
	xcvsBase.DrawBitmapRotated(xbmpKnob, xRectBase, Angle)
	xcvsBase.Invalidate
End Sub

Private Sub DrawScaleDigit(Index As Int, Color As Int)
	Private x1, y1, DeltaX, DeltaY As Int
	Private Angle, Radius As Double
	Private txt As String
	
	If mOffsetAngle = 0 And Index = mScaleNbValues - 1 Then
		Return
	End If
	
	txt = mScaleMinValue + Index * mScaleDivision
	Angle = mBeginAngle + Index * mDivisionAngle
	Radius = 1.25 * mRadius 
	
	DeltaX = MeasureTextWidth(txt, xTextFont) / 2 * CosD(Angle)
	DeltaY = MeasureTextHeight(txt, xTextFont) / 2 * SinD(Angle)
	x1 = mCenterX + Radius * CosD(Angle) + DeltaX
	y1 = mCenterY + Radius * SinD(Angle) + 0.5 * mTextHeight + DeltaY
	xcvsBase.DrawText(txt, x1, y1, xTextFont, Color, "CENTER")

	xcvsBase.Invalidate
End Sub

'Draws the current value, only in the "NEVER" snap mode
Private Sub DrawValue(Value As Double)
	Private txt As String	
	Private NbDecimals As Int
	If mOffsetAngle > 30 Then
		If Value < 1 Then
			NbDecimals = 3
		Else If Value >= 1 And Value < 10 Then
			NbDecimals = 2
		Else If Value >= 10 And Value = 100 Then
			NbDecimals = 1
		Else
			NbDecimals = 0
		End If
		txt = NumberFormat(Value, 1, NbDecimals)
		xcvsBase.DrawRect(xRectValue, mBackgroundColor, True, 1dip)
		xcvsBase.DrawText(txt, mCenterX, mTextValueY, xTextFont, mTextColor, "CENTER")
	End If
End Sub

'Draws the whole object
Private Sub DrawAll
	InitKnobBitmap
	DrawScale
	DrawKnob(mBeginAngle)
	DrawScaleDigit(mIndex, mHighlightTextColor)
End Sub

'gets or sets the Left property
Public Sub getLeft As Double
	Return mLeft
End Sub

Public Sub setLeft(Left As Double)
	mLeft = Left
	xBase.Left = mLeft
End Sub

'gets or sets the Top property
Public Sub getTop As Double
	Return mTop
End Sub

Public Sub setTop(Top As Double)
	mTop  = Top 
	xBase.Top  = mTop
End Sub

'gets or sets the Width property
'there is no Height property because the object is square
Public Sub getWidth As Double
	Return mWidth
End Sub

Public Sub setWidth(Width As Double)
	mWidth  = Width
	mHeight = mWidth
	xBase.Width  = mWidth
	xcvsBase.Resize(mWidth, mHeight)
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the OffsetAngle property
Public Sub getOffsetAngle As Int
	Return mOffsetAngle
End Sub

Public Sub setOffsetAngle(OffsetAngle As Int)
	mOffsetAngle = OffsetAngle
	mBeginAngle = -270 + OffsetAngle
	mEndAngle = 90 - mOffsetAngle
	mDivisionAngle = (360 - 2 * mOffsetAngle) / (mScaleNbValues - 1)
	mScale = (mScaleMaxValue - mScaleMinValue) / (360 - 2 * mOffsetAngle)
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the ScaleNbValues property
Public Sub getScaleNbValues As Int
	Return mScaleNbValues
End Sub

Public Sub setScaleNbValues(ScaleNbValues As Int)
	mScaleNbValues = ScaleNbValues
	mScaleDivision = (mScaleMaxValue - mScaleMinValue) / (mScaleNbValues - 1)
End Sub

'gets or sets the ScaleMinValue property
Public Sub getScaleMinValue As Int
	Return mScaleMinValue
End Sub

Public Sub setScaleMinValue(ScaleMinValue As Int)
	mScaleMinValue = ScaleMinValue
	mScaleDivision = (mScaleMaxValue - mScaleMinValue) / (mScaleNbValues - 1)
	mScale = (mScaleMaxValue - mScaleMinValue) / (360 - 2 * mOffsetAngle)
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the ScaleMaxValue property
Public Sub getScaleMaxValue As Int
	Return mScaleMaxValue
End Sub

Public Sub setScaleMaxValue(ScaleMaxValue As Int)
	mScaleMaxValue = ScaleMaxValue
	mScaleDivision = (mScaleMaxValue - mScaleMinValue) / (mScaleNbValues - 1)
	mScale = (mScaleMaxValue - mScaleMinValue) / (360 - 2 * mOffsetAngle)
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the BackgroundColor property
Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

Public Sub setBackgroundColor(BackgroundColor As Int)
	mBackgroundColor = BackgroundColor
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the KnobColor property
Public Sub getKnobColor As Int
	Return mKnobColor
End Sub

Public Sub setKnobColor(KnobColor As Int)
	mKnobColor = KnobColor
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the KnobBorderColor property
Public Sub getKnobBorderColor As Int
	Return mKnobBorderColor
End Sub

Public Sub setKnobBorderColor(KnobBorderColor As Int)
	mKnobBorderColor = KnobBorderColor
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the LineColor property
Public Sub getLineColor As Int
	Return mLineColor
End Sub

Public Sub setLineColor(LineColor As Int)
	mLineColor = LineColor
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the TextColor property
Public Sub getTextColor As Int
	Return mTextColor
End Sub

Public Sub setTextColor(TextColor As Int)
	mTextColor = TextColor
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the HighlightTextColor property
Public Sub getHighlightTextColor As Int
	Return mHighlightTextColor
End Sub

Public Sub setHighlightTextColor(HighlightTextColor As Int)
	mHighlightTextColor = HighlightTextColor
	If xBase.IsInitialized Then
		DrawAll
	End If
End Sub

'gets or sets the SnapMode property
'possible values:
'AFTERMOVE	the knob snaps only when the knob is released, default value.
'ALLWAYS		the knob snaps during moving.
'NEVER			the knob doesn't snap at all, it displays the current position.  
Public Sub getSnapMode As String
	Return mSnapMode
End Sub

Public Sub setSnapMode(SnapMode As String)
	If SnapMode = "AFTERMOVE" Or SnapMode = "ALLWAYS" Or SnapMode = "NEVER" Then
		mSnapMode = SnapMode
		If xBase.IsInitialized Then
			DrawAll
		End If
	Else
		Log("Wrong SnapMode property value: only 'AFTERMOVE', 'ALLWAYS' and 'NEVER' are authorized")
	End If
End Sub

'gets or sets the CustomKnob property
'CustomKnob with a Bitmap. 
'The file must be in File.DirAsset
Public Sub getCustomKnob As Boolean
	Return mCustomKnob
End Sub

Public Sub setCustomKnob(CustomKnob As Boolean)
	mCustomKnob = CustomKnob
End Sub

'gets or sets the CustomKnobFileName property
'CustomKnob Bitmap file name. 
'Valid only with CustomKnob = True. 
'The file must be in File.DirAsset
Public Sub getCustomKnobFileName As String
	Return mCustomKnobFileName
End Sub

Public Sub setCustomKnobFileName(CustomKnobFileName As String)
	mCustomKnobFileName = CustomKnobFileName
End Sub

'sets or gets the value propertycof of the knob
Public Sub getValue As Double
	Return mValue
End Sub

Public Sub setValue(Value As Double)
	mValue = Value
	If mSnapMode <> "NEVER" Then
		DrawScaleDigit(mIndex, mTextColor)
		mIndex = GetIndexValue(mValue)
		DrawScaleDigit(mIndex, mHighlightTextColor)
		mValue = mScaleMinValue + mIndex * mScaleDivision
	Else
		mValue = Floor(mValue + 0.5)
		DrawValue(mValue)
	End If
	mAngle = (mValue - mScaleMinValue) / mScale + mBeginAngle
	DrawKnob(mAngle)
	CallValueChanged
End Sub
	
'sets or gets the Visible property of the knob
Public Sub getVisible As Boolean
	Return xBase.Visible
End Sub

Public Sub setVisible(Visible As Boolean)
	xBase.Visible = Visible
End Sub

'sets or gets the SnapToZero property of the knob
'When True snaps to the ZERO position after releasing the knob
'If there is no ZERO position in the scale, it snaps to the position nearest to ZERO.
'The duration of the snap can be set with the SnapToZeroDuration property
Public Sub getSnapToZero As Boolean
	Return mSnapToZero
End Sub

Public Sub setSnapToZero(SnapToZero As Boolean)
	mSnapToZero = SnapToZero
End Sub

'sets or gets the SnapToZeroDuration property of the knob
Public Sub getSnapToZeroDuration As Int
	Return mSnapToZeroDuration
End Sub

Public Sub setSnapToZeroDuration(SnapToZeroDuration As Int)
	mSnapToZeroDuration = SnapToZeroDuration
End Sub

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsBase.MeasureText(Text, Font1)
	Return rct.Width
End Sub

Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsBase.MeasureText(Text, Font1)
	Return rct.Height
End Sub

'generates the animation of scrolling
Private Sub AnimateTo(NewValueA As Int, Duration As Int)
	Private CurrentValueA As Int
	Dim BeginTime As Long = DateTime.Now
	Dim StartA As Int = mCurrentAngle
	CurrentValueA = NewValueA
	Dim tempValueA As Float
	Do While DateTime.Now < BeginTime + Duration
		tempValueA = QuarticTimeEaseOut(DateTime.Now - BeginTime, StartA, NewValueA - StartA, Duration)
'		tempValueA = LinearTimeEaseOut(DateTime.Now - BeginTime, StartA, NewValueA - StartA, Duration)
		DrawKnob(tempValueA)
		mValue = mScaleMinValue + (tempValueA - mBeginAngle) * mScale
'		CallValueChanged
		Sleep(5)
		If NewValueA <> CurrentValueA Then Return 'will happen if another update has started
	Loop
	DrawKnob(CurrentValueA)
End Sub

'Quartic easing out from http://gizma.com/easing/
Private Sub QuarticTimeEaseOut(Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time = Time / Duration
	Time = Time - 1
	Return -ChangeInValue * (Time * Time * Time * Time - 1) + Start
End Sub

