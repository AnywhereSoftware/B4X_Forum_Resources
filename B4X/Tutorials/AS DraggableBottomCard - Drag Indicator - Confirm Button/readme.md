###  AS DraggableBottomCard - Drag Indicator - Confirm Button by Alexander Stolte
### 11/25/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157554/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/>  
  
![](https://www.b4x.com/android/forum/attachments/147993)  
  

```B4X
    'DragIndicator  
    Dim xpnl_DragIndicator As B4XView = xui.CreatePanel("")  
    BottomCard.HeaderPanel.AddView(xpnl_DragIndicator,Root.Width/2 - 70dip/2,HeaderHeight/2 - 6dip/2,70dip,6dip)  
    xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,255,255,255),0,0,3dip)
```

  
  

```B4X
    'ConfirmationButton  
    Dim xlbl_ConfirmationButton As B4XView = CreateLabel("xlbl_ConfirmationButton")  
    xlbl_ConfirmationButton.Text = "Confirm"  
    xlbl_ConfirmationButton.TextColor = xui.Color_White  
    xlbl_ConfirmationButton.SetColorAndBorder(xui.Color_ARGB(255,45, 136, 121),0,0,10dip)  
    xlbl_ConfirmationButton.SetTextAlignment("CENTER","CENTER")  
    Dim ConfirmationButtoHeight As Float = 40dip    
    BottomCard.BodyPanel.AddView(xlbl_ConfirmationButton,Root.Width/2 - 220dip/2,BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,220dip,ConfirmationButtoHeight)
```

  
  

```B4X
Private Sub OpenDarkDatePicker  
     
    Dim SafeAreaHeight As Float = 0  
    Dim HeaderHeight As Float = 20dip  
    Dim BodyHeight As Float = 150dip  
     
    #If B4I  
    SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom  
    BodyHeight = BodyHeight + SafeAreaHeight  
    #Else  
    SafeAreaHeight = 20dip  
    BodyHeight = BodyHeight + SafeAreaHeight  
    #End If  
     
    BottomCard.Initialize(Me,"BottomCard")  
    BottomCard.BodyDrag = True  
    BottomCard.Create(Root,BodyHeight,BodyHeight,HeaderHeight,Root.Width,BottomCard.Orientation_MIDDLE)  
    BottomCard.CornerRadius_Header = 30dip/2  
  
    'DragIndicator  
    Dim xpnl_DragIndicator As B4XView = xui.CreatePanel("")  
    BottomCard.HeaderPanel.AddView(xpnl_DragIndicator,Root.Width/2 - 70dip/2,HeaderHeight/2 - 6dip/2,70dip,6dip)  
    xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,255,255,255),0,0,3dip)  
  
    'ConfirmationButton  
    Dim xlbl_ConfirmationButton As B4XView = CreateLabel("xlbl_ConfirmationButton")  
    xlbl_ConfirmationButton.Text = "Confirm"  
    xlbl_ConfirmationButton.TextColor = xui.Color_White  
    xlbl_ConfirmationButton.SetColorAndBorder(xui.Color_ARGB(255,45, 136, 121),0,0,10dip)  
    xlbl_ConfirmationButton.SetTextAlignment("CENTER","CENTER")  
    Dim ConfirmationButtoHeight As Float = 40dip    
    BottomCard.BodyPanel.AddView(xlbl_ConfirmationButton,Root.Width/2 - 220dip/2,BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,220dip,ConfirmationButtoHeight)  
     
    'Optional Code  
    BottomCard.HeaderPanel.Color = xui.Color_ARGB(255,32, 33, 37)  
    BottomCard.BodyPanel.Color = xui.Color_ARGB(255,32, 33, 37)  
     
    BottomCard.Show(False)  
     
End Sub  
  
Private Sub CreateLabel(EventName As String) As B4XView  
    Dim lbl As Label  
    lbl.Initialize(EventName)  
    Return lbl  
End Sub  
  
Private Sub xlbl_ConfirmationButton_Click  
    Log("ConfirmationButton Clicked")  
    BottomCard.Hide(False)  
End Sub
```