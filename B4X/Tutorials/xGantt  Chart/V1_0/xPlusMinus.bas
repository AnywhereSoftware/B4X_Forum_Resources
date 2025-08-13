B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'xPlusMinus CustomView Class
'Version 0.94
'Author Klaus CHRISTL (klaus)

#Event: ValieChanged(Value As Int)
#RaisesSynchronousEvents: ValieChanged(Value As Int)

#DesignerProperty: Key: Value, DisplayName: Value, FieldType: Int, DefaultValue: 0, Description: Value
#DesignerProperty: Key: ValueMin, DisplayName: ValueMin, FieldType: Int, DefaultValue: 0, Description: min Value or min Index for TEXT data
#DesignerProperty: Key: ValueMax, DisplayName: ValueMax, FieldType: Int, DefaultValue: 100, Description: max Value or max Index for TEXT data
#DesignerProperty: Key: TextSize, DisplayName: TextSize, FieldType: Int, DefaultValue: 16, Description: Text size
#DesignerProperty: Key: TextColor, DisplayName: TextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Text color
#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background color
#DesignerProperty: Key: ButtonColor, DisplayName: ButtonColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Button color
#DesignerProperty: Key: ButtonSymbol, DisplayName: ButtonSymbol, FieldType: String, DefaultValue: PLUS_MINUS, List: PLUS_MINUS|ARROW_H|ARROW_V|SMALL_ARROW_H|SMALL_ARROW_V|TRIANGLE_H|TRIANGLE_V, Description: Button symbol
#DesignerProperty: Key: ButtonSymbolColor, DisplayName: ButtonSymbolColor, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: Button symbol color
#DesignerProperty: Key: BorderWidth, DisplayName: BorderWidth, FieldType: Int, DefaultValue: 0, Description: Border width
#DesignerProperty: Key: BorderColor, DisplayName: BorderColor, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: Border color
#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: Int, DefaultValue: 0, Description: Corner radius
#DesignerProperty: Key: ScrollIncrement, DisplayName: ScrollIncrement, FieldType: Int, DefaultValue: 1, Description: Number of items to increment per click.
#DesignerProperty: Key: NbFastScrollItems, DisplayName: NbFastScrollItems, FieldType: Int, DefaultValue: 10, Description: Number of items to be scrolled before the fast scroll is activated.
#DesignerProperty: Key: FastScrollFactor, DisplayName: FastScrollFactor, FieldType: Int, DefaultValue: 10, Description: Multiplication factor for fast scroll. FastScrollIncrement = ScrollIncrement * FastScrollFactor.
#DesignerProperty: Key: ValueScrolling, DisplayName: ValueScrolling, FieldType: Boolean, DefaultValue: True, Description: When the value changes it scrolls up or down.

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private mParent As B4XView
	Private TimerPlusMinus As Timer
	Private pnlMain As B4XView
	Private cvsMain As B4XCanvas
	Private rectValue, rectButtonMinus, rectButtonPlus As B4XRect
	Private ValueFont As B4XFont
	
	Private mTag As Object
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mBackgroundColor, mButtonColor, mButtonSymbolColor, mTextColor, mBorderColor As Int
	Private mValue, mValuePrev As Int
	Private mTextSize = 16 As Int
	Private mBorderWidth, mBorderHalfWidth, mCornerRadius As Int
	Private mValue = 0 As Int
	Private mValueMin = 0 As Int
	Private mValueMax = 100 As Int
	Private mValueIncrementSign As Int
	Private mButtonSymbol = "PLUS_MINUS" As String
	Private mValueScrollTime = 200 As Int
	Private mValueRepeatDelay = 1500 As Int
	Private mValueRepeatTime = 300 As Int
	Private mValueScrolling = True As Boolean
	Private mTimeDown As Long
	Private mTimerTickCount As Int
	Private mScrollIncrement = 1 As Int
	Private mNbFastScrollItems = 10 As Int
	Private mFastScrollFactor = 10 As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

	mBackgroundColor = xui.Color_White
	mButtonColor =  xui.Color_White
	mBorderColor =  xui.Color_DarkGray
	mBorderWidth = 0
	mBorderHalfWidth = 0
	mCornerRadius = 0
	mButtonSymbolColor = xui.Color_DarkGray
	mTextColor = xui.Color_Black
	mTextSize = 16
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mLeft = mBase.Left
	mTop = mBase.Top
	mWidth = mBase.Width
	mHeight = mBase.Height
	
	mValue = Props.GetDefault("Value", 0)
	mValueMin = Props.GetDefault("ValueMin", 0)
	mValueMax = Props.GetDefault("ValueMax", 100)
	mTextSize = Props.GetDefault("TextSize", 16)
	mTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", 0xFF000000))
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor", 0xFFFFFFFF))
	If mBackgroundColor = 0x00FFFFFF Then	'needed
		mBackgroundColor = xui.Color_Transparent
	End If
	mButtonSymbol = Props.GetDefault("ButtonSymbol", "PLUS_MINUS")
	mButtonColor = xui.PaintOrColorToColor(Props.GetDefault("ButtonColor", 0xFFFFFFFF))
	mButtonSymbolColor = xui.PaintOrColorToColor(Props.GetDefault("ButtonSymbolColor", 0xFFFFFFFF))
	mBorderColor = xui.PaintOrColorToColor(Props.GetDefault("BorderColor", 0xFF808080))
	mBorderWidth = DipToCurrent(Props.GetDefault("BorderWidth", 0))
	mCornerRadius = DipToCurrent(Props.GetDefault("CornerRadius", 0))
	mScrollIncrement = Props.GetDefault("ScrollIncrement", 1)
	mNbFastScrollItems = Props.GetDefault("NbFastScrollItems", 10)
	mFastScrollFactor = Props.GetDefault("FastScrollFactor", 10)
	mValueScrolling = Props.GetDefault("ValueScrolling", True)
