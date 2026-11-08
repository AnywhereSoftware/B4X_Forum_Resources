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
	Private mainmenu As SHIonMenu			'ignore
	Private mainpage As SHIonPage			'ignore
	Private mainmenulist As SHIonList			'ignore
End Sub

Sub Initialize
	'initialize the app, show ios mode
	app.Initialize(Me, "ios")
	'add a router
	app.AddAppRouter
	'load the drawer and page viewer
	BANano.LoadLayoutAppend(app.Here, "indexlayout")
	'
	mainmenulist.Initialize(Me, "mainmenulist", "mainmenulist")
	mainmenulist.LinkExisting
	'
	'define the page viewer for navigation (router-outlet)
	app.PageViewer = mainpage.PageTabsID
	'add tab pages to main tabs
	BANano.Await(AddPages)
	'add items to the drawer list
	AddDrawerItems
	'add tab bar links
	AddPageTabs
End Sub

'clicking the list on the menu
Private Sub mainmenulist_ItemClick (e As BANanoEvent)
	e.PreventDefault
	'close the drawer
	BANano.Await(mainmenu.close)
	'show the page if it exists
	Dim bShow As Boolean = app.NavigateToPage(e.ID, "forward")
	'the page exists, exit sub
	If bShow Then Return
	'if we are not showing a page, do this
	Dim itemID As String = app.MvField(e.ID, 1, "_")
	Select Case itemID
		Case ""
	End Select
End Sub


''COMPULSORY: add all pages to the app
Sub AddPages
	'pgblank.Initialize(app)
	pghome.Initialize(app)
End Sub
'
''add pages to drawer list
Sub AddDrawerItems
	'mainmenulist.AddItemPage(pgBlank)
End Sub
'
''add links to the bottom navigation
Sub AddPageTabs
	'mainpage.PageTabBar.AddItemPage(pgblank)
End Sub
'
'hide or show components depending
Sub IsAuthenticated(b As Boolean)
	mainmenu.Visible = b
	If mainpage.HasTabs Then mainpage.PageTabBar.Visible = b
	If mainpage.HasFooter Then mainpage.PageFooter.Visible = b
	If mainpage.HasHeader Then mainpage.PageHeader.Visible = b
End Sub
'

Private Sub app_IonRouteDidChange (e As BANanoEvent)
	Log("app_IonRouteDidChange")
	Log(e)
End Sub

Private Sub app_IonRouteWillChange (e As BANanoEvent)
	Log("app_IonRouteWillChange")
	Log(e)
End Sub
