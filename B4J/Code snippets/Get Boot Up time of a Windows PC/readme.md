### Get Boot Up time of a Windows PC... by Magma
### 06/06/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/141016/)

Well…  
before some days ASK if someone knows a time/data format… explained [here](https://www.b4x.com/android/forum/threads/convert-rfc-3339-not-sure-date-time-to-ticks-and-then-in-any-format-i-want.140915/).  
  
I ve create a small snippet - if someone wants to know what date/time bootup last time your Windows PC…  
  
how to use it:  

```B4X
    Wait for (BootUpTime) complete (bootup As Long)  
    Log(bootup)  
    DateTime.DateFormat="dd/MM/yyyy"  'You can give your Date format here…  
    Log(DateTime.Date(bootup))  
    Log(DateTime.time(bootup))
```

  
  
code need to add:  

```B4X
Sub BootUpTime As ResumableSub  
    'yyyymmddhhmmss.nnn  
    Dim bootticks As Long  
    Dim js As Shell  
    Dim params As List  
    params.Initialize  
  
    params.Add("os")  
    params.Add("get")  
    params.Add("lastbootuptime")  
    params.Add("/format:csv")  
    
    js.Initialize("js", "wmic.exe", params)  
    js.WorkingDirectory=File.DirApp  
    js.Run(-1)  
    Wait for (js) js_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    
    If Success=True Then  
        Log(StdOut)  
        Dim nlines() As String=Regex.Split(Chr(13) & Chr(10),StdOut)  
        Dim cols() As String=Regex.Split(",",nlines(2))  
  
        DateTime.DateFormat="yyyyMMddhhmmss" '.SSS  ?? millisecond… hmm are you sure need them ?  
        
        bootticks=DateTime.DateParse(cols(1).Trim)  
        
    End If  
    
    Return bootticks  
End Sub
```