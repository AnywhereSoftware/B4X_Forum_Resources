B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub GetObject As Object
	Return TJO
End Sub

Public Sub SetObject(O As Object)
	TJO = O
End Sub

Public Sub GetCategory As Object
	Return TJO.RunMethod("getCategory",Null)
End Sub

Public Sub GetName As String
	Return TJO.RunMethod("getName",Null)
End Sub

Public Sub GetValue As Object
	Return TJO.RunMethod("getValue",Null)
End Sub

Public Sub Tostring As String
	Return TJO.RunMethod("toString",Null)
End Sub