B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.07
@EndOfDesignText@
'Static code module
Sub Class_Globals
	'the vuetify instance	
	Public vuetify As VuetifyApp
	'this route page
	Public page As VueComponent
	'the path to this page
	Public path As String
	'the name of the page, should be unique
	Public name As String = "home"
	'banano transpiler
	Private banano As BANano			'ignore
	Private VLabel1 As VLabel
	Private cboLanguage As VAutoComplete
End Sub

'initializes the page and builds the html structure
Sub Initialize(v As VuetifyApp)						'ignoreDeadCode
	'establish a reference to the app
	vuetify = v
	'initialize the page using unique name
	page.Initialize(Me, name)
	'link the vuetify instance
	page.vuetify = vuetify
	'set the page title
	page.Title = "Home"
	'make this the start page
	page.StartPage
	path = page.path
	'
	'build the page html here
	banano.LoadLayout(page.Here, "homelayout")
	
	vuetify.AddTranslation("en", "de", "hello", "Hello {name}!", "Guten Tag, {name}!")
	vuetify.AddTranslation("en", "de", "welcome", "Welcome!", "Willkommen!")
	vuetify.AddTranslation("en", "de", "yes-button", "Yes", "Ja")
	vuetify.AddTranslation("en", "de", "no-button", "No", "Nein")
	
	'add this route component to the app
	vuetify.AddRoute(page)
End Sub

Sub beforeEnter(boTo As Map, boFrom As Map, boNext As BANanoObject)   'ignoreDeadCode
	vuetify.Loading(True)
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
	'update the page title
	vuetify.SetBrowserTitle(boTo)
End Sub

'Use beforeDestroy if you need to clean-up events or reactive subscriptions:	
'Sub beforedestroy		'ignoreDeadCode
'	Log("beforedestroy")
'End Sub

'The updated hook runs after data changes on your component and the DOM re-renders.
'Sub updated			'ignoreDeadCode
'	Log("updated")
'End Sub

'The beforeUpdate hook runs after data changes on your component and the update cycle begins, right before the DOM is patched and re-rendered.
'Sub beforeupdate		'ignoreDeadCode
'	Log("beforeupdate")
'End Sub

'The beforeMount hook runs right before the initial render happens and after the template or render functions have been compiled:
'Sub beforemount		'ignoreDeadCode
'	Log("beforemount")
'End Sub

'The beforeCreate hook runs at the very initialization of your component. data has not been made reactive, and events have not been set up yet
'Sub beforecreate		'ignoreDeadCode
'	Log("beforecreate")
'End Sub

'You are able to access reactive data and events that are active with the created hook.
'Templates and Virtual DOM have not yet been mounted or rendered:
'Sub created		'IgnoreDeadCode
'	Log("created")
'End Sub

'In the mounted hook, you will have full access to the reactive component, templates, and rendered DOM
Sub mounted		'ignoreDeadCode
	vuetify.Loading(False)
End Sub

'Use destroyed if you need do any last-minute cleanup or inform a remote server that the component was destroyed:
'Sub destroyed		'ignoreDeadCode
'	Log("destroyed")
'End Sub

Private Sub cboLanguage_Change (item As Object)
	vuetify.SetLocale(item)
End Sub