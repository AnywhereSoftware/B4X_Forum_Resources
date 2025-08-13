###  Programmatically open B4XComboBox by Erel
### 01/09/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/158539/)

```B4X
Private Sub OpenComboBox(x As B4XComboBox)  
    #if B4A  
    x.cmbBox.As(JavaObject).RunMethod("performClick", Null)  
    #else if B4J  
    x.cmbBox.As(JavaObject).RunMethod("show", Null)  
    #else if B4i  
    CallSub(x, "btn_click")  
    #end if  
End Sub
```