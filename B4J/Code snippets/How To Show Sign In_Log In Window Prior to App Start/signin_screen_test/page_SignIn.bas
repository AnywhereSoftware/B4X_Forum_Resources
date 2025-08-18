B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private Root As B4XView 'ignore
	Private lbl_ErrorMsg As Label
	Private txt_EmailLogin As TextField
	Private txt_LoginPassword As TextField
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me,"Sign In")
	Root.LoadLayout("LoginScreen")
	B4XPages.GetNativeParent(Me).SetFormStyle("UTILITY")
	AddEscapeExit(txt_EmailLogin.Parent)
End Sub

Sub bttn_Login_Click
	'check your database with the given credentials
	Dim res As Int = fx.Msgbox2(Null,"Did you successfully sign in?","Sign In Result","Yes","","No",fx.MSGBOX_CONFIRMATION)
	If res = -1 Then
		B4XPages.ClosePage(Me)
		B4XPages.ShowPage("MainPage")
	Else
		lbl_ErrorMsg.Text = "Email/password not recognized. Please try again."
		txt_EmailLogin.RequestFocus
	End If
End Sub

Public Sub AddEscapeExit(ctl As Object)
	'allow Escape key to exit signin screen
	Dim r As Reflector
	r.Target = ctl
	r.AddEventFilter("keypressed","javafx.scene.input.KeyEvent.KEY_PRESSED")
End Sub

Sub KeyPressed_Filter (e As Event)
	Dim jo As JavaObject = e
	Dim keycode As String = jo.RunMethod("getCode", Null)
	If keycode = "ESCAPE" Then
		B4XPages.ClosePage(Me)
		e.Consume
	End If
End Sub

Sub txt_LoginPassword_Action
	'if the user presses Enter while in the password field,
	'we want to act like they clicked the "Sign In" button
	bttn_Login_Click
End Sub