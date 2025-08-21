B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.33
@EndOfDesignText@
#DesignerProperty: Key: Items, DisplayName: Items, FieldType: String, DefaultValue: Drive|Folder|File
#DesignerProperty: Key: CrumbColor, DisplayName: Crumb Color, FieldType: Color, DefaultValue: 0xFF075DC0
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: True, Description: Whether to make a haptic feedback when the user clicks on the control.
#Event: CrumbClick (Crumbs As List)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cvs As B4XCanvas
	Private mItems As List
	Private RightPositions As List
	Public TextColor As Int
	Public fnt As B4XFont
	Private offset As Int = 10dip
	Private bc As BitmapCreator
	Public CrumbColor As Int
	Private TouchPanel As B4XView
	Private PressedItem As Int = -1
	Public Tag As Object
	Public mHaptic As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	mItems.Initialize
	RightPositions.Initialize
	bc.Initialize(1, 1)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	cvs.Initialize(mBase)
	Dim xlbl As B4XView = Lbl
	fnt = xlbl.Font
	TextColor = xlbl.TextColor
	CrumbColor = xui.PaintOrColorToColor(Props.Get("CrumbColor"))
	mHaptic = Props.GetDefault("HapticFeedback", False)
	TouchPanel = xui.CreatePanel("Touch")
	mBase.AddView(TouchPanel, 0, 0, mBase.Width, mBase.Height)
	Dim items As String = Props.Get("Items")
	For Each s As String In Regex.Split("\|", items)
		mItems.Add(s)
	Next
	Draw
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	TouchPanel.SetLayoutAnimated(0, 0, 0, Width, Height)
	Draw
End Sub

Private Sub Draw
	cvs.ClearRect(cvs.TargetRect)
	Dim bcolor As ARGBColor
	bc.ColorToARGB(CrumbColor, bcolor)
	bcolor.r = Min(255, bcolor.r * 2)
	bcolor.g = Min(255, bcolor.g * 2)
	bcolor.b = Min(255, bcolor.b * 2)
	Dim strokeColor As Int = bc.ARGBToColor(bcolor)
	
	bc.ColorToARGB(CrumbColor, bcolor)
	bcolor.r = bcolor.r * 0.8
	bcolor.g = bcolor.g * 0.8
	bcolor.b = bcolor.b * 0.8
	Dim Clrs() As Int = Array As Int(CrumbColor, bc.ARGBToColor(bcolor))
	
	RightPositions.Clear
	If mItems.Size = 0 Then Return
	Dim Left As Int = 0
	For i = 0 To mItems.Size - 1
		Dim sc As Int
		If PressedItem = i Then sc = strokeColor Else sc = 0
		Dim width As Int = DrawItem(Left, mItems.Get(i), i = 0, i = mItems.Size - 1, Clrs(i Mod Clrs.Length), sc)
		Left = Left + width + offset + 2dip
		RightPositions.Add(Left)
	Next
	cvs.Invalidate
End Sub

Private Sub DrawItem(Left As Int, Text As String, First As Boolean, Last As Boolean, clr As Int, strokeColor As Int) As Int
	Dim r As B4XRect = cvs.MeasureText(Text, fnt)
	Dim ItemWidth As Int = r.Width + 30dip
	Dim ItemHeight As Int = cvs.TargetRect.Height
	Dim BaseLine As Int = cvs.TargetRect.CenterY - r.Height / 2 - r.Top
	Dim p As B4XPath
	p.Initialize(Left, 0)
	p.LineTo(Left + ItemWidth, 0)
	If Last = False Then
		p.LineTo(Left + ItemWidth + offset, ItemHeight / 2)
	End If
	p.LineTo(Left + ItemWidth, ItemHeight)
	If First = False Then
		p.LineTo(Left - offset, ItemHeight)
		p.LineTo(Left, ItemHeight / 2)
		p.LineTo(Left - offset, 0)
	Else
		p.LineTo(Left, ItemHeight)
	End If
	p.LineTo(Left, 0)
	cvs.DrawPath(p, clr, True, 0)
	If strokeColor <> 0 Then
		cvs.DrawPath(p, strokeColor, False, 3dip)
	End If
	
	cvs.DrawText(Text, Left + ItemWidth / 2, BaseLine, fnt, TextColor, "CENTER")
	Return ItemWidth
End Sub

Private Sub Touch_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case TouchPanel.TOUCH_ACTION_DOWN, TouchPanel.TOUCH_ACTION_MOVE
			Dim prev As Int = PressedItem
			PressedItem = FindItem(X, Y)
			If prev <> PressedItem Then Draw
		Case TouchPanel.TOUCH_ACTION_UP
			Dim index As Int = FindItem(X, Y)
			If index = PressedItem And index > -1 Then
				Dim Items As List
				Items.Initialize
				For i = 0 To index
					Items.Add(mItems.Get(i))
				Next
				If mHaptic Then XUIViewsUtils.PerformHapticFeedback(mBase)
				CallSub2(mCallBack, mEventName & "_CrumbClick", Items)
			End If
			PressedItem = -1
			Draw
	End Select
End Sub

Private Sub FindItem (x As Int, y As Int) As Int
	If RightPositions.Size = 0 Then Return -1
	If y < 0 Or y > cvs.TargetRect.Height Then Return -1
	Dim r As Int = RightPositions.Get(RightPositions.Size - 1)
	If x > r Then Return -1
	For i = RightPositions.Size - 2 To 0 Step -1
		Dim r As Int = RightPositions.Get(i)
		If x > r Then Return i + 1
	Next
	Return 0
End Sub

Public Sub setItems (i As List)
	mItems = i
	Draw
End Sub

Public Sub getItems As List
	Return mItems
End Sub