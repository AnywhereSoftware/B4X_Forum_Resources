###  [XUI] AS Scheduler 📅 - MonthView, DayView (Week), AgendaView and CalendarView [Payware] by Alexander Stolte
### 03/04/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/138410/)

The AS Scheduler is a B4X library for displaying and interacting with appointments.  
  
You want to try the views out? Then click [here](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/#post-876275)  
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
<https://payhip.com/b/nrtw5>  
Thanks for your understanding. :)  
  
![](https://www.b4x.com/android/forum/attachments/162238)  
  
The project was divided into modules.  

- Views

- ASScheduler\_DayView
- ASScheduler\_MonthView
- ASScheduler\_AgendaView
- ASScheduler\_CalendarViewMonth
- ASScheduler\_CalendarViewWeek

- Classes

- ASSchedulerAPI
- ASSchedulerInternShared

- Modules

- ASSchedulerUtils

![](https://www.b4x.com/android/forum/attachments/125440)  
**All Features of the DayView:**  
<https://www.b4x.com/android/forum/threads/b4x-as-scheduler-dayview.157770/>  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,jDateUtils,xCustomListView,ASViewPager,jSQL  
**B4a**: XUi,DateUtils,Reflection,xCustomListView,ASViewPager,SQL  
**B4i**: iXUI,iDateUtils,xCustomListView,ASViewPager,iSQL  
[/SPOILER]  
Make sure you are using [ASViewPager](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/) V1.31+  
On B4I you need [GestureRecognizer](https://www.b4x.com/android/forum/threads/gesturerecognizer-native-uigesturerecognizer.52836/) Download the .bas file in the attachment **No longer needed since 1.16+  
  
ASScheduler  
Author: Alexander Stolte  
Version: 3.00**  
[SPOILER="Properties, Functions, Events, etc."]  

- **ASSchedulerAPI**

- **Functions:**

- **Class\_Globals** As String
- **ClearAppointments** As String
*Deletes all Appointments*- **ClearBlackouts** As String
*Deletes all Blackouts*- **ClearSpecialDays** As String
*Deletes all SpecialDays*- **CreateAppointment** (Appointment As ASScheduler\_Appointment) As ASScheduler\_Appointment
*Creates a new Appointment  
 <code>ASScheduler\_DayView1.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler\_Appointment(0,"Test Item 1",xui.Color\_ARGB(255,45, 136, 121),False,DateTime.now,DateTime.now+DateTime.TicksPerHour))</code>  
 <code>ASScheduler\_DayView1.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler\_AppointmentRecurring(0,"Test Item 1",xui.Color\_ARGB(255,45, 136, 121),False,DateTime.now,DateTime.now+DateTime.TicksPerHour,True,"week",1))</code>*- **CreateBlackout** (Blackout As ASScheduler\_Blackout) As String
*Create a new Blackout  
 <code>ASScheduler\_DayView1.API.CreateBlackout(ASSchedulerUtils.CreateASScheduler\_Blackout(0,DateTime.Now+(DateTime.TicksPerDay\*2),DateTime.Now+(DateTime.TicksPerDay\*2)))'2 days </code>*- **CreateSpecialDay** (SpecialDay As ASScheduler\_SpecialDay) As ASScheduler\_SpecialDay
- **DeleteAppointment** (Id As Int) As String
*Removes an Appointment*- **DeleteBlackout** (Id As Int) As String
*Removes an Appointment*- **DeleteSpecialDa** (Id As Int) As String
- **GetAppointment** (Id As Int) As ASScheduler\_Appointment
*Get a Appointment*- **GetAppointmentCount** As Int
*Gets the count of all Appointments*- **GetAppointmentCountInRange** (StartDate As Long, EndDate As Long, DurationLongerThanOneDay As Boolean) As Int
*Gets the Appointments count from StartDate to EndDate  
 The time value is set to 0 o'clock on StartDate and at the EndDate to 23:59  
 If DurationLongerThanOneDay = True then it counts only the appointments that go longer than 1 day*- **GetAppointmentCountOnOneDay** (Date As Long) As Int
- **GetAppointments** (Date As Long) As List
*Gets all appointments on that Date  
 Returns a List of ASScheduler\_Appointment objects*- **GetCustomQuery** (Columns As String, Table As String, Where As String, Args As String()) As ResultSet
*The table structure you find here  
<code>[https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-?-monthview-and-dayview-week-payware.138410/post-876274](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-and-dayview-week-payware.138410/post-876274)</code>  
 If you dont need a where, just put a "" to the string*- **GetDateSpecialDay** (Date As Long) As ASScheduler\_SpecialDay
- **GetIsDayBlackout** (Date As Long) As Boolean
*Checks if there is a blackout on that day*- **getSQL** As SQL
- **Initialize** (sql As SQL) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **UpdateAppointment** (Appointment As ASScheduler\_Appointment) As ASScheduler\_Appointment
- **UpdateSpecialDay** (SpecialDay As ASScheduler\_SpecialDay) As ASScheduler\_SpecialDay

- **Properties:**

- **SQL** As SQL [read only]

- **ASSchedulerInternShared**

- **Fields:**

- **SQL** As SQL

- **Functions:**

- **CreateAppointment** (Parent As B4XView, Appointment As ASScheduler\_Appointment, CurrentDay As Long, g\_AppointmentProperties As ASScheduler\_MonthView\_AppointmentProperties) As String
- **CreateASScheduler\_MonthView\_AppointmentProperties** (Height As Float, Gap As Float, LeftRightGap As Float, CornerRadius As Float, xFont As B4XFont, TextColor As Int) As ASScheduler\_MonthView\_AppointmentProperties
- **CreateASScheduler\_MonthView\_BlackoutProperties** (Width As Float, Color As Int, GapBetween As Float) As ASScheduler\_MonthView\_BlackoutProperties
- **CreateHeaderItem** (Text As String, HeaderTextProperties As ASScheduler\_MonthView\_HeaderTextProperties) As B4XView
- **CreateHiddenAppointments** (Parent As B4XView, Text As String, ListOfHiddenAppointments As List, g\_AppointmentProperties As ASScheduler\_MonthView\_AppointmentProperties, DividerSize As Float) As String
*+3 More Appointments, but not visible*- **GetARGB** (Color As Int) As Int()
- **GetDisplayDuration** (StartTime As Long, EndTime As Long) As String
- **GetMonthNameByIndex** (Index As Int, MonthNameShort As ASScheduler\_MonthNameShort) As String
*1 = January*- **GetWeekNameByIndex** (Index As Int, WeekNameShort As ASScheduler\_WeekNameShort) As String
*1 = Sunday*- **Initialize** As String
- **Process\_Globals** As String

- **ASSchedulerUtils**

- **Functions:**

- **API** As ASSchedulerAPI
*Global Scheduler API Access*- **ConvertSameDateTimeTicks2SameDateTicks** (ticks As Long) As Long
- **CreateASScheduler\_Appointment** (Id As Int, Name As String, Description As String, Color As Int, isFullDay As Boolean, StartDate As Long, EndDate As Long) As ASScheduler\_Appointment
*Id -The appointment ID, set this to 0 if you want to create an appointment*- **CreateASScheduler\_AppointmentRecurring** (Id As Int, Name As String, Description As String, Color As Int, isFullDay As Boolean, StartDate As Long, EndDate As Long, isRecurring As Boolean, RecurringUnit As String, RecurringInterval As Int) As ASScheduler\_Appointment
*Id -The appointment ID, set this to 0 if you want to create an appointment  
 isRecurring - If True then the appointment will be recurring  
 RecurringUnit - day - week - month - year are valid  
 Use ASSchedulerUtils.Recurring\_Day for the RecurringUnits*- **CreateASScheduler\_Blackout** (Id As Int, StartDate As Long, EndDate As Long) As ASScheduler\_Blackout
- **CreateASScheduler\_HeatMapColor** (Color As Int, Count As Int, TextColor As Int) As ASScheduler\_HeatMapColor
- **CreateASScheduler\_MonthNameShort** (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASScheduler\_MonthNameShort
- **CreateASScheduler\_SpecialDay** (Id As Int, Name As String, Date As Long) As ASScheduler\_SpecialDay
*Id -The appointment ID, set this to 0 if you want to create an special day*- **CreateASScheduler\_SpecialDayRecurring** (Id As Int, Name As String, Date As Long, isRecurring As Boolean, RecurringUnit As String, RecurringInterval As Int, isAlways As Boolean) As ASScheduler\_SpecialDay
*Id -The appointment ID, set this to 0 if you want to create an special day  
 isRecurring - If True then the appointment will be recurring  
 RecurringUnit - day - week - month - year are valid  
 Use ASSchedulerUtils.Recurring\_Day for the RecurringUnits*- **CreateASScheduler\_WeekNameShort** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASScheduler\_WeekNameShort
- **FillWithDiagonallyDrawnLines** (Target As B4XView, Thickness As Float, Color As Int) As String
- **FillWithDiagonallyDrawnLines2** (Target As B4XView, Thickness As Float, GapBetween As Float, Color As Int) As String
- **GetARGB** (Color As Int) As Int()
- **GetDaysBetween2Dates** (StartDate As Long, EndDate As Long, RequiredDayOfWeek As Int) As List
*RequiredDayOfWeek - week starts at 1=sunday,2=monday…  
 Call it if you are done adding new special days, makes this way makes the performance better*- **GetFirstDayOfWeek2** (Ticks As Long, FirstDayOfWeek As Int) As Long
*FirstDayOfWeek:  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **GetWeekNumberStartingFromMonday** (ticks As Long) As Int
- **NumberOfWeeksBetween** (StartDate As Long, EndDate As Long) As Int
- **Process\_Globals** As String
- **Recurring\_Day** As String
- **Recurring\_Month** As String
- **Recurring\_Week** As String
- **Recurring\_Year** As String
- **TimeSystem\_12h** As String
- **TimeSystem\_24h** As String
- **WeekDay\_Friday** As Int
- **WeekDay\_Monday** As Int
- **WeekDay\_Saturday** As Int
- **WeekDay\_Sunday** As Int
- **WeekDay\_Thursday** As Int
- **WeekDay\_Tuesday** As Int
- **WeekDay\_Wednesday** As Int

- **ASScheduler\_AgendaView**

- **Events:**

- **AppointmentClick** (Appointment As ASScheduler\_Appointment)
- **AppointmentDoubleClick** (Appointment As ASScheduler\_Appointment)
- **CustomDrawEmptyState** (StartDate As Long, BackgroundPanel As B4XView)
- **CustomDrawMonth** (StartDate As Long, BackgroundPanel As B4XView)
- **CustomDrawWeek** (StartDate As Long, BackgroundPanel As B4XView)
- **MonthClick** (StartDate As Long)
- **WeekClick** (StartDate As Long)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **CreateASScheduler\_AgendaView\_AppointmentDayOfMonthProperties** (xFont As B4XFont, TextColor As Int) As ASScheduler\_AgendaView\_AppointmentDayOfMonthProperties
- **CreateASScheduler\_AgendaView\_AppointmentProperties** (Height As Float, Gap As Float, CornerRadius As Float, xFont As B4XFont, TextColor As Int, ShowStartEndTime As Boolean, ShowDuration As Boolean) As ASScheduler\_AgendaView\_AppointmentProperties
- **CreateASScheduler\_AgendaView\_AppointmentWeekDayProperties** (xFont As B4XFont, TextColor As Int) As ASScheduler\_AgendaView\_AppointmentWeekDayProperties
- **CreateASScheduler\_AgendaView\_EmptyStateProperties** (xFont As B4XFont, TextColor As Int, Height As Float, BackgroundColor As Int, EmptyText As String) As ASScheduler\_AgendaView\_EmptyStateProperties
- **CreateASScheduler\_AgendaView\_MonthProperties** (xFont As B4XFont, TextColor As Int, Height As Float, BackgroundColor As Int) As ASScheduler\_AgendaView\_MonthProperties
- **CreateASScheduler\_AgendaView\_TimelineProperties** (Width As Float) As ASScheduler\_AgendaView\_TimelineProperties
- **CreateASScheduler\_AgendaView\_WeekProperties** (xFont As B4XFont, TextColor As Int, Height As Float, BackgroundColor As Int) As ASScheduler\_AgendaView\_WeekProperties
- **CreateScheduler**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getAPI** As ASSchedulerAPI
*Gets the API*- **getAppointmentDayOfMonthProperties** As ASScheduler\_AgendaView\_AppointmentDayOfMonthProperties
- **getAppointmentProperties** As ASScheduler\_AgendaView\_AppointmentProperties
- **getAppointmentWeekDayProperties** As ASScheduler\_AgendaView\_AppointmentWeekDayProperties
- **getEmptyStateProperties** As ASScheduler\_AgendaView\_EmptyStateProperties
- **getMonthNameShort** As ASScheduler\_MonthNameShort
- **getMonthProperties** As ASScheduler\_AgendaView\_MonthProperties
- **getStartDate** As Long
- **getTimelineProperties** As ASScheduler\_AgendaView\_TimelineProperties
- **getWeekNameShort** As ASScheduler\_WeekNameShort
- **getWeekProperties** As ASScheduler\_AgendaView\_WeekProperties
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RebuildScheduler**
*Clears the list and rebuilds it  
 Set the StartDate if you want a new date*- **RefreshScheduler** As String
*Reloads all visible elements  
 If you want to remove appointments then call RebuildScheduler*- **Scroll2Date** (Date As Long)
- **setMonthNameShort** (MonthNameShort As ASScheduler\_MonthNameShort) As String
- **setStartDate** (StartDate As Long) As String
- **setWeekNameShort** (WeekNameShort As ASScheduler\_WeekNameShort) As String

- **Properties:**

- **API** As ASSchedulerAPI [read only]
*Gets the API*- **AppointmentDayOfMonthProperties** As ASScheduler\_AgendaView\_AppointmentDayOfMonthProperties [read only]
- **AppointmentProperties** As ASScheduler\_AgendaView\_AppointmentProperties [read only]
- **AppointmentWeekDayProperties** As ASScheduler\_AgendaView\_AppointmentWeekDayProperties [read only]
- **EmptyStateProperties** As ASScheduler\_AgendaView\_EmptyStateProperties [read only]
- **MonthNameShort** As ASScheduler\_MonthNameShort
- **MonthProperties** As ASScheduler\_AgendaView\_MonthProperties [read only]
- **StartDate** As Long
- **TimelineProperties** As ASScheduler\_AgendaView\_TimelineProperties [read only]
- **WeekNameShort** As ASScheduler\_WeekNameShort
- **WeekProperties** As ASScheduler\_AgendaView\_WeekProperties [read only]

- **ASScheduler\_AgendaView\_AppointmentDayOfMonthProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_AgendaView\_AppointmentProperties**

- **Fields:**

- **CornerRadius** As Float
- **Gap** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ShowDuration** As Boolean
- **ShowStartEndTime** As Boolean
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_AgendaView\_AppointmentWeekDayProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_AgendaView\_EmptyStateProperties**

- **Fields:**

- **BackgroundColor** As Int
- **EmptyText** As String
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_AgendaView\_MonthProperties**

- **Fields:**

- **BackgroundColor** As Int
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_AgendaView\_TimelineProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Width** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_AgendaView\_WeekProperties**

- **Fields:**

- **BackgroundColor** As Int
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_Appointment**

- **Fields:**

- **Color** As Int
- **Description** As String
- **EndDate** As Long
- **Id** As Int
- **isFullDay** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isRecurring** As Boolean
- **Just4Sorting** As String
- **Name** As String
- **RecurringInterval** As Int
- **RecurringUnit** As String
- **StartDate** As Long
- **Tag** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_Blackout**

- **Fields:**

- **EndDate** As Long
- **Id** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **StartDate** As Long

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_CalendarViewMonth**

- **Events:**

- **AppointmentClick** (Appointment As ASScheduler\_Appointment)
- **AppointmentDoubleClick** (Appointment As ASScheduler\_Appointment)
- **AppointmentLongClick** (Appointment As ASScheduler\_Appointment)
- **CustomDrawDay** (Date As Long, Views As ASScheduler\_CalendarView\_CustomDrawDay)
- **HiddenAppointmentClick** (ListOfAppointments As List)
- **HiddenAppointmentLongClick** (ListOfAppointments As List)
- **SelectedDateChanged** (Date As Long)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **ChangeView** (NewView As String)
- **Class\_Globals** As String
- **CreateASScheduler\_CalendarView\_AppointmentProperties** (Height As Float, Gap As Float, BottomGap As Float) As ASScheduler\_CalendarView\_AppointmentProperties
- **CreateASScheduler\_CalendarView\_BodyProperties** (xFont As B4XFont, TextColor As Int) As ASScheduler\_CalendarView\_BodyProperties
- **CreateASScheduler\_CalendarView\_HeaderProperties** (Height As Float, xFont As B4XFont, TextColor As Int) As ASScheduler\_CalendarView\_HeaderProperties
- **CreateASScheduler\_CalendarView\_SpecialDayProperties** (Color As Int) As ASScheduler\_CalendarView\_SpecialDayProperties
- **CreateASScheduler\_CalendarView\_WeekNumberProperties** (Width As Float, Color As Int, xFont As B4XFont, TextColor As Int, Text As String) As ASScheduler\_CalendarView\_WeekNumberProperties
- **CreateASScheduler\_MonthNameShort** (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASScheduler\_MonthNameShort
- **CreateASScheduler\_WeekNameShort** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASScheduler\_WeekNameShort
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getAPI** As ASSchedulerAPI
*Gets the API*- **getAppointmentProperties** As ASScheduler\_MonthView\_AppointmentProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>14dip</code>  
 Gap: <code>2dip</code>  
 LeftRightGap: <code>2dip</code>  
 CornerRadius: <code>3dip</code>  
 xFont: <code>xui.CreateDefaultFont(IIf(xui.IsB4i,12,10))</code>  
 TextColor: <code>xui.Color\_White</code>*- **getBlackoutProperties** As ASScheduler\_MonthView\_BlackoutProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,255,255,255)</code>*- **getBodyColor** As Int
- **getBodyProperties** As ASScheduler\_CalendarView\_BodyProperties
- **getCurrentDateColor** As Int
- **getCurrentView\_CenturyView** As String
- **getCurrentView\_DecadeView** As String
- **getCurrentView\_MonthView** As String
- **getCurrentView\_YearView** As String
- **getGridLineColor** As Int
- **getHeaderColor** As Int
- **getHeaderPanel** As B4XView
*You can customize the appereance of the header  
 With the following code you can customize the control elements that are visible in the header:  
 <code>  
 'Middle Text Label  
 Dim xlbl\_Header As B4XView = AS\_DatePicker1.HeaderPanel.GetView(0)  
 'Left Arrow Label  
 Dim xlbl\_ArrowLeft As B4XView = AS\_DatePicker1.HeaderPanel.GetView(1)  
 'Right Arrow Label  
 Dim xlbl\_ArrowRight As B4XView = AS\_DatePicker1.HeaderPanel.GetView(2)  
 </code>*- **getHeaderProperties** As ASScheduler\_CalendarView\_HeaderProperties
- **getMonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_CalendarViewMonth1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **getSchedulerFunction** As String
- **getSchedulerFunction\_Calendar** As String
- **getSchedulerFunction\_MonthView** As String
- **getSelectedDate** As Long
- **getSelectedDateColor** As Int
- **getShowAppointments** As Boolean
*Call RefreshScheduler if you change something*- **getShowGridLines** As Boolean
- **getShowHeader** As Boolean
- **getShowWeekNumbers** As Boolean
*Gets or sets the number of visible weeks  
 Call Refresh to commit changes*- **getSpecialDayProperties** As ASScheduler\_CalendarView\_SpecialDayProperties
- **getStartDate** As Long
- **getWeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshHeader if you change something  
 <code>ASScheduler\_CalendarViewMonth1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **getWeekNumberProperties** As ASScheduler\_CalendarView\_WeekNumberProperties
*Call Refresh if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextMonth** As String
- **PreviousMonth** As String
- **RefreshScheduler** As String
*Rebuilds the visible scheduler items*- **Scroll2Date** (Date As Long) As String
*Scrolls to the date  
 Builds the view new if the date was not in range*- **setAppointmentProperties** (MonthView\_AppointmentProperties As ASScheduler\_MonthView\_AppointmentProperties) As String
- **setBlackoutProperties** (MonthView\_BlackoutProperties As ASScheduler\_MonthView\_BlackoutProperties) As String
- **setBodyColor** (Color As Int) As String
- **setBodyProperties** (BodyProperties As ASScheduler\_CalendarView\_BodyProperties) As String
- **setCurrentDateColor** (Color As Int) As String
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
- **setHeaderProperties** (HeaderProperties As ASScheduler\_CalendarView\_HeaderProperties) As String
- **setMonthNameShort** (MonthNameShort As ASScheduler\_MonthNameShort) As String
- **setSchedulerFunction** (FunctionName As String) As String
- **setSelectedDate** (Date As Long) As String
- **setSelectedDateColor** (Color As Int) As String
- **setShowAppointments** (Visible As Boolean) As String
- **setShowGridLines** (Show As Boolean) As String
- **setShowHeader** (Visible As Boolean) As String
- **setShowWeekNumbers** (Show As Boolean) As String
- **setSpecialDayProperties** (SpecialDayProperties As ASScheduler\_CalendarView\_SpecialDayProperties) As String
- **setStartDate** (Date As Long) As String
- **setWeekNameShort** (WeekNameShort As ASScheduler\_WeekNameShort) As String
- **setWeekNumberProperties** (WeekNumberProperties As ASScheduler\_CalendarView\_WeekNumberProperties) As String

- **Properties:**

- **API** As ASSchedulerAPI [read only]
*Gets the API*- **AppointmentProperties** As ASScheduler\_MonthView\_AppointmentProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>14dip</code>  
 Gap: <code>2dip</code>  
 LeftRightGap: <code>2dip</code>  
 CornerRadius: <code>3dip</code>  
 xFont: <code>xui.CreateDefaultFont(IIf(xui.IsB4i,12,10))</code>  
 TextColor: <code>xui.Color\_White</code>*- **BlackoutProperties** As ASScheduler\_MonthView\_BlackoutProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,255,255,255)</code>*- **BodyColor** As Int
- **BodyProperties** As ASScheduler\_CalendarView\_BodyProperties
- **CurrentDateColor** As Int
- **CurrentView\_CenturyView** As String [read only]
- **CurrentView\_DecadeView** As String [read only]
- **CurrentView\_MonthView** As String [read only]
- **CurrentView\_YearView** As String [read only]
- **FirstDayOfWeek**
*1-7  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **GridLineColor** As Int
- **HeaderColor** As Int
- **HeaderPanel** As B4XView [read only]
*You can customize the appereance of the header  
 With the following code you can customize the control elements that are visible in the header:  
 <code>  
 'Middle Text Label  
 Dim xlbl\_Header As B4XView = AS\_DatePicker1.HeaderPanel.GetView(0)  
 'Left Arrow Label  
 Dim xlbl\_ArrowLeft As B4XView = AS\_DatePicker1.HeaderPanel.GetView(1)  
 'Right Arrow Label  
 Dim xlbl\_ArrowRight As B4XView = AS\_DatePicker1.HeaderPanel.GetView(2)  
 </code>*- **HeaderProperties** As ASScheduler\_CalendarView\_HeaderProperties
- **MonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_CalendarViewMonth1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **SchedulerFunction** As String
- **SchedulerFunction\_Calendar** As String [read only]
- **SchedulerFunction\_MonthView** As String [read only]
- **SelectedDate** As Long
- **SelectedDateColor** As Int
- **ShowAppointments** As Boolean
*Call RefreshScheduler if you change something*- **ShowGridLines** As Boolean
- **ShowHeader** As Boolean
- **ShowWeekNumbers** As Boolean
*Gets or sets the number of visible weeks  
 Call Refresh to commit changes*- **SpecialDayProperties** As ASScheduler\_CalendarView\_SpecialDayProperties
- **StartDate** As Long
- **WeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshHeader if you change something  
 <code>ASScheduler\_CalendarViewMonth1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **WeekNumberProperties** As ASScheduler\_CalendarView\_WeekNumberProperties
*Call Refresh if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*
- **ASScheduler\_CalendarViewWeek**

- **Events:**

- **CustomDrawDay** (Date As Long, Views As ASScheduler\_CalendarView\_CustomDrawDay)
- **SelectedDateChanged** (Date As Long)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **CreateASScheduler\_CalendarView\_AppointmentProperties** (Height As Float, Gap As Float, BottomGap As Float) As ASScheduler\_CalendarView\_AppointmentProperties
- **CreateASScheduler\_CalendarView\_BodyProperties** (xFont As B4XFont, TextColor As Int) As ASScheduler\_CalendarView\_BodyProperties
- **CreateASScheduler\_CalendarView\_HeaderProperties** (Height As Float, xFont As B4XFont, TextColor As Int) As ASScheduler\_CalendarView\_HeaderProperties
- **CreateASScheduler\_CalendarView\_SpecialDayProperties** (Color As Int) As ASScheduler\_CalendarView\_SpecialDayProperties
- **CreateASScheduler\_CalendarView\_WeekNumberProperties** (Width As Float, Color As Int, xFont As B4XFont, TextColor As Int, Text As String) As ASScheduler\_CalendarView\_WeekNumberProperties
- **CreateASScheduler\_MonthNameShort** (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASScheduler\_MonthNameShort
- **CreateASScheduler\_WeekNameShort** (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASScheduler\_WeekNameShort
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getAPI** As ASSchedulerAPI
*Gets the API*- **getBodyColor** As Int
- **getBodyProperties** As ASScheduler\_CalendarView\_BodyProperties
- **getCurrentDateColor** As Int
- **getHeaderColor** As Int
- **getHeaderPanel** As B4XView
*You can customize the appereance of the header  
 With the following code you can customize the control elements that are visible in the header:  
 <code>  
 'Middle Text Label  
 Dim xlbl\_Header As B4XView = AS\_DatePicker1.HeaderPanel.GetView(0)  
 'Left Arrow Label  
 Dim xlbl\_ArrowLeft As B4XView = AS\_DatePicker1.HeaderPanel.GetView(1)  
 'Right Arrow Label  
 Dim xlbl\_ArrowRight As B4XView = AS\_DatePicker1.HeaderPanel.GetView(2)  
 </code>*- **getHeaderProperties** As ASScheduler\_CalendarView\_HeaderProperties
- **getMonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_CalendarViewWeek1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **getSelectedDateColor** As Int
- **getShowAppointments** As Boolean
*Call RefreshScheduler if you change something*- **getShowHeader** As Boolean
- **getShowWeekNumbers** As Boolean
*Gets or sets the number of visible weeks  
 Call Refresh to commit changes*- **getSpecialDayProperties** As ASScheduler\_CalendarView\_SpecialDayProperties
- **getStartDate** As Long
- **getWeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshHeader if you change something  
 <code>ASScheduler\_CalendarViewWeek1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **getWeekNumberProperties** As ASScheduler\_CalendarView\_WeekNumberProperties
*Call Refresh if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextWeek** As String
- **PreviousWeek** As String
- **RefreshScheduler** As String
*Rebuilds the visible scheduler items*- **Scroll2Date** (Date As Long) As String
*Scrolls to the date  
 Builds the view new if the date was not in range*- **setBodyColor** (Color As Int) As String
- **setBodyProperties** (BodyProperties As ASScheduler\_CalendarView\_BodyProperties) As String
- **setCurrentDateColor** (Color As Int) As String
- **setFirstDayOfWeek** (number As Int) As String
*1-7  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **setHeaderColor** (Color As Int) As String
- **setHeaderProperties** (HeaderProperties As ASScheduler\_CalendarView\_HeaderProperties) As String
- **setMonthNameShort** (MonthNameShort As ASScheduler\_MonthNameShort) As String
- **setSelectedDateColor** (Color As Int) As String
- **setShowAppointments** (Visible As Boolean) As String
- **setShowHeader** (Visible As Boolean) As String
- **setShowWeekNumbers** (Show As Boolean) As String
- **setSpecialDayProperties** (SpecialDayProperties As ASScheduler\_CalendarView\_SpecialDayProperties) As String
- **setStartDate** (Date As Long) As String
- **setWeekNameShort** (WeekNameShort As ASScheduler\_WeekNameShort) As String
- **setWeekNumberProperties** (WeekNumberProperties As ASScheduler\_CalendarView\_WeekNumberProperties) As String

- **Properties:**

- **API** As ASSchedulerAPI [read only]
*Gets the API*- **BodyColor** As Int
- **BodyProperties** As ASScheduler\_CalendarView\_BodyProperties
- **CurrentDateColor** As Int
- **FirstDayOfWeek**
*1-7  
 Friday = 1  
 Thursday = 2  
 Wednesday = 3  
 Tuesday = 4  
 Monday = 5  
 Sunday = 6  
 Saturday = 7*- **HeaderColor** As Int
- **HeaderPanel** As B4XView [read only]
*You can customize the appereance of the header  
 With the following code you can customize the control elements that are visible in the header:  
 <code>  
 'Middle Text Label  
 Dim xlbl\_Header As B4XView = AS\_DatePicker1.HeaderPanel.GetView(0)  
 'Left Arrow Label  
 Dim xlbl\_ArrowLeft As B4XView = AS\_DatePicker1.HeaderPanel.GetView(1)  
 'Right Arrow Label  
 Dim xlbl\_ArrowRight As B4XView = AS\_DatePicker1.HeaderPanel.GetView(2)  
 </code>*- **HeaderProperties** As ASScheduler\_CalendarView\_HeaderProperties
- **MonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_CalendarViewWeek1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **SelectedDateColor** As Int
- **ShowAppointments** As Boolean
*Call RefreshScheduler if you change something*- **ShowHeader** As Boolean
- **ShowWeekNumbers** As Boolean
*Gets or sets the number of visible weeks  
 Call Refresh to commit changes*- **SpecialDayProperties** As ASScheduler\_CalendarView\_SpecialDayProperties
- **StartDate** As Long
- **WeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshHeader if you change something  
 <code>ASScheduler\_CalendarViewWeek1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **WeekNumberProperties** As ASScheduler\_CalendarView\_WeekNumberProperties
*Call Refresh if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*
- **ASScheduler\_CalendarView\_AppointmentProperties**

- **Fields:**

- **BottomGap** As Float
- **Gap** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_CalendarView\_BodyProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_CalendarView\_CustomDrawDay**

- **Fields:**

- **BackgroundPanel** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_Date** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_CalendarView\_HeaderProperties**

- **Fields:**

- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_CalendarView\_SpecialDayProperties**

- **Fields:**

- **Color** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_CalendarView\_WeekNumberProperties**

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
- **ASScheduler\_DayView**

- **Events:**

- **AppointmentClick** (Appointment As ASScheduler\_Appointment)
- **AppointmentDoubleClick** (Appointment As ASScheduler\_Appointment)
- **AppointmentLongClick** (Appointment As ASScheduler\_Appointment)
- **Created**
- **TimeBlockClick** (StartDate As Long, EndDate As Long)
- **TimeBlockDoubleClick** (StartDate As Long, EndDate As Long)
- **TimeBlockLongClick** (StartDate As Long, EndDate As Long)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Back2CurrentDate** As String
*Slides Back or Forward to the Current Date*- **Base\_Resize** (Width As Double, Height As Double)
- **Class\_Globals** As String
- **CreateASScheduler\_DayView\_AppointmentProperties** (Height As Float, Gap As Float, CornerRadius As Float, xFont As B4XFont, TextColor As Int, OverviewGap As Boolean, ShowStartEndTime As Boolean, ShowDuration As Boolean) As ASScheduler\_DayView\_AppointmentProperties
- **CreateASScheduler\_DayView\_BlackoutProperties** (Width As Float, Color As Int) As ASScheduler\_DayView\_BlackoutProperties
- **CreateASScheduler\_DayView\_CurrentTimeIndicatorProperties** (Height As Float, Color As Int, FullWidth As Boolean) As ASScheduler\_DayView\_CurrentTimeIndicatorProperties
- **CreateASScheduler\_DayView\_HeaderTextProperties** (TextColor As Int, TextFont As B4XFont) As ASScheduler\_DayView\_HeaderTextProperties
- **CreateASScheduler\_DayView\_TimelineProperties** (Width As Float, BackgroundColor As Int, TextColor As Int, ShowGridLines As Boolean) As ASScheduler\_DayView\_TimelineProperties
- **CreateASScheduler\_DayView\_WeekNumberProperties** (Width As Float, Height As Float, Color As Int, xFont As B4XFont, TextColor As Int, CornerRadius As Float) As ASScheduler\_DayView\_WeekNumberProperties
- **CreateASScheduler\_DayView\_WorkingProperties** (StartHour As Int, EndHour As Int, NonWorkingDays As Int(), Color As Int, Active As Boolean) As ASScheduler\_DayView\_WorkingProperties
- **CreateScheduler** As String
*Call this if you want to show the scheduler the user  
 The Panel in the forderground is hiding smoothly*- **CreateVirtualView** (Left As Double, Top As Double, Right As Double, Height As Double, xpnl\_ItemBackground As B4XView) As VirtualView
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getAPI** As ASSchedulerAPI
*Gets the API*- **getAppointmentProperties** As ASScheduler\_DayView\_AppointmentProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>14dip</code>  
 Gap: <code>2dip</code>  
 CornerRadius: <code>3dip</code>  
 xFont: <code>xui.CreateDefaultFont(IIf(xui.IsB4i,12,10))</code>  
 TextColor: <code>xui.Color\_White</code>*- **getBlackoutProperties** As ASScheduler\_DayView\_BlackoutProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,255,255,255)</code>*- **getBlockHeight** As Float
- **getBodyColor** As Int
- **getCurrentDateColor** As Int
- **getCurrentTimeIndicatorLiveUpdate** As Boolean
- **getCurrentTimeIndicatorProperties** As ASScheduler\_DayView\_CurrentTimeIndicatorProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,221, 95, 96)</code>  
 FullWidth: <code>False</code>*- **getDayCount** As String
- **getDayCount\_FiveDays** As String
- **getDayCount\_OneDay** As String
- **getDayCount\_SevenDays** As String
- **getDayCount\_ThreeDays** As String
*ThreeDays*- **getDayCount\_WorkWeek** As String
- **getGridLineColor** As Int
- **getHeaderColor** As Int
- **getHeaderHeight** As Float
- **getHeaderTextProperties** As ASScheduler\_DayView\_HeaderTextProperties
*Call RefreshScheduler if you change something  
 Default Values  
 TextColor: <code>xui.Color\_White</code>  
 TextFont: <code>xui.CreateDefaultBoldFont(15)</code>*- **getHeaderVisibility** As Boolean
- **getMonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_DayView1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **getSelectedBlockColor** As Int
- **getShowMonthNames** As Boolean
*Call RefreshScheduler if you change something*- **getShowWeekNumbers** As Boolean
*Call RefreshScheduler if you change something*- **getStartDate** As Long
*Call RefreshComplete if you change something*- **getTimelineProperties** As ASScheduler\_DayView\_TimelineProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>40dip</code>  
 BackgroundColor: <code>0xFF131416</code>  
 TextColor: <code>xui.Color\_White</code>*- **getTimelineVisibility** As Boolean
- **getTimeSystem** As String
*Call RefreshScheduler if you change something  
 <code>ASSchedulerUtils.TimeSystem\_24h</code>*- **getWeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_DayView1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **getWeekNumberProperties** As ASScheduler\_DayView\_WeekNumberProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*- **getWorkingProperties** As ASScheduler\_DayView\_WorkingProperties
*Call RefreshScheduler if you change something  
 Default Values  
 StartHour: <code>8</code>  
 EndHour: <code>17</code>  
 NonWorkingDays: <code>Array As Int(ASSchedulerUtils.WeekDay\_Saturday,ASSchedulerUtils.WeekDay\_Sunday)</code>  
 Color: <code>xui.Color\_ARGB(255,60, 64, 67)</code>  
 Active: <code>True</code>*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isValueInArray** (SourceArray As Int(), TargetValue As Int) As Boolean
- **Jump2Date** (Date As Long) As String
*Jumps to the date  
 Builds the view new if the date was not in range*- **Nextweek** As String
- **PreviousWeek** As String
- **RefreshComplete** As String
- **RefreshScheduler** As String
*Rebuilds the visible scheduler items*- **Scroll2Date** (Date As Long) As String
*Scrolls to the date  
 Builds the view new if the date was not in range*- **setAppointmentProperties** (DayView\_AppointmentProperties As ASScheduler\_DayView\_AppointmentProperties) As String
- **setBlackoutProperties** (DayView\_BlackoutProperties As ASScheduler\_DayView\_BlackoutProperties) As String
- **setBlockHeight** (Height As Float) As String
*Call RefreshScheduler if you change something  
 Default: 20dip*- **setBodyColor** (Color As Int) As String
*Call RefreshScheduler if you change something*- **setCurrentDateColor** (Color As Int) As String
*Call RefreshScheduler if you change something*- **setCurrentTimeIndicatorLiveUpdate** (Enabled As Boolean) As String
*If True then indicator moves 1 time per minute to always show the most current time*- **setCurrentTimeIndicatorProperties** (DayView\_CurrentTimeIndicatorProperties As ASScheduler\_DayView\_CurrentTimeIndicatorProperties) As String
- **setDayCount** (DayCount As String) As String
*Changes the number of days that are visible  
 Call RefreshComplete if you change something  
 <code> ASScheduler\_DayView1.DayCount = ASScheduler\_DayView1.DayCount\_FiveDays</code>*- **setGridLineColor** (Color As Int) As String
*Call RefreshScheduler if you change something*- **setHeaderColor** (Color As Int) As String
*Call RefreshScheduler if you change something*- **setHeaderHeight** (Height As Float) As String
*Call RefreshScheduler if you change something*- **setHeaderTextProperties** (DayView\_HeaderTextProperties As ASScheduler\_DayView\_HeaderTextProperties) As String
- **setHeaderVisibility** (Visibility As Boolean) As String
*Hides or Show the Header  
 Call RefreshScheduler if you change something*- **setMonthNameShort** (MonthNameShort As ASScheduler\_MonthNameShort) As String
- **setSelectedBlockColor** (Color As Int) As String
*Call RefreshScheduler if you change something*- **setShowMonthNames** (Show As Boolean) As String
*Call RefreshScheduler if you change something*- **setShowWeekNumbers** (Show As Boolean) As String
- **setStartDate** (Date As Long) As String
- **SetTheme** (Theme As ASScheduler\_Theme) As String
*DarkMode Example  
 <code>  
 Dim Theme As ASScheduler\_Theme  
 Theme.Initialize  
 'Background Colors  
 Theme.BackgroundColor\_Body = 0xFF202125  
 Theme.BackgroundColor\_Header = 0xFF131416  
 Theme.BackgroundColor\_Timeline = 0xFF131416  
 Theme.BackgroundColor\_WeekNumber = xui.Color\_ARGB(255,32, 33, 37)  
 Theme.BackgroundColor\_GridLine = 0x64FFFFFF  
 Theme.BackgroundColor\_Blackout = xui.Color\_ARGB(152,255,255,255)  
 'Text Colors  
 Theme.TextColor\_Header = xui.Color\_White  
 Theme.TextColor\_Timeline = xui.Color\_White  
 Theme.TextColor\_WeekNumber = xui.Color\_White  
 ASScheduler\_DayView1.SetTheme(Theme)  
 ASScheduler\_DayView1.RefreshScheduler  
 </code>  
 LightMode Example  
 <code>  
 Dim Theme As ASScheduler\_Theme  
 Theme.Initialize  
 'Background Colors  
 Theme.BackgroundColor\_Body = xui.Color\_White  
 Theme.BackgroundColor\_Header = xui.Color\_White  
 Theme.BackgroundColor\_Timeline = xui.Color\_White  
 Theme.BackgroundColor\_WeekNumber = xui.Color\_Gray  
 Theme.BackgroundColor\_GridLine = xui.Color\_ARGB(100,0,0,0)  
 Theme.BackgroundColor\_Blackout = xui.Color\_ARGB(152,0,0,0)  
 'Text Colors  
 Theme.TextColor\_Header = xui.Color\_Black  
 Theme.TextColor\_Timeline = xui.Color\_Black  
 Theme.TextColor\_WeekNumber = xui.Color\_Black  
 ASScheduler\_DayView1.SetTheme(Theme)  
 ASScheduler\_DayView1.RefreshScheduler  
 </code>*- **setTimelineProperties** (DayView\_TimelineProperties As ASScheduler\_DayView\_TimelineProperties) As String
- **setTimelineVisibility** (Visibility As Boolean) As String
*Hides or Show the Timeline  
 Call RefreshScheduler if you change something*- **setTimeSystem** (System As String) As String
- **setWeekNameShort** (WeekNameShort As ASScheduler\_WeekNameShort) As String
- **setWeekNumberProperties** (DayView\_WeekNumberProperties As ASScheduler\_DayView\_WeekNumberProperties) As String

- **Properties:**

- **API** As ASSchedulerAPI [read only]
*Gets the API*- **AppointmentProperties** As ASScheduler\_DayView\_AppointmentProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>14dip</code>  
 Gap: <code>2dip</code>  
 CornerRadius: <code>3dip</code>  
 xFont: <code>xui.CreateDefaultFont(IIf(xui.IsB4i,12,10))</code>  
 TextColor: <code>xui.Color\_White</code>*- **BlackoutProperties** As ASScheduler\_DayView\_BlackoutProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,255,255,255)</code>*- **BlockHeight** As Float
