###  [XUI] AS BottomActionMenu by Alexander Stolte
### 01/22/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/157513/)

This view combines 2 views and makes it quick and easy to let the user make an action.  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/)

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/147931)![](https://www.b4x.com/android/forum/attachments/147932)![](https://www.b4x.com/android/forum/attachments/147933)  
  

```B4X
    BottomActionMenu.Initialize(Me,"BottomActionMenu",Root)  
   
    BottomActionMenu.Color = xui.Color_ARGB(255,32, 33, 37)  
    BottomActionMenu.DragIndicatorColor = xui.Color_White  
    BottomActionMenu.ItemProperties.TextColor = xui.Color_White  
   
    BottomActionMenu.AddItem("WhatsApp",BottomActionMenu.FontToBitmap(Chr(0xF232),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Twitter",BottomActionMenu.FontToBitmap(Chr(0xF099),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Instagram",BottomActionMenu.FontToBitmap(Chr(0xF16D),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Snapchat",BottomActionMenu.FontToBitmap(Chr(0xF2AC),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("YouTube",BottomActionMenu.FontToBitmap(Chr(0xF16A),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Stackoverflow",BottomActionMenu.FontToBitmap(Chr(0xF16C),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
   
    BottomActionMenu.ShowPicker
```

  

```B4X
    BottomActionMenu.Initialize(Me,"BottomActionMenu",Root)  
   
    BottomActionMenu.Color = xui.Color_White  
    BottomActionMenu.DragIndicatorColor = xui.Color_Black  
    BottomActionMenu.ItemProperties.TextColor = xui.Color_Black  
   
    BottomActionMenu.AddItem("WhatsApp",BottomActionMenu.FontToBitmap(Chr(0xF232),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Twitter",BottomActionMenu.FontToBitmap(Chr(0xF099),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Instagram",BottomActionMenu.FontToBitmap(Chr(0xF16D),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Snapchat",BottomActionMenu.FontToBitmap(Chr(0xF2AC),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("YouTube",BottomActionMenu.FontToBitmap(Chr(0xF16A),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
    BottomActionMenu.AddItem("Stackoverflow",BottomActionMenu.FontToBitmap(Chr(0xF16C),False,30,BottomActionMenu.ItemProperties.TextColor),"")  
   
    BottomActionMenu.ShowPicker
```

  
**AS\_BottomActionMenu  
Author: Alexander Stolte  
Version: 1.02**  

- **AS\_BottomActionMenu**

- **Events:**

- **ItemClick** (Index As Int, Value As Object)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddItem** (Text As String, Icon As B4XBitmap, Value As Object)
- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **HidePicker**
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView)
*Initializes the object. You can add parameters to this method if needed.*- **ShowPicker**

- **Properties:**

- **Color** As Int
- **DragIndicatorColor** As Int
- **isOpen** As Boolean [read only]
- **ItemProperties** As AS\_BottomActionMenu\_ItemProperties [read only]
*Defaults:  
 TextColor - White  
 Width - 90dip  
 xFont - Bold 14*
**Changelog**  

- **1.00**

- Release

- **1.01**

- New HidePicker
- New get isOpen

- **1.02**

- **BreakingChange** get and set TextColor renamed -> DragIndicatorColor
- New AS\_BottomActionMenu\_ItemProperties type
- New get ItemProperties
- BugFixes

- **1.03**

- BugFix - Icon under B4A in wrong position

**Github:** [github.com/StolteX/AS\_BottomActionMenu](https://github.com/StolteX/AS_BottomActionMenu)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)