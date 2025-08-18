### Detect mobile device by tummosoft
### 06/28/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/141450/)

\* Detect mobile device  
  

```B4X
Sub Handle(req As ServletRequest, resp As ServletResponse)  
    If req.GetHeader("User-Agent").Contains("Mobi") Then  
        Log("Mobile Device")  
        resp.SendRedirect("/mobile")  
    Else  
        Log("Not Mobile")  
        
    End If  
End Sub
```