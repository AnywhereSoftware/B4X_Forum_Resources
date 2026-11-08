B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
' Class based on the library (GoogleCalendarClientV0.2) and tutorial by DonManfred:
' https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver-query-insert-update-delete.100229/

' Library dependencies:
' - GoogleCalendarClient: get V0.2 from https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver-query-insert-update-delete.100229/
' - ContentResolver
' - RuntimePermissions
' - SQL

' IMPORTANT: Manifest and RuntimePermissions: read the first post on https://www.b4x.com/android/forum/threads/working-with-calendars-using-contentresolver-query-insert-update-delete.100229/

' General Google information about the Calendar provider: https://developer.android.com/guide/topics/providers/calendar-provider

' Changes:
' 2021-04-29:
' - Initial version

Sub Class_Globals

	'''''''''
	' General
	'''''''''

	Private cr As ContentResolver ' Library dependencies: ContentResolver, SQL

	'''''''''''
	' Calendars
	' For detailed information about the fields, see https://developer.android.com/reference/android/provider/CalendarContract.CalendarColumns
	'''''''''''

	Public ccon As CalendarConstants ' This type comes from DonManfred's GoogleCalendarClient library

	' DonManfred, re CalendarInfo.accountType:
	' - LOCAL: Changes in a Local Calendar only affects the Devices Calendar. Events in this Calendar are Not Synced.
	' - COM.GOOGLE: Account Is linked To Google. Changes in Calendars of this Type are Synced with Google.
	'   Note that the Calendar must be defined And activated For Sync in the Google Calendar App.
	' - COM.SAMSUNG.ANDROID.EXCHANGE: Account Is linked To Samsung Account (And Samsung Calendar). It Is probably syned with Samsung (don´t know).
	' If fields are changed, methods 'CreateCalendarInfoFromCursor' and 'FillCalendarContentValues' must be changed as well.
	Type CalendarInfo(id As String, name As String, displayName As String, _
					accountName As String, accountType As String, ownerAccount As String, _
					location As String, timeZone As String, canModifyTimeZone As String, _
					isPrimary As String, visible As String, syncEvents As String, _
					syncID As String)

	' This 'projection' is used by all Calendar-related methods that require one.
	' If fields are changed, methods 'CreateCalendarInfoFromCursor' and 'FillCalendarContentValues' must be changed as well.
	' DonManfred:
	' If you want to Query something your need to define a 'Projection'. In fact
	' you are defining the Fields you want To query.
	Dim calendarProjection() As String = Array As String(ccon.ID, ccon.NAME, ccon.CALENDAR_DISPLAY_NAME, _
														ccon.ACCOUNT_NAME, ccon.ACCOUNT_TYPE, ccon.OWNER_ACCOUNT, _
														ccon.CALENDAR_LOCATION, ccon.CALENDAR_TIME_ZONE, ccon.CAN_MODIFY_TIME_ZONE, _
														ccon.IS_PRIMARY, ccon.VISIBLE, ccon.SYNC_EVENTS, _
														ccon.SYNC_ID)

	''''''''''''''''''''''
	' Events and Instances
	' For detailed information about the fields, see
	' - Events: https://developer.android.com/reference/android/provider/CalendarContract.EventsColumns
	' - Instances: https://developer.android.com/reference/android/provider/CalendarContract.Instances
	''''''''''''''''''''''

	Public econ As EventConstants ' This type comes from DonManfred's GoogleCalendarClient library
	Public icon As InstancesConstants ' This type comes from DonManfred's GoogleCalendarClient library

	Type EventInfo(eventId As String, allDay As String, availability As String, _
					calendarAccessLevel As String, description As String, dateTimeEnd As String, _
					dateTimeStart As String, duration As String, location As String, _
					organizer As String, title As String, customAppPackage As String, _
					customAppUri As String, displayColor As String, eventColor As String, _
					eventColorKey As String, endTimeZone As String, timeZone As String, _
					recurrenceExceptionDates As String, recurrenceExceptionRule As String, recurrenceDates As String, _
					recurrenceRule As String, eventStatus As String, syncId As String, _
					visible As String, instanceBegin As String, instanceEnd As String, _
					instanceId As String)

	' This 'projection' is used by all Event-related methods that require one.
	' If fields are changed, method 'CreateEventInfoFromCursor' must be changed as well.
	' DonManfred:
	' If you want to Query something your need to define a 'Projection'. In fact
	' you are defining the Fields you want To query.
	Dim eventProjection() As String = Array As String(econ.ID, econ.ALL_DAY, econ.AVAILABILITY, _
													econ.CALENDAR_ACCESS_LEVEL, econ.DESCRIPTION, econ.DTEND, _
													econ.DTSTART, econ.DURATION, econ.LOCATION, _
													econ.ORGANIZER, econ.TITLE, econ.CUSTOM_APP_PACKAGE, _
													econ.CUSTOM_APP_URI, econ.DISPLAY_COLOR, econ.EVENT_COLOR, _
													econ.EVENT_COLOR_KEY, econ.EVENT_END_TIMEZONE, econ.EVENT_TIMEZONE, _
													econ.EXDATE, econ.EXRULE, econ.RDATE, _
													econ.RRULE, econ.STATUS, econ.SYNC_ID, _
													econ.VISIBLE)

	Dim eventInstanceProjection() As String = Array As String(econ.ID, econ.ALL_DAY, econ.AVAILABILITY, _
															econ.CALENDAR_ACCESS_LEVEL, econ.DESCRIPTION, econ.DTEND, _
															econ.DTSTART, econ.DURATION, econ.LOCATION, _
															econ.ORGANIZER, econ.TITLE, econ.CUSTOM_APP_PACKAGE, _
															econ.CUSTOM_APP_URI, econ.DISPLAY_COLOR, econ.EVENT_COLOR, _
															econ.EVENT_COLOR_KEY, econ.EVENT_END_TIMEZONE, econ.EVENT_TIMEZONE, _
															econ.EXDATE, econ.EXRULE, econ.RDATE, _
															econ.RRULE, econ.STATUS, econ.SYNC_ID, _
															econ.VISIBLE, icon.BEGIN, icon.END, _
															icon.EVENT_ID)

	'''''''''''
	' Reminders
	' For detailed information about the fields, see https://developer.android.com/reference/android/provider/CalendarContract.Reminders
	'''''''''''

	Public rcon As RemindersConstants ' This type comes from DonManfred's GoogleCalendarClient library

	' ReminderInfo.method is one of the 'rcon.METHOD_...' values
	Type ReminderInfo(reminderId As String, method As Int, minutesBefore As Int)

	' DonManfred:
	' If you want to Query something your need to define a 'Projection'. In fact
	' you are defining the Fields you want To query.
	Dim reminderProjection() As String = Array As String(rcon.ID, rcon.EVENT_ID, rcon.METHOD, rcon.MINUTES)

	'''''''''''
	' Attendees
	' For detailed information about the fields, see https://developer.android.com/reference/android/provider/CalendarContract.AttendeesColumns
	'''''''''''

	Public acon As AttendeesConstants ' This type comes from DonManfred's GoogleCalendarClient library

	Type AttendeeInfo(email As String, identityNamespace As String, identity As String, _
					name As String, relationship As String, attendeeType As String, _
					eventId As String)

	' DonManfred:
	' If you want to Query something your need to define a 'Projection'. In fact
	' you are defining the Fields you want To query.
	Dim AttendeeProjection() As String = Array As String(acon.ATTENDEE_EMAIL, acon.ATTENDEE_ID_NAMESPACE, acon.ATTENDEE_IDENTITY, _
														acon.ATTENDEE_NAME, acon.ATTENDEE_RELATIONSHIP, acon.ATTENDEE_TYPE, _
														acon.EVENT_ID)

