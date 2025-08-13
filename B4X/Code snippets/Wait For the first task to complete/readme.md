###  Wait For the first task to complete by Erel
### 03/21/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160023/)

This code snippet shows how to wait for several tasks to complete: <https://www.b4x.com/android/forum/threads/b4x-wait-for-multiple-tasks-to-complete.150329/#content>  
  
Here, we are waiting for the first event that is raised. This can be useful in cases where there are two different events, one for success and one for failure.  

```B4X
     Dim status(1) As String  
    Test1(status)  
    Test2(status)  
    Do While status(0) = ""  
        Sleep(50)  
    Loop  
    Log("task completed: " & status(0))  
End Sub  
  
Private Sub Test1 (Status() As String)  
    Sleep(Rnd(1, 1000))  
    Status(0) = "Test1 completed"  
End Sub  
  
Private Sub Test2 (Status() As String)  
    Sleep(Rnd(1, 1000))  
    Status(0) = "Test2 completed"  
End Sub
```

  
  
You can replace the Sleep calls in the "test" subs with Wait Fors. For example:  

```B4X
 BannerAd.LoadAd  
 WaitForSuccess (status)  
  WaitForFailure(status)  
    Do While status(0) = ""  
        Sleep(50)  
    Loop  
    Log("task completed: " & status(0))  
  
Private Sub WaitForSuccess (Status() As String)  
   Wait For BannerAd_ReceiveAd  
    Status(0) = "success"  
End Sub  
  
Private Sub WaitForFailure(Status() As String)  
     Wait For BannerAd_FailedToReceiveAd (ErrorCode As String)  
    Status(0) = "fail: " & ErrorCode  
End Sub
```