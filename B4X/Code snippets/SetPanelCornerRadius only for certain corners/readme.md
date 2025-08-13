###  SetPanelCornerRadius only for certain corners by Alexander Stolte
### 12/12/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/164567/)

I needed a way to have only the corners that I need and preferably cross-platform.  
I have found a solution **for B4A and B4I**.  
For working B4J code I would be very grateful, I have packed an example project in the attachment.  
Thanks [USER=51832]@LucaMs[/USER] **for the B4J** code  
  
![](https://www.b4x.com/android/forum/attachments/159437)  
  

```B4X
    xpnl_MyPanel = xui.CreatePanel("")  
    xpnl_MyPanel.Color = xui.Color_Red  
    Root.AddView(xpnl_MyPanel,100dip,100dip,100dip,100dip)  
    SetPanelCornerRadius(xpnl_MyPanel,20dip,True,True,False,False)
```

  

```B4X
Private Sub SetPanelCornerRadius(View As B4XView, CornerRadius As Float,TopLeft As Boolean,TopRight As Boolean,BottomLeft As Boolean,BottomRight As Boolean)  
    #If B4I  
    'https://www.b4x.com/android/forum/threads/individually-change-corner-radius-of-a-view.127751/post-800352  
    View.SetColorAndBorder(View.Color,0,0,CornerRadius)  
    Dim CornerSum As Int = IIf(TopLeft,1,0) + IIf(TopRight,2,0) + IIf(BottomLeft,4,0) + IIf(BottomRight,8,0)  
    View.As(NativeObject).GetField ("layer").SetField ("maskedCorners", CornerSum)  
    #Else If B4A  
    'https://www.b4x.com/android/forum/threads/gradientdrawable-with-different-corner-radius.51475/post-322392  
    Dim cdw As ColorDrawable  
    cdw.Initialize(View.Color, 0)  
    View.As(View).Background = cdw  
    Dim jo As JavaObject = View.As(View).Background  
    If View.As(View).Background Is ColorDrawable Or View.As(View).Background Is GradientDrawable Then  
        jo.RunMethod("setCornerRadii", Array As Object(Array As Float(IIf(TopLeft,CornerRadius,0), IIf(TopLeft,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomLeft,CornerRadius,0))))  
    End If  
    #Else If B4J  
    'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/post-1008965  
    Dim Corners As String = ""  
    Corners = Corners & IIf(TopLeft, CornerRadius, 0) & " "  
    Corners = Corners & IIf(TopRight, CornerRadius, 0) & " "  
    Corners = Corners & IIf(BottomLeft, CornerRadius, 0) & " "  
    Corners = Corners & IIf(BottomRight, CornerRadius, 0)  
    CSSUtils.SetStyleProperty(View, "-fx-background-radius", Corners)  
    #End If  
End Sub
```