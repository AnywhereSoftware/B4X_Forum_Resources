###  Like Animation - smooth and beautiful transition by Alexander Stolte
### 11/25/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/124924/)

This is a simple like animation.  
It looks smoother and better in real.  
![](https://www.b4x.com/android/forum/attachments/103551)  

```B4X
Private Sub LikeAnimation(xlbl As B4XView,duration As Int)  
    Dim txt_size As Float = xlbl.TextSize  
    If xlbl.Text = Chr(0xE87E) Then  
        xlbl.SetTextSizeAnimated(duration/2,1)  
        Sleep(duration/2)  
        xlbl.Text = Chr(0xE87D)  
        xlbl.SetTextSizeAnimated(duration/2,txt_size)  
    Else  
        xlbl.SetTextSizeAnimated(duration/2,1)  
        Sleep(duration/2)  
        xlbl.Text = Chr(0xE87E)  
        xlbl.SetTextSizeAnimated(duration/2,txt_size)  
    End If  
End Sub
```

  

```B4X
Private Sub LikeAnimationColored(xlbl As B4XView,duration As Int,liked_color As Int,unliked_color As Int)  
    Dim txt_size As Float = xlbl.TextSize  
    If xlbl.Text = Chr(0xE87E) Then  
        xlbl.SetTextSizeAnimated(duration/2,1)  
        Sleep(duration/2)  
        xlbl.Text = Chr(0xE87D)  
        xlbl.TextColor = liked_color  
        xlbl.SetTextSizeAnimated(duration/2,txt_size)  
    Else  
        xlbl.SetTextSizeAnimated(duration/2,1)  
        Sleep(duration/2)  
        xlbl.Text = Chr(0xE87E)  
        xlbl.TextColor = unliked_color  
        xlbl.SetTextSizeAnimated(duration/2,txt_size)  
    End If  
End Sub
```