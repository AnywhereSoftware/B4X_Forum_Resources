###  AS Scheduler - MonthView HeatMap by Alexander Stolte
### 01/23/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158812/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/>  
  
![](https://www.b4x.com/android/forum/attachments/149992)  
  
**Setup**  
-Set in the designer the "Calendar Function" to "HeatMap"  
-Done  
  
**Customizing**  
You can set your own colors  

```B4X
Dim HeatColor As List : HeatColor.Initialize  
HeatColor.Add(ASSchedulerUtils.CreateASScheduler_HeatMapColor(xui.Color_ARGB(255,214, 230, 133),0,xui.Color_White))  
HeatColor.Add(ASSchedulerUtils.CreateASScheduler_HeatMapColor(xui.Color_ARGB(255,140, 198, 101),2,xui.Color_White))  
HeatColor.Add(ASSchedulerUtils.CreateASScheduler_HeatMapColor(xui.Color_ARGB(255,68, 163, 64),4,xui.Color_White))  
HeatColor.Add(ASSchedulerUtils.CreateASScheduler_HeatMapColor(xui.Color_ARGB(255,30, 104, 35),7,xui.Color_White))  
ASScheduler_MonthView1.HeatMapProperties.ColorCountList = HeatColor
```

  
  
**Example Data**  

```B4X
    'HeatMap Example Data  
    For i = 1 To 40 -1  
        Dim p As Period  
        p.Initialize  
        p.Days = i  
        Dim Date As Long = DateUtils.AddPeriod(DateTime.Now,p)  
        For z = 1 To Rnd(2,12) -1  
            ASScheduler_MonthView1.API.CreateAppointment(ASSchedulerUtils.CreateASScheduler_AppointmentRecurring(0,"Test1","Description",xui.Color_ARGB(255,73, 98, 164),False,Date,Date+DateTime.TicksPerHour,False,"day",7))  
        Next  
    Next  
  
    ASScheduler_MonthView1.CreateScheduler
```