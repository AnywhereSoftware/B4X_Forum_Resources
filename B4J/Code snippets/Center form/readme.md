### Center form by LucaMs
### 12/23/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169822/)

[I'm quite surprised I didn't find this]  
  

```B4X
'Center the form, on the parent form if it is passed (passed Null)  
'otherwise on the Desktop.  
Private Sub CenterForm(FrmToCenter As Form, Parent As Form)  
    Dim JFX1 As JFX  
    If Not(NotInitialized(Parent)) Then  
        FrmToCenter.WindowLeft = Parent.WindowLeft + (Parent.Width - FrmToCenter.Width) / 2  
        FrmToCenter.WindowTop  = Parent.WindowTop  + (Parent.Height - FrmToCenter.Height) / 2  
    Else  
        Dim PS As Screen = JFX1.PrimaryScreen  
        FrmToCenter.WindowLeft = (PS.MaxX - PS.MinX) / 2 - FrmToCenter.Width / 2  
        FrmToCenter.WindowTop  = (PS.MaxY - PS.MinY) / 2 - FrmToCenter.Height / 2  
    End If  
End Sub
```

  
  
I used a local variable, JFX1, but obviously you can use the classic fx declared by default in the B4J templates.