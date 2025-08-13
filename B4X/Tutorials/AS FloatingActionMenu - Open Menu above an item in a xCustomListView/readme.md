###  AS FloatingActionMenu - Open Menu above an item in a xCustomListView by Alexander Stolte
### 05/20/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/161225/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-floatingactionmenu.161223/#post-989307>  
  
In this example, I let the AS\_FloatingActionMenu open over an item that is in a list, no matter how far down the item is.  
  
![](https://www.b4x.com/android/forum/attachments/153902)  
  

```B4X
    Dim Height As Float = FloatingActionMenu.ItemProperties.Height*FloatingActionMenu.Size 'Action Menu Height  
    Dim Width As Float = 250dip 'Action Menu Width  
    Dim Left As Float = TargetView.Left + TargetView.Width/2 - Width 'To the left of the target item  
     
    Dim RawListItem As CLVItem = CustomListView1.GetRawListItem(CustomListView1.GetItemFromView(TargetView)) 'Gets the raw list item  
    Dim Top As Float = CustomListView1.AsView.Top + (RawListItem.Offset - CustomListView1.sv.ScrollViewOffsetY) + RawListItem.Panel.Height 'Calculates the right top  
    If Top + Height > Root.Height Then 'If the menu no longer fits on the screen, display the menu above the list item  
        Top = Top - Height - 80dip + 20dip  
    End If
```