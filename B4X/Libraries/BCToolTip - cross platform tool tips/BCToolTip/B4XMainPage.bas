B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ToolTip As BCToolTip
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("1")
	ToolTip.Initialize(Root, 200dip)
	ToolTip.AutoHideMs = 4000
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub Button1_Click
	Dim btn As B4XView = Sender
	ToolTip.Show(btn.Left + btn.Width / 2, btn.Top, "TOP", "Click me!!!")
End Sub

Sub Button3_Click
	Dim btn As B4XView = Sender
	ToolTip.Show(btn.Left + btn.Width / 2, btn.Top + btn.Height, "BOTTOM", $"[b]Click[/b] [Color=Red][u]me[/u][/Color]!!!"$)
End Sub

Sub Button4_Click
	Dim btn As B4XView = Sender
	ToolTip.Show(btn.Left, btn.Top + btn.Height / 2, "LEFT", $"[TextSize=25]wefwefwef lwkef j[/TextSize]
jwlkefj lwke fjwe
fw ejklfwej klfwe f
ef wejklfj welkf"$)
End Sub

Sub Button2_Click
	Dim btn As B4XView = Sender
	ToolTip.Show(btn.Left + btn.Width, btn.Top + btn.Height / 2, "RIGHT", $"wefwefwef lwkef j
jwlkefj lwke fjwe
wefjlwkef jlwkefw
ef wejklfj welkf"$)
End Sub