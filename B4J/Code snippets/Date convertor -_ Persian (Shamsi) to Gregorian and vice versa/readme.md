### Date convertor -> Persian (Shamsi) to Gregorian and vice versa by MegatenFreak
### 04/22/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/130003/)

Hello.  
I wanted to share this since it took me a lot of searching and testing different codes to find ones that actually worked. The algorithms were coded in 'C++'. I converted them into B4J. Just put them in the same module.  
  

```B4X
Sub MiladiIsLeap(miladiYear As Int) As Int  
    If(((miladiYear Mod 100) <> 0 And (miladiYear Mod 4) = 0) Or ((miladiYear Mod 100) = 0 And (miladiYear Mod 400) = 0)) Then  
        Return 1  
    Else  
        Return 0  
    End If  
End Sub  
  
'Persian to Gregorian conversion. Takes the Persian year/month/day as parameters.  
Sub ShamsiToMiladi(y As Int, m As Int, d As Int) As String  
{  
    Dim sumshamsi() As Int = Array As Int ( 31, 62, 93, 124, 155, 186, 216, 246, 276, 306, 336, 365 )  
    Dim miladidays() As Int = Array As Int( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 )  
      
    Dim yy, mm, dd,daycount As Int  
    daycount = d  
    If m > 1 Then daycount = daycount+ sumshamsi(m - 2)  
    yy = y + 621  
    daycount = daycount + 79  
    If MiladiIsLeap(yy) = 1 Then  
        If daycount > 366 Then  
            daycount = daycount - 366  
            yy = yy + 1  
        End If  
    Else If daycount > 365 Then  
        daycount = daycount - 365  
        yy = yy + 1  
    End If  
      
    If MiladiIsLeap(yy) = 1 Then miladidays(1) = 29  
    mm=0  
    Do While (daycount > miladidays(mm))  
        daycount = daycount - miladidays(mm)  
        mm = mm + 1  
    Loop  
  
    Dim iYear As Int = yy  
    Dim iMonth As Int = (mm + 1)  
    Dim iDay As Int = daycount  
      
    Return iYear & "/" & NumberFormat(iMonth, 2, 0) & "/" & NumberFormat(iDay, 2, 0)  
End Sub  
  
'Convert Gregorian date to Hijri Shamsi (Persian) date  
Sub MiladiToShamsi(Year As Int, Month As Int, Day As Int) As String  
      
    Dim count_days(12) As Int  
    count_days = Array As Int(31,28,31,30,31,30,31,31,30,31,30,31)  
    Dim i As Int  
    Dim day_year As Int  
    Dim newMonth, newYear, newDay As Int  
      
    day_year = 0  
    For i = 1 To Month - 1  
        day_year = day_year + count_days(i-1)  
    Next  
    day_year = day_year + Day  
      
    If IsLeapYear(Year) And Month > 2 Then day_year = day_year + 1  
    If day_year <= 79 Then  
        If (Year - 1) Mod 4 = 0 Then  
            day_year = day_year + 11  
        Else  
            day_year = day_year + 10  
        End If  
        newYear = Year - 622  
        If day_year Mod 30 = 0 Then  
            newMonth = (day_year / 30) + 9  
            newDay = 30  
        Else  
            newMonth = (day_year / 30) + 10  
            newDay = day_year Mod 30  
        End If  
    Else  
        newYear = Year - 621  
        day_year = day_year - 79  
        If day_year <= 186 Then  
            If day_year Mod 31 = 0 Then  
                newMonth = day_year / 31  
                newDay = 31  
            Else  
                newMonth = (day_year / 31) + 1  
                newDay = day_year Mod 31  
            End If  
        Else  
            day_year = day_year - 186  
            If day_year Mod 30 = 0 Then  
                newMonth = (day_year / 30) + 6  
                newDay = 30  
            Else  
                newMonth = (day_year / 30) + 7  
                newDay = day_year Mod 30  
            End If  
        End If  
    End If  
      
    'Return the result  
    Return newYear & "/" & newMonth & "/" & newDay  
End Sub  
  
Sub IsLeapYear(year As Int) As Boolean  
    If year Mod 400 = 0 Then Return True  
    If year Mod 100 = 0 Then Return False  
    If year Mod 4 = 0 Then Return True  
    Return False  
End Sub
```

  
  
Among all the things I found in different websites, these ones seem to work flawlessly. I hope it proves useful to someone.