#If B4A
  InitPlusMinus	
#End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If pnlMain.IsInitialized = False Then
		InitPlusMinus
	Else
		mWidth = Width
		mHeight = Height
		
		DrawFrame
		DrawButtons
		DrawValue(False, False)
	End If
End Sub

Public Sub AddToParent(Parent As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
	mLeft = Left
	mTop = Top
	mWidth = Width
	mHeight = Height
	
	mParent = Parent
	mBase = xui.CreatePanel("")
	mParent.AddView(mBase, Left, Top, Width, Height)
	mBase.Tag = Me
	
	InitPlusMinus
End Sub

Private Sub InitPlusMinus
	TimerPlusMinus.Initialize("TimerPlusMinus", mValueRepeatTime)
	
	mBorderHalfWidth = Ceil(mBorderWidth / 2)
	rectButtonMinus.Initialize(mBorderHalfWidth, mBorderHalfWidth, mHeight - mBorderHalfWidth, mHeight - mBorderHalfWidth)
	rectButtonPlus.Initialize(mWidth - mHeight + mBorderHalfWidth, mBorderHalfWidth, mWidth - mBorderHalfWidth, mHeight - mBorderHalfWidth)
	Private Margin = 2dip As Int
	rectValue.Initialize(mHeight + mBorderWidth, mBorderWidth + Margin, mWidth - mHeight - mBorderWidth - Margin, mHeight - mBorderWidth- Margin)
	
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_Transparent, 0)
	pnlMain = xui.CreatePanel("pnlMain")
	mBase.AddView(pnlMain, 0, 0, mWidth, mHeight)
	
	ValueFont = xui.CreateDefaultFont(mTextSize)
	cvsMain.Initialize(pnlMain)
	
	DrawFrame
	DrawButtons
	DrawValue(False, False)	'KC
End Sub

Private Sub DrawFrame
	Private pth As B4XPath
	Private rect As B4XRect
	
	cvsMain.ClearRect(cvsMain.TargetRect)
	rect.Initialize(mBorderHalfWidth, mBorderHalfWidth, cvsMain.TargetRect.Width - mBorderHalfWidth, cvsMain.TargetRect.Height - mBorderHalfWidth)
	pth.InitializeRoundedRect(rect, mCornerRadius)
	cvsMain.DrawPath(pth, mBackgroundColor, True, 1dip)
	If mBorderWidth > 0 Then
		cvsMain.DrawPath(pth, mBorderColor, False, mBorderWidth)
	End If
	cvsMain.Invalidate
End Sub

