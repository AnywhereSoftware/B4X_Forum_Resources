B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

'Return a List of Ints in which the first element contains the B4xBitSet size
'The remaining elements contain the B4xBitSet converted to Ints
Public Sub Serialize(BitSet As B4XBitSet) As List
	Dim IntSize As Int = 32
	Dim Values As List
	Values.Initialize
	Values.Add(BitSet.Size)
	For i = 0 To Ceil(BitSet.Size / IntSize) -1
		Values.Add(0)
	Next
	
	Dim Index As Int = 1
	For i = 0 To BitSet.Size - 1
		If BitSet.Get(i) Then
			Dim Shift As Int =  i Mod IntSize
			Values.Set(Index,Bit.Or(Values.Get(Index),Bit.ShiftLeft(1,Shift)))
		End If
		If i <> 0 And i Mod IntSize = IntSize - 1 Then Index = Index + 1
	Next
	Return Values
End Sub

'Recreate a B4xBitSet from a serialized List.  The first element containing the B4xBitSet size.
Public Sub Deserialize(Serialized As List) As B4XBitSet
	Dim BitSet As B4XBitSet
	BitSet.Initialize(Serialized.Get(0))
	Dim IntSize As Int = 32
	
	For i = 1 To Serialized.Size - 1
		For j = 0 To IntSize - 1
			Dim BitPos As Int = (i - 1) * IntSize + j
			If BitPos = BitSet.Size Then Exit
			If Bit.And(Bit.ShiftRight(Serialized.Get(i),j),1) = 1 Then
				BitSet.Set(BitPos,True)
			End If
		Next
	Next
		
	Return BitSet
End Sub

Public Sub GetValues(Bitset As B4XBitSet) As Int()
	Dim Ser As List = Serialize(Bitset)
	Dim Result(Ser.size - 1) As Int
	For i = 1 To Ser.Size - 1
		Result(i - 1) = Ser.Get(i)
	Next
	Return Result
End Sub
