### Working with Calendars using ContentResolver (Query, Insert, Update, Delete) by DonManfred
### 04/11/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/100229/)

Hello,  
  
i´m playing around with the Calendars on my Device and want to Query them. I found out how it works using ContentResolver querying the ContentProvider available in Android.  
  
[You can find it documented here](https://developer.android.com/reference/android/provider/CalendarContract).  
  
I started using java code and a java-librarywrapper for this but then i realized that it is probably better to use the B4A ContentResolver instead of building a new one just for the Calendars. I then decided to do the same with the ContentResolver.  
As the CalendarProvider is using different Tables internally there are a lot of Constants used (for each table a Content-Uti is needed, and Constants for the Fields in the Table). All of them can be created in B4A easily too but i decided to have them in a small Library (just a small wrapper just for the Constants).  
  
- From now i will use "CR" for a short version of ContentResolver.  
  
The constants make it easy to Build a Query for CR, get the right ContentUri.  
  
Ok, let´s start with the basics to use Android CalendarProvider.  
  
- It depends on the Permission "android.permission.READ\_CALENDAR" and "android.permission.WRITE\_CALENDAR". As both of them are dangerous permissions you need to use Runtimepermission to request Permission for them and they need to be defined in the manifest.  
  

```B4X
AddManifestText(  
<uses-permission android:name="android.permission.READ_CALENDAR"/>  
<uses-permission android:name="android.permission.WRITE_CALENDAR"/>  
)
```

  
.  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Dim ccon As CalendarConstants  
    Dim econ As EventConstants  
End Sub  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Dim gcal As GoogleCalendar  
    Private cr As ContentResolver  
    Private canAccessCal As Boolean  
End Sub  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    canAccessCal = False  
    Activity.LoadLayout("Layout1")  
    Starter.rp.CheckAndRequest("android.permission.READ_CALENDAR")  
    wait for Activity_PermissionResult (Permission As String, Result As Boolean)  
    If Result = False Then  
        Log("NO Permission READ Calendar")  
    Else  
        Starter.rp.CheckAndRequest("android.permission.WRITE_CALENDAR")  
        wait for Activity_PermissionResult (Permission As String, Result As Boolean)  
        If Result Then  
            canAccessCal = True  
            cr.Initialize("CR")  
        End If  
    End If  
    If canAccessCal Then  
               ' We are working from here now…  
        END IF  
END sub
```

  
  
If you want to Query something your need to define a "Projection". In fact ou are defining the Fields you want to query.  
  
We want to get a list of ID, Name, DisplayNAme, AccountType and the OwnerAccount from the Calendars.  

```B4X
        Dim projection() As String = Array As String(ccon.ID,ccon.NAME,ccon.CALENDAR_DISPLAY_NAME,ccon.ACCOUNT_NAME,ccon.ACCOUNT_TYPE,ccon.OWNER_ACCOUNT)
```

  
  
The ID you get is the ID from Androids Calendar.  
as we are requesting Calendars we need to use the ContentUri from the CalendarsConstants object when Querying with CR.  
  
ccon, econ are two Objects which only contains the Constant. Each of them do have a CONTENT\_URI and some other Values. ccon have Constants for Calendars. econ have Constants for CalendarEvents.  
  
We set the "Selection" to match all visible Calendars.  
We order them by ID Ascending.  

```B4X
        cr.QueryAsync(ccon.CONTENT_URI,projection, ccon.VISIBLE&"=1",Null,ccon.ID&" ASC")  
        wait for CR_QueryCompleted(Success As Boolean, Crsr As Cursor)  
        Log($"QueryCompleted(${Success})"$)  
        If Crsr.IsInitialized Then  
            If Crsr.RowCount > 0 Then  
                Dim Cursor As Cursor  
                Cursor = Crsr  
                For i = 0 To Cursor.RowCount - 1  
                    Cursor.Position = i  
                    'calcon.ACCOUNT_TYPE,calcon.OWNER_ACCOUNT)  
                    Log($"CR ————————————–"$)  
                    Log(Cursor.GetString(ccon.ID)) ' You can use the constants you used for the projection. But remember: only the ones you defined in the projection are available in the Result.  
                    Log(Cursor.GetString(ccon.NAME))  
                    Log(Cursor.GetString(ccon.CALENDAR_DISPLAY_NAME))  
                    Log(Cursor.GetString(ccon.ACCOUNT_NAME))  
                    Log(Cursor.GetString(ccon.ACCOUNT_TYPE))  
                    Log(Cursor.GetString(ccon.OWNER_ACCOUNT))  
                Next  
                Cursor.Close  
            Else  
                ' No rows  
            End If  
        Else  
            '  
        End If
```

  
  
The constants used in the Example here can be found in the Attached small Library.  
  
I´ll add more Examples to this Thread. As of now i´m ivestigating/play around with the Calendars. I do not know how to delete or edit a Event but i´ll find out and Update here.  
  
I just want to share my findings and i think they may be useful for you too.  
  
Related Examples:  
- [Reading Events from a Calendar](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver.100229/#post-630189)  
- [More Advanced reading from a Calendar](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver.100229/#post-630209)  
- [Adding an Event in a Calendar](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver.100229/#post-630236)  
- [Some notes about Calendars AccountType](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver.100229/#post-630467).  
- [Deleting an Event](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver.100229/#post-630494).  
- [Updating an Event](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver.100229/#post-630495).  
- [Adding an Attendee](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver.100229/#post-630498).  
- [Get all Reminders for an specific Event](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver-query-insert-update-delete.100229/#post-639702).  
- [Add a Reminder to a Specific Event](https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver-query-insert-update-delete.100229/post-726060).