End Sub

' Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

	cr.Initialize("")

End Sub

#Region Calendar
' Returns a list of type CalendarInfo containing all visible Calendars.
' - sortBy: use one of the ccon.xxx values, e.g. 'ccon.CALENDAR_DISPLAY_NAME' (the value must be present in 'calendarProjection')
' - sortAscending: True for ascending, False for descending
Public Sub GetAllVisibleCalendars(sortBy As String, sortAscending As Boolean) As List

	Dim allCalendarsList As List ' This list will be populated and returned
	allCalendarsList.Initialize

	Dim sortOrder As String = " ASC"
	If sortAscending = False Then sortOrder = " DESC"
	sortBy = SetSortBy(sortBy, ccon.ID, calendarProjection)

	' DonManfred:
	' The ID you get Is the ID from Android's Calendar.
	' As we are requesting Calendars we need to use the ContentUri from the
	' CalendarsConstants object when Querying with cr.
	' ccon, econ are two Objects which only contains the Constant. Each of them
	' has a CONTENT_URI and some other values:
	' - ccon has Constants for Calendars
	' - econ has Constants for CalendarEvents
	' We set the 'Selection' to match all visible Calendars.
	Dim crsr As Cursor = cr.Query(ccon.CONTENT_URI, calendarProjection, ccon.VISIBLE&"=1", Null, sortBy & sortOrder)
	If crsr.IsInitialized Then
		If crsr.RowCount > 0 Then
			For i = 0 To (crsr.RowCount - 1)
				crsr.Position = i
				allCalendarsList.Add(CreateCalendarInfoFromCursor(crsr))
			Next
			crsr.Close
		End If
	End If

	Return allCalendarsList

End Sub

' Returns a list of type CalendarInfo containing all Calendars with the specified name.
' - name and displayName: use "" for either of them; the one that is not "" will be used.
'   If both contain a value, 'name' will be used. If both are "", an empty list is returned.
'   Note that the values are CASE-SENSITIVE.
' - sortBy: use one of the ccon.xxx values, e.g. 'ccon.CALENDAR_DISPLAY_NAME' (the value must be present in 'calendarProjection')
' - sortAscending: True for ascending, False for descending
Public Sub GetCalendarByName(name As String, displayName As String, sortBy As String, sortAscending As Boolean) As List

	Dim selectedCalendarsList As List ' This list will be populated and returned
	selectedCalendarsList.Initialize

	Dim sortOrder As String = " ASC"
	If sortAscending = False Then sortOrder = " DESC"
	sortBy = SetSortBy(sortBy, ccon.ID, calendarProjection)

	Dim selectionField As String
	Dim selectionVal As String
	If name <> "" Then
		selectionField = ccon.NAME
		selectionVal = name
	Else If displayName <> "" Then
		selectionField = ccon.CALENDAR_DISPLAY_NAME
		selectionVal = displayName
	Else
		Return selectedCalendarsList
	End If
	' See method GetAllVisibleCalendars for info
	Dim crsr As Cursor = cr.Query(ccon.CONTENT_URI, calendarProjection, selectionField & "=?", Array As String(selectionVal), sortBy & sortOrder)
	If crsr.IsInitialized Then
		If crsr.RowCount > 0 Then
			For i = 0 To (crsr.RowCount - 1)
				crsr.Position = i
				selectedCalendarsList.Add(CreateCalendarInfoFromCursor(crsr))
			Next
			crsr.Close
		End If
	End If

	Return selectedCalendarsList

End Sub