*Call RefreshScheduler if you change something  
 Default: 20dip*- **BodyColor** As Int
*Call RefreshScheduler if you change something*- **CurrentDateColor** As Int
*Call RefreshScheduler if you change something*- **CurrentTimeIndicatorLiveUpdate** As Boolean
*If True then indicator moves 1 time per minute to always show the most current time*- **CurrentTimeIndicatorProperties** As ASScheduler\_DayView\_CurrentTimeIndicatorProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,221, 95, 96)</code>  
 FullWidth: <code>False</code>*- **DayCount** As String
*Changes the number of days that are visible  
 Call RefreshComplete if you change something  
 <code> ASScheduler\_DayView1.DayCount = ASScheduler\_DayView1.DayCount\_FiveDays</code>*- **DayCount\_FiveDays** As String [read only]
- **DayCount\_OneDay** As String [read only]
- **DayCount\_SevenDays** As String [read only]
- **DayCount\_ThreeDays** As String [read only]
*ThreeDays*- **DayCount\_WorkWeek** As String [read only]
- **GridLineColor** As Int
*Call RefreshScheduler if you change something*- **HeaderColor** As Int
*Call RefreshScheduler if you change something*- **HeaderHeight** As Float
*Call RefreshScheduler if you change something*- **HeaderTextProperties** As ASScheduler\_DayView\_HeaderTextProperties
*Call RefreshScheduler if you change something  
 Default Values  
 TextColor: <code>xui.Color\_White</code>  
 TextFont: <code>xui.CreateDefaultBoldFont(15)</code>*- **HeaderVisibility** As Boolean
