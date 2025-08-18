###  DateUtils - Simplifies Date and Time Calcuations by Erel
### 02/07/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/26290/)

DateUtils is a code module with a set of useful date and time related methods.  
It complements DateTime api, it doesn't replace it.  
  
The methods included in DateUtils:  
  

```B4X
'Calculates the period between two date instances.  
'This method returns a Period type with years, months, days, hours, minutes, seconds.  
Sub PeriodBetween(Start As Long, EndTime As Long) As Period  
  
'Calculates the period between two date instances.  
'This method returns a Period type with days, hours, minutes, seconds  
Sub PeriodBetweenInDays (Start As Long, EndTime As Long) As Period  
  
'Returns the month name of the given date.  
'Similar To DateTime.GetMonth which returns the month as an integer.  
Sub GetMonthName(Ticks As Long) As String  
  
'Returns the day of week name.  
'Similar to DateTime.GetDayOfWeek which returns the day of week as an integer.  
Sub GetDayOfWeekName(Ticks As Long) As String  
  
'Returns a list with the week days names, using the device set locale.  
Sub GetDaysNames As List  
  
'Returns a list with the months names, using the device set locale.  
Sub GetMonthsNames As List  
  
'Returns the ticks value of the given date (the time will be 00:00:00).  
Sub SetDate(Years As Int, Months As Int, Days As Int) As Long  
  
'Returns the ticks value of the given date and time  
Sub SetDateAndTime(Years As Int, Months As Int, Days As Int, Hours As Int, Minutes As Int, Seconds As Int) As Long  
  
'Returns the ticks value of the given date and time with the specified time zone offset.  
'The last parameter is the time zone offset measured in hours.  
Public Sub SetDateAndTime2(Years As Int, Months As Int, Days As Int, Hours As Int, Minutes As Int, Seconds As Int, _  
      TimeZone As Double) As Long  
  
'Returns the number of days in the given month  
Sub NumberOfDaysInMonth(Month As Int, Year As Int) As Int  
  
'Adds a Period to the given date instance. Do not forget to assign the result.  
Sub AddPeriod(Ticks As Long, Per As Period) As Long  
  
'Tests whether the two ticks values represent the same day.  
Sub IsSameDay(Ticks1 As Long, Ticks2 As Long) As Boolean  
  
'Converts ticks value to unix time.  
Sub TicksToUnixTime(Ticks As Long) As Long  
  
'Converts unix time to ticks value.  
Sub UnixTimeToTicks(UnixTime As Long) As Long
```

  
  
DateUtils includes a type named Period:  

```B4X
Type Period (Years As Int, Months As Int, _  
      Days As Int, Hours As Int, Minutes As Int, Seconds As Int)
```

  
  
You can use PeriodBetween method to get the Period between two dates.  
AddPeriod method adds a Period to a given date instance.  
  
The DateUtils module is included in the attached example.  
  
**v1.05**: Adds SetDateAndTime2. Allows you to explicitly set the time zone.  
  
**v1.03**: Fixes a bug in NumberOfDaysInMonth method.  
  
**v1.02**: Fixes a locale related bug (SetDate and SetDateAndTime).  
  
**v1.01**: Adds PeriodBetweenInDays - Similar to PeriodBetween however the years and months will be zero (days field will be larger as needed).  
This version also fixes a bug in SetDateAndTime related to DST  
  
**Starting from B4A v2.70, DateUtils is included as a library in the IDE.**