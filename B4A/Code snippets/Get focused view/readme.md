### Get focused view by ANC-Software
### 12/16/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/144845/)

Simple routine to get the focused (normally EditText) view:  
  

```B4X
Sub GetFocused() as View  
    Dim jo As JavaObject  
    Dim vw As View  
    jo.InitializeContext  
    Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)  
    vw=window.RunMethod("getCurrentFocus",Null)  
    Return vw  
End Sub
```

  
  
HTH