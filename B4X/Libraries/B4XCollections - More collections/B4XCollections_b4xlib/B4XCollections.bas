B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7
@EndOfDesignText@

Sub Process_Globals
	Private mEmptyMap As Map
	Private mEmptyList As List
End Sub

'Creates a new empty set.
'A set is similar to an ordered map without the values, only the keys.
'It is useful when you need to collect unique items.
Public Sub CreateSet As B4XSet
	Return CreateSet2(Null)
End Sub

'Creates a new set and adds the passed values. 
'A set is similar to an ordered map without the values, only the keys.
'It is useful when you need to collect unique items.
Public Sub CreateSet2 (Values As List) As B4XSet
	Dim s As B4XSet
	s.Initialize
	If Values <> Null And Values.IsInitialized Then
		For Each v As Object In Values
			s.Add(v)
		Next
	End If
	Return s
End Sub

'Creates an empty OrderedMap.
'OrderedMap is similar to the regular Map. However the items order is preserved (this is not the case with B4i regular maps).
'You can also sort the map keys with OrderedMap.Keys.Sort(...).
Public Sub CreateOrderedMap As B4XOrderedMap
	Return CreateOrderedMap2(Null, Null)
End Sub


'Creates an OrderedMap.
'OrderedMap is similar to the regular Map. However the items order is preserved (this is not the case with B4i regular maps).
'You can also sort the map keys with OrderedMap.Keys.Sort(...).
Public Sub CreateOrderedMap2 (Keys As List, Values As List) As B4XOrderedMap
	Dim m As B4XOrderedMap
	m.Initialize
	If Keys <> Null And Values <> Null And Keys.IsInitialized And Values.IsInitialized Then
		For i = 0 To Keys.Size - 1
			m.Put(Keys.Get(i), Values.Get(i))
		Next
	End If
	Return m
End Sub

'Creates a bit set with the passed size.
'A BitSet is an efficient collection of bits. Each bit can be True or False.
'It is similar to an array of booleans (just faster and requires less memory).
Public Sub CreateBitSet (Size As Int) As B4XBitSet
	Dim s As B4XBitSet
	s.Initialize(Size)
	Return s
End Sub

'Returns an empty map. Do not modify the map as it will affect other instances.
Public Sub GetEmptyMap As Map
	If mEmptyMap.IsInitialized = False Or mEmptyMap.Size > 0 Then
		Dim mEmptyMap As Map
		mEmptyMap.Initialize
	End If
	Return mEmptyMap
End Sub

'Returns an empty list. Do not modify the list as it will affect other instances.
Public Sub GetEmptyList As List
	If mEmptyList.IsInitialized = False Or mEmptyList.Size > 0 Then
		Dim mEmptyList As List
		mEmptyList.Initialize
	End If
	Return mEmptyList
End Sub

'Returns a new merged map. Maps are added in order. Non-initialized maps are skipped.
Public Sub MergeMaps (Map1 As Map, Map2 As Map) As Map
	Dim res As Map
	res.Initialize
	If Initialized(Map1) Then
		For Each key As Object In Map1.Keys
			res.Put(key, Map1.Get(key))
		Next
	End If
	If Initialized(Map2) Then
		For Each key As Object In Map2.Keys
			res.Put(key, Map2.Get(key))
		Next
	End If
	Return res
End Sub

'Returns a new list with the items from all given lists, added in order. Non-initialized lists are skipped.
Public Sub MergeLists (List1 As List, List2 As List) As List
	Dim res As List
	res.Initialize
	If Initialized(List1) Then res.AddAll(List1)
	If Initialized(List2) Then res.AddAll(List2)
	Return res
End Sub

'Returns a new modifiable list. Items parameter can be null.
Public Sub CreateList (Items As List) As List
	Dim res As List
	res.Initialize
	If Initialized(Items) Then res.AddAll(Items)
	Return res
End Sub

'Randomly shuffles a list. This method will also work with arrays of object, but not arrays of other types.
Public Sub ShuffleList (Items As List)
	Dim n As Int = Items.Size
	For i = 0 To n - 2
		Dim j As Int = Rnd(i, n)
		Dim o As Object = Items.Get(i)
		Items.Set(i, Items.Get(j))
		Items.Set(j, o)
	Next
End Sub

'Returns a new list with the items starting with StartIndex (inclusive) to EndIndex (exclusive).
Public Sub SubList (Items As List, StartIndex As Int, EndIndex As Int) As List
	Dim res As List
	res.Initialize
	For i = StartIndex To EndIndex - 1
		res.Add(Items.Get(i))
	Next
	Return res
End Sub

