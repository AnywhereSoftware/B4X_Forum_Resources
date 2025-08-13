### Add event in calendar using intent by asales
### 09/13/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163086/)

```B4X
Dim i As Intent  
i.Initialize(i.ACTION_EDIT, "content://com.android.calendar/events")  
  
'The title of the event.  
i.PutExtra("title", "Team reunion")  
  
'The description of the event  
i.PutExtra("description", "Project Discussion")  
  
'Where the event takes place.  
i.PutExtra("eventLocation", "Conference Room")  
  
'start date/time  
Dim startTime As Long = DateTime.Add(DateTime.Now, 0, 0, 1)  
i.putExtra("beginTime", startTime)  
     
'end date/time  
Dim endTime As Long = DateTime.Add(DateTime.Now, 0, 0, 1)  
i.putExtra("endTime", endTime)  
     
i.putExtra("rrule", "freq=WEEKLY")  
     
StartActivity(i)
```

  
References:  
<https://developer.android.com/reference/android/provider/CalendarContract.EventsColumns>  
<https://developer.android.com/guide/components/intents-common?hl=pt-br#AddEvent>  
<https://stackoverflow.com/questions/14694931/insert-event-to-calendar-using-intent>