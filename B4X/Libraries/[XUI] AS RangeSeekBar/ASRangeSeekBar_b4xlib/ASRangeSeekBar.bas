B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFix - set Value2 was linked to the wrong variable
V1.02
	-Base_Resize is public now
#End If

#DesignerProperty: Key: ReachedLineColor , DisplayName: Reached Line Color , FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: UnreachedLineColor, DisplayName: Unreached Line Color, FieldType: Color, DefaultValue: 0x98FFFFFF
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0x64FFFFFF
#DesignerProperty: Key: Interval, DisplayName: Interval, FieldType: Int, DefaultValue: 1
#DesignerProperty: Key: Min, DisplayName: Minimum, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: Max, DisplayName: Maximum, FieldType: Int, DefaultValue: 100
#DesignerProperty: Key: Value1, DisplayName: Value 1, FieldType: Int, DefaultValue: 50
#DesignerProperty: Key: Value2, DisplayName: Value 2, FieldType: Int, DefaultValue: 100
#Event: ValueChanged (Value1 As Int,Value2 As Int)
#Event: TouchStateChanged (Pressed As Boolean)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public ReachedLineColor , UnreachedLineColor, ThumbColor As Int
	Private cvs As B4XCanvas
	Public Tag As Object
	Private TouchPanel As B4XView
	Private mValue1,mValue2 As Int
	Public MinValue, MaxValue As Int
	Public Interval As Int = 1
	Private Vertical As Boolean
	Public ReachedLineSize = 4dip, UnreachedLineSize = 2dip, Radius1 = 6dip, Radius2 = 20dip As Int
	Private Pressed,PressedLeftThumb,PressedTopThumb As Boolean
	Private size As Int
	Private s1,s2 As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	ReachedLineColor = xui.PaintOrColorToColor(Props.Get("ReachedLineColor"))
	UnreachedLineColor = xui.PaintOrColorToColor(Props.Get("UnreachedLineColor"))
	ThumbColor = xui.PaintOrColorToColor(Props.Get("ThumbColor"))
	Interval = Max(1, Props.GetDefault("Interval", 1))
	MinValue = Props.Get("Min")
	MaxValue = Props.Get("Max")
	mValue1 = Max(MinValue, Min(MaxValue, Props.Get("Value1")))
	mValue2 = Max(MinValue, Min(MaxValue, Props.Get("Value2")))
	cvs.Initialize(mBase)
	TouchPanel = xui.CreatePanel("TouchPanel")
	mBase.AddView(TouchPanel, 0, 0, mBase.Width, mBase.Height)
	#If B4A
	Base_Resize(mBase.Width, mBase.Height)
	#End If
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
 	cvs.Resize(Width, Height)
	TouchPanel.SetLayoutAnimated(0, 0, 0, Width, Height)
	Vertical = mBase.Height > mBase.Width
	size = Max(mBase.Height, mBase.Width) - 2 * Radius2
	Update
End Sub

'Redraws the control
Public Sub Update
	
	cvs.ClearRect(cvs.TargetRect)
	If size > 0 Then
		If Vertical = False Then
			s1 = Radius2 + (mValue1 - MinValue) / (MaxValue - MinValue) * size
			s2 = Radius2 + (mValue2 - MinValue) / (MaxValue - MinValue) * size
			
			Dim y As Int = mBase.Height / 2
			cvs.DrawLine(Radius2, y, mBase.Width - Radius2, y, UnreachedLineColor, UnreachedLineSize)
			cvs.DrawLine(s1, y, s2, y, ReachedLineColor , ReachedLineSize)
			
			cvs.DrawCircle(s1, y, Radius1, ReachedLineColor , True, 0) 'Left Thumb
			cvs.DrawCircle(s2, y, Radius1, ReachedLineColor , True, 0) 'Right Thumb
			If Pressed = True And PressedLeftThumb = True Then
				cvs.DrawCircle(s1, y, Radius2, ThumbColor, True, 0)
			else If Pressed = True And PressedLeftThumb = False Then
				cvs.DrawCircle(s2, y, Radius2, ThumbColor, True, 0)
			End If
		Else
			s1 = Radius2 + (MaxValue - mValue1 - MinValue) / (MaxValue - MinValue) * size
			s2 = Radius2 + (MaxValue - mValue2 - MinValue) / (MaxValue - MinValue) * size
			Dim x As Int = mBase.Width / 2
			cvs.DrawLine(x, Radius2, x, mBase.height - Radius2, UnreachedLineColor, UnreachedLineSize)
			cvs.DrawLine(x, s1, x,s2, ReachedLineColor , ReachedLineSize)
			
			cvs.DrawCircle(x, s1, Radius1, ReachedLineColor , True, 0)
			cvs.DrawCircle(x, s2, Radius1, ReachedLineColor , True, 0)
			If Pressed And PressedTopThumb = True Then
				cvs.DrawCircle(x, s1, Radius2, ThumbColor, True, 0)
			else If Pressed = True And PressedTopThumb = False Then
				cvs.DrawCircle(x, s2, Radius2, ThumbColor, True, 0)
			End If
		End If
	End If
	cvs.Invalidate
