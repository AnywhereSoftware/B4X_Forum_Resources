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
	Public name As String = "adsignup"
	Public title As String = "Sign Up"
	Public icon As String = "fa-solid fa-swatchbook"
	'this variable holds the page controller
	Public page As SDUIPage
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private btnSignUp As SDUIButton				'ignore
	Private confirmpassword As SDUITextBox		'ignore
	Private email As SDUITextBox				'ignore
	Private fullname As SDUITextBox				'ignore
	Private lblSignIn As SDUILink				'ignore
	Private mdlSignIn As SDUIModal				'ignore
	Private password As SDUITextBox				'ignore
	Private policies As SDUILabel				'ignore
	Private SDUILabel1 As SDUILabel				'ignore
	Private useroptions1 As SDUIDiv				'ignore
	Private useroptions2 As SDUIDiv				'ignore
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
	banano.LoadLayout(app.PageViewer, "adsignuplayout")
	fullname.PrependButton.BGColor = "#386885"
	email.PrependButton.BGColor = "#386885"
	password.PrependButton.BGColor = "#386885"
	password.AppendButton.BGColor = "#386885"
	confirmpassword.PrependButton.BGColor = "#386885"
	confirmpassword.AppendButton.BGColor = "#386885"
	'show the modal
	mdlSignIn.show
End Sub


Private Sub lblSignIn_Click (e As BANanoEvent)
	e.preventdefault
	pgSignIn.Show(app)
End Sub

Private Sub btnSignUp_Click (e As BANanoEvent)
	'reset the validations
	mdlSignIn.ResetValidation
	'validate each of the elements
	mdlSignIn.Validate(fullname.IsBlank)
	mdlSignIn.Validate(email.IsBlank)
	mdlSignIn.Validate(password.IsBlank)
	mdlSignIn.Validate(confirmpassword.IsBlank)
	'check the form status
	If mdlSignIn.IsValid = False Then Return
	'get the data on form
	Dim data As Map = mdlSignIn.GetData
	Log(data)
End Sub

Private Sub password_Append_Click (event As BANanoEvent)
	password.toggleEyes
End Sub

Private Sub confirmpassword_Append_Click (event As BANanoEvent)
	confirmpassword.toggleEyes
End Sub