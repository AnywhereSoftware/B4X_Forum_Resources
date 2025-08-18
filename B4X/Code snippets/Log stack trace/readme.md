###  Log stack trace by Erel
### 04/01/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/129299/)

This sub will log the underlying stack trace. It can be useful for debugging cases where the code flow is complex.  
In debug mode the underlying stack trace can be incomplete.  
  

```B4X
Sub Log_StackTrace  
    Dim lines As List  
    #if B4A or B4J  
    Dim jo As JavaObject  
    lines.Initialize  
    Dim stack() As Object = jo.InitializeStatic("java.lang.Thread").RunMethodJO("currentThread", Null).RunMethod("getStackTrace", Null)  
    For Each st As JavaObject In stack  
        lines.Add(st.RunMethod("getClassName", Null) & ": " & st.RunMethod("getMethodName", Null))  
    Next  
    #else if B4i  
    Dim no As NativeObject  
    Dim stack As List = no.Initialize("NSThread").RunMethod("callStackSymbols", Null)  
    lines = stack  
    #end if  
    Log("****************")  
    Dim found As Boolean  
    For Each line As String In lines  
        If found Then  
            Log(line)  
        Else If line.Contains("log_stacktrace") Then  
            found = True  
        End If  
    Next  
End Sub
```