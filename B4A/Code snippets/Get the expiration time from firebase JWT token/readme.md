### Get the expiration time from firebase JWT token by Erel
### 02/14/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/146137/)

```B4X
Private Sub GetExpiryTime(JWTToken As String) As Long  
    Dim parts() As String = Regex.Split("\.", JWTToken)  
    Dim b() As Byte = UrlSafeDecodeBase64(parts(1))  
    Dim s As String = BytesToString(b, 0, b.Length, "utf8")  
    Dim map As Map = s.As(JSON).ToMap  
    Log(map.As(JSON).ToString)  
    If map.ContainsKey("exp") Then  
        Dim expire As Long = map.Get("exp") * 1000  
        Return expire  
    End If  
    Return 0  
End Sub  
  
Private Sub UrlSafeDecodeBase64 (s As String) As Byte()  
    Dim jo As JavaObject  
    jo.InitializeStatic("android.util.Base64")  
    Return jo.RunMethod("decode", Array(s, Bit.Or(8, Bit.Or(2, 1)))) 'URL_SAFE  
End Sub
```