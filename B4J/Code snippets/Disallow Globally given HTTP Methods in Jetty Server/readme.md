### Disallow Globally given HTTP Methods in Jetty Server by hatzisn
### 07/10/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171514/)

In order to allow only GET, POST, HEAD methods in your jetty server add the following filter:  
  

```B4X
'Filter class  
Sub Class_Globals  
  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
Public Sub Filter(req As ServletRequest, resp As ServletResponse) As Boolean  
    Dim method As String = req.Method.ToUpperCase  
  
    If method = "OPTIONS" Or method = "TRACE" Or method = "PATCH" Or method = "DELETE" Or method = "PUT" Then  
        resp.SetHeader("Allow", "GET, POST, HEAD")  
        WriteError(resp, 405, "METHOD_NOT_ALLOWED", "This method is not allowed")  
        Return False  
    End If  
  
    Return True  
End Sub  
  
  
Private Sub WriteError(resp As ServletResponse, Status As Int, Code As String, Message As String)  
    'Standard error envelope returned by this handler.  
    WriteJson(resp, Status, CreateMap("success": False, "error": Code, "message": Message))  
End Sub  
  
Private Sub WriteJson(resp As ServletResponse, Status As Int, Value As Map)  
    'Single JSON serializer path keeps response formatting predictable.  
    Dim generator As JSONGenerator  
    generator.Initialize(Value)  
    resp.Status = Status  
    resp.SetHeader("Server", "—")  
    resp.ContentType = "application/json"  
    resp.Write(generator.ToString)  
End Sub
```

  
  
Then you add this in Main  
  

```B4X
srvr.AddFilter("/*", "BlockHttpMethods", False)
```