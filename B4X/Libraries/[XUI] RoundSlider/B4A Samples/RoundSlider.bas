B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
#DesignerProperty: Key: ValueColor, DisplayName: Value Color, FieldType: Color, DefaultValue: 0xFF0061FF
#DesignerProperty: Key: Min, DisplayName: Minimum, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: Max, DisplayName: Maximum, FieldType: Int, DefaultValue: 100

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cvs As B4XCanvas
	Private mValue As Int = 75
	Private mMin, mMax As Int
	Private thumb As B4XBitmap
	Private pnl As B4XView
	Private xlbl As B4XView
	Private CircleRect As B4XRect
	Private ValueColor As Int
	Private stroke As Int
	Private ThumbSize As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	cvs.Initialize(mBase)
	mMin = Props.Get("Min")
	mMax = Props.Get("Max")
	pnl = xui.CreatePanel("pnl")
	xlbl = Lbl
	mBase.AddView(xlbl, 0, 0, 0, 0)
	mBase.AddView(pnl, 0, 0, 0, 0)
	ValueColor = xui.PaintOrColorToColor(Props.Get("ValueColor"))
	If xui.IsB4A Or xui.IsB4i Then
		stroke = 8dip
	Else If xui.IsB4J Then
		stroke = 6dip
	End If
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub CreateThumb
	'to provide smoother result, the thumb is drawn twice the desired size.
	Dim p As B4XPath
	Dim r As Int = 40dip
	Dim g As Int = 4dip
	Dim l As Int = 14dip
	p.Initialize(r - l + g, 2 * r - 2dip + g)
	p.LineTo(r + l + g, 2 * r - 2dip + g)
	p.LineTo(r + g, 2 * r + l + g)
	p.LineTo(r - l + g, 2 * r - 2dip + g)
	cvs.ClearRect(cvs.TargetRect)
	cvs.DrawPath(p, 0xFF5B5B5B, True, 0)
	cvs.DrawCircle(r + g, r + g, r, xui.Color_White, True, 0)
	cvs.DrawCircle(r + g, r + g, r, 0xFF5B5B5B, False, 5dip)
	thumb = cvs.CreateBitmap.Crop(0, 0, 2 * r + g + 3dip, 2 * r + l + g)
	ThumbSize = thumb.Height / 2
	xlbl.SetTextAlignment("CENTER", "CENTER")
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	pnl.SetLayoutAnimated(0, 0, 0, Width, Height)
	If thumb.IsInitialized = False Then CreateThumb
	CircleRect.Initialize(ThumbSize + stroke, ThumbSize + stroke, Width - ThumbSize - stroke, Height - ThumbSize - stroke)
	xlbl.SetLayoutAnimated(0, CircleRect.Left, CircleRect.Top, CircleRect.Width, CircleRect.Height)
	Draw
End Sub

Private Sub Draw
	cvs.ClearRect(cvs.TargetRect)
	Dim radius As Int = CircleRect.Width / 2
	cvs.DrawCircle(CircleRect.CenterX, CircleRect.CenterY, radius, 0xFFB6B6B6, False, stroke)
	Dim p As B4XPath
	Dim angle As Int = (mValue - mMin) / (mMax - mMin) * 360
	Dim B4JStrokeOffset As Int
	If xui.IsB4J Then B4JStrokeOffset = stroke / 2
	p.InitializeArc(CircleRect.CenterX, CircleRect.CenterY, radius + B4JStrokeOffset, -90, angle)
	cvs.DrawPath(p, ValueColor, False, stroke)
	cvs.DrawCircle(CircleRect.CenterX, CircleRect.CenterY, radius - B4JStrokeOffset, xui.Color_White, True, 0)
	Dim dest As B4XRect
	Dim r As Int = radius + ThumbSize / 2 + stroke / 2
	Dim cx As Int = CircleRect.CenterX + r * CosD(angle-90)
	Dim cy As Int = CircleRect.CenterY + r * SinD(angle-90)
	dest.Initialize(cx - thumb.Width / 4, cy - ThumbSize / 2, cx + thumb.Width / 4, cy + ThumbSize / 2)
	cvs.DrawBitmapRotated(thumb, dest, angle)
	cvs.Invalidate
	xlbl.Text = mValue
End Sub

Private Sub pnl_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnl.TOUCH_ACTION_MOVE_NOTOUCH Then Return
	Dim dx As Int = x - CircleRect.CenterX
	Dim dy As Int = y - CircleRect.CenterY
	Dim dist As Float = Sqrt(Power(dx, 2) + Power(dy, 2))
	If dist > CircleRect.Width / 2 Then
		Dim angle As Int = Round(ATan2D(dy, dx))
		angle = angle + 90
		angle = (angle + 360) Mod 360
		mValue = mMin + angle / 360 * (mMax - mMin)
		mValue = Max(mMin, Min(mMax, mValue))
		Draw
	End If
End Sub

Public Sub setValue (v As Int)
	mValue = Max(mMin, Min(mMax, v))
	Draw
End Sub

Public Sub getValue As Int
	Return mValue
End Sub