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

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Instantiates a new Index.
Public Sub Create(IndexType As JavaObject, Field As String, CollectionName As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("org.dizitart.no2.Index",Array As Object(IndexType, Field, CollectionName))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Gets the collection name.
Public Sub GetCollectionName As String
	Return Tjo.RunMethod("getCollectionName",Null)
End Sub
'Gets the target value for the index.
Public Sub GetField As String
	Return Tjo.RunMethod("getField",Null)
End Sub
'Specifies the type of the index.
Public Sub GetIndexType As JavaObject
	Return Tjo.RunMethod("getIndexType",Null)
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

