B4J=true
Group=Default Group\Views
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'This is needed by the BANanoServer i.e. jetty server
#Region BANano
' <-------------- IMPORTANT! This is because we want this module to be transpiled by BANano
#End Region
'Global variables...
Sub Class_Globals
	'the vuetify app instance
	Public vuetify As VuetifyApp
	'this page instance
	Public page As VueComponent
	'the name of this route component page
	Public name As String = "vprojects"
	Public path As String = "/vprojects"
	'the b4x to javascript transpiler
	Private BANano As BANano			'ignore
	'define the page components
	Private contprojects As VContainer			'ignore
	Private rowprojects As VRow			'ignore
	Private colprojects As VCol			'ignore
	Private tblprojects As VueTable			'ignore
	Private dsprojects As BananoDataSource			'ignore
	Private dlgprojects As VFlexDialog			'ignore
	Private frmprojects As VForm			'ignore
	Private confirmprojects As VMsgBox			'ignore
	Private txtid As VField    'ignore
	Private txtname As VField    'ignore
End Sub
Sub Initialize(v As VuetifyApp)
	'establish a reference to the app
	vuetify = v
	'initialize the component
	page.Initialize(Me, name)
	page.vuetify = vuetify
	'set the page title
	page.Title = "Projects"
	'uncomment this line if this will be the first page
	page.StartPage
	path = page.path
	'
	'build the page html here
	BANano.LoadLayout(page.Here, "layprojects")
	'apply master data-source settings - set it on pgIndex
	vuetify.SetBackEnd(dsprojects)
	'add validation rules
	'get the empty form
	frmprojects = dlgprojects.Form
	'build the vflex dialog
	Build_projects_VFlexDialog
	frmprojects.AddRule("name", "namecheck")
	'bind the form to the ds & table (table should be set to manual)
	frmprojects.BindState(page)
	frmprojects.BindDataSource(dsprojects)
	frmprojects.BindDataTable(tblprojects)
	'universal dialog management
	page.AddMethod("OkResponse", Null)
	page.AddMethod("CancelResponse", Null)
	'*****
	'add the route page to vuetify instance
	vuetify.AddRoute(page)
End Sub
Private Sub namecheck(v As String) As Object	'IgnoreDeadCode
	v = BANanoShared.validstring(v)
	If v = "" Then
		Return "The  is required!"
	Else
		Return True
	End If
End Sub
'In the mounted hook, you will have full access to the reactive component, templates, and rendered DOM
Sub mounted		'ignoreDeadCode
	'we want the records to load on mount
	vuetify.Loading(True)
	'fetch the records from the data-base
	dsprojects.SELECT_ALL
End Sub
'build the vflex dialog
Sub Build_projects_VFlexDialog
	dlgprojects.TableName = "projects"
	dlgprojects.Title = "Projects"
	dlgprojects.PrimaryKey = "id"
	dlgprojects.AutoIncrement = "id"
	dlgprojects.RecordSource = "project"
	dlgprojects.Singular = "Project"
	dlgprojects.Plural = "Projects"
	dlgprojects.DisplayField = "name"
	dlgprojects.Clearable = False
	dlgprojects.Dense = True
	dlgprojects.HideDetails = True
	dlgprojects.Filled = False
	dlgprojects.Outlined = True
	dlgprojects.Rounded = False
	dlgprojects.Shaped = False

	txtid = dlgprojects.AddTextField (1, 1, "id", "#", "")
	dlgprojects.SetItemHeadings("id", "", "#")
	dlgprojects.SetItemOnDB("id", "Yes", "")
	dlgprojects.SetItemOnTable("id", "Normal", False, False ,False, "large")
	dlgprojects.SetItemHidden("id", True)
	txtname = dlgprojects.AddTextField (1, 1, "name", "Project Name", "")
	dlgprojects.SetItemOnDB("name", "Yes", "Yes")
	dlgprojects.SetItemOnTable("name", "Normal", False, True ,True, "large")
	dlgprojects.SetItemRequired("name","Project Name", True)
	dlgprojects.SetItemAutoFocus("name")

	dlgprojects.Refresh
End Sub
'refresh the contents of the 'projects' table
Private Sub tblprojects_Refresh_Click (e As BANanoEvent)       'IgnoreDeadCode
	'call mounted reloads the records to the data-table
	page.CallMounted
End Sub
'table add new button has been clicke
Private Sub tblprojects_Add_Click (e As BANanoEvent)	'IgnoreDeadCode
	dsprojects.ADD
	'change the title of the dialog
	dlgprojects.Title = $"Add ${(dsprojects.Singular)}"$
	'change the ok label
	dlgprojects.YesCaption = "Save"
	'change the cancel label
	dlgprojects.NoCaption = "Cancel"
	'show the dialog
	dlgprojects.Show
