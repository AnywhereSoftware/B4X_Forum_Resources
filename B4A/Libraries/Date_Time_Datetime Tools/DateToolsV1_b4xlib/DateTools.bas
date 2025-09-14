B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
'###############################################
' Class with Date and Time Functions
'-----------------------------------------------
' Name:			DateTools
' Version:		1 (04/2021)
' State:		()WIP (X)Release
' Depend Libs:	Core, XUI
' Depend Mod.:	-
' Depend Class:	-
' Layout:		-
' Files:		-
' Database:		-
' Other:		-
'-----------------------------------------------
' (C) TECHDOC G. Becker
'###############################################

#region --- Globals, Initialize ---
Sub Class_Globals
	Private saveDateFormat As String
	Private saveTimeFormat As String
	Private lCheck As Long = 0
	Private xui As XUI
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub
#end region

'###############################################

#region - Compare ---
' Compare 2 dates
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' Date1/2: Date formated like DateTime.DateFormat
' Return: =equal, > greater, < smaller and (>=/<=)
public Sub compareDate(Date1 As String, Date2 As String) As String
	Try
		If CheckDate(Date1) = False Or CheckDate(Date2) = False Then Return ""
		
		Dim d1 As Long = DateTime.DateParse(Date1)
		Dim d2 As Long = DateTime.DateParse(Date2)
		
		If d2 = d1 Then
			Return "="
		else if d2 > d1 Then
			Return ">"
		else if d2 < d1 Then
			Return "<"
		else if d2 >= d1 Then
			Return ">="
		else if d2 <= d1 Then
			Return "<="
		Else
			Return "<>"
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return ""
	End Try
End Sub

' Compare 2 Times 
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' Time1/2: Time formated like DateTime.TimeFormat
' Return: =equal, > greater, < smaller and (>=/<=)
public Sub compareTime(Time1 As String, Time2 As String) As String
	Try
		If CheckTime(Time1) = False Or CheckTime(Time2) = False Then Return ""
		
		Dim t1 As Long = DateTime.timeParse(Time1)
		Dim t2 As Long = DateTime.timeParse(Time2)
		
		If t2 = t1 Then
			Return "="
		else if t2 > t1 Then
			Return ">"
		else if t2 < t1 Then
			Return "<"
		else if t2 >= t1 Then
			Return ">="
		else if t2 <= t1 Then
			Return "<="
		Else
			Return "<>"
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return ""
	End Try
End Sub

' Compare 2 datetimes
' Version: 1, ( ) WIP (X) Release
'  Prior set DateTime.DateFormat and DateTime.TimeFormat
' Date1/2: Date formated like DateTime.DateFormat
' Time1/2: Time formated like DateTime.TimeFormat
' Return: =equal, > greater, < smaller and (>=/<=)
public Sub compareDateTime(Date1 As String, Date2 As String, _
	Time1 As String, Time2 As String) As String
	Try
		If CheckDate(Date1) = False Or CheckDate(Date2) = False Then Return ""
		If CheckTime(Time1) = False Or CheckTime(Time2) = False Then Return ""
		
		Dim d1 As Long = DateTime.DatetimeParse(Date1,Time1)
		Dim d2 As Long = DateTime.DatetimeParse(Date2,Time2)
		
		If d2 = d1 Then
			Return "="
		else if d2 > d1 Then
			Return ">"
		else if d2 < d1 Then
			Return "<"
		else if d2 >= d1 Then
			Return ">="
		else if d2 <= d1 Then
			Return "<="
		Else
			Return "<>"
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return ""
	End Try
End Sub
#end region

'###############################################

#region --- Ticks ---
' get Date as TICK Value
' Version: 1, ( ) WIP (X) Release
' 1 TICK = 1/1000 Second, elapsed since 1/1/1970 00:00:00
' Prior set DateTime.DateFormat
' StartDate: Date formated like DateTime.DateFormat 
' Return: TICK value as long
public Sub getDateTick(StartDate As String) As Long
	' check date and convert to neutral tic
	Try
		If CheckDate(StartDate) = True Then
			Return DateTime.Dateparse(StartDate)
		Else
			Return Null
		End If
		Return DateTime.DateParse(StartDate)
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
	End Try
End Sub

' get Time as TIC Value
' Version: 1, ( ) WIP (X) Release
' 1 TICK = 1/1000 Second elapsed since 00:00 o'clock
' Prior set DateTime.TimeFormat
' StartDate: Time formated like DateTime.TimeFormat 
' Return: TIC value as long
public Sub getTimeTick(StartTime As String) As Long
	Try
		If CheckTime(StartTime) = True Then
			Return DateTime.TimeParse(StartTime)
		Else
			Return Null
		End If
		Return DateTime.TimeParse(StartTime)
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
	End Try
