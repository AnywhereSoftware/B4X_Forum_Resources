###  Convert Base64 To String, String To Base64 and Validate Is Base64 by Lucas Siqueira
### 03/21/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/166253/)

```B4X
Sub isBase64(text As String) As Boolean  
    If Regex.IsMatch("^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$", text) And text.Length > 3  Then  
        Return True  
    Else  
        Return False  
    End If  
End Sub  
  
Sub convertStringToBase64(text As String) As String  
    Private su As StringUtils  
    Private b() As Byte = text.GetBytes("UTF8")  
    Return su.EncodeBase64(b)  
End Sub  
  
Sub convertBase64ToString(text As String) As String  
    Private su As StringUtils  
    Dim b() As Byte = su.DecodeBase64(text)  
    Return BytesToString(b, 0, b.Length, "UTF8")  
End Sub
```

  
  
Credits: [USER=49674]@Douglas Farias[/USER] (code isBase64)  
  
  
remember: Convert bitmap to base64 use [Base64EncodeDecodeImage](https://www.b4x.com/android/forum/threads/b4x-library-base64-encode-decode-image-and-file-library.115033/post-998317) from [USER=63206]@MarcoRome[/USER]