End Sub

Private Sub TouchPanel_Touch (Action As Int, X As Float, Y As Float)
	If Action = TouchPanel.TOUCH_ACTION_DOWN Then
		If Vertical = False Then
			If x <= (s1 + Radius1) And x <= (s2 + Radius1) Then
				PressedLeftThumb = True
			Else
				PressedLeftThumb = False
			End If
		Else
			If y >= (s1 - Radius1) And y >= (s2 - Radius1) Then
				PressedTopThumb = True
			Else
				PressedTopThumb = False
			End If
		End If
		Pressed = True
		RaiseTouchStateEvent
		SetValueBasedOnTouch(X, Y)
	Else If Action = TouchPanel.TOUCH_ACTION_MOVE Then
		If Vertical = False Then
			If PressedLeftThumb = True Then
				SetValueBasedOnTouch(Min(X,s2 + Radius1/2), Y)
			Else
				SetValueBasedOnTouch(Max(X,s1 + Radius1/2), Y)
			End If
		Else
			If PressedTopThumb = True Then
				SetValueBasedOnTouch(x, Max(y,s2 - Radius1/2))
			Else
				SetValueBasedOnTouch(x, Min(y,s1 - Radius1/2))
			End If
		End If
	Else If Action = TouchPanel.TOUCH_ACTION_UP Then
		Pressed = False
		RaiseTouchStateEvent
	End If
	If Action <> TouchPanel.TOUCH_ACTION_MOVE_NOTOUCH Then Update
End Sub

Private Sub RaiseTouchStateEvent
	If xui.SubExists(mCallBack, mEventName & "_TouchStateChanged", 1) Then
		CallSubDelayed2(mCallBack, mEventName & "_TouchStateChanged", Pressed)
	End If
End Sub

Private Sub SetValueBasedOnTouch(x As Int, y As Int)
	Dim v As Int
	If Vertical Then
		v = (mBase.Height - Radius2 - y) / size * (MaxValue - MinValue) + MinValue
	Else
		v = (x - Radius2) / size * (MaxValue - MinValue) + MinValue
	End If
	v = Round (v / Interval) * Interval
	Dim NewValue As Int = Max(MinValue, Min(MaxValue, v))
	If NewValue <> mValue1 Or NewValue <> mValue2 Then
		If Vertical = False Then
			If PressedLeftThumb = True Then mValue1 = NewValue Else mValue2 = NewValue
		Else
			If PressedTopThumb = True Then mValue1 = NewValue Else mValue2 = NewValue
		End If
		If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 2) Then
			CallSubDelayed3(mCallBack, mEventName & "_ValueChanged", mValue1,mValue2)
		End If
	End If
End Sub

Public Sub setValue1(v As Int)
	mValue1 = Max(MinValue, Min(MaxValue, v))
	Update
End Sub

Public Sub setValue2(v As Int)
	mValue2 = Max(MinValue, Min(MaxValue, v))
	Update
End Sub

Public Sub getValue1 As Int
	Return mValue1
End Sub

Public Sub getValue2 As Int
	Return mValue2
End Sub