B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Public BANano As BANano		'ignore
	Public App As SDUI5App
	Private appdrawer As SDUI5Drawer		'ignore
	Private appnavbar As SDUI5NavBar		'ignore
	Private pageView As SDUI5Container		'ignore
	Private drawermenu As SDUI5Menu		'ignore
End Sub

Sub Initialize					'ignoreDeadCode
	BANano.Await(App.Initialize(Me))
	'load the main layout to the body of the page
	BANano.LoadLayout(App.Here, "baselayout")
	'create the drawer menu
	BANano.Await(CreateDrawerMenu)
	'add any other page not added to the drawer menu
	'IsAuthenticated(False)
	'define the database schema for use in the database as a while
	App.AddDataModel("categories", "id", True)
	App.AddDataModelStrings("categories", Array("name", "color"))
	
	
	'show the categories page
	pgDashboard.Show(App)
	App.pageresume
End Sub

'fired when a drawer is closed / opened
Private Sub appdrawer_Opened (Status As Boolean)
	'the hamburger is a swap so open / close it when overlay is clicked also
	appnavbar.Hamburger.Active = Status
End Sub

'define the menu items fo dawe
Sub CreateDrawerMenu
	drawermenu.AddMenuItemIconText("pg-categories", "", "Categories", False)
	
	drawermenu.AddItemParent("", "settings", "", "Settings")
	drawermenu.AddItemChild("settings", "pg-users", "", "Users")
	drawermenu.AddItemChild("settings", "pg-permissions", "", "Permissions")
	
End Sub


'the hamburger is a swap button, open / close the drawer depending
Private Sub appnavbar_BurgerClick (value As Boolean)
	appdrawer.OpenDrawer(value)
End Sub

Private Sub drawermenu_ItemClick (item As String)
	'close the drawer on menu item click
	appdrawer.OpenDrawer(False)
	'close the swap button
	appnavbar.Hamburger.Active = False
	'to force the drawer to close you can execute
	'appdrawer.ForceClose

	Dim sprefix As String = App.UI.MvField(item, 1, "-")
	Dim ssuffix As String = App.UI.MvField(item, 2, "-")
	Select Case sprefix
	Case "pg"
		'only mark this item as active
		BANano.Await(drawermenu.SetItemActive(item))
		Select Case ssuffix
		Case "categories"
			pgCategories.Show(App)
		Case "users"
			'pgInfoBox.Show(App)
		Case "permissions"
'				pgGroupSelect.Show(App)
		End Select
	End Select	
End Sub


Private Sub btnLogOff_Click (e As BANanoEvent)
'	'hide stuff, fix the height fist
'	IsAuthenticated(False)
'	'show login
'	pgSignIn.Show(app)
End Sub

'show/hide drawer
Sub IsAuthenticated(b As Boolean)
'	If b Then
'		appdrawer.Show
'		appdrawer.AdjustClippedLeft(True)
'		appnavbar.Show
'	Else
'		appdrawer.AdjustClippedLeft(False)
'		appdrawer.Hide
'		appnavbar.hide
'	End If		
End Sub

'update the title of the page
Sub UpdateTitle(s As String)
	appnavbar.Title = s
End Sub

Sub UpdateUserName(s As String)
'	lblUserName.Caption = s
End Sub

Sub UpdateUserAvatar(s As String)
'	userAvatar.Src = s
End Sub

'the title of the app navbar has been clicked
Private Sub appnavbar_TitleClick (e As BANanoEvent)
	e.PreventDefault
	App.ShowToastSuccess("Title Click!")
End Sub