Private Sub DrawButtons
	Private pth As B4XPath
	

	pth.InitializeRoundedRect(rectButtonMinus, mCornerRadius)
	cvsMain.DrawPath(pth, mButtonColor, True, 1dip)
	If mBorderWidth > 0 Then
		cvsMain.DrawPath(pth, mBorderColor, False, mBorderWidth)
	End If
	
	pth.InitializeRoundedRect(rectButtonPlus, mCornerRadius)
	cvsMain.DrawPath(pth, mButtonColor, True, 1dip)
	If mBorderWidth > 0 Then
		cvsMain.DrawPath(pth, mBorderColor, False, mBorderWidth)
	End If
	
	Select mButtonSymbol
		Case "PLUS_MINUS"
			Private dd As Int
			dd = 0.3 * rectButtonMinus.Height
			cvsMain.DrawLine(rectButtonMinus.Left + dd, rectButtonMinus.CenterY, rectButtonMinus.Right - dd, rectButtonMinus.CenterY, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonPlus.Left + dd, rectButtonPlus.CenterY, rectButtonPlus.Right - dd, rectButtonPlus.CenterY, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonPlus.CenterX, rectButtonPlus.Top + dd, rectButtonPlus.CenterX, rectButtonPlus.Bottom  - dd, mButtonSymbolColor, 2dip)
		Case "ARROW_H"
			Private dy, dx As Int
			dy = 0.28 * rectButtonMinus.Height
			dx = 0.15 * rectButtonMinus.Height
			cvsMain.DrawLine(rectButtonMinus.CenterX - dx, rectButtonMinus.CenterY, rectButtonMinus.CenterX + dx, rectButtonMinus.CenterY - dy, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonMinus.CenterX - dx, rectButtonMinus.CenterY, rectButtonMinus.CenterX + dx, rectButtonMinus.CenterY + dy, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonPlus.CenterX - dx, rectButtonPlus.CenterY - dy, rectButtonPlus.CenterX + dx, rectButtonPlus.CenterY, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonPlus.CenterX - dx, rectButtonPlus.CenterY + dy, rectButtonPlus.CenterX + dx, rectButtonPlus.CenterY, mButtonSymbolColor, 2dip)
		Case "ARROW_V"
			Private dy, dx As Int
			dy = 0.15 * rectButtonMinus.Height
			dx = 0.28 * rectButtonMinus.Height
			cvsMain.DrawLine(rectButtonMinus.CenterX, rectButtonMinus.CenterY + dy, rectButtonMinus.CenterX - dx, rectButtonMinus.CenterY - dy, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonMinus.CenterX, rectButtonMinus.CenterY + dy, rectButtonMinus.CenterX + dx, rectButtonMinus.CenterY - dy, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonPlus.CenterX, rectButtonPlus.CenterY - dy, rectButtonPlus.CenterX - dx, rectButtonPlus.CenterY + dy, mButtonSymbolColor, 2dip)
			cvsMain.DrawLine(rectButtonPlus.CenterX, rectButtonPlus.CenterY - dy, rectButtonPlus.CenterX + dx, rectButtonPlus.CenterY + dy, mButtonSymbolColor, 2dip)
		Case "SMALL_ARROW_H"
			Private dd, th As Int
			dd = 0.2 * rectButtonMinus.Height
			th = 1dip
			cvsMain.DrawLine(rectButtonMinus.CenterX - dd, rectButtonMinus.CenterY, rectButtonMinus.CenterX + dd, rectButtonMinus.CenterY, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonMinus.CenterX - dd, rectButtonMinus.CenterY, rectButtonMinus.CenterX, rectButtonMinus.CenterY - dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonMinus.CenterX - dd, rectButtonMinus.CenterY, rectButtonMinus.CenterX, rectButtonMinus.CenterY + dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonPlus.CenterX - dd, rectButtonPlus.CenterY, rectButtonPlus.CenterX + dd, rectButtonPlus.CenterY, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonPlus.CenterX + dd, rectButtonPlus.CenterY, rectButtonPlus.CenterX, rectButtonPlus.CenterY - dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonPlus.CenterX + dd, rectButtonPlus.CenterY, rectButtonPlus.CenterX, rectButtonPlus.CenterY + dd, mButtonSymbolColor, th)
		Case "SMALL_ARROW_V"
			Private dd As Int
			dd = 0.2 * rectButtonMinus.Height
			cvsMain.DrawLine(rectButtonMinus.CenterX, rectButtonMinus.CenterY - dd, rectButtonMinus.CenterX, rectButtonMinus.CenterY + dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonMinus.CenterX - dd, rectButtonMinus.CenterY , rectButtonMinus.CenterX, rectButtonMinus.CenterY + dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonMinus.CenterX + dd, rectButtonMinus.CenterY, rectButtonMinus.CenterX, rectButtonMinus.CenterY + dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonPlus.CenterX, rectButtonPlus.CenterY - dd, rectButtonPlus.CenterX, rectButtonPlus.CenterY + dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonPlus.CenterX - dd, rectButtonPlus.CenterY, rectButtonPlus.CenterX, rectButtonPlus.CenterY - dd, mButtonSymbolColor, th)
			cvsMain.DrawLine(rectButtonPlus.CenterX + dd, rectButtonPlus.CenterY, rectButtonPlus.CenterX, rectButtonPlus.CenterY - dd, mButtonSymbolColor, th)
		Case "TRIANGLE_H"
			Private dy, dx As Int
			Private pth As B4XPath
			dy = 0.28 * rectButtonMinus.Height
			dx = 0.15 * rectButtonMinus.Height
			pth.Initialize(rectButtonMinus.CenterX - dx, rectButtonMinus.CenterY)
			pth.LineTo(rectButtonMinus.CenterX + dx, rectButtonMinus.CenterY - dy)
			pth.LineTo(rectButtonMinus.CenterX + dx, rectButtonMinus.CenterY + dy)
			cvsMain.DrawPath(pth, mButtonSymbolColor, True, 1dip)
			
			pth.Initialize(rectButtonPlus.CenterX - dx, rectButtonPlus.CenterY - dy)
			pth.LineTo(rectButtonPlus.CenterX + dx, rectButtonPlus.CenterY)
			pth.LineTo(rectButtonPlus.CenterX - dx, rectButtonPlus.CenterY + dy)
			cvsMain.DrawPath(pth, mButtonSymbolColor, True, 1dip)
		Case "TRIANGLE_V"
			Private dy, dx As Int
			Private pth As B4XPath
			dy = 0.15 * rectButtonMinus.Height
			dx = 0.28 * rectButtonMinus.Height
			pth.Initialize(rectButtonMinus.CenterX - dx, rectButtonMinus.CenterY - dy)
			pth.LineTo(rectButtonMinus.CenterX, rectButtonMinus.CenterY + dy)
			pth.LineTo(rectButtonMinus.CenterX + dx, rectButtonMinus.CenterY - dy)
			cvsMain.DrawPath(pth, mButtonSymbolColor, True, 1dip)
			
			pth.Initialize(rectButtonPlus.CenterX - dx, rectButtonPlus.CenterY + dy)
			pth.LineTo(rectButtonPlus.CenterX, rectButtonPlus.CenterY - dy)
			pth.LineTo(rectButtonPlus.CenterX + dx, rectButtonPlus.CenterY + dy)
			cvsMain.DrawPath(pth, mButtonSymbolColor, True, 1dip)
	End Select
	cvsMain.Invalidate
