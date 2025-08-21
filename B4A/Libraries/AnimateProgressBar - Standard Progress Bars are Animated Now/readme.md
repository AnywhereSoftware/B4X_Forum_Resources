### AnimateProgressBar - Standard Progress Bars are Animated Now by ProgrammedComputer
### 03/30/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/115595/)

Hi  
This library animates standard progress bars. It doesn't add any view  
  
![](https://www.b4x.com/android/forum/attachments/90894)  
  
Animation is smoother on a real device. this is a gif.  
  
Example:  

```B4X
Sub Globals  
  
    Private ProgressBar1 As ProgressBar  
    Private RndPb As Button  
    Dim apb As AnimateProgressBar  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Main")  
End Sub  
  
Sub RndPb_Click  
    apb.SetProgressAnimated(ProgressBar1,Rnd(0,101))  
End Sub
```