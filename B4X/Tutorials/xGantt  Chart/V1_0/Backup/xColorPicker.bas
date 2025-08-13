B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'xColorPicker Custom View class
'
'Version 0.2
'Author: Klaus CHRISTL (klaus)
#DesignerProperty: Key: RGBValuesEditable, DisplayName: RGBValuesEditable, FieldType: Boolean, DefaultValue: True, Description: Enabled = True adds three editable text fields for R G B values.

#DesignerProperty: Key: Color, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private mLeft, mTop, mWidth, mHeight As Int
	Private pnlColor, pnlColors As B4XView
	Private cvsColors As B4XCanvas
	Private xlblRGB(3) As B4XView
	Private xedtRGB(3) As B4XView
	
	Private MyColor(252), ColorIndex, mColor, mColorRGB(3) As Int
	Private mRGBValuesEditable As Boolean
	Private flgSelectColor = False  As Boolean
	Private flgEditColor = False As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mLeft = mBase.Left
	mTop	= mBase.Top
	
	mColor = xui.PaintOrColorToColor(Props.GetDefault("Color", 0xFFFFFFFF))
	mRGBValuesEditable = Props.GetDefault("RGBValuesEditable", True)
	
#If B4A
	Base_Resize (mBase.Width, mBase.Height)
#End If

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mHeight = Height

	If pnlColors.IsInitialized = False Then
		InitColorPicker
	Else
		mBase.Width = mWidth
	End If
	mBase.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
	mBase.SetColorAndBorder(xui.Color_White, 1dip, xui.Color_Black, 0)
End Sub

Private Sub InitColorPicker
	pnlColor = xui.CreatePanel("")
	pnlColor.SetColorAndBorder(xui.Color_White, 1dip, xui.Color_Black, 0)
	
	pnlColors = xui.CreatePanel("pnlColors")
	pnlColors.SetColorAndBorder(xui.Color_White, 1dip, xui.Color_Black, 0)
'	mBase.AddView(pnlColor, 0, 0, mBase.Height, mBase.Height)
	mBase.AddView(pnlColor, 0, 0, mHeight, mHeight)

	If mRGBValuesEditable = False Then
'		mBase.Width = mBase.Height + 253
		mWidth = mBase.Height + 253
		mBase.AddView(pnlColors, mBase.Height, 0, mBase.Width - mBase.Height, mBase.Height)
	Else
		Private lblRGB(3) As Label
#If B4A
		Private edtRGB(3) As EditText
#Else
		Private edtRGB(3) As TextField
#End If	
		
		Private txtSize As Float
		txtSize = mBase.Height * 0.4 / xui.Scale
		Private fnt As B4XFont
		fnt = xui.CreateDefaultFont(txtSize)
		Private lblH, lblW, edtW As Int
		lblW = mBase.Height * 0.7
		edtW = mBase.Height * 1.3
		lblH = mBase.Height - 4dip
		Private txt(3) As String = Array As String("R", "G", "B")
		mWidth = mBase.Height + 253 + 3 * (lblW + edtW) + 5dip
		For i = 0 To 2
			lblRGB(i).Initialize("")
			xlblRGB(i) = lblRGB(i)
			xlblRGB(i).Font = fnt
			xlblRGB(i).SetTextAlignment("CENTER", "CENTER")
			xlblRGB(i).Text = txt(i)
			
			edtRGB(i).Initialize("edtRGB")
			xedtRGB(i) = edtRGB(i)
			xedtRGB(i).Font = fnt
			xedtRGB(i).Tag = i
			xedtRGB(i).Text = 0
		Next
		mBase.AddView(lblRGB(0), mBase.Height, 2dip, lblW, lblH)
		mBase.AddView(edtRGB(0), mBase.Height + lblW, 2dip, edtW, lblH)
		mBase.AddView(lblRGB(1), mBase.Height + lblW + edtW, 2dip, lblW, lblH)
		mBase.AddView(edtRGB(1), mBase.Height + 2 * lblW + edtW, 2dip, edtW, lblH)
		mBase.AddView(lblRGB(2), mBase.Height + 2 * (lblW + edtW), 2dip, lblW, lblH)
		mBase.AddView(edtRGB(2), mBase.Height + 3 * lblW + 2 * edtW, 2dip, edtW, lblH)
		mBase.AddView(pnlColors, mBase.Height + 3 * (lblW + edtW) + 5dip, 0, 253, mBase.Height)
	End If
	mBase.Width = mWidth
	
	cvsColors.Initialize(pnlColors)
	
	DrawColors
