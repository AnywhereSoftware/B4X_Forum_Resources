### [B4x] B4xBitSet_Utils Serialize a B4xBitSet by stevel05
### 04/30/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/147677/)

I had a need to save the state of a B4xBitSet so I thought I should serializable its data. The easiest method and compatible with B4xSerializator, was to create a list of Int values representing the bits.  
I considered using a byte array but without adding complexity, that would mean that the BitSet size would be limited to 255. Not that I could really imagine working with that many bits, but it would be an arbitrary limit.  
  
There is probably a simpler way to do this. If there is, please let me know.  
  

```B4X
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
```

  
  
I have tested as much as I can but I attach a test project if you would like to help test this. and a B4xLib.  
  
Please do test it thoroughly before using in anger.