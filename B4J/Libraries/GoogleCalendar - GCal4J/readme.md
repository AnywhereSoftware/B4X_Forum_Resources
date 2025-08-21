### GoogleCalendar - GCal4J by DonManfred
### 07/06/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/119860/)

**GCal4J**  
*<link>…|<https://www.b4x.com></link>*  
**Author:** DonManfred  
**Version:** 0.26  

- **Calendar**

- **Functions:**

- **IsInitialized** As Boolean

- **Properties:**

- **CalendarList** As com.google.api.services.calendar.Calendar.CalendarList [read only]
- **Calendars** As com.google.api.services.calendar.Calendar.Calendars [read only]
- **Channels** As com.google.api.services.calendar.Calendar.Channels [read only]
- **Colors** As com.google.api.services.calendar.Calendar.Colors [read only]
- **Events** As com.google.api.services.calendar.Calendar.Events [read only]
- **RootUrl** As String [read only]

- **CalendarList**

- **Functions:**

- **Delete** (calendarId As String)
- **Get** (calendarId As String) As com.google.api.services.calendar.model.CalendarListEntry
- **Insert** (content As com.google.api.services.calendar.model.CalendarListEntry) As com.google.api.services.calendar.model.CalendarListEntry
- **IsInitialized** As Boolean
- **Update** (calendarId As String, content As com.google.api.services.calendar.model.CalendarListEntry) As com.google.api.services.calendar.model.CalendarListEntry

- **Properties:**

- **Items** As java.util.List [read only]

- **CalendarListEntry**

- **Functions:**

- **IsInitialized** As Boolean

- **Properties:**

- **AccessRole** As String [read only]
- **BackgroundColor** As String [read only]
- **Deleted** As Boolean [read only]
- **Description** As String [read only]
- **Etag** As String
- **ForegroundColor** As String [read only]
- **Hidden** As Boolean [read only]
- **Id** As String [read only]
- **Kind** As String [read only]
- **Location** As String [read only]
- **Primary** As Boolean [read only]
- **Selected** As Boolean [read only]
- **Summary** As String [read only]
- **TimeZone** As String [read only]

- **Calendars**

- **Functions:**

- **clear** (calendarId As String)
- **delete** (calendarId As String)
- **IsInitialized** As Boolean

- **Event**

- **Functions:**

- **GetField** (fieldName As String) As Object
- **GetKeySet**
- **Initialize**
- **IsInitialized** As Boolean
- **setEnd** (endtime As Long, timezone As String)
- **SetField** (fieldName As String, value As Object)
- **setStart** (starttime As Long, timezone As String)

- **Properties:**

- **Attachments** As java.util.List
- **Attendees** As java.util.List
- **ColorId** As String
- **Created** As Long [read only]
- **Description** As String
- **End** As Long [read only]
- **Etag** As String
- **HtmlLink** As String
- **ICalUID** As String [read only]
- **Id** As String
- **Location** As String
- **Locked** As Boolean
- **Recurrence** As java.util.List
- **Start** As Long [read only]
- **Status** As String
- **Summary** As String
- **Updated** As Long

- **EventReminder**

- **Functions:**

- **clear**
- **Initiallize**
- **IsInitialized** As Boolean

- **Properties:**

- **Method** As String
- **Minutes** As Int

- **EventReminders**

- **Functions:**

- **clear**
- **Initiallize**
- **IsInitialized** As Boolean

- **Properties:**

- **Overrides** As java.util.List
- **UseDefault** As Boolean

- **Events**

- **Functions:**

- **Delete** (calendarId As String, eventId As String)
- **Get** (calendarId As String, eventId As String) As com.google.api.services.calendar.model.Event
- **Insert** (calendarId As String, content As com.google.api.services.calendar.model.Event) As com.google.api.services.calendar.model.Event
- **IsInitialized** As Boolean
- **List** (calendarId As String) As java.util.List
- **Update** (calendarId As String, eventId As String, content As com.google.api.services.calendar.model.Event) As com.google.api.services.calendar.model.Event

- **GoogleCalendar**

- **Functions:**

- **Initialize** (EventName As String, applicationName As String, clientId As String, clientSecret As String, refreshToken As String, accessToken As String)
- **makeClient** (clientId As String, clientSecret As String, applicationName As String, emailAddress As String, p12FileName As String, user As String, refreshToken As String, accessToken As String) As com.google.api.services.calendar.Calendar

- **Properties:**

- **Calendar** As com.google.api.services.calendar.Calendar [read only]
- **CalendarList** As com.google.api.services.calendar.Calendar.CalendarList [read only]
- **Calendars** As com.google.api.services.calendar.Calendar.Calendars [read only]
- **Events** As com.google.api.services.calendar.Calendar.Events [read only]

  
The Library depends on a lot of jars. You can download them here:  
<https://www.dropbox.com/s/o0ud2g3h6n9d2i1/GoogleCalendar-AdditionalJARs.zip?dl=0>  
  
  

```B4X
    oauth2.GetAccessToken  
    Wait For OAuth2_AccessTokenAvailable (Success As Boolean, token As String)  
    If Success = False Then  
        Log("Error accessing account.")  
        Return  
    Else  
        Log($"Success = ${Success}"$)  
        Log($"Token = ${token}"$)  
'        kvs.Put("Token",token)     
        GCal.Initialize("Calendar","GCal",ClientId,ClientSecret,Null,token)  
          
        Dim c As Calendar = GCal.Calendar  
        Log("Calendar Object")  
        Log©  
        Log(c.RootUrl)  
        events = c.Events ' events is a global Var.  
        '                   Once set you can use it for further operations.  
        '                   It is a important Object…  
        Log("Events Object")  
        Log(events)  
          
  
        Log("CalendarList")  
        Dim cl As CalendarList =  GCal.calendarList  
        Log(cl)  
        Dim calendarslist As List =  cl.Items  
        If calendarslist <> Null And calendarslist.IsInitialized And calendarslist.Size > 0 Then  
            For i=0 To calendarslist.Size-1  
                Dim entry As CalendarListEntry = calendarslist.Get(i)  
                Log($"=========== CALENDAR ==========================="$)  
                Log(entry.Etag)  
                Log(entry.Id)  
  
                'If entry.Id.Contains("xxxxx") Then ' work with the Calendar you want to  
                      
                    Dim eventslist As List = events.List(entry.Id) ' Get all Events from the given Calendar.  
                    If eventslist.IsInitialized And eventslist.Size>0 Then  
                        Log("Events "&entry.Id)  
                        Log(eventslist.Size)  
                        For o= 0 To eventslist.Size-1  
                            Log($"=========== EVENT ==========================="$)  
                            Dim event As Event = eventslist.Get(o)  
                            Log(event)  
                            Log(event.Id)  
                            Log(event.Description)  
                            Log(event.Location)  
                            Log(event.Start)  
                            Log(event.End)  
                            Log(event.Etag)  
                        Next  
                    End If  
                    'events  
               ' End If  
            Next  
        End If  
    End If
```