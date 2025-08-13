### Log Calling Class and Method by Blueforcer
### 05/15/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/161135/)

I've created a utility function that allows you to automatically log the class and method from which a function was called. I currently need this in our very large project where different classes call the same function. This makes it easier to debug where the call came from.  
Below is the code for the LogCaller function, which uses JavaObject to access the stack trace and determine the calling class and method.  
  
**Note on Stack Trace Position**  
The position 5 in the stack trace (StackTrace(5)) is chosen based on my case. However, if you have a chain of method calls, this position might need to be adjusted. For instance, if there are multiple nested calls, the index might need to be higher or lower to correctly capture the calling method and class.  
You can experiment with the stack trace index to ensure it correctly identifies the calling method. You can do this by logging the entire stack trace and analyzing the positions  
  

```B4X
Sub LogCaller  
    Dim ST As JavaObject  
    ST.InitializeStatic("java.lang.Thread")  
    Dim CurrentThread As JavaObject = ST.RunMethod("currentThread", Null)  
    Dim StackTrace() As Object = CurrentThread.RunMethod("getStackTrace", Null)  
    Dim ClassName As String = StackTrace(5).As(JavaObject).RunMethod("getClassName", Null)  
    Dim MethodName As String = StackTrace(5).As(JavaObject).RunMethod("getMethodName", Null)  
    Log("Called from Class: " & ClassName & ", Method: " & MethodName)  
End Sub
```

  
  
**ClassB.bas**  

```B4X
Sub Class_Globals  
    ' Declare your global variables here.  
End Sub  
  
Public Sub Initialize  
    ' Initialization code here.  
End Sub  
  
Public Sub SomeFunction  
    LogCaller  
    ' Other code for the function.  
End Sub
```

  
  
**ClassA.bas**  

```B4X
Sub Class_Globals  
    ' Declare your global variables here.  
    Private b As ClassB  
End Sub  
  
Public Sub Initialize  
    b.Initialize  
End Sub  
  
Public Sub SomeFunctionInA  
    b.SomeFunction  
End Sub
```

  
  
**Result**  

```B4X
Called from Class: de.dinotec.netplus.ClassA, Method: SomeFunctionInA
```