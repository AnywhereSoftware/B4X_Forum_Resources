B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'DateUtils - Version 1.05
Sub Process_Globals
	Type Period (Years As Int, Months As Int, _
		Days As Int, Hours As Int, Minutes As Int, Seconds As Int)
	Private daysList, monthsList As List
	Private ad, bc As String
End Sub

'Returns the month name of the given date.
'Similar To DateTime.GetMonth which returns the month as an integer.
Public Sub GetMonthName(Ticks As Long) As String
	Dim df As String = DateTime.DateFormat
	DateTime.DateFormat = "MMMM"
	Dim res As String = DateTime.Date(Ticks)
	DateTime.DateFormat = df
	Return res
End Sub

'Returns the day of week name.
'Similar to DateTime.GetDayOfWeek which returns the day of week as an integer.
Public Sub GetDayOfWeekName(Ticks As Long) As String
	Dim df As String = DateTime.DateFormat
	DateTime.DateFormat = "EEEE"
	Dim res As String = DateTime.Date(Ticks)
	DateTime.DateFormat = df
	Return res
End Sub

'Returns a list with the week days names, using the device set locale.
Public Sub GetDaysNames As List
	If daysList.IsInitialized Then Return daysList
	daysList.Initialize
	Dim df As String = DateTime.DateFormat
	DateTime.DateFormat = "EEEE"
	Dim t As Long = DateTime.Now
	t = DateTime.Add(t, 0, 0, - (DateTime.GetDayOfWeek(t) - 1))
	For i = 1 To 7
		daysList.Add(DateTime.Date(t))
		t = DateTime.Add(t, 0, 0, 1)
	Next
	DateTime.DateFormat = df
	Return daysList
End Sub

'Returns a list with the months names, using the device set locale.
Public Sub GetMonthsNames As List
	If monthsList.IsInitialized Then Return monthsList
	monthsList.Initialize
	Dim df As String = DateTime.DateFormat
	DateTime.DateFormat = "MMMM"
	Dim t As Long = DateTime.Now
	t = DateTime.Add(t, 0,- (DateTime.GetMonth(t) - 1), 0)
	For i = 1 To 12
		monthsList.Add(DateTime.Date(t))
		t = DateTime.Add(t, 0, 1, 0)
	Next
	DateTime.DateFormat = df
	Return monthsList
End Sub

'Calculates the period between two date instances. 
'This method returns a Period type with years, months, days, hours, minutes, seconds.
Public Sub PeriodBetween(Start As Long, EndTime As Long) As Period
	Return PeriodBetweenHelper(Start, EndTime, False)
End Sub

'Calculates the period between two date instances.
'This method returns a Period type with days, hours, minutes, seconds
Public Sub PeriodBetweenInDays (Start As Long, EndTime As Long) As Period
	Return PeriodBetweenHelper(Start, EndTime, True)
End Sub	

