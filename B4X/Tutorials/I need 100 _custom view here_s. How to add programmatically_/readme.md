###  I need 100 <custom view here>s. How to add programmatically? by Erel
### 05/21/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/118037/)

Custom views are designed to be added with the designer.  
  
It is however very simple to create a layout file with the custom view and load it multiple times.  
  
![](https://www.b4x.com/basic4android/images/B4A_NrYo4sDqsp.png)  
Tip: remove the call to AutoScaleAll from the designer script.  
  
Complete example:  

```B4X
Sub Globals  
    Private B4XSwitch1 As B4XSwitch  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    For i = 1 To 20  
        AddSwitch(50dip, 40dip * i, i)  
    Next  
End Sub  
  
Sub AddSwitch (Left As Int, Top As Int, Tag As Object) As B4XSwitch  
    Activity.LoadLayout("B4XSwitch")  
    B4XSwitch1.mBase.Left = Left 'B4XSwitch1 global variable will point to the last one added  
    B4XSwitch1.mBase.Top = Top  
    B4XSwitch1.Tag = Tag  
    Return B4XSwitch1  
End Sub  
  
  
Sub B4XSwitch1_ValueChanged (Value As Boolean)  
    Dim switch As B4XSwitch = Sender  
    Log(switch.Tag)  
End Sub
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/94480)