End Sub

Private Sub DrawValue(Scrolling As Boolean, SubCall As Boolean)
	Private rect, rect1 As B4XRect
	Private pth As B4XPath
	Private y, dy, ddy As Int
	
	rect = cvsMain.MeasureText(mValue, ValueFont)
	If Scrolling = False Then
		If mBackgroundColor = xui.Color_Transparent Then
			cvsMain.ClearRect(rectValue)
		Else
			cvsMain.DrawRect(rectValue, mBackgroundColor, True, 1dip)
		End If
		cvsMain.DrawText(mValue, rectValue.CenterX, rectValue.CenterY - rect.CenterY, ValueFont, mTextColor, "CENTER")
		cvsMain.Invalidate
	Else
		dy = 1.3 * rect.Height
		ddy = rect.Height / 1.6
		rect1.Initialize(rectValue.Left, rectValue.CenterY - ddy, rectValue.Right, rectValue.CenterY + ddy)
		pth.InitializeRoundedRect(rect1, 0)
		cvsMain.ClipPath(pth)
		If mValueIncrementSign > 0 Then
			dy = 1.3 * rect.Height
		Else
			dy = -1.3 * rect.Height
		End If
		Private NbFrames = 10 As Int
		For i = 0 To NbFrames
			ddy = rect.Height / 1.8
			rect1.Initialize(rectValue.Left, rectValue.CenterY - ddy, rectValue.Right, rectValue.CenterY + ddy)
			y = rectValue.CenterY - rect.CenterY - i * dy / NbFrames
			If mBackgroundColor = xui.Color_Transparent Then
				cvsMain.ClearRect(rectValue)
			Else
				cvsMain.DrawRect(rectValue, mBackgroundColor, True, 1dip)
			End If
			cvsMain.DrawText(mValuePrev, rectValue.CenterX, y, ValueFont, mTextColor, "CENTER")
			cvsMain.DrawText(mValue, rectValue.CenterX, y + dy, ValueFont, mTextColor, "CENTER")
			Sleep(mValueScrollTime / NbFrames)
			cvsMain.Invalidate
		Next
		cvsMain.RemoveClip
	End If
	If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) And SubCall Then
		CallSub2(mCallBack, mEventName & "_ValueChanged", mValue)
	End If
