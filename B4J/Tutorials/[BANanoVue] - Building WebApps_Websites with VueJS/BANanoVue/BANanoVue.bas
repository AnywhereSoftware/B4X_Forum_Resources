B4J=true
Group=BANano
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private BOVue As BANanoObject
	Private BANAno As BANano  'ignore
	Private methods As Map
	Private data As Map
End Sub

'initialize view
Public Sub Initialize
	BOVue.Initialize("Vue")
	'empty the body of the page
	BANAno.GetElement("#body").empty
	'add an empty div
	BANAno.GetElement("#body").Append($"<div id="app"></div>"$)
	methods.Initialize
	data.Initialize  
End Sub

'use a component module
Sub Use(bo As BANanoObject)
	BOVue.RunMethod("use", bo)
End Sub

'render the ux
Sub UX()
	Dim opt As Map = CreateMap()
	opt.Put("el", "#app")
	If data.Size > 0 Then
		opt.put("data", data)
	End If
	If methods.Size > 0 Then
		opt.Put("methods", methods)
	End If
	BOVue.Initialize2("Vue", opt)
End Sub

'add a method
Sub SetMethod(methodName As String, cb As BANanoObject) As BANanoVue
	methods.Put(methodName, cb)
	Return Me
End Sub

'add data for state
Sub SetDefaultState(k As String, v As Object) As BANanoVue
	data.Put(k, v)
	Return Me
End Sub

'set the state
Sub SetState(k As String, v As Object) As BANanoVue
	If data.ContainsKey(k) Then
		Dim dKey As String = "$" & "data"
		Dim data As Map = BOVue.GetField(dKey).Result
		data.Put(k, v)
	Else
		Log("First set the v-model for " & k)
	End If	
End Sub

'get the state
Sub GetState(k As String, v As Object) As Object
	If data.ContainsKey(k) Then
		Dim dKey As String = "$" & "data"
		Dim data As Map = BOVue.GetField(dKey).Result
		Dim out As Object = data.Get(k)
		Return out
	Else
		Log("First set the v-model for " & k)
	End If	
End Sub