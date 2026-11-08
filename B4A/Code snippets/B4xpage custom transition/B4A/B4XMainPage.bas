B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
	Sub Class_Globals
	Public Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Public txtUser As B4XFloatTextField
	Private btnLogin As B4XView
	Public Page2 As B4XPage2
	Public trans As Transition
End Sub

'You can add more parameters here.
Public Sub Initialize
	B4XPages.GetManager.TransitionAnimationDuration = 0
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	trans.Initialize
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("Login")
	Page2.Initialize
	B4XPages.AddPageAndCreate("Page 2", Page2)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub btnLogin_Click
	trans.SlidePageIn2(Root, B4XPages.MainPage.Page2.Root, B4XPages.MainPage.Page2, "Page 2")
End Sub

Sub txtUser_TextChanged (Old As String, New As String)
	btnLogin.Enabled = New.Length > 0
End Sub

Sub txtUser_EnterPressed
	If btnLogin.Enabled Then btnLogin_Click
End Sub

Sub B4XPage_Appear
	'txtUser.Text = ""
End Sub