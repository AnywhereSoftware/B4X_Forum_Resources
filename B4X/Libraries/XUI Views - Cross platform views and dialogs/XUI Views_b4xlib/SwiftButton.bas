B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
#DesignerProperty: Key: PrimaryColor, DisplayName: Primary Color, FieldType: Color, DefaultValue: 0xFFF11B00
#DesignerProperty: Key: SecondaryColor, DisplayName: Secondary Color, FieldType: Color, DefaultValue: 0xFFB01702
#DesignerProperty: Key: DisabledColor, DisplayName: Disabled Color, FieldType: Color, DefaultValue: 0xFF999999
#DesignerProperty: Key: CornersRadius, DisplayName: Corners Radius, FieldType: Int, DefaultValue: 15
#DesignerProperty: Key: SideHeight, DisplayName: Side Height, FieldType: Int, DefaultValue: 5
#DesignerProperty: Key: ButtonEnabled, DisplayName: Button Enabled, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: True, Description: Whether to make a haptic feedback when the user clicks on the control.

#Event: Click
#Event: ButtonUp
#Event: ButtonDown
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cvs As B4XCanvas
	Public xLBL As B4XView
	Public clr1, clr2, disabledColor As Int
	Private pressed As Boolean
	Public Tag As Object
	Private mDisabled As Boolean
	Public CornersRadius, SideHeight As Int
	Public mHaptic As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	Dim p As B4XView = xui.CreatePanel("p")
	p.Color = xui.Color_Transparent
	clr1 = xui.PaintOrColorToColor(Props.Get("PrimaryColor"))
	clr2 = xui.PaintOrColorToColor(Props.Get("SecondaryColor"))
	disabledColor = xui.PaintOrColorToColor(Props.GetDefault("DisabledColor", 0xFF999999))
	CornersRadius = DipToCurrent(Props.GetDefault("CornersRadius", 15))
	SideHeight = DipToCurrent(Props.GetDefault("SideHeight", 5))
	mDisabled = Not(Props.GetDefault("ButtonEnabled", True))
	mHaptic = Props.GetDefault("HapticFeedback", False)
	pressed = mDisabled
	xLBL = Lbl
	xLBL.Visible = True
	mBase.AddView(xLBL, 0, 0, 0, 0)
	mBase.AddView(p, 0, 0, 0, 0)
	xLBL.SetTextAlignment("CENTER", "CENTER")
	cvs.Initialize(mBase)
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	For Each v As B4XView In mBase.GetAllViewsRecursive
		v.SetLayoutAnimated(0, 0, 0, Width, Height)
	Next
	Draw
End Sub

Public Sub getEnabled As Boolean
	Return Not(mDisabled)
End Sub

Public Sub setEnabled(b As Boolean)
	mDisabled = Not(b)
	pressed = mDisabled
	Draw
End Sub

Private Sub p_Touch (Action As Int, X As Float, Y As Float)
	If mDisabled Then Return
	Dim Inside As Boolean = x > 0 And x < mBase.Width And y > 0 And y < mBase.Height
	Select Action
		Case mBase.TOUCH_ACTION_DOWN
			SetPressedState(True)
			Draw
		Case mBase.TOUCH_ACTION_MOVE
			If pressed <> Inside Then
				SetPressedState(Inside)
				Draw
			End If
		Case mBase.TOUCH_ACTION_UP, 3
			SetPressedState(False)
			Draw
			If Inside Then
				If mHaptic Then XUIViewsUtils.PerformHapticFeedback(mBase)
				CallSubDelayed(mCallBack, mEventName & "_Click")
			End If
	End Select
End Sub

Private Sub SetPressedState(NewState As Boolean)
	If pressed = NewState Then Return
	If NewState And xui.SubExists(mCallBack, mEventName & "_ButtonDown", 0) Then
		CallSubDelayed(mCallBack, mEventName & "_ButtonDown")
	End If
	If NewState = False And xui.SubExists(mCallBack, mEventName & "_ButtonUp", 0) Then
		CallSubDelayed(mCallBack, mEventName & "_ButtonUp")
	End If
	pressed= NewState
End Sub

#if B4J
Private Sub p_MouseClicked (EventData As MouseEvent)
	EventData.Consume
End Sub
#End If

Public Sub SetColors(Primary As Int, Secondary As Int)
	clr1 = Primary
	clr2 = Secondary
	Draw
End Sub

Public Sub Update
	Draw
End Sub

Private Sub Draw
	cvs.ClearRect(cvs.TargetRect)
	Dim r As B4XRect
	Dim p As B4XPath
	r.Initialize(0, SideHeight, mBase.Width, mBase.Height)
	If pressed = False Then
		xLBL.Top = 0
		p.InitializeRoundedRect(r, CornersRadius)
		cvs.DrawPath(p, clr2, True, 0)
		r.Initialize(0, 0, mBase.Width, mBase.Height - SideHeight)
		p.InitializeRoundedRect(r, CornersRadius)
		cvs.DrawPath(p, clr1, True, 0)
	Else
		xLBL.Top = SideHeight
		p.InitializeRoundedRect(r, CornersRadius)
		Dim c As Int
		If mDisabled Then c = disabledColor Else c = clr1
		cvs.DrawPath(p, c, True, 0)
	End If
	
	cvs.Invalidate
End Sub

