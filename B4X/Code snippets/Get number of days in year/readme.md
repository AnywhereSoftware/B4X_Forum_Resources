###  Get number of days in year by Alexander Stolte
### 11/28/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/149406/)

```B4X
Public Sub GetNumberOfDaysInYear(Year As Int) As Int  
    Return DateUtils.PeriodBetweenInDays(DateUtils.SetDate(Year,1,1),DateUtils.SetDate(Year,12,DateUtils.NumberOfDaysInMonth(12,Year))).Days +1  
End Sub
```

  
or  

```B4X
Public Sub GetNumberOfDaysInYear2(Year As Int) As Int  
    Return DateTime.GetDayOfYear(DateUtils.SetDate(Year,12,31))  
End Sub
```

  
or  
from [USER=103273]@mcqueccu[/USER]  

```B4X
Public Sub GetNumberOfDaysInYear3(Year As Int) As Int  
    DateTime.DateFormat = "yyyy/MM/dd"  
    Dim d As Long = DateTime.DateParse($"${Year}/12/31"$)  
    Return DateTime.GetDayOfYear(d)  
End Sub
```

  
or  
from [USER=121302]@epiCode[/USER]  

```B4X
Sub GetDaysInYear(year As Int) As Int  
    Return IIf((year Mod 4 = 0 And year Mod 100 <> 0) Or year Mod 400 = 0, 366, 365)  
End Sub
```