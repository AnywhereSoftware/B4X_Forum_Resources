### ServletRequest all Header and Parameters (httpServer) by Star-Dust
### 01/14/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/126535/)

I arose from the need to know all the headers of a GET request.  
  
When HttServer raises the HttpServer\_HandleRequest event it returns the Request variable.  
  
The Request variable has only one method for reading Headers, GetHeader.  
How to get a complete list of Headers?  
  

```B4X
    HttpServer1.Initialize("HttpServer")  
    HttpServer1.Start(1080)
```

  
  

```B4X
Private Sub HttpServer_HandleRequest (Request As ServletRequest, Response As ServletResponse)  
    If Request.Method = "GET" Then  
        Dim ServletRequestWrapper As Reflector  
        ServletRequestWrapper.Target=Request  
        
        Dim req As JavaObject = ServletRequestWrapper.GetField("req")  
        Dim headerNames As JavaObject = req.RunMethod("getHeaderNames",Null)  
  
         ' List of Header  
        Do While headerNames.RunMethod("hasMoreElements",Null)  
            Log(headerNames.RunMethod("nextElement",Null)) ' Header  
        Loop  
    End If  
  
End Sub
```

  
  
**NB** Requires JavaObject and Reflector library