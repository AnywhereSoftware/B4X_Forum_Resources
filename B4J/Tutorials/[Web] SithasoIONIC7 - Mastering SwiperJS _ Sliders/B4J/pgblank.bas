B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.95
@EndOfDesignText@
#IgnoreWarnings:12, 9
Sub Process_Globals
	'this is the name of the page
	Public name As String = ""
	Public title As String = ""
	Public icon As String = ""
	Public path As String = ""
	Public color As String = ""
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As IonicApp
	'the variable referencing banano lib
	Private banano As BANano				'ignore
	Private blank As SHIonTab				'ignore
End Sub
'
'sub to show the page
Sub Initialize(ionapp As IonicApp)			'ignore
	'get the reference to the app
	app = ionapp
	'add this layout to the router-outlet
	banano.LoadLayoutAppend(app.PageViewer, "blanklayout")
	'get the details from the abstract design
	name = blank.PgName
	title = blank.PgTitle
	icon = blank.PgIcon
	path = blank.PgPath
	color = blank.PgIconColor
	'add the page to the app pages collection
	app.AddPagePath(name, title, icon, path)
	BuildPage
End Sub
'
'show this page
Sub Show
	app.NavigateTo(path, "forward")
End Sub

Sub getName As String		'ignore
	Return name
End Sub
'
Sub getIcon As String		'ignore
	Return icon
End Sub
'
Sub getTitle As String		'ignore
	Return title
End Sub

Sub getPath As String		'ignore
	Return path
End Sub

Sub getColor As String		'ignore
	Return color
End Sub

'start building the page
Private Sub BuildPage
	
End Sub
