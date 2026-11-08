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
	Private swapTheme As SDUISwap		'ignore
	Private themeName As String
End Sub

Sub Initialize					'ignoreDeadCode
	'initialize the app
	BANano.Await(app.AddApp(Me, Main.AppName))
	'BANano.Await(app.UsesPocketBase)
	'BANano.Await(app.UsesFlatPickDateTime)
	'BANano.Await(app.UsesRollDate)
	'BANano.Await(app.UsesExcel)
	'BANano.Await(app.UsesPDF)
	'BANano.Await(app.UsesEnjoyHint)
	'set the font of the app
	app.Font = "font-sans"	
	'load the base layout
	BANano.LoadLayoutAppend(app.Here, "baselayout")
	'set theme
	themeName = $"${Main.AppName}_theme"$
	Dim ctheme As String = BANano.GetLocalStorage2(themeName)
	ctheme = SDUIShared.CStr(ctheme)
	Select Case ctheme
	Case "", app.THEME_LIGHT
		app.Theme = app.THEME_LIGHT
		swapTheme.Checked = False
	Case app.THEME_DARK
		swapTheme.Checked = True
		app.Theme = app.THEME_DARK
	End Select
	'link this app to the drawer, this is needed
	'when adding pages to side nav
	appdrawer.app = app
	appnavbar.TitleCaption = Main.AppTitle
	'create the drawer menu
	CreateDrawerMenu
	'add any other page not added to the drawer menu
	AddPages
	'show the sign in page
	IsAuthenticated(True)
	'show the home page
	pgtablecrud.Show(app)
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
	appdrawer.AddItemPage(pgtablecrud)
	
End Sub

'an item in the menu is clicked
Private Sub appdrawer_menu_Click (item As String)
	'hide the drawer (wont hide if set to mobile)
	appdrawer.Close
	
	'if this is a page
	'navigate to it and exit
	If app.ShowPage(item) Then Return
	
	'we have code that does not open a page
End Sub

'if you want to fie an event when the hambuge is clicked
'uncomment this
'Private Sub appnavbar_Hamburger_Click (e As BANanoEvent)
'End Sub

'navba menu click
Private Sub appnavbar_Menu_Click (e As BANanoEvent)
	e.PreventDefault
	app.ShowSwal("Menu Click!")
End Sub


Private Sub btnLogOff_Click (e As BANanoEvent)
	e.PreventDefault
	'hide stuff, fix the height fist
	IsAuthenticated(False)
	'show login
	pgtablecrud.Show(app)
End Sub

'show/hide drawer
Sub IsAuthenticated(b As Boolean)
	If b Then
		appdrawer.Show
		appdrawer.AdjustClippedLeft(True)
		appnavbar.Show
	Else
		appdrawer.AdjustClippedLeft(False)
		appdrawer.Hide
		appnavbar.hide
	End If
End Sub
