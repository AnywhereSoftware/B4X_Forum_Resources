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
	Private mainpage As SHIonPage		'ignore
	'Uncomment the elements you will want to access via code
	Private mainpagecontent As SHIonContent		'ignore
	Private mainpagetabs As SHIonTabs		'ignore
End Sub
Sub Initialize
	'initialize the app, show ios mode
	app.Initialize(Me, "ios")
	'add a router to house page routes
	app.AddAppRouter
	'load the main layout
	'BANano.LoadLayoutAppend(app.Here, "indexlayout")
	maincontent.Initialize(Me, "maincontent", "maincontent")
	maincontent.IonPage = False
	maincontent.AddToParent("app", maincontent.CustProps)
	'
	mainpage.Initialize(Me, "mainpage", "mainpage")
	mainpage.RouterName = ""
	mainpage.Path = ""
	mainpage.HasTabs = True
	mainpage.AddToParent("maincontent", mainpage.CustProps)
	'Uncomment the elements you will want to access via code
	'
	'mainpagecontent.Initialize(Me, "mainpagecontent", "mainpagecontent")
	'mainpagecontent.LinkExisting
	'
	'mainpagetabs.Initialize(Me, "mainpagetabs", "mainpagetabs")
	'mainpagetabs.LinkExisting
	'
	'define the page viewer for navigation (we use tabs for navigation)
	app.PageViewer = mainpage.PageTabsID
	'add tab pages to main tabs
	BANano.Await(AddPages)
	'add items to the drawer list
	AddDrawerItems
	'add tab bar links
	AddPageTabs
	'show the active page
	pghome.Show
End Sub
'
'clicking the list on the menu
'Private Sub mainmenulist_ItemClick (e As BANanoEvent)
'	e.PreventDefault
'	'close the drawer
'	BANano.Await(mainmenu.close)
'	'show the page if it exists
'	Dim bShow As Boolean = app.NavigateToPage(e.ID, "forward")
'	'the page exists, exit sub
'	If bShow Then Return
'	'if we are not showing a page, do this
'	Dim itemID As String = app.MvField(e.ID, 1, "_")
'	Select Case itemID
'		Case ""
'	End Select
'End Sub
'
''COMPULSORY: add all pages to the app
Sub AddPages
	pghome.Initialize(app)
End Sub
'
''add pages to drawer list
Sub AddDrawerItems
	'mainmenulist.AddItemPage(pghome)
End Sub
'
''add links to the bottom navigation
Sub AddPageTabs
	'mainpage.PageTabBar.AddItemPage(pghome)
End Sub
'
'hide or show components depending
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
	Select Case toPage
		Case "home"
	End Select
End Sub
'
'trap changes to happen to routes
Private Sub app_IonRouteWillChange (e As BANanoEvent)
	Log("app_IonRouteWillChange")
	Dim fromPage As String = app.GetNavigatingFrom(e)
	Dim toPage As String = app.GetNavigatingTo(e)
	Log(fromPage)
	Log(toPage)
	Select Case toPage
		Case "home"
	End Select
End Sub

