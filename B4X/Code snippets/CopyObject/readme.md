###  CopyObject by LucaMs
### 04/03/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/147214/)

Author: **Erel**  
  

```B4X
Sub CopyObject(SourceObject As Object) As Object  
   Dim s As B4XSerializator  
   Return s.ConvertBytesToObject(s.ConvertObjectToBytes(SourceObject))  
End Sub
```

  
  
Note that not all types are supported. Supported types are: primitives, strings, lists, maps, arrays of objects or bytes, custom types and any combination of those (a map that holds arrays of custom types).  
  
<https://www.b4x.com/android/forum/threads/copying-an-object-not-just-a-reference.12816/post-412984>