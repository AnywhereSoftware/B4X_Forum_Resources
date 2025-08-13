### [BANano]  (v7) Running Cron Jobs (in the background) by alwaysbusy
### 12/10/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/134729/)

The next version of BANano (7) will have the ability to run Cron jobs!  
  
A Cron is Timer like functionality that runs a certain job **automatically at a specified time following a predifined pattern**. A Cron Job is the scheduled task itself. Cron jobs can be very useful to automate repetitive tasks.  
  
They will become especially handy together with the other new functionality, [Background Workers](https://www.b4x.com/android/forum/threads/banano-using-background-workers-in-your-webapps-introduction.134544/)  
You could for example schedule in a Background Worker to sync your data every hour on a weekday.  
  
cronName: Name of the Cron job. This can not be a variable and must be a literal String and can not contain spaces or special characters!  
  
maxRuns: you can set a maximum number of times the Cron job should run (0 = indefinite, until you Stop it)  
  
pattern: Cron jobs use a special **Pattern** format to define them:  
  
 [FONT=courier new]\* \* \* \* \* \*   
 S M H D m d[/FONT]  
   
 **S**: second (0 - 59)  
 **M**: minute (0 - 59)  
 **H**: hour (0 - 23)  
 **D**: day of month (1 - 31)  
 **m**: month (1 - 12)  
 **d**: day of week (0 - 6), 0 to 6 are Sunday to Saturday; 7 is Sunday, the same as 0  
   
 **Ranges:**  
 Ranges are two numbers separated with a "-", and they indicate all numbers from one to the other. e.g. 10-30 would indicated all numbers between and including 10 to 30.  
   
 **Interval:**  
 A interval is a range and a number separated by "/". The range specifies the group of values, and number specifies every nth value to take from that range.  
 e.g. 0-10/2 would indicate every 2nd number from 0 to 10, therefore [0,2,4,6,8,10]  
  
Example usage:  

```B4X
BANano.CronStart("myCron", "0 0 0 * * 2-6", 15) ' at 00:00:00 on every weekday run, for a total of 15 times, then stop this Cron  
  
Public Sub MyCron_Run()  
   ' do something, like a sync of your data to a server  
End Sub  
  
Public Sub btnPause_Click(event as BANanoEvent)  
     BANano.CronPause("myCron")  
End Sub  
  
Public Sub btnResume_Click(event as BANanoEvent)  
     BANano.CronResume("myCron")  
End Sub  
  
Public Sub btnStop_Click(event as BANanoEvent)  
     BANano.CronStop("myCron")  
End Sub
```

  
  
Alwaysbusy