End Sub

' get DateTime as TICK Value
' Version: 1, ( ) WIP (X) Release
' 1 TICK = 1/1000 Second
' Prior set DateTime.DateFormat and DateTime.TimeFormat
' StartDate: Date formated like DateTime.DateFormat
' StartTime: Time formated like DateTime.TimeFormat
' Return: TICK value as long
public Sub getDateTimeTick(StartDate As String, StartTime As String) As Long
	Try
		If CheckDate(StartDate) = True And CheckTime(StartTime) = True Then
			Return DateTime.DateTimeParse(StartDate,StartTime)
		Else
			Return Null
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error")
		Return Null
	End Try
End Sub

' Convert TICK to Date string
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' StartDate: Date in Ticks
' Return: Date as formatted string
public Sub getTick2Date(StartDate As Long) As String
	Try
		Return DateTime.Date(StartDate)
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return ""
	End Try
End Sub

' Convert TICK to Time string
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.TimeFormat
' StartTime: Time in Ticks
' Return: Time as formatted string
public Sub getTick2Time(StartTime As Long) As String
	Try
		Return DateTime.time(StartTime)
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return ""
	End Try
End Sub

' Convert TICK to DateTime string
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.TimeFormat
' StartDateTime: DateTime in Ticks
' Return: DateTime as formatted string
public Sub getTick2DateTime(StartDateTime As Long) As String
	Try
		Dim d,t As String
		d = DateTime.date(StartDateTime)
		t = DateTime.time(StartDateTime)
		Return d & " " & t
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return ""
	End Try
End Sub
#end region

'###############################################

#region --- WeekNumber, Month/Day Between, Add/subtract Periode
' Return target date from added or subtracted period.
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' StartDate: Date formated like DateTime.DateFormat 
' Value: .. to add/subtract
' Unit: y-ear,m-onth,d-ay.w-eek,q-uarter
' Fill: true-fill digits with null
' Return: Date as string formated with DateTime.DateFormat
public Sub getDatePeriode(StartDate As String, Value As Long, Unit As String) As String
	Try
		Dim StartDt As Long = -1
		Dim TargetDtTic As Long
		Dim targetDt As String
		Dim d,m,y As Long
		d = DateTime.GetDayOfMonth(StartDt)
		m = DateTime.GetMonth(StartDt)
		y = DateTime.GetYear(StartDt)

		' check date and convert to neutral tic
		If CheckDate(StartDate) = False Then Return Null
			
		ResetSetDateTimeFormat(False)
		
		' do unit functions
		Select Unit
			Case "d","D","Day","DAY","day"
				TargetDtTic = StartDt + DateTime.TicksPerDay * Value
			Case "m","M","Month","MONTH","month"
				Dim y1 As Long = (m + Value)/12
				If Value > 0 Then ' add
					y= y + y1
					m = (m + Value) - (y1*12)
				Else ' subtract
					Dim y1 As Long = Value/12
					y = y + y1
					Dim m1 As Long = Value - (y1 * 12 )
					If m + m1 > 0 Then
						m = m + m1
					Else
						m = 12 - (m+m1)
						y=y-1
					End If
				End If
			Case "y","Y","Year","YEAR","year"
				y = y + Value
				targetDt = y & "/" & m & "/" & d
				TargetDtTic = DateTime.DateParse(targetDt)
			Case "w","W","Week","WEEK","week"
				TargetDtTic = StartDt + (DateTime.TicksPerDay * 7 * Value)
			Case "q","Q","Quarter","QUARTER","quarter"
				Value = Value * 3 ' 1 quarter
				Dim y1 As Long = (m + Value)/12
				If Value > 0 Then ' add
					y= y + y1
					m = (m + Value) - (y1*12)
				Else ' subtract
					Dim y1 As Long = Value/12
					y = y + y1
					Dim m1 As Long = Value - (y1 * 12 )
					If m + m1 > 0 Then
						m = m + m1
					Else
						m = 12 - (m+m1)
						y=y-1
					End If
				End If
		End Select
		
		' build return date
		targetDt = y & "/" & m & "/" & d
		TargetDtTic = DateTime.DateParse(targetDt)
		targetDt = DateTime.Date(TargetDtTic)
		ResetSetDateTimeFormat(True)
		Return targetDt
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
		ResetSetDateTimeFormat(True)
	End Try
End Sub

