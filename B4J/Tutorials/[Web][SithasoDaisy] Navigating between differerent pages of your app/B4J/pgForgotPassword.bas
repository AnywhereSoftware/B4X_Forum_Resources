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
	Public name As String = "adforgotpassword"
	Public title As String = "Forgot Password"
	Public icon As String = "fa-solid fa-swatchbook"
	'this variable holds the page controller
	Public page As SDUIPage
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private btnReset As SDUIButton			'ignore
	Private email As SDUITextBox			'ignore
	Private lblSignIn As SDUILink			'ignore
	Private mdlSignIn As SDUIModal			'ignore
	Private SDUILabel1 As SDUILabel			'ignore
	Private useroptions1 As SDUIDiv			'ignore
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
	banano.LoadLayout(app.PageViewer, "adforgotpassword")
	email.PrependButton.BGColor = "#386885"
	mdlSignIn.show
End Sub


Private Sub lblSignIn_Click (e As BANanoEvent)
	e.PreventDefault
	pgSignIn.Show(app)
End Sub

Private Sub btnReset_Click (e As BANanoEvent)
	'reset the validations
	mdlSignIn.ResetValidation
	'validate each of the elements
	mdlSignIn.Validate(email.IsBlank)
	'check the form status
	If mdlSignIn.IsValid = False Then Return
	'get the data on form
	Dim data As Map = mdlSignIn.GetData
	Log(data)
End Sub