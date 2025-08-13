###  AS SegmentedTab - Custom tab width by Alexander Stolte
### 10/29/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157090/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/>  
  
![](https://www.b4x.com/android/forum/attachments/147331)  
  

```B4X
    ASSegmentedTab3.mBase.Color = xui.Color_ARGB(255,42, 156, 255)  
    ASSegmentedTab3.SelectionPanel.Color = xui.Color_White  
    ASSegmentedTab3.ItemTextProperties.TextColor = xui.Color_Black  
    ASSegmentedTab3.ItemTextProperties.SelectedTextColor = xui.Color_Black  
    ASSegmentedTab3.CornerRadiusBackground = 8dip  
    ASSegmentedTab3.CornerRadiusSelectionPanel = 8dip  
    ASSegmentedTab3.PaddingSelectionPanel = 4dip  
      
    '*********CustomTab************  
    Dim Tab1 As ASSegmentedTab_Tab  
    Tab1.Initialize  
    Tab1.Icon = ASSegmentedTab3.FontToBitmap(Chr(0xE068),True,15,xui.Color_White)  
    Tab1.Width = 40dip  
    ASSegmentedTab3.AddTabAdvanced(Tab1)  
  
    ASSegmentedTab3.AddTab("Inizio",Null)  
    ASSegmentedTab3.AddTab("Fine Prova",Null)
```