B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private Label1 As Label
End Sub

Public Sub Initialize As Object
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Page2")
	Log("Localizing Page2...")
	Main.Loc.LocalizeLayout(Root)
	Label1.Text = Main.Loc.LocalizeParams(Label1.Text, Array(2))
	B4XPages.SetTitle(Me, Label1.Text)
End Sub