End Sub

Private Sub DrawColors
	Private x, y1, y2, c As Int
	
	'cvsColors.DrawRect(cvsColors.TargetRect, xui.Color_Black, True, 1dip)
	
	x = 0
	y1 = 1dip
	y2 = mBase.Height - 1dip
	c = 0
	For x = 0 To 41
		c = c + 6
		MyColor(x) = xui.Color_RGB(255, c, 0)
		cvsColors.DrawLine(x, y1, x, y2, MyColor(x), 1dip)
	Next
	c = 0
	For x = 42 To 83
		c = 255 - (x - 42) * 6
		MyColor(x) = xui.Color_RGB(c, 255, 0)
		cvsColors.DrawLine(x, y1, x, y2, MyColor(x), 1dip)
	Next
	c = 0
	For x = 84 To 125
		c = (x - 84) * 6
		MyColor(x) = xui.Color_RGB(0, 255, c)
		cvsColors.DrawLine(x, y1, x, y2, MyColor(x), 1dip)
	Next
	c = 0
	For x = 126 To 167
		c = 255 - (x - 126) * 6
		MyColor(x) = xui.Color_RGB(0, c, 255)
		cvsColors.DrawLine(x, y1, x, y2, MyColor(x), 1dip)
	Next
	c = 0
	For x = 168 To 209
		c = (x - 168) * 6
		MyColor(x) = xui.Color_RGB(c, 0, 255)
		cvsColors.DrawLine(x, y1, x, y2, MyColor(x), 1dip)
	Next
	c = 0
	For x = 210 To 251
		c = 255 - (x - 210) * 6
		MyColor(x) = xui.Color_RGB(255, 0, c)
		cvsColors.DrawLine(x, y1, x, y2, MyColor(x), 1dip)
	Next
'	cvsColors.DrawRect(cvsColors.TargetRect, xui.Color_Black, False, 1dip)
	cvsColors.Invalidate
End Sub

Private Sub pnlColors_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case pnlColors.TOUCH_ACTION_DOWN, pnlColors.TOUCH_ACTION_MOVE
			flgSelectColor = True
			ColorIndex = X / xui.Scale
			ColorIndex = Max(X, 0)
			ColorIndex = Min(ColorIndex, 251)
			setColor(MyColor(ColorIndex))
		Case pnlColors.TOUCH_ACTION_UP
			flgSelectColor = False
	End Select
End Sub

'Sets or gets the Color property
Public Sub getColor As Int
	Return mColor
End Sub

Public Sub setColor(Color As Int)
	mColor = Color
	pnlColor.Color = mColor
	If flgEditColor = False Then
		ColorToRGB(mColor)
	End If
End Sub

'Sets or gets the RGBValuesEditable property
'True adds three editable text fields For R G B values.
Public Sub getRGBValuesEditable As Boolean
	Return mRGBValuesEditable
End Sub

Public Sub setRGBValuesEditable(RGBValuesEditable As Boolean)
	mRGBValuesEditable = RGBValuesEditable
End Sub

Private Sub edtRGB_TextChanged (Old As String, New As String)
	Private edt As B4XView
	Private i As Int
	
	If flgSelectColor = False And IsNumber(New) Then
		flgEditColor = True
		edt = Sender
		i = edt.Tag
		mColorRGB(i) = Max(0, New)
		mColorRGB(i) = Min(255, mColorRGB(i))
		setColor(xui.Color_RGB(mColorRGB(0), mColorRGB(1), mColorRGB(2)))
		flgEditColor = False
	End If
End Sub

Private Sub ColorToRGB(Color As Int)
	mColorRGB(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	mColorRGB(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	mColorRGB(2) = Bit.And(Color, 0xff)
	xedtRGB(0).Text = mColorRGB(0)
	xedtRGB(1).Text = mColorRGB(1)
	xedtRGB(2).Text = mColorRGB(2)
End Sub