###  [XUI] AS BottomActionSheet by Alexander Stolte
### 12/03/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/159328/)

This view makes it quick and easy to let the user make an action.  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/)

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/150939) ![](https://www.b4x.com/android/forum/attachments/150941)  
  

```B4X
    BottomActionSheet.Initialize(Me,"BottomActionSheet",Root)  
    BottomActionSheet.Theme = BottomActionSheet.Theme_Light 'Dark or Light mode  
   
    BottomActionSheet.AddItem("Item #1",BottomActionSheet.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),0)  
    BottomActionSheet.AddItem("Item #2",BottomActionSheet.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),1)  
    BottomActionSheet.AddItem("Item #3",BottomActionSheet.FontToBitmap(Chr(0xE190),True,30,xui.Color_Black),2)  
   
    BottomActionSheet.ShowPicker  
   
    Wait For BottomActionSheet_ItemClicked(Item As AS_BottomActionSheet_Item)  
   
    BottomActionSheet.HidePicker  
    Log(Item.Text & " clicked")
```

  
  
**Examples**  
<https://www.b4x.com/android/forum/threads/b4x-as-bottomactionsheet-small-icon.163932/>  
  
**AS\_BottomActionSheet  
Author: Alexander Stolte  
Version: 1.03  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_BottomActionSheet**

- **Events:**

- **ActionButtonClicked**
- **Close**
- **CustomDrawItem** (Item As AS\_BottomActionSheet\_Item, ItemViews As AS\_BottomActionSheet\_ItemViews)
- **ItemClicked** (Item As AS\_BottomActionSheet\_Item)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddItem** (Text As String, Icon As B4XBitmap, Value As Object) As AS\_BottomActionSheet\_Item
- **AddItem2** (Text As String, Icon As B4XBitmap, SmallIcon As B4XBitmap, Value As Object) As AS\_BottomActionSheet\_Item
*SmallIcon - An icon that can be displayed before or after the text*- **Class\_Globals** As String
- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getActionButton** As B4XView
- **getActionButtonVisible** As Boolean
- **getColor** As Int
- **getDragIndicatorColor** As Int
- **getHorizontalAlignment\_AfterText** As String
- **getHorizontalAlignment\_BeforeText** As String
- **getItemProperties** As AS\_BottomActionSheet\_ItemProperties
- **getItemSmallIconProperties** As AS\_BottomActionSheet\_ItemSmallIconProperties
*VerticalAlignment - Top, Center, Bottom  
 HorizontalAlignment - BeforeText, AfterText  
 WidthHeight - Default: 15dip  
 LeftGap - Default: 0dip*- **GetItemViews** (Value As Object) As AS\_BottomActionSheet\_ItemViews
*Gets the item views for a value*- **GetItemViews2** (Index As Int) As AS\_BottomActionSheet\_ItemViews
*Gets the item views for a index*- **getSize** As Int
*Get the number of items*- **getTheme\_Dark** As AS\_BottomActionSheet\_Theme
- **getTheme\_Light** As AS\_BottomActionSheet\_Theme
- **getVerticalAlignment\_Bottom** As String
- **getVerticalAlignment\_Center** As String
- **getVerticalAlignment\_Top** As String
- **HidePicker** As String
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setActionButtonVisible** (Visible As Boolean) As String
- **setColor** (Color As Int) As String
- **setDragIndicatorColor** (Color As Int) As String
- **setTextColor** (Color As Int) As String
- **setTheme** (Theme As AS\_BottomActionSheet\_Theme) As String
- **ShowPicker**

- **Properties:**

- **ActionButton** As B4XView [read only]
- **ActionButtonVisible** As Boolean
- **Color** As Int
- **DragIndicatorColor** As Int
- **HorizontalAlignment\_AfterText** As String [read only]
- **HorizontalAlignment\_BeforeText** As String [read only]
- **ItemProperties** As AS\_BottomActionSheet\_ItemProperties [read only]
- **ItemSmallIconProperties** As AS\_BottomActionSheet\_ItemSmallIconProperties [read only]
*VerticalAlignment - Top, Center, Bottom  
 HorizontalAlignment - BeforeText, AfterText  
 WidthHeight - Default: 15dip  
 LeftGap - Default: 0dip*- **Size** As Int [read only]
*Get the number of items*- **TextColor**
- **Theme**
- **Theme\_Dark** As AS\_BottomActionSheet\_Theme [read only]
- **Theme\_Light** As AS\_BottomActionSheet\_Theme [read only]
- **VerticalAlignment\_Bottom** As String [read only]
- **VerticalAlignment\_Center** As String [read only]
- **VerticalAlignment\_Top** As String [read only]

- **AS\_BottomActionSheet\_Item**

- **Fields:**

- **Icon** As B4XBitmap
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemProperties** As AS\_BottomActionSheet\_ItemProperties
- **ItemSmallIconProperties** As AS\_BottomActionSheet\_ItemSmallIconProperties
- **SmallIcon** As B4XBitmap
- **Text** As String
- **Value** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_BottomActionSheet\_ItemProperties**

- **Fields:**

- **Height** As Float
- **IconWidthHeight** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **LeftGap** As Float
- **SeperatorColor** As Int
- **SeperatorVisible** As Boolean
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_BottomActionSheet\_ItemSmallIconProperties**

- **Fields:**

- **Color** As Int
- **HorizontalAlignment** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **LeftGap** As Float
- **VerticalAlignment** As String
- **WidthHeight** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_BottomActionSheet\_ItemViews**

- **Fields:**

- **BackgroundPanel** As B4XView
- **IconImageView** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SeperatorPanel** As B4XView
- **TextLabel** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_BottomActionSheet\_Theme**

- **Fields:**

- **BodyColor** As Int
- **DragIndicatorColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Improvements
- Add get and set DragIndicatorColor

- **1.02**

- Add Event CustomDrawItem
- Add Type AS\_BottomActionSheet\_ItemViews
- Add GetItemViews - Gets the item views for a value
- Add GetItemViews2 - Gets the item views for a index
- Add Event Close
- Add get Size - Get the number of items

- **1.03**

- Add Type AS\_BottomActionSheet\_ItemSmallIconProperties
- Add SmallIcon to Type AS\_BottomActionSheet\_Item
- Add ItemSmallIconProperties to Type AS\_BottomActionSheet\_Item
- Add AddItem2 with the SmallIcon Parameter
- Add set Theme

- Add get Theme\_Dark
- Add get Theme\_Light

- **1.04 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomactionsheet.159328/post-1005724)**)**

- Add get and set SheetWidth - Set a value greater than 0 to define a custom width

- Default: 0

- Add TextHorizontalAlignment to Type AS\_BottomActionSheet\_ItemProperties

- Left, Center, Right

- **1.05 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomactionsheet.159328/post-1008218)**)**

- Add IconHorizontalAlignment to Type AS\_BottomActionSheet\_ItemProperties

- Auto, Left, Right
- Default: Auto

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)