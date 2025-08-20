B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Private map As Map
	Private list As List
End Sub

Public Sub Initialize
	map.Initialize
	list.Initialize
End Sub

'Puts a key / value pair to the map. If the key already exists the new value replaces the previous one (and the order doesn't change).
Public Sub Put (Key As Object, Value As Object)
	If map.ContainsKey(Key) = False Then
		list.Add(Key)
	End If
	map.Put(Key, Value)
End Sub

'Removes a pair from the map. This is an O(n) operation.
Public Sub Remove (Key As Object)
	If map.ContainsKey(Key) = False Then Return
	list.RemoveAt(list.IndexOf(Key))
	map.Remove(Key)
End Sub
'Clears the map.
Public Sub Clear
	list.Clear
	map.Clear
End Sub

'Returns the keys as a list. You can sort this list to change the order.
Public Sub getKeys As List
	Return list
End Sub

'Gets the value mapped to the key.
Public Sub Get (Key As Object) As Object
	Return map.Get(Key)
End Sub

'Gets the value mapped to the key. Returns the passed DefaultValue is no such key exists.
Public Sub GetDefault (Key As Object, DefaultValue As Object) As Object
	Return map.GetDefault(Key, DefaultValue)
End Sub
'Tests whether the map contains the key.
Public Sub ContainsKey (Key As Object) As Boolean
	Return map.ContainsKey(Key)
End Sub
'Returns the map size.
Public Sub getSize As Int
	Return map.Size
End Sub

'Returns a (copied) list of the collection values.
Public Sub getValues As List
	Dim res As List
	res.Initialize
	For Each key As Object In list
		res.Add(map.Get(key))
	Next
	Return res
End Sub

'Returns an object that can be serialized with B4XSerializator.
Public Sub GetDataForSerializator As Object
	Return Array(map, list)
End Sub

'Sets the map data from a deserialized object.
Public Sub SetDataFromSerializator (Data As Object)
	Dim o() As Object = Data
	map = o(0)
	list = o(1)
End Sub