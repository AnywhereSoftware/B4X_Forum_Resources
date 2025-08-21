B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.31
@EndOfDesignText@
Sub Class_Globals
	Public pnl As B4XView
	Private xui As XUI
	Public BB1 As BBLabel
	Private te As BCTextEngine
	Public DefaultTextColor As Int = 0xFF3E3E3E
	Public BackgroundColor As Int = 0xFFE2E2E2
	Public pnlBackground As B4XView
	Private mParent As B4XView
	Private GapFromText As Int = 20dip
	Private cvs As B4XCanvas
	Private pnlArrow As B4XView
	Private pnlTouch As B4XView
	Private ShowIndex As Int
	Public AutoHideMs As Int
End Sub

Public Sub Initialize (Parent As B4XView, MaxWidth As Int)
	mParent = Parent
	pnl = xui.CreatePanel("")
	pnl.SetLayoutAnimated(0, 0, 0, MaxWidth, 300dip)
	pnl.LoadLayout("BCToolTip")
	cvs.Initialize(pnlArrow)
	pnl.Color = xui.Color_Transparent
	te.Initialize(pnl)
	BB1.DisableResizeEvent = True
	
	BB1.Padding.Initialize(0, 0, 0, 0)
#if B4A
	For Each p As Panel In Array(pnl, pnlBackground, pnlTouch, pnlArrow, BB1.mBase)
		p.Elevation = 5dip
	Next
#Else If B4i
	Dim p As Panel = pnl
	p.SetShadow(xui.Color_Black, 2dip, 2dip, 0.5, False)
#End If
End Sub

'Shows the tooltip.
'X / Y - Arrow point.
'Side - One of the following values: LEFT, TOP, RIGHT, BOTTOM
'Message - BBCode message.
Public Sub Show (X As Int, Y As Int, Side As String, Message As String)
	ShowIndex = ShowIndex + 1
	Dim MyIndex As Int = ShowIndex
	BB1.ParseData.DefaultColor = DefaultTextColor
	BB1.Text = Message
	If pnl.Parent.IsInitialized Then pnl.RemoveViewFromParent
	mParent.AddView(pnl, 100dip, 100dip, pnl.Width, pnl.Height)
	Dim iv As B4XView = BB1.ForegroundImageView
	pnlBackground.Color = BackgroundColor
	pnlBackground.SetLayoutAnimated(0, BB1.mBase.Left + iv.Left - GapFromText, BB1.mBase.Top + iv.Top - GapFromText, iv.Width + 2 * GapFromText, iv.Height + 2 * GapFromText)
	If xui.IsB4i Then
		pnlTouch.SetLayoutAnimated(0, 0, 0, pnl.Width, pnl.Height)
	Else
		pnlTouch.SetLayoutAnimated(0, pnlBackground.Left, pnlBackground.Top, pnlBackground.Width, pnlBackground.Height)
	End If
	cvs.ClearRect(cvs.TargetRect)
	Dim p As B4XPath
	Select Side
		Case "TOP"
			pnlArrow.SetLayoutAnimated(0, pnl.Width / 2 - pnlArrow.Width / 2, pnlBackground.Top + pnlBackground.Height, pnlArrow.Width, pnlArrow.Height)
			p.Initialize(0, 0).LineTo(pnlArrow.Width, 0).LineTo(pnlArrow.Width / 2, pnlArrow.Height).LineTo(0, 0)
			pnl.SetLayoutAnimated(0, x - pnl.Width / 2, y - pnlArrow.Height - pnlArrow.Top, pnl.Width, pnl.Height)
		Case "BOTTOM"
			pnlArrow.SetLayoutAnimated(0, pnl.Width / 2 - pnlArrow.Width / 2, pnlBackground.Top - pnlArrow.Height, pnlArrow.Width, pnlArrow.Height)
			p.Initialize(pnlArrow.Width / 2, 0).LineTo(pnlArrow.Width, pnlArrow.Height).LineTo(0, pnlArrow.Height).LineTo(pnlArrow.Width / 2, 0)
			pnl.SetLayoutAnimated(0, x - pnl.Width / 2, y - pnlArrow.Top, pnl.Width, pnl.Height)
		Case "RIGHT"
			pnlArrow.SetLayoutAnimated(0, pnlBackground.Left - pnlArrow.Width, pnl.Height / 2 - pnlArrow.Height / 2, pnlArrow.Width, pnlArrow.Height)
			p.Initialize(pnlArrow.Width, 0).LineTo(pnlArrow.Width, pnlArrow.Height).LineTo(0, pnlArrow.Height / 2).LineTo(pnlArrow.Width, 0)
			pnl.SetLayoutAnimated(0, x - pnlArrow.Left, y - pnl.Height / 2, pnl.Width, pnl.Height)
		Case "LEFT"
			pnlArrow.SetLayoutAnimated(0, pnlBackground.Left + pnlBackground.Width, pnl.Height / 2 - pnlArrow.Height / 2, pnlArrow.Width, pnlArrow.Height)
			p.Initialize(0, 0).LineTo(pnlArrow.Width, pnlArrow.Height / 2).LineTo(0, pnlArrow.Height).LineTo(0, 0)
			pnl.SetLayoutAnimated(0, x - pnlArrow.Width - pnlArrow.Left, y - pnl.Height / 2, pnl.Width, pnl.Height)
	End Select
	
	cvs.DrawPath(p, pnlBackground.Color, True, 0)
	cvs.Invalidate
	pnl.Visible = False
	pnl.SetVisibleAnimated(300, True)
	If AutoHideMs > 0 Then
		Sleep(AutoHideMs)
		If MyIndex <> ShowIndex Then Return
		Hide
	End If
End Sub

Public Sub Hide
	ShowIndex = ShowIndex + 1
	Dim MyIndex As Int = ShowIndex
	pnl.SetVisibleAnimated(300, False)
	Sleep(300)
	If MyIndex <> ShowIndex Then Return
	If pnl.Parent.IsInitialized Then pnl.RemoveViewFromParent
End Sub

Sub pnlTouch_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnlTouch.TOUCH_ACTION_DOWN Then
		Hide	
	End If
End Sub