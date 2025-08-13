B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'***** DO NOT DELETE OR CHANGE THIS FILE *****
#IgnoreWarnings:12, 9
Sub Process_Globals
	'this is the name of the page
	Public name As String = "adsignin"
	Public title As String = "Sign In"
	Public icon As String = "fa-solid fa-swatchbook"
	'this variable holds the page controller
	Public page As SDUIPage
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private mdlSignIn As SDUIModal	'ignore
	Private email As SDUITextBox	'ignore
	Private password As SDUITextBox	'ignore
	Private lblForgotPassword As SDUILink	'ignore
	Private rememberme As SDUICheckbox		'ignore
	Private useroptions As SDUIDiv			'ignore
	Private lblSignUp As SDUILink			'ignore
	Private SDUILabel1 As SDUILabel			'ignore
	Private useroptions1 As SDUIDiv			'ignore
	Private btnSignIn As SDUIButton			'ignore
End Sub

'sub to show the page
Sub Show(duiapp As SDUIApp)			'ignore
	'get the reference to the app
	app = duiapp
	'build the page, via code or loadlayouts
	BuildPage
End Sub


Sub getName As String
	Return name
End Sub

Sub getIcon As String
	Return icon
End Sub

Sub getTitle As String
	Return title
End Sub

'start building the page
private Sub BuildPage
	banano.LoadLayout(app.PageViewer, "adsigninlayout")
	Log(page.CustProps)
	
	email.PrependButton.BGColor = "#386885"
	password.PrependButton.BGColor = "#386885"
	password.AppendButton.BGColor = "#386885"
	'show the modal
	mdlSignIn.show
	'if there is a remember me, show it
	Dim settings As Map = SDUIShared.GetLocalStorage(Main.AppName)
	mdlSignIn.SetData(settings)
	
	'get the layout
	'Dim lay As Map = banano.GetViewFromLayout(Me, "page")
	'Log(lay)
	'Log(lay.Get("title"))
	'Log(lay)
	'Log(Me)
End Sub

Private Sub password_Append_Click (event As BANanoEvent)
	password.toggleEyes
End Sub

Sub Hide
	mdlSignIn.hide
End Sub

Private Sub lblForgotPassword_Click (e As BANanoEvent)
	e.PreventDefault
	'show the forgot password screen
	pgForgotPassword.Show(app)
End Sub

Private Sub lblSignUp_Click (e As BANanoEvent)
	e.PreventDefault
	pgSignUp.Show(app)
End Sub

Private Sub btnSignIn_Click (e As BANanoEvent)
	'reset the validations
	mdlSignIn.ResetValidation
	'validate each of the elements
	mdlSignIn.Validate(email.IsBlank)
	mdlSignIn.Validate(password.IsBlank)
	'check the form status
	If mdlSignIn.IsValid = False Then Return
	'get the data on form
	Dim data As Map = mdlSignIn.GetData
	Log(data)
	'do verification
	'if verification = false return
	'do we remember
	If rememberme.Checked Then
		'save settings using app name
		SDUIShared.SetLocalStorage(Main.AppName, data)
	Else
		'remove settings
		SDUIShared.DeleteLocalStorage(Main.AppName)
	End If
	
	
	'show nav & drawer
	pgIndex.UpdateUserName("Anele 'Mashy' Mbanga")
	pgIndex.UpdateUserAvatar("./assets/mashy.jpg")
	pgIndex.IsAuthenticated(True)
	'hide the modal
	mdlSignIn.Hide
	pgHome.Show(app)
End Sub