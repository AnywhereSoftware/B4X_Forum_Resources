###  Exception To String, with Stack Trace by Erel
### 07/20/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/167847/)

Compatible with B4A, B4i and B4J  
Returns a string similar to the error message that is logged when an exception happens.  
You can show it for debug purposes or handle in other ways.  
  

```B4X
Public Sub ExceptionToString(Exception As Object) As String  
    #if b4i  
    Dim sb As StringBuilder  
    sb.Initialize  
    sb.Append(Exception)  
    Dim symbols As NativeObject  
    If GetType(Exception) = "NSError" Then  
        Dim Thread As NativeObject  
        symbols = Thread.Initialize("NSThread").RunMethod("callStackSymbols", Null)  
    Else If GetType(Exception) = "NSException" Then  
        symbols = Exception.As(NativeObject).RunMethod("callStackSymbols", Null)  
    End If  
    If symbols.IsInitialized Then  
        For Each symbol In symbols.As(List)  
            sb.Append(CRLF).Append(symbol)  
        Next  
    End If  
    Return sb.ToString  
    #else if B4A or B4J  
    Dim StringWriter As JavaObject  
    StringWriter.InitializeNewInstance("java.io.StringWriter", Null)  
    Dim PrintWriter As JavaObject  
    PrintWriter.InitializeNewInstance("java.io.PrintWriter", Array(StringWriter))  
    Exception.As(JavaObject).RunMethod("printStackTrace", Array(PrintWriter))  
    Return StringWriter.RunMethod("toString", Null)  
    #End If  
End Sub
```

  
  
Usage:  

```B4X
Try  
    Dim a(0) As Int  
    a(10) = 34  
Catch  
    xui.MsgboxAsync(ExceptionToString(LastException), "")  
    Log(LastException)  
End Try
```