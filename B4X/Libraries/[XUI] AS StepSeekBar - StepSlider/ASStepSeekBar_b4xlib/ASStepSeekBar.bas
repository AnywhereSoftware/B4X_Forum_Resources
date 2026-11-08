B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#If Documentation

StepSlider
SectionSeekBar
StepSeekBar
Updates
V1.00
	-Release
V1.01
	-minor adjustments
	-Base_Resize is public now
V1.02
	-Add get StepIndex
V1.03
	-Add Clear - Clear all steps
	-Hitbox improved - you can now simply tap on the line and the item that is closer to it will be selected
V1.04
	-BugFix
V1.05
	-BugFixes on the vertical seekbar
	-Add AddStep2 with ReachedColor and UnreachedColor parameter
#End If
#DesignerProperty: Key: ReachedLineColor, DisplayName: Reached Line Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: UnreachedLineColor, DisplayName: Unreached Line Color, FieldType: Color, DefaultValue: 0x98FFFFFF
#DesignerProperty: Key: ThumbColor, DisplayName: Thumb Color, FieldType: Color, DefaultValue: 0x64FFFFFF
#Event: ValueChanged (Index as Int,Value As Object)
#Event: TouchStateChanged (Pressed As Boolean)

Sub Class_Globals
	Type ASStepSeekBar_Step(Value As Object,ReachedColor As Int, UnreachedColor As Int)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Public ReachedLineColor, UnreachedLineColor, ThumbColor As Int
	Private cvs As B4XCanvas
	Public Tag As Object
	Private TouchPanel As B4XView
	Private mValue As Int = 0
	Private MinValue As Int = 0
	Private MaxValue As Int = 100
	Public Interval As Int = 1
	Private Vertical As Boolean
	Public ReachedLineSize = 4dip, UnreachedLineSize = 2dip, Radius1 = 6dip, Radius2 = 20dip As Int
	Private Pressed As Boolean
	Private size As Int
	Private lst_Sections As List
	Private lst_X,lst_Y As List
	Private m_Index As Int = 0
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lst_Sections.Initialize
	lst_X.Initialize : lst_Y.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	ReachedLineColor = xui.PaintOrColorToColor(Props.Get("ReachedLineColor"))
	UnreachedLineColor = xui.PaintOrColorToColor(Props.Get("UnreachedLineColor"))
	ThumbColor = xui.PaintOrColorToColor(Props.Get("ThumbColor"))
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
	size = Max(mBase.Height, mBase.Width) - 2 * Radius2
	cvs.ClearRect(cvs.TargetRect)
	If size > 0 Then
		If Vertical = False Then
			Dim s1 As Int = Radius2 + (mValue - MinValue) / (MaxValue - MinValue) * size
			Dim y As Int = mBase.Height / 2
			cvs.DrawLine(Radius2, y, s1, y, ReachedLineColor, ReachedLineSize) 'Active line
			cvs.DrawLine(s1, y, mBase.Width - Radius2, y, UnreachedLineColor, UnreachedLineSize) 'Inactive line
			
			lst_X.Clear
			'****
			For i = 0 To lst_Sections.Size -1
				
				Dim tmp_width As Float = (mBase.Width - Radius2*2)'/lst_Sections.Size
				
				Dim newx As Float = 0
				If i = 0 Then
					newx = Radius2
				Else if i = (lst_Sections.Size -1) Then
					newx = tmp_width + Radius2
				Else
					newx = (tmp_width/(lst_Sections.Size -1)) * i + Radius2
				End If
				Dim Section As ASStepSeekBar_Step = lst_Sections.Get(i)
				
				If i > m_Index Then					
					cvs.DrawCircle(newx,mBase.Height/2,Radius1,Section.UnreachedColor,True,0)
				Else
					cvs.DrawCircle(newx,mBase.Height/2,Radius1,Section.ReachedColor,True,0)
				End If
				
				lst_X.Add(newx)
			Next
			'****
			
			cvs.DrawCircle(s1, y, Radius2/2, ReachedLineColor, True, 0) 'Thumb Inactive
			
			If Pressed Then
				cvs.DrawCircle(s1, y, Radius2, ThumbColor, True, 0) 'Thumb active
			End If
		Else
			Dim s1 As Int = Radius2 + (MaxValue - mValue - MinValue) / (MaxValue - MinValue) * size
			Dim x As Int = mBase.Width / 2
			cvs.DrawLine(x, Radius2, x, s1, UnreachedLineColor, UnreachedLineSize)
			cvs.DrawLine(x, s1, x, mBase.Height - Radius2, ReachedLineColor, ReachedLineSize)
			
			lst_Y.Clear
			
			'****
			For i = 0 To lst_Sections.Size -1
				
				Dim tmp_height As Float = (mBase.Height - Radius2*2)'/lst_Sections.Size
				
				Dim newy As Float = 0
				If i = 0 Then
					newy = tmp_height + Radius2
				Else if i = (lst_Sections.Size -1) Then
					newy = Radius2
				Else
					newy = mBase.Height - (tmp_height/(lst_Sections.Size -1)) * i + Radius2
				End If
				Dim Section As ASStepSeekBar_Step = lst_Sections.Get(i)
				
				If i > m_Index Then
					cvs.DrawCircle(mBase.Width/2,newy,Radius1,Section.UnreachedColor,True,0)
				Else
					cvs.DrawCircle(mBase.Width/2,newy,Radius1,Section.ReachedColor,True,0)
				End If
				lst_Y.Add(newy)
			Next
			'****
		
			cvs.DrawCircle(x, s1, Radius2/2, ReachedLineColor, True, 0)
			
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
		'SetValueBasedOnTouch(X, Y)
	Else If Action = TouchPanel.TOUCH_ACTION_MOVE Then
		'SetValueBasedOnTouch(X, Y)
		If Vertical = False Then
			For i = 0 To lst_X.Size -1
				If x > (lst_X.Get(i) - Radius2) And x < (lst_X.Get(i) + Radius2) Then
					SetValueBasedOnTouch(lst_X.Get(i) , Y)
					Exit
				End If
			Next
		Else
			For i = 0 To lst_Y.Size -1
				If y > (lst_Y.Get(i) - Radius2) And y < (lst_Y.Get(i) + Radius2) Then
					SetValueBasedOnTouch(x , lst_Y.Get(i))
					Exit
				End If
			Next
		End If
		
	Else If Action = TouchPanel.TOUCH_ACTION_UP Then
		Pressed = False
		If Vertical = False Then
			Dim ThisIndex As Int = 0
			Dim ItemWidth As Float = (mBase.Width/lst_X.Size) + Radius2*2
			For i = 0 To lst_X.Size -1
				If Round(x) >= Round((lst_X.Get(i) - (ItemWidth/2))) And Round(x) <= Round((lst_X.Get(i) + (ItemWidth/2))) Then
					ThisIndex = i
					Exit
				End If
