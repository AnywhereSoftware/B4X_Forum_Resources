### Simple analog Clock by Johan Schoeman
### 10/08/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/143404/)

Nothing spectacular - a simple analog clock made entirely from static and rotating ImageViews and a bit of code. The movement of the hands are much smoother than in the below GIF  
  
![](https://www.b4x.com/android/forum/attachments/134534)  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 400  
    #MainFormHeight: 400  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
  
    Dim t As Timer                                   'timer - tick every second  
    Dim cntsec, cntmin, cnthr As Float = 0.0         'they will hold the Int values of day of month, month, year  
     
    Private ImageView1 As B4XView                    'the minute hand  
    Private ImageView2 As B4XView                    'The clock face image                    '  
    Private ImageView3 As B4XView                    'The hour hand  
    Private ImageView4 As B4XView                    'The second hand  
     
    Dim sekonde As Float = 0                         'angle of seconds  
    Dim minuut As Float = 0                          'angle of minutes  
    Dim uur As Float = 0                             'angle of hours  
    Private Label1 As Label                          'the year  
    Private Label2 As Label                          'the day of month  
    Private Label3 As Label                          'string of the month (eg Jan, Feb, etc)  
     
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
  
    MainForm.Show  
     
    t.Initialize("t", 1000)                                 'initialize the timer  
    t.Enabled = True                                        'start the timer  
     
    setClock                                                'get the hour, minute, second from DateTime.GetSecond/GetMinute/GetHour(DateTime.Now)  
     
    ImageView4.Rotation = sekonde                           'move the seconds needle to the correct angle  
    ImageView1.Rotation = minuut                            'move the minutes needle to the correct angle  
    ImageView3.Rotation = uur                               'move the hours needle to the correct angle  
     
    Label1.Text = DateTime.GetYear(DateTime.Now)            'set the label text - current year  
    Label2.Text = DateTime.GetDayOfMonth(DateTime.Now)      'set the lable text - current day of the month  
     
    Dim mnd As Int = DateTime.GetMonth(DateTime.Now)        'get the current month (an Int)  
     
    setmonth(mnd)                                           'convert month Int to month String  
  
End Sub  
  
Sub setClock  
     
    cntsec = DateTime.GetSecond(DateTime.Now)               'get the currect value of Second  
    cntmin = DateTime.GetMinute(DateTime.Now)               'get the current value of Minute  
    cnthr = DateTime.GetHour(DateTime.Now)                  'get the current value of Hour  
    If cnthr > 12 Then  
        cnthr = cnthr - 12                                  'we are dealing with a 12hr clock - so subtract 12 from hours if hours is greater than 12  
    End If  
     
    sekonde = 360 * cntsec/60                                           'calc the angle of the seconds hand  
    minuut = (360 * cntmin/60) + (360 * cntsec/(60*60))                 'calc the angle of the minute hand  
    uur = (360 * cnthr/12) + (6.0 * cntmin/12) + (6* cntmin/12/60)   'calc the angle of the hour hand  
     
End Sub  
  
Sub t_tick  
  
    setClock                                                         'get the hour, minute, second from DateTime.GetSecond/GetMinute/GetHour(DateTime.Now)                                                    '  
    RotateViewShortestArc(ImageView4, 1000, sekonde)                 'animate the seconds hand to the correct new angle  
    Sleep(0)                                                         'sleep a bit  
    RotateViewShortestArc(ImageView3, 1000, uur)                     'animate the hour and to the correct new angle  
    Sleep(0)                                                         'sleep a bit more  
    RotateViewShortestArc(ImageView1, 1000, minuut)                  'animate the second hand to the correct new angle  
    Sleep(0)                                                         '…and sleep even more  
    Label2.Text = DateTime.GetDayOfMonth(DateTime.Now)               'set the day of month inside the clock  
    Label1.Text = DateTime.GetYear(DateTime.Now)                     'set the year inside the clock  
    setmonth(DateTime.GetMonth(DateTime.Now))                        'set the month inside the clock - look up the String of the month in Sub setmonth  
     
End Sub  
  
Sub RotateViewShortestArc (v As B4XView, Duration As Int, Target As Float)   'from a posting of Erel - shortest Arc/route to the new angular position  
    Dim Rotation As Float = v.Rotation  
    Dim dx As Float = (Target - Rotation) Mod 360  
    If dx > 180 Then  
        dx = -(360 - dx)  
    Else if dx < -180 Then  
        dx = 360 + dx  
    End If  
    v.SetRotationAnimated(Duration, Rotation + dx)  
  
End Sub  
  
Sub setmonth(mnd As Int)                             'get the string of the month(Int)  
     
    Select mnd  
        Case 1  
            Label3.Text = "Jan"  
        Case 2  
            Label3.Text = "Feb"  
        Case 3  
            Label3.Text = "Mar"  
        Case 4  
            Label3.Text = "Apr"  
        Case 5  
            Label3.Text = "May"  
        Case 6  
            Label3.Text = "Jun"  
        Case 7  
            Label3.Text = "Jul"  
        Case 8  
            Label3.Text = "Aug"  
        Case 9  
            Label3.Text = "Sep"  
        Case 10  
            Label3.Text = "Oct"  
        Case 11  
            Label3.Text = "Nov"  
        Case 12  
            Label3.Text = "Dec"  
    End Select  
     
     
End Sub
```