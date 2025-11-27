###  Restart App by T201016
### 11/24/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169426/)

hello everyone,  
Here is a slightly improved code that allows you to restart the application at any time:  
  
[code source by @byz](https://www.b4x.com/android/forum/threads/the-b4j-ui-program-restarts-itself.164128/):  
  

```B4X
#Region Project Attributes  
    #MainFormWidth:  600  
    #MainFormHeight: 880  
    #PackagerProperty: ExeName = Your.exe  
'    #IgnoreWarnings:  
#End Region
```

  
  

```B4X
Private Sub Button1_Click  
    RestartSelf("Your.exe")  
End Sub  
  
Private Sub RestartSelf(exeName As String)  
    Try  
'       shl.Initialize("shl", "java.exe", Array As String("-jar", exeName))  'Your.jar  
        shl.Initialize("shl", "cmd.exe", Array As String("/c", exeName))     'Your.exe  
        shl.WorkingDirectory = File.DirApp  
        shl.Run(-1)  
    Catch  
        Log(LastException.Message)  
    End Try  
    Sleep(0)  
    ExitApplication  
End Sub
```