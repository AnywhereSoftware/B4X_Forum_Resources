###  [XUI] AS BottomEmojiPicker by Alexander Stolte
### 08/11/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/157648/)

A bottom emoji picker.  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/)

  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/148110) ![](https://www.b4x.com/android/forum/attachments/148111) ![](https://www.b4x.com/android/forum/attachments/148112)  
  
Emoji Datasource from:  
<https://github.com/muan/unicode-emoji-json/blob/main/data-by-group.json>  
  

```B4X
    BottomEmojiPicker.Initialize(Me,"BottomEmojiPicker",Root)  
   
    BottomEmojiPicker.BackgroundColor = xui.Color_ARGB(255,32, 33, 37)  
    BottomEmojiPicker.CategoryTextColor = xui.Color_White  
    BottomEmojiPicker.CategoryIndicatorColor = xui.Color_White  
   
    BottomEmojiPicker.ShowPicker
```

  

```B4X
    BottomEmojiPicker.Initialize(Me,"BottomEmojiPicker",Root)  
   
    BottomEmojiPicker.BackgroundColor = xui.Color_White  
    BottomEmojiPicker.CategoryTextColor = xui.Color_Black  
    BottomEmojiPicker.CategoryIndicatorColor = xui.Color_Black  
   
    BottomEmojiPicker.ShowPicker
```

  

```B4X
    BottomEmojiPicker.Initialize(Me,"BottomEmojiPicker",Root)  
   
    BottomEmojiPicker.BackgroundColor = xui.Color_ARGB(255,32, 33, 37)  
    BottomEmojiPicker.CategoryTextColor = xui.Color_White  
    BottomEmojiPicker.CategoryIndicatorColor = xui.Color_White  
    BottomEmojiPicker.EmojiSize = 50  
    BottomEmojiPicker.BodyHeight = 300dip  
    BottomEmojiPicker.Rows = 3  
   
    BottomEmojiPicker.ShowPicker
```

  
  
**AS\_BottomEmojiPicker  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_BottomEmojiPicker**

- **Events:**

- **EmojiSelected** (Emoji As String)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **getBackgroundColor** As Int
- **getBodyHeight** As Float
*Default: 300dip*- **getCategoryIndicatorColor** As Int
- **getCategoryTextColor** As Int
- **getEmojiSize** As Int
- **getRows** As Int
*Number of emojis per row vertical  
 Default: 5*- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setBackgroundColor** (Color As Int) As String
- **setBodyHeight** (Height As Float) As String
- **setCategoryIndicatorColor** (Color As Int) As String
- **setCategoryTextColor** (Color As Int) As String
- **setEmojiSize** (Size As Int) As String
*Default: 30*- **setRows** (Rows As Int) As String
- **ShowPicker**

- **Properties:**

- **BackgroundColor** As Int
- **BodyHeight** As Float
*Default: 300dip*- **CategoryIndicatorColor** As Int
- **CategoryTextColor** As Int
- **EmojiSize** As Int
*Default: 30*- **Rows** As Int
*Number of emojis per row vertical  
 Default: 5*
- **B4XMainPage**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add HidePicker

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)