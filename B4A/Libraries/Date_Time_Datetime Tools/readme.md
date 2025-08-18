### Date/Time/Datetime Tools by Guenter Becker
### 04/08/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/129500/)

This is a B4A Class with a collection of **needful functions around Dates and Times.** Please use it, modify or enhance it at your individual needs.  
  
**Version: 1/2021  
  
Install**:  
a) FIle: Open your project and import appended file by using Menu 'Project/New Module/Append existing modul'.  
b) File: copy file in your additional library folder. Open Project and mark DateToolsV1 in library Window  
**Libs:** depends on Core and XUI  
**Usage:** declare instance of the class in '…Globals" like *Dim DT as DateTools*  
**a) File**: DateTools.bas (Type B4A Class)  
**b) File**: DateTools.B4xLib  
  
**[SIZE=5]Functions Overview:[/SIZE]**  

- **convertMinutes**, converts given minutes to string HH:mm
- **compareDate**, checks 2 dates if =,<,>,<=,>=
- **compareTime**, checks 2 times if =,<,>,<=,>=
- **compareDateTime**, checks 2 datetimes if =, <,>,<=,>=
- **checkDate**, checks if given date string has correct format (DateTime.DateFormat)
- **checkTime**, checks if given time string has correct format (DateTime.TimeFormat)
- **checkDateTime**, checks if given date and time string has correct format (DateTime.DateFormat, DateTime.TimeFormat)
- **getDateTick**, returns tick value of given date string (since 1970/01/01 00:00:00)
- **getTimeTick**, returns tick value of given time string (current date leapsed from 00:00:00)
- **getDateTimeTick**, returns tick value of given datetime string
- **getTick2Date**, returns date string of given tick value
- **getTick2Time**, returns time string of given tick value
- **getTick2DateTime**, returns datetime string of given tick value (Date Time)
- **getStartSummertime**, returns date where European Summertime starts
- **getStartWintertime**, returns date where European Wintertime starts
- **getUTC**, get current date and UTC Time respect Summertime or not (like yyyy/MM/dd HH:mm:ss Z or yyyy/MM/dd HH:mm:ss ZS -S=Summertime-)
- **getDatePeriode**, get target date of added/subtracted Periode (Years,Month,Days,Weeks,Quarters) to given date
- **getDaysBetween**, get the count of days between 2 dates
- **getMonthBetween**, get the count of month between 2 dates
- **getHoursBetween**, compute hours between 2 times
- **getMinutesBetween**, compute minutes between 2 times
- **getWeekNumber**, get the yearly week number of a given date

  
**Notice**:  

- Prior using a function set the needed Date and/or Time Format like DateTime.DateFormat= or DateTime.TimeFormat= in your code. This format will be saved. Internally the functions will work with ("yyyy/MM/dd" and "HH:mm:ss") at the end of the functions the internal format setting is resetted by the saved format.

  
Proposals, Comments are welcome. If you detect errors please give me a kick to solve. Thank you.