###  HexToColor and ColorToHex by Erel
### 02/24/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/114300/)

Converts hex color strings to a color int value and vice versa:  

```B4X
Private Sub ColorToHex(clr As Int) As String  
    Dim bc As ByteConverter  
    Return bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))  
End Sub  
  
Private Sub HexToColor(Hex As String) As Int  
    Dim bc As ByteConverter  
    If Hex.StartsWith("#") Then   
        Hex = Hex.SubString(1)  
    Else If Hex.StartsWith("0x") Then   
        Hex = Hex.SubString(2)  
    End If  
    Dim ints() As Int = bc.IntsFromBytes(bc.HexToBytes(Hex))  
    Return ints(0)  
End Sub
```

  
  
Depends on: B4A / B4J - ByteConverter, B4i - iRandomAccessFile