*Hides or Show the Header  
 Call RefreshScheduler if you change something*- **MonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_DayView1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **SelectedBlockColor** As Int
*Call RefreshScheduler if you change something*- **ShowMonthNames** As Boolean
*Call RefreshScheduler if you change something*- **ShowWeekNumbers** As Boolean
*Call RefreshScheduler if you change something*- **StartDate** As Long
*Call RefreshComplete if you change something*- **TimelineProperties** As ASScheduler\_DayView\_TimelineProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>40dip</code>  
 BackgroundColor: <code>0xFF131416</code>  
 TextColor: <code>xui.Color\_White</code>*- **TimelineVisibility** As Boolean
*Hides or Show the Timeline  
 Call RefreshScheduler if you change something*- **TimeSystem** As String
*Call RefreshScheduler if you change something  
 <code>ASSchedulerUtils.TimeSystem\_24h</code>*- **WeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_DayView1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **WeekNumberProperties** As ASScheduler\_DayView\_WeekNumberProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*- **WorkingProperties** As ASScheduler\_DayView\_WorkingProperties [read only]
*Call RefreshScheduler if you change something  
 Default Values  
 StartHour: <code>8</code>  
 EndHour: <code>17</code>  
 NonWorkingDays: <code>Array As Int(ASSchedulerUtils.WeekDay\_Saturday,ASSchedulerUtils.WeekDay\_Sunday)</code>  
 Color: <code>xui.Color\_ARGB(255,60, 64, 67)</code>  
 Active: <code>True</code>*
