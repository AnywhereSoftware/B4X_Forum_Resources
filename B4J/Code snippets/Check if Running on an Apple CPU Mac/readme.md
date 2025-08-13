### Check if Running on an Apple CPU Mac by xulihang
### 09/29/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/163338/)

I need to know whether it is running on a Mac with an Apple CPU or an Intel CPU to load jni libraries and here is the code came out:  
  

```B4X
Sub IsAppleCPU As ResumableSub  
    Dim sh As Shell  
    sh.Initialize("sh","uname",Array As String("-m"))  
    sh.Run(-1)  
    wait for sh_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If StdOut.Contains("arm64") Then  
        Return True  
    Else  
        Return False  
    End If  
End Sub
```