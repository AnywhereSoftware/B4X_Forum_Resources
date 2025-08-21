### TakeTime by LucaMs
### 12/13/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/112167/)

A way to calculate the time taken by a part of source code (very simple and rarely useful but… I was tired of writing these lines every time).  
  

```B4X
Sub TakeTime  
   Dim CurrTimeFormat As String = DateTime.TimeFormat  
   DateTime.TimeFormat = "mm:ss:SSS"  
   Dim Now As Long = DateTime.Now  
   Wait for StopTakeTime  
   Now = DateTime.Now - Now  
   Log("Elapsed time: " & DateTime.Time(Now))  
   DateTime.TimeFormat = CurrTimeFormat  
End Sub
```

  
  
Usage:  

```B4X
TakeTime  
  
' here the code to test  
  
CallSub(Me, "StopTakeTime")
```