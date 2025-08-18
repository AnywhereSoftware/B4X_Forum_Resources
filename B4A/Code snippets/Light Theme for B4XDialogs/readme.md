### Light Theme for B4XDialogs by arfprogramas
### 03/05/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/128302/)

First you have to use the code below to set your **dialog** variable to Light Theme:  

```B4X
Sub SetLightThemeDialog(dialog As B4XDialog)  
    dialog.BackgroundColor = Colors.White  
    dialog.ButtonsColor = Colors.White  
    dialog.BorderColor = Colors.Gray  
    dialog.ButtonsTextColor = 0xFF007DC3  
End Sub
```

  
  
Then you can use the others codes whenever you need:  

```B4X
Sub SetLightThemeList(list As B4XListTemplate)  
    Dim TextColor As Int = 0xFF5B5B5B  
    list.CustomListView1.sv.ScrollViewInnerPanel.Color = 0xFFDFDFDF  
    list.CustomListView1.sv.Color = Colors.White  
    list.CustomListView1.DefaultTextBackgroundColor = Colors.White  
    list.CustomListView1.DefaultTextColor = TextColor  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/109139)  
  

```B4X
Sub SetLightThemeInput(input As B4XInputTemplate)  
    Dim TextColor As Int = 0xFF5B5B5B  
    input.TextField1.TextColor = TextColor  
    input.lblTitle.TextColor = TextColor  
    input.SetBorderColor(TextColor, Colors.Red)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/109140)  
  

```B4X
Sub SetLightThemeSearch(search As B4XSearchTemplate)  
    Dim TextColor As Int = 0xFF5B5B5B  
    search.SearchField.TextField.TextColor = TextColor  
    search.SearchField.NonFocusedHintColor = TextColor  
    search.CustomListView1.sv.ScrollViewInnerPanel.Color = 0xFFDFDFDF  
    search.CustomListView1.sv.Color = Colors.White  
    search.CustomListView1.DefaultTextBackgroundColor = Colors.White  
    search.CustomListView1.DefaultTextColor = TextColor  
    If search.SearchField.lblV.IsInitialized Then search.SearchField.lblV.TextColor = TextColor  
    If search.SearchField.lblClear.IsInitialized Then search.SearchField.lblClear.TextColor = TextColor  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/109141)  
  

```B4X
Sub SetLightThemeDate(datetemplate As B4XDateTemplate)  
    Dim TextColor As Int = 0xFF5B5B5B  
    datetemplate.DaysInWeekColor = Colors.Black  
    datetemplate.SelectedColor = 0xFF39D7CE  
    datetemplate.HighlightedColor = 0xFF00CEFF  
    datetemplate.DaysInMonthColor = TextColor  
    datetemplate.lblMonth.TextColor = TextColor  
    datetemplate.lblYear.TextColor = TextColor  
    datetemplate.SelectedColor = 0xFFFFA761  
    For Each x As B4XView In Array(datetemplate.btnMonthLeft, datetemplate.btnMonthRight, datetemplate.btnYearLeft, datetemplate.btnYearRight)  
        x.Color = Colors.Transparent  
    Next  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/109142)