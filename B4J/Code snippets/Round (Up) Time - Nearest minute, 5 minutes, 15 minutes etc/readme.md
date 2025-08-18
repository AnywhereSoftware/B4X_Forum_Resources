### Round (Up) Time - Nearest minute, 5 minutes, 15 minutes etc by tchart
### 03/07/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/128359/)

A quick snippet to round time up. I needed this for a time base chart to avoid having irregular start/end times on the chart. So now I can show (for example) the last hour and it will be to a whole minute etc.  
  

```B4X
Sub AppStart (Args() As String)    
    Dim now As Long = DateTime.Now    
    Log(DateTime.Time(RoundTime(now,"1M")))  
    Log(DateTime.Time(RoundTime(now,"5M")))  
    Log(DateTime.Time(RoundTime(now,"15M")))  
    Log(DateTime.Time(RoundTime(now,"30M")))  
    Log(DateTime.Time(RoundTime(now,"1H")))  
End Sub  
  
Sub RoundTime(Tick As Long, Nearest As String) As Long  
    Dim divisor As Long = 1  
     
    Select Nearest  
        Case "1M"  
            divisor = 60000            
        Case "5M"  
            divisor = 300000  
        Case "15M"  
            divisor = 900000  
        Case "30M"  
            divisor = 1800000  
        Case "1H"  
            divisor = 3600000  
    End Select  
     
    Return Tick - (Tick Mod divisor) + divisor  
End Sub
```