' Compute week number of given date
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' StartDate: Date formatted DateTime.DateFormat
' Return: week number
public Sub getWeekNumber(StartDate As String) As Int
	Try
		ResetSetDateTimeFormat(False)
		
		Dim y As Int = DateTime.GetYear(DateTime.DateParse(StartDate))
		
		If CheckDate(StartDate) Then
			Dim d1 As String = y & "/01/01"
			Dim d2 As Long = DateTime.dateparse(d1)
			Dim Diff As Long = DateTime.DateParse(StartDate) - d2
			Dim w As Int = (Diff/DateTime.TicksPerDay)/7+1
			If w = 0 Then w = 1
			Return w
		Else
			Return Null
		End If
		ResetSetDateTimeFormat(True)
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		ResetSetDateTimeFormat(True)
		Return Null
	End Try
End Sub

' Compute days between 2 dates
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' Date1/2: Date formatted DateTime.DateFormat
' Return: days - 0 if same day
public Sub getDaysBetween(Date1 As String, Date2 As String) As Int
	Try
		If CheckDate(Date1) = True And CheckDate(Date2) = True Then
			Dim d1 As Long = DateTime.DateParse(Date1)
			Dim d2 As Long = DateTime.DateParse(Date2)
			Dim Diff As Long  = d2-d1
			Return (Diff/DateTime.TicksPerDay)
		Else 
			Return Null
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
	End Try
End Sub

' Compute month between 2 dates
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' Date1/2: Date formatted DateTime.DateFormat
' Return: mont - 0 if same month
public Sub getMonthBetween(Date1 As String, Date2 As String) As Int
	Try
		If CheckDate(Date1) = True And CheckDate(Date2) = True Then
			Dim d1 As Long = DateTime.DateParse(Date1)
			Dim d2 As Long = DateTime.DateParse(Date2)
			Dim y As Long = DateTime.GetYear(d2) - DateTime.GetYear(d1)
			Dim m As Long = y * 12
			m = m - DateTime.GetMonth(d1)
			m = m + DateTime.GetMonth(d2)	
			
			Return m
		Else 
			Return Null
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
	End Try
End Sub
#end region

'###############################################

#region --- Between, Hours, Minutes ---
' Compute hours between 2 times
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.TimeFormat
' Time1/2: Time formatted DateTime.TimeFormat
' Return: hours - 0 if same hour
public Sub getHoursBetween(Time1 As String, Time2 As String) As Int
	Try
		If CheckTime(Time1) = True And CheckTime(Time2) = True Then
			Dim t1 As Long = DateTime.TimeParse(Time1)
			Dim t2 As Long = DateTime.TimeParse(Time2)
			Dim diff As Long = t2 - t1
			Dim h As Int = diff / DateTime.TicksPerminute
			Return h
		Else
			Return Null
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
	End Try
End Sub

' Compute minutes between 2 times
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.TimeFormat
' Time1/2: Time formatted DateTime.TimeFormat
' Return: minutes - 0 if same minute
public Sub getMinutesBetween(Time1 As String, Time2 As String) As Int
	Try
		If CheckTime(Time1) = True And CheckTime(Time2) = True Then
			Dim t1 As Long = DateTime.TimeParse(Time1)
			Dim t2 As Long = DateTime.TimeParse(Time2)
			Dim diff As Long = t2 - t1
			Dim h As Int = diff / DateTime.TicksPerminute
			Return h
		Else
			Return Null
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
	End Try
End Sub

' Convert minutes to HH:MM
' Version: 1, ( ) WIP (X) Release
' Minutes: Value to convert
' Return: string as HH:mm
public Sub convertMinutes(Minutes As Long) As String
	Try
		Dim h As Long = Minutes / 60
		Dim	m As Long = Minutes - h * 60
		Dim sh, sm As String
		If h < 10 Then
			sh = "0" & h
		Else
			sh = h
		End If
		If m < 10 Then
			sm = "0" & m
		Else
			sm = m
		End If
		
		Return sh & ":" & sm
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		Return Null
	End Try
End Sub
#end region

'###############################################

#region --- UTC, StartSummertime, Wintertime ---
' get UTC Time
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.TimeFormat
' Summertime: use it if true
' Return: datetime string formated 'date time Z' or 'date time ZS'
public Sub getUTC (Summertime As Boolean)  As String
	Try
		ResetSetDateTimeFormat(False)
		
		' get current date and time (device)
		Dim tnow As Long = DateTime.Now ' current date and UTC Wintertime in ticks
		Log(DateTime.date(tnow) & " " & DateTime.Time(tnow))		
		' get Summertime offset and correct UTC
		If Summertime Then
			If tnow >= getStartSummertime(DateTime.GetYear(tnow)) And _
				tnow <= getStartWintertime(DateTime.GetYear(tnow)) Then
				' subtract summertime offset
				tnow = tnow - DateTime.TicksPerHour	
			End If
		End If		
	
		ResetSetDateTimeFormat(True)
		
		' return result
		If Summertime Then
			Return DateTime.Date(tnow) & " " & DateTime.Time(tnow) & "Z"
		Else
			Return DateTime.Date(tnow) & " " & DateTime.Time(tnow) & "ZS"
		End If
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		ResetSetDateTimeFormat(True)
		Return Null
	End Try
