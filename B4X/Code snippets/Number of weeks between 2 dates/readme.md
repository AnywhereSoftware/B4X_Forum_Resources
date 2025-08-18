###  Number of weeks between 2 dates by Alexander Stolte
### 01/16/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/137662/)

```B4X
Public Sub NumberOfWeeksBetween(StartDate As Long,EndDate As Long) As Int  
    Return Round(DateUtils.PeriodBetweenInDays(StartDate,EndDate).Days / 7)  
End Sub
```