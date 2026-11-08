B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
#IgnoreWarnings:12, 9
Sub Process_Globals
	Public app As IonicApp
	Private banano As BANano			'ignore
	Public name As String = "home"
	Public title As String = "SithasoIONIC7"
	Public icon As String = "play-circle"
	Public path As String = "/"
	Public color As String = "danger"
	Private home As SHIonTab		'ignore
End Sub

Sub Initialize(ionapp As IonicApp)			'ignore
	app = ionapp
	banano.LoadLayoutAppend("#mainpagetabs", "homelayout")

	'add page to the app page collection
	app.AddPagePath(name, title, icon, path)
	BuildPage
End Sub

'show this page
Sub Show
	app.NavigateTo(path, "forward")
End Sub
'
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
'
Sub getPath As String		'ignore
	Return path
End Sub
Sub getColor As String		'ignore
	Return color
End Sub
'
'start building the page
Private Sub BuildPage
End Sub

