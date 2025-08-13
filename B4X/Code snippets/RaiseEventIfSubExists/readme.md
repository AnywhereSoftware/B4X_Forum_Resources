###  RaiseEventIfSubExists by LucaMs
### 03/27/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/166333/)

When you create a custom view, you often add some events to it.  
For example, the custom view I am preparing now has 3 events:  

```B4X
#Event: ElapsedTimeChanged(ElapsedTime As Long)  
#Event: StateChanged(Paused As Boolean, ElapsedTime As Long)  
#Event: Click(ElapsedTime As Long)
```

  
Writing code for each one would mean duplicating lines of code. This snippet (Sub) is useful in these cases.  
  
Note that the mEventName variable is already declared in the custom views class model.  
  

```B4X
Private Sub RaiseEventIfSubExists(EventName As String, params As List)  
    Dim FullSubName As String  
    FullSubName = mEventName & "_" & EventName  
    If xui.SubExists(mCallBack, FullSubName, params.Size) Then  
        Select params.Size  
            Case 0  
                CallSub(mCallBack, FullSubName)  
            Case 1  
                CallSub2(mCallBack, FullSubName, params.Get(0))  
            Case 2  
                CallSub3(mCallBack, FullSubName, params.Get(0), params.Get(1))  
        End Select  
    End If  
End Sub
```

  
  
Usage examples:  

```B4X
'Note the 2 parameters.  
RaiseEventIfSubExists("StateChanged", Array(mPaused, getElapsedTime))  
'1 parameter.  
RaiseEventIfSubExists("Click", Array(getElapsedTime))
```