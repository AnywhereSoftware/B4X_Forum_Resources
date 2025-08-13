###  Get JWT Payload (JavaWebToken) by Alexander Stolte
### 01/19/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/165158/)

This function reads the payload of a jwt token and returns a map  
  
Input token:  

```B4X
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3Mzc4NDc5MjksImlkIjoiNzA4MXNoeDM3YzY3dmUzIiwicmVmcmVzaGFibGUiOnRydWUsInR5cGUiOiJhdXRoIn0.W0ZA6c2_qKhbjjvnUKDJPfO-kU-_prk235_YU8fYBxU
```

  
Payload from this token:  
![](https://www.b4x.com/android/forum/attachments/160926)  
  

```B4X
Public Sub GetJWTPayload(Token As String) As Map  
    Dim su As StringUtils  
    Dim parts() As String = Regex.Split("\.", Token)  
    Dim ResultMap As Map  
    ResultMap.Initialize  
      
    Dim b() As Byte = su.DecodeBase64(IIf(parts(1).Contains("="),parts(1),parts(1) & "="))  
    ResultMap.Put("Payload",BytesToString(b, 0, b.Length, "UTF-8").As(JSON).ToMap)  
      
    Return ResultMap  
End Sub
```