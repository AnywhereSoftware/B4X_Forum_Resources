### DateTime by icakinser
### 04/11/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/116179/)

Snip from my stock app to check if markets are open and if they are how many chunks of time are left in the day.  
The second snip is to get how many minutes the markets have been open based on how many days you put in and add the remaining minutes are left today if the markets are still open.  
  

```B4X
Sub get_difference(interval As String)As String  
    '390 minutes in one day  
    '78 for on day /5mins  
    '39 /10min  
    '26 /15min  
    '13 /30min  
      
    Dim x As Long' = DateTime.DateTimeParse(DateTime.Date(DateTime.Now),"09:30:00")  
    Dim y As Long' = DateTime.DateTimeParse(DateTime.Date(DateTime.Now),DateTime.Time(DateTime.Now))  
    Dim z As Long' = y-x  
    Dim w As Long' = z/60  
    Dim n As Long'  = w/15  
  
    'Check if markets are open  
    fetchClock()  
    '*************************  
    If open_now = True Then  
        'If they are check how much time has past  
        x= DateTime.DateTimeParse(DateTime.Date(DateTime.Now),"09:30:00")  
        y= DateTime.DateTimeParse(DateTime.Date(DateTime.Now),DateTime.Time(DateTime.Now))  
        z = y-x  
        w  = z/60  
        '*********************************************************************************  
    Select Case interval  
          
        Case "1min"  
              
            Dim group As String = NumberFormat2(w,0,0,0,False)  
            Log(group)  
                Return group.SubString2(0,3)  
              
        Case "10min"  
                n= w/10  
                Dim group As String = NumberFormat2(n,0,0,0,False)  
                Log(group)  
                Return group.SubString2(0,3)  
        Case "5min"  
            n= w/5  
            Dim group As String = NumberFormat2(n,0,0,0,False)  
            Log(group)  
            Return group.SubString2(0,3)  
              
        Case "15min"  
              
            n= w/15  
            Dim group As String = NumberFormat2(n,0,0,0,False)  
            Log(group)  
            Return group.SubString2(0,2)  
              
        Case "30min"  
              
            n = w/30  
            Dim group As String = NumberFormat2(n,0,0,0,False)  
            Log(group)  
                Return group.SubString2(0,2)  
              
        End Select  
  
    End If  
End Sub  
  
Sub get_difference_period_1min(interval As Long)As String  
    '390 minutes in one day  
    '78 for on day /5mins  
    '39 /10min  
    '26 /15min  
    '13 /30min  
      
    Dim x As Long  
    Dim w As Long  
    Dim group As String  
  
   fetchClock()  
      
    If open_now = True Then  
          
        'If the market is open get the amount of time its been open  
        x  = get_difference("1min")  
        '**********************************************************  
        'Get the number of minutes times the desired days  
        w = 390*interval -1 + x  
        '**********************************************************     
        'Build the return string  
            group = NumberFormat2(w,0,0,0,False)  
        '**********************************************************  
            'Log(group)  
            Return group  
      
    Else  
        'If markets are closed just return the amount of minutes times the desired number of days  
        w = 390*interval  
        '****************************************************************************************  
        'Build the return string  
        group = NumberFormat2(w,0,0,0,False)  
        '****************************************************************************************  
        'Log(group)  
        Return group  
      
    End If  
End Sub
```