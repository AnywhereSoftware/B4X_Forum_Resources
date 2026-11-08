B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private TJO As JavaObject
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Class is "org.dizitart.no2.NitriteId"
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'*
Public Sub CompareTo(Other As NitriteId) As Int
	Return TJO.RunMethod("compareTo",Array As Object(Other.GetObject))
End Sub

'*
Public Sub Equals(O As Object) As Boolean
	Return TJO.RunMethod("equals",Array As Object(O))
End Sub
'Gets the underlying id object.
Public Sub GetIdValue As JavaObject
	Return TJO.RunMethod("getIdValue",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'*
Public Sub HashCode As Int
	Return TJO.RunMethod("hashCode",Null)
End Sub

'*
Public Sub ToString As String
	Return TJO.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