- **ASScheduler\_DayView\_AppointmentProperties**

- **Fields:**

- **CornerRadius** As Float
- **Gap** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **OverviewGap** As Boolean
- **ShowDuration** As Boolean
- **ShowStartEndTime** As Boolean
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_DayView\_BlackoutProperties**

- **Fields:**

- **Color** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Width** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_DayView\_CurrentTimeIndicatorProperties**

- **Fields:**

- **Color** As Int
- **FullWidth** As Boolean
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_DayView\_HeaderTextProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **TextFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_DayView\_TimeBlock**

- **Fields:**

- **EndDate** As Long
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **StartDate** As Long

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_DayView\_TimelineProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ShowGridLines** As Boolean
- **TextColor** As Int
- **Width** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_DayView\_WeekNumberProperties**

- **Fields:**

- **Color** As Int
- **CornerRadius** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **Width** As Float
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_DayView\_WorkingProperties**

- **Fields:**

- **Active** As Boolean
- **Color** As Int
- **EndHour** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NonWorkingDays** As Int()
- **StartHour** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_HeatMapColor**

- **Fields:**

- **Color** As Int
- **Count** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthNameShort**

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
- **ASScheduler\_MonthView**

- **Events:**

- **AppointmentClick** (Appointment As ASScheduler\_Appointment)
- **AppointmentDoubleClick** (Appointment As ASScheduler\_Appointment)
- **AppointmentLongClick** (Appointment As ASScheduler\_Appointment)
- **Created**
- **CustomDrawDay** (Date As Long, Views As ASScheduler\_MonthView\_CustomDrawDay)
- **DayClick** (Date As Long)
- **DayDoubleClick** (Date As Long)
- **DayLongClick** (Date As Long)
- **FirstVisibleDay** (Date As Long)
- **HiddenAppointmentClick** (ListOfAppointments As List)
- **HiddenAppointmentLongClick** (ListOfAppointments As List)
- **LastVisibleDay** (Date As Long)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Back2CurrentDate** As String
*Slides Back or Forward to the Current Date*- **Base\_Resize** (Width As Double, Height As Double)
- **Class\_Globals** As String
- **CreateASScheduler\_MonthView\_DayProperties** (TextColor As Int, TextFont As B4XFont, TextFontCurrentDay As B4XFont) As ASScheduler\_MonthView\_DayProperties
- **CreateASScheduler\_MonthView\_HeaderTextProperties** (TextColor As Int, TextFont As B4XFont, TextAlignment\_Vertical As String, TextAlignment\_Horizontal As String, BackgroundColor As Int) As ASScheduler\_MonthView\_HeaderTextProperties
- **CreateASScheduler\_MonthView\_HeatMapProperties** (xFont As B4XFont, ShowCounter As Boolean, ColorCountList As List) As ASScheduler\_MonthView\_HeatMapProperties
- **CreateASScheduler\_MonthView\_MinimalismProperties** (Height As Float, Gap As Float, BottomGap As Float) As ASScheduler\_MonthView\_MinimalismProperties
- **CreateASScheduler\_MonthView\_WeekNumberProperties** (Width As Float, Color As Int, xFont As B4XFont, TextColor As Int) As ASScheduler\_MonthView\_WeekNumberProperties
- **CreateScheduler** As String
*Call this if you want to show the scheduler the user  
 The Panel in the forderground is hiding smoothly*- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getAPI** As ASSchedulerAPI
