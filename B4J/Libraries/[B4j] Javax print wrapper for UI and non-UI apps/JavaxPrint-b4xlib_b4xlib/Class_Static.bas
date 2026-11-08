B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Returns the Class object associated with the class or interface with the given string name.
Public Sub ForName(ClassName As String) As Class_Wrapper
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.lang.Class")
	Dim Wrapper As Class_Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("forName",Array As Object(ClassName)))
	Return Wrapper
End Sub