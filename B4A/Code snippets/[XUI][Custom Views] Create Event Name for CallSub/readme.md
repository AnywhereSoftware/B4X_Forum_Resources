### [XUI][Custom Views] Create Event Name for CallSub by LWGShane
### 12/22/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/144967/)

Just a simple method that makes creating event names for CallSub easier. Useful for Custom Views.  
  
Method:  

```B4X
Private Sub CreateEventName (SubName As String) As String  
    Return $"${mEventName}_${SubName}"$  
End Sub
```

  
  
To use:  

```B4X
CallSub(mCallBack, CreateEventName("YourEvent"))
```