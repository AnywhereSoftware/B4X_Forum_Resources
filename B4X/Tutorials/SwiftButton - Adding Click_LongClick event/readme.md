###  SwiftButton - Adding Click/LongClick event by Myr0n
### 06/03/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/118613/)

The next code add the funcionality in b4x to capture the click & longClick using Touch, in case of b4j add the option to fire the longClick using the Right Mouse Click or the secondary mouse button.  
**- Unzip the file "XUI Views.b4xlib"  
- Look for the file "SwiftButton.bas" and open  
- Add the next changes to the file "SwiftButton.bas"  
- Zip again the file "XUI Views.b4xlib"**  
  
Add next line just after **#Event: Click**  

```B4X
#Event: LongClick
```

  
  
**Add next lines to the Sub Class\_Globals**  

```B4X
    Private TouchEventStarted, TouchEventDuration As Long 'These vars are to simulate the click and longClick event.  
    #if B4J  
    Private TouchEventMaxDuration As Long = 100  
    #else  
    Private TouchEventMaxDuration As Long = 400  
    #End If
```

  
  
**1.1-Replace next code**  

```B4X
#if B4J  
Private Sub p_MouseClicked (EventData As MouseEvent)  
    EventData.Consume  
End Sub  
#End If
```

  
**1.2-For this**  

```B4X
#if B4J  
Private Sub p_MouseClicked (EventData As MouseEvent)  
    If EventData.SecondaryButtonPressed Then  
        CallSubDelayed(mCallBack, mEventName & "_LongClick")  
    Else  
        EventData.Consume  
    End If  
End Sub  
#End If
```

  
  
**2.1-Replace next code**  

```B4X
Private Sub p_Touch (Action As Int, X As Float, Y As Float)  
    If mDisabled Then Return  
    Dim Inside As Boolean = x > 0 And x < mBase.Width And y > 0 And y < mBase.Height  
    Select Action  
        Case mBase.TOUCH_ACTION_DOWN  
            SetPressedState(True)  
            Draw  
        Case mBase.TOUCH_ACTION_MOVE  
            If pressed <> Inside Then  
                SetPressedState(Inside)  
                Draw  
            End If  
        Case mBase.TOUCH_ACTION_UP  
            SetPressedState(False)  
            Draw  
            If Inside Then  
                CallSubDelayed(mCallBack, mEventName & "_Click")  
            End If  
    End Select  
End Sub
```

  
**2.2-For this**  

```B4X
Private Sub p_Touch (Action As Int, X As Float, Y As Float) As Boolean  
    If mDisabled Then Return True  
    Dim Inside As Boolean = x > 0 And x < mBase.Width And y > 0 And y < mBase.Height  
    Select Action  
        Case mBase.TOUCH_ACTION_DOWN  
            SetPressedState(True)  
            Draw  
            TouchEventStarted = DateTime.Now 'Capture the time that the user started touching the panel.  
        Case mBase.TOUCH_ACTION_MOVE  
            If pressed <> Inside Then  
                SetPressedState(Inside)  
                Draw  
            End If  
        Case mBase.TOUCH_ACTION_UP  
            SetPressedState(False)  
            Draw  
            If Inside Then  
                TouchEventDuration = DateTime.Now - TouchEventStarted 'Calculate touch duration  
                If TouchEventDuration <= TouchEventMaxDuration Then 'Click event  
                    CallSubDelayed(mCallBack, mEventName & "_Click")  
                Else ' longClick / Touch event raised as LongClick  
                    CallSubDelayed(mCallBack, mEventName & "_LongClick")  
                End If  
            End If  
    End Select  
    Return True  
End Sub
```

  
  
  
  
  
  
Hope this help.  
If you can optimize the code, please post any change in this thread.  
  
[USER=1]@Erel[/USER] if you consider that this functionality is helpful for the b4x community and have some free time, please, include it in the next release of **SwiftButton XUI Views**.