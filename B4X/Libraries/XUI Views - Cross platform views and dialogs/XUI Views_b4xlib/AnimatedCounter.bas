B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
#DesignerProperty: Key: Digits, DisplayName: Number Of Digits, FieldType: Int, DefaultValue: 4, Description: Number of digits
#DesignerProperty: Key: Duration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 1000, Description:
#DesignerProperty: Key: FadeColor, DisplayName: Fade Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ImageViews As List
	Private mdigits As Int
	Private lblTemplate As B4XView
	Private mValue As List
	Private DigitHeight, DigitWidth As Int
	Private mDuration As Int
	Private fade As B4XBitmap
	Private xfadeIv As B4XView
	Public Tag As Object
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ImageViews.Initialize
	mValue.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	Dim pnl As B4XView = xui.CreatePanel("") 'needed as the passed pane in B4J doesn't crop the child views
	mBase.AddView(pnl, 0, 0, 0, 0)
	mdigits = Props.Get("Digits")
	mDuration = Props.Get("Duration")
	lblTemplate = lbl
	fade = CreateFadeBitmap(xui.PaintOrColorToColor(Props.GetDefault("FadeColor", xui.Color_White)))
	For i = 0 To mdigits - 1
		Dim iv As ImageView
		iv.Initialize("")
		ImageViews.Add(iv)
		mBase.GetView(0).AddView(iv, 0, 0, 0, 0)
	Next
	Dim fadeIv As ImageView
	fadeIv.Initialize("")
	xfadeIv = fadeIv
	mBase.GetView(0).AddView(fadeIv, 0, 0, 0, 0)
	setValue(0)
	If xui.IsB4A Then
		Base_Resize(mBase.Width, mBase.Height)
		setValue(getValue)
	End If
End Sub

Private Sub CreateFadeBitmap (clr As Int) As B4XBitmap
	Dim bc As BitmapCreator
	bc.Initialize(200, 50)
	Dim r As B4XRect
	r.Initialize(0, 0, bc.mWidth, bc.mHeight / 3)
	Dim tclr As Int = Bit.And(0x00ffffff, clr)
	bc.FillGradient(Array As Int(clr, tclr), r, "TOP_BOTTOM")
	r.Top = bc.mHeight * 2 / 3
	r.Bottom = bc.mHeight
	bc.FillGradient(Array As Int(clr, tclr), r, "BOTTOM_TOP")
	Return bc.Bitmap
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
	mBase.GetView(0).SetLayoutAnimated(0, 0, 0, Width, Height)
	xfadeIv.SetLayoutAnimated(0, 0, 0, Width, Height)
	xfadeIv.SetBitmap(fade.Resize(Width, Height, False))
	DigitHeight = Height
	Dim Columns As Int = mdigits
	DigitWidth = Width / Columns
	Dim bmp As B4XBitmap = CreateBitmap(lblTemplate)
	Dim left As Int = Width
	For i = 0 To ImageViews.Size - 1
		Dim iv As B4XView = ImageViews.Get(i)
		'from right to left
		left = left - DigitWidth
		iv.SetLayoutAnimated(0, left, TopFromValue(i), DigitWidth, DigitHeight * 10)
		iv.SetBitmap(bmp)
	Next
End Sub

Private Sub TopFromValue (Digit As Int) As Int
	Dim d As Int = mValue.Get(Digit)
	Return -d * DigitHeight
End Sub

Private Sub CreateBitmap (lbl As B4XView) As B4XBitmap
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, DigitWidth, DigitHeight * 10)
	Dim cvs As B4XCanvas
	cvs.Initialize(p)
	Dim r As B4XRect = cvs.MeasureText("5", lbl.Font)
	Dim BaseLine As Int = DigitHeight / 2 - r.Height / 2 - r.Top
	For i = 0 To 9
		cvs.DrawText(i, DigitWidth / 2, i * DigitHeight + BaseLine, lbl.Font, lbl.TextColor, "CENTER")
	Next
	cvs.Invalidate
	Dim res As B4XBitmap = cvs.CreateBitmap
	cvs.Release
	Return res
End Sub

Public Sub setValue(v As Int)
	mValue.Clear
	For i = 0 To mdigits - 1
		mValue.Add(v Mod 10)
		v = v / 10
		Dim iv As B4XView = ImageViews.Get(i)
		iv.SetLayoutAnimated(mDuration, iv.Left, TopFromValue(i), Max(1, iv.Width), Max(1, iv.Height))
	Next
	
End Sub

Public Sub getValue As Int
	Dim res As Int
	For i = 0 To mValue.Size - 1
		res = res + mValue.Get(i) * Power(10, i)
	Next
	Return res
End Sub
