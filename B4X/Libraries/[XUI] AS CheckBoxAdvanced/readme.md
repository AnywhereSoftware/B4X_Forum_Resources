###  [XUI] AS CheckBoxAdvanced by Alexander Stolte
### 12/08/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149025/)

This is a CheckBox library that can be displayed together with text. So you can now add checkboxes and text them even faster.  
If you want a standalone checkbox, then have a look at the [AS\_CheckBox](https://www.b4x.com/android/forum/threads/b4x-xui-as-checkbox.121878/) library.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
  
![](https://www.b4x.com/android/forum/attachments/143747)![](https://www.b4x.com/android/forum/attachments/143748)  
How the text should look like, you decide completely in the designer, under the "Label properties:  
![](https://www.b4x.com/android/forum/attachments/143749)  
or in the code:  

```B4X
AS_CheckboxAdvanced1.TextLabel.TextColor = xui.Color_Red
```

  
  
**AS\_CheckBoxAdvanced  
Author: Alexander Stolte  
Version: 2.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_CheckboxAdvanced**

- **Events:**

- **CheckedChange** (Checked As Boolean)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Base\_Resize** (Width As Double, Height As Double)
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String)
- **Refresh**
- **SetIcon** (icon As String, isfontawesome As Boolean)

- **Properties:**

- **BorderCornerRadius** As Int [write only]
- **BorderWidth** As Int [write only]
- **CheckBoxLabel** As B4XView [read only]
- **CheckBoxWidthHeight** As Float
*Call Refresh if you change this value*- **Checked** As Boolean
- **CheckedAnimated** As Boolean [write only]
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
- **Text** As String
- **TextLabel** As B4XView [read only]
- **Theme** As AS\_CheckBoxAdvanced\_Theme [write only]
- **Theme\_Dark** As AS\_CheckBoxAdvanced\_Theme [read only]
- **Theme\_Light** As AS\_CheckBoxAdvanced\_Theme [read only]
- **UncheckedBackgroundColor** As Int
- **UncheckedIconColor** As Int

[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- The checkbox is now also toggled when you click on the text

- **1.02**

- Add Designer Property CheckBox2TextGap - Gap between checkbox and text

- Default: 10dip

- **1.03**

- BugFixes and Improvements

- **2.00**

- Add get CheckBoxLabel - The checkbox label
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