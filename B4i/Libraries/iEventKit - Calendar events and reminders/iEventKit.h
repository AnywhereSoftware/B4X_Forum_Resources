#import <Foundation/Foundation.h>
#import "iCore.h"
#import <EventKit/EventKit.h>
@class B4I;
@class B4ICalendarEvent;
@class B4ICalendarAlarm;
@class B4IReminder;
/**
 * Provides access to the device Calendar database. This includes calendar events and reminders.
 *You must add the following usage description for each of the features:
 * <code>#PlistExtra:<key>NSCalendarsUsageDescription</key><string>description here...</string>
 *#PlistExtra:<key>NSRemindersUsageDescription</key><string>description here...</string></code>
 */
//~version: 1.10
//~dependson: EventKit.framework
//~Event: AuthorizationGrantedEvents (Success As Boolean)
//~Event: AuthorizationGrantedReminders (Success As Boolean)
//~Event: EventsReady (Success As Boolean, Events As List)
//~Event: RemindersReady (Success As Boolean, Reminders As List)
//~shortname: EventStore
@interface B4IEventStore : NSObject

//The user has not yet denied or granted access. A dialog will be displayed when the RequestAccess method is called.
@property (nonatomic, readonly)int AUTHORIZATION_NOT_DETERMINED;
//Application is not authorized and user is restricted from changing its state (parental control for example).
@property (nonatomic, readonly)int AUTHORIZATION_RESTRICTED;
//The user denied access for this application.
@property (nonatomic, readonly)int AUTHORIZATION_DENIED;
//The user granted access. On iOS 17+ FULL_ACCESS will be returned instead.
@property (nonatomic, readonly)int AUTHORIZATION_AUTHORIZED;
//Replaces AUTHORIZED in iOS 17+.
@property (nonatomic, readonly)int AUTHORIZATION_FULL_ACCESS;
//Returns True if the status is AUTHORIZED or FULL_ACCESS
- (BOOL) IsAuthorized:(int)Status;
- (void)Initialize:(B4I *)bi :(NSString *)EventName;
/**
 * Requests access to calender events.
 *A dialog will be displayed on the first run.
 *The AuthorizationGrantedEvents event will be raised with the result.
 */
- (void)RequestAccessEvents;
/**
 * Requests access to the reminders.
 *A dialog will be displayed on the first run.
 *The AuthorizationGrantedReminders event will be raised with the result.
 */
- (void)RequestAccessReminders;
//Returns the current authorization status.
- (int)AuthorizationStatusReminders;
//Returns the current authorization status.
- (int)AuthorizationStatusEvents;
/**
 * Fetches all the calendar events between the specified dates. Note that the maximum date range is 4 years.
 *The EventsReady event will be raised.
 */
- (void)FindEvents:(long long)StartDate :(long long)EndDate;
/**
 * Returns the calendar event with the given identifier.
 */
- (B4ICalendarEvent *)GetEvent:(NSString *)Identifier;
/**
 * Returns the reminder with the given identifier.
 */
- (B4IReminder *)GetReminder:(NSString *)Identifier;
/**
 * Fetches all reminders based on the following criterions:
 * If Completed is true, it returns all completed reminders with completion date in the specified date range.
 * If Completed is false, it returns all uncompleted reminders with due date in the specified date range.
 * StartDate and EndDate are optional. Pass 0 for an open range.
 */
- (void)FindReminders:(long long)StartDate :(long long)EndDate :(BOOL)Completed;
/**
 * Removes the event.
 *IncludeFutureEvents - Whether to also remove all future events (for recurring events).
 */
- (void)RemoveEvent:(EKEvent *)Event :(BOOL)IncludeFutureEvents;
/**
 * Saves the event.
 *IncludeFutureEvents - Whether to also update all future events (for recurring events).
 */
- (void)SaveEvent:(EKEvent *)Event :(BOOL)IncludeFutureEvents;
//Removes the reminder.
- (void)RemoveReminder:(EKReminder *)Reminder;
//Saves the reminder.
- (void)SaveReminder:(EKReminder *)Reminder;
//Creates a new event.
- (B4ICalendarEvent *)CreateEvent;
//Creates a new reminder.
- (B4IReminder *)CreateReminder;
@end

//~ObjectWrapper: EKCalendarItem*
@interface B4ICalendarItem : B4IObjectWrapper
//Gets or sets the item's title.
@property (nonatomic)NSString *Title;
//Gets or sets the item's location.
@property (nonatomic)NSString *Location;
//Returns a list with the set alarms. Modifying the list will not have any effect on the alarms.
@property (nonatomic, readonly)B4IList *Alarms;
//Adds an alarm to the item.
- (void) AddAlarm:(B4ICalendarAlarm*) Alarm;
//Removes an alarm.
- (void) RemoveAlarm:(B4ICalendarAlarm *) Alarm;

@end
//~ObjectWrapper: EKEvent*
//~shortname: CalendarEvent
@interface B4ICalendarEvent : B4ICalendarItem
@property (nonatomic, readonly) NSString *Identifier;
@property (nonatomic) long long StartDate;
@property (nonatomic) long long EndDate;
//Gets or sets whether this is an all day event.
@property (nonatomic) BOOL AllDay;
@end

//~ObjectWrapper: EKReminder*
//~shortname: Reminder
@interface B4IReminder : B4ICalendarItem
//Gets or sets the priority (0 - 9).
@property (nonatomic) int Priority;
//Gets or sets whether the reminder considered completed.
@property (nonatomic) BOOL Completed;
//Returns the completed date. Returns 0 if not available.
@property (nonatomic, readonly) long long CompletedDate;
//Gets the due date. Returns 0 if there is no due date. Use SetDueDate to set this field.
@property (nonatomic, readonly) long long DueDate;
//Gets the start date. Returns 0 if there is no start date. Use SetStartDate to set this field.
@property (nonatomic, readonly) long long StartDate;
@property (nonatomic, readonly) NSString *Identifier;
/**
 * Sets the due date.
 */
- (void) SetDueDate:(long long)Date :(BOOL)AllDay;
/**
 * Sets the start date.
 */
- (void) SetStartDate:(long long)Date :(BOOL)AllDay;
@end

//~ObjectWrapper: EKAlarm*
//~shortname: CalendarAlarm
@interface B4ICalendarAlarm : B4IObjectWrapper
//Initializes an alarm that fires at the specified absolute time.
- (void) InitializeAbsolute:(long long)Date;
//Initiaizes an alarm that fires X minutes before the event start time.
- (void) InitializeRelative: (double)Minutes;
//Gets or sets the absolute time. Returns 0 if there is no absolute time.
@property (nonatomic) long long AbsoluteDate;
//Gets or sets the offset measured in minutes before the start time.
@property (nonatomic) double RelativeMinutes;
@end
