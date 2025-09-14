B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
'	Private fx As JFX
End Sub

'Creates a new UpdateOptions.
Public Sub NewUpdateOptions(Upsert As Boolean) As UpdateOptions
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.UpdateOptions")
	Dim Wrapper As UpdateOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("updateOptions",Array As Object(Upsert)))
	Return Wrapper
End Sub

'Creates a new UpdateOptions.
Public Sub UpdateOptions2(Upsert As Boolean, JustOnce As Boolean) As UpdateOptions
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.UpdateOptions")
	Dim Wrapper As UpdateOptions
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("updateOptions",Array As Object(Upsert, JustOnce)))
	Return Wrapper
End Sub