### [B4XLib] B4XExecCondLM by LucaMs
### 09/12/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/134177/)

Yesterday I was programming (sometimes it happens to me) and I realized that I… don't know **now** if I need this kind of feature, so I developed it ?  
  
Seriously, I seem to remember something like the commands I wrote in this library and which could therefore be useful.  
  
Don't forget that this developer needs coffee in order for him to post decent stuff :)  
  
**V. 1.10 - Added ExecIfAll** - see [post #9](https://www.b4x.com/android/forum/threads/b4x-b4xlib-b4xexeccondlm.134177/post-848989)  
![](https://www.b4x.com/android/forum/attachments/118992)  
  
  
**ExecIf**  
![](https://www.b4x.com/android/forum/attachments/118904)  
  
**ExecOnIndex**  
![](https://www.b4x.com/android/forum/attachments/118905)  
  
Example:  

```B4X
Private Sub Button1_Click  
    'ExecIF example.  
    Dim A As Int = 10  
    Dim B As Int = 2  
  
    Dim Result As Int  
    Result = B4XExecCondLM.ExecIF(Array As Boolean(a <= b, a > b), Array As String("Multiply", "Divide"), Array As Object(10, 2), True, Me)  
    Log("ExecIf result: " & Result)  
   
    'ExecOnIndex example.  
    B4XExecCondLM.ExecOnIndex(1, Array As String("Zero", "One", "Two"), Null, False, Me)  
End Sub  
  
  
Public Sub Multiply(Value1 As Int, Value2 As Int) As Int  
    Return Value1 * Value2  
End Sub  
  
Public Sub Divide(Value1 As Int, Value2 As Int) As Double  
    Return Value1 / Value2  
End Sub  
  
  
Public Sub Zero  
    Log("Zero")  
End Sub  
  
Public Sub One  
    Log("One")  
End Sub  
  
Public Sub Two  
    Log("Two")  
End Sub
```

  
**Log:**  
ExecIf result: 5  
One  
  
Library and test project attached.