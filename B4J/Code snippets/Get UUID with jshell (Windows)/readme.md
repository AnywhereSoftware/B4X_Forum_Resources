### Get UUID with jshell (Windows) by behnam_tr
### 01/11/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/138224/)

Tested On Windows Only./  
Windows 7 - 8 - 8.1 - 10 - 11  
  

```B4X
Sub RunShellCommand  
  
  
    Private shl As Shell  
    Private params As List  
    params.Initialize  
    params.Add("/c")  
    params.Add("WMIC CSProduct Get UUID")  
    shl.Initialize("shl","cmd.exe",params)  
    shl.WorkingDirectory =  "C:\Windows\system32"  
  
    shl.Run(-1)  
   
    Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success And ExitCode = 0 Then  
        Log("Success")  
'        Log($" ${StdOut} "$)  
  
        Dim st() As String = Regex.Split(CRLF,StdOut)  
        Dim MyUUID As String = st(1)  
        Log(MyUUID)  
  
    Else  
       
        Log("Error: " & StdErr)  
       
    End If  
   
End Sub
```

  
  
also u can check this ::  
<https://www.b4x.com/android/forum/threads/b4j-juuid-get-unique-hardware-id.132277/#post-835016>