End Sub

' get begin of Summertime in Europe (last Sunday in March)
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.Date and Time Format
' Year1: year to check
' Return: date as ticks
public Sub getStartSummertime(Year1 As Int) As Long
	Try
		ResetSetDateTimeFormat(False)
		
		Dim sDT As String = Year1 & "/03/01"
		Dim sH As String = "02:00:00"
		Dim rs As  Long = -1
		
		' get date of last SUnday in March
		If Year1 > 1970 Then
			Dim sy As Long = DateTime.DateTimeParse(sDT,sH)
			Dim sz As Long
			For x = 0 To 30
				sz = sy + x * DateTime.TicksPerDay
				If DateTime.GetDayOfWeek(sz) = 1  And _
					DateTime.GetMonth(sz) = 3 Then
					rs = sz
				End If
			Next
			Return rs
		Else
			Return Null
		End If
		ResetSetDateTimeFormat(True)
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		ResetSetDateTimeFormat(True)
		Return Null
	End Try
End Sub

' get begin of Wintertime in Europe (last Sunday in October)
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.Date and Time Format
' Year1: year to check
' Return: date as ticks
public Sub getStartWintertime(Year1 As Int) As Long
	Try
		
		ResetSetDateTimeFormat(False)
		
		Dim sDT As String = Year1 & "/10/01"
		Dim sH As String = "02:00:00"
		Dim rs As  Long = -1
		
		' get date of last Sunday in October
		If Year1 > 1970 Then
			Dim sy As Long = DateTime.Datetimeparse(sDT,sH)
			Dim sz As Long
			For x = 0 To 30
				sz = sy + x * DateTime.TicksPerDay
				If DateTime.GetDayOfWeek(sz) = 1  And _
					DateTime.GetMonth(sz) = 10 Then
					rs = sz
				End If
			Next
			Return rs
		Else
			Return Null
		End If
		
		ResetSetDateTimeFormat(True)
	Catch
		xui.MsgboxAsync(LastException,"Error!")
		ResetSetDateTimeFormat(True)
		Return Null
	End Try
End Sub
#end region

'###############################################

#region --- Helpers ---
' save/reset/set Date and Time Format
' Version: 1, ( ) WIP (X) Release
' use yyyy/MM/dd and HH:mm:ss as standard format
private Sub ResetSetDateTimeFormat(Reset As Boolean)
	If Reset Then
		If saveDateFormat <> "" Then DateTime.DateFormat=saveDateFormat
		If saveTimeFormat <> "" Then DateTime.TimeFormat=saveTimeFormat
	Else
		saveDateFormat=DateTime.DateFormat
		saveTimeFormat=DateTime.timeformat
		DateTime.DateFormat = "yyyy/MM/dd"
		DateTime.TimeFormat = "HH:mm:ss"
	End If
End Sub

' check correct time format
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.TimeFormat
' StartTime: Time formated like DateTime.TimeFormat
' Return: True if OK
Public Sub CheckTime(StartTime As String) As Boolean
	Try
		lCheck= DateTime.TimeParse(StartTime)
		Return True
	Catch
		xui.MsgboxAsync(LastException,"Wrong Time Format!")
		Return False
	End Try
End Sub

' check correct date format
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' StartDate: Date formated like DateTime.DateFormat
' Return: True if OK
Public Sub CheckDate(StartDate As String) As Boolean
	Try
		lCheck= DateTime.dateParse(StartDate)
		Return True
	Catch
		xui.MsgboxAsync(LastException,"Wrong Date Format!")
		Return False
	End Try
End Sub

' check correct datetime format
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat and DateTime.TimeFormat
' StartDate: Date formated like DateTime.DateFormat
' StartTime: Time formated like DateTime.TimeFormat
' Return: True if OK
Public Sub CheckDateTime(StartDate As String,StartTime As String) As Boolean
	Try
		lCheck= DateTime.dateTimeParse(StartDate,StartTime)
		Return True
	Catch
		xui.MsgboxAsync(LastException,"Wrong Date/Time Format!")
		Return False
	End Try
End Sub
#end region
'###############################################
' (C) TECHDOC G. Becker
'###############################################