' Returns a variable of type CalendarInfo containing the selected Calendar's data, or Null if the ID doesn't exist.
Public Sub GetCalendarByID(calendarId As String) As CalendarInfo

	Try
		Dim crsr As Cursor = cr.Query(ccon.CONTENT_URI, calendarProjection, ccon.ID & "=?", Array As String(calendarId), "")
		If crsr.IsInitialized Then
			If crsr.RowCount > 0 Then
				crsr.Position = 0
				Return CreateCalendarInfoFromCursor(crsr)
				crsr.Close
			End If
		End If
	Catch
		Log("GetCalendarByID: " & LastException)
	End Try

	Return Null

End Sub

' Used by methods GetAllVisibleCalendars, GetCalendarByName, and GetCalendarByID
Private Sub CreateCalendarInfoFromCursor(cursor1 As Cursor) As CalendarInfo

	Dim t1 As CalendarInfo
	t1.Initialize
	t1.id = cursor1.GetString(ccon.ID)
	t1.name = cursor1.GetString(ccon.NAME)
	t1.displayName = cursor1.GetString(ccon.CALENDAR_DISPLAY_NAME)
	t1.accountName = cursor1.GetString(ccon.ACCOUNT_NAME)
	t1.accountType = cursor1.GetString(ccon.ACCOUNT_TYPE)
	t1.ownerAccount = cursor1.GetString(ccon.OWNER_ACCOUNT)
	t1.location = cursor1.GetString(ccon.CALENDAR_LOCATION)
	t1.timeZone = cursor1.GetString(ccon.CALENDAR_TIME_ZONE)
	t1.canModifyTimeZone = cursor1.GetString(ccon.CAN_MODIFY_TIME_ZONE)
	t1.isPrimary = cursor1.GetString(ccon.IS_PRIMARY)
	t1.visible = cursor1.GetString(ccon.VISIBLE)
	t1.syncEvents = cursor1.GetString(ccon.SYNC_EVENTS)
	t1.syncID = cursor1.GetString(ccon.SYNC_ID)
	Return t1

End Sub

' Adds a new Calendar and returns its id, or -1 if no Calendar was added.
' - In parameter 'theCalendar', item 'id' is ignored.
' - 'cconValuesOrNull' is either Null or a list of 'ccon.xxx' values indicating the fields from 'theCalendar' that
'   must be processed. If Null, all fields are processed.
Public Sub AddCalendar(theCalendar As CalendarInfo, cconValuesOrNull As List) As Int

	Try
		Dim val As ContentValues = FillCalendarContentValues(theCalendar, cconValuesOrNull)
		Dim resUri As Uri = cr.Insert(ccon.CONTENT_URI, val)
		If resUri.IsInitialized Then
			If resUri <> Null Then
				Dim calendarId As Int = resUri.ParseId
				Return calendarId
			End If
		End If
	Catch
		Log("AddCalendar: " & LastException)
	End Try

	Return -1

End Sub

' Used by method AddCalendar
Private Sub FillCalendarContentValues(theCalendar As CalendarInfo, cconValuesOrNull As List) As ContentValues

	Dim val As ContentValues
	val.Initialize
	FillOneContentValue(val, ccon.NAME, theCalendar.name, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.CALENDAR_DISPLAY_NAME, theCalendar.displayName, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.ACCOUNT_NAME, theCalendar.accountName, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.ACCOUNT_TYPE, theCalendar.accountType, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.OWNER_ACCOUNT, theCalendar.ownerAccount, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.CALENDAR_LOCATION, theCalendar.location, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.CALENDAR_TIME_ZONE, theCalendar.timeZone, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.CAN_MODIFY_TIME_ZONE, theCalendar.canModifyTimeZone, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.IS_PRIMARY, theCalendar.isPrimary, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.VISIBLE, theCalendar.visible, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.SYNC_EVENTS, theCalendar.syncEvents, False, cconValuesOrNull)
	FillOneContentValue(val, ccon.SYNC_ID, theCalendar.syncID, False, cconValuesOrNull)
	Return val

End Sub

' Unfortunately I couldn't get this to work
' Attempts to delete a Calendar and returns the number of Calendars that were deleted
Public Sub DeleteCalendar_DOES_NOT_WORK(calendarId As Int) As Int

	Try
		Dim deletionURI As Uri
		deletionURI.WithAppendedPath(ccon.CONTENT_URI, calendarId)
		Return cr.Delete(deletionURI, Null, Null)
	Catch
		Log("DeleteCalendar: " & LastException)
		Return 0
	End Try

End Sub
#End Region ' Calendar

#Region Events and Event Instances
' Returns a list of type EventInfo containing all visible Events for the specified Calendar id.
' - sortBy: use one of the econ.xxx values, e.g. 'econ.TITLE' (the value must be present in 'eventProjection')
' - sortAscending: True for ascending, False for descending
Public Sub GetAllVisibleEventsForCalendar(calendarID As String, sortBy As String, sortAscending As Boolean) As List

	Dim selectionFields() As String = Array As String(econ.VISIBLE)
	Dim selectionOperators() As String = Array As String("=")
	Dim selectionArgs() As String = Array As String(1)

	Return GetSelectedEventsForCalendar(calendarID, selectionFields, selectionOperators, selectionArgs, sortBy, sortAscending)

End Sub

' Returns a list of type EventInfo containing all visible Events for the specified Calendar id.
' - repeatRecurringInstancesFrom/repeatRecurringInstancesTo: a DateTime range within which all recurring instances should be returned
' - sortBy: use one of the econ.xxx values, e.g. 'econ.TITLE' (the value must be present in 'eventProjection')
' - sortAscending: True for ascending, False for descending
Public Sub GetAllVisibleEventsInstancesForCalendar(calendarID As String, _
													repeatRecurringInstancesFrom As Long, repeatRecurringInstancesTo As Long, _
													sortBy As String, sortAscending As Boolean) As List

	Dim selectionFields() As String = Array As String(econ.VISIBLE)
	Dim selectionOperators() As String = Array As String("=")
	Dim selectionArgs() As String = Array As String(1)

	Return GetSelectedEventsInstancesForCalendar(calendarID, selectionFields, selectionOperators, selectionArgs, repeatRecurringInstancesFrom, repeatRecurringInstancesTo, sortBy, sortAscending)

