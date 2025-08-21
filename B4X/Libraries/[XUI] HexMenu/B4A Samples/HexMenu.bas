B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
'version: 1.00
#Event: Click (Index As Int, Text As String)
#DesignerProperty: Key: FillColor, DisplayName: Fill Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: StrokeColor, DisplayName: StrokeColor, FieldType: Color, DefaultValue: 0xFF434343
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private bc As BitmapCreator
	Private iv As B4XView
	Public Items As List
	Private Centers As List
	Public labels As List
	Private pnl As B4XView
	Private UpdatedCenters As List
	Public StrokeColor As Int
	Public FillColor As Int
	Public PressedFilledColor As Int = xui.Color_Black
	Public PressedTextColor As Int = xui.Color_White
	Private TextColor As Int
	Private PressedIndex as Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Items.Initialize
	Dim s As Float = CosD(30)
	Centers.Initialize
	Centers.Add(Array As Float(0, 0))
	Centers.Add(Array As Float(-1.5, -s))
	Centers.Add(Array As Float(0, -2 * s))
	Centers.Add(Array As Float(1.5, -1 * s))
	Centers.Add(Array As Float(1.5, 1 * s))
	Centers.Add(Array As Float(0, 2 * s))
	Centers.Add(Array As Float(-1.5, 1 * s))
	labels.Initialize
	UpdatedCenters.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	StrokeColor = xui.PaintOrColorToColor(Props.Get("StrokeColor"))
	FillColor = xui.PaintOrColorToColor(Props.Get("FillColor"))
	Dim iv1 As ImageView
	iv1.Initialize("")
	iv = iv1
	mBase.AddView(iv, 0, 0, 0, 0)
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	Dim origLabel As B4XView = Lbl
	TextColor = origLabel.TextColor
	For i = 0 To Centers.Size - 1
		Dim NewLabel As Label
		NewLabel.Initialize("")
		Dim xlbl As B4XView = NewLabel
		xlbl.TextSize = origLabel.TextSize
		xlbl.TextColor = TextColor
		xlbl.SetTextAlignment("CENTER", "CENTER")
		mBase.AddView(xlbl, 0, 0, 0, 0)
		labels.Add(xlbl)
	Next
	pnl = xui.CreatePanel("pnl")
	mBase.AddView(pnl, 0, 0, 0, 0)
	If mBase.Width > 0 Then Base_Resize(mBase.Width, mBase.Height)
End Sub

Public Sub Update
	bc.DrawRect(bc.TargetRect, xui.Color_Transparent, True, 0)
	Dim h As Int = Min(iv.Height,  iv.Width) 
	Dim r As Float = (h - 6dip) / 6
	UpdatedCenters.Clear
	For i = 0 To Centers.Size - 1
		Dim c() As Float = Centers.Get(i)
		Dim cx As Float = c(0) * r + h / 2
		Dim cy As Float = c(1) * r + h / 2
		Dim lbl As B4XView = labels.Get(i)
		If i <= Items.Size - 1 Then
			lbl.Text = Items.Get(i)
			lbl.SetLayoutAnimated(0, iv.Left + (cx - r), iv.Top + (cy - r), (r  * 2), (r * 2))
			UpdatedCenters.Add(Array As Float(cx, cy))
			DrawCell(cx + 0.5, cy + 0.5, r + 0.5, FillColor, StrokeColor, 4dip)
		Else
			lbl.Text = ""
		End If
	Next
	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Dim mn As Double = Min(Width, Height)
	iv.SetLayoutAnimated(0, Width / 2 - mn / 2, Height / 2 - mn / 2, mn, mn)
	pnl.SetLayoutAnimated(0, iv.Left, iv.Top, iv.Width, iv.Height)
	bc.Initialize(iv.Width, iv.Height)
	Update
End Sub

Private Sub DrawCell (CenterX As Int, CenterY As Int, Radius As Int, vFillColor As Int, vStrokeColor As Int, Thickness As Int)
	Dim s As Float = Radius * CosD(30)
	Dim p As BCPath
	p.Initialize(CenterX - Radius / 2, CenterY - s)
	p.LineTo(CenterX + Radius / 2, CenterY - s)
	p.LineTo(CenterX + Radius, CenterY)
	p.LineTo(CenterX + Radius / 2, CenterY + s)
	p.LineTo(CenterX - Radius / 2, CenterY + s).LineTo(CenterX - Radius, CenterY)
	bc.DrawPath(p, vFillColor, True, 0)
	bc.DrawPath(p, vStrokeColor, False, Thickness)
End Sub

Private Sub Pnl_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnl.TOUCH_ACTION_DOWN Then
		Dim h As Int = Min(iv.Height,  iv.Width)
		Dim r As Float = (h - 6dip) / 6
		Dim MinR As Float = r * 1000
		Dim MinI As Int
		For i = 0 To UpdatedCenters.Size - 1
			Dim cc() As Float = UpdatedCenters.Get(i)
			Dim dist As Float = Sqrt(Power(cc(0) - x, 2) + Power(cc(1) - y, 2))
			If dist < MinR Then
				MinR = dist
				MinI = i
			End If
		Next
		If MinR < r Then
			Dim cc() As Float = UpdatedCenters.Get(MinI)
			DrawCell(cc(0) + 0.5, cc(1) + 0.5, r + 0.5, PressedFilledColor, StrokeColor, 3dip)
			Dim lbl As B4XView = labels.Get(MinI)
			lbl.TextColor = PressedTextColor
			bc.SetBitmapToImageView(bc.Bitmap, iv)
			CallSub3(mCallBack, mEventName & "_Click", MinI, Items.Get(MinI))
			PressedIndex = PressedIndex + 1
			Dim MyIndex As Int = PressedIndex
			Sleep(100)
			lbl.TextColor = TextColor
			If MyIndex <> PressedIndex Then Return
			Update
		End If
	End If
End Sub

