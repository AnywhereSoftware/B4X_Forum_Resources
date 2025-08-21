###  isCurrentMonth, isSameYear, isSameWeek, isLastWeek by Alexander Stolte
### 05/31/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/118350/)

can certainly still be optimized.  
  

```B4X
Private Sub isCurrentMonth(ticks As Long) As Boolean  
    Return DateTime.GetYear(ticks) = DateTime.GetYear(DateTime.Now) And DateTime.GetMonth(ticks) = DateTime.GetMonth(DateTime.Now)  
End Sub
```

  
  

```B4X
Private Sub isSameYear(ticks_1 As Long,ticks_2 As Long) As Boolean  
    DateTime.GetYear(ticks_1) = DateTime.GetYear(ticks_2)  
End Sub
```

  
  

```B4X
Private Sub isSameWeek(week_ticks As Long,ticks As Long) As Boolean  
    Dim p As Period  
    p.Days = -((DateTime.GetDayOfWeek(week_ticks)+6) Mod 5)  
    Return ticks > DateUtils.AddPeriod(week_ticks, p)  
End Sub
```

  
  

```B4X
Private Sub isLastWeek(week_ticks As Long,ticks As Long) As Boolean  
    Dim p_begin_lastweek As Period  
    p_begin_lastweek.Days = (-((DateTime.GetDayOfWeek(week_ticks)+6) Mod 5)) - 7  
    Dim p_end_lastweek As Period  
    p_end_lastweek.Days = -((DateTime.GetDayOfWeek(week_ticks)+6) Mod 5)  
    Return ticks > DateUtils.AddPeriod(week_ticks, p_begin_lastweek) And ticks < DateUtils.AddPeriod(week_ticks, p_end_lastweek)  
End Sub
```