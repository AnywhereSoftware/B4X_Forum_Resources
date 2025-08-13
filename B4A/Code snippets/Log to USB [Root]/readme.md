### Log to USB [Root] by Blueforcer
### 03/13/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159873/)

The `Log2USB` function is designed to facilitate logging within Android applications by writing log entries to a text file (`SystemLog.txt`) located on the first accessible USB drive without Userinput. It requires root access due to its use of the `SuShell` component to execute Unix commands.  
  
- The function scans the `/mnt/media\_rw/` directory to find available USB drives.  
- Upon identifying an available USB drive, it constructs a timestamped log entry using the current date and time.  
- It then appends this log entry, containing the timestamp and the user-provided log text (`LogText`), to a file named `SystemLog.txt` on the root of the first found USB drive.  
- The function utilizes root privileges (`su` command) to ensure it has the necessary permissions to write to the external USB storage, which is typically protected in non-rooted Android environments.  
  

```B4X
Sub Log2USB(LogText As String)  
    Dim su As SuShell  
    Dim process As SuProcess = su.Execute("ls /mnt/media_rw/")  
    process.WaitForCompletion  
    If process.Success Then  
        For i = 0 To process.Response.Length - 1  
            Dim line As String = process.Response(i)  
            If line.Length > 0 Then  
                Dim Timestamp As String = DateTime.Date(DateTime.Now) & " " & DateTime.Time(DateTime.Now)  
                Dim command As String = $"echo "${Timestamp}: ${LogText}" >> /mnt/media_rw/${line}/SystemLog.txt"$  
                su.Execute(command)  
                Exit  
            End If  
        Next  
    End If  
End Sub
```

  
  
This will append "This is a log entry." to the `SystemLog.txt` file on the USB drive, preceded by the current date and time.