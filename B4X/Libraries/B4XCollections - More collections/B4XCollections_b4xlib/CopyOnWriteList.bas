B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Wraps an internal list. The internal list is replaced with a new list before each change.
'GetList returns the internal and unmodifiable list. Do not modify it directly.
'Use GetList to iterate over the items.
Sub Class_Globals
	Private InternalList As List
End Sub

Public Sub Initialize (InitialItems As List)
	InternalList = B4XCollections.CreateList(InitialItems)
End Sub

Private Sub MakeCopy
	InternalList = B4XCollections.CreateList(InternalList)
End Sub

Public Sub Add (Item As Object)
	MakeCopy
	InternalList.Add(Item)
End Sub

Public Sub RemoveAt (Index As Int)
	MakeCopy
	InternalList.RemoveAt(Index)
End Sub

Public Sub Clear
	Dim InternalList As List
	InternalList.Initialize
End Sub

Public Sub Get (Index As Int) As Boolean
	Return InternalList.Get(Index)
End Sub

Public Sub Set (Index As Int, Item As Object)
	MakeCopy
	InternalList.Set(Index, Item)
End Sub

Public Sub getSize As Int
	Return InternalList.Size
End Sub

Public Sub InsertAt (Index As Int, Item As Object)
	MakeCopy
	InternalList.InsertAt(Index, Item)
End Sub

Public Sub AddAll (Items As List)
	MakeCopy
	InternalList.AddAll(Items)
End Sub

Public Sub AddAllAt (Index As Int, Items As List)
	MakeCopy
	InternalList.AddAllAt(Index, Items)
End Sub

Public Sub IndexOf (Item As Object) As Int
	Return InternalList.IndexOf(Item)
End Sub

Public Sub Sort (Ascending As Boolean)
	MakeCopy
	InternalList.Sort(Ascending)
End Sub

Public Sub SortCaseInsensitive (Ascending As Boolean)
	MakeCopy
	InternalList.SortCaseInsensitive(Ascending)
End Sub

Public Sub SortType (FieldName As String, Ascending As Boolean)
	MakeCopy
	InternalList.SortType(FieldName, Ascending)
End Sub

Public Sub SortTypeCaseInsensitive (FieldName As String, Ascending As Boolean)
	MakeCopy
	InternalList.SortTypeCaseInsensitive(FieldName, Ascending)
End Sub

'Returns the internal list. Modifying the internal list directly will break the expected behavior.
Public Sub GetList As List
	Return InternalList
End Sub

