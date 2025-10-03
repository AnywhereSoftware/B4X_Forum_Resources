### If you're looking to hide the Command Prompt (CMD) window when running a script or program by T201016
### 09/30/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168866/)

If you're looking to hide the Command Prompt (CMD) window when running a script or program,  
there are several approaches depending on your needs.  
  
I wanted to hide the Command Prompt (CMD) window and the FFmpeg.exe program window at the same time.  
Here is my solution that was implemented in Windows 11 version, using a script (*Script\_converting.cmd*) & (*Script\_converting.vbs*):  

```B4X
Dim media  As String = "0000.media" 'input file  
Dim mp4    As String = "0000.mp4"     'output file  
Dim script As String = File.Combine(File.DirApp, "\e-Scripts\Script_converting.vbs")  
  
If Not(File.Exists(File.DirApp, "\e-Scripts\Script_converting.cmd")) Or Not(File.Exists(File.DirApp, "\e-Scripts\Script_converting.vbs")) Then  
    If Not(File.Exists(File.DirApp, "e-Scripts")) Then File.MakeDir(File.DirApp, "e-Scripts")  
    If Not(File.Exists(File.DirApp, "\e-Scripts\Script_converting.cmd")) Then  
        Wait For (File.CopyAsync(File.DirAssets, "Script_converting.cmd", File.DirApp, "\e-Scripts\Script_converting.cmd")) Complete (Success As Boolean)  
    End If  
    If Not(File.Exists(File.DirApp, "\e-Scripts\Script_converting.vbs")) Then  
        Wait For (File.CopyAsync(File.DirAssets, "Script_converting.vbs", File.DirApp, "\e-Scripts\Script_converting.vbs")) Complete (Success As Boolean)  
    End If  
End If  
  
start_cmd(script & " " & File.Combine(File.DirApp, "\e-Scripts") & " 3 " & media & " " & mp4) 'Windows command script (with command interpreter 'cmd.exe')  
  
Private Sub start_cmd(fScript As String)  
    shl.Initialize("shl", "cmd.exe", Array As String("/c", fScript)) '(use a vbscript called ".vbs" only to run the batch file with hidden dos screen)  
    shl.WorkingDirectory = "D:\TMP\SessionData" 'Target file conversion directory  
    shl.RunSynchronous(-1)  
End Sub  
  
Private Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success = True And ExitCode = 0 Then  
        #If Debug  
        Log("SHL Process, Success") 'The Windows command script has completed.  
        #End If  
    End If  
End Sub
```

  
  
Overview of details:  
In the file attached here (*Script\_converting.cmd*):  
1. I used the flag **/B**  
2. I used the parameter **/affinity 3** - this means that it will use CPU0 i CPU1  
3. I used six (threads fffmpeg): **-threads 6**  
4. I used the parameter **-nostats -nostdin** - I missed creating statistics  
  
In the file attached here (*Script\_converting.vbs*):  
1. *WScript.Arguments(0)* - The parameter used determines the directory for the file Script\_converting.cmd  
2. *WScript.Arguments(1)* - The parameter used determines the jump to the label IF "%1"=="**3**" GOTO cnverting\_med (see: *Script\_converting.cmd)*  
3. *WScript.Arguments(2)* - The parameter used determines the directory for the file 0000.media  
4. *WScript.Arguments(3)* - The parameter used determines the directory for the file 0000.mp4  
5. I used the parameter to hide the FFmpeg.exe, window as well "**0**, **False**"  
  
> See file: *Script\_converting.cmd*  
> :cnverting\_med  
> C:\Windows\System32\cmd.exe /c start /low **/B** **/affinity 3** D:\ffmpeg\bin\ffmpeg.exe -i %2 -s 960x540 -c:v libx264 -b:v 1260k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset medium -movflags +faststart -**nostats** -**nostdin** -**threads 6** %3

  
> See file: *Script\_converting.vbs*  
> CreateObject("Wscript.Shell").Run WScript.Arguments(**0**) & "\Script\_converting.cmd " & WScript.Arguments(**1**) & " " & WScript.Arguments(**2**) & " " & WScript.Arguments(**3**), **0**, **False**

  
You can find more information [HERE](https://www.b4x.com/android/forum/threads/starting-the-batch-file-without-calling-the-window.168807/):