End Sub

' Returns a list of type EventInfo containing selected Events for the specified Calendar id.
' - selectionFields: a String Array that contains the 'econ.xxx' fields to use as query selection criteria; example:
'   Array As String(econ.DTSTART, econ.DTEND)
' - selectionOperators: a String Array that contains an operator (=, &lt;, &gt;, &lt;=, &gt;=, &lt;&gt;) for each of the 'selectionFields' entries. Example:
'   Array As String("&gt;=", "&lt;=")
' - selectionArgs: a String Array that contains a value for each of the 'selectionFields' entries. Example:
'   Array As String(DateTime.DateTimeParse("01/01/2021", "08:00:00"), DateTime.DateTimeParse("31/01/2021", "17:00:00"))
' - sortBy: use one of the econ.xxx values, e.g. 'econ.TITLE'
' - sortAscending: True for ascending, False for descending.
' 'selectionFields', 'selectionOperators', and 'selectionArgs' must contain the same number of entries,
' otherwise an uninitialized list will be returned
Public Sub GetSelectedEventsForCalendar(calendarID As String, _
										selectionFields() As String, selectionOperators() As String, selectionArgs() As String, _
										sortBy As String, sortAscending As Boolean) As List

	Dim allSelectedEvents As List ' This list will be populated and returned
	If (selectionArgs.Length <> selectionFields.Length) Or (selectionArgs.Length <> selectionOperators.Length) Or (selectionFields.Length <> selectionOperators.Length) Then
		Log("Array dimensions are not equal: selectionArgs.Length=" & selectionArgs.Length & "; selectionFields.Length=" & selectionFields.Length & "; selectionOperators.Length=" & selectionOperators.Length)
		Return allSelectedEvents
	End If
	allSelectedEvents.Initialize

	Dim sortOrder As String = " ASC"
	If sortAscending = False Then sortOrder = " DESC"
	sortBy = SetSortBy(sortBy, econ.ID, eventProjection)

	Dim selection As String = "(" & econ.CALENDAR_ID & "=" & calendarID & ")"
	If selectionArgs.Length > 0 Then
		For i = 0 To (selectionArgs.Length - 1)
			selection = selection & " AND (" & selectionFields(i) & selectionOperators(i) & "?)"
		Next
	End If

	' See method GetAllVisibleCalendars for info
	Dim crsr As Cursor = cr.Query(econ.CONTENT_URI, eventProjection, selection, selectionArgs, sortBy & sortOrder)
	If crsr.IsInitialized Then
		If crsr.RowCount > 0 Then
			For i = 0 To (crsr.RowCount - 1)
				crsr.Position = i
				allSelectedEvents.Add(CreateEventInfoFromCursor(crsr, Null))
			Next
			crsr.Close
		End If
	End If

	Return allSelectedEvents

End Sub

' Returns a list of type EventInfo containing selected Events for the specified Calendar id.
' The returned data contain a combination of Event and Instance data.
' - selectionFields: a String Array that contains the 'econ.xxx' fields to use as query selection criteria; example:
'   Array As String(econ.DTSTART, econ.DTEND)
' - selectionOperators: a String Array that contains an operator (=, &lt;, &gt;, &lt;=, &gt;=, &lt;&gt;) for each of the 'selectionFields' entries. Example:
'   Array As String("&gt;=", "&lt;=")
' - selectionArgs: a String Array that contains a value for each of the 'selectionFields' entries. Example:
'   Array As String(DateTime.DateTimeParse("01/01/2021", "08:00:00"), DateTime.DateTimeParse("31/01/2021", "17:00:00"))
' - repeatRecurringInstancesFrom/repeatRecurringInstancesTo: a DateTime range within which all recurring instances should be returned
' - sortBy: use one of the econ.xxx values, e.g. 'econ.TITLE'
' - sortAscending: True for ascending, False for descending.
' 'selectionFields', 'selectionOperators', and 'selectionArgs' must contain the same number of entries,
' otherwise an uninitialized list will be returned. If no selection is required other than 'repeatRecurringInstancesFrom' / 'repeatRecurringInstancesTo',
' just declare all three Arrays as e.g. "Dim arr() As String" without adding any data to them.
Public Sub GetSelectedEventsInstancesForCalendar(calendarID As String, _
												selectionFields() As String, selectionOperators() As String, selectionArgs() As String, _
												repeatRecurringInstancesFrom As Long, repeatRecurringInstancesTo As Long, _
												sortBy As String, sortAscending As Boolean) As List

	Dim allSelectedEvents As List ' This list will be populated and returned
	If (selectionArgs.Length <> selectionFields.Length) Or (selectionArgs.Length <> selectionOperators.Length) Or (selectionFields.Length <> selectionOperators.Length) Then
		Log("Array dimensions are not equal: selectionArgs.Length=" & selectionArgs.Length & "; selectionFields.Length=" & selectionFields.Length & "; selectionOperators.Length=" & selectionOperators.Length)
		Return allSelectedEvents
	End If
	allSelectedEvents.Initialize

	Dim sortOrder As String = " ASC"
	If sortAscending = False Then sortOrder = " DESC"
	sortBy = SetSortBy(sortBy, econ.ID, eventInstanceProjection)

	Dim selection As String = "(" & econ.CALENDAR_ID & "=" & calendarID & ")"
	If selectionArgs.Length > 0 Then
		For i = 0 To (selectionArgs.Length - 1)
			selection = selection & " AND (" & selectionFields(i) & selectionOperators(i) & "?)"
		Next
	End If
	selection = selection & " AND (" & icon.BEGIN & ">=?) AND (" & icon.END & "<=?)"

	' See method GetAllVisibleCalendars for info
	Dim instanceSelectionArgs() As String
	Dim instanceURI As Uri
	If selectionArgs.Length > 0 Then
		instanceSelectionArgs = CombineStringArrays(selectionArgs, Array As String(repeatRecurringInstancesFrom, repeatRecurringInstancesTo))
	Else
		instanceSelectionArgs = Array As String(repeatRecurringInstancesFrom, repeatRecurringInstancesTo)
	End If

	instanceURI.WithAppendedPath(icon.CONTENT_URI, repeatRecurringInstancesFrom)
	instanceURI.WithAppendedPath(instanceURI, repeatRecurringInstancesTo)
	Dim crsr As Cursor = cr.Query(instanceURI, eventInstanceProjection, selection, instanceSelectionArgs, sortBy & sortOrder)
	If crsr.IsInitialized Then
		If crsr.RowCount > 0 Then
			Dim previousEventId As String = ""
			Dim crsrEvent As Cursor
			For i = 0 To (crsr.RowCount - 1)
				crsr.Position = i
				If previousEventId <> crsr.GetString(icon.EVENT_ID) Then
					If crsrEvent.IsInitialized Then crsrEvent.Close
					previousEventId = crsr.GetString(icon.EVENT_ID)
					crsrEvent = cr.Query(econ.CONTENT_URI, eventProjection, econ.ID & "=" & previousEventId, Null, "")
					If crsrEvent.IsInitialized Then
						If crsrEvent.RowCount > 0 Then crsrEvent.Position = 0
					End If
				End If
				If crsrEvent.IsInitialized Then
					allSelectedEvents.Add(CreateEventInfoFromCursor(crsrEvent, crsr))
				Else
					allSelectedEvents.Add(CreateEventInfoFromCursor(Null, crsr))
				End If
			Next
			crsr.Close
			If crsrEvent.IsInitialized Then crsrEvent.Close
		End If
	End If

	Return allSelectedEvents

