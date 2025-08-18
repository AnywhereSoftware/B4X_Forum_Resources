###  [Class] [Calendar] Class wmCalendar - Android calendar manipulation based on DonManfred's explorations by walt61
### 04/19/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/130273/)

This is a calendar manipulation class based on [USER=42649]@DonManfred[/USER] 's explorations which you can find at <https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver-query-insert-update-delete.100229/>.  
  
It contains the following methods:  
  
- AddCalendar: Adds a new Calendar and returns its id, or -1 if no Calendar was added  
- GetAllVisibleCalendars: Returns a list of type CalendarInfo containing all visible Calendars  
- GetCalendarByID: Returns a variable of type CalendarInfo containing the selected Calendar's data, or Null if the ID doesn't exist  
- GetCalendarByName: Returns a list of type CalendarInfo containing all Calendars with the specified name  
  
- AddEvent: Adds a new Event to a Calendar and returns the new Event's id, or -1 if no Event was added  
- GetAllVisibleEventsForCalendar: Returns a list of type EventInfo containing all visible Events for the specified Calendar id  
- GetAllVisibleEventsInstancesForCalendar: Returns a list of type EventInfo containing all visible Events' Instances for the specified Calendar id  
- GetSelectedEventsForCalendar: ' Returns a list of type EventInfo containing selected Events for the specified Calendar id  
- GetSelectedEventsInstancesForCalendar: ' Returns a list of type EventInfo containing selected Events' Instances for the specified Calendar id  
- GetEventByID: Returns a variable of type EventInfo containing the selected Event's data, or Null if the ID doesn't exist  
- UpdateEvent: Attempts to update an Event and returns the number of Events that were updated  
- DeleteEvent: Attempts to delete an Event and returns the number of Events that were deleted  
  
- AddAttendeeToEvent: Adds an Attendee to an Event and returns the id of the added Attendee, or -1 if no Attendee was added  
- GetEventAttendees: Returns a list of type AttendeeInfo containing all Attendees for the selected Event id  
  
- AddReminderToEvent: Adds a Reminder to an Event and returns the id of the added Reminder, or -1 if no Reminder was added  
- GetEventReminders: Returns a list of type ReminderInfo containing all Reminders for the selected Event id  
  
Important:  
- CalendarInfo, EventInfo, AttendeeInfo, and ReminderInfo are Types that are defined in the class  
- Events vs. Instances: Instances are individual instances of recurring Events  
**- The Manifest has been edited as well, and RuntimePermissions must be requested - see [USER=42649]@DonManfred[/USER] 's post**  
- General Google information about the Calendar provider that can be useful when 'strange' things seem to happen (the Calendar is a complex beast): <https://developer.android.com/guide/topics/providers/calendar-provider>  
  
Non-core library dependencies:  
- GoogleCalendarClient: get V0.2 from [USER=42649]@DonManfred[/USER]'s post  
- ContentResolver  
- RuntimePermissions  
- SQL  
  
An example project is attached, feel free to modify as desired; if you'd add/improve functionality, please post it here as well.  
  
Enjoy!  
  
EDIT 2022-04-19: adding an all-day event caused it to wind up for 'yesterday' instead of 'today'. The attached project was updated with the correct way to handle this, and comments were added.