End Sub

Public Sub ReDraw
	DrawFrame
	DrawButtons
	DrawValue(False, False)
End Sub

Private Sub pnlMain_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case pnlMain.TOUCH_ACTION_DOWN
			mTimeDown = DateTime.Now
			If X >= rectButtonMinus.Left And X <= rectButtonMinus.Right Then
				If mValue >= mValueMin + mScrollIncrement Then
					mValueIncrementSign = -1
					mValuePrev = mValue
					mValue = mValue - mScrollIncrement
					DrawValue(mValueScrolling, True)
					TimerPlusMinus.Enabled = True
				End If
			Else If X >= rectButtonPlus.Left And X <= rectButtonPlus.Right Then
				If mValue <= mValueMax - mScrollIncrement Then
					mValueIncrementSign = 1
					mValuePrev = mValue
					mValue = mValue + mScrollIncrement
					DrawValue(mValueScrolling, True)
					TimerPlusMinus.Enabled = True
				End If
			End If
		Case pnlMain.TOUCH_ACTION_UP
			TimerPlusMinus.Enabled = False
			mTimerTickCount = 0
	End Select
End Sub

Private Sub TimerPlusMinus_Tick
	Private Increment As Int
	If DateTime.Now > mTimeDown + mValueRepeatDelay Then
		If mTimerTickCount <= mNbFastScrollItems Then
			Increment = mScrollIncrement
		Else
			Increment = mScrollIncrement * mFastScrollFactor
		End If
		mTimerTickCount = mTimerTickCount + 1
		If mValueIncrementSign > 0 And mValue <= mValueMax - mScrollIncrement Then
			mValue = Min(mValue + Increment, mValueMax)
			DrawValue(mValueScrolling, True)
		Else if mValueIncrementSign < 0 And mValue >= mValueMin + mScrollIncrement Then
			mValue = mValue - Increment
			mValue = Max(mValue - Increment, mValueMin)
			DrawValue(mValueScrolling, True)
		End If
	End If
End Sub

'Gets or sets the Left property.
Public Sub setLeft(Left As Int)
	mLeft = Left
	mBase.Left = Left
End Sub

Public Sub getLeft As Int
	Return mLeft
End Sub

'Gets or sets the Top property.
Public Sub setTop(Top As Int)
	mTop = Top
	mBase.Top = Top
End Sub

Public Sub getTop As Int
	Return mTop
End Sub

'Gets or sets the Width property.
Public Sub setWidth(Width As Int)
	mWidth = Width
	If pnlMain.IsInitialized Then
		mBase.Width = Width
		pnlMain.Width = Width
		ReDraw
	End If
End Sub

Public Sub getWidth As Int
	Return mWidth
End Sub

'Gets or sets the Height property.
Public Sub setHeight(Height As Int)
	mHeight = Height
	If pnlMain.IsInitialized Then
		mBase.Height = Height
		pnlMain.Height = Height
		ReDraw
	End If
End Sub

Public Sub getHeight As Int
	Return mHeight
End Sub

'Gets or sets the Tag property.
Public Sub setTag(MyTag As Object)
	mTag = MyTag
End Sub

Public Sub getTag As Object
	Return mTag
End Sub

