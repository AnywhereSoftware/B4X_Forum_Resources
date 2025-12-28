B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'Version 1.00
#DesignerProperty: Key: Color, DisplayName: Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: IndicatorStyle, DisplayName: Style, FieldType: String, DefaultValue: Three Circles 1, List: Three Circles 1|Three Circles 2|Single Circle|Five Lines 1|Arc 1|Arc 2|PacMan
#DesignerProperty: Key: Duration, DisplayName: Duration, FieldType: Int, DefaultValue: 1000


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public IndicatorColor As Int
	Private index As Int
	Private cvs As B4XCanvas
	Public Duration As Int
	Private DrawingSubName As String
	Public Tag As Object
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
  	IndicatorColor = xui.PaintOrColorToColor(Props.Get("Color")) 
	Dim style As String = Props.Get("IndicatorStyle")
	Duration = Props.Get("Duration")
	SetStyle(style)
	cvs.Initialize(mBase)
	MainLoop
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	MainLoop
End Sub

'Sets the indicator style. One of the following values:
'Three Circles 1, Three Circles 2, Single Circle, Five Lines 1, Arc 1, Arc 2, PacMan
Public Sub SetStyle(Style As String)
	DrawingSubName = "Draw_" & Style.Replace(" ", "")
End Sub


Private Sub MainLoop
	index = index + 1
	Dim MyIndex As Int = index
	Dim n As Long = DateTime.Now
	Do While MyIndex = index
		Dim progress As Float = (DateTime.Now - n) / Duration
		progress = progress - Floor(progress)
		cvs.ClearRect(cvs.TargetRect)
		CallSub2(Me, DrawingSubName, progress)
		cvs.Invalidate
		Sleep(10)
	Loop
End Sub

Public Sub Show
	mBase.Visible = True
	MainLoop
End Sub

Public Sub Hide
	mBase.Visible = False
	index = index + 1
End Sub

Private Sub Draw_ThreeCircles1 (Progress As Float)
	Dim MaxR As Float = (cvs.TargetRect.Width / 2 - 20dip) / 2
	Dim r As Float = 10dip + MaxR + MaxR * Sin(Progress * 2 * cPI)
	For i = 0 To 2
		Dim alpha As Int = i * 120 + Progress * 360
		'alpha = -alpha
		cvs.DrawCircle(cvs.TargetRect.CenterX + r * SinD(alpha), cvs.TargetRect.CenterY + r * CosD(alpha), 7dip, IndicatorColor, True, 1dip)
	Next
End Sub

Private Sub Draw_ThreeCircles2 (Progress As Float)
	Dim MinR As Int = 5dip
	Dim MaxR As Int = cvs.TargetRect.Width / 2 / 3 - MinR -2dip
	For i = 0 To 2
		Dim r As Float = MinR + MaxR / 2 + MaxR / 2 * SinD(Progress * 360 - 60 * i)
		cvs.DrawCircle(MaxR + MinR + (MinR + MaxR + 2dip) * 2 * i, cvs.TargetRect.CenterY, r, IndicatorColor, True, 0)
	Next
End Sub

Private Sub Draw_SingleCircle(Progress As Float)
	For i = 0 To 2
		cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.CenterX * Progress, SetAlpha(IndicatorColor, 255 - 255 * Progress), True, 0)
	Next
End Sub

Private Sub SetAlpha (c As Int, alpha As Int) As Int
	Return Bit.And(0xffffff, c) + Bit.ShiftLeft(alpha, 24)
End Sub

Private Sub Draw_FiveLines1(Progress As Float)
	Dim MinR As Int = 10dip
	Dim MaxR As Int = cvs.TargetRect.Height / 2
	Dim dx As Int = (cvs.TargetRect.Width - 2dip) / 5
	For i = 0 To 4
		Dim r As Float = MinR + MaxR / 2 + MaxR / 2 * SinD(Progress * 360 - 30 * i)
		cvs.DrawLine(2dip + i * dx, cvs.TargetRect.CenterY - r, 2dip + i * dx, cvs.TargetRect.CenterY + r, IndicatorColor, 4dip)
	Next
End Sub

Private Sub Draw_Arc1 (Progress As Float)
	Dim p As B4XPath
	Dim r As Float = cvs.TargetRect.CenterX - 5dip
	If Progress < 0.5 Then
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, Progress * 2 * 360)
	Else
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, -(1 - Progress) * 2 * 360)
	End If
	cvs.ClipPath(p)
	cvs.DrawRect(cvs.TargetRect, IndicatorColor, True, 0)
	cvs.RemoveClip
End Sub

Private Sub Draw_Arc2 (Progress As Float)
	Dim p As B4XPath
	Dim r As Float = cvs.TargetRect.CenterX - 5dip
	If Progress < 0.5 Then
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, Progress * 2 * 360)
	Else
		p.InitializeArc(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, r, -90, 360 - (Progress - 0.5) * 2 * 360)
	End If
	cvs.ClipPath(p)
	cvs.DrawRect(cvs.TargetRect, IndicatorColor, True, 0)
	cvs.RemoveClip
End Sub

Private Sub Draw_PacMan(Progress As Float)
	Dim DotR As Int = 5dip
	cvs.DrawCircle(cvs.TargetRect.Width - DotR - Progress * (cvs.TargetRect.CenterX - 10dip), cvs.TargetRect.CenterY, DotR, SetAlpha(IndicatorColor, 255 - 200 * Progress), True, 0)
	Dim p As B4XPath
	Dim angle As Int = 70 * SinD(Progress * 180)
	Dim cx As Int = cvs.TargetRect.CenterX - 5dip
	Dim cy As Int = cvs.TargetRect.CenterY
	Dim r As Int = cvs.TargetRect.CenterY - 5dip
	If angle = 0 Then
		cvs.DrawCircle(cx, cy, r, IndicatorColor, True, 0)
	Else
		p.InitializeArc(cx, cy , r, -angle / 2, -(360-angle))
		cvs.ClipPath(p)
		cvs.DrawRect(cvs.TargetRect, IndicatorColor, True, 0)
		cvs.RemoveClip
	End If

End Sub


