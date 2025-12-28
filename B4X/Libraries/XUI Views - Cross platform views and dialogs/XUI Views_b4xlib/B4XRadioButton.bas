B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
#DesignerProperty: Key: Value, DisplayName: Checked, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: OnColor, DisplayName: On Color, FieldType: Color, DefaultValue: #FF00D254
#DesignerProperty: Key: OffColor, DisplayName: Off Color, FieldType: Color, DefaultValue: #FFCACACA
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: True, Description: Whether to make a haptic feedback when the user clicks on the control.
#Event: Checked
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public OnColor, OffColor As Int
	Private bc As BitmapCreator
	Private iv As B4XView
	Private mValue As Boolean
	Private transparent As BCBrush
	Private LoopIndex As Int
	Public Tag As Object
	Private OnBrush, OffBrush As BCBrush
	Private mEnabled As Boolean = True
	Public mHaptic As Boolean
	Private Size As Int
	Public mLabel As B4XView
	Private pnl As B4XView
	Private Scale As Float 'ignore
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	pnl = xui.CreatePanel("pnl")
	pnl.Color = xui.Color_Transparent
	Dim iiv As ImageView
	iiv.Initialize("")
	iv = iiv
	mBase.AddView(iv, 0, 0, 0, 0)
	mLabel = Lbl
	mLabel.SetTextAlignment("CENTER", "LEFT")
	mBase.AddView(mLabel, 0, 0, 0, 0)
	mBase.AddView(pnl, 0, 0, 0, 0)
	
	OnColor = xui.PaintOrColorToColor(Props.Get("OnColor"))
	OffColor = xui.PaintOrColorToColor(Props.Get("OffColor"))
	mHaptic = Props.GetDefault("HapticFeedback", False)
	
	mEnabled = mBase.Enabled
	mBase.Enabled = True
	mValue = Props.Get("Value")
	Base_Resize(mBase.Width, mBase.Height)
End Sub


Private Sub Base_Resize (Width1 As Double, Height1 As Double)
	Dim NewSize As Int = Max(5dip, Height1)
	If NewSize = Size Then Return
	Size = NewSize
	Dim gap As Int = 3dip
  #if B4J or B4A
	bc.Initialize(NewSize - 2 * gap, NewSize - 2 * gap)
	Scale = xui.Scale
	#else if B4i
	Scale = GetDeviceLayoutValues.NonnormalizedScale
	bc.Initialize(Round(NewSize * Scale), Round(NewSize * Scale))
	#End If
	iv.SetLayoutAnimated(0, gap, gap, Size - 2 * gap, Size - 2 * gap)
	pnl.SetLayoutAnimated(0, 0, 0, Width1, Height1)
	mLabel.SetLayoutAnimated(0, Size + gap, 0, Width1 - Size - gap, Height1)
	OnBrush = bc.CreateBrushFromColor(OnColor)
	OffBrush = bc.CreateBrushFromColor(OffColor)
	transparent = bc.CreateBrushFromColor(xui.Color_Transparent)
	SetValueImpl(mValue, True)
End Sub



#if B4J
Private Sub Pnl_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#else
Private Sub pnl_Click
#end if
	If mValue Then Return
	If mEnabled Then
		If mHaptic Then XUIViewsUtils.PerformHapticFeedback(mBase)
		SetValueImpl(Not(mValue), False)
		If mValue And xui.SubExists(mCallBack, mEventName & "_Checked", 0) Then
			CallSubDelayed(mCallBack, mEventName & "_Checked")
		End If
	End If
End Sub

Private Sub SetValueImpl(b As Boolean, Immediate As Boolean)
	mValue = b
	If b = True Then
		For i = 0 To mBase.Parent.NumberOfViews - 1
			Dim v As B4XView = mBase.Parent.GetView(i)
			If v <> mBase And v.Tag Is B4XRadioButton Then
				Dim rb As B4XRadioButton = v.Tag
				rb.Checked = False
			End If
		Next
	End If
	LoopIndex = LoopIndex + 1
	If Immediate Then
		If mValue Then Draw(1) Else Draw(0)
	Else
		Dim MyIndex As Int = LoopIndex
		Dim start As Long = DateTime.Now
		Dim duration As Int = 200
		Do While DateTime.Now < start + duration
			Dim state1 As Float = (DateTime.Now - start) / duration
			If mValue = False Then state1 = 1 - state1
			Draw(state1)
			Sleep(16)
			If MyIndex <> LoopIndex Then Exit
		Loop
		If MyIndex = LoopIndex Then
			If mValue Then Draw(1) Else Draw(0)
		End If
	End If
	If mEnabled Then
		XUIViewsUtils.SetAlpha(mBase, 1)
	Else
		XUIViewsUtils.SetAlpha(mBase, 0.4)
	End If
	
End Sub

Public Sub setChecked(b As Boolean)
	If b = mValue Then Return
	SetValueImpl(b, False)
End Sub

Public Sub getChecked As Boolean
	Return mValue
End Sub

Public Sub setEnabled (b As Boolean)
	mEnabled = b
	SetValueImpl(mValue, True)
End Sub

Public Sub getEnabled As Boolean
	Return mEnabled
End Sub

Private Sub Draw (State As Float)
	bc.DrawRect2(bc.TargetRect, transparent, True, 0)
	Dim r As Float = Floor(bc.mHeight / 2)
	If State < 1 Then bc.DrawCircle2(r, r, r, OffBrush, True, 0)
	If State > 0 Then bc.DrawCircle2(r, r, r * State, OnBrush, True, 0)
	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub

Public Sub setText (t As Object)
	XUIViewsUtils.SetTextOrCSBuilderToLabel(mLabel, t)
End Sub

Public Sub getText As Object
	Return mLabel.Text
End Sub