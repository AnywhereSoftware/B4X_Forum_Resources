B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	Private Tjo As JavaObject
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub

'Returns the name of the entity (class, interface, array class, primitive type, or void) represented by this Class object, as a String.
Public Sub GetName As String
	Return Tjo.RunMethod("getName",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub
