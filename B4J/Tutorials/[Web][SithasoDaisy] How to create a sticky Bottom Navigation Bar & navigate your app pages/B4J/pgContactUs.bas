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
	Public name As String = "contactus"
	Public title As String = "Contact Us"
	Public icon As String = "fa-solid fa-phone"
	Public color As String = "#0000cc"
	'this variable holds the page controller
	Public page As SDUIPage
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private btnHome As SDUILink
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


Sub getColor As String
	Return color
End Sub

'start building the page
private Sub BuildPage
	banano.LoadLayout(app.PageViewer, "contactuslayout")
End Sub


Private Sub btnHome_Click (e As BANanoEvent)
	e.preventdefault
	'navigate to the home page
	pgHome.Show(app)
End Sub