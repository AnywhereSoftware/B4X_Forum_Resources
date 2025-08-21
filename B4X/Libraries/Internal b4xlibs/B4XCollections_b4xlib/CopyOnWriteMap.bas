B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Wraps an internal map. A new internal map is created whenever the map is modified.
'GetMap returns the internal and unmodifiable map. Modifying the map returned will break the expected behavior.
'Note that the class instances are not maps by themselves. Pass GetMap to methods that expect maps.
'Use GetMap to iterate over the items:
'<code>Dim m As Map = CopyOnWriteMap1.GetMap
'For Each k As Object In m.Keys
'	Dim v As Object = m.Get(k)
'Next</code>
Sub Class_Globals
	Private InternalMap As Map	
End Sub

'Creates a new CopyOnWriteMap with the initial items (can be Null).
Public Sub Initialize (InitialItems As Map)
	InternalMap = B4XCollections.MergeMaps(InitialItems, Null)
End Sub

Private Sub CopyMap
	InternalMap = B4XCollections.MergeMaps(InternalMap, Null)
End Sub

Public Sub Get (Key As Object) As Object
	Return InternalMap.Get(Key)
End Sub

Public Sub GetDefault (Key As Object, Default As Object) As Object
	Return InternalMap.GetDefault(Key, Default)
End Sub

Public Sub Put (Key As Object, Value As Object)
	CopyMap
	InternalMap.Put(Key, Value)
End Sub

Public Sub Remove (Key As Object)
	CopyMap
	InternalMap.Remove(Key)
End Sub

Public Sub Clear
	Dim InternalMap As Map
	InternalMap.Initialize
End Sub

Public Sub getSize As Int
	Return InternalMap.Size
End Sub

Public Sub ContainsKey (Key As Object) As Boolean
	Return InternalMap.ContainsKey(Key)
End Sub

'Returns the internal map. Modifying the internal map will break the expected behavior.
Public Sub GetMap As Map
	Return InternalMap
End Sub