### Swipe left-right between activities by WimS
### 04/08/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/116050/)

To swipe left-right from one activity to another without panels, buttons or tabs.  
  
Put this code in each activity to swipe.  
  

```B4X
Sub Globals  
    Dim Xprevious As Float  
End sub  
  
Sub Activity_Resume     
    Xprevious = 0  
End Sub  
  
Sub Activity_Touch (Action As Int, X As Float, Y As Float)  
      
    If Action= Activity.ACTION_MOVE Then  
        If Xprevious = 0 Then Xprevious = X  
    End If  
    If Action = Activity.ACTION_UP Then         
        If X > 0 And X - Xprevious > 400 And Xprevious > 0 Then  '400 = swipe distance  
            Log("right")  
            StartActivity("Right")  
        Else  
            If X > 0 And X - Xprevious < -400  Then        '-400 = swipe distance  
                Log("left")  
                StartActivity("Left")             
            End If  
        End If  
        Xprevious = 0         
    End If  
End Sub
```