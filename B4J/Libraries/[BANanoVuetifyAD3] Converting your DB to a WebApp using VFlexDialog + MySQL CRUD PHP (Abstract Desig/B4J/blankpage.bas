B4J=true
Group=Default Group\App
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#ignorewarnings:12
#Region BANano 
	' <-------------- IMPORTANT! This is because we want this module to be transpiled by BANano 
#End Region

'Static code module
Sub Class_Globals	
	Public vuetify As VuetifyApp
	Public page As VueComponent
	Public path As String
	Public name As String = "blankpage"
	Private banano As BANano	'ignore
End Sub

Sub Initialize(v As VuetifyApp)
	'establish a reference to the app
	vuetify = v
	'initialize the component
	page.Initialize(Me, name)
	page.vuetify = vuetify
	'set the page title
	page.Title = "Blank Page"
	'uncomment this line if this will be the first page
	'page.StartPage
	path = page.path
	'
	'build the page html here
	banano.LoadLayout(page.Here, "layblank")
		
	'initialize this on pgIndex.AddPages
	'add the route page to vuetify instance
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

'You are able to access reactive data and events that are active with the created hook.
'Templates and Virtual DOM have not yet been mounted or rendered:
'Sub created		'IgnoreDeadCode
'	Log("created")
'End Sub

'In the mounted hook, you will have full access to the reactive component, templates, and rendered DOM
Sub mounted		'ignoreDeadCode
	vuetify.Loading(False)
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

'Use destroyed if you need do any last-minute cleanup or inform a remote server that the component was destroyed:
'Sub destroyed		'ignoreDeadCode
'	Log("destroyed")
'End Sub