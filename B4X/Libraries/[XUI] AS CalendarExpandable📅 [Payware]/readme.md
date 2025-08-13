###  [XUI] AS CalendarExpandable📅 [Payware] by Alexander Stolte
### 05/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/146808/)

This view was developed from scratch based on the [AS\_DatePicker](https://www.b4x.com/android/forum/threads/b4x-xui-as-datepicker-fast-navigate-to-a-month-year-decade-century-rangedatepicker.139957/) and the AS\_CalendarViewWeek from the [AS\_Scheduler](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/). Both combined results in a fantastic new view.  
  
**Those who have already purchased** [**AS\_CalendarAdvanced**](https://www.b4x.com/android/forum/threads/b4x-xui-as-calendaradvanced-%F0%9F%93%85-onerow-fiverow-calendar-expand-and-collapse-payware.128809/) **can use the same key to use this library.**  
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
<https://payhip.com/b/dq0uS>  
Thanks for your understanding. :)  
  
The calendar can be **collapsed** and **expanded**  
![](https://www.b4x.com/android/forum/attachments/140277)  
![](https://www.b4x.com/android/forum/attachments/140276)  
3 Types of Appointments  
**AppointmentType\_1**  
![](https://www.b4x.com/android/forum/attachments/140278)  
**AppointmentType\_2**  
![](https://www.b4x.com/android/forum/attachments/140279)  
**AppointmentType\_3**  
![](https://www.b4x.com/android/forum/attachments/140280)  
[MEDIA=youtube]2HchBfgf4Fk[/MEDIA]  
  
Make sure you are using [ASViewPager](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/) V2.02+  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,jDateUtils,ASViewPager  
**B4a**: XUi,DateUtils,ASViewPager  
**B4i**: iXUI,iDateUtils,ASViewPager  
[/SPOILER]  
**AS\_CalendarExpandable  
Author: Alexander Stolte  
Version: 1.00**  
[SPOILER="Properties, Functions, Events, etc."]  

- **ASCalendarExpandable\_AppointmentType1**

- **Fields:**

- **Color** As Int
- **Date** As Long
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_AppointmentType1\_ItemProperties**

- **Fields:**

- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Padding** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_AppointmentType2**

- **Fields:**

- **Color** As Int
- **Date** As Long
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Text** As String
- **TextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_AppointmentType2\_ItemProperties**

- **Fields:**

- **CornerRadius** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Padding** As Float
- **TextAlignment\_Horizontal** As String
- **xfont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_AppointmentType3**

- **Fields:**

- **Color** As Int
- **EndDate** As Long
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **StartDate** As Long

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_AppointmentType3\_ItemProperties**

- **Fields:**

- **AlphaColor** As Int
- **CornerRadius** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_BodyProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_CustomDrawDay**

- **Fields:**

- **BackgroundPanel** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_Date** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_HeaderProperties**

- **Fields:**

- **ButtonIconSize** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASCalendarExpandable\_MonthNameShort**

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
- **ASCalendarExpandable\_WeekNameShort**

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
- **ASCalendarExpandable\_WeekNumberProperties**

- **Fields:**

- **Color** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Text** As String
- **TextColor** As Int
- **Width** As Float
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_CalendarExpandable**

- **Events:**

- **CustomDrawDay\_MonthView** (Date As Long, Views As ASCalendarExpandable\_CustomDrawDay)
- **CustomDrawDay\_WeekView** (Date As Long, Views As ASCalendarExpandable\_CustomDrawDay)
- **SelectedDateChanged** (Date As Long)
- **SelectedDateRangeChanged** (StartDate As Long, EndDate As Long)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Add\_AppointmentType1** (Date As Long, Color As Int) As String
*Call Refresh if you add something*- **Add\_AppointmentType2** (Date As Long, Color As Int, Text As String, TextColor As Int) As String
*Call Refresh if you add something*- **Add\_AppointmentType3** (StartDate As Long, EndDate As Long, Color As Int) As String
*Call Refresh if you add something*- **AppointmentsReset** As String
- **ChangeView** (NewView As String) As String
*<code>AS\_CalendarExpandable1.ChangeView(AS\_CalendarExpandable1.CurrentView\_YearView)</code>*- **Class\_Globals** As String
- **Close** As String
- **CreateAppointmentType1** (Date As Long, xpnl\_Date As B4XView) As String
- **CreateAppointmentType2** (Date As Long, xpnl\_Date As B4XView) As String
- **CreateAppointmentType3** (Appointment As ASCalendarExpandable\_AppointmentType3, xpnl\_Appointments\_Type3 As B4XView) As String
- **CreateASCalendarExpandable\_AppointmentType1** (Date As Long, Color As Int) As ASCalendarExpandable\_AppointmentType1
- **CreateASCalendarExpandable\_AppointmentType1\_ItemProperties** (Height As Float, Padding As Float) As ASCalendarExpandable\_AppointmentType1\_ItemProperties
- **CreateASCalendarExpandable\_AppointmentType2** (Date As Long, Color As Int, Text As String, TextColor As Int) As ASCalendarExpandable\_AppointmentType2
- **CreateASCalendarExpandable\_AppointmentType2\_ItemProperties** (xfont As B4XFont, Height As Float, Padding As Float, CornerRadius As Float, TextAlignment\_Horizontal As String) As ASCalendarExpandable\_AppointmentType2\_ItemProperties
- **CreateASCalendarExpandable\_AppointmentType3** (StartDate As Long, EndDate As Long, Color As Int) As ASCalendarExpandable\_AppointmentType3
- **CreateASCalendarExpandable\_AppointmentType3\_ItemProperties** (Height As Float, AlphaColor As Int, CornerRadius As Float) As ASCalendarExpandable\_AppointmentType3\_ItemProperties
- **CreateASCalendarExpandable\_BodyProperties** (xFont As B4XFont, TextColor As Int) As ASCalendarExpandable\_BodyProperties
- **CreateASCalendarExpandable\_CustomDrawDay** (BackgroundPanel As B4XView, xlbl\_Date As B4XView) As ASCalendarExpandable\_CustomDrawDay
- **CreateASCalendarExpandable\_HeaderProperties** (Height As Float, xFont As B4XFont, TextColor As Int, ButtonIconSize As Float) As ASCalendarExpandable\_HeaderProperties
- **CreateASCalendarExpandable\_MonthNameShort** (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASCalendarExpandable\_MonthNameShort
- **CreateASCalendarExpandable\_WeekNameShort** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASCalendarExpandable\_WeekNameShort
- **CreateASCalendarExpandable\_WeekNumberProperties** (Width As Float, Color As Int, xFont As B4XFont, TextColor As Int, Text As String) As ASCalendarExpandable\_WeekNumberProperties
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Expand** As String
- **getAppointmentType1** As List
- **getAppointmentType1\_ItemProperties** As ASCalendarExpandable\_AppointmentType1\_ItemProperties
- **getAppointmentType2** As List
- **getAppointmentType2\_ItemProperties** As ASCalendarExpandable\_AppointmentType2\_ItemProperties
- **getAppointmentType3** As List
- **getAppointmentType3\_ItemProperties** As ASCalendarExpandable\_AppointmentType3\_ItemProperties
- **getBodyColor** As Int
- **getBodyProperties** As ASCalendarExpandable\_BodyProperties
- **getCurrentDateColor** As Int
- **getCurrentView** As String
- **getCurrentView\_CenturyView** As String
- **getCurrentView\_DecadeView** As String
- **getCurrentView\_MonthView** As String
- **getCurrentView\_YearView** As String
- **getDragPanelColor** As Int
- **getDragPanelIndicatorColor** As Int
- **getFirstDayOfWeek** As Int
- **GetFirstDayOfWeek2** (Ticks As Long, FirstDayOfWeek As Int) As Long
*FirstDayOfWeek:  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **getGridLineColor** As Int
- **getHeaderColor** As Int
- **getHeaderProperties** As ASCalendarExpandable\_HeaderProperties
- **getInactiveDaysVisible** As Boolean
- **getMaxDate** As Long
- **getMinDate** As Long
- **GetMonthNameByIndex** (index As Int) As String
- **getMonthNameShort** As ASCalendarExpandable\_MonthNameShort
*Call Refresh if you change something  
 <code>AS\_DatePicker1.MonthNameShort = AS\_DatePicker1.CreateASCalendarExpandable\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **getMouseHoverFeedback** As Boolean
- **getSelectedDate** As Long
- **getSelectedDateColor** As Int
- **getSelectedEndDate** As Long
*Only in SelectMode "Range"*- **getSelectedStartDate** As Long
- **getSelectMode** As String
- **getSelectMode\_Day** As String
- **getSelectMode\_Month** As String
- **getSelectMode\_Range** As String
- **getShowGridLines** As Boolean
- **getShowWeekNumbers** As Boolean
*Gets or sets the number of visible weeks  
 Call Refresh to commit changes*- **getStartDate** As Long
- **GetWeekNameByIndex** (Index As Int) As String
*1 = Sunday*- **getWeekNameHeight** As Float
- **getWeekNameShort** As ASCalendarExpandable\_WeekNameShort
- **getWeekNumberProperties** As ASCalendarExpandable\_WeekNumberProperties
*Call Refresh if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*- **GetWeekNumberStartingFromMonday** (ticks As Long) As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **MonthBetween** (Date1 As Long, Date2 As Long) As Int
 *Compute month between 2 dates  
 Version: 1, ( ) WIP (X) Release  
 Prior set DateTime.DateFormat  
 Date1/2: Date formatted DateTime.DateFormat  
 Return: mont - 0 if same month*- **NumberOfWeeksBetween** (StartDate As Long, EndDate As Long) As Int
- **Rebuild** As String
- **Refresh** As String
- **RefreshHeader** As String
- **Remove\_Appointment** (TypeNumber As Int, Date As Long, RemoveAll As Boolean) As String
*Call Refresh if you remove something  
 TypeNumber: 1,2 or 3  
 RemoveAll: If true, then remove all appointments on this date*- **setAppointmentType1\_ItemProperties** (ItemProperties As ASCalendarExpandable\_AppointmentType1\_ItemProperties) As String
- **setAppointmentType2\_ItemProperties** (ItemProperties As ASCalendarExpandable\_AppointmentType2\_ItemProperties) As String
- **setAppointmentType3\_ItemProperties** (ItemProperties As ASCalendarExpandable\_AppointmentType3\_ItemProperties) As String
- **setBodyColor** (Color As Int) As String
- **setBodyProperties** (BodyProperties As ASCalendarExpandable\_BodyProperties) As String
- **setCurrentDateColor** (Color As Int) As String
- **setCurrentView** (CurrentView As String) As String
- **setDragPanelColor** (Color As Int) As String
- **setDragPanelIndicatorColor** (Color As Int) As String
- **setFirstDayOfWeek** (number As Int) As String
*1-7  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **setGridLineColor** (Color As Int) As String
- **setHeaderColor** (Color As Int) As String
- **setHeaderProperties** (HeaderProperties As ASCalendarExpandable\_HeaderProperties) As String
- **setInactiveDaysVisible** (Visible As Boolean) As String
- **setMaxDate** (MaxDate As Long) As String
*Will restrict date navigations features of forward, and also cannot swipe the control using touch gesture beyond the max date range*- **setMinDate** (MinDate As Long) As String
*Will restrict date navigations features of backward, also cannot swipe the control using touch gesture beyond the min date range*- **setMonthNameShort** (MonthNameShort As ASCalendarExpandable\_MonthNameShort) As String
- **setMouseHoverFeedback** (Feedback As Boolean) As String
- **setSelectedDate** (Date As Long) As String
- **setSelectedDateColor** (Color As Int) As String
- **setSelectedEndDate** (Date As Long) As String
- **setSelectedStartDate** (Date As Long) As String
- **setSelectMode** (Mode As String) As String
- **setShowGridLines** (Show As Boolean) As String
- **setShowWeekNumbers** (Show As Boolean) As String
- **setStartDate** (Date As Long) As String
- **setWeekNameHeight** (Height As Float) As String
- **setWeekNameShort** (WeekNameShort As ASCalendarExpandable\_WeekNameShort) As String
*Call Refresh if you change something  
 <code>AS\_DatePicker1.CreateASCalendarExpandable\_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")</code>*- **setWeekNumberProperties** (WeekNumberProperties As ASCalendarExpandable\_WeekNumberProperties) As String

- **Properties:**

- **AppointmentType1** As List [read only]
- **AppointmentType1\_ItemProperties** As ASCalendarExpandable\_AppointmentType1\_ItemProperties
- **AppointmentType2** As List [read only]
- **AppointmentType2\_ItemProperties** As ASCalendarExpandable\_AppointmentType2\_ItemProperties
- **AppointmentType3** As List [read only]
- **AppointmentType3\_ItemProperties** As ASCalendarExpandable\_AppointmentType3\_ItemProperties
- **BodyColor** As Int
- **BodyProperties** As ASCalendarExpandable\_BodyProperties
- **CurrentDateColor** As Int
- **CurrentView** As String
- **CurrentView\_CenturyView** As String [read only]
- **CurrentView\_DecadeView** As String [read only]
- **CurrentView\_MonthView** As String [read only]
- **CurrentView\_YearView** As String [read only]
- **DragPanelColor** As Int
- **DragPanelIndicatorColor** As Int
- **FirstDayOfWeek** As Int
*1-7  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **GridLineColor** As Int
- **HeaderColor** As Int
- **HeaderProperties** As ASCalendarExpandable\_HeaderProperties
- **InactiveDaysVisible** As Boolean
- **MaxDate** As Long
*Will restrict date navigations features of forward, and also cannot swipe the control using touch gesture beyond the max date range*- **MinDate** As Long
*Will restrict date navigations features of backward, also cannot swipe the control using touch gesture beyond the min date range*- **MonthNameShort** As ASCalendarExpandable\_MonthNameShort
*Call Refresh if you change something  
 <code>AS\_DatePicker1.MonthNameShort = AS\_DatePicker1.CreateASCalendarExpandable\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **MouseHoverFeedback** As Boolean
- **SelectedDate** As Long
- **SelectedDateColor** As Int
- **SelectedEndDate** As Long
*Only in SelectMode "Range"*- **SelectedStartDate** As Long
- **SelectMode** As String
- **SelectMode\_Day** As String [read only]
- **SelectMode\_Month** As String [read only]
- **SelectMode\_Range** As String [read only]
- **ShowGridLines** As Boolean
- **ShowWeekNumbers** As Boolean
*Gets or sets the number of visible weeks  
 Call Refresh to commit changes*- **StartDate** As Long
- **WeekNameHeight** As Float
- **WeekNameShort** As ASCalendarExpandable\_WeekNameShort
*Call Refresh if you change something  
 <code>AS\_DatePicker1.CreateASCalendarExpandable\_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")</code>*- **WeekNumberProperties** As ASCalendarExpandable\_WeekNumberProperties
*Call Refresh if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add get and set WeekNameProperties

- **1.02**

- Add Scroll2Date

- **1.03**

- B4I BugFix

- **1.04**

- BugFix

- **1.05**

- BugFixes

- **1.06**

- BugFixes

- **1.07**

- In WeekView, the year gap is now only 2 years, instead of 5

- **1.08**

- Add Event HeightChanged

- **1.09**

- BugFixes
- Performance Improvements

- **1.10**

- BugFixes

- **1.11**

- Add Event PageChanged
- Add get CurrentMonthWeek
- BugFixes

- **1.12**

- Add get MonthView
- Add get WeekView
- Add Event CustomDrawHeader
- BugFixes

- **1.13**

- BugFixes and Improvements
- Add get Theme\_Dark
- Add get Theme\_Light
- Add Designer Property ThemeChangeTransition

- Default: Fade

- Add "SelectedTextColor" to ASCalendarExpandable\_BodyProperties

- Default: White

- **1.14**

- **Breaking change**- GetFirstDayOfWeek2 First day of week is now 1=sunday, 2=monday and so on

- old: 1=friday, 2 = thursday and so on…

- **Breaking change**- setFirstDayOfWeek First day of week is now 1=sunday, 2=monday and so on

- old: 1=friday, 2 = thursday and so on…

- Change - If you change the 1st day of the week, you no longer have to change the text order, you can leave the text as it is

- **1.15**

- BugFixes

Have Fun :)  
<https://payhip.com/b/dq0uS>