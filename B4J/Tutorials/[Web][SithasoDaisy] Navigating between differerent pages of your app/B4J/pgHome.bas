B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12, 9
Sub Process_Globals
	'this is the name of the page
	Public name As String = "home"
	'what is the title of the page
	Public title As String = "Home"
	'what is the icon of the page
	Public icon As String = "fa-solid fa-house"
	'this variable holds the page controller
	Public page As SDUIPage
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private btnServices As SDUIButton
End Sub

'** DO NOT DELETE
'sub to show the page
Sub Show(duiapp As SDUIApp)			'ignore
	'get the reference to the app
	app = duiapp
	'build the page, via code or loadlayouts
	BuildPage
End Sub

'** DO NOT DELETE
'sub to get the name of the page
Sub getName As String
	Return name
End Sub

'** DO NOT DELETE
'sub to get the icon of the page
Sub getIcon As String
	Return icon
End Sub

'** DO NOT DELETE
'sub to get the title of the page
Sub getTitle As String
	Return title
End Sub

'** DO NOT DELETE
'start building the page, here you load layouts / code your app
private Sub BuildPage
	'load the page layout
	banano.LoadLayout(app.PageViewer, "homelayout")
	'start adding you components here
End Sub


Private Sub btnServices_Click (e As BANanoEvent)
	pgServices.Show(app)
End Sub