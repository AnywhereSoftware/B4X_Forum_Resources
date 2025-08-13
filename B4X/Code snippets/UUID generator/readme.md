###  UUID generator by TILogistic
### 09/21/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/163203/)

With this UUID generator you will not have problems with duplicates, in Java 11 or higher it generates version 4.  
  

```B4X
Public Sub UUID As String  
#If B4i  
   Dim no As NativeObject  
   Return no.Initialize("NSUUID").RunMethod("UUID", Null).RunMethod("UUIDString", Null).AsString  
#Else  
    Dim jo As JavaObject  
    Return jo.InitializeStatic("java.util.UUID").RunMethod("randomUUID", Null)  
#End If  
End Sub
```

  
  
ref.  
<https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/UUID.html#version()>  
<https://developer.apple.com/documentation/foundation/nsuuid>