###  [XUI] AS Checkbox by Alexander Stolte
### 12/08/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/121878/)

This is a simple cross platform Checkbox.  
  
If you need a checkbox with text, then check out the [AS\_CheckBoxAdvanced](https://www.b4x.com/android/forum/threads/b4x-xui-as-checkboxadvanced.149025/)  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,JavaObject  
**B4a**: XUi,StringUtils,XUI Views (2.40+)  
**B4i**: iXUI,XUI Views (2.40+)  
[/SPOILER]  
  
![](https://www.b4x.com/android/forum/attachments/99463)![](https://www.b4x.com/android/forum/attachments/99464)![](https://www.b4x.com/android/forum/attachments/99465)  
![](https://www.b4x.com/android/forum/attachments/99494)![](https://www.b4x.com/android/forum/attachments/99496)  
Disabled style:  
![](https://www.b4x.com/android/forum/attachments/103672)  
  
**AS\_Checkbox  
Author: Alexander Stolte  
Version: 2.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASCheckbox**

- **Events:**

- **CheckedChange** (Checked As Boolean)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Base\_Resize** (Width As Double, Height As Double)
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String)
- **SetIcon** (icon As String, isfontawesome As Boolean)

- **Properties:**

- **BorderCornerRadius** As Int [write only]
- **BorderWidth** As Int [write only]
- **Checked** As Boolean
- **Checked2** As Boolean [write only]
*Without the CheckedChange Event*- **CheckedAnimated** As Boolean [write only]
- **CheckedBackgroundColor** As Int [write only]
- **DisabledBackgroundColor** As Int
- **DisabledIconColor** As Int
- **Enabled** As Boolean
- **IconColor** As Int
- **isEvent** As Boolean
- **isFillUncheckedBackgroundColor** As Boolean
- **isFontAswesome** As Boolean
- **isHaptic** As Boolean
- **isround** As Boolean
- **Theme** As AS\_CheckBox\_Theme [write only]
- **Theme\_Dark** As AS\_CheckBox\_Theme [read only]
- **Theme\_Light** As AS\_CheckBox\_Theme [read only]
- **UncheckedBackgroundColor** As Int
- **UncheckedIconColor** As Int

[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-1.12"][/SPOILER][SPOILER="Version 1.0-1.12"][/SPOILER][SPOILER="Version 1.0-1.12"][/spoiler]**[SPOILER="Version 1.0-1.12"]  

- **1.00**

- Release

- **1.01**

- Add CheckedAnimated
- B4J BugFix Label Size was resizing if the font was to big

- **1.02**

- Add HapticFeedback

- **1.03**

- Checked was readonly

- **1.04**

- Add DisabledBackgroundColor property and designer property
- Add DisabledIconColor property and designer property
- Add Enable property - enable or disable the view

- ![](https://www.b4x.com/android/forum/attachments/103671)

- no animation if you change the checked state via code

- **1.05**

- B4I No Jump animation if the BorderCornerRadius > 0 (the radius cannot be held during animation, so it looks buggy when you have e.g. a circle)
- BugFix - Enabled = False, now the view is disabled, no touch gestures allowed

- **1.06**

- Intern Function IIF renamed to iif2

- **1.07**

- Add DesingerProperty Checked - if true then the checkbox is checked
- Add DesingerProperty Enabled - if false then the checkbox is disabled

- On B4A and B4J the core enabled property in the designer is not used anymore

- BugFixes
- Intern Function iif2 removed and the core iif is now used

- B4A V11+ - B4J V9.10+ - B4I V7.50+

- **1.08**

- BugFix - When creating the view the CheckedChange event was triggered with parameter "False"

- **1.09**

- Add Event property - If False then the CheckedChange event is not triggered

- **1.10**

- Base\_Resize is now public

- **1.11**

- Intern Improvements
- Add get and set IconColor

- **1.12**

- Add set Checked2 - Without the CheckedChange Event

[/SPOILER]  

- **2.00 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-checkbox.121878/post-1008664)**)**

- Add Designer Property FillUncheckedBackgroundColor
- Add Designer Property UncheckedBackgroundColor
- Add Designer Property UncheckedIconColor
- Add Designer Property Round

- Default: False

- Add set Theme
- Add get Theme\_Dark
- Add get Theme\_Light
- Add Designer Property ThemeChangeTransition

- Default: None

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)