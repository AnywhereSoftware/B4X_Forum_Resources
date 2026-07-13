### Start automatically your B4J Server Main Web Page on WebApp Start in Windows by hatzisn
### 07/04/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171454/)

It needs jShell library. You must call the sub immediately after srvr.Start and before StartMessageLoop.  
  

```B4X
Private Sub WindowsStartPage  
    Select Case GetSystemProperty("os.name", "").ToLowerCase.Contains("win")  
        
        Case True  
            Dim sh As Shell  
            Dim shresult As ShellSyncResult  
            sh.Initialize("sh", "cmd", Array As String("/c", "start", "http://localhost:51042"))  
            shresult = sh.RunSynchronous(1500)  
            Log(shresult.StdOut)  
        Case False  
            
    End Select  
    
    
End Sub
```