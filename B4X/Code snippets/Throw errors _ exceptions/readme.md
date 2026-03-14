###  Throw errors / exceptions by Erel
### 03/08/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/170538/)

Cross platform code to raise exceptions. Mostly Useful for libraries development.  

```B4X
Private Sub ThrowError(Message As String)  
    LogColor("Error: " & Message, 0xffff0000)  
    #if B4A or B4J  
    Me.As(JavaObject).RunMethod("raiseException", Array(Message))  
    #else  
    Dim no As NativeObject  
    no.Initialize("NSException").RunMethod("raise:format:", Array("", Message))  
    #end if  
End Sub  
  
#if Java  
public static void raiseException(String message) {  
    throw new java.lang.RuntimeException(message);  
}  
#end if
```