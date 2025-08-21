### Haptic Touch by Mike1970
### 02/05/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/113675/)

Hi, i want to share this snippet that is a SLIGHTLY modified version of the Erel one.  
Maybe it can be found easly with this specific thread name:  
  
  

```B4X
Private FeedbackGenerator As NativeObject  'globals  
  
FeedbackGenerator.Initialize("UIImpactFeedbackGenerator")  
  
Sub Set_HapticTouch_Impact(Strenght As String) 'LIGHT, MEDIUM, HEAVY  
    If FeedbackGenerator.IsInitialized Then  
        Dim s As Int = 0  
        Select Strenght  
            Case "LIGHT"  
                s = 0  
            Case "MEDIUM"  
                s = 1  
            Case "HEAVY"  
                s = 2  
        End Select  
        FeedbackGenerator = FeedbackGenerator.RunMethod("alloc", Null).RunMethod("initWithStyle:", Array(s))  
    End If  
End Sub
```

  
  
Call  

```B4X
FeedbackGenerator.RunMethod("impactOccurred", Null)
```

  
to actually Start the vibration