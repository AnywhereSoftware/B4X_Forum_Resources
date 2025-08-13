###  [XUI] AS BottomColorChooser by Alexander Stolte
### 11/26/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164296/)

This view makes it quick and easy to let the user choose a color. Inspired by the [colorchooser from the AS\_Settings](https://www.b4x.com/android/forum/threads/b4x-as-settings-colorchooser-property.163869/).  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/)

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/158921) ![](https://www.b4x.com/android/forum/attachments/158922)  
  

```B4X
Private Sub OpenSheet(DarkMode As Boolean)  
   
    BottomColorChooser.Initialize(Me,"BottomColorChooser",Root)  
   
    Dim lst_Colors As List  
    lst_Colors.Initialize  
    lst_Colors.Add(xui.Color_ARGB(255, 49, 208, 89))  
    lst_Colors.Add(xui.Color_ARGB(255, 25, 29, 31))  
    lst_Colors.Add(xui.Color_ARGB(255, 9, 131, 254))  
    lst_Colors.Add(xui.Color_ARGB(255, 255, 159, 10))  
   
    lst_Colors.Add(xui.Color_ARGB(255, 45, 136, 121))  
    lst_Colors.Add(BottomColorChooser.CreateColorItem(xui.Color_ARGB(255, 73, 98, 164),False))  
    lst_Colors.Add(BottomColorChooser.CreateColorItem(xui.Color_ARGB(255, 221, 95, 96),False))  
    lst_Colors.Add(BottomColorChooser.CreateColorItem(xui.Color_ARGB(255, 141, 68, 173),False))  
    lst_Colors.Add(xui.Color_Magenta)  
    lst_Colors.Add(xui.Color_Cyan)  
   
    BottomColorChooser.SelectedColor = xui.Color_ARGB(255, 9, 131, 254)  
   
    BottomColorChooser.Theme = IIf(DarkMode,BottomColorChooser.Theme_Dark,BottomColorChooser.Theme_Light)  
    BottomColorChooser.ActionButtonVisible = True  
    BottomColorChooser.SetItems(lst_Colors)  
    BottomColorChooser.ShowPicker  
   
    BottomColorChooser.ActionButton.Text = "Confirm"  
   
End Sub
```

  
**Events**  

```B4X
Private Sub BottomColorChooser_ItemClicked(Item As AS_BottomColorChooser_Item)  
    LogColor("ItemClicked",Item.Color)  
End Sub
```

  

```B4X
Private Sub BottomColorChooser_DisabledItemClicked(Item As AS_BottomColorChooser_Item)  
    LogColor("DisabledItemClicked",Item.Color)  
End Sub
```

  

```B4X
Private Sub BottomColorChooser_ActionButtonClicked  
    LogColor("ActionButtonClicked with color",BottomColorChooser.SelectedColor)  
    BottomColorChooser.HidePicker  
End Sub
```

  
**Item Width and Height + Corner Radius**  
You can set the size of the items, if you want to keep a circle, you have to adjust the corner radius to the new size.  

```B4X
    BottomColorChooser.WidthHeight = 100dip  
    BottomColorChooser.CornerRadius = BottomColorChooser.WidthHeight/2 'For a circle
```

  
If you don't want a circle, you can set the corner radius to a value of your choice.  
  
**AS\_BottomColorChooser  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_BottomColorChooser**

- **Events:**

- **ActionButtonClicked**
- **Close**
- **DisabledItemClicked** (Item As AS\_BottomColorChooser\_Item)
- **ItemClicked** (Item As AS\_BottomColorChooser\_Item)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddItem** (Color As Int, Enabled As Boolean) As AS\_BottomColorChooser\_Item
- **Class\_Globals** As String
- **CreateColorItem** (Color As Int, Enabled As Boolean) As AS\_BottomColorChooser\_Item
- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getActionButton** As B4XView
- **getActionButtonVisible** As Boolean
- **getColor** As Int
- **getCornerRadius** As Float
- **getDragIndicatorColor** As Int
- **getSelectedColor** As Int
- **getSheetWidth** As Float
- **getSize** As Int
*Get the number of items*- **getTheme\_Dark** As AS\_BottomColorChooser\_Theme
- **getTheme\_Light** As AS\_BottomColorChooser\_Theme
- **getWidthHeight** As Float
- **HidePicker** As String
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setActionButtonVisible** (Visible As Boolean) As String
- **setColor** (Color As Int) As String
- **setCornerRadius** (CornerRadius As Float) As String
*The CornerRadius of a color item*- **setDragIndicatorColor** (Color As Int) As String
- **SetItems** (ColorList As List) As String
- **setSelectedColor** (SelectedColor As Int) As String
*<code>BottomColorChooser.SelectedColor = xui.Color\_ARGB(255, 9, 131, 254)</code>*- **setSheetWidth** (SheetWidth As Float) As String
*Set the value to greater than 0 to set a custom width  
 Set the value to 0 to use the full screen width  
 Default: 0*- **setTheme** (Theme As AS\_BottomColorChooser\_Theme) As String
- **setWidthHeight** (WidthHeight As Float) As String
*Default: 60dip  
 If you want a circle, then dont forget to set the CornerRadius property*- **ShowPicker**

- **Properties:**

- **ActionButton** As B4XView [read only]
- **ActionButtonVisible** As Boolean
- **Color** As Int
- **CornerRadius** As Float
*The CornerRadius of a color item*- **DragIndicatorColor** As Int
- **SelectedColor** As Int
*<code>BottomColorChooser.SelectedColor = xui.Color\_ARGB(255, 9, 131, 254)</code>*- **SheetWidth** As Float
*Set the value to greater than 0 to set a custom width  
 Set the value to 0 to use the full screen width  
 Default: 0*- **Size** As Int [read only]
*Get the number of items*- **Theme**
- **Theme\_Dark** As AS\_BottomColorChooser\_Theme [read only]
- **Theme\_Light** As AS\_BottomColorChooser\_Theme [read only]
- **WidthHeight** As Float
*Default: 60dip  
 If you want a circle, then dont forget to set the CornerRadius property*
- **AS\_BottomColorChooser\_Item**

- **Fields:**

- **Color** As Int
- **Enabled** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_BottomColorChooser\_Theme**

- **Fields:**

- **ActionButtonBackgroundColor** As Int
- **ActionButtonTextColor** As Int
- **BodyColor** As Int
- **DragIndicatorColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)