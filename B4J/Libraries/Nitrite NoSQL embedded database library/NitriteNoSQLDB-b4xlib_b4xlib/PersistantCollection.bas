B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
#Event: PersistentCollection (MethodName As String,Args() as Object) As Object
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private Tjo As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'May need to use CreateEventFromUI dependant on usage and change default return value (Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Closes the collection for further access.
Public Sub Close
	Tjo.RunMethod("close",Null)
End Sub
'Creates an index on value, if not already exists.
'IndexOptions 
Public Sub CreateIndex(Field As String, IndexOption As IndexOptions)
	Tjo.RunMethod("createIndex",Array As Object(Field, IndexOption.GetObject))
End Sub
'Drops the collection and all of its indices.
Public Sub Drop
	Tjo.RunMethod("drop",Null)
End Sub
'Drops all indices from the collection.
Public Sub DropAllIndices
	Tjo.RunMethod("dropAllIndices",Null)
End Sub
'Drops the index on a field.
Public Sub DropIndex(Field As String)
	Tjo.RunMethod("dropIndex",Array As Object(Field))
End Sub
'Gets a single element from the collection by its id.
Public Sub GetById(TNitriteId As NitriteId) As Object
	Return Tjo.RunMethod("getById",Array As Object(TNitriteId.GetObject))
End Sub
'Returns the name of the PersistentCollection.
Public Sub GetName As String
	Return Tjo.RunMethod("getName",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Checks if a value is already indexed or not.
Public Sub HasIndex(Field As String) As Boolean
	Return Tjo.RunMethod("hasIndex",Array As Object(Field))
End Sub
'Inserts elements into this collection.
Public Sub Insert(Elements() As Object) As WriteResult
	Dim Wrapper As WriteResult
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("insert",Array As Object(Elements)))
	Return Wrapper
End Sub
'Returns true if the collection is closed; otherwise, false.
Public Sub IsClosed As Boolean
	Return Tjo.RunMethod("isClosed",Null)
End Sub
'Returns true if the collection is dropped; otherwise, false.
Public Sub IsDropped As Boolean
	Return Tjo.RunMethod("isDropped",Null)
End Sub
'Checks if indexing operation is currently ongoing for a field.
Public Sub IsIndexing(Field As String) As Boolean
	Return Tjo.RunMethod("isIndexing",Array As Object(Field))
End Sub
'Gets a set of all indices in the collection.
Public Sub ListIndices As List
	Dim JO As JavaObject = Tjo.RunMethod("listIndices",Null)
	Dim L As List
	L.Initialize
	Dim It As JavaObject = JO.RunMethod("iterator",Null)
	Do While It.RunMethod("hasNext",Null)
		L.Add(It.RunMethod("next",Null))
	Loop
	Return L
End Sub
'Rebuilds index on field if it exists.
Public Sub RebuildIndex(Field As String, Async As Boolean)
	Tjo.RunMethod("rebuildIndex",Array As Object(Field, Async))
End Sub
'Deletes the element from the collection.
Public Sub Remove(Element As Object) As WriteResult
	Dim Wrapper As WriteResult
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("remove",Array As Object(Element)))
	Return Wrapper
End Sub
'Returns the size of the PersistentCollection.
Public Sub Size As Long
	Return Tjo.RunMethod("size",Null)
End Sub
'Updates element in the collection.
Public Sub Update(Element As Object) As WriteResult
	Dim Wrapper As WriteResult
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("update",Array As Object(Element)))
	Return Wrapper
End Sub
'Updates element in the collection.
Public Sub Update2(Element As Object, Upsert As Boolean) As WriteResult
	Dim Wrapper As WriteResult
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("update",Array As Object(Element, Upsert)))
	Return Wrapper
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

