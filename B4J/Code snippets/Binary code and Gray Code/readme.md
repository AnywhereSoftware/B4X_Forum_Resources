### Binary code and Gray Code by Num3
### 03/25/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/139395/)

Didn't find any [Gray Code](https://en.wikipedia.org/wiki/Gray_code) encoding on the forums, so I leave these two procedures for everyone to use:  
  

```B4X
Public Sub Number2GrayCode(a As Int) As String  
    Dim b As Int = Bit.Xor(Bit.Shiftright(a,1),a)  
    Return Bit.ToBinaryString(b)  
End Sub  
  
Public Sub Number2BinaryCode(a As Int) As String  
    Return Bit.ToBinaryString(a)  
End Sub
```