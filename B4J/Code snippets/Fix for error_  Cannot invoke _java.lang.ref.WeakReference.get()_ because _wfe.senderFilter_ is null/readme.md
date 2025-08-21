### Fix for error:  Cannot invoke "java.lang.ref.WeakReference.get()" because "wfe.senderFilter" is null by Erel
### 08/18/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168282/)

This error is a bit tricky. It happens when multiple resumable subs are waiting for events with the same name, some with sender filter set and others without.  
  
This code reproduces this error:  

```B4X
'Call both subs in this order:  
    t2  
    t1  
  
  
Private Sub t1  
    Dim job As HttpJob  
    job.Initialize("", Me)  
    job.Download("https://www.b4x.com")  
    Wait For (job) JobDone(job As HttpJob) 'with sender filter  
    If job.Success Then  
       Log(job.GetString)  
    End If  
    job.Release  
End Sub  
  
Private Sub t2  
    Dim job As HttpJob  
    job.Initialize("", Me)  
    job.Download("https://www.b4x.com")  
    Wait For JobDone(job As HttpJob) 'without sender filter  
    If job.Success Then  
       Log(job.GetString)  
    End If  
    job.Release  
End Sub
```

  
  
This is a programming mistake as the only reliable way to intercept multiple events with the same name is based on the sender filter.  