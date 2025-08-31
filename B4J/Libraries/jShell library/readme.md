### jShell library by Erel
### 08/27/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/34661/)

The jShell library allows you to start other programs. It is based on Apache Commons Exec project: <http://commons.apache.org/proper/commons-exec/index.html>  
  
The programs are always started asynchronously. ProcessComplete event is raised when the process completes.  
  
The following code will run the Java program we [previously created](https://www.b4x.com/android/forum/threads/non-ui-applications.34657/):  
  

```B4X
Sub AppStart (Args() As String)  
   Dim shl As Shell  
   shl.Initialize("shl", "java", _  
     Array As String("-cp", "curl.jar", "b4j.example.main", "http://www.b4x.com"))  
   shl.WorkingDirectory = "C:\Users\H\Documents\B4J\Curl\Objects"  
   shl.Run(10000) 'set a timeout of 10 seconds  
   StartMessageLoop 'need to call this as this is a console app.  
End Sub  
  
  
Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
   If Success AND ExitCode = 0 Then  
     Log("Success")  
     Log(StdOut)  
   Else  
     Log("Error: " & StdErr)  
   End If  
   ExitApplication  
End Sub
```

  
The Shell library can be used in a UI app in the same way.