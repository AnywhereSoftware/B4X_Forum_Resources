###  [B4XLib] [XUI] SD_xMultiSpinner by Star-Dust
### 10/14/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/136215/)

**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*  
  
**SD\_xMultiSpinner  
  
Author:** Star-Dust  
**Version:** 0.05  

- **xMultiSpinner**

- **Events:**

- **ItemClick** (Position As Int, CheckValue As Boolean)

- **Fields:**

- **ItemHeight** As Int
- **ItemWidth** As Int
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Add** (Text As String, ReturnValue As Object, Check As Boolean)
*Add Item*- **Add2** (Text As String, ReturnValue As Object, Check As Boolean, Enabled As Boolean)
- **AddAll** (L As List)
*Add List of Item, Return Value is a Text*- **Clear**
- **CloseDropDown**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **GetChecked** (Position As Int) As Boolean
- **GetReturnValue** (Position As Int) As Object
- **GetText** (Position As Int) As String
- **Initialize** (Callback As Object, EventName As String)
- **isDroprDownOpen** As Boolean
- **OpenDropDown**
- **RemoveIndex** (Position As Int)
- **SelectedIndexToArray** As Int()
- **SelectedReturnValueToArray** As Object()
- **SelectedReturnValueToText** As String
- **SelectedTextToArray** As String()
- **SelectedToText** As String
- **SetChecked** (Position As Int, Check As Boolean)
- **SetEnabled** (Position As Int, Check As Boolean)
- **Size** As Int

- **Properties:**

- **Hint** As String
- **HintFont** As B4XFont
- **TextFont** As B4XFont

  
![](https://www.b4x.com/android/forum/attachments/122069) ![](https://www.b4x.com/android/forum/attachments/122070)