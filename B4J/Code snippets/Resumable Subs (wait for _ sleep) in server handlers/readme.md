### Resumable Subs (wait for / sleep) in server handlers by Erel
### 02/16/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/81833/)

Resumable subs can only work when there is a message queue.  
  
By default, server handlers end when the Handle sub is completed. They do not create a message loop.  
If you want to wait for an event then you need to call StartMessageLoop and later StopMessageLoop.  
  
Example of handler that downloads a page and returns it as the response:  

```B4X
Sub Handle(req As ServletRequest, resp As ServletResponse)  
   Download(resp)  
   StartMessageLoop '<—  
End Sub  
  
Sub Download (resp As ServletResponse)  
   Dim j As HttpJob  
   j.Initialize("", Me)  
   j.Download("https://www.example.com")  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
     resp.Write(j.GetString)  
   End If  
   j.Release  
   StopMessageLoop '<—-  
End Sub
```

  
  
The Handle sub cannot be a resumable sub itself.  
  
Why?  
  
- Wait For / Sleep must be called before the call to StartMessageLoop or they will never be executed.  
- Wait For / Sleep code flow is equivalent to Return so if they appear before StartMessageLoop then the message loop will never be created and the handler will complete before the event is raised.  
  
WebSocket handlers do have a message loop so nothing special should be done there.  
  
Tip: Use the correct library.  
OkHttpUtils2\_NonUI for server apps and OkHttpUtils2 for UI apps.  
Above tip is no longer correct. As OkHttpUtils2 is a b4xlib, you should always use OkHttpUtils2.