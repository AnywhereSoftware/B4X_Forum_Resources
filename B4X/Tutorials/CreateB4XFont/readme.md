###  CreateB4XFont by aeric
### 07/31/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/168034/)

This is an example in response to this [post](https://www.b4x.com/android/forum/threads/solved-how-to-code-stylefont-from-truetype-font.168020/) and extension of the example posted [here](https://www.b4x.com/android/forum/threads/b4x-createb4xfont.138325/#post-875776).  
  

```B4X
Private Sub Button1_Click  
    #If B4i  
    Label1.Font = CreateB4XFont("D3-Biscuitism-Bold", 30, 30)  
    #Else  
    Label1.Font = CreateB4XFont("D3_Biscuitism_Bold.ttf", 30, 30)  
    #End If  
     
    #If B4A  
    SetFontSize(60)  
    SetFontName("FONTAWESOME")  
    SetFontStyle("BOLD_ITALIC")  
    CreateFont  
    xLBL.TextColor = xui.Color_Green  
    #End If  
End Sub
```

  
  
GitHub: <https://github.com/pyhoon/CreateB4XFontExample-B4X>