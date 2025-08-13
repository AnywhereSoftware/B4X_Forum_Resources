###  B4XSwitch to support Accessibility by b4x-de
### 11/15/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/157418/)

I think that the B4XSwitch does not support accessibility very well. I made a simple extension based on the already [extended version of the B4XSwitch that supports setting colors at runtime](https://www.b4x.com/android/forum/threads/b4x-b4xswitch-changing-colors-in-runtime.138657/). (Many thanks to [USER=75340]@Blueforcer[/USER].) Now you can add a description to the panel, which is read out correctly by TalkBack.  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
      
    Acc.SetContentDescription(B4XSwitchAcc1.Panel, "This is a switch. It is currently " & IIf(B4XSwitchAcc1.Value, "on.", "off."))  
End Sub  
  
Private Sub B4XSwitchAcc1_ValueChanged (Value As Boolean)  
    Acc.SetContentDescription(B4XSwitchAcc1.Panel, "This is a switch. It is currently " & IIf(B4XSwitchAcc1.Value, "on.", "off."))  
End Sub
```

  
  
> Just replace it inside your XUI Views.b4xlib. You can also rename the class to use it beside the official XUI Views. Maybe this can be added in future official updates.