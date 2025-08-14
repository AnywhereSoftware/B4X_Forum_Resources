###  [XUI] AS WeekdaySelector by Alexander Stolte
### 08/06/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/168107/)

A custom B4X view for selecting weekdays – perfect for recurring events, reminders, or alarms.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/165823)  
  
**AS\_WeekdaySelector  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_WeekdaySelector**

- **Events:**

- **WeekDayClicked** (WeekDay As AS\_WeekdaySelector\_WeekDay, ClickState As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **BodyText\_DayOfMonth** As String
- **BodyText\_None** As String
- **BodyText\_WeekDay** As String
- **Clear**
- **CreateWeekNameLong** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As AS\_WeekdaySelector\_WeekNameLong
- **CreateWeekNameShort** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As AS\_WeekdaySelector\_WeekNameShort
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetFirstDayOfWeek2** (Ticks As Long, FirstDayOfWeek As Int) As Long
*FirstDayOfWeek:  
 1 = Sunday  
 2 = Monday  
 3 = Tuesday  
 4 = Wednesday  
 5 = Thursday  
 6 = Friday  
 7 = Saturday*- **GetWeekNameByIndex** (Index As Int) As String
*1 = Sunday*- **HeaderText\_DayOfMonth** As String
- **HeaderText\_None** As String
- **HeaderText\_WeekDay** As String
- **Initialize** (Callback As Object, EventName As String)
- **SelectWeekDay** (WeekDay As Int)

- **Properties:**

- **BodyText** As String
*<code>AS\_WeekdaySelector1.BodyText = AS\_WeekdaySelector1.BodyText\_DayOfMonth</code>*- **BodyTextColor** As Int
- **FirstClickColor** As Int
- **FirstDayOfWeek** As Int
*1-7  
 1 = Sunday  
 2 = Monday  
 3 = Tuesday  
 4 = Wednesday  
 5 = Thursday  
 6 = Friday  
 7 = Saturday*- **HeaderText** As String
*<code>AS\_WeekdaySelector1.HeaderText = AS\_WeekdaySelector1.HeaderText\_WeekDay</code>*- **HeaderTextColor** As Int
- **NormalColor** As Int
- **SecondClickColor** As Int
- **SelectedWeekDays** As List [read only]
- **Week** As Long
*Display Week*- **WeekNameLong** As AS\_WeekdaySelector\_WeekNameLong
*Call Refresh if you change something  
 <code>AS\_WeekdaySelector1.WeekNameLong = AS\_WeekdaySelector1.CreateWeekNameLong("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **WeekNameShort** As AS\_WeekdaySelector\_WeekNameShort
*Call Refresh if you change something  
 <code>AS\_WeekdaySelector1.WeekNameShort = AS\_WeekdaySelector1.CreateWeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")</code>*
**Changelog**  

- **1.00**

- Release

- **1.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-weekdayselector.168107/post-1030426)**)**

- New get and set BodySelectedTextColor
- New Themes - You can now switch to Light or Dark mode
- New set Theme
- New get Theme\_Dark
- New get Theme\_Light
- New Designer Property ThemeChangeTransition

- Default: None

- New ClearSelections
- New SelectWeekDay - Values are between 1 to 7, where 1 means sunday
- New SelectWeekDay2 - Selects the day of the week by date

**Github:** [github.com/StolteX/AS\_WeekdaySelector](https://github.com/StolteX/AS_WeekdaySelector)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)