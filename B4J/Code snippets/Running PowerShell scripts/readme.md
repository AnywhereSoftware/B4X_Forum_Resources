### Running PowerShell scripts by Erel
### 05/27/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/131116/)

This is really a really cool snippet. It makes it very simple to run Windows 10 PowerShell scripts. It doesn't require special permissions.  
  

```B4X
Public Sub PowerShellScript(s As String) As ResumableSub  
    s = s.Replace(CRLF, ";").Replace("""", "'")  
    Dim shl As Shell  
    shl.InitializeDoNotHandleQuotes("shl", "powershell.exe", Array("-Command", s))  
    shl.Run(-1)  
    Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    Dim res As ShellSyncResult  
    res.ExitCode = ExitCode  
    res.StdErr = StdErr  
    res.StdOut = StdOut  
    res.Success = Success  
    If StdErr <> "" Then  
        Log(StdErr)  
        If ExitCode = 0 Then res.ExitCode = 1  
    End If  
    Return res  
End Sub
```

  
Depends on: jShell  
  
Usage example:  

```B4X
Sub Button1_Click  
    TakeScreenshot(File.Combine(File.DirApp, "1.png"), MainForm.WindowLeft, MainForm.WindowTop, _  
        MainForm.WindowLeft + MainForm.WindowWidth, MainForm.WindowTop + MainForm.WindowHeight)  
End Sub  
  
Public Sub TakeScreenshot (OutputFile As String, Left As Int, Top As Int, Right As Int, Bottom As Int)  
    Dim script As String = $"  
    
    [Reflection.Assembly]::LoadWithPartialName("System.Drawing")  
function screenshot([Drawing.Rectangle]$bounds, $path) {  
   $bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height  
   $graphics = [Drawing.Graphics]::FromImage($bmp)  
  
   $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)  
  
   $bmp.Save($path)  
  
   $graphics.Dispose()  
   $bmp.Dispose()  
}  
  
$bounds = [Drawing.Rectangle]::FromLTRB(${Left}, ${Top}, ${Right}, ${Bottom})  
screenshot $bounds "${OutputFile}"  
    "$  
    Wait For (PowerShellScript(script)) Complete (Result As ShellSyncResult)  
    If Result.ExitCode = 0 Then  
        PowerShellScript(OutputFile) 'show the screenshot  
    End If  
End Sub
```

  
  
Another example - lock the computer:  

```B4X
PowerShellScript($"rundll32.exe user32.dll,LockWorkStation"$)
```