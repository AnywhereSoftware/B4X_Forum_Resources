### Center form by LucaMs
### 12/24/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169822/)

[I'm quite surprised I didn't find this]  
  

```B4X
'Center the form, on the parent form if it is passed (you can pass Null)  
'otherwise on the Desktop.  
Private Sub CenterForm(Frm As Form, Parent As Form)  
    Dim JFX1 As JFX  
    If Initialized(Parent) Then  
        Frm.WindowLeft = Parent.WindowLeft + (Parent.Width - Frm.Width) / 2  
        Frm.WindowTop  = Parent.WindowTop  + (Parent.Height - Frm.Height) / 2  
    Else  
        Dim PS As Screen = JFX1.PrimaryScreen  
        Frm.WindowLeft = (PS.MaxX - PS.MinX) / 2 - Frm.Width / 2  
        Frm.WindowTop  = (PS.MaxY - PS.MinY) / 2 - Frm.Height / 2  
    End If  
End Sub
```

  
  
I used a local variable, JFX1, but obviously you can use the classic fx declared by default in the B4J templates.