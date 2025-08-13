B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano		'ignore
	Private app As SDUI5App			'ignore
	Public name As String = "categories"
	Public title As String = "categories"
	Public icon As String = "./assets/page.svg"
	Public color As String = "#000000"
	Private prefcategories As SDUI5Preferences			'ignore		
	Private tblcategories As SDUI5Table				'ignore
	Private Mode As String = ""							'ignore
	Private toDeleteID As String						'id of item to delete
	Private toDeleteName As String						'name of item to delete
End Sub

Sub Show(MainApp As SDUI5App)			'ignore
	app = MainApp
	'load the layout
	BANano.LoadLayout(app.PageView, "categoriesview")
	'change the title of the pgIndex navbar
	pgIndex.UpdateTitle("Categories")
	'define the table columns
	tblcategories.AddColumn("id", "#")
	tblcategories.SetColumnVisible("id", False)
	tblcategories.AddColumn("name", "Name")
	tblcategories.AddColumnBadge("color", "Color", "color")
	tblcategories.AddDesignerColums
	'build the preference dialog
	prefcategories.Clear
	prefcategories.AddPropertyTextBox("id", "Category ID", "-1", True)
	prefcategories.SetPropertyVisible("id", False)
	prefcategories.AddPropertyTextBox("name", "Name", "", True)
	prefcategories.AddPropertyColorWheel("color", "Color", "#f5375f", False, "16", 200, 20, "bottom-end")
	BANano.Await(MountCategories)
End Sub

'load categories from the database
Sub MountCategories
	'turn to add mode
	AddMode
	'select contacts from the database
	Dim api As SDUIMySQLREST
	api.Initialize(Me, "categories", Main.ServerURL, "categories")
	'the api file will be stock.php
	api.ApiFile = "stock"
	'we are using an api key to make calls
	api.UseApiKey = True
	'specify the api key
	api.ApiKey = Main.APIKey
	'link this api class to the data models
	api.SetSchemaFromDataModel(app.DataModels)
	'clear any where clauses
	api.CLEAR_WHERE
	'order the details by name
	api.ADD_ORDER_BY("name")
	'execute a select all
	BANano.Await(api.SELECT_ALL)
	'load the records to the database
	tblcategories.SetItemsPaginate(api.result)
End Sub


private Sub AddMode
	'turn the mode to CREATE
	Mode = "C"
	'change the title of the pref dialog
	prefcategories.Title = "Add Category"
	'set the default properties
	prefcategories.SetPropertyBagDefaults
	'focus on the name
	prefcategories.SetPropertyFocus("name")
End Sub

Private Sub tblcategories_EditRow (Row As Int, item As Map)
	'set the mode to U
	Mode = "U"
	'update the title of the preference dialog
	prefcategories.Title = "Edit Category"
	'set the pref dialog defaults
	prefcategories.SetPropertyBagDefaults
	'check if the roles has users asssigned to it
	app.pagepause
	Dim sID As String = item.Get("id")
	'execute a delete using the id of the category
	Dim api As SDUIMySQLREST
	api.Initialize(Me, "categories", Main.ServerURL, "categories")
	api.SetSchemaFromDataModel(app.DataModels)
	api.ApiFile = "stock"
	api.UseApiKey = True
	api.ApiKey = Main.APIKey
	Dim rec As Map = BANano.Await(api.READ(sID))
	'set the property bag record
	prefcategories.PropertyBag = rec
	'set focus on the name
	prefcategories.SetPropertyFocus("name")
	app.pageresume
End Sub

Private Sub tblcategories_DeleteRow (Row As Int, item As Map)
	'switch to add mode
	AddMode
	'get the id and name of the item to delete
	toDeleteID = item.Get("id")
	toDeleteName = item.Get("name")
	'build the confirmation message
	Dim sMsg As String = $"<h2 class="text-2xl font-bold mt-2">${toDeleteName}</h2><br>Are you sure that you want to delete this category?"$
	'wait for the user to confirm
	Dim bConfirm As Boolean = BANano.Await(app.ShowSwalConfirmWait("Confirm Delete", sMsg, "Yes", "No"))
	'the user has click No, exit
	If bConfirm = False Then Return
	'check if the roles has users asssigned to it
	app.pagepause
	'execute a delete using the id of the category
	Dim api As SDUIMySQLREST
	api.Initialize(Me, "categories", Main.ServerURL, "categories")
	api.SetSchemaFromDataModel(app.DataModels)
	api.ApiFile = "stock"
	api.UseApiKey = True
	api.ApiKey = Main.APIKey
	BANano.Await(api.DELETE(toDeleteID))
	'reload the categories
	BANano.Await(MountCategories)
	app.pageresume
End Sub

Private Sub tblcategories_Add (e As BANanoEvent)
	AddMode
End Sub

Private Sub tblcategories_Refresh (e As BANanoEvent)
	e.PreventDefault
	app.PagePause
	BANano.Await(MountCategories)
	app.pageresume
End Sub

Private Sub tblcategories_Back (e As BANanoEvent)
	e.preventdefault
	'show the dashboard
	pgDashboard.Show(app)
End Sub

Private Sub prefcategories_Yes_Click (e As BANanoEvent)
	e.PreventDefault
	'validate the property bag details
	Dim bValid As Boolean = BANano.Await(prefcategories.IsPropertyBagValid)
	If bValid = False Then
		BANano.Await(app.ShowSwalErrorWait("Category", "The category details are not complete!", "Ok"))
		Return
	End If
	'get the property bag fields as a map
	Dim pb As Map = BANano.Await(prefcategories.PropertyBag)
	app.pagepause
	'open the database gateway
	Dim api As SDUIMySQLREST
	api.Initialize(Me, "categories", Main.ServerURL, "categories")
	api.SetSchemaFromDataModel(app.DataModels)
	api.ApiFile = "stock"
	api.UseApiKey = True
	api.ApiKey = Main.APIKey
	'pass the map record
	api.SetRecord(pb)
'	rolesapi.ShowLog = False
	Select Case Mode
	Case "C"
		Dim nid As String = BANano.Await(api.CREATE)
	Case "U"
		Dim nid As String = BANano.Await(api.UPDATE)
	End Select
	If nid <> "" Then
		app.ShowToastSuccess("Category has been created/updated.")
	Else
		app.ShowToastError("Category has NOT been created/updated.")
	End If
	BANano.Await(MountCategories)
	app.pageresume
End Sub

Private Sub prefcategories_No_Click (e As BANanoEvent)
	AddMode
End Sub