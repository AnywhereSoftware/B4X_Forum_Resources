### Get Current Form by Erel
### 07/14/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/162078/)

Gets the currently focused form:  
  

```B4X
Public Sub GetCurrentForm As Form  
    Dim UninitializedForm As Form  
    Dim x As JavaObject  
    Dim stage As JavaObject = x.InitializeStatic("anywheresoftware.b4a.objects.B4XViewWrapper$XUI").RunMethod("findActiveStage", Null)  
    If stage.IsInitialized = False Then Return UninitializedForm  
    Dim scene As JavaObject = stage.RunMethod("getScene", Null)  
    Dim pane As B4XView = scene.RunMethod("getRoot", Null)  
    Dim a As JavaObject  
    Return a.InitializeStatic("anywheresoftware.b4a.AbsObjectWrapper").RunMethodJO("getExtraTags", Array(pane)).RunMethod("get", Array("form"))  
End Sub
```

  
  

```B4X
Dim frm As Form = GetCurrentForm  
If frm.IsInitialized Then  
    Log(frm.Title)  
End If
```