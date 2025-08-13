### SQL Server - Convert SQL Server Datetime Value to Unix Datetime and vice versa by hatzisn
### 11/04/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143939/)

It requires jDateUtils library  
  

```B4X
Sub GetDatetimeValueSqlServerFromUnixDatetime(dt As Long) As Double  
    Dim p As Period =  DateUtils.PeriodBetweenInDays(DateTime.DateTimeParse("1/1/1900", "0:0:0"), dt)  
    Return p.Days + ((p.Hours * 3600 + p.Minutes * 60 + p.Seconds)/(3600*24))  
End Sub  
  
Sub GetDatetimeValueUnixFromSqlServerDatetime(days As Double) As Long  
    Dim p As Period  
    p.Initialize  
      
    p.Days = Floor(days)  
    p.Seconds = Floor((days - p.Days) * (3600*24))  
      
    Return DateUtils.AddPeriod(DateTime.DateTimeParse("1/1/1900", "0:0:0"), p)  
End Sub
```