End Sub
'Edit button has been clicked on a row
'Gets the row being edited, keys have the field names
Private Sub tblprojects_Edit (item As Map)		'IgnoreDeadCode
	vuetify.Loading(True)
	'freeze the table contents
	tblprojects.Freeze
	'receive the record from the data-table and execute a read from the database
	dsprojects.EDIT(item)
End Sub
'Delete button has been clicked on a row
'Gets the row being deleted, keys have the field names
Private Sub tblprojects_Delete (item As Map)		'IgnoreDeadCode
	dsprojects.DELETE_CONFIRM(item)
	Dim sMsg As String = $"<h2>${dsprojects.DisplayValue}</h2><br>Are you sure that you want to delete this ${dsprojects.Singular.ToLowerCase}?"$
	confirmprojects.Confirm(page, "delete", "Confirm Delete", sMsg, "Yes", "No")
	'vuetify.Confirm("projects_delete", "Confirm Delete", sMsg, "Yes", "No")
End Sub
Private Sub confirmprojects_Ok_Click (e As BANanoEvent)			'IgnoreDeadCode
	'show a loading indicator on ok button
	confirmprojects.OkLoading = True
	'execute the delete call
	dsprojects.DELETE
End Sub
Private Sub dsprojects_Delete (Success As Boolean, Response As String, Error As String, affectedRows As Int, Result As List)		'IgnoreDeadCode
	confirmprojects.OkLoading = False
	If Success And Response = dsprojects.RESULT_SUCCESS Then
		'hide the dialog
		confirmprojects.hide
		'load the method to load all records
		page.CallMounted
	Else
		Log(Error)
		vuetify.ShowSwalError("The operation could not be executed, please try again!")
		Return
	End If
End Sub
Private Sub confirmprojects_Cancel_click (e As BANanoEvent)			'IgnoreDeadCode
	''hide the dialog
	confirmprojects.hide
End Sub
'clear sort button has been clicked
Private Sub tblprojects_ClearSort_Click (e As BANanoEvent)		'IgnoreDeadCode
	tblprojects.ClearSort
End Sub
'back button has been clicked
Private Sub tblprojects_Back_Click (e As BANanoEvent)		'IgnoreDeadCode
	vuetify.NavigateTo("?")
End Sub
'Returns the records loaded from the database
Sub dsprojects_SelectAll (Success As Boolean, Response As String, Error As String, affectedRows As Int, Result As List)		'IgnoreDeadCode
	If Success And Response = dsprojects.RESULT_SUCCESS Then
		'reload records to the data-table
		tblprojects.Reload(Result)
		'refresh the totals if any
		tblprojects.RefreshTotals
		'turn off loading indicator
		vuetify.Loading(False)
	Else
		Log(Error)
		vuetify.Loading(False)
		vuetify.ShowSwalError("The operation could not be executed, please try again!")
		Return
	End If
End Sub
'fired when an edit-dialog is opened
Private Sub tblprojects_OpenItem (item As Map)
End Sub
'fired when an edit-dialog is cancelled
Private Sub tblprojects_CancelItem (item As Map)
End Sub
'fired when an edit-dialog is closed
Private Sub tblprojects_CloseItem (item As Map)
End Sub
'fired when an edit-dialog is saved
Private Sub tblprojects_SaveItem (item As Map)
End Sub
Private Sub dlgprojects_Yes_Click (e As BANanoEvent)		'IgnoreDeadCode
	'perform form data verification via data-source
	dsprojects.VERIFY
	'peform the form validation
	page.refs = vuetify.GetRefs
	Dim bValid As Boolean = frmprojects.Validate(page)
	If bValid = False Then
		'the validation has failed
		vuetify.ShowSwalToastError("Please enter all required information!", 2000)
		Return
	End If
	'show a loading indicator on the ok button
	dlgprojects.YesLoading = True
	'get the record from form (recordsource) and CREATE / UPDATE record depending on mode
	dsprojects.CREATE_OR_UPDATE
End Sub
Private Sub dsprojects_Create (Success As Boolean, Response As String, Error As String, affectedRows As Int, Result As List)		'IgnoreDeadCode
	'turn off the ok loading indicator
	dlgprojects.YesLoading = False
	If Success And Response = dsprojects.RESULT_SUCCESS Then
		'hide the dialog
		dlgprojects.hide
		'run method to load the records
		page.CallMounted
	Else
		Log(Error)
		vuetify.ShowSwalError("The operation could not be executed, please try again!")
		Return
	End If
