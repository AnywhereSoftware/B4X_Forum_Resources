###  Wait for multiple tasks to complete by Erel
### 09/06/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/150329/)

A pattern such as this one can be used when you want to run multiple resumable subs concurrently and wait for all of them to complete before continuing:  

```B4X
    Dim status(1) As Int  
    Test1(status)  
    Test2(status)  
    Test3(status)  
    Do While status(0) < 3  
        Sleep(50)  
    Loop  
    Log("all tasks completed. Continue with your next task…")  
  
Private Sub Test1 (Status() As Int)  
    Sleep(Rnd(1, 1000))  
    Log("Test1 completed")  
    Status(0) = Status(0) + 1  
End Sub  
  
Private Sub Test2 (Status() As Int)  
    Sleep(Rnd(1, 1000))  
    Log("Test2 completed")  
    Status(0) = Status(0) + 1  
End Sub  
  
Private Sub Test3 (Status() As Int)  
    Sleep(Rnd(1, 1000))  
    Log("Test3 completed")  
    Status(0) = Status(0) + 1  
End Sub
```

  
For example, you might want to download multiple resources and process them together.  
Note that it doesn't need to be three different subs. You can call the same sub multiple times. Just make sure to set the counter (3 in the example) to match the number of calls.  
And don't worry about this loop. It is not a busy loop. It is similar to using a timer to poll something.