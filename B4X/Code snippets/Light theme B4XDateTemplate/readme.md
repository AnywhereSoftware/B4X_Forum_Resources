###  Light theme B4XDateTemplate by Erel
### 09/13/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/111837/)

**Many more options: <https://www.b4x.com/android/forum/threads/b4x-share-your-b4xdialog-templates-theming-code.131243>**  
  
![](https://www.b4x.com/basic4android/images/i_view64_QAmn2SVit7.png)  
  
Example of customizing B4XDialog and B4XDateTemplate.  
  

```B4X
Sub SetLightTheme  
    Dialog.TitleBarColor = 0xFFFF7505  
    Dialog.TitleBarHeight = 80dip  
    Dim TextColor As Int = 0xFF5B5B5B  
    Dialog.BackgroundColor = xui.Color_White  
    Dialog.ButtonsColor = xui.Color_White  
    Dialog.ButtonsTextColor = Dialog.TitleBarColor  
    Dialog.BorderColor = xui.Color_Transparent  
    DateTemplate.DaysInWeekColor = xui.Color_Black  
    DateTemplate.SelectedColor = 0xFF39D7CE  
    DateTemplate.HighlightedColor = 0xFF00CEFF  
    DateTemplate.DaysInMonthColor = TextColor  
    DateTemplate.lblMonth.TextColor = TextColor  
    DateTemplate.lblYear.TextColor = TextColor  
    DateTemplate.SelectedColor = 0xFFFFA761  
    For Each b As B4XView In Array(DateTemplate.btnMonthLeft, DateTemplate.btnMonthRight, DateTemplate.btnYearLeft, DateTemplate.btnYearRight)  
        b.Color = xui.Color_Transparent  
        b.TextColor = TextColor  
        #if B4i  
        Dim no As NativeObject = b  
        no.RunMethod("setTitleColor:forState:", Array(no.ColorToUIColor(TextColor), 0))  
        #End If  
    Next  
End Sub
```

  
  
B4A project is attached.  
  
Edit: code updated to correctly set the arrow buttons text color in B4i.