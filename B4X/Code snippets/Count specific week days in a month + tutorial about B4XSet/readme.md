###  Count specific week days in a month + tutorial about B4XSet by Erel
### 12/09/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/125380/)

Depends on DateUtils and B4XCollections:  

```B4X
Sub CountSpecificDaysInMonth (Year As Int, Month As Int, RelevantDays As B4XSet) As Int  
    Dim day As Long = DateUtils.SetDate(Year, Month, 1)  
    Dim p As Period  
    p.Days = 1  
    Dim total As Int  
    Do While DateTime.GetMonth(day) = Month  
        If RelevantDays.Contains(DateTime.GetDayOfWeek(day)) Then total = total + 1  
        day = DateUtils.AddPeriod(day, p)  
    Loop  
    Return total  
End Sub
```

  
  
Usage example:  

```B4X
Sub AppStart (Args() As String)  
    Dim InterestingDays As B4XSet = B4XCollections.CreateSet2(Array(1, 2, 3, 4, 5)) 'number of days excluding Friday and Saturday  
    Log(CountSpecificDaysInMonth(2020, 12, InterestingDays)) 'December 2020  
End Sub
```