End Sub

' Returns a variable of type EventInfo containing the selected Event's data, or Null if the ID doesn't exist.
Public Sub GetEventByID(eventId As String) As EventInfo

	Try
		Dim crsr As Cursor = cr.Query(econ.CONTENT_URI, eventProjection, econ.ID & "=?", Array As String(eventId), "")
		If crsr.IsInitialized Then
			If crsr.RowCount > 0 Then
				crsr.Position = 0
				Return CreateEventInfoFromCursor(crsr, Null)
				crsr.Close
			End If
		End If
	Catch
		Log("GetEventByID: " & LastException)
	End Try

	Return Null

End Sub

' I did not test this - feel free to uncomment and test :)
' Returns a list of type EventInfo containing all Events for the specified Calendar id and Sync id.
' - sortBy: use one of the econ.xxx values, e.g. 'econ.TITLE' (the value must be present in 'eventProjection')
' - sortAscending: True for ascending, False for descending
'Public Sub GetEventsBySyncId(calendarID As String, syncId As String, sortBy As String, sortAscending As Boolean) As List
'
'	Dim selectionFields() As String = Array As String(econ.SYNC_ID)
'	Dim selectionOperators() As String = Array As String("=")
'	Dim selectionArgs() As String = Array As String(syncId)
'
'	Return GetSelectedEventsForCalendar(calendarID, selectionFields, selectionOperators, selectionArgs, sortBy, sortAscending)
'
'End Sub

' I did not test this - feel free to uncomment and test :)
' Returns a list of type EventInfo containing all Events for the specified Calendar id and Sync id.
' - repeatRecurringInstancesFrom/repeatRecurringInstancesTo: a DateTime range within which all recurring instances should be returned
' - sortBy: use one of the econ.xxx values, e.g. 'econ.TITLE' (the value must be present in 'eventProjection')
' - sortAscending: True for ascending, False for descending
'Public Sub GetEventsInstancesBySyncId(calendarID As String, syncId As String, _
'									repeatRecurringInstancesFrom As Long, repeatRecurringInstancesTo As Long, _
'									sortBy As String, sortAscending As Boolean) As List
'
'	Dim selectionFields() As String = Array As String(econ.SYNC_ID)
'	Dim selectionOperators() As String = Array As String("=")
'	Dim selectionArgs() As String = Array As String(syncId)
'
'	Return GetSelectedEventsInstancesForCalendar(calendarID, selectionFields, selectionOperators, selectionArgs, repeatRecurringInstancesFrom, repeatRecurringInstancesTo, sortBy, sortAscending)
'
'End Sub

