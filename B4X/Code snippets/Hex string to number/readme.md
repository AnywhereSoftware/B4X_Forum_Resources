###  Hex string to number by Erel
### 09/25/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/122739/)

Bit.ParseInt will fail if the hex string is larger than the maximum positive int.  
  
We can instead use the ByteConverter library to do it (B4A, B4J: <https://www.b4x.com/android/forum/threads/6787/#content>, it is an internal library named iRandomAccessFile in B4i)  

```B4X
Sub AppStart (Args() As String)  
    Dim i As Int = 0xFB461E4D  
    Log(i)  
    Log(StringToInt("FB461E4D"))  
    'unsigned value:  
    Log(StringToUnsignedInt("FB461E4D"))  
End Sub  
  
Sub StringToInt(Str As String) As Int  
    Dim converter As ByteConverter  
    Dim ii() As Int = converter.IntsFromBytes(converter.HexToBytes(Str))  
    Return ii(0)  
End Sub  
  
Sub StringToUnsignedInt (Str As String) As Long  
    Dim converter As ByteConverter  
    Dim a(8) As Byte  
    Dim i() As Byte = converter.HexToBytes(Str)  
    Bit.ArrayCopy(i, 0, a, 4, 4)  
    Dim ll() As Long = converter.LongsFromBytes(a)  
    Return ll(0)  
End Sub
```