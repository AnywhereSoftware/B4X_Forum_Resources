B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#DesignerProperty: Key: Value, DisplayName: Value, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: OnColor, DisplayName: On Color, FieldType: Color, DefaultValue: #FF00D254
#DesignerProperty: Key: OffColor, DisplayName: Off Color, FieldType: Color, DefaultValue: #FFCACACA
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: True, Description: Whether to make a haptic feedback when the user clicks on the control.
#Event: ValueChanged (Value As Boolean)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private mPanel As B4XView
	Private xui As XUI 'ignore
	Private mOnColor, mOffColor As BCBrush
	Private bc As BitmapCreator
	Private Width As Int = 55dip
	Private Height As Int = 31dip
	Private mThumbColor As BCBrush
	Private iv As ImageView
	Private mValue As Boolean
	Private transparent As BCBrush
	Private LoopIndex As Int
	Public Tag As Object
	Private Scale As Float
	Private mEnabled As Boolean = True
	Public mHaptic As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

public Sub setOnColor(color As Object)
	mOnColor = bc.CreateBrushFromColor(color)
	SetValueImpl(mValue,True)
End Sub

public Sub setOffColor(color As Object)
	mOffColor = bc.CreateBrushFromColor(color)
	SetValueImpl(mValue,True)
End Sub

public Sub setThumbColor(color As Object)
	mThumbColor = bc.CreateBrushFromColor(color)
	SetValueImpl(mValue,True)
End Sub

'SWTPDM
Public Sub getPanel() As B4XView
	Return mPanel
End Sub
' End SWTPDM

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, Width, Height)
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	mPanel = xui.CreatePanel("pnl")
	mPanel.Color = xui.Color_Transparent
	iv.Initialize("")
	mBase.AddView(iv, 0, 0, Width, Height)
	mBase.AddView(mPanel, 0, 0, Width, Height)
	#if B4J or B4A
	bc.Initialize(Width, Height)
	Scale = xui.Scale
	#else if B4i
	Scale = GetDeviceLayoutValues.NonnormalizedScale
	bc.Initialize(Round(Width * Scale), Round(Height * Scale))
	#End If
	mOnColor = bc.CreateBrushFromColor(xui.PaintOrColorToColor(Props.Get("OnColor")))
	mOffColor = bc.CreateBrushFromColor(xui.PaintOrColorToColor(Props.Get("OffColor")))
	mThumbColor = bc.CreateBrushFromColor(xui.PaintOrColorToColor(Props.Get("ThumbColor")))
	mHaptic = Props.GetDefault("HapticFeedback", False)
	transparent = bc.CreateBrushFromColor(xui.Color_Transparent)
	mEnabled = mBase.Enabled
	mBase.Enabled = True
	SetValueImpl(Props.Get("Value"), True)
End Sub

'Private Sub pnl_Touch (Action As Int, X As Float, Y As Float)
'	If Action = mBase.TOUCH_ACTION_UP And x > 0 And x < Width And y > 0 And y < Height Then
'		
'	End If
'End Sub

#if B4J
Private Sub Pnl_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#else
Private Sub pnl_Click
#end if
	If mEnabled Then
		If mHaptic Then XUIViewsUtils.PerformHapticFeedback(mBase)
		SetValueImpl(Not(mValue), False)
		If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
			CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", mValue)
		End If
	End If
End Sub

Private Sub SetValueImpl(b As Boolean, Immediate As Boolean)
	mValue = b
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
		XUIViewsUtils.SetAlpha(mBase, 0.6)
	End If
End Sub

Public Sub setValue(b As Boolean)
	If b = mValue Then Return
	SetValueImpl(b, False)
End Sub

Public Sub getValue As Boolean
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
	Dim r As Float = Round(bc.mHeight / 2)
	Dim cx As Float = r - 1 * Scale + (bc.mWidth - 2 * r) * State
	If State = 0 Then
		cx = r
	Else If State = 1 Then
		cx = Round(bc.mWidth - 1 * Scale - r)
	End If
	Dim cy As Int = bc.mHeight / 2
	Dim smallrect As B4XRect
	Dim w As Float = State * bc.mWidth
	Dim h As Float = State * bc.mHeight
	If State < 1 Then bc.DrawRectRounded2(bc.TargetRect, mOffColor, True, 2 * Scale, r)
	smallrect.Initialize(bc.mWidth / 2 - w / 2, cy - h / 2, bc.mWidth / 2 + w / 2, cy + h / 2)
	If State > 0 Then bc.DrawRectRounded2(smallrect, mOnColor, True, 2 * Scale, smallrect.Height / 2)
	If mEnabled Then
		bc.DrawCircle2(cx, cy, r - 2 * Scale, mThumbColor, True, 0)
	End If
	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub

Private Sub Base_Resize (Width1 As Double, Height1 As Double)
  
End Sub