*Gets the API*- **getAppointmentProperties** As ASScheduler\_MonthView\_AppointmentProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>14dip</code>  
 Gap: <code>2dip</code>  
 LeftRightGap: <code>2dip</code>  
 CornerRadius: <code>3dip</code>  
 xFont: <code>xui.CreateDefaultFont(IIf(xui.IsB4i,12,10))</code>  
 TextColor: <code>xui.Color\_White</code>*- **getBlackoutProperties** As ASScheduler\_MonthView\_BlackoutProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,255,255,255)</code>*- **getDayProperties** As ASScheduler\_MonthView\_DayProperties
- **getHeaderHeight** As Float
*Default: 40dip*- **getHeaderTextProperties** As ASScheduler\_MonthView\_HeaderTextProperties
*Call RefreshHeader if you change something  
 Default Values  
 TextColor: <code>xui.Color\_White</code>  
 TextFont: <code>xui.CreateDefaultBoldFont(15)</code>  
 TextAlignment\_Vertical: <code>"CENTER"e</code>  
 TextAlignment\_Horizontal: <code>"CENTER"</code>  
 BackgroundColor: <code>m\_HeaderColor</code>*- **getHeaderVisibility** As Boolean
- **getHeatMapProperties** As ASScheduler\_MonthView\_HeatMapProperties
*Call RefreshScheduler if you change something  
 Default Values  
 xFont: <code>xui.CreateDefaultBoldFont(15)</code>  
 ColorCountList Example:  
 <code>  
 Dim HeatColor As List : HeatColor.Initialize  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,214, 230, 133),0,xui.Color\_White))  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,140, 198, 101),2,xui.Color\_White))  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,68, 163, 64),4,xui.Color\_White))  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,30, 104, 35),7,xui.Color\_White))  
 </code>*- **getMinimalismProperties** As ASScheduler\_MonthView\_MinimalismProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>8dip</code>  
 Gap: <code>4dip</code>  
 BottomGap: <code>16dip</code>*- **getMonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_MonthView1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **getNumberOfWeeks** As Int
