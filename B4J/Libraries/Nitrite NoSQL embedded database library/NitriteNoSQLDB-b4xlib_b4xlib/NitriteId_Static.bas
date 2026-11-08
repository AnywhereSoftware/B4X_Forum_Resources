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

'Creates a NitriteId from a long value.
Public Sub CreateId(Value As JavaObject) As NitriteId
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.dizitart.no2.NitriteId")
	Dim Wrapper As NitriteId
	Wrapper.Initialize
	Wrapper.SetObject(TJO1.RunMethod("createId",Array As Object(Value)))
	Return Wrapper
End Sub

'Gets a new auto-generated NitriteId.
Public Sub NewId As NitriteId
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.dizitart.no2.NitriteId")
	Dim Wrapper As NitriteId
	Wrapper.Initialize
	Wrapper.SetObject(TJO1.RunMethod("newId",Null))
	Return Wrapper
End Sub