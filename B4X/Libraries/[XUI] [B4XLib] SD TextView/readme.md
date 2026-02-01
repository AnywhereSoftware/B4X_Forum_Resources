###  [XUI] [B4XLib] SD TextView by Star-Dust
### 01/30/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/121178/)

I needed to develop a modern editText (or TextField), but different from the B4XFloatTextField, different in terms of graphics and style. So I created the SD\_TextView  
(see also [**xComboBox**](https://www.b4x.com/android/forum/threads/b4x-xui-sd_xcombobox.135359/))  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*  
  
**SD\_TextView  
  
Author:** Star-Dust  
**Version:** 0.25  

- **SD\_IconTextView**

- **Events:**

- **EnterPressed**
- **FocusChanged** (HasFocus As Boolean)
- **HintClick**
- **TextChanged** (OldText As String, Newtext As String)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)

- **Properties:**

- **Hint** As String
- **HintFont** As B4XFont
- **NativeObject** As TextField [read only]
- **Text** As String
- **TextFont** As B4XFont

- **SD\_TextView**

- **Events:**

- **EnterPressed**
- **FocusChanged** (HasFocus As Boolean)
- **TextChanged** (OldText As String, Newtext As String)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **SetHintColor** (HintTextColor As Int, HintBackGroundColor As Int)
- **SetTextViewColor** (TextColor As Int, BackGroundColor As Int, Corner\_Color As Int)

- **Properties:**

- **AnimateHint** As Boolean
- **Hint** As String
- **HintFont** As B4XFont
- **NativeObject** As TextField [read only]
- **Text** As String
- **TextFont** As B4XFont

- **SD\_TwoIconTextView**

- **Events:**

- **Click**
- **EnterPressed**
- **FocusChanged** (HasFocus As Boolean)
- **HintClick**
- **TextChanged** (OldText As String, Newtext As String)
- **Unfocus**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)

- **Properties:**

- **Hint** As String
- **HintFont** As B4XFont
- **NativeObject** As TextField [read only]
- **Text** As String
- **TextConfirmButton** As String
*Char fontAwesone*- **TextFont** As B4XFont

- **SD\_UnderLineTextView**

- **Events:**

- **EnterPressed**
- **FocusChanged** (HasFocus As Boolean)
- **TextChanged** (OldText As String, Newtext As String)

- **Fields:**

- **ExpansionTime** As Int
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **UnderLine** (Show As Boolean)

- **Properties:**

- **Hint** As String
- **HintFont** As B4XFont
- **NativeObject** As TextField [read only]
- **Text** As String
- **TextFont** As B4XFont

  
![](https://www.b4x.com/android/forum/attachments/103235)  
  
![](https://www.b4x.com/android/forum/attachments/103232)  
  
![](https://www.b4x.com/android/forum/attachments/98528) ![](https://www.b4x.com/android/forum/attachments/104910)  
  
![](https://www.b4x.com/android/forum/attachments/125624)![](https://www.b4x.com/android/forum/attachments/125685)