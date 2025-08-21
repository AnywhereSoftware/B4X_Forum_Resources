B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
Sub Class_Globals
	Public pnl As B4XView
	Private xui As XUI
	Private ShowIndex As Int
	Public BB1 As BBLabel
	Private te As BCTextEngine
	Private iv As B4XView
	Public DurationMs As Int = 3000
	Public DefaultTextColor As Int = 0xFF3E3E3E
	Public PaddingSides As Int = 15dip
	Public PaddingTopBottom As Int = 10dip
	Public MaxHeight As Int = 100dip
	Public VerticalCenterPercentage As Int = 85
End Sub

Public Sub Initialize (Parent As B4XView)
	pnl = xui.CreatePanel("")
	Parent.AddView(pnl, 0, 0, Parent.Width - 30dip, MaxHeight)
	pnl.LoadLayout("BCToast")
	pnl.SetColorAndBorder(0xFFC3C3C3, 0dip, xui.Color_White, 20dip)
	pnl.Visible = False
	te.Initialize(pnl)
	iv = BB1.mBase.GetView(0)
	iv.RemoveViewFromParent
	BB1.DisableResizeEvent = True
#if B4A
	Dim p As Panel = pnl
	p.Elevation = 5dip
#End If
	
End Sub

Public Sub Show(Message As String)
	BB1.ParseData.DefaultColor = DefaultTextColor
	iv.RemoveViewFromParent
	For Each v As B4XView In pnl.GetAllViewsRecursive
		If v.Tag = "to remove" Then v.RemoveViewFromParent
	Next
	pnl.Width = pnl.Parent.Width - 2 * PaddingSides
	pnl.Height = MaxHeight
	BB1.mBase.Width = pnl.Width
	BB1.mBase.Height = pnl.Height
	BB1.mBase.AddView(iv, 0, 0, BB1.mBase.Width, BB1.mBase.Height)
	BB1.Text = Message
	Dim iv As B4XView = BB1.mBase.GetView(0)
	iv.RemoveViewFromParent
	Dim w As Int = iv.Width + 2 * PaddingSides
	Dim h As Int = iv.Height + 2 * PaddingTopBottom
	Dim Parent As B4XView = pnl.Parent
	Dim NewLeft As Int = Parent.Width / 2 - w / 2
	pnl.SetLayoutAnimated(0, NewLeft, Parent.Height * VerticalCenterPercentage / 100 - h / 2, w, h)
	pnl.BringToFront
	Dim dx As Int = PaddingSides - iv.Left
	Dim dy As Int = PaddingTopBottom - iv.Top
	pnl.AddView(iv, PaddingSides, PaddingTopBottom, iv.Width, iv.Height)
'	Log(iv.Top & ", " & iv.Height)
	Do While BB1.mBase.NumberOfViews > 0
		Dim v As B4XView = BB1.mBase.GetView(0)
		v.RemoveViewFromParent
		v.Tag = "to remove"
		pnl.AddView(v, dx + v.Left, dy + v.Top, v.Width, v.Height)
	Loop
	pnl.SetVisibleAnimated(200, True)
	ShowIndex = ShowIndex + 1
	Dim MyIndex As Int = ShowIndex
	Sleep(DurationMs)
	If MyIndex = ShowIndex Then
		pnl.SetVisibleAnimated(200, False)
	End If
	
End Sub
