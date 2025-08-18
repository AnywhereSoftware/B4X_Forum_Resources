### [server] list all request headers in a handler class by Erel
### 10/04/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123079/)

```B4X
Dim jo As JavaObject = req  
Dim collections As JavaObject  
collections.InitializeStatic("java.util.Collections")  
Dim headers As List = collections.RunMethod("list", Array(jo.RunMethodJO("getHeaderNames", Null)))  
For Each h As String In headers  
    Log(h & ": " & req.GetHeader(h))  
Next
```