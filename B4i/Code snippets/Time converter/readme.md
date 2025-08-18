### Time converter by Filippo
### 07/31/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/142081/)

Hi,  
  
today I would like to provide my own routines for time conversion.  
All these routines can be inserted into a library or a code module.  
  

```B4X
Public Sub getConvertTickTo_HHmmss(time As Long) As String  
    Dim vorzeichen As String=""  
    Dim h,m,s As Int  
    Dim t As Long=Abs(time)  
    If time < 0 Then vorzeichen="-"  
    s = Bit.FMod(t/1000,60)  
    m = Bit.FMod(t/60000, 60)  
    h = Bit.FMod(t/3600000,24)  
    Return vorzeichen & NumberFormat(h,2,0) & ":" & NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0)  
End Sub  
  
Public Sub getConvertTickTo_mmss(time As Long) As String  
    Dim vorzeichen As String=""  
    Dim m,s As Int  
    Dim t As Long = Abs(time)  
    If time < 0 Then vorzeichen="-"  
    s = Bit.FMod(t/1000,60)  
    m = Bit.FMod(t/60000,60)  
    Return vorzeichen & NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0)  
End Sub  
  
Public Sub getConvertTickTo_mssz(time As Long) As String  
    Dim vorzeichen As String=""  
    Dim m,s,zs As Int  
    Dim t As Long = Abs(time)  
    If time < 0 Then vorzeichen="-"  
    s = Bit.FMod(t/1000, 60)  
    m = Bit.FMod(t/60000, 60)  
    zs = Bit.FMod(t, 1000)  
    Return vorzeichen & NumberFormat(m,1,0) & ":" & NumberFormat(s,2,0) & "." & NumberFormat(zs,3,0).SubString2(0,1)  
End Sub  
  
Public Sub getConvertTickTo_msszz(time As Long) As String  
    Dim vorzeichen As String=""  
    Dim m,s,zs As Int  
    Dim t As Long=Abs(time)  
    If time < 0 Then vorzeichen="-"  
    s = Bit.FMod(t/1000, 60)  
    m = Bit.FMod(t/60000, 60)  
    zs = Bit.FMod(t, 1000)  
    Return vorzeichen & NumberFormat(m,1,0) & ":" & NumberFormat(s,2,0) & "." & NumberFormat(zs,3,0).SubString2(0,2)  
End Sub  
  
Public Sub getConvertTickTo_sszz(time As Long) As String  
    Dim vorzeichen As String=""  
    Dim m,s,zs As Int  
    Dim t As Long=Abs(time)  
    If time < 0 Then vorzeichen="-"  
    s = Bit.FMod(t/1000, 60)  
    m = Bit.FMod(t/60000, 60)  
    zs = Bit.FMod(t, 1000)  
    If m > 0 Then  
        s = s + m * 60  
    End If  
    Return vorzeichen & NumberFormat(s,1,0) & "." & NumberFormat(zs,3,0).SubString2(0,2)  
End Sub  
  
Public Sub getConvertTickTo_zs(t As Long) As String  
    Dim zs As Int  
    Dim time As Long  
    time=Abs(t)  
    zs = Bit.FMod(time/10, 100)  
    Return NumberFormat(zs,2,0)  
End Sub  
  
Public Sub getConvertTickTo_HHmmsszs(time As Long) As String  
    Dim vorzeichen As String=""  
    Dim h,m,s,zs As Int  
    Dim t As Long=Abs(time)  
    If time < 0 Then vorzeichen="-"  
    zs = Bit.FMod(t/10,100)  
    s = Bit.FMod(t/1000,60)  
    m = Bit.FMod(t/60000,60)  
    h = Bit.FMod(t/3600000,24)  
    Return vorzeichen & NumberFormat(h,2,0) & ":" & NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0) & "." & NumberFormat(zs,2,0)  
End Sub  
  
Public Sub getConvertTickTo_HHmmssus(time As Long) As String  
    Dim h,m,s,us As Int  
    us = Bit.FMod(time/10, 100)  
    s = Bit.FMod(time/1000, 60)  
    m = Bit.FMod(time/60000, 60)  
    h = Bit.FMod(time/3600000, 24)  
    Return NumberFormat(h,1,0) & ":" & NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0) & "." & NumberFormat(us,2,0)  
End Sub  
  
Public Sub getConvertTickTo_mmsszs(time As Long) As String  
    Dim m,s,us As Int  
    us = Bit.FMod(time/10, 100)  
    s = Bit.FMod(time/1000, 60)  
    m = Bit.FMod(time/60000, 60)  
    Return NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0) & "." & NumberFormat(us,2,0)  
End Sub  
  
Public Sub getConvertTickTo_mmssus(time As Long) As String  
    Dim m,s,us As Int  
    us = Bit.FMod(time/10,100)  
    s = Bit.FMod(time/1000, 60)  
    m = Bit.FMod(time/60000, 60)  
    Return NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0) & "." & NumberFormat(us,2,0)  
End Sub  
  
Public Sub getConvertTickTo_HHmmssms(time As Long, Precision As Int) As String  
    Dim vorzeichen As String=""  
    Dim h,m,s,zs As Int  
    Dim ms As String  
    Dim t As Long=Abs(time)  
    If time < 0 Then vorzeichen="-"  
    zs = Bit.FMod(t,1000)  
    s = Bit.FMod(t/1000,60)  
    m = Bit.FMod(t/60000,60)  
    h = Bit.FMod(t/3600000,24)  
    ms = NumberFormat(zs,3,0)  
    'Log("zs=" & NumberFormat(zs,3,0))  
    If Precision = -1 Then  
        Return vorzeichen & NumberFormat(h,2,0) & ":" & NumberFormat(m,2,0)  
    else If Precision = 0 Then  
        Return vorzeichen & NumberFormat(h,2,0) & ":" & NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0)  
    Else  
        Return vorzeichen & NumberFormat(h,2,0) & ":" & NumberFormat(m,2,0) & ":" & NumberFormat(s,2,0) & "." & ms.SubString2(0,Precision)  
    End If  
End Sub  
  
Public Sub getConvertTickTo_dec(time As Long) As Int  
    Dim t As Long=Abs(time)  
    Dim ms As String = NumberFormat(Bit.FMod(t,1000),3,0)  
    Dim n As Int = ms.SubString2(0,1)  
    Return n  
End Sub  
  
Public Sub getConvertTimeStringToLong(time As String) As Long  
    Dim ltime As Long  
    Dim millis As Int  
    Dim DateFormat As String = DateTime.DateFormat  
    Dim timeformat As String = DateTime.TimeFormat  
    DateTime.DateFormat = "yyyy.MM.dd"  
    Select time.Length  
        Case 5  
            DateTime.TimeFormat = "HH:mm"  
            millis = 0  
        Case 8  
            DateTime.TimeFormat = "HH:mm:ss"  
            millis = 0  
        Case 10  
            DateTime.TimeFormat = "HH:mm:ss.S"  
            millis = time.SubString2(9, 10) * 100  
        Case 11  
            DateTime.TimeFormat = "HH:mm:ss.SS"  
            millis = time.SubString2(9, 11) * 10  
        Case 12  
            DateTime.TimeFormat = "HH:mm:ss.SSS"  
            millis = time.SubString2(9, 12)  
    End Select  
    ltime = DateTime.DateTimeParse(DateTime.Date(DateTime.Now), time)  
    ltime = DateTime.GetHour(ltime) * DateTime.TicksPerHour + _  
            DateTime.GetMinute(ltime) * DateTime.TicksPerMinute + _  
            DateTime.GetSecond(ltime) * DateTime.TicksPerSecond + millis  
    DateTime.DateFormat = DateFormat  
    DateTime.TimeFormat = timeformat  
    Return ltime  
End Sub  
  
Public Sub getTicksToDay As Long  
    Dim DateFormat As String = DateTime.DateFormat  
    DateTime.DateFormat = "yyyy.MM.dd"  
    Dim date As Long = DateTime.Now  
    Dim today As Long = DateTime.DateParse(DateTime.GetYear(date) & "." & NumberFormat(DateTime.GetMonth(date),2,0) & "." & NumberFormat(DateTime.GetDayOfMonth(date),2,0))  
    DateTime.DateFormat = DateFormat  
    Return today + DateTime.TimeZoneOffset * DateTime.TicksPerHour  
End Sub
```