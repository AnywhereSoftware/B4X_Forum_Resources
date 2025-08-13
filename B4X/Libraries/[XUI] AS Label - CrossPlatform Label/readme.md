###  [XUI] AS Label - CrossPlatform Label by Alexander Stolte
### 02/08/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/130752/)

This is a simple label view, in IOS roundings are removed when resizing or colors are not displayed properly. This can be fixed by placing a panel under the label, this view does the work for you.  
Just set the properties you want in the designer like in a normal label.  
  
**ASLabel  
Author: Alexander Stolte  
Version: 1.02**  

- **ASLabel**

- **Events:**

- **Click**
- **LongClick**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getLabel** As Label
*gets the native label*- **getxLabel** As B4XView
*gets the native label as B4XView*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Properties:**

- **Label** As Label [read only]
*gets the native label*- **xLabel** As B4XView [read only]
*gets the native label as B4XView*
![](https://www.b4x.com/android/forum/attachments/113412)  

```B4X
    ASLabel1.IconPosition = ASLabel1.IconPosition_LeftText  
    ASLabel1.Icon = ASLabel1.FontToBitmap(Chr(0xE859),True,20,xui.Color_White)
```

  
![](https://www.b4x.com/android/forum/attachments/145020)  
  
**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFix - ClickEvent is now working on B4A and B4J

- **1.02**

- Add set and get Enabled - Disabled or Enabled the label click events

- **1.03**

- Add Icon support

- **1.04**

- Add get and set Left
- Add get and set Top
- Add get and set Widt
- Add get and set Height
- Add get and set Text
- Add get and set TextColor
- Add SetColorAndBorder
- Add SetTextAlignment
- Add get and set Visible
- Add get and set Font
- Add get and set TextSize

**Github:** [github.com/StolteX/AS\_Label](https://github.com/StolteX/AS_Label)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)