###  [XUI] AS Radio Button by Alexander Stolte
### 02/06/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/121959/)

This is a simple cross platform RadioButton.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI  
**B4a**: XUi,XUI Views  
**B4i**: iXUI,XUI Views  
[/SPOILER]  
**In B4I the animation is limited, because otherwise the circle would look too angular in the animation.**  
![](https://www.b4x.com/android/forum/attachments/99607)![](https://www.b4x.com/android/forum/attachments/99608) ![](https://www.b4x.com/android/forum/attachments/103682)  
Animation = NONE (default)  
![](https://www.b4x.com/android/forum/attachments/114066)  
**ASCheckbox  
Author: Alexander Stolte  
Version: 1.04**  

- **ASRadioButton**

- **Events:**

- **CheckedChange** (Checked As Boolean)

- **Fields:**

- **g\_Haptic** As Boolean
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBase** As B4XView
- **getChecked** As Boolean
- **getDisabledCheckedBackgroundColor** As Int
- **getDisabledUncheckedBackgroundColor** As Int
- **getEnabled** As Boolean
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setBorderWidth** (width As Int) As String
- **setChecked** (b\_checked As Boolean) As String
- **setCheckedBackgroundColor** (crl As Int) As String
- **setDisabledCheckedBackgroundColor** (crl As Int) As String
- **setDisabledUncheckedBackgroundColor** (crl As Int) As String
- **setEnabled** (enable As Boolean) As String
- **setUncheckedBackgroundColor** (crl As Int) As String

- **Properties:**

- **Base** As B4XView [read only]
- **BorderWidth**
- **Checked** As Boolean
- **CheckedBackgroundColor**
- **DisabledCheckedBackgroundColor** As Int
- **DisabledUncheckedBackgroundColor** As Int
- **Enabled** As Boolean
- **UncheckedBackgroundColor**

**Changelog**  

- **1.00**

- Release

- **1.01**

- B4I Better Animations thanks to [USER=106971]@Semen Matusovskiy[/USER]
- Add getBase

- **1.02**

- Add DisabledCheckedBackgroundColor property and designer property
- Add DisabledUnCheckedBackgroundColor property and designer property

- ![](https://www.b4x.com/android/forum/attachments/103682)

- Add Enable property - enable or disable the view
- BugFixes

- **1.03**

- Add Designer Property Animation -Select-Animation NONE=without Slide=the normal animation

- ![](https://www.b4x.com/android/forum/attachments/114066)

- **V1.04**

- BugFix - Enabled = False, now the view is disabled, no touch gestures allowed

- **V1.05**

- Base\_Resize is now public

**Github:** [github.com/StolteX/AS\_RadioButton](https://github.com/StolteX/AS_RadioButton)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)