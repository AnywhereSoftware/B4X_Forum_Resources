### ABBackgroundWorkers (extracted from jServer) by alwaysbusy
### 09/06/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/134061/)

This library is just an extraction of the Background Worker functionality in the jServer library. I needed this functionality but did not want to include the whole Jetty part. Could be useful for someone.  
  
Lib source code Github: <https://github.com/RealAlwaysbusy/ABBackgroundWorkers>  
  
Usage:  
  
Main  

```B4X
Sub Process_Globals  
    Dim bgw As ABBackgroundWorkers  
     
End Sub  
  
Sub AppStart (Args() As String)  
    bgw.Initialize  
     
    bgw.AddBackgroundWorker("Worker1")  
    bgw.AddBackgroundWorker("Worker2")  
     
    bgw.Start  
     
    StartMessageLoop  
End Sub
```

  
  
Worker1  

```B4X
Sub Class_Globals  
    Private Timer As Timer  
    Private TimerTickMs As Int = 10000  
End Sub  
  
Public Sub Initialize  
    Timer.Initialize("Timer", TimerTickMs)  
    Timer.Enabled = True  
     
    StartMessageLoop '<- don't forget!  
End Sub  
  
Sub Timer_Tick  
    'do the work required  
    Log("Worker 1: every " & TimerTickMs)  
End Sub
```

  
  
Worker2  

```B4X
Sub Class_Globals  
    Private Timer As Timer  
    Private TimerTickMs As Int = 5000  
End Sub  
  
Public Sub Initialize  
    Timer.Initialize("Timer", TimerTickMs)  
    Timer.Enabled = True  
     
    StartMessageLoop '<- don't forget!  
End Sub  
  
Sub Timer_Tick  
    'do the work required  
    Log("Worker 2: every " & TimerTickMs)  
End Sub
```

  
  
Alwaysbusy