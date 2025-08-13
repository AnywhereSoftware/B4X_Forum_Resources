###  AS PopupMenu with icons by Alexander Stolte
### 01/14/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158623/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-popup-menu.121832/>  
  
![](https://www.b4x.com/android/forum/attachments/149652) ![](https://www.b4x.com/android/forum/attachments/149653)  
  

```B4X
Private Sub ShowMenu  
      
    aspm_Main.Initialize(Root,Me,"aspm_Main")  
   
    aspm_Main.MenuCornerRadius = 10dip  
    aspm_Main.ItemLabelProperties.TextAlignment_Horizontal = aspm_Main.OrientationHorizontal_LEFT  
    aspm_Main.ItemLabelProperties.LeftRightPadding = 10dip  
   
    aspm_Main.IconProperties.HorizontalAlignment = aspm_Main.OrientationHorizontal_RIGHT  
   
    aspm_Main.AddMenuItemWithIcon("Item #1",aspm_Main.FontToBitmap(Chr(0xE3C9),True,20,xui.Color_White),"Item1")  
    aspm_Main.AddMenuItemWithIcon("Item #2",aspm_Main.FontToBitmap(Chr(0xE192),True,20,xui.Color_White),"Item2")  
   
    aspm_Main.ItemLabelProperties.BackgroundColor = xui.Color_ARGB(200,0,0,0)'black  
   
    aspm_Main.OpenMenuAdvanced(Root.Width/2 - 200dip/2,Root.Height/2 - aspm_Main.MenuHeight/2,200dip)  
  
    Wait For aspm_Main_ItemClicked(Index As Int,Tag As Object)  
      
    Select Tag.As(String)  
        Case "Item1"  
              
        Case "Item2"  
  
    End Select  
      
End Sub
```