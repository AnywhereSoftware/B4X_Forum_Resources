B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
#DesignerProperty: Key: ProgressColor, DisplayName: Progress Color, FieldType: Color, DefaultValue: 0xFF075DC0
#DesignerProperty: Key: Value, DisplayName: Value, FieldType: Int, DefaultValue: 100, Description: Value between 0 to 100
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 10
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private BusyBrush As BCBrush
	Private BackgroundColor As Int
	Private BusyIndex As Int
	Private bc As BitmapCreator
	Private mIV As B4XView
	Private TransparentBrush As BCBrush
	Private Vertical As Boolean
	Private CurrentValue As Float
	Public EmptyColor As Int = xui.Color_White
	Private EmptyBrush As BCBrush
	Private mValue As Int
	Public Tag As Object
	Public ValueChangePerSecond As Float = 60
	Public CornerRadius As Int
	Public BrushOffsetDelta As Int = 3
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	Dim iv As ImageView
	iv.Initialize("")
	mIV = iv
	mIV.Color = xui.Color_Transparent
	setValue(Props.GetDefault("Value", 100))
	CurrentValue = mValue
	mBase.AddView(mIV, 0, 0, 0, 0)
	mBase.AddView(lbl, 0, 0, mBase.Width, mBase.Height)
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	BackgroundColor = xui.PaintOrColorToColor(Props.Get("ProgressColor"))
	CornerRadius = Props.GetDefault("CornerRadius", 15)
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	For Each v As B4XView In mBase.GetAllViewsRecursive
		v.SetLayoutAnimated(0, 0, 0, Width, Height)
	Next
	bc.Initialize(mBase.Width / xui.Scale, mBase.Height / xui.Scale)
	Vertical = mBase.Height > mBase.Width
	UpdateGraphics
	
End Sub

Private Sub BusyLoop
	Dim MyIndex As Int = BusyIndex
	Dim r As B4XRect
	r.Initialize(0, 0, bc.mWidth, bc.mHeight)
	Dim LastTime As Long = DateTime.Now
	Do While MyIndex = BusyIndex
		If Vertical Then
			BusyBrush.SrcOffsetY = BusyBrush.SrcOffsetY + BrushOffsetDelta
		Else
			BusyBrush.SrcOffsetX = BusyBrush.SrcOffsetX + BrushOffsetDelta
		End If
		Dim tasks As List
		tasks.Initialize
		tasks.Add(bc.AsyncDrawRect(bc.TargetRect, TransparentBrush, True, 0))
		Dim delta As Float = mValue - CurrentValue
		If Abs(delta) <= 1 Then
			CurrentValue = mValue
		Else
			Dim change As Float = (DateTime.Now - LastTime) / 1000 * ValueChangePerSecond
			If delta > 0 Then
				CurrentValue = CurrentValue + Min(change, mValue - CurrentValue)
			Else
				CurrentValue = CurrentValue - Min(change, CurrentValue - mValue)
			End If
		End If
		LastTime = DateTime.Now
		If CurrentValue < 100 Then
			tasks.Add(bc.AsyncDrawRectRounded(bc.TargetRect, EmptyBrush, True, 0, CornerRadius))
		End If
		If Vertical Then
			r.Bottom = Round(CurrentValue / 100 * bc.mHeight)
		Else
			r.Right = Round(CurrentValue / 100 * bc.mWidth)
		End If
'		Log(CurrentValue & "-> " & mValue)
		tasks.Add(bc.AsyncDrawRectRounded(r, BusyBrush, True, 0, CornerRadius))
		bc.DrawBitmapCreatorsAsync(Me, "BC", tasks)
		Wait For BC_BitmapReady (bmp As B4XBitmap)
		If xui.IsB4J Then bmp = bc.Bitmap
		bc.SetBitmapToImageView(bmp, mIV)
		Sleep(30)
	Loop
End Sub

Public Sub getProgressColor As Int
	Return BackgroundColor
End Sub

Public Sub setProgressColor (c As Int)
	BackgroundColor = c
	UpdateGraphics
End Sub

Public Sub UpdateGraphics
	EmptyBrush = bc.CreateBrushFromColor(EmptyColor)
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	Dim Width As Int = 40
	Dim Template As BitmapCreator
	Dim bcolor As ARGBColor
	bc.ColorToARGB(BackgroundColor, bcolor)
	bcolor.r = Min(255, bcolor.r * 1.5)
	bcolor.g = Min(255, bcolor.g * 1.5)
	bcolor.b = Min(255, bcolor.b * 1.5)
	If Vertical Then
		Template.Initialize(mBase.Width / xui.Scale, mBase.Width / xui.Scale + Width)
	Else
		Template.Initialize(mBase.Height / xui.Scale + Width, mBase.Height / xui.Scale)
	End If
	
	Template.DrawRect(Template.TargetRect, BackgroundColor, True, 0)
	If Vertical Then
		Template.DrawLine(-Width / 2, Width / 2, Template.mWidth + Width / 2, Template.mHeight - Width / 2, bc.ARGBToColor(bcolor), Width)
	Else
		Template.DrawLine(Width / 2, -Width / 2, Template.mWidth - Width / 2, Template.mHeight + Width / 2, bc.ARGBToColor(bcolor), Width)
	End If
	BusyBrush = bc.CreateBrushFromBitmapCreator(Template)
	If mValue = 100 Then
		bc.DrawRectRounded(bc.TargetRect, BackgroundColor, True, 0, 15)
	Else
		bc.DrawRectRounded2(bc.TargetRect, EmptyBrush, True, 0, 15)
	End If
	bc.SetBitmapToImageView(bc.Bitmap, mIV)
	setVisible(mBase.Visible)
End Sub


Public Sub setVisible(b As Boolean)
	BusyIndex = BusyIndex + 1
	If b Then
		BusyLoop
	End If
	mBase.Visible = b
End Sub

Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub

Public Sub getValue As Int
	Return mValue
End Sub

Public Sub setValue (v As Int)
	mValue = Max(0, Min(100, v))
End Sub

Public Sub SetValueNoAnimation (v As Int)
	setValue(v)
	CurrentValue = mValue
End Sub