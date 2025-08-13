###  Get month from day of year by Alexander Stolte
### 08/03/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/149410/)

```B4X
Public Sub GetMonthFromDayOfYear(DayOfYear As Int,Year As Int) As Int  
    
    Dim p As Period  
    p.Initialize  
    p.Days = DayOfYear -1  
    'Log(DateUtils.TicksToString(DateUtils.AddPeriod(DateUtils.SetDate(Year,1,1),p)))  
    Return DateTime.GetMonth(DateUtils.AddPeriod(DateUtils.SetDate(Year,1,1),p))  
    
End Sub
```

  
Example:  

```B4X
Log(GetMonthFromDayOfYear(1,2023)) '1 = January  
Log(GetMonthFromDayOfYear(31,2023)) '1 = January  
Log(GetMonthFromDayOfYear(32,2023)) '2 = February
```