'Gets or sets the Value property.
Public Sub setValue(Value As Int)
	mValue = Value
	DrawValue(False, False)
End Sub

Public Sub getValue As Int
	Return mValue
End Sub

'Gets or sets the ValueMin property.
Public Sub setValueMin(ValueMin As Int)
	mValueMin = ValueMin
End Sub

Public Sub getTValueMin As Int
	Return mValueMin
End Sub

'Gets or sets the ValueMax property.
Public Sub setValueMax(ValueMax As Int)
	mValueMax = ValueMax
End Sub

Public Sub getTValueMax As Int
	Return mValueMin
End Sub

'Gets or sets the BackgroundColor property.
'It must be a xui.Color
Public Sub setBackgroundColor(BackgroundColor As Int)
	mBackgroundColor = BackgroundColor
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

'Gets or sets the BorderColor property.
'It must be a xui.Color
Public Sub setBorderColor(BorderColor As Int)
	mBorderColor = BorderColor
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getBorderColor As Int
	Return mBorderColor
End Sub

'Gets or sets the BorderWidth property.
Public Sub setBorderWidth(BorderWidth As Int)
	mBorderWidth = BorderWidth
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getBorderWidth As Int
	Return mBorderWidth
End Sub

'Gets or sets the CornerRadius property.
Public Sub setCornerRadius(CornerRadius As Int)
	mCornerRadius = CornerRadius
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getCornerRadius As Int
	Return mCornerRadius
End Sub

'Gets or sets the TextSize property.
Public Sub setTextSize(TextSize As Float)
	mTextSize = TextSize
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getTextSize As Float
	Return mTextSize
End Sub

'Gets or sets the TexColor property.
'It must be a xui.Color
Public Sub setTextColor(TextColor As Int)
	mTextColor = TextColor
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getTextColor As Int
	Return mTextColor
End Sub

'Gets or sets the ButtonColor property.
'It must be a xui.Color
Public Sub setButtonColor(ButtonColor As Int)
	mButtonColor = ButtonColor
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getButtonColor As Int
	Return mButtonColor
End Sub

'Gets or sets the ButtonSymbol property.
'Possible values PLUS_MINUS  ARROW_H    ARROW_V  TRIANGLE_H  TRIANGLE_V
Public Sub setButtonSymbol(ButtonSymbol As String)
	Select ButtonSymbol
		Case "PLUS_MINUS", "ARROW_H", "ARROW_V", "TRIANGLE_H", "TRIANGLE_V"
			mButtonSymbol = ButtonSymbol
			If pnlMain.IsInitialized Then
				ReDraw
			End If
		Case Else
			LogColor("Wrong symbol name ! Possible values PLUS_MINUS, ARROW_H, ARROW_V, TRIANGLE_H, TRIANGLE_V", 0xFFFF0000)
	End Select
End Sub

Public Sub getButtonSymbol As String
	Return mButtonSymbol
End Sub

'Gets or sets the ButtonSymbolColor property.
'It must be a xui.Color
Public Sub setButtonSymbolColor(ButtonSymbolColor As Int)
	mButtonSymbolColor = ButtonSymbolColor
	If pnlMain.IsInitialized Then
		ReDraw
	End If
End Sub

Public Sub getButtonSymbolColor As Int
	Return mButtonSymbolColor
End Sub

'Gets or sets the ScrollIncrement property.
Public Sub setScrollIncrement(ScrollIncrement As Int)
	mScrollIncrement = ScrollIncrement
End Sub

Public Sub getScrollIncrement As Int
	Return mScrollIncrement
End Sub

'Gets or sets the NbFastScrollItems property.
'Number of increments before the fast scroll is activated
Public Sub setNbFastScrollItems(NbFastScrollItems As Int)
	mNbFastScrollItems = NbFastScrollItems
End Sub

Public Sub getNbFastScrollItems As Int
	Return mNbFastScrollItems
End Sub

'Gets or sets the FastScrollFactor property.
'Multiplication factor for fast scroll. FastScrollIncrement = ScrollIncrement * FastScrollFactor.
Public Sub setFastScrollFactor(FastScrollFactor As Int)
	mFastScrollFactor = FastScrollFactor
End Sub

Public Sub getFastScrollFactor As Int
	Return mFastScrollFactor
End Sub


