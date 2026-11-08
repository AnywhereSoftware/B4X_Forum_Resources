B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
'https://ionic.io/ionicons
'https://ionicframework.com/docs/
#IgnoreWarnings:12
Sub Process_Globals
	Public app As IonicApp					'ignore
	Private BANano As BANano				'ignore
	Private maincontent As SHIonContent		'ignore
	Private mainpage As SHIonPage
End Sub

Sub Initialize
	'initialize the app, show ios mode
	app.Initialize(Me, "ios")
	'add a router to house page routes
	app.AddAppRouter
	BANano.LoadLayout("#app", "maincontentlayout")

	'define the page viewer for navigation (we use tabs for navigation)
	app.PageViewer = mainpage.PageTabsID
	'add tab pages to main tabs
	BANano.Await(AddPages)
	'add items to the drawer list
	AddDrawerItems
	'add tab bar links
	AddPageTabs
	'show the active page
	pgHome.Show
End Sub

''COMPULSORY: add all pages to the app
Sub AddPages
	pgHome.Initialize(app)
End Sub
'
''add pages to drawer list
Sub AddDrawerItems
	'mainmenulist.AddItemPage(pghome)
End Sub
'
''add links to the bottom navigation
Sub AddPageTabs
	'mainpage.PageTabBar.AddItemPage(pgHome)
End Sub
'
hide Or show components depending
Sub IsAuthenticated(b As Boolean)
	'mainmenu.Visible = b
	If mainpage.HasTabs Then mainpage.PageTabBar.Visible = b
	If mainpage.HasFooter Then mainpage.PageFooter.Visible = b
	If mainpage.HasHeader Then mainpage.PageHeader.Visible = b
End Sub
'
'trap changes that happened to routes
Private Sub app_IonRouteDidChange (e As BANanoEvent)
	Log("app_IonRouteDidChange")
	Dim fromPage As String = app.GetNavigatingFrom(e)
	Dim toPage As String = app.GetNavigatingTo(e)
	Log(fromPage)
	Log(toPage)
End Sub

'trap changes to happen to routes
Private Sub app_IonRouteWillChange (e As BANanoEvent)
	Log("app_IonRouteWillChange")
	Dim fromPage As String = app.GetNavigatingFrom(e)
	Dim toPage As String = app.GetNavigatingTo(e)
	Log(fromPage)
	Log(toPage)
End Sub
