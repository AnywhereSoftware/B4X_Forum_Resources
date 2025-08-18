### ShThumbUpButton (Wrapped) by Salar82
### 02/06/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/138227/)

Hi All;  
  
This is a simple view:) wrapped from this project:  
<https://github.com/ldoublem/ThumbUp>  
  
  
Library source (github):  
<https://github.com/Salar82/ShThumbUpButton-B4A>  
  
  
![](https://github.com/Salar82/ShThumbUpButton-B4A/raw/master/Preview/preview.gif)  
  
[HEADING=1]Features[/HEADING]  

- [HEADING=2]Designer Support[/HEADING]
- [HEADING=2]Simple to use[/HEADING]
- [HEADING=2]Full Customize[/HEADING]

  
[HEADING=1]Usage[/HEADING]  

```B4X
Sub Globals  
    Private ShThumbUpButton1 As ShThumbUpButton  
End Sub  
  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    
    ShThumbUpButton1.Sh_CracksColor = Colors.White  
    ShThumbUpButton1.Sh_FillColor = 0xFFFF7700  
    ShThumbUpButton1.Sh_EdgeColor = Colors.Magenta  
    ShThumbUpButton1.Sh_UnLikeType = ShThumbUpButton1.Type_Broken  
    
End Sub
```

  
  

```B4X
Sub Globals  
    Dim ShThumbUpButton1 As ShThumbUpButton  
End Sub  
  
  
Sub Activity_Create(FirstTime As Boolean)  
    ShThumbUpView1.Initialize("ShThumbUpView1")  
    Activity.AddView(ShThumbUpView1, 0dip, 50dip, 50dip, 50dip)  
    
    ShThumbUpButton1.Sh_CracksColor = Colors.White  
    ShThumbUpButton1.Sh_FillColor = 0xFFFF7700  
    ShThumbUpButton1.Sh_EdgeColor = Colors.Magenta  
    ShThumbUpButton1.Sh_UnLikeType = ShThumbUpButton1.Type_Broken  
    
End Sub
```

  
  
[HEADING=1]Event[/HEADING]  

```B4X
Private Sub ShThumbUpView1_StateChange (Like As Boolean)  
    'Log($"Like: ${Like}"$)  ' TODTO  
End Sub
```

  
  
  
[HEADING=1]About Me[/HEADING]  
[HEADING=3]A developer in Iran :);)[/HEADING]