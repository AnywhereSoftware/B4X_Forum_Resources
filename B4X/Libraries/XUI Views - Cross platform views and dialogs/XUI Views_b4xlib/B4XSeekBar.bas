B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#DesignerProperty: Key: Color1, DisplayName: Color 1, FieldType: Color, DefaultValue: 0xFF006AFF
#DesignerProperty: Key: Color2, DisplayName: Color 2, FieldType: Color, DefaultValue: 0xFF8AB9FC
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0x58006AFF
#DesignerProperty: Key: Interval, DisplayName: Interval, FieldType: Int, DefaultValue: 1
#DesignerProperty: Key: Min, DisplayName: Minimum, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: Max, DisplayName: Maximum, FieldType: Int, DefaultValue: 100
#DesignerProperty: Key: Value, DisplayName: Value, FieldType: Int, DefaultValue: 50
#Event: ValueChanged (Value As Int)
#Event: TouchStateChanged (Pressed As Boolean)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Color1, Color2, ThumbColor As Int
	Private cvs As B4XCanvas
	Public Tag As Object
	Private TouchPanel As B4XView
	Private mValue As Int
	Public MinValue, MaxValue As Int
	Public Interval As Int = 1
	Private Vertical As Boolean
	Public Size1 = 4dip, Size2 = 2dip, Radius1 = 6dip, Radius2 = 12dip As Int
	Private Pressed As Boolean
	Private size As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	Color1 = xui.PaintOrColorToColor(Props.Get("Color1"))
	Color2 = xui.PaintOrColorToColor(Props.Get("Color2")) 
	ThumbColor = xui.PaintOrColorToColor(Props.Get("ThumbColor"))
	Interval = Max(1, Props.GetDefault("Interval", 1))
	MinValue = Props.Get("Min")
	MaxValue = Props.Get("Max")
	mValue = Max(MinValue, Min(MaxValue, Props.Get("Value")))
	cvs.Initialize(mBase)
	TouchPanel = xui.CreatePanel("TouchPanel")
	mBase.AddView(TouchPanel, 0, 0, mBase.Width, mBase.Height)
	If xui.IsB4A Or xui.IsB4i Then Radius2 = 20dip
	If xui.IsB4A Then Base_Resize(mBase.Width, mBase.Height)
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
			Dim s1 As Int = Radius2 + (mValue - MinValue) / (MaxValue - MinValue) * size
			Dim y As Int = mBase.Height / 2
			cvs.DrawLine(Radius2, y, s1, y, Color1, Size1)
			cvs.DrawLine(s1, y, mBase.Width - Radius2, y, Color2, Size2)
			cvs.DrawCircle(s1, y, Radius1, Color1, True, 0)
			If Pressed Then
				cvs.DrawCircle(s1, y, Radius2, ThumbColor, True, 0)
			End If
		Else
			Dim s1 As Int = Radius2 + (MaxValue - mValue) / (MaxValue - MinValue) * size
			Dim x As Int = mBase.Width / 2
			cvs.DrawLine(x, Radius2, x, s1, Color2, Size2)
			cvs.DrawLine(x, s1, x, mBase.Height - Radius2, Color1, Size1)
			cvs.DrawCircle(x, s1, Radius1, Color1, True, 0)
			If Pressed Then
				cvs.DrawCircle(x, s1, Radius2, ThumbColor, True, 0)
			End If
		End If
	End If
	cvs.Invalidate
End Sub

Private Sub TouchPanel_Touch (Action As Int, X As Float, Y As Float)
	If Action = TouchPanel.TOUCH_ACTION_DOWN Then
		Pressed = True
		RaiseTouchStateEvent
		SetValueBasedOnTouch(X, Y)
	Else If Action = TouchPanel.TOUCH_ACTION_MOVE Then
		SetValueBasedOnTouch(X, Y)
	Else If Action = TouchPanel.TOUCH_ACTION_UP Then
		Pressed = False
		RaiseTouchStateEvent
	End If
	Update
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
	If NewValue <> mValue Then
		mValue = NewValue
		If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
			CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", mValue)
		End If
	End If
End Sub

Public Sub setValue(v As Int)
	mValue = Max(MinValue, Min(MaxValue, v))
	Update
End Sub

Public Sub getValue As Int
	Return mValue
End Sub