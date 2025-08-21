B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
#DesignerProperty: Key: PrimaryColor, DisplayName: Primary Color, FieldType: Color, DefaultValue: 0xFFF11B00
#DesignerProperty: Key: SecondaryColor, DisplayName: Secondary Color, FieldType: Color, DefaultValue: 0xFFB01702
#Event: Click
#Event: Release
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cvs As B4XCanvas
	Public xLBL As B4XView
	Private clr1, clr2 As Int
	Private pressed As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Dim p As B4XView = xui.CreatePanel("p")
	p.Color = xui.Color_Transparent
	clr1 = xui.PaintOrColorToColor(Props.Get("PrimaryColor"))
	clr2 = xui.PaintOrColorToColor(Props.Get("SecondaryColor"))
	xLBL = Lbl
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

Private Sub p_Touch (Action As Int, X As Float, Y As Float)
	
	Log("Action=" & Action & " x=" & " y=" & Y)
	Select Action
		Case mBase.TOUCH_ACTION_DOWN
			pressed = True
			Draw
			CallSubDelayed(mCallBack, mEventName & "_Click")
		Case mBase.TOUCH_ACTION_UP
			pressed = False
			Draw
			CallSubDelayed(mCallBack, mEventName & "_Release")
	End Select
End Sub

Private Sub Draw
	cvs.ClearRect(cvs.TargetRect)
	Dim gap As Int = 5dip
	Dim corners As Int = 15dip
	Dim r As B4XRect
	Dim p As B4XPath
	r.Initialize(0, gap, mBase.Width, mBase.Height)
	If pressed = False Then
		xLBL.Top = 0
		p.InitializeRoundedRect(r, corners)
		cvs.DrawPath(p, clr2, True, 0)
		r.Initialize(0, 0, mBase.Width, mBase.Height - gap)
		p.InitializeRoundedRect(r, corners)
		cvs.DrawPath(p, clr1, True, 0)
	Else
		xLBL.Top = gap
		p.InitializeRoundedRect(r, corners)
		cvs.DrawPath(p, clr1, True, 0)
	End If
	
	cvs.Invalidate
End Sub

