B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Public txtUser As B4XFloatTextField
	Private btnLogin As B4XView
	Public Page2 As B4XPage2
	Public Page3 As B4XPage3
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("Login")
	Page2.Initialize
	B4XPages.AddPage("Page 2", Page2)
	Page3.Initialize
	B4XPages.AddPage("Page 3", Page3)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub btnLogin_Click
	B4XPages.ShowPageAndRemovePreviousPages("Page 2")
End Sub

Sub txtUser_TextChanged (Old As String, New As String)
	btnLogin.Enabled = New.Length > 0
End Sub

Sub txtUser_EnterPressed
	If btnLogin.Enabled Then btnLogin_Click
End Sub

Sub B4XPage_Appear
	txtUser.Text = ""
End Sub