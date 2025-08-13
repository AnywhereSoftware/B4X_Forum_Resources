### Date Converter Library by shrs
### 12/05/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/164493/)

Hi guys! I apologize if my English is not very good. :)  
Some time ago, I found a code in VB6 at [this address](https://www.vojoudi.com/vb/vb_date_per.htm) that converts Gregorian dates to Hebrew, lunar, and solar dates. The code is very accurate and effective. So I wanted to convert it for B4J. However, there was a problem that sometimes the converted code made incorrect calculations. After much investigation, I realized that the data types and functions in VB6 are different from B4J.  
For example, the **Cint()** function in VB6 does not always return the integer part of a decimal number and sometimes rounds the number. For example, **Cint(2.5)** equals 2, but **Cint(1.5)** does not equal 1, and the output of the function is 2. And the output of **Cint(1.4)** equals 1. In fact, the Cint function in VB6 rounds the number to the nearest even number at the boundary of 0.5 between two numbers. While **As(int)** in B4J returns the integer part of the decimal number.  
I finally solved its problems one by one and turned it into a library for B4J. I hope it will be useful.  
  
This library includes the following classes:  
  
**RzvDateConverter\_B4J  
Author: S.Hossein.Razavi.S  
Version: 1.00**  

- **JulianDate**

- **Initialize** As JulianDate
- **SetDate**(year As Int, month As Int, day As Int) As JulianDate
- **Copy** As JulianDate
- **DayOfMonth** As Int
- **Month** As Int
- **Year** As Int
- **JDN** As Long
*Julian days number value*- **ToString** As String
*Shows the date in yyyy/MM/dd format*- **IsLeapYear** As Boolean
- **IsLeapYear2**(year As Int) As Boolean
- **ToHijriDate** As HijriDate
*Converts the date to the lunar hijri date*- **ToIslamicDate** As IslamicDate
*Converts the date to the lunar hijri date*- **ToPersianDate** As PersianDate
*Converts the date to the solar hijri (jalali) date*- **ToCivilDate** As CivilDate
*Converts the date to the civil date*- **ToGregorianDate** As GregorianDate
*Converts the date to the Gregorian date*- **ToHebrewDate** As HebrewDate
*Converts the date to the Hebrew date*- **ToDateTime** As Long
*Converts the date to the Date and Time (in b4x)*- **AddDays**(days As Int) As JulianDate
- **AddMonths**(months As Int) As JulianDate
- **AddYears**(years As Int) As JulianDate
- **DayOfWeek** As Int
*Returns the number of the weekday from Monday (1 means Monday and 7 means Sunday)*- ***WeekDayName** As String*
*Returns the name of the weekday*- **DaysInYear** As Int
- **DaysInYear2**(year As Int) As Int
- **DaysOfYear** As Int
- **DaysInMonth** As Int
- **DaysInMonth2**(year As Int, month As Int) As Int
- **DateDifference**(tDate As JulianDate) As Long
- **DateDifference2**(tDate1 As JulianDate, tDate2 As JulianDate) As Long
- **GetWeekOfYear**(firstDayOfWeek As Int) As Int
- **GetWeekOfYear2**(targetDate As JulianDate, firstDayOfWeek As Int) As Int

- **GregorianDate**

- **Initialize** As GregorianDate
- **SetDate**(year As Int, month As Int, day As Int) As GregorianDate
- **Copy** As GregorianDate
- **DayOfMonth** As Int
- **Month** As Int
- **Year** As Int
- **JDN** As Long
*Julian days number value*- **ToString** As String
*Shows the date in yyyy/MM/dd format*- **IsLeapYear** As Boolean
- **IsLeapYear2**(year As Int) As Boolean
- **ToHijriDate** As HijriDate
*Converts the date to the lunar hijri date*- **ToIslamicDate** As IslamicDate
*Converts the date to the lunar hijri date*- **ToPersianDate** As PersianDate
*Converts the date to the solar hijri (jalali) date*- **ToJulianDate** As JulianDate
*Converts the date to the Julian date*- **ToCivilDate** As CivilDate
*Converts the date to the Gregorian (Civil) date*- **ToHebrewDate** As HebrewDate
*Converts the date to the Hebrew date*- **ToDateTime** As Long
*Converts the date to the Date and Time (in b4x)*- **AddDays**(days As Int) As GregorianDate
- **AddMonths**(months As Int) As GregorianDate
- **AddYears**(years As Int) As GregorianDate
- **DayOfWeek** As Int
*Returns the number of the weekday from Monday (1 means Monday and 7 means Sunday)*- ***WeekDayName** As String*
*Returns the name of the weekday*- **DaysInYear** As Int
- **DaysInYear2**(year As Int) As Int
- **DaysOfYear** As Int
- **DaysInMonth** As Int
- **DaysInMonth2**(year As Int, month As Int) As Int
- **DateDifference**(tDate As GregorianDate) As Long
- **DateDifference2**(tDate1 As GregorianDate, tDate2 As GregorianDate) As Long
- **GetWeekOfYear**(firstDayOfWeek As Int) As Int
- **GetWeekOfYear2**(targetDate As GregorianDate, firstDayOfWeek As Int) As Int

- **CivilDate**

- **Initialize** As CivilDate
- **SetDate**(year As Int, month As Int, day As Int) As CivilDate
- **Copy** As CilivilDate
- **DayOfMonth** As Int
- **Month** As Int
- **Year** As Int
- **JDN** As Long
*Julian days number value*- **ToString** As String
*Shows the date in yyyy/MM/dd format*- **IsLeapYear** As Boolean
- **IsLeapYear2**(year As Int) As Boolean
- **ToHijriDate** As HijriDate
*Converts the date to the lunar hijri date*- **ToIslamicDate** As IslamicDate
*Converts the date to the lunar hijri date*- **ToPersianDate** As PersianDate
*Converts the date to the solar hijri (jalali) date*- **ToJulianDate** As JulianDate
*Converts the date to the Julian date*- **ToGregorianDate** As GregorianDate
*Converts the date to the Gregorian date*- **ToHebrewDate** As HebrewDate
*Converts the date to the Hebrew date*- **ToDateTime** As Long
*Converts the date to the Date and Time (in b4x)*- **AddDays**(days As Int) As CivilDate
- **AddMonths**(months As Int) As CivilDate
- **AddYears**(years As Int) As CivilDate
- **DayOfWeek** As Int
*Returns the number of the weekday from Monday (1 means Monday and 7 means Sunday)*- ***WeekDayName** As String*
*Returns the name of the weekday*- **DaysInYear** As Int
- **DaysInYear2**(year As Int) As Int
- **DaysOfYear** As Int
- **DaysInMonth** As Int
- **DaysInMonth2**(year As Int, month As Int) As Int
- **DateDifference**(tDate As CivilDate) As Long
- **DateDifference2**(tDate1 As CivilDate, tDate2 As CivilDate) As Long
- **GetWeekOfYear**(firstDayOfWeek As Int) As Int
- **GetWeekOfYear2**(targetDate As CivilDate, firstDayOfWeek As Int) As Int

- **IslamicDate**

- **Initialize** As IslamicDate
- **SetDate**(year As Int, month As Int, day As Int) As IslamicDate
- **Copy** As IslamicDate
- **DayOfMonth** As Int
- **Month** As Int
- **Year** As Int
- **JDN** As Long
*Julian days number value*- **ToString** As String
*Shows the date in yyyy/MM/dd format*- **IsLeapYear** As Boolean
- **IsLeapYear2**(year As Int) As Boolean
- **ToHijriDate** As HijriDate
*Converts the date to the lunar hijri date*- **ToCivilDate** As CivilDate
*Converts the date to the Civil (Gregorian) date*- **ToPersianDate** As PersianDate
*Converts the date to the solar hijri (jalali) date*- **ToJulianDate** As JulianDate
*Converts the date to the Julian date*- **ToGregorianDate** As GregorianDate
*Converts the date to the Gregorian date*- **ToHebrewDate** As HebrewDate
*Converts the date to the Hebrew date*- **ToDateTime** As Long
*Converts the date to the Date and Time (in b4x)*- **AddDays**(days As Int) As IslamicDate
- **AddMonths**(months As Int) As IslamicDate
- **AddYears**(years As Int) As IslamicDate
- **DayOfWeek** As Int
*Returns the number of the weekday from Monday (1 means Monday and 7 means Sunday)*- ***WeekDayName** As String*
*Returns the name of the weekday*- **DaysInYear** As Int
- **DaysInYear2**(year As Int) As Int
- **DaysOfYear** As Int
- **DaysInMonth** As Int
- **DaysInMonth2**(year As Int, month As Int) As Int
- **DateDifference**(tDate As IslamicDate) As Long
- **DateDifference2**(tDate1 As IslamicDate, tDate2 As IslamicDate) As Long
- **GetWeekOfYear**(firstDayOfWeek As Int) As Int
- **GetWeekOfYear2**(targetDate As IslamicDate, firstDayOfWeek As Int) As Int

- **HijriDate**

- **Initialize** As HijriDate
- **SetDate**(year As Int, month As Int, day As Int) As HijriDate
- **Copy** As HijriDate
- **DayOfMonth** As Int
- **Month** As Int
- **Year** As Int
- **JDN** As Long
*Julian days number value*- **ToString** As String
*Shows the date in yyyy/MM/dd format*- **IsLeapYear** As Boolean
- **IsLeapYear2**(year As Int) As Boolean
- **ToIslamicDate** As IslamicDate
*Converts the date to the lunar hijri date*- **ToCivilDate** As CivilDate
*Converts the date to the Civil date*- **ToPersianDate** As PersianDate
*Converts the date to the solar hijri (jalali) date*- **ToJulianDate** As JulianDate
*Converts the date to the Julian date*- **ToGregorianDate** As GregorianDate
*Converts the date to the Gregorian date*- **ToHebrewDate** As HebrewDate
*Converts the date to the Hebrew date*- **ToDateTime** As Long
*Converts the date to the Date and Time (in b4x)*- **AddDays**(days As Int) As HijriDate
- **AddMonths**(months As Int) As HijriDate
- **AddYears**(years As Int) As HijriDate
- **DayOfWeek** As Int
*Returns the number of the weekday from Monday (1 means Monday and 7 means Sunday)*- ***WeekDayName** As String*
*Returns the name of the weekday*- **DaysInYear** As Int
- **DaysInYear2**(year As Int) As Int
- **DaysOfYear** As Int
- **DaysInMonth** As Int
- **DaysInMonth2**(year As Int, month As Int) As Int
- **DateDifference**(tDate As HijriDate) As Long
- **DateDifference2**(tDate1 As HijriDate, tDate2 As HijriDate) As Long
- **GetWeekOfYear**(firstDayOfWeek As Int) As Int
- **GetWeekOfYear2**(targetDate As HijriDate, firstDayOfWeek As Int) As Int

- **PersianDate**

- **Initialize** As PersianDate
- **SetDate**(year As Int, month As Int, day As Int) As PersianDate
- **Copy** As PersianDate
- **DayOfMonth** As Int
- **Month** As Int
- **Year** As Int
- **JDN** As Long
*Julian days number value*- **ToString** As String
*Shows the date in yyyy/MM/dd format*- **IsLeapYear** As Boolean
- **IsLeapYear2**(year As Int) As Boolean
- **ToHijriDate** As HijriDate
*Converts the date to the lunar hijri date*- **ToCivilDate** As CivilDate
*Converts the date to the Civil date*- **ToIslamicDate** As IslamicDate
*Converts the date to the lunar hijri date*- **ToJulianDate** As JulianDate
*Converts the date to the Julian date*- **ToGregorianDate** As GregorianDate
*Converts the date to the Gregorian date*- **ToHebrewDate** As HebrewDate
*Converts the date to the Hebrew date*- **ToDateTime** As Long
*Converts the date to the Date and Time (in b4x)*- **AddDays**(days As Int) As PersianDate
- **AddMonths**(months As Int) As PersianDate
- **AddYears**(years As Int) As PersianDate
- **DayOfWeek** As Int
*Returns the number of the weekday from Monday (1 means Monday and 7 means Sunday)*- ***WeekDayName** As String*
*Returns the name of the weekday*- **DaysInYear** As Int
- **DaysInYear2**(year As Int) As Int
- **DaysOfYear** As Int
- **DaysInMonth** As Int
- **DaysInMonth2**(year As Int, month As Int) As Int
- **DateDifference**(tDate As PersianDate) As Long
- **DateDifference2**(tDate1 As PersianDate, tDate2 As PersianDate) As Long
- **GetWeekOfYear**(firstDayOfWeek As Int) As Int
- **GetWeekOfYear2**(targetDate As PersianDate, firstDayOfWeek As Int) As Int

- **HebrewDate**

- **Initialize** As HebrewDate
- **SetDate**(year As Int, month As Int, day As Int) As HebrewDate
- **Copy** As HebrewDate
- **DayOfMonth** As Int
- **Month** As Int
- **Year** As Int
- **JDN** As Long
*Julian days number value*- **ToString** As String
*Shows the date in yyyy/MM/dd format*- **IsLeapYear** As Boolean
- **IsLeapYear2**(year As Int) As Boolean
- **ToHijriDate** As HijriDate
*Converts the date to the lunar hijri date*- **ToCivilDate** As CivilDate
*Converts the date to the Civil date*- **ToIslamicDate** As IslamicDate
*Converts the date to the lunar hijri date*- **ToJulianDate** As JulianDate
*Converts the date to the civil date*- **ToGregorianDate** As GregorianDate
*Converts the date to the Gregorian date*- **ToPersianDate** As PersianDate
*Converts the date to the *solar hijri (jalali)* date*- **ToDateTime** As Long
*Converts the date to the Date and Time (in b4x)*- **AddDays**(days As Int) As HebrewDate
- **AddMonths**(months As Int) As HebrewDate
- **AddYears**(years As Int) As HebrewDate
- **DayOfWeek** As Int
*Returns the number of the weekday from Monday (1 means Monday and 7 means Sunday)*- ***WeekDayName** As String*
*Returns the name of the weekday*- **DaysInYear** As Int
- **DaysInYear2**(year As Int) As Int
- **DaysOfYear** As Int
- **DaysInMonth** As Int
- **DaysInMonth2**(year As Int, month As Int) As Int
- **DateDifference**(tDate As HebrewDate) As Long
- **DateDifference2**(tDate1 As HebrewDate, tDate2 As HebrewDate) As Long
- **GetWeekOfYear**(firstDayOfWeek As Int) As Int
- **GetWeekOfYear2**(targetDate As HebrewDate, firstDayOfWeek As Int) As Int

  
**Changelog**  

- **1.00**

- Release

  
The following example shows how to use the library:  

```B4X
Private Sub button1_Click  
    Dim dt1 As CivilDate  
    Log (dt1.Initialize.ToString) ' Returns 2024/12/05  
    Log (dt1.AddDays(7).ToHebrewDate.ToString) 'Returns 5785/03/11  
End Sub
```

  
  
Please test it, friends, and if there are any bugs or issues, let me know so I can fix them. If you have any ideas on how to improve this library, please share them. Thanks.