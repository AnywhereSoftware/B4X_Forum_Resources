### [B4x] Padding data (e.g. building blocks of a multiple of 16) by KMatle
### 04/28/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130230/)

For some solutions you need to pad data to a specific length (=blocksize or a multiple of x, like a multiple of 16 in AES). This snippet gets the next higher multiple of the padding. If your data is 5 bytes long, the blocksize would be 16, having 17 bytes it would be 32.  
  

```B4X
Dim PadTo As Int = 16 'Pad to lenght of xxx  
    Dim PaddedLength As Int  
    For i=1 To 256  
        If i Mod PadTo >0 Then 'don't pad if length = padding e.g. 16 mod 16 = 0, a length of 0 isn't relevant here = no data  
           PaddedLength = i-i Mod PadTo + PadTo  
        End If  
        Log("Original length: " & i & ", padded: " & PaddedLength)  
    Next
```