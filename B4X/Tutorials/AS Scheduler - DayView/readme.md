###  AS Scheduler - DayView by Alexander Stolte
### 12/03/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157770/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/>  
  
The following thread lists all the features that the DayView of the AS\_Scheduler has.  
  
![](https://www.b4x.com/android/forum/attachments/148269)  
**[SIZE=5]Appointments Overview[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/148270)  
**[SIZE=5]Appointment OverviewGap[/SIZE]**  
The OverviewGap is always 8dip and it's per default enabled  

```B4X
ASScheduler_DayView1.AppointmentProperties.OverviewGap = True
```

  
![](https://www.b4x.com/android/forum/attachments/148271)  
**[SIZE=5]Blackout Day[/SIZE]**  
A blackout day is a day where the user cannot add appointments. The day is blocked for interactions.  

```B4X
    Dim BlackoutStartDate As Long = WeekStartDate+DateTime.TicksPerDay*5  
    ASSchedulerUtils.API.CreateBlackout(ASSchedulerUtils.CreateASScheduler_Blackout(0,BlackoutStartDate,BlackoutStartDate+DateTime.TicksPerDay))'2 days
```

  
![](https://www.b4x.com/android/forum/attachments/148272)  
**[SIZE=5]Working Hours[/SIZE]**  
Defines a visual area that should represent working times. Appointments can still be created outside the area as usual.  

```B4X
ASScheduler_DayView1.WorkingProperties.Active = True  
ASScheduler_DayView1.WorkingProperties.StartHour = 8  
ASScheduler_DayView1.WorkingProperties.EndHour = 17  
ASScheduler_DayView1.WorkingProperties.NonWorkingDays = Array As Int(ASSchedulerUtils.WeekDay_Saturday,ASSchedulerUtils.WeekDay_Sunday)
```

  
![](https://www.b4x.com/android/forum/attachments/148273)  
**[SIZE=5]ShowStartEndTime and ShowDuration[/SIZE]**  
Better overview of the time and duration of an appointment.  

```B4X
    ASScheduler_DayView1.AppointmentProperties.ShowDuration = True  
    ASScheduler_DayView1.AppointmentProperties.ShowStartEndTime = True  
    ASScheduler_DayView1.RefreshScheduler
```

  
  
![](https://www.b4x.com/android/forum/attachments/148275)  
**[SIZE=5]Week Number and Month Name[/SIZE]**  
In the designer you can set whether you want to have the week number and or the month name displayed.  
![](https://www.b4x.com/android/forum/attachments/148278)  
**[SIZE=5]Theming[/SIZE]**  
You can switch seamlessly from dark design to light design.  
Have a look at the following thread:  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-scheduler-%F0%9F%93%85-monthview-dayview-week-agendaview-and-calendarview-payware.138410/post-876273>