*Gets or sets the number of visible weeks*- **getSchedulerFunction** As String
- **getSchedulerFunction\_Calendar** As String
*Normal mode, Appointments and Blackout days are displayed*- **getSchedulerFunction\_HeatMap** As String
*A heatmap shows how the workload is on one day  
 The more appointments in a day, the darker is the color*- **getSchedulerFunction\_Minimalism** As String
*Appointments are displayed as dots*- **getSelectedDate** As Long
*gets or sets the selected date*- **getStartDate** As Long
*Gets or sets the start date*- **GetVisibleDays** As List
*Gets the visible days as list of ASScheduler\_MonthView\_CustomDrawDay  
 <code>  
 For Each CustomDrawDay As ASScheduler\_MonthView\_CustomDrawDay In ASScheduler\_MonthView1.GetVisibleDays  
 CustomDrawDay.BackgroundPanel.Color = xui.Color\_Red  
 Next  
 </code>*- **getWeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshHeader if you change something  
 <code>ASScheduler\_MonthView1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **getWeekNumberProperties** As ASScheduler\_MonthView\_WeekNumberProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RefreshComplete** As String
*Rebuilds the calendar*- **RefreshHeader** As String
*Rebuilds the header*- **RefreshScheduler** As String
*Rebuilds the visible scheduler items*- **Scroll2Date** (Date As Long)
*Scrolls to the date  
 Builds the view new if the date was not in range*- **SelectDate** (Date As Long) As String
