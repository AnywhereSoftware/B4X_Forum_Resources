###  ShakeView by LucaMs
### 09/11/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/122182/)

**[By Erel]**  
  

```B4X
Sub ShakeView (View As B4XView, Duration As Int)  
   Dim Left As Int = View.Left  
   Dim Delta As Int = 20dip  
   For i = 1 To 4  
       View.SetLayoutAnimated(Duration / 5, Left + Delta, View.Top, View.Width, View.Height)  
       Delta = -Delta  
       Sleep(Duration / 5)  
   Next  
   View.SetLayoutAnimated(Duration/5, Left, View.Top, View.Width, View.Height)  
End Sub
```

  
  

```B4X
Sub Button1_Click  
   ShakeView(EditText1, 500)  
End Sub
```

  
  
> Add a reference to XUI.