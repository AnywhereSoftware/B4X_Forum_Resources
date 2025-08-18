### Convert Mysql DateTime to regular string date time by omarruben
### 02/15/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/127690/)

I know is not the best way, but works ans sometimes is very useful  
  

```B4X
Sub date_mysql_to_normal(Value As String) As String  
    ' value format yyyy-mm-day hh:mm:ss  –>> as mysql field  
    Dim buffer() As String  
    Dim datex As String  
    Dim timex As String  
    
    buffer = Regex.Split(" ",Value)  
    datex = buffer(0)  
    timex = buffer(1)  
    
    Dim buffer2() As String  
    buffer2 = Regex.Split("-",datex)  
    
    Dim normalDate As String  
    
    normalDate = buffer2(1) & "-" & buffer2(2) & "-" & buffer2(0)  & " " & timex  
    Return normalDate  
    
End Sub
```

  
  
returns : month-day-year hh:mm:ss