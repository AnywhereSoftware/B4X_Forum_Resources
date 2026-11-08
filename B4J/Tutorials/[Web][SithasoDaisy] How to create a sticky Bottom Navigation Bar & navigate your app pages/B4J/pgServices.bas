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
	Public name As String = "services"
	Public title As String = "Our Services"
	Public icon As String = "fa-solid fa-users-gear"
	Public color As String = "#cc00ff"	
	'this variable holds the page controller
	Public page As SDUIPage
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private btnContactUs As SDUILink
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
	banano.LoadLayout(app.PageViewer, "serviceslayout")
End Sub


Private Sub btnContactUs_Click (e As BANanoEvent)
	e.preventdefault
	'show the contact us page
	pgContactUs.show(app)
End Sub