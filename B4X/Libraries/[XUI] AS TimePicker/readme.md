###  [XUI] AS TimePicker by Alexander Stolte
### 01/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/140084/)

This is a simple TimePicker, with android style.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/128364)![](https://www.b4x.com/android/forum/attachments/128414)![](https://www.b4x.com/android/forum/attachments/128415)  
**Events**  

- SelectedHourChanged and SelectedMinuteChanged

- This event is triggered every time the pointer moves

- SelectedHour and SelectedMinute

- This event is triggered when you release the pointer

- SelectionDone

- This event is triggered when an hour and minute is selected

**Designer Properties**  

- AutoSwitch

- If True then automatically switches to minutes when the user releases the clock during hour selection

- MinuteSteps

- Indicates in how many steps the selector can be moved
- Example: 5 = the pointer only moves in 5 minute increments

- TimeFormat

- If 24h then 2 rows are displayed
- If 12h just 1 row are visible

<https://www.b4x.com/android/forum/threads/b4x-xui-as-timepickerdialog-based-on-b4xdialog-and-as_timepicker.149354/>  
![](https://www.b4x.com/android/forum/attachments/146863)  
**ASTimePicker  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_TimerPicker**

- **Events:**

- **SelectedHour** (Hour As Int)
- **SelectedHourChanged** (Hour As Int)
- **SelectedMinute** (Minute As Int)
- **SelectedMinuteChanged** (Minute As Int)
- **SelectionDone** (Hour As Int, Minute As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **getAutoSwitch** As Boolean
- **getBackgroundColor** As Int
- **getCurrentMode\_HourSelection** As String
- **getCurrentMode\_MinuteSelection** As String
- **getMinuteSteps** As Int
- **getTextColor** As Int
- **getThumbColor** As Int
- **getThumbLineColor** As Int
- **getTimeFormat** As String
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Refresh** As String
- **setAutoSwitch** (Auto As Boolean) As String
- **setBackgroundColor** (Color As Int) As String
- **setCurrentMode** (Mode As String) As String
- **setMinuteSteps** (Steps As Int) As String
- **setTextColor** (Color As Int) As String
- **setThumbColor** (Color As Int) As String
- **setThumbLineColor** (Color As Int) As String
- **setTimeFormat** (Format As String) As String

- **Properties:**

- **AutoSwitch** As Boolean
- **BackgroundColor** As Int
- **CurrentMode**
- **CurrentMode\_HourSelection** As String [read only]
- **CurrentMode\_MinuteSelection** As String [read only]
- **MinuteSteps** As Int
- **TextColor** As Int
- **ThumbColor** As Int
- **ThumbLineColor** As Int
- **TimeFormat** As String

**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFixes

- **1.02 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepicker.140084/post-888578)**)**

- BugFixes
- Add get and set Hours
- Add get and set Minutes

- **1.03 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepicker.140084/post-888601)**)**

- Add SmoothModeChange - Fade in mode change

- **1.04**

- 12h Format now has a 12 at the top

- **1.05**

- BugFix

- **1.06**

- BugFix

- **1.07**

- Add get CurrentMode

- **1.08**

- BugFixes
- Visual Improvements
- The Thumb is now behind the Text, so you can now use thumb colors with full alpha
- Add get and set FontSize

- Default: 15

- Add get and set SecondRowGap

- Default: 5dip

- **1.09**

- BugFix

- **1.10**

- BugFix in set Hours

- **1.11**

- B4A BugFix

**Github:** [github.com/StolteX/AS\_TimePicker](https://github.com/StolteX/AS_TimePicker)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)