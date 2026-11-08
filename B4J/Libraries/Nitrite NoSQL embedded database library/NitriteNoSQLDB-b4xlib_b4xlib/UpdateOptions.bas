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
	Tjo.InitializeNewInstance("org.dizitart.no2.UpdateOptions",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Indicates if only one document will be updated or all of them.
Public Sub IsJustOnce As Boolean
	Return Tjo.RunMethod("isJustOnce",Null)
End Sub
'Indicates if the update operation will insert a new document if it does not find any existing document to update.
Public Sub IsUpsert As Boolean
	Return Tjo.RunMethod("isUpsert",Null)
End Sub
'Indicates if only one document will be updated or all of them.
Public Sub SetJustOnce(JustOnce As Boolean)
	Tjo.RunMethod("setJustOnce",Array As Object(JustOnce))
End Sub
'Indicates if the update operation will insert a new document if it does not find any existing document to update.
Public Sub SetUpsert(Upsert As Boolean)
	Tjo.RunMethod("setUpsert",Array As Object(Upsert))
End Sub
'*
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

