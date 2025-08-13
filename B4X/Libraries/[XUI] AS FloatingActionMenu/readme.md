###  [XUI] AS FloatingActionMenu by Alexander Stolte
### 05/29/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/161223/)

This view makes it quick and easy to let the user make an action.  
  
You need:  

- [AS\_FloatingPanel](https://www.b4x.com/android/forum/threads/b4x-as-floatingpanel.141754/)

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/153889) ![](https://www.b4x.com/android/forum/attachments/153890)  
  
![](https://www.b4x.com/android/forum/attachments/153891)  
  

```B4X
    FloatingActionMenu.Initialize(Me,"FloatingActionMenu",Root)  
  
    FloatingActionMenu.AddItem("Item #1",Null,0)  
    FloatingActionMenu.AddItem("Item #2",Null,1)  
    FloatingActionMenu.AddItem("Item #3",Null,2)  
   
    Dim Height As Float = FloatingActionMenu.ItemProperties.Height*FloatingActionMenu.Size  
    Dim Left As Float = xlbl_OpenMenuDark.Left + xlbl_OpenMenuDark.Width + 10dip  
    Dim Top As Float = xlbl_OpenMenuDark.Top + xlbl_OpenMenuDark.Height/2 - Height/2  
   
    FloatingActionMenu.ShowPicker(Left,Top,200dip,Height)  
   
    Wait For FloatingActionMenu_ItemClicked(Item As AS_FloatingActionMenu_Item)  
   
    Select Item.Value  
        Case 0  
            Log(Item.Text & " clicked")  
        Case 1  
            Log(Item.Text & " clicked")  
        Case 2  
            Log(Item.Text & " clicked")  
    End Select
```

  
  

```B4X
    FloatingActionMenu.Initialize(Me,"FloatingActionMenu",Root)  
   
    FloatingActionMenu.Color = xui.Color_ARGB(255,32, 33, 37)  
    FloatingActionMenu.TextColor = xui.Color_White  
    FloatingActionMenu.ItemProperties.SeperatorVisible = True  
  
'    FloatingActionMenu.AddItem("Item #1",Null,0)  
'    FloatingActionMenu.AddItem("Item #2",Null,1)  
'    FloatingActionMenu.AddItem("Item #3",Null,2)  
   
    FloatingActionMenu.AddItem("Item #1",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),0)  
    FloatingActionMenu.AddItem("Item #2",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),1)  
    FloatingActionMenu.AddItem("Item #3",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_White),2)  
   
    Dim Height As Float = FloatingActionMenu.ItemProperties.Height*FloatingActionMenu.Size  
    Dim Left As Float = xlbl_OpenMenuDark.Left + xlbl_OpenMenuDark.Width + 10dip  
    Dim Top As Float = xlbl_OpenMenuDark.Top + xlbl_OpenMenuDark.Height/2 - Height/2  
   
    FloatingActionMenu.ShowPicker(Left,Top,200dip,Height)  
   
    Wait For FloatingActionMenu_ItemClicked(Item As AS_FloatingActionMenu_Item)  
   
    Select Item.Value  
        Case 0  
            Log(Item.Text & " clicked")  
        Case 1  
            Log(Item.Text & " clicked")  
        Case 2  
            Log(Item.Text & " clicked")  
    End Select
```

  
  

```B4X
    FloatingActionMenu.Initialize(Me,"FloatingActionMenu",Root)  
   
    FloatingActionMenu.Color = xui.Color_White  
    FloatingActionMenu.TextColor = xui.Color_Black  
    FloatingActionMenu.ItemProperties.SeperatorVisible = True  
  
'    FloatingActionMenu.AddItem("Item #1",Null,0)  
'    FloatingActionMenu.AddItem("Item #2",Null,1)  
'    FloatingActionMenu.AddItem("Item #3",Null,2)  
   
    FloatingActionMenu.AddItem("Item #1",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),0)  
    FloatingActionMenu.AddItem("Item #2",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),1)  
    FloatingActionMenu.AddItem("Item #3",FloatingActionMenu.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),2)  
   
    Dim Height As Float = FloatingActionMenu.ItemProperties.Height*FloatingActionMenu.Size  
    Dim Left As Float = xlbl_OpenMenuLight.Left + xlbl_OpenMenuLight.Width + 10dip  
    Dim Top As Float = xlbl_OpenMenuLight.Top + xlbl_OpenMenuLight.Height/2 - Height/2  
   
    FloatingActionMenu.ShowPicker(Left,Top,200dip,Height)  
   
    Wait For FloatingActionMenu_ItemClicked(Item As AS_FloatingActionMenu_Item)  
   
    Select Item.Value  
        Case 0  
            Log(Item.Text & " clicked")  
        Case 1  
            Log(Item.Text & " clicked")  
        Case 2  
            Log(Item.Text & " clicked")  
    End Select
```

  
  
<https://www.b4x.com/android/forum/threads/b4x-as-floatingactionmenu-open-menu-above-an-item-in-a-xcustomlistview.161225/>  
  
**AS\_FloatingActionMenu  
Author: Alexander Stolte  
Version: 1.00**  
[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_FloatingActionMenu**

- **Events:**

- **ItemClicked** (Item As AS\_BottomActionSheet\_Item)
- **MenuClosed**

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddItem** (Text As String, Icon As B4XBitmap, Value As Object) As String
- **Class\_Globals** As String
- **CreateAS\_FloatingActionMenu\_Item** (Text As String, Icon As B4XBitmap, Value As Object, ItemProperties As AS\_FloatingActionMenu\_ItemProperties) As AS\_FloatingActionMenu\_Item
- **CreateAS\_FloatingActionMenu\_ItemProperties** (Height As Float, IconLeftGap As Float, TextLeftGap As Float, xFont As B4XFont, TextColor As Int, IconWidthHeight As Float, SeperatorVisible As Boolean, SeperatorColor As Int) As AS\_FloatingActionMenu\_ItemProperties
- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getCloseOnTap** As Boolean
*Default: True*- **getColor** As Int
- **getCornerRadius** As Float
*Default: 10dip*- **GetCustomDrawItem** (Index As Int) As AS\_FloatingActionMenu\_CustomDrawItem
- **getFloatingPanel** As b4j.example.as\_floatingpanel
*Can only be used after ShowPicker is called*- **getItemProperties** As AS\_FloatingActionMenu\_ItemProperties
- **getOpenOrientation\_BottomTop** As String
*Opens the panel from bottom to top*- **getOpenOrientation\_LeftBottom** As String
*Opens the panel from left to bottom*- **getOpenOrientation\_LeftRight** As String
*Opens the panel from left to right*- **getOpenOrientation\_LeftTop** As String
*Opens the panel from left to top*- **getOpenOrientation\_None** As String
*Opens the panel without slide, but with fade*- **getOpenOrientation\_RightBottom** As String
*Opens the panel from right to bottom*- **getOpenOrientation\_RightLeft** As String
*Opens the panel from right to left*- **getOpenOrientation\_RightTop** As String
*Opens the panel from right to top*- **getOpenOrientation\_TopBottom** As String
*Opens the panel from top to bottom*- **getSize** As Int
*Added item count*- **HidePicker** As String
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setCloseOnTap** (Enabled As Boolean) As String
- **setColor** (Color As Int) As String
- **setCornerRadius** (Radius As Float) As String
- **setDuration** (Duration As Long) As String
*Default: 150*- **setOpenOrientation** (Orientation As String) As String
- **setTextColor** (Color As Int) As String
- **ShowPicker** (Left As Float, Top As Float, Width As Float, Height As Float)

- **Properties:**

- **CloseOnTap** As Boolean
*Default: True*- **Color** As Int
- **CornerRadius** As Float
*Default: 10dip*- **Duration**
*Default: 150*- **ItemProperties** As AS\_FloatingActionMenu\_ItemProperties [read only]
- **OpenOrientation**
- **OpenOrientation\_BottomTop** As String [read only]
*Opens the panel from bottom to top*- **OpenOrientation\_LeftBottom** As String [read only]
*Opens the panel from left to bottom*- **OpenOrientation\_LeftRight** As String [read only]
*Opens the panel from left to right*- **OpenOrientation\_LeftTop** As String [read only]
*Opens the panel from left to top*- **OpenOrientation\_None** As String [read only]
*Opens the panel without slide, but with fade*- **OpenOrientation\_RightBottom** As String [read only]
*Opens the panel from right to bottom*- **OpenOrientation\_RightLeft** As String [read only]
*Opens the panel from right to left*- **OpenOrientation\_RightTop** As String [read only]
*Opens the panel from right to top*- **OpenOrientation\_TopBottom** As String [read only]
*Opens the panel from top to bottom*- **Size** As Int [read only]
*Added item count*- **TextColor**

- **AS\_FloatingActionMenu\_CustomDrawItem**

- **Fields:**

- **BackgroundPanel** As B4XView
- **IconImageView** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Item** As AS\_FloatingActionMenu\_Item
- **TextLabel** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_FloatingActionMenu\_Item**

- **Fields:**

- **Icon** As B4XBitmap
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemProperties** As AS\_FloatingActionMenu\_ItemProperties
- **Text** As String
- **Value** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_FloatingActionMenu\_ItemProperties**

- **Fields:**

- **Height** As Float
- **IconLeftGap** As Float
- **IconWidthHeight** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SeperatorColor** As Int
- **SeperatorVisible** As Boolean
- **TextColor** As Int
- **TextLeftGap** As Float
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- AddItem is now returning the AS\_FloatingActionMenu\_Item
- Add "Enabled" property to the AS\_FloatingActionMenu\_Item

- Deactivates an item
- The item is darkened so that the user can see that it is deactivated

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)