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

	Private Tjo As JavaObject
End Sub

'*
Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("org.dizitart.no2.Lookup",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Specifies the field from the foreign records.
Public Sub GetForeignField As String
	Return Tjo.RunMethod("getForeignField",Null)
End Sub
'Specifies the field from the records input to the join.
Public Sub GetLocalField As String
	Return Tjo.RunMethod("getLocalField",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Specifies the new field of the joined records.
Public Sub GetTargetField As String
	Return Tjo.RunMethod("getTargetField",Null)
End Sub
'Specifies the field from the foreign records.
Public Sub SetForeignField(ForeignField As String)
	Tjo.RunMethod("setForeignField",Array As Object(ForeignField))
End Sub
'Specifies the field from the records input to the join.
Public Sub SetLocalField(LocalField As String)
	Tjo.RunMethod("setLocalField",Array As Object(LocalField))
End Sub
'Specifies the new field of the joined records.
Public Sub SetTargetField(TargetField As String)
	Tjo.RunMethod("setTargetField",Array As Object(TargetField))
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

'Set the Tag for this object
Public Sub SetTag(Tag As Object)
	Tjo.RunMethod("setUserData",Array(Tag))
End Sub

'Get the Tag for this object
Public Sub GetTag As Object
	Dim Tag As Object = Tjo.RunMethod("getUserData",Null)
	If Tag = Null Then Tag = ""
	Return Tag
End Sub

