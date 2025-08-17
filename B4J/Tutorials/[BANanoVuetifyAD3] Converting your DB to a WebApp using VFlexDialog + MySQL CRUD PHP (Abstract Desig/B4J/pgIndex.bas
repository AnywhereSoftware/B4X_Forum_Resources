B4J=true
Group=Default Group\App
ModulesStructureVersion=1
Type=StaticCode
Version=9.5
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Public vuetify As VuetifyApp		'ignore
	Public BANano As BANano		'ignore

	Private appbar As VAppBar					'ignore
	Private appbartitle As VToolBarTitle		'ignore
	Private appdrawer As VNavigationDrawer		'ignore
	Private apphamburger As VAppBarNavIcon		'ignore
	Private applogo As VImg						'ignore
	Private appmain As VMain					'ignore
	Private approuterview As VRouterView		'ignore
	Private appsnack As VSnackBar				'ignore
	Private appspacer As VSpacer				'ignore
	Private apptransition As VTransition		'ignore
	Private btnLogOff As VFAB					'ignore
	Private drwlist As VList					'ignore
	Private drwoptions As VListOptions			'ignore
	Private inspire As VApp						'ignore
	Private dsMaster As BananoDataSource		'ignore
	Private appdialog As VMsgBox				'ignore
End Sub

Sub Init					'ignoreDeadCode
	'initialize the app
	vuetify.Initialize(Me, Main.AppName)
	'load the base layout
	BANano.LoadLayout(vuetify.Here, "baselayout")
	'set the app title
	vuetify.SetData("apptitle", Main.AppTitle)
	
	'set the list options
	drwlist.SetOptions(drwoptions)
	'
	'tell instance about the router view
	vuetify.BindRouterView(approuterview)
	'tell instace about the progress loader
	vuetify.BindProgressLoaderOn(appbar)
	'hide stuff on small evices		
	appbartitle.HiddenSMAndDown
	appspacer.HiddenSMAndDown
	'save data source connection for master settings
	vuetify.GetBackEnd(dsMaster)
	'add other route component pages
	AddPages
	'we are using pdf for exporting, this should be defined explicitly
	'vuetify.UseJsPDF
	'universal dialog management
	vuetify.AddMethod("OkResponse", Null)
	vuetify.AddMethod("CancelResponse", Null)
	'render the ux
	vuetify.Serve
	'Log(vuetify.UsageReport)
End Sub

'before each page is rendered
Sub beforeEach(boTo As Map, boFrom As Map, boNext As BANanoObject)   'ignoreDeadCode
	Log("beforeEach...")
	vuetify.Loading(True)
	'Dim sToPage As String = boTo.Get("name")
	'Log(boTo)
	'Log(boFrom)
	'the page we are going to
	'vuetify.SaveRoute(boTo, False)
	'check authentication
	'If vuetify.Authenticated = False Then
	'user is not authenticated, go to login page
	'	vuetify.NavigateToNext(boNext, "login")
	'	Return
	'End If
	'continue navigation
	vuetify.NavigateToNext(boNext, "")
End Sub

'after each page is rendered
'Sub afterEach(boTo As Map, boFrom As Map)   'ignoreDeadCode
'	vuetify.Loading(False)
'End Sub


'code to add other pages to the app
Sub AddPages			'IgnoreDeadCode
	Dim pgblank As blankpage
	pgblank.Initialize(vuetify)
	'
	Dim pgprojects As ViewProjects
	pgprojects.Initialize(vuetify)
	BANano.Await(Build_projects_BackEnd)

End Sub
'
Sub Build_projects_BackEnd
	''add the data-model for 'projects' to the project instance
	vuetify.AddDataModel("projects", "id", "id")
	vuetify.AddDataModelStrings("projects", Array("id","name"))

	'START: CREATE TABLE IF NOT EXIST projects - NB: COMMENT THIS SECTION OUT FOR PRODUCTION
	'declare the table recordSet
	'this will create the table if it does not exist
	'Comment this code for production
	Dim rsprojects As BANanoMySQLE
	'initialize table for table creation
	rsprojects.Initialize("projects", "projects", "id", "id")
	'set the master back-end
	vuetify.SetBackEndMySQLE(rsprojects)
	rsprojects.SchemaAddInt(Array("id"))
	rsprojects.SchemaAddText(Array("name"))
	'generate & run command to create the table
	rsprojects.SchemaCreateTable
	rsprojects.JSON = BANano.CallInlinePHPWait(rsprojects.MethodName, rsprojects.Build)
	rsprojects.FromJSON
	'END: CREATE TABLE IF NOT EXIST projects
End Sub

Private Sub apphamburger_ClickStop (e As BANanoEvent)			'ignoreDeadCode
	appdrawer.ToggleOnApp(vuetify)
End Sub

Private Sub drwlist_Click (item As Map)				'ignoreDeadCode
	vuetify.NavigateTo("/")
End Sub

Private Sub btnLogOff_Click (e As BANanoEvent)			'ignoreDeadCode
	'turn off authentication
	vuetify.Authenticated = False
	'navigate to the start page
	vuetify.NavigateTo("/")
End Sub


'Use beforeDestroy if you need to clean-up events or reactive subscriptions:	
'Sub beforedestroy		'ignoreDeadCode
'	Log("app.beforedestroy")
'End Sub

'The updated hook runs after data changes on your component and the DOM re-renders.
'Sub updated			'ignoreDeadCode
'	Log("app.updated")
'End Sub

'The beforeUpdate hook runs after data changes on your component and the update cycle begins, right before the DOM is patched and re-rendered.
'Sub beforeupdate		'ignoreDeadCode
'	Log("app.beforeupdate")
'End Sub

'The beforeMount hook runs right before the initial render happens and after the template or render functions have been compiled:
'Sub beforemount		'ignoreDeadCode
'	Log("app.beforemount")
'End Sub

'The beforeCreate hook runs at the very initialization of your component. data has not been made reactive, and events have not been set up yet
'Sub beforecreate		'ignoreDeadCode
'	Log("app.beforecreate")
'End Sub

'You are able to access reactive data and events that are active with the created hook.
'Templates and Virtual DOM have not yet been mounted or rendered:
Sub created		'IgnoreDeadCode
	'close the drawer
	appdrawer.CloseOnApp(vuetify)
	'clear the listview
	drwlist.ClearOnApp(vuetify)
	drwlist.AddItem("", "pprojects", "mdi-vuetify", "blue", "Projects", "/vprojects")
	'refresh the drawer
	drwlist.RefreshOnApp(vuetify)
End Sub

'In the mounted hook, you will have full access to the reactive component, templates, and rendered DOM
'Sub mounted		'ignoreDeadCode
'	Log("app.mounted")
'End Sub

'Use destroyed if you need do any last-minute cleanup or inform a remote server that the component was destroyed:
'Sub destroyed		'ignoreDeadCode
'	Log("app.destroyed")
'End Sub

'garbage collection when f5 is pressed
Sub BeforeUnload(e As BANanoEvent)
	'vuetify.Destroy
	vuetify.DoNotDestroy(e)
End Sub

'change the user name on vappbar.appuser
Sub ChangeUserName(newUserName As String)			'IgnoreDeadCode
	vuetify.SetData("username", newUserName)
End Sub

'change the title on vappbar.vtoolbartitle
Sub ChangeAppBarTitle(newTitle As String)			'IgnoreDeadCode
	vuetify.SetData("apptitle", newTitle)
End Sub

'pgIndex.appdialog.OK_click
private Sub OkResponse
	'hide the universal dialog
	vuetify.HideDialog
	'get the process response
	Dim lastProcess As String = vuetify.Process	'ignore
	'get the prompt entered
	Dim enteredValue As String = vuetify.GetResponseValue		'ignore
	Select Case lastProcess
		Case ""
	End Select
End Sub

'pgIndex.appdialog.CANCEL_click
private Sub CancelResponse
	'hide the universal dialog
	vuetify.hidedialog
	'get the process response
	Dim lastProcess As String = vuetify.Process	'ignore
	Select Case lastProcess
		Case ""
	End Select
End Sub

Private Sub appdialog_Ok_Click (e As BANanoEvent)
	vuetify.ActivePageOkResponse
End Sub

Private Sub appdialog_Cancel_click (e As BANanoEvent)
	vuetify.ActivePageCancelResponse
End Sub

Private Sub appdialog_Visible
	
End Sub