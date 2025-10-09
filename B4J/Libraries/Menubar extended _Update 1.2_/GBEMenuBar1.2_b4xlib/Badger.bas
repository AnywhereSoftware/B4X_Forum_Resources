B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'v3.00
'(C) Erel Anywhere
'Modified v3.GBE1 add parameter cx/cy To set points manually

Sub Class_Globals
	Private views As Map
	Private stub As B4XView 'ignore
	Private radius As Int = 15dip
	Private animationDuration As Int = 500
	Private cx, cy As Float
	Private xui As XUI
	Private color As Int
	Private textColor As Int = xui.Color_White
End Sub

Public Sub Initialize
	views.Initialize
End Sub
'# modfied GBE CX/CY
Public Sub SetBadge(view As B4XView, Badge As Int,X As Int, y As Int,col As  Int)
	cx=X: cy=y : color = col
	If views.ContainsKey(view) Then
		If Badge = 0 Then
			RemoveBadge(view)
		Else
			ReplaceLabel(view, Badge)
		End If
	Else
		If Badge > 0 Then
			Dim p As B4XView = CreateNewPanel(view, Badge)
			CreateLabel(p, Badge)
			p.SetLayoutAnimated(animationDuration, cx - radius, cy - radius, radius * 2, radius * 2)
			views.Put(view, p)
		End If
	End If
End Sub

private  Sub RemoveBadge(view As B4XView)
	Dim p As B4XView = GetPanel(view)
	GetLabel(p).RemoveViewFromParent
	views.Remove(view)
	p.SetLayoutAnimated(animationDuration, cx, cy, 0, 0)
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
'# modfied GBE CX/CY
Private Sub CreateNewPanel(view As B4XView, count As Int) As B4XView
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
	
	'cx = view.Left + view.Width
	'cy = view.Top
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