- **setAppointmentProperties** (MonthView\_AppointmentProperties As ASScheduler\_MonthView\_AppointmentProperties) As String
- **setBlackoutProperties** (MonthView\_BlackoutProperties As ASScheduler\_MonthView\_BlackoutProperties) As String
- **setBodyColor** (Color As Int) As String
*sets the body color  
 Call RefreshScheduler to commit changes*- **setCurrentDateColor** (Color As Int) As String
*Call RefreshScheduler to commit changes*- **setCurrentDateTextColor** (Color As Int) As String
*Call RefreshScheduler to commit changes*- **setHeaderColor** (Color As Int) As String
*sets the Header Color*- **setHeaderHeight** (Height As Float) As String
- **setHeaderTextProperties** (MonthView\_HeaderTextProperties As ASScheduler\_MonthView\_HeaderTextProperties) As String
- **setMonthNameShort** (MonthNameShort As ASScheduler\_MonthNameShort) As String
- **setNumberOfWeeks** (Weeks As Int) As String
*Call RefreshScheduler to commit changes*- **setSchedulerFunction** (Function As String) As String
*Changes the functionality of the scheduler  
 <code>ASScheduler\_MonthView1.SchedulerFunction = ASScheduler\_MonthView1.SchedulerFunction\_HeatMap</code>*- **setSelectedDate** (date As Long) As String
*gets or sets the selected date  
 Call RefreshScheduler to commit changes*- **setSelectedDateColor** (Color As Int) As String
*Call RefreshScheduler to commit changes*- **setSelectedDateTextColor** (Color As Int) As String
*Call RefreshScheduler to commit changes*- **setShowWeekNumbers** (Show As Boolean) As String
*Gets or sets the number of visible weeks  
 Call RefreshScheduler to commit changes*- **setStartDate** (Date As Long) As String
*Gets or sets the start date  
 Call RefreshComplete if you change the StartDate*- **SetTheme** (Theme As ASScheduler\_Theme) As String
*DarkMode Example  
 <code>  
 Dim Theme As ASScheduler\_Theme  
 Theme.Initialize  
 'Background Colors  
 Theme.BackgroundColor\_Body = 0xFF202125  
 Theme.BackgroundColor\_Header = 0xFF131416  
 Theme.BackgroundColor\_WeekNumber = xui.Color\_ARGB(255,32, 33, 37)  
 Theme.BackgroundColor\_GridLine = 0x64FFFFFF  
 Theme.BackgroundColor\_Blackout = xui.Color\_ARGB(152,255,255,255)  
 'Text Colors  
 Theme.TextColor\_Header = xui.Color\_White  
 Theme.TextColor\_WeekNumber = xui.Color\_White  
 Theme.TextColor\_Day\_MonthView = xui.Color\_White  
 ASScheduler\_DayView1.SetTheme(Theme)  
 ASScheduler\_DayView1.RefreshScheduler  
 </code>  
 LightMode Example  
 <code>  
 Dim Theme As ASScheduler\_Theme  
 Theme.Initialize  
 'Background Colors  
 Theme.BackgroundColor\_Body = xui.Color\_White  
 Theme.BackgroundColor\_Header = xui.Color\_White  
 Theme.BackgroundColor\_Timeline = xui.Color\_White  
 Theme.BackgroundColor\_WeekNumber = xui.Color\_Gray  
 Theme.BackgroundColor\_GridLine = xui.Color\_ARGB(100,0,0,0)  
 Theme.BackgroundColor\_Blackout = xui.Color\_ARGB(152,0,0,0)  
 'Text Colors  
 Theme.TextColor\_Header = xui.Color\_Black  
 Theme.TextColor\_Timeline = xui.Color\_Black  
 Theme.TextColor\_WeekNumber = xui.Color\_Black  
 Theme.TextColor\_Day\_MonthView = xui.Color\_Black  
 ASScheduler\_DayView1.SetTheme(Theme)  
 ASScheduler\_DayView1.RefreshScheduler  
 </code>*- **setWeekNameShort** (WeekNameShort As ASScheduler\_WeekNameShort) As String
- **setWeekNumberProperties** (MonthView\_WeekNumberProperties As ASScheduler\_MonthView\_WeekNumberProperties) As String

- **Properties:**

- **API** As ASSchedulerAPI [read only]
*Gets the API*- **AppointmentProperties** As ASScheduler\_MonthView\_AppointmentProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>14dip</code>  
 Gap: <code>2dip</code>  
 LeftRightGap: <code>2dip</code>  
 CornerRadius: <code>3dip</code>  
 xFont: <code>xui.CreateDefaultFont(IIf(xui.IsB4i,12,10))</code>  
 TextColor: <code>xui.Color\_White</code>*- **BlackoutProperties** As ASScheduler\_MonthView\_BlackoutProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>2dip</code>  
 Color: <code>xui.Color\_ARGB(152,255,255,255)</code>*- **BodyColor**
*sets the body color  
 Call RefreshScheduler to commit changes*- **CurrentDateColor**
*Call RefreshScheduler to commit changes*- **CurrentDateTextColor**
*Call RefreshScheduler to commit changes*- **DayProperties** As ASScheduler\_MonthView\_DayProperties [read only]
- **HeaderColor**
*sets the Header Color*- **HeaderHeight** As Float
*Default: 40dip*- **HeaderTextProperties** As ASScheduler\_MonthView\_HeaderTextProperties
*Call RefreshHeader if you change something  
 Default Values  
 TextColor: <code>xui.Color\_White</code>  
 TextFont: <code>xui.CreateDefaultBoldFont(15)</code>  
 TextAlignment\_Vertical: <code>"CENTER"e</code>  
 TextAlignment\_Horizontal: <code>"CENTER"</code>  
 BackgroundColor: <code>m\_HeaderColor</code>*- **HeaderVisibility** As Boolean [read only]
- **HeatMapProperties** As ASScheduler\_MonthView\_HeatMapProperties [read only]
*Call RefreshScheduler if you change something  
 Default Values  
 xFont: <code>xui.CreateDefaultBoldFont(15)</code>  
 ColorCountList Example:  
 <code>  
 Dim HeatColor As List : HeatColor.Initialize  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,214, 230, 133),0,xui.Color\_White))  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,140, 198, 101),2,xui.Color\_White))  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,68, 163, 64),4,xui.Color\_White))  
 HeatColor.Add(ASSchedulerUtils.CreateASScheduler\_HeatMapColor(xui.Color\_ARGB(255,30, 104, 35),7,xui.Color\_White))  
 </code>*- **MinimalismProperties** As ASScheduler\_MonthView\_MinimalismProperties [read only]
*Call RefreshScheduler if you change something  
 Default Values  
 Height: <code>8dip</code>  
 Gap: <code>4dip</code>  
 BottomGap: <code>16dip</code>*- **MonthNameShort** As ASScheduler\_MonthNameShort
*Call RefreshScheduler if you change something  
 <code>ASScheduler\_MonthView1.MonthNameShort = ASSchedulerUtils.CreateASScheduler\_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>*- **NumberOfWeeks** As Int
*Gets or sets the number of visible weeks*- **SchedulerFunction** As String
*Changes the functionality of the scheduler  
 <code>ASScheduler\_MonthView1.SchedulerFunction = ASScheduler\_MonthView1.SchedulerFunction\_HeatMap</code>*- **SchedulerFunction\_Calendar** As String [read only]
*Normal mode, Appointments and Blackout days are displayed*- **SchedulerFunction\_HeatMap** As String [read only]
*A heatmap shows how the workload is on one day  
 The more appointments in a day, the darker is the color*- **SchedulerFunction\_Minimalism** As String [read only]
*Appointments are displayed as dots*- **SelectedDate** As Long
*gets or sets the selected date*- **SelectedDateColor**
*Call RefreshScheduler to commit changes*- **SelectedDateTextColor**
*Call RefreshScheduler to commit changes*- **ShowWeekNumbers**
*Gets or sets the number of visible weeks  
 Call RefreshScheduler to commit changes*- **StartDate** As Long
