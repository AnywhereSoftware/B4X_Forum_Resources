B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7
@EndOfDesignText@

Sub Process_Globals
	
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