End Sub
Private Sub dsprojects_Update (Success As Boolean, Response As String, Error As String, affectedRows As Int, Result As List)		'IgnoreDeadCode
	'turn off the loading indicator
	dlgprojects.YesLoading = False
	If Success And Response = dsprojects.RESULT_SUCCESS Then
		'hide the dialog
		dlgprojects.hide
		'run the method to load records
		page.CallMounted
	Else
		Log(Error)
		vuetify.ShowSwalError("The operation could not be executed, please try again!")
		Return
	End If
End Sub
'show a loading indicator for the data-table
'set the selected record to be active on the data-source and read from database
'we will show the edit dialog when the record is read from the db
Private Sub dsprojects_Read (Success As Boolean, Response As String, Error As String, affectedRows As Int, Result As List)		'IgnoreDeadCode
	vuetify.Loading(False)
	If Success And Response = dsprojects.RESULT_SUCCESS Then
		'move to the first record
		dsprojects.MOVE_FIRST(Result)
		'change the title of the dialog
		dlgprojects.Title = $"Edit ${(dsprojects.Singular)}"$
		'change the ok label
		dlgprojects.YesCaption = "Update"
		'change the cancel label
		dlgprojects.NoCaption = "Cancel"
		'show the dialog
		dlgprojects.Show
	Else
		Log(Error)
		vuetify.ShowSwalError("The operation could not be executed, please try again!")
		Return
	End If
End Sub
Private Sub dlgprojects_No_click (e As BANanoEvent)			'IgnoreDeadCode
	''hide the dialog
	dlgprojects.hide
End Sub
'the dialog has become visible, reset validation
Private Sub dlgprojects_Visible				'IgnoreDeadCode
	Try
		'determine if the dialog is visible
		Dim bVisible As Boolean = dlgprojects.IsVisible(page)
		'if the dialog is visible
		If bVisible Then
			'refresh the refs to link to the active page
			page.refs = vuetify.GetRefs
			'reset the form validations
			frmprojects.ResetValidation(page)
		End If
	Catch
	End Try			'ignore
End Sub
'change the user name on vappbar.appuser
Sub ChangeUserName(newUserName As String)			'IgnoreDeadCode
	vuetify.SetData("username", newUserName)
End Sub
'change the title on vappbar.vtoolbartitle
Sub ChangeAppBarTitle(newTitle As String)			'IgnoreDeadCode
	vuetify.SetData("apptitlecaption", newTitle)
End Sub
'<code>
'vuetify.Prompt("app_prompt", "First Name", "What is your first name", "", "", "Mashy", "Ok", "Cancel")
'vuetify.Confirm("app_confirm", "Confirm Delete", "Are you sure you want to delete this?", "Yes", "No")
'vuetify.Alert("app_alert", "Alert", "This is a app alert", "Great!")
'</code>
'returned by pgIndex.appdialog.OK_click
private Sub OkResponse
	'hide the universal dialog
	vuetify.HideDialog
	'get the process response
	Dim lastProcess As String = vuetify.Process	'ignore
	'get the prompt entered
	Dim enteredValue As String = vuetify.GetResponseValue		'ignore
	Select Case lastProcess
		Case ""
			'a record is deleted from projects
		Case "projects_delete"
	End Select
End Sub
'returned by pgIndex.appdialog.CANCEL_click
private Sub CancelResponse
	'hide the universal dialog
	vuetify.hidedialog
	'get the process response
	Dim lastProcess As String = vuetify.Process	'ignore
	Select Case lastProcess
		Case ""
			'a record deletion is cancelled for projects
		Case "projects_delete"
	End Select
End Sub
'Use beforeDestroy if you need to clean-up events or reactive subscriptions:
Sub beforeDestroy		'ignoreDeadCode
	'set = null all objects defined in this page
	'this seeks to preserve RAM
	page.DestroyAll
End Sub
'The updated hook runs after data changes on your component and the DOM re-renders.
'Sub updated			'ignoreDeadCode
'End Sub
'The beforeUpdate hook runs after data changes on your component and the update cycle begins, right before the DOM is patched and re-rendered.
'Sub beforeUpdate		'ignoreDeadCode
'End Sub
'The beforeMount hook runs right before the initial render happens and after the template or render functions have been compiled:
'Sub beforeMount		'ignoreDeadCode
'End Sub
'The beforeCreate hook runs at the very initialization of your component. data has not been made reactive, and events have not been set up yet
'Sub beforeCreate		'ignoreDeadCode
'End Sub
'Use destroyed if you need do any last-minute cleanup or inform a remote server that the component was destroyed:
'Sub destroyed		'ignoreDeadCode
'End Sub
