### Disable automatic redirections with OkHttpUtils2 by Erel
### 06/01/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/118469/)

Step 1: Add to build configuration (Ctrl + B): HU2\_PUBLIC  
Step 2: Add to starter service:  

```B4X
Sub Service_Create  
    Dim jo As JavaObject = HttpUtils2Service.hc  
    Dim builder As JavaObject = jo.RunMethod("sharedInit", Array("hc"))  
    builder.RunMethod("followRedirects", Array(False))  
    builder.RunMethod("followSslRedirects", Array(False))  
    jo.SetField("client", builder.RunMethod("build", Null))  
End Sub
```

  
  
Step 3: Test:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Dim j As HttpJob  
    j.Initialize("", Me)  
    j.Download("https://www.b4x.com/b4a")  
    Wait For (j) JobDone(j As HttpJob)  
    If j.Success Then  
        Log(j.Response.StatusCode)  
    Else If Floor(j.Response.StatusCode / 100) = 3 Then  
        Log("Moved to: " & j.Response.GetHeaders.Get("location"))  
    End If  
    j.Release  
End Sub
```

  
Depends on: JavaObject