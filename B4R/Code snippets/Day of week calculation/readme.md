### Day of week calculation by NoNickName
### 06/07/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/118761/)

I'd like to share this Sub, for calculation the day of week, based on [SIZE=5]**Zeller's algorithm**[/SIZE]  
  
  

```B4X
Private Sub weekday(day As Int, month As Int, year As Int) As Int  
  
  
    Dim dayofweek As Int ' day of week  
    month = month -2  
    If month = -1 Then  
        month = 11  
    End If  
    If month = 0 Then  
        month = 12  
    End If  
    Dim c As Int = Floor(year/100)  
    Dim d As Int = year - c*100  
  
    Dim f As Int = day + (Floor(13*month-1)/5) +d+ Floor(d/4) +Floor(d/4)-2*c  
    dayofweek = f Mod 7  
    If dayofweek < 0 Then dayofweek=dayofweek + 7 'Sunday = 0  
    Return dayofweek  
End Sub
```

  
  
Hope this is useful to somebody