Private Sub PeriodBetweenHelper(Start As Long, EndTime As Long, StartWithDays As Boolean) As Period
	Dim td As Period
	td.Initialize
	Dim sy = DateTime.GetYear(Start), ey = DateTime.GetYear(EndTime) As Int
	Dim daysOffset As Int
	If EndTime > Start Then
		If Not(StartWithDays) Then
			'years
			If DateTime.Add(Start, ey - sy, 0, 0) > EndTime Then td.Years = ey - sy - 1 Else td.Years = ey - sy
			Dim ticks As Long = DateTime.Add(Start, td.Years, 0, 0)
			'months
			For i = 1 To 13
				If DateTime.Add(ticks, 0, i, 0) > EndTime Then
					td.Months = i - 1
					Exit
				End If
			Next
			ticks = DateTime.Add(ticks, 0, td.Months, 0)
		Else
			daysOffset = (EndTime - Start) / DateTime.TicksPerDay - 3
			Dim ticks As Long = Start
		End If
		'days
		For i = daysOffset + 1 To daysOffset + 32
			If DateTime.Add(ticks, 0, 0, i) > EndTime Then
				td.Days = i - 1
				Exit
			End If
		Next
		ticks = DateTime.Add(ticks, 0, 0, td.Days)
		Dim diff As Long = EndTime - ticks
		td.Hours = diff / DateTime.TicksPerHour
		td.Minutes = (diff Mod DateTime.TicksPerHour) / DateTime.TicksPerMinute
		td.Seconds = (diff Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
		Return td
	Else 'EndTime is before Start
		If Not(StartWithDays) Then
			'years
			If DateTime.Add(Start, ey - sy, 0, 0) < EndTime Then td.Years = ey - sy + 1 Else td.Years = ey - sy
			Dim ticks As Long = DateTime.Add(Start, td.Years, 0, 0)
			'months
			For i = -1 To -13 Step -1
				If DateTime.Add(ticks, 0, i, 0) < EndTime Then
					td.Months = i + 1
					Exit
				End If
			Next
			ticks = DateTime.Add(ticks, 0, td.Months, 0)
		Else
			daysOffset = (EndTime - Start) / DateTime.TicksPerDay + 3
			Dim ticks As Long = Start
		End If
		'days
		For i = daysOffset - 1 To daysOffset - 32 Step -1
			If DateTime.Add(ticks, 0, 0, i) < EndTime Then
				td.Days = i + 1
				Exit
			End If
		Next
		ticks = DateTime.Add(ticks, 0, 0, td.Days)
		Dim diff As Long = ticks - EndTime
		td.Hours = -diff / DateTime.TicksPerHour
		td.Minutes = -(diff Mod DateTime.TicksPerHour) / DateTime.TicksPerMinute
		td.Seconds = -(diff Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
		Return td
	End If
End Sub

Private Sub GetEra(Negative As Boolean) As String
	Dim df As String = DateTime.DateFormat
	If Negative Then
		If bc <> "" Then Return bc
		DateTime.DateFormat = "GG"
		bc = DateTime.Date(-137628808000000)
		DateTime.DateFormat = df
		Return bc
	Else
		If ad <> "" Then Return ad
		DateTime.DateFormat = "GG"
		ad = DateTime.Date(0)
		DateTime.DateFormat = df
		Return ad
	End If
End Sub
'Returns the ticks value of the given date (the time will be 00:00:00).
Public Sub SetDate(Years As Int, Months As Int, Days As Int) As Long
	Return SetDateAndTime(Years, Months, Days, 0, 0, 0)
End Sub
'Returns the ticks value of the given date and time
Public Sub SetDateAndTime(Years As Int, Months As Int, Days As Int, Hours As Int, Minutes As Int, Seconds As Int) As Long
	Dim df = DateTime.DateFormat, tf = DateTime.TimeFormat As String
	DateTime.DateFormat = "GGyyyyMMdd"
	DateTime.TimeFormat = "HHmmss"
	Dim d As String = Format(Abs(Years), 4) & Format(Months, 2) & Format(Days, 2)
	d = GetEra(Years < 0) & d
	Dim t As String = Format(Hours, 2) & Format(Minutes, 2) & Format(Seconds, 2)
	Try
		Dim ticks As Long = DateTime.DateTimeParse(d, t)
	Catch
		DateTime.DateFormat = df
		DateTime.TimeFormat = tf
		Log("Error: Invalid value: " & d & " " & t)
		Return "invalid date" + 1 'hack to throw an error
	End Try
	DateTime.DateFormat = df
	DateTime.TimeFormat = tf
	Return ticks
End Sub

'Returns the ticks value of the given date and time with the specified time zone offset.
'The last parameter is the time zone offset measured in hours.
Public Sub SetDateAndTime2(Years As Int, Months As Int, Days As Int, Hours As Int, Minutes As Int, Seconds As Int, _
		TimeZone As Double) As Long
	Dim df As String = DateTime.DateFormat
	DateTime.DateFormat = "GGyyyyMMddHHmmssz"
	Dim d As String = Format(Abs(Years), 4) & Format(Months, 2) & Format(Days, 2)
	d = GetEra(Years < 0) & d
	Dim tzMinutes As Int = Abs(TimeZone * 60)
	Dim tzHours As Int = tzMinutes / 60
	Dim tzSign As String
	If TimeZone >= 0 Then tzSign = "+" Else tzSign = "-"
	d = d & Format(Hours, 2) & Format(Minutes, 2) & Format(Seconds, 2) & _
		"GMT" & tzSign & Format(tzHours, 2) & ":" & Format(tzMinutes Mod 60, 2)
	Try
		Dim ticks As Long = DateTime.DateParse(d)
	Catch
		DateTime.DateFormat = df
		Log("Error: Invalid value: " & d)
		Return "invalid date" + 1 'hack to throw an error
	End Try
	DateTime.DateFormat = df
	Return ticks
End Sub

Private Sub Format(Value As Int, Length As Int) As String
	Return NumberFormat2(Value, Length, 0, 0, False)
End Sub

'Returns the number of days in the given month
Public Sub NumberOfDaysInMonth(Month As Int, Year As Int) As Int
	Dim Ticks As Long = SetDate(Year, Month, 1)
	Dim nextMonth As Long = DateTime.Add(Ticks, 0, 1, 0)
	Dim res As Int =  Round((nextMonth - Ticks) / DateTime.TicksPerDay)
	Return res
End Sub

'Adds a Period to the given date instance. Do not forget to assign the result.
Public Sub AddPeriod(Ticks As Long, Per As Period) As Long
	Ticks = DateTime.Add(Ticks, Per.Years, Per.Months, Per.Days)
	Ticks = Ticks + Per.Hours * DateTime.TicksPerHour + Per.Minutes * DateTime.TicksPerMinute + _
		Per.Seconds * DateTime.TicksPerSecond
	Return Ticks
End Sub

Public Sub TicksToString(Ticks As Long) As String
	Return DateTime.Date(Ticks) & " " & DateTime.Time(Ticks)
End Sub

'Tests whether the two ticks values represent the same day.
Public Sub IsSameDay(Ticks1 As Long, Ticks2 As Long) As Boolean
	Return DateTime.GetYear(Ticks1) = DateTime.GetYear(Ticks2) And DateTime.GetMonth(Ticks1) = DateTime.GetMonth(Ticks2) _
		And DateTime.GetDayOfMonth(Ticks1) = DateTime.GetDayOfMonth(Ticks2)
End Sub

'Converts ticks value to unix time.
Public Sub TicksToUnixTime(Ticks As Long) As Long
	Return Ticks / DateTime.TicksPerSecond
End Sub	

'Converts unix time to ticks value.
Public Sub UnixTimeToTicks(UnixTime As Long) As Long
	Return UnixTime * DateTime.TicksPerSecond
End Sub

