### Resumable subs in console/non-ui apps by Erel
### 07/05/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171462/)

We want to create a small program that downloads something and quits.  
  
First failed attempt:  

```B4X
'Will not work  
Sub AppStart (Args() As String)  
    Dim job As HttpJob  
    job.Initialize("", Me)  
    job.Download("https://www.google.com")  
    Wait For (job) JobDone(job As HttpJob)  
    If job.Success Then  
       Log(job.GetString)  
    End If  
    job.Release  
End Sub
```

  
  
Failure reason: Resumable subs, which includes calls to Sleep, rely on the internal message queue. There is no message queue in console apps, unless we call StartMessageLoop.  
  
Second failed attempt:  

```B4X
'Will not work  
Sub AppStart (Args() As String)  
    Dim job As HttpJob  
    job.Initialize("", Me)  
    job.Download("https://www.google.com")  
    Wait For (job) JobDone(job As HttpJob)  
    If job.Success Then  
       Log(job.GetString)  
    End If  
    job.Release  
    StartMessageLoop '<———-  
End Sub
```

  
This one is a bit more tricky. It goes like this - calling Sleep or Wait For is similar to calling Return. The flow returns to the calling sub and in this case as this is the AppStart sub, the program ends before it reaches the StartMessageLoop line.  
  
Third successful attempt:  

```B4X
'Will work  
Sub AppStart (Args() As String)  
    Download  
    StartMessageLoop  
End Sub  
  
Private Sub Download  
    Dim job As HttpJob  
    job.Initialize("", Me)  
    job.Download("https://www.google.com")  
    Wait For (job) JobDone(job As HttpJob)  
    If job.Success Then  
        Log(job.GetString)  
    End If  
    job.Release  
    StopMessageLoop 'or ExitApplication  
End Sub
```

  
Two important points:  
1. We need a separate sub. The flow will continue from the Wait For line, back to AppStart, and the StartMessageLoop will be executed.  
2. We call StopMessageLoop or ExitApplication once the task has completed. Without it, to the process will continue running.