###  [XUI] SD_xComboBox by Star-Dust
### 11/29/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/135359/)

At the request of my friend [USER=44364]@Mashiane[/USER] , I created a combobox that has the graphics of my [**IconTextView**](https://www.b4x.com/android/forum/threads/b4x-xui-b4xlib-sd_textview.121178/#post-757544) that is Multiplatform (B4X, B4J, B4i)  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*  
  
  
**SD\_xComboBox  
  
Author:** Star-Dust  
**Version:** 0.16  

- **SD\_xComboBox**

- **Events:**

- **ItemClick** (Position As Int, Value As Object)
- **OpenList**

- **Fields:**

- **ItemHeight** As Int
- **mBase** As B4XView
- **OpenDropDownOnFocus** As Boolean
- **Tag** As Object

- **Functions:**

- **Add** (Text As String, ReturnValue As Object)
*Add Item*- **AddAll** (L As List)
*Add List of Item, Return Value is a Text*- **Clear**
- **CloseDropDown**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **GetItem** (Position As Int) As String
- **GetValue** (Position As Int) As Object
- **Initialize** (Callback As Object, EventName As String)
- **isDropDownOpen** As Boolean
- **OpenDropDown**
- **SetSelection**(Start As Int, Length As Int)
- **Size** As Int

- **Properties:**

- **Enabled** As Boolean
- **Hint** As String
- **HintFont** As B4XFont
- **SelectedIndex** As Int
- **SelectedTextItem** As String
- **SelectOnlyFromList** As Boolean
- **SelectedValueItem** As Object
- **SelectionLenght** As Int [read only]
- **SelectionStart** As Int [read only]
- **TextFont** As B4XFont

  
![](https://www.b4x.com/android/forum/attachments/120648)![](https://www.b4x.com/android/forum/attachments/120649)