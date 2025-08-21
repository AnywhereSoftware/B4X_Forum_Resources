B4J=true
Group=Pages
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Public Vue As BANanoVue
	Private BANano As BANano  'ignore
End Sub

Sub Init
	'initialize vue, this clears the body and adds an empty div identified with app.
	Vue.Initialize
	'set the default state
	Vue.SetDefaultState("greeting", "Hello World!")
	
	'let's update the app div
	BANano.GetElement("#app").Append($"<h2>{{ greeting }}</h2>"$)
	
	'execute the DOM rendering
	Vue.ux
End Sub
