B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'v3.10
Sub Class_Globals
	Private views As Map
	Private stub As B4XView 'ignore this is required in B4A for the class to have an activity context.
	Private radius As Int = 15dip
	Private animationDuration As Int = 500
	Private cx, cy As Float
	Private xui As XUI
	Private color As Int = xui.Color_Red
	Private textColor As Int = xui.Color_White
End Sub

Public Sub Initialize
	views.Initialize
End Sub

Public Sub SetBadge(view As B4XView, Badge As Int)
	If views.ContainsKey(view) Then
		If Badge = 0 Then
			RemoveBadge(view)
		Else
			ReplaceLabel(view, Badge)
		End If
	Else
		If Badge > 0 Then
			Dim p As B4XView = CreateNewPanel(view)
			CreateLabel(p, Badge)
			p.SetLayoutAnimated(animationDuration, cx - radius, cy - radius, radius * 2, radius * 2)
			views.Put(view, p)
		End If
	End If
End Sub

Private Sub RemoveBadge(view As B4XView)
	Dim p As B4XView = GetPanel(view)
	GetLabel(p).RemoveViewFromParent
	views.Remove(view)
	p.SetLayoutAnimated(animationDuration, cx, cy, 2dip, 2dip)
	Sleep(animationDuration)
	p.RemoveViewFromParent
End Sub

Private Sub ReplaceLabel(view As B4XView, Badge As Int)
	Dim lbl As B4XView = GetLabel(GetPanel(view))
	lbl.SetLayoutAnimated(animationDuration / 2, radius + 8dip, 0, radius * 2, radius * 2)
	CreateLabel(GetPanel(view), Badge)
	Sleep(animationDuration / 2)
	lbl.RemoveViewFromParent
End Sub

Public Sub GetBadge(view As B4XView) As Int
	If views.ContainsKey(view) Then
		Dim lbl As B4XView = GetLabel(GetPanel(view))
		Return lbl.Text
	Else
		Return 0
	End If
End Sub

Private Sub GetPanel (view As Object) As B4XView
	Return views.Get(view)
End Sub

Private Sub GetLabel(panel As B4XView) As B4XView
	Return panel.GetView(panel.NumberOfViews - 1)
End Sub

Private Sub CreateNewPanel(view As B4XView) As B4XView
#if B4J
	Dim p As Pane
#else
	Dim p As Panel
#end if
	p.Initialize("")
#if B4A
	p.SetElevationAnimated(animationDuration, 8dip)
#end if
	Dim xp As B4XView = p
	xp.SetColorAndBorder(color, 0, color, radius)
	cx = view.Left + view.Width
	cy = view.Top
	Dim parent As B4XView = view.Parent
	parent.AddView(xp, cx, cy, 0, 0)
	Return p
End Sub

Private Sub CreateLabel(p As B4XView, count As Int)
	Dim lbl As Label
	lbl.Initialize("")
	Dim xlbl As B4XView = lbl
	xlbl.Font = xui.CreateDefaultBoldFont(16)
	xlbl.TextColor = textColor
	xlbl.Text = count
	p.AddView(xlbl, radius, radius, 0, 0)
	xlbl.SetTextAlignment("CENTER", "CENTER")
	Dim duration As Int = animationDuration
	xlbl.SetLayoutAnimated(duration, 0, 0, radius * 2, radius * 2)
	xlbl.Visible = False
	xlbl.SetVisibleAnimated(animationDuration, True)
End Sub