'				If x > (lst_X.Get(i) - Radius2) And x < (lst_X.Get(i) + Radius2) Then
'					SetValueBasedOnTouch(lst_X.Get(i) , Y)
'					Exit
'				End If
			Next
			SetValueBasedOnTouch(lst_X.Get(ThisIndex) , Y)
		Else
			Dim ThisIndex As Int = 0
			Dim ItemHeight As Float = (mBase.Height/lst_Y.Size) + Radius2*2
			For i = 0 To lst_Y.Size -1
				If Round(y) >= Round((lst_Y.Get(i) - (ItemHeight/2))) And Round(y) <= Round((lst_Y.Get(i) + (ItemHeight/2))) Then
					ThisIndex = i
					Exit
				End If
'				If y > (lst_Y.Get(i) - Radius2) And y < (lst_Y.Get(i) + Radius2) Then
'					SetValueBasedOnTouch(x , Y)'lst_Y.Get(i))
'					Exit
'				End If
			Next
			SetValueBasedOnTouch(x , lst_Y.Get(ThisIndex))
		End If
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
		
		If Vertical = False Then
			For i = 0 To lst_X.Size -1
				If x > (lst_X.Get(i) - Radius2) And x < (lst_X.Get(i) + Radius2) Then
					m_Index = i
					If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 2) Then
						Dim section As ASStepSeekBar_Step = lst_Sections.Get(i)
						CallSubDelayed3(mCallBack, mEventName & "_ValueChanged", i,section.Value)
					End If
					Exit
				End If
			Next
		Else
			For i = 0 To lst_Y.Size -1
				If y > (lst_Y.Get(i) - Radius2) And y < (lst_Y.Get(i) + Radius2) Then
					m_Index = i
					If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 2) Then
						Dim section As ASStepSeekBar_Step = lst_Sections.Get(i)
						CallSubDelayed3(mCallBack, mEventName & "_ValueChanged", i,section.Value)
					End If
					Exit
				End If
			Next
		End If
	End If
End Sub

Public Sub setStepIndex(Index As Int)
	'mValue = Max(MinValue, Min(MaxValue, v))
	If Vertical = False Then
		SetValueBasedOnTouch(lst_X.Get(Index) , 0)
	Else
		SetValueBasedOnTouch(0 ,lst_Y.Get(Index))
	End If
	Update
End Sub

Public Sub getStepIndex As Int
	Return m_Index
End Sub


'Gets the count of steps
Public Sub getSize As Int
	Return lst_Sections.Size
End Sub
'Get a value from a step
Public Sub GetStepValue(Index As Int) As Object
	Return lst_Sections.Get(Index).As(ASStepSeekBar_Step).Value
End Sub

Public Sub AddStep(Color As Int,Value As Object)
	lst_Sections.Add(CreateASStepSeekBar_Step(Value,Color,Color))
	Update
End Sub

Public Sub AddStep2(ReachedColor As Int, UnreachedColor As Int,Value As Object)
	lst_Sections.Add(CreateASStepSeekBar_Step(Value,ReachedColor,UnreachedColor))
	Update
End Sub

Public Sub Clear
	lst_Sections.Clear
	lst_X.Clear
	lst_Y.Clear
End Sub

Public Sub CreateASStepSeekBar_Step (Value As Object, ReachedColor As Int, UnreachedColor As Int) As ASStepSeekBar_Step
	Dim t1 As ASStepSeekBar_Step
	t1.Initialize
	t1.Value = Value
	t1.ReachedColor = ReachedColor
	t1.UnreachedColor = UnreachedColor
	Return t1
End Sub