' Used by methods GetAllVisibleEventsForCalendar, GetSelectedEventsForCalendar, GetEventByID, and GetEventsBySyncId
Private Sub CreateEventInfoFromCursor(crsrEvents As Cursor, crsrInstances As Cursor) As EventInfo

	' NOTE: all Cursor columns that are used here must be present in eventProjection/eventInstanceProjection as well !

	Dim t1 As EventInfo
	t1.Initialize

	If crsrEvents <> Null Then
		t1.eventId = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.ID)
		t1.allDay = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.ALL_DAY)
		t1.availability = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.AVAILABILITY)
		t1.calendarAccessLevel = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.CALENDAR_ACCESS_LEVEL)
		t1.description = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.DESCRIPTION)
		t1.dateTimeEnd = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.DTEND)
		t1.dateTimeStart = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.DTSTART)
		t1.duration = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.DURATION)
		t1.location = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.LOCATION)
		t1.organizer = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.ORGANIZER)
		t1.title = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.TITLE)
		t1.customAppPackage = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.CUSTOM_APP_PACKAGE)
		t1.customAppUri = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.CUSTOM_APP_URI)
		t1.displayColor = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.DISPLAY_COLOR)
		t1.eventColor = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.EVENT_COLOR)
		t1.eventColorKey = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.EVENT_COLOR_KEY)
		t1.endTimeZone = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.EVENT_END_TIMEZONE)
		t1.timeZone = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.EVENT_TIMEZONE)
		t1.recurrenceExceptionDates = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.EXDATE)
		t1.recurrenceExceptionRule = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.EXRULE)
		t1.recurrenceDates = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.RDATE)
		t1.recurrenceRule = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.RRULE)
		t1.eventStatus = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.STATUS)
		t1.syncId = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.SYNC_ID)
		t1.visible = CreateEventInfoFromCursorOneColumn(crsrEvents, econ.VISIBLE)
	End If

	If crsrInstances <> Null Then
		t1.instanceBegin = CreateEventInfoFromCursorOneColumn(crsrInstances, icon.BEGIN)
		t1.instanceEnd = CreateEventInfoFromCursorOneColumn(crsrInstances, icon.END)
		t1.instanceId = CreateEventInfoFromCursorOneColumn(crsrInstances, icon.ID)
	End If

	Return t1

End Sub

' Used by method CreateEventInfoFromCursor to cope with the fact that the Events Cursor may be based
' on an Events or Instances URI, and the column layout differs between those 2
Private Sub CreateEventInfoFromCursorOneColumn(cursor1 As Cursor, column As String) As String

	Try
		Return "" & cursor1.GetString(column) ' The "" is to avoid the app crashing if the column contains Null
	Catch
		Return ""
	End Try

End Sub

' Attempts to delete an Event and returns the number of Events that were deleted.
' Notice that Event Instances cannot be written to directly; they have to be handled via the Event.
Public Sub DeleteEvent(eventId As Int) As Int

	Try
		Dim selectionArgs() As String = Array As String(eventId)
		Return cr.Delete(econ.CONTENT_URI, econ.ID & "=?", selectionArgs)
	Catch
		Log("DeleteEvent: " & LastException)
		Return 0
	End Try

End Sub

' Adds a new Event to a Calendar and returns the new Event's id, or -1 if no Event was added.
' Notice that Event Instances cannot be written to directly; they have to be handled via the Event.
' - In parameter 'theEvent', item 'id' is ignored.
' - 'econValuesOrNull' is either Null or a list of 'econ.xxx' values indicating the fields from 'theEvent' that
'   must be processed. If Null, all fields are processed.
Public Sub AddEvent(calendarId As String, theEvent As EventInfo, econValuesOrNull As List) As Int

	' For more information about writing Events, see https://developer.android.com/reference/android/provider/CalendarContract.Events#writing-to-events

	Try
		Dim val As ContentValues = FillEventContentValues(theEvent, econValuesOrNull)
		val.PutLong(econ.CALENDAR_ID, calendarId)
		Dim resUri As Uri = cr.Insert(econ.CONTENT_URI, val)
		If resUri.IsInitialized Then
			If resUri <> Null Then
				Dim eventId As Int = resUri.ParseId
				Return eventId
			End If
		End If
	Catch
		Log("AddEvent: " & LastException)
	End Try

	Return -1

End Sub

' Attempts to update an Event and returns the number of Events that were updated.
' Notice that Event Instances cannot be written to directly; they have to be handled via the Event.
' - In parameter 'theEvent', item 'id' is ignored.
' - 'econValuesOrNull' is either Null or a list of 'econ.xxx' values indicating the fields from 'theEvent' that
'   must be processed. If Null, all fields are processed.
Public Sub UpdateEvent(eventId As Int, theEvent As EventInfo, econValuesOrNull As List) As Int

	Try
		Dim selectionArgs() As String = Array As String(eventId)
		Dim val As ContentValues = FillEventContentValues(theEvent, econValuesOrNull)
		Return cr.Update(econ.CONTENT_URI, val, econ.ID & "=?", selectionArgs)
	Catch
		Log("UpdateEvent: " & LastException)
		Return 0
	End Try

End Sub

