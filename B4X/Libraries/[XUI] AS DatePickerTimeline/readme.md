###  [XUI] AS DatePickerTimeline by Alexander Stolte
### 02/20/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/140691/)

Date Picker Library that provides a calendar as a horizontal timeline.  
This library is inspired by [a Flutter library](https://pub.dev/packages/date_picker_timeline), but the B4X one is better ;)  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
The view has 2 modes:  

- Paging - you scroll page by page
- List - scrolling without snapping

![](https://www.b4x.com/android/forum/attachments/129406)  
[MEDIA=youtube]JMKWJoPLHBo[/MEDIA]  
  
![](https://www.b4x.com/android/forum/attachments/129427)  

```B4X
Private Sub AS_DatePickerTimeline1_CustomDrawDay (Date As Long, BackgroundPanel As B4XView)  
    Dim xlbl_Date As B4XView = BackgroundPanel.GetView(0)  
   
    'Month Name - January  
    Dim xlbl_Month As B4XView = BackgroundPanel.GetView(1) 'Ignore  
    'WeekDay Name - Monday  
    Dim xlbl_WeekDay As B4XView = BackgroundPanel.GetView(2) 'Ignore  
   
    If DateTime.GetDayOfWeek(Date) = 1 Then '1=Sunday  
        xlbl_Date.TextColor = xui.Color_ARGB(255,221, 95, 96)  
    End If  
End Sub
```

  
![](https://www.b4x.com/android/forum/attachments/129440)  
[Badge example](https://www.b4x.com/android/forum/threads/b4x-xui-as-datepickertimeline.140691/post-891301)  
  
Make sure you are using [ASViewPager](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/) V1.31+  
**ASDatePickerTimeline  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASDatePickerTimeline\_BodyProperties**

- **Fields:**

- **DateTextColor** As Int
- **DateTextFont** As B4XFont
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **MonthTextColor** As Int
- **MonthTextFont** As B4XFont
- **WeekDayTextColor** As Int
- **WeekDayTextFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASDatePickerTimeline\_MonthNameShort**

- **Fields:**

- **April** As String
- **August** As String
- **December** As String
- **February** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **January** As String
- **July** As String
- **June** As String
- **March** As String
- **May** As String
- **November** As String
- **October** As String
- **September** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASDatePickerTimeline\_SelectedDayProperties**

- **Fields:**

- **Color** As Int
- **CornerRadius** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASDatePickerTimeline\_WeekNameShort**

- **Fields:**

- **Friday** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Monday** As String
- **Saturday** As String
- **Sunday** As String
- **Thursday** As String
- **Tuesday** As String
- **Wednesday** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_DatePickerTimeline**

- **Events:**

- **SelectedDateChanged** (Date As Long)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **CreateASDatePickerTimeline\_BodyProperties** (DateTextColor As Int, DateTextFont As B4XFont, MonthTextColor As Int, MonthTextFont As B4XFont, WeekDayTextColor As Int, WeekDayTextFont As B4XFont) As ASDatePickerTimeline\_BodyProperties
- **CreateASDatePickerTimeline\_MonthNameShort** (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASDatePickerTimeline\_MonthNameShort
- **CreateASDatePickerTimeline\_SelectedDayProperties** (Color As Int, CornerRadius As Float) As ASDatePickerTimeline\_SelectedDayProperties
- **CreateASDatePickerTimeline\_WeekNameShort** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASDatePickerTimeline\_WeekNameShort
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBodyProperties** As ASDatePickerTimeline\_BodyProperties
*Call Refresh if you change something*- **getMonthNameShort** As ASDatePickerTimeline\_MonthNameShort
*Call Refresh if you change something*- **getSelectedDayProperties** As ASDatePickerTimeline\_SelectedDayProperties
- **getStartDate** As Long
- **getWeekNameShort** As ASDatePickerTimeline\_WeekNameShort
*Call Refresh if you change something*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextWeek** As String
- **PreviousWeek** As String
- **Refresh**
*Rebuilds the visible items*- **setFirstDayOfWeek** (number As Int) As String
*1-7  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **setStartDate** (StartDate As Long) As String

- **Properties:**

- **BodyProperties** As ASDatePickerTimeline\_BodyProperties [read only]
*Call Refresh if you change something*- **FirstDayOfWeek**
*1-7  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **MonthNameShort** As ASDatePickerTimeline\_MonthNameShort [read only]
*Call Refresh if you change something*- **SelectedDayProperties** As ASDatePickerTimeline\_SelectedDayProperties [read only]
- **StartDate** As Long
- **WeekNameShort** As ASDatePickerTimeline\_WeekNameShort [read only]
*Call Refresh if you change something*
[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-1.19"][/SPOILER][SPOILER="Version 1.0-1.19"][/SPOILER][SPOILER="Version 1.0-1.19"][/spoiler]**[SPOILER="Version 1.0-1.19"]  

- **1.00**

- Release

- **1.01**

- Add Event CustomDrawDay

- **1.02**

- Add new Type ASDatePickerTimeline\_CustomDrawDay
- **Breaking Change** on Event CustomDrawDay - The second parameter has changed to Views As ASDatePickerTimeline\_CustomDrawDay
- Add Designer Property CurrentDateColor
- Add Designer Property SelectedDateColor
- BugFixes

- **1.03**

- Add get and set SelectedDate
- Add Scroll2Date
- BugFixes

- **1.04**

- Add set MonthNameShort
- Add set WeekNameShort

- **1.05 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-datepickertimeline.140691/post-900750)**)**

- Add CustomDrawDay - You can make changes on one day without having to reload the entire week, with refresh

- **1.06**

- Function "Refresh" is now even better

- No visual flickering
- Changes are instant

- **1.07**

- Add get and set MaxDate - Will restrict date navigations features of forward, and also cannot swipe the control using touch gesture beyond the max date range
- Add get and set MinDate - Will restrict date navigations features of backward, and also cannot swipe the control using touch gesture beyond the max date range
- Add Rebuild - Clears the DatePicker and builds the DatePicker new

- **1.08**

- BugFix

- **1.09**

- BugFixes

- **1.10**

- BugFix

- **1.11**

- BugFixes

- **1.12**

- Add get and set Enabled - If False then click events and scroll (only on paging mode) is disabled

- **1.13**

- Scroll2Date BugFix

- **1.14**

- Add compatibility for [AS\_ViewPager](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/) Version 2.0

- **1.15**

- ListMode List

- Completely rewritten logic
- Each day now has its own slot, instead of always adding 1 week to the list
- MinDate and MaxDate can now be used in a more targeted manner

- **1.16 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-datepickertimeline.140691/post-946830)**)**

- Add Designer Property CreateMode - If you set it to Manual then you need to call CreateDatePicker

- **1.17**

- B4A BugFix

- **1.18**

- Add Event PageChanged

- **1.19**

- BugFix - The CustomDrawDayEvent is now also triggered when a different day is selected

- Old Day and New Day

[/SPOILER]  

- **1.20**

- BugFixes
- Add Designer Property SelectedDateTextColor
- Add Designer Property SelectedMonthTextColor
- Add Designer Property SelectedWeekDayTextColor
- Add Designer Property ThemeChangeTransition
- Add set Theme
- Add get Theme\_Light
- Add get Theme\_Dark

- **1.21**

- BugFix

- **1.22**

- BugFix If the selected day is recreated in LazyLoading, a crash occurs because a view was not initialized

- **1.23**

- BugFixes
- New get LoadingPanel

Github: <https://github.com/StolteX/AS_DatePickerTimeline>  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)