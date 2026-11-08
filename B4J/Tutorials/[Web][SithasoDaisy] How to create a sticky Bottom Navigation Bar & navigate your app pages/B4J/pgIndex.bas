B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Public app As SDUIApp		'ignore
	Public BANano As BANano		'ignore
	Private appnavbar As SDUINavBar		'ignore
	Private appdrawer As SDUIDrawer		'ignore
	Private userAvatar As SDUIAvatar			'ignore
	Private lblUserName As SDUILabel			'ignore
	Private btnLogOff As SDUIButton				'ignore
	Private page As SDUIPage					'ignore
	Private appbottomnavbar As SDUIBottomNav			'ignore
	Private apptoast As SDUIMDToast				'ignore
End Sub

Sub Initialize					'ignoreDeadCode
	'initialize the app
	BANano.Await(app.AddApp(Me, Main.AppName))
	'set the font of the app
	app.Font = "font-sans"
	'load the base layout
	BANano.LoadLayout(app.Here, "baselayout")
	'link this app to the drawer, this is needed
	'when adding pages to side nav
	appdrawer.app = app
	'create the drawer menu
	CreateDrawerMenu
	'create the bottom nav content
	CreateDrawerBottomNav
	'add any other page not added to the drawer menu
	AddPages
	'show the sign in page
	IsAuthenticated(False)
	pgSignIn.Show(app)
End Sub

'NB: use this to add pages that are not added to the side nav bar
Sub AddPages
	'example
	'app.AddPage(pgHome.name, pgHome)
End Sub

'define the menu items fo dawe
Sub CreateDrawerMenu
	'clear the menu
	appdrawer.Clear("")
	'add a page link to the drawer
	appdrawer.AddItemPage(pgHome)
	appdrawer.AddItemPage(pgServices)
	appdrawer.AddItemPage(pgContactUs)
	'
	appdrawer.AddItem("settings", "Settings")
	appdrawer.AddItemChildPage("settings", pgUsers)
End Sub

Sub CreateDrawerBottomNav
	'get the footer inside the drawer
	appbottomnavbar = appdrawer.BottomNav
	'turn off animation
	appbottomnavbar.animate = False
	'add links to the various pages
	appbottomnavbar.AddItemPage(pgHome)
	appbottomnavbar.AddItemPage(pgServices)
	appbottomnavbar.AddItemPage(pgContactUs)
End Sub

'an item in the menu is clicked
Private Sub appdrawer_menu_Click (item As String)
	'hide the drawer (wont hide if set to mobile)
	appdrawer.Close
	'
	'ensure we sync the clicked page to the bottom nav
	appbottomnavbar.ActivePage = item
	
	'if this is a page
	'navigate to it and exit
	If app.ShowPage(item) Then Return
	
	'we have code that does not open a page
	Select Case item
	End Select
End Sub

'if you want to fie an event when the hambuge is clicked
'uncomment this
'Private Sub appnavbar_Hamburger_Click (e As BANanoEvent)
'End Sub

'navba menu click
Private Sub appnavbar_Menu_Click (e As BANanoEvent)
	app.ShowSwal("Menu Click!")
End Sub


Private Sub btnLogOff_Click (e As BANanoEvent)
	e.preventdefault
	'hide stuff, fix the height fist
	IsAuthenticated(False)
	'show login
	pgSignIn.Show(app)
End Sub

'show/hide drawer
Sub IsAuthenticated(b As Boolean)
	If b Then
		appdrawer.Show
		appdrawer.AdjustClippedLeft(True)
		appnavbar.Show
		appbottomnavbar.Show
	Else
		appdrawer.AdjustClippedLeft(False)
		appdrawer.Hide
		appnavbar.hide
		appbottomnavbar.Hide
	End If		
End Sub

Sub UpdateUserName(s As String)
	lblUserName.Caption = s
End Sub

Sub UpdateUserAvatar(s As String)
	userAvatar.Src = s
End Sub

Private Sub appbottomnavbar_Click (item As String)
	'the item starts with page_
	If app.ShowPage(item) Then Return
	'
	Select Case item
		
	End Select
End Sub