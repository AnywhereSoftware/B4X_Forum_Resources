### RoundSlider Min/Max Values by advansis
### 03/11/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/114838/)

Hi guys,  
I've just changed the XUI Views Library to have Min/Max Properties editable at runtime…  
[USER=1]@Erel[/USER], please include (after correcting) in future versions of the library, thanks.  
  

```B4X
Public Sub setMax (v As Int)  
    if v<0 then return  
    mMax= max(mMin,v)  
    Draw  
End Sub  
  
Public Sub getMax As Int  
    Return mMax  
End Sub  
  
Public Sub setMin (v As Int)  
    if v<0 then return  
    mMin= min(mMax,v)  
    Draw  
End Sub  
  
Public Sub getMin As Int  
    Return mMin  
End Sub
```