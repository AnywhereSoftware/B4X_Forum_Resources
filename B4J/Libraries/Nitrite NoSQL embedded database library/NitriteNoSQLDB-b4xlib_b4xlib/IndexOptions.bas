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
	Public Const INDEXTYPE_UNIQUE As String = "Unique"
	Public Const INDEXTYPE_NONUNIQUE As String = "NonUnique"
	Public Const INDEXTYPE_FULLTEXT As String = "Fulltext"
End Sub


Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("org.dizitart.no2.IndexOptions",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Specifies the type of an index to create.
Public Sub GetIndexType As JavaObject
	Return TJO.RunMethod("getIndexType",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Creates an IndexOptions with the specified indexType and async flag.
'IndexOption - One of the IndexType_ Constants
Public Sub IndexOptions2(IndexType As String, Async As Boolean) As IndexOptions
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("org.dizitart.no2.IndexOptions")
	Dim Wrapper As IndexOptions
	Wrapper.Initialize
	Wrapper.SetObject(TJO1.RunMethod("indexOptions",Array As Object(IndexType, Async)))
	Return Wrapper
End Sub
'Indicates whether an index to be created in a non-blocking way.
Public Sub IsAsync As Boolean
	Return TJO.RunMethod("isAsync",Null)
End Sub
'Indicates whether an index to be created in a non-blocking way.
Public Sub SetAsync(Async As Boolean)
	TJO.RunMethod("setAsync",Array As Object(Async))
End Sub
'Specifies the type of an index to create.
Public Sub SetIndexType(IndexType As String)
	TJO.RunMethod("setIndexType",Array As Object(IndexType))
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

