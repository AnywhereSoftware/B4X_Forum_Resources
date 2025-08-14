###  AS WheelDateTimePicker - based on ASWheelPicker by Alexander Stolte
### 06/04/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/141588/)

This is a date and time picker in IOS picker design.  
  
**This library is based on the ASWheelPicker, without it the library will not work.**  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview-payware.127505/>  
  
 ![](https://www.b4x.com/android/forum/attachments/131112)[MEDIA=youtube]\_8ApxvqReVc[/MEDIA]  
  
**Use:**  

```B4X
AS_WheelDateTimePicker1.Create
```

  
**[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  
**AS\_WheelDateTimePicker  
Author: Alexander Stolte  
Version: 1.17**  

- **AS\_WheelDateTimePicker**

- **Events:**

- **CustomDrawItemChange** (NewItem As ASWheelPicker\_CustomDraw, OldItem As ASWheelPicker\_CustomDraw)
- **SelectedDateChanged** (Date As Long)
- **SelectedTimeChanged** (Hour As Int, Minute As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Create**
- **CreateASWheelDateTimePicker\_MonthName** (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASWheelDateTimePicker\_MonthName
- **CreateASWheelDateTimePicker\_MonthNameShort** (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASWheelDateTimePicker\_MonthNameShort
- **CreateASWheelDateTimePicker\_WeekNameShort** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASWheelDateTimePicker\_WeekNameShort
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String)
- **Refresh**
- **SetDateTextOrder** (WeekName As Int, MonthName As Int, DayOfMonth As Int)
*Weekname - Fri  
 Monthname - Jun  
 DayOfMonth - 19  
 Example:1,2,3 = Fri Jun 19  
 Example:2,1,3 = Jun Fri 19  
 Example:3,2,1 = 19 Jun Fri*
- **Properties:**

- **BackgroundColor** As Int
- **Date** As Long
- **DisabledTextColor** As Int
- **FadeColor** As Int
- **HapticFeedback** As Boolean
- **Hour** As Int
- **HourShortText** As String
- **MaxDate** As Long
- **MinDate** As Long
- **Minute** As Int
- **MinuteShortText** As String
- **MinuteSteps** As Int
- **MonthName** As ASWheelDateTimePicker\_MonthName
- **MonthNameShort** As ASWheelDateTimePicker\_MonthNameShort
- **PickerType** As String
*Call Refresh if you change something*- **PickerType\_DatePicker** As String [read only]
- **PickerType\_TimePicker** As String [read only]
- **SelectorColor** As Int
- **ShowAMPM** As Boolean
*Show the AM and PM column*- **ShowDate** As Boolean
*Show the date column in the TimePicker*- **ShowTimeDivider** As Boolean
*The separator between hour and minute is usually a colon ( : )*- **ShowTimeUnit** As Boolean
*Display time unit (12hour 05 min) can be changed with the HourShort and MinuteShort property*- **TextColor** As Int
- **Theme** As AS\_WheelDateTimePicker\_Theme [write only]
- **Theme\_Dark** As AS\_WheelDateTimePicker\_Theme [read only]
- **Theme\_Light** As AS\_WheelDateTimePicker\_Theme [read only]
- **ThemeChangeTransition** As String
*Fade or None*- **ThemeChangeTransition\_Fade** As String [read only]
- **ThemeChangeTransition\_None** As String [read only]
- **TodayText** As String
*Call Refresh if you change something*- **WeekNameShort** As ASWheelDateTimePicker\_WeekNameShort
- **WheelPicker** As ASWheelPicker [read only]

[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-1.16"][/SPOILER][SPOILER="Version 1.0-1.16"][/SPOILER][SPOILER="Version 1.0-1.16"][/spoiler]**[SPOILER="Version 1.0-1.16"]  

- **1.00**

- Release

- **1.01**

- BugFixes

- **1.02**

- Add set Hour
- Add set Minute
- Add set Date

- **1.03**

- Add Refresh

- **1.04**

- BugFixes
- PickerType = DatePicker - The days in the month now adjust automatically
- Add Designer Property TextColor
- Add Designer Property FadeColor
- Add Designer Property HapticFeedback

- **1.05**

- Add Designer Property TodayText

- Default: Today

- Add get and set TodayText - Call Refresh if you change something

- **1.06**

- BugFixes

- **1.07**

- BugFixes - AM and PM mode works now as expected
- BugFixes - setDate Number of days is now adjusted

- **1.08**

- Add get and set FadeColor
- Add get and set TextColor
- Add get and set SelectorColor
- Add get and set BackgroundColor
- MonthName now comes from the DateUtils

- **1.09**

- BugFixes

- **1.10**

- BugFixes

- **1.11**

- Add Designer Property MinuteSteps - 1-5-10-15 Block Interval

- Default: False

- **1.12**

- BugFixes

- **1.13**

- Add get WheelPicker - gets the wheelpicker to modify font etc.

- **1.14 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-as-wheeldatetimepicker-based-on-aswheelpicker.141588/post-945219)**)**

- You need AS\_WheelPicker V3.15+ for this update
- If a month has 30 or 28 days, then these are now no longer removed from the list, but the new EnabledRow is used and the affected items are deactivated.

- This prevents the list from behaving in an unusual way.

- Add MinDate and MaxDate - You can specify a DateRange what may be selected

- **1.15**

- You need AS\_WheelPicker V3.20+
- Breaking Change: You need to call Create

- The view will not be built without it
- Now you can make changes to the proepties without calling refresh at the beginning
- Faster loading time
- No crashes

- Add SetDateTextOrder - You can change the text order of the date text
- BugFixes
- Add Event CustomDrawItemChange

- **1.16**

- New Themes - You can now switch to Light or Dark mode

- New set Theme
- New get Theme\_Dark
- New get Theme\_Light

- New Designer Property ThemeChangeTransition

- Default: Fade

[/SPOILER]  

- **1.17**

- New all designer properties, now as get and set too
- New designer property descriptions
- BugFixes

- **1.18**

- B4A BugFix

- **1.19**

- Adjustments for [AS\_WheelPicker V3.25](https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview-payware.127505/)

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)