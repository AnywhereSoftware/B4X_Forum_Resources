### Run B4J console app by Erel
### 08/18/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168233/)

Depends on jShell. Tested on Windows. Expected to work on Mac and Linux as well.  
This code will not work when called from a standalone package. More powerful implementation is available here: <https://www.b4x.com/android/forum/threads/jarcaller-run-and-kill-non-ui-jars.168284/>  
  

```B4X
'Jar - Path to the compiled jar file. Should be a non-ui / console app.  
'Args - Optional string arguments.  
Private Sub RunJar(Jar As String, Args As List)  
    Dim shl As Shell  
    Dim javaExe As String = File.Combine(GetSystemProperty("java.home", ""), "bin/java")  
    Dim NewArgs As List  
    NewArgs.Initialize  
    NewArgs.Add("-jar")  
    NewArgs.Add(Jar)  
    If Initialized(Args) Then NewArgs.AddAll(Args)  
    shl.Initialize("shl", javaExe, NewArgs)  
    shl.WorkingDirectory = File.GetFileParent(Jar)  
    shl.Run(-1)  
    Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    Log(StdOut)  
    Log(StdErr)  
End Sub
```

  
  
Usage example:  

```B4X
RunJar("C:\Users\H\Downloads\projects\ccc\Objects\ccc.jar", Array("aaa", "bbb", "ccc"))
```