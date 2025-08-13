###  Elapsed Days between 2 dates with Specific Days in Month by Brian Michael
### 06/29/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/161865/)

Hi everyone, based on [USER=1]@Erel[/USER] example [HERE](https://www.b4x.com/android/forum/threads/days-elapsed-in-a-month.125357/post-782808) i edit the code for get what title says.  
  
  

```B4X
Public Sub ElapsedDaysInMonth (FirstDay As Long, LastDay As Long, RelevantDays As B4XSet) As Int  
      
    Dim Day As Long = DateUtils.SetDate(DateTime.GetYear(FirstDay), DateTime.GetMonth(FirstDay), DateTime.GetDayOfMonth(FirstDay))  
    Dim p As Period : p.Days = 1  
    Dim total As Int  
    Do While DateTime.GetMonth(Day) = DateTime.GetMonth(LastDay)  
        If RelevantDays.Contains(DateTime.GetDayOfWeek(Day)) Then total = total + 1  
        Day = DateUtils.AddPeriod(Day, p)  
    Loop  
    Return total  
End Sub
```

  
  

```B4X
Dim ID As B4XSet = B4XCollections.CreateSet2(Array(1, 2, 3, 4, 5)) 'number of days excluding Friday and Saturday  
Dim elapDays As Int = ElapsedDaysInMonth(Date1,Date2,ID)
```