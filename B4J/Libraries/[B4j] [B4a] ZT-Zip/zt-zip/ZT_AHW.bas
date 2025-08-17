B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.78
@EndOfDesignText@
'Static code module
'Add hoc Wrappers
Sub Process_Globals
	
End Sub

Public Sub ListToArray(L As JavaObject) As Object()
	Return L.RunMethod("toArray",Null)
End Sub