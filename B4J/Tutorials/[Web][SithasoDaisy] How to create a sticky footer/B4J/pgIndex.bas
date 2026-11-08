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
	Private appfooter As SDUIFooter				'ignore
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
	'create the footer content
	CreateDrawerFooter
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

Sub CreateDrawerFooter
	'get the footer inside the drawer
	appfooter = appdrawer.Footer
	'set the background color
	appfooter.BGColor = app.COLOR_NEUTRAL
	'set the text color
	appfooter.TextColorIntensity(app.COLOR_NEUTRAL, "content")
	'add some padding
	appfooter.Root.p(10)
	'
	Dim c1 As SDUIDiv = appfooter.AddColumn("c1", "")
	c1.AddFooterTitle("ft1", "Services")
	c1.AddLink("ft1l1", "Branding", "#").Hover
	c1.AddLink("ft1l2", "Design", "#").Hover
	c1.AddLink("ft1l3", "Marketing", "#").Hover
	c1.AddLink("ft1l4", "Advertisement", "#").Hover
	
	'
	Dim c2 As SDUIDiv = appfooter.AddColumn("c2", "")
	c2.AddFooterTitle("ft2", "Company")
	c2.AddLink("ft2l1", "About Us", "#").Hover
	c2.AddLink("ft2l2", "Contact Us", "#").Hover
	c2.AddLink("ft2l3", "Services", "#").Hover
	c2.AddLink("ft2l4", "Press Kit", "#").Hover
	'
	Dim c3 As SDUIDiv = appfooter.AddColumn("c3", "")
	c3.AddFooterTitle("ft3", "Legal")
	c3.AddLink("ft3l1", "Terms of Use", "#").Hover
	c3.AddLink("ft3l2", "Privacy Policy", "#").Hover
	c3.AddLink("ft3l3", "Cookie Policy", "#").Hover
End Sub

'when a user clicks a link
Sub ft1l1_click(e As BANanoEvent)
	e.PreventDefault
	pgHome.Show(app)
End Sub

'when a user clicks a link
Sub ft1l2_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("Design")
End Sub

'when a user clicks a link
Sub ft1l3_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("Marketing")
End Sub

'when a user clicks a link
Sub ft1l4_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("Advertisement")
End Sub

'when a user clicks a link
Sub ft2l1_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("About Us")
End Sub

'when a user clicks a link
Sub ft2l2_click(e As BANanoEvent)
	e.PreventDefault
	pgContactUs.Show(app)
End Sub

'when a user clicks a link
Sub ft2l3_click(e As BANanoEvent)
	e.PreventDefault
	pgServices.Show(app)
End Sub

'when a user clicks a link
Sub ft2l4_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("Press Kit")
End Sub

'when a user clicks a link
Sub ft3l1_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("Terms of Use")
End Sub

'when a user clicks a link
Sub ft3l2_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("Privacy Policy")
End Sub

'when a user clicks a link
Sub ft3l3_click(e As BANanoEvent)
	e.PreventDefault
	apptoast.ShowSuccess("Cookie Policy")
End Sub

'an item in the menu is clicked
Private Sub appdrawer_menu_Click (item As String)
	'hide the drawer (wont hide if set to mobile)
	appdrawer.Close
	
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
		'appfooter.Show
	Else
		appdrawer.AdjustClippedLeft(False)
		appdrawer.Hide
		appnavbar.hide
		'appfooter.Hide
	End If		
End Sub

Sub UpdateUserName(s As String)
	lblUserName.Caption = s
End Sub

Sub UpdateUserAvatar(s As String)
	userAvatar.Src = s
End Sub