*Gets or sets the start date*- **WeekNameShort** As ASScheduler\_WeekNameShort
*Call RefreshHeader if you change something  
 <code>ASScheduler\_MonthView1.WeekNameShort = ASSchedulerUtils.CreateASScheduler\_WeekNameShort("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>*- **WeekNumberProperties** As ASScheduler\_MonthView\_WeekNumberProperties
*Call RefreshScheduler if you change something  
 Default Values  
 Width: <code>20dip</code>  
 Color: <code>xui.Color\_ARGB(255,32, 33, 37)</code>  
 xFont: <code>xui.CreateDefaultFont(15)</code>  
 TextColor: <code>xui.Color\_White</code>*
- **ASScheduler\_MonthView\_AppointmentProperties**

- **Fields:**

- **CornerRadius** As Float
- **Gap** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **LeftRightGap** As Float
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthView\_BlackoutProperties**

- **Fields:**

- **Color** As Int
- **GapBetween** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Width** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthView\_CustomDrawDay**

- **Fields:**

- **BackgroundPanel** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_Day** As B4XView
- **xpnl\_AppointmentBackground** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthView\_DayProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **TextFont** As B4XFont
- **TextFontCurrentDay** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthView\_HeaderTextProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextAlignment\_Horizontal** As String
- **TextAlignment\_Vertical** As String
- **TextColor** As Int
- **TextFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthView\_HeatMapProperties**

- **Fields:**

- **ColorCountList** As List
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ShowCounter** As Boolean
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthView\_MinimalismProperties**

- **Fields:**

- **BottomGap** As Float
- **Gap** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_MonthView\_WeekNumberProperties**

- **Fields:**

- **Color** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **Width** As Float
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_SpecialDay**

- **Fields:**

- **Date** As Long
- **Id** As Int
- **isAlways** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isRecurring** As Boolean
- **Name** As String
- **RecurringInterval** As Int
- **RecurringUnit** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_Theme**

- **Fields:**

- **BackgroundColor\_Blackout** As Int
- **BackgroundColor\_Body** As Int
- **BackgroundColor\_CurrentDate** As Int
- **BackgroundColor\_GridLine** As Int
- **BackgroundColor\_Header** As Int
- **BackgroundColor\_SelectedBlock** As Int
- **BackgroundColor\_SelectedDateColor\_MonthView** As Int
- **BackgroundColor\_Timeline** As Int
- **BackgroundColor\_WeekNumber** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor\_CurrentDate** As Int
- **TextColor\_Day\_MonthView** As Int
- **TextColor\_Header** As Int
- **TextColor\_SelectedDateColor** As Int
- **TextColor\_Timeline** As Int
- **TextColor\_WeekNumber** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScheduler\_WeekNameShort**

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
[/SPOILER]  
If you have features or something is still missing, let me know.  
**Changelog  
[SPOILER="Version 3.0-3.21"][/SPOILER]**[SPOILER="Version 3.0-3.21"]  

- **3.00 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-926393)**)**

- **MonthView**

- BugFixes
- Add Event "Created" - is triggered when the calendar is finished building

- If you call RefreshComplete once the calendar is ready, the event will be triggered

- Add RefreshComplete - Rebuilds the calendar
- Event improvements

- **DayView**

- Performance improvments
- Add Event "Created" - is triggered when the calendar is finished building
- Add get and set StartDate
- Add RefreshComplete - Rebuilds the calendar
- Breaking change: setDayCount needs now a RefreshComplete if you want to apply it

- **CalendarViewMonth**

- Add Designer Property "SchedulerFunction"

- Calendar - Normal DatePicker and the Appointments are displayed as circles under the date
- MonthView - Same function as the MonthView, the view is used on the whole height and width, the appointments are with text

- Add Events

- AppointmentClick
- AppointmentDoubleClick
- AppointmentLongClick
- AppointmentRightClick
- HiddenAppointmentClick
- HiddenAppointmentLongClick

- Add Properties

- get and set AppointmentProperties\_MonthView
- get and set BlackoutProperties
- get and set SchedulerFunction

- **3.01**

- **CalendarView**

- Add compatibility for [AS\_ViewPager](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/) Version 2.0

- **DayView**

- Add compatibility for [AS\_ViewPager](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/) Version 2.0

- **3.02**

- **General**

- Appointment Click Event BugFixes

- **CalendarView**

- BugFixes

- **MonthView**

- B4J BugFix Scroll2Date

- If the date is still within the range of the one already added, then it has scrolled one week too far. Unfortunately, it is not possible in B4J with such a long list, to land exactly on the item for which you have the index, it lands every time in release mode a week later or a week earlier.

- **3.03**

- **DayView**

- Add Designer Property StartHour - The calendar automatically scrolls to the set hour

- Default: 0

- Add Scroll2Hour

- **3.04**

- **DayView**

- BugFixes

- **3.05**

- **CalendarView**

- BugFixes

- **3.06**

- **CalendarView**

- BugFixes

- **3.07 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-950898)**)**

- **CalendarView**

- Add Event CustomHeaderText

- **3.08 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-964018)**)**

- **AgendaView**

- Theming BugFixes
- Add SetTheme - You now have all the colors for the view in one function
- Add 2 Examples for SetTheme

- Theme\_Dark
- Theme\_Light

- Add get isCreated - Returns true after you call CreateScheduler

- **3.09**

- **AgendaView**

- B4I BugFix

- **3.11 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-966527)**)**

- **CalendarView**

- BugFixes
- Performance Improvements

- **DayView**

- BugFixes
- Performance Improvements

- **MonthView**

- BugFixes
- Performance Improvements

- **AgendaView**

- BugFixes
- Performance Improvements

- **API**

- Add DeleteBlackoutOnDate
- Add GetBlackoutIdFromDate

- **3.12**

- **MonthView**

- Add get isCreated

- **DayView**

- BugFix
- Remove B4XCanvas - led to crashes if you swiped quickly

- **3.13**

- **DayView**

- BugFixes and Improvements

- **3.14**

- **General**

- BugFix for MacOS and Linux

- Breaking change if you use this lib. in MacOS or Linux, the database is in a new location in the system to avoid crashes

- **3.15 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-974372)**)**

- **DayView**

- Add Event CustomDrawAppointment
- BugFix on 12h Time System

- **MonthView**

- Add Event CustomDrawAppointment

- **AgendaView**

- Add Event CustomDrawAppointment

- **3.16**

- **MonthView**

- B4A BugFix

- **3.17 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-978753)**)**

- **API**

- Add BackupDatabase
- Add RestoreDatabase

- **3.18 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-978963)**)**

- **CalendarView**

- Add WeekNameProperties
- Add Event CustomDrawHeader

- **3.19 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-979807)**)**

- **DayView**

- Add Designer Property MultiDayAppointmentShowMode

- Default: OnTop

- Appointments that last longer than 1 day are now always displayed at the top.

- Previously, you had to scroll to the top of the list to make them visible
- This has caused confusion

- BugFixes and Performance Improvements

- **API**

- BugFix on GetAppointmentCountInRange

- **3.20**

- **DayView**

- New get FirstVisibleDay
- New get LastVisibleDay
- New VisibleDateRangeChanged Event

- **3.21**

- **DayView**

- New set CanSwipe - If “False” the swiping is deactivated
- New get and set AutoAppointmentTextColor - Automatically adjusts the text color of an appointment to the background color

- **MonthView**

- New get and set AutoAppointmentTextColor - Automatically adjusts the text color of an appointment to the background color

- **AgendaView**

- New get and set AutoAppointmentTextColor - Automatically adjusts the text color of an appointment to the background color

[/SPOILER]  

- **3.22**

- **Utils**

- **Removed** ASScheduler\_Theme

- **MonthView**

- **Removed** SetTheme
- **Removed** set HeaderColor -> is now in HeaderTextProperties
- New set Theme - You can now switch to Light or Dark mode
- New get Theme\_Dark
- New get Theme\_Light
- New Designer Property ThemeChangeTransition

- Default: None

- **DayView**

- **Removed** SetTheme
- New set Theme - You can now switch to Light or Dark mode
- New get Theme\_Dark
- New get Theme\_Light
- New Designer Property ThemeChangeTransition

- Default: None

- **AgendaView**

- **Removed** SetTheme
- New set Theme - You can now switch to Light or Dark mode
- New get Theme\_Dark
- New get Theme\_Light
- New Designer Property ThemeChangeTransition

- Default: None

- New Designer Property CurrentDateTextColor

- Default: Black

- Change Designer Property CurrentDateColor default value to WHITE

- **CalendarView**

- **Removed** "HeaderColor", is now in the ASScheduler\_CalendarView\_HeaderProperties type
- **Removed** SetTheme
- New set Theme - You can now switch to Light or Dark mode
- New get Theme\_Dark
- New get Theme\_Light
- New Designer Property ThemeChangeTransition

- Default: None

Have Fun :)  
<https://payhip.com/b/nrtw5>