' Used by methods AddEvent and UpdateEvent
Private Sub FillEventContentValues(theEvent As EventInfo, econValuesOrNull As List) As ContentValues

	Dim val As ContentValues
	val.Initialize
	FillOneContentValue(val, econ.DTSTART, theEvent.dateTimeStart, True, econValuesOrNull)
	FillOneContentValue(val, econ.DTEND, theEvent.dateTimeEnd, True, econValuesOrNull)
	FillOneContentValue(val, econ.TITLE, theEvent.title, False, econValuesOrNull)
	FillOneContentValue(val, econ.LOCATION, theEvent.location, False, econValuesOrNull)
	FillOneContentValue(val, econ.DESCRIPTION, theEvent.description, False, econValuesOrNull)
	FillOneContentValue(val, econ.ORGANIZER, theEvent.organizer, False, econValuesOrNull)
	FillOneContentValue(val, econ.VISIBLE, theEvent.visible, False, econValuesOrNull)
	FillOneContentValue(val, econ.SYNC_ID, theEvent.syncId, False, econValuesOrNull)
	FillOneContentValue(val, econ.ACCESS_LEVEL, theEvent.calendarAccessLevel, False, econValuesOrNull)
	FillOneContentValue(val, econ.ALL_DAY, theEvent.allDay, False, econValuesOrNull)
	FillOneContentValue(val, econ.AVAILABILITY, theEvent.availability, False, econValuesOrNull)
	FillOneContentValue(val, econ.DURATION, theEvent.duration, False, econValuesOrNull)
	FillOneContentValue(val, econ.CUSTOM_APP_PACKAGE, theEvent.customAppPackage, False, econValuesOrNull)
	FillOneContentValue(val, econ.CUSTOM_APP_URI, theEvent.customAppUri, False, econValuesOrNull)
	FillOneContentValue(val, econ.DISPLAY_COLOR, theEvent.displayColor, False, econValuesOrNull)
	FillOneContentValue(val, econ.EVENT_COLOR, theEvent.eventColor, False, econValuesOrNull)
	FillOneContentValue(val, econ.EVENT_COLOR_KEY, theEvent.eventColorKey, False, econValuesOrNull)
	FillOneContentValue(val, econ.EVENT_END_TIMEZONE, theEvent.endTimeZone, False, econValuesOrNull)
	FillOneContentValue(val, econ.EVENT_TIMEZONE, theEvent.timeZone, False, econValuesOrNull)
	FillOneContentValue(val, econ.EXDATE, theEvent.recurrenceExceptionDates, False, econValuesOrNull)
	FillOneContentValue(val, econ.EXRULE, theEvent.recurrenceExceptionRule, False, econValuesOrNull)
	FillOneContentValue(val, econ.RDATE, theEvent.recurrenceDates, False, econValuesOrNull)
	FillOneContentValue(val, econ.RRULE, theEvent.recurrenceRule, False, econValuesOrNull)
	FillOneContentValue(val, econ.STATUS, theEvent.eventStatus, False, econValuesOrNull)
	FillOneContentValue(val, econ.SYNC_ID, theEvent.syncId, False, econValuesOrNull)
	FillOneContentValue(val, econ.VISIBLE, theEvent.visible, False, econValuesOrNull)
	' These are not applicable because, per https://developer.android.com/reference/android/provider/CalendarContract.Instances,
	' "The instances table is not writable and only provides a way to query event occurrences."
'	FillOneContentValue(val, icon.BEGIN, theEvent.instanceBegin, False, econValuesOrNull)
'	FillOneContentValue(val, icon.END, theEvent.instanceEnd, False, econValuesOrNull)
'	FillOneContentValue(val, icon.END_DAY, theEvent.instanceEndDay, False, econValuesOrNull)
'	FillOneContentValue(val, icon.END_MINUTE, theEvent.instanceEndMinute, False, econValuesOrNull)
'	FillOneContentValue(val, icon.EVENT_ID, theEvent.instanceEventId, False, econValuesOrNull)
'	FillOneContentValue(val, ECON_INSTANCE_START_DAY, theEvent.instanceStartDay, False, econValuesOrNull)
'	FillOneContentValue(val, ECON_INSTANCE_START_MINUTE, theEvent.instanceStartMinute, False, econValuesOrNull)
	Return val

End Sub

' Returns a list of type AttendeeInfo containing all Attendees for the selected Event id.
' - sortBy: use one of the acon.xxx values, e.g. 'acon.ATTENDEE_NAME' (the value must be present in the 'projection' - see comments)
' - sortAscending: True for ascending, False for descending
Public Sub GetEventAttendees(eventId As String, sortBy As String, sortAscending As Boolean) As List

	Dim allAttendees As List ' This list will be populated and returned
	allAttendees.Initialize

	Dim sortOrder As String = " ASC"
	If sortAscending = False Then sortOrder = " DESC"
	sortBy = SetSortBy(sortBy, acon.ATTENDEE_NAME, AttendeeProjection)

	' See method GetAllVisibleCalendars for info
	Dim selectionArgs() As String = Array As String(eventId)
	Dim crsr As Cursor = cr.Query(acon.CONTENT_URI, AttendeeProjection, acon.EVENT_ID & "=?", selectionArgs, sortBy & sortOrder)
	If crsr.IsInitialized Then
		If crsr.RowCount > 0 Then
			For i = 0 To (crsr.RowCount - 1)
				crsr.Position = i
				allAttendees.Add(CreateAttendeeInfoFromCursor(crsr))
			Next
			crsr.Close
		End If
	End If

	Return allAttendees

End Sub

' Used by method GetEventAttendees
Private Sub CreateAttendeeInfoFromCursor(cursor1 As Cursor) As AttendeeInfo

	Dim t1 As AttendeeInfo
	t1.Initialize
	t1.email = cursor1.GetString(acon.ATTENDEE_EMAIL)
	t1.identityNamespace = cursor1.GetString(acon.ATTENDEE_ID_NAMESPACE)
	t1.identity = cursor1.GetString(acon.ATTENDEE_IDENTITY)
	t1.name = cursor1.GetString(acon.ATTENDEE_NAME)
	t1.relationship = cursor1.GetString(acon.ATTENDEE_RELATIONSHIP)
	t1.attendeeType = cursor1.GetString(acon.ATTENDEE_TYPE)
	t1.eventId = cursor1.GetString(acon.EVENT_ID)
	Return t1

End Sub

' Adds an Attendee to an Event and returns the id of the added Attendee, or -1 if no Attendee was added.
' The Event ID is specified through theAttendee.eventId.
' Notice that Event Instances cannot be written to directly; they have to be handled via the Event.
' - 'aconValuesOrNull' is either Null or a list of 'acon.xxx' values indicating the fields from 'theAttendee' that
'   must be processed. If Null, all fields are processed.
Public Sub AddAttendeeToEvent(theAttendee As AttendeeInfo, aconValuesOrNull As List) As Int

	Try
		Dim val As ContentValues = FillAttendeeContentValues(theAttendee, aconValuesOrNull)
		Dim attendee As Uri = cr.Insert(acon.CONTENT_URI, val)
		If attendee.IsInitialized Then
			If attendee <> Null Then
				Dim attendeeID As Int = attendee.ParseId
				Return attendeeID
			End If
		End If
	Catch
		Log("AddAttendeeToEvent: " & LastException)
	End Try

	Return -1

End Sub

' Used by method AddAttendeeToEvent
Private Sub FillAttendeeContentValues(theAttendee As AttendeeInfo, aconValuesOrNull As List) As ContentValues

	Dim val As ContentValues
	val.Initialize
	FillOneContentValue(val, acon.ATTENDEE_EMAIL, theAttendee.email, False, aconValuesOrNull)
	FillOneContentValue(val, acon.ATTENDEE_NAME, theAttendee.name, False, aconValuesOrNull)
	FillOneContentValue(val, acon.ATTENDEE_ID_NAMESPACE, theAttendee.identityNamespace, False, aconValuesOrNull)
	FillOneContentValue(val, acon.ATTENDEE_IDENTITY, theAttendee.identity, False, aconValuesOrNull)
	FillOneContentValue(val, acon.ATTENDEE_RELATIONSHIP, theAttendee.relationship, False, aconValuesOrNull)
	FillOneContentValue(val, acon.ATTENDEE_TYPE, theAttendee.attendeeType, False, aconValuesOrNull)
	FillOneContentValue(val, acon.EVENT_ID, theAttendee.eventId, False, aconValuesOrNull)
	Return val

End Sub

' Adds a Reminder to an Event and returns the id of the added Reminder, or -1 if no Reminder was added.
' Notice that Event Instances cannot be written to directly; they have to be handled via the Event.
' 'method' is one of the 'rcon.METHOD_...' constants.
Public Sub AddReminderToEvent(eventID As Int, method As String, minutesBefore As Int) As Int

	Try
		Dim val As ContentValues
		val.Initialize
		val.PutString(rcon.EVENT_ID, eventID)
		val.PutInteger(rcon.METHOD, method)
		val.PutString(rcon.MINUTES, minutesBefore)
		Dim reminderuri As Uri = cr.Insert(rcon.CONTENT_URI, val)
		If reminderuri.IsInitialized Then
			If reminderuri <> Null Then
				Dim reminderID As Int = reminderuri.ParseId
				Return reminderID
			End If
		End If
	Catch
		Log("AddReminderToEvent: " & LastException)
	End Try

	Return -1

End Sub

' Returns a list of type ReminderInfo containing all Reminders for the selected Event id.
' - sortBy: use one of the rcon.xxx values, e.g. 'rcon.METHOD' (the value must be present in the 'projection' - see comments)
' - sortAscending: True for ascending, False for descending
Public Sub GetEventReminders(eventId As String, sortBy As String, sortAscending As Boolean) As List

	Dim allReminders As List ' This list will be populated and returned
	allReminders.Initialize

	Dim sortOrder As String = " ASC"
	If sortAscending = False Then sortOrder = " DESC"
	sortBy = SetSortBy(sortBy, rcon.ID, reminderProjection)

	' See method GetAllVisibleCalendars for info
	Dim selectionArgs() As String = Array As String(eventId)
	Dim crsr As Cursor = cr.Query(rcon.CONTENT_URI, reminderProjection, rcon.EVENT_ID & "=?", selectionArgs, sortBy & sortOrder)
	If crsr.IsInitialized Then
		If crsr.RowCount > 0 Then
			For i = 0 To (crsr.RowCount - 1)
				crsr.Position = i
				' DonManfred:
				' You can use the constants you used for the projection. But remember:
				' only the ones you defined in the projection are available in the Result.
				allReminders.Add(CreateReminderInfo(crsr.GetString(rcon.ID), crsr.GetInt(rcon.METHOD), crsr.GetString(rcon.MINUTES)))
			Next
			crsr.Close
		End If
	End If

	Return allReminders

End Sub

' Used by method GetEventReminders
Private Sub CreateReminderInfo(reminderId As String, method As Int, minutesBefore As Int) As ReminderInfo

	Dim t1 As ReminderInfo
	t1.Initialize
	t1.reminderId = reminderId
	t1.method = method
	t1.minutesBefore = minutesBefore
	Return t1

End Sub
#End Region ' Events and Event Instances

#Region Utility
' Used by methods FillCalendarContentValues and FillEventContentValues
Private Sub FillOneContentValue(val As ContentValues, fieldName As String, fieldVal As String, isLong As Boolean, xconValuesOrNull As List)

	If xconValuesOrNull.IsInitialized Then
		If xconValuesOrNull <> Null Then
			If xconValuesOrNull.IndexOf(fieldName) < 0 Then Return
		End If
	End If

	If isLong Then
		val.PutLong(fieldName, fieldVal)
	Else
		val.PutString(fieldName, fieldVal)
	End If

End Sub

' Used by all methods that have 'sortBy' in their signature; ensures that
' the 'sortBy' field is present in the 'projection' and returns the default value if it isn't.
Private Sub SetSortBy(sortBy As String, deflt As String, projection() As String) As String

	If sortBy = "" Then Return deflt

	For i = 0 To (projection.Length - 1)
		If projection(i) = sortBy Then Return sortBy
	Next

	Return deflt

End Sub

' Used by method GetSelectedEventsForCalendar
Private Sub CombineStringArrays(a1() As String, a2() As String) As String()

	Dim combo(a1.Length + a2.Length) As String
	Dim i As Int
	Dim iOut As Int = -1

	For i = 0 To (a1.Length - 1)
		iOut = iOut + 1
		combo(iOut) = a1(i)
	Next

	For i = 0 To (a2.Length - 1)
		iOut = iOut + 1
		combo(iOut) = a2(i)
	Next

	Return combo

End Sub
#End Region ' Utility