### Generate UUID in B4J by jln2X1234%
### 09/07/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/162962/)

I know this is very late. But I'd like to share my working code to generate UUID in B4J. As a requirement, must select from the Library: JavaObject.  

```B4X
Sub GenerateUUID() As String  
    Dim jObj As JavaObject  
    jObj.InitializeStatic("java.util.UUID")  
    Dim uuid As String = jObj.RunMethod("randomUUID", Null)  
    Return uuid  
End Sub
```