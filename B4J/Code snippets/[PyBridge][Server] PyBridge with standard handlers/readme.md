### [PyBridge][Server] PyBridge with standard handlers by Erel
### 07/20/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171598/)

The previous tutorial: <https://www.b4x.com/android/forum/threads/pybridge-server-using-pybridge-in-web-apps.166154/#content> explains how to use PyBridge within a server solution. The tutorial is based on WebSocket handlers. Calling PyBridge from standard handlers is quite similar, but requires starting and stopping a message loop.  
  
The important code is:  

```B4X
Sub Handle(req As ServletRequest, resp As ServletResponse)  
    Dim code As String = req.GetParameter("code")  
    SendAndWait(code, resp) 'must be a separate sub  
    StartMessageLoop  
End Sub  
  
Private Sub SendAndWait (code As String, resp As ServletResponse)  
    CallSubDelayed3(Main.PyWorker, "Run_Eval", Me, code)  
    Wait For Run_Eval (Result As PyWrapper)  
    resp.ContentType = "text/html"  
    resp.Write("Code: " & code)  
    resp.Write("<br/>")  
    If Result.IsSuccess Then  
        resp.Write("Success: " & Result.Value)  
    Else  
        resp.Write("Error: " & Result.ErrorMessage)  
    End If  
    StopMessageLoop  
End Sub
```

  
  
The handler expects a "code" parameter that is evaluated and the result is returned. Never evaluate user input in non-trusted environments (internet for example) as it will lead to execution of malicious code on the server.