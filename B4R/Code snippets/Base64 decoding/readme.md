### Base64 decoding by Erel
### 09/08/2019
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/109385/)

```B4X
Sub Process_Globals  
   Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
   Serial1.Initialize(115200)  
   Log("AppStart")  
   Dim Result(100) As Byte  
   Dim length As UInt = DecodeBase64(Result, "RGVjb2RpbmcgQmFzZTY0IHN0cmluZyB3aXRoIEI0UiEhIQ==")  
   Dim bc As ByteConverter 'rRandomAccessFile library  
   Log(bc.SubString2(Result, 0, length))  
End Sub  
  
'Returns the length of the decoded data  
Sub DecodeBase64(Result() As Byte, Text() As Byte) As UInt  
   Dim rawlength As Int  
   For i = 0 To Text.Length - 1  
       Dim u As Byte = Text(i)  
       If u >= 43 And u <> 61 Then rawlength = rawlength + 1  
   Next  
   Dim length As Int = Min(Result.Length, rawlength * 3 / 4)  
   Dim si = -1, ri = 0 As Int  
   Do While ri < length  
       Dim four(4) As Byte  
       For i = 0 To 3  
           si = si + 1  
           Do While Text(si) < 43  
               si = si + 1  
           Loop  
           four(i) = GetBase64Index(Text(si))  
       Next  
       Result(ri) = Bit.ShiftLeft(four(0), 2) + Bit.ShiftRight(four(1), 4)  
       If ri + 1 = length Then Exit  
       Result(ri + 1) = Bit.ShiftLeft(four(1), 4) + Bit.ShiftRight(four(2), 2)  
       If ri + 2 = length Then Exit  
       Result(ri + 2) = Bit.ShiftLeft(four(2), 6) + Bit.ShiftRight(four(3), 0)  
       ri = ri + 3  
   Loop  
   Return length  
End Sub  
  
Sub GetBase64Index(u As Int) As Int  
   If u = 43 Then Return 63  
   If u = 47 Then Return 63  
   If u = 61 Then Return 0  
   If u <= 57 Then Return u - 48 + 52  
   If u <= 90 Then Return u - 65  
   If u <= 122 Then Return u - 97 + 26  
   Log("Error: ", u)  
   Return 0  
End Sub
```

  
  
As demonstrated above the result is stored in the Result array and the length is returned.