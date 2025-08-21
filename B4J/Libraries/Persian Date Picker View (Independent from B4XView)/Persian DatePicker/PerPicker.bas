B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' PERSIAN DATE PICKER VIEW
'
' WRITTEN BY: MOSTAFA HODAEE
'
' NOTE: This piece of code can be used freely by anyone!
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'#7F7362

'NOTE: "DOW" stands for "Day of Week" and is from 1 to 7 (Saturday to Friday)

'Static code module
Sub Process_Globals
	Private fx As JFX
	
	'The origin (earliest date) of this picker is 1395/1/1 Solar Hijri Shamsi (Persian calendar)
	'And that day is a Sunday.
	Private FarvardinFirst1395_DOW As Int = 2
	
	Private TopPane As Pane
	Private months, years As ChoiceBox
	Private DayDate(42) As Label
	
	Public ChosenDay, ChosenMonth, ChosenYear As Int
	Public ChosenDate As String
	Public TodayShamsiDate As String
End Sub


'Display the date picker at the specified coordinates in the pane. Returns the date chosen as a string.
'Parameters:
'Display coordinates of the calendar:
'       x: the left edge if "LeftToRight" is "true", otherwise the right edge.
'       y: the top edge if "TopDown" is "true", otherwise the bottom edge.
'(year/month): The default date the calendar should open to.

Sub ShowPicker(ParentPane As Pane, x As Int, y As Int, year As Int, month As Int, TopDown As Boolean, LeftToRight As Boolean) As ResumableSub

	'Make sure it's not opened repeatedly. It waits for one to close first.
	If TopPane.IsInitialized = True And TopPane.Tag = "open" Then Return ""

	TopPane.Initialize("TopPane")
	TopPane.Tag = "open"
	TopPane.Style = "-fx-background-color:#FFFFFF;-fx-border-color:#000000;-fx-border-radius:5.00;-fx-background-radius:5.00;-fx-border-width:2.00;"
	
	TodayShamsiDate = MiladiToShamsi(DateTime.GetYear(DateTime.Now), DateTime.GetMonth(DateTime.Now), DateTime.GetDayOfMonth(DateTime.Now))

	Dim h As Int
	If GetMonthBeginDOW(month, year) + MonthDays(month, year) <= 36 Then
		TopPane.SetSize(230, 250)
		h = 250
	Else
		TopPane.SetSize(230, 280)
		h = 280
	End If
	
	months.Initialize("CBOX_Months")
	months.SetSize(100, 30)
	years.Initialize("CBOX_Years")
	years.SetSize(73, 30)
	
	months.Items.AddAll(Array As String("فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند"))
	For i = 1395 To 1420
		years.Items.Add(i)
	Next
	months.SelectedIndex = month - 1
	years.SelectedIndex = year - 1395
	years.Style = "-fx-font-size:15.00;fx-font-weight:bold;-fx-base:#FFE9C5;-fx-border-color:#000000;-fx-border-width:0.00;"
	months.Style = "-fx-font-size:15.00;fx-font-weight:bold;-fx-base:#FFE9C5;-fx-border-color:#000000;-fx-border-width:0.00;"
	TopPane.AddNode(years, 46, 10, 73, 30)
	TopPane.AddNode(months, 122, 10, 100, 30)
	
	Dim close As Button
	close.Initialize("BTN_Close")
	close.SetSize(30, 30)
	close.text = "X"
	close.Style = "-fx-base:#FF4242;-fx-border-color:#000000;-fx-border-width:0.00;"
	TopPane.AddNode(close, 10, 10, 30, 30)
	
	Dim daypane As Pane
	daypane.Initialize("")
	daypane.SetSize(210, 30)
	daypane.Style = "-fx-background-color:#D7D5D5;-fx-border-color:#000000;-fx-border-radius:3.00;-fx-background-radius:3.00;-fx-border-width:1.00;"
	TopPane.AddNode(daypane, 10, 53, 210, 30)
	
	Dim day_names(7) As String = Array As String("ش", "ی", "د", "س", "چ", "پ", "ج")
	For i = 0 To 6
		Dim dow As Label
		dow.Initialize("")
		dow.SetSize(30, 30)
		dow.Alignment = "CENTER"
		dow.Text = day_names(i)
		dow.Font = fx.CreateFont("Arial", 15, True, False)
		TopPane.AddNode(dow, 190 - (i * 30), 50, 30, 30)
	Next
	
	'Create arrays for day date labels and coordinates within the pane
	Dim daydate_x(42), daydate_y(42) As Int
	For i = 0 To 41
		daydate_x(i) = 190 - ((i Mod 7) * 30)
		Dim d As Int = i / 7
		daydate_y(i) = 90 + (d * 30)
		DayDate(i).Initialize("Day")
		DayDate(i).SetSize(30, 30)
		DayDate(i).Alignment = "CENTER"
		TopPane.AddNode(DayDate(i), daydate_x(i), daydate_y(i), 30, 30)
		DayDate(i).Font = fx.CreateFont("Arial", 15, True, False)
		DayDate(i).Visible = False
	Next
	'Now start from the first day of the month and go all the way
	For i = GetMonthBeginDOW(month, year) To (GetMonthBeginDOW(month, year) + MonthDays(month, year) - 1)
		DayDate(i-1).Text = i - GetMonthBeginDOW(month, year) + 1
		DayDate(i-1).Tag = i - GetMonthBeginDOW(month, year) + 1
		If IsToday(DayDate(i-1).Tag) Then
			DayDate(i-1).Style = "-fx-border-color:#000000;-fx-border-radius:0.00;-fx-border-width:2.00;"
		Else
			DayDate(i-1).Style = "-fx-border-color:#FFFFFF;-fx-border-radius:0.00;-fx-border-width:0.00;"
		End If
		DayDate(i-1).Visible = True
	Next
	
	Dim nodeX, nodeY As Int
	nodeX = x
	nodeY = y
	If TopDown = False Then nodeY = y - h
	If LeftToRight = False Then nodeX = x - 230
	
	TopPane.Enabled = True
	TopPane.Visible = True
	TopPane.Alpha = 0
	ParentPane.AddNode(TopPane, nodeX, nodeY, 230, h)
	TopPane.SetAlphaAnimated(300, 1)
	
	Wait For ReturnDate
	Return ChosenDate
End Sub

'Called when the chosen month/year changes
Sub RebuildDays
	If months.SelectedIndex < 0 Or years.SelectedIndex < 0 Then Return

	Dim month, year As Int
	month = months.SelectedIndex + 1
	year = years.SelectedIndex + 1395
	If GetMonthBeginDOW(month, year) + MonthDays(month, year) <= 36 Then
		TopPane.SetSize(230, 250)
	Else
		TopPane.SetSize(230, 280)
	End If
	
	For i = 0 To 41
		DayDate(i).Visible = False
	Next
	'Now start from the first day of the month and go all the way
	For i = GetMonthBeginDOW(month, year) To (GetMonthBeginDOW(month, year) + MonthDays(month, year) - 1)
		DayDate(i-1).Text = i - GetMonthBeginDOW(month, year) + 1
		DayDate(i-1).Tag = i - GetMonthBeginDOW(month, year) + 1
		If IsToday(DayDate(i-1).Tag) Then
			DayDate(i-1).Style = "-fx-border-color:#000000;-fx-border-radius:0.00;-fx-border-width:2.00;"
		Else
			DayDate(i-1).Style = "-fx-border-color:#FFFFFF;-fx-border-radius:0.00;-fx-border-width:0.00;"
		End If
		DayDate(i-1).Visible = True
	Next
End Sub

'On which day of the week does this month begin?
Sub GetMonthBeginDOW(month As Int, year As Int) As Int	
	If year < 1395 Then Return -1
	
	Dim add_yeardays As Int = 0
	If year > 1395 Then
		For i = 1395 To year - 1
			add_yeardays = add_yeardays + 365
			If IsPersianLeapYear(i) Then add_yeardays = add_yeardays + 1
		Next
	End If
	
	Dim add_monthdays As Int = 0
	If month > 1 Then
		For i = 1 To month - 1
			add_monthdays = add_monthdays + 30
			If i < 7 Then add_monthdays = add_monthdays + 1
		Next
	End If
	
	Dim result As Int = FarvardinFirst1395_DOW + ((add_yeardays + add_monthdays) Mod 7)
	If result > 7 Then result = result - 7
	Return result
End Sub

Sub IsPersianLeapYear(year As Int) As Boolean	

	Dim days() As Int
	days = Array As Int(1, 5, 9, 13, 17, 22, 26, 30)
	For i = 0 To days.Length - 1
		If (year Mod 33) = days(i) Then Return True
	Next
	Return False
End Sub

'How many days in that month?
Sub MonthDays(month As Int, year As Int) As Int
	
	If month < 7 Then Return 31
	If month < 12 Then Return 30
	If IsPersianLeapYear(year) = True Then Return 30
	Return 29
End Sub

Sub CBOX_Months_SelectedIndexChanged(Index As Int, Value As Object)
	If Index < 0 Then Return
	RebuildDays
End Sub

Sub CBOX_Years_SelectedIndexChanged(Index As Int, Value As Object)
	If Index < 0 Then Return
	RebuildDays
End Sub

Sub BTN_Close_Click
	TopPane.SetAlphaAnimated(300, 0)
End Sub

Sub TopPane_AnimationCompleted
	If TopPane.Alpha > 0.5 Then Return
	TopPane.RemoveNodeFromParent
	TopPane.Visible = False
	TopPane.Enabled = False
	TopPane.Tag = "closed"
End Sub

Sub Day_MouseClicked (EventData As MouseEvent)
	Dim lb As Label = Sender
	ChosenDay = lb.Tag
	ChosenMonth = months.SelectedIndex + 1
	ChosenYear = years.SelectedIndex + 1395
	ChosenDate = ChosenYear & "/" & ChosenMonth & "/" & ChosenDay
	
	CallSubDelayed(Me, "ReturnDate")
	BTN_Close_Click
End Sub

Sub IsLeapYear(year As Int) As Boolean
	If year Mod 400 = 0 Then Return True
	If year Mod 100 = 0 Then Return False
	If year Mod 4 = 0 Then Return True
	Return False
End Sub

'Convert Gregorian date to Hijri Shamsi (Persian) date
Sub MiladiToShamsi(Year As Int, Month As Int, Day As Int) As String
	
	Dim count_days(12) As Int
	count_days = Array As Int(31,28,31,30,31,30,31,31,30,31,30,31)
	Dim i As Int
	Dim day_year As Int
	Dim newMonth, newYear, newDay As Int
	
	day_year = 0
	For i = 1 To Month - 1
		day_year = day_year + count_days(i-1)
	Next
	day_year = day_year + Day
	
	If IsLeapYear(Year) And Month > 2 Then day_year = day_year + 1
	If day_year <= 79 Then
		If (Year - 1) Mod 4 = 0 Then
			day_year = day_year + 11
		Else
			day_year = day_year + 10
		End If
		newYear = Year - 622
		If day_year Mod 30 = 0 Then
			newMonth = (day_year / 30) + 9
			newDay = 30
		Else
			newMonth = (day_year / 30) + 10
			newDay = day_year Mod 30
		End If
	Else
		newYear = Year - 621
		day_year = day_year - 79
		If day_year <= 186 Then
			If day_year Mod 31 = 0 Then
				newMonth = day_year / 31
				newDay = 31
			Else
				newMonth = (day_year / 31) + 1
				newDay = day_year Mod 31
			End If
		Else
			day_year = day_year - 186
			If day_year Mod 30 = 0 Then
				newMonth = (day_year / 30) + 6
				newDay = 30
			Else
				newMonth = (day_year / 30) + 7
				newDay = day_year Mod 30
			End If
		End If
	End If
	
	'Return the result
	Return newYear & "/" & newMonth & "/" & newDay
End Sub

Sub IsToday(day As Int) As Boolean
	Dim chosen_date As String = (years.SelectedIndex + 1395) & "/" & (months.SelectedIndex + 1) & "/" & day
	If chosen_date = TodayShamsiDate Then Return True
	Return False
End Sub

Sub Day_MouseEntered (EventData As MouseEvent)
	Dim lb As Label = Sender
	If IsToday(lb.Tag) Then
		lb.Style = "-fx-border-color:#000000;-fx-border-radius:0.00;-fx-border-width:2.00;-fx-background-color:#FFE9C5;"
	Else
		lb.Style = "-fx-border-color:#FFFFFF;-fx-border-radius:0.00;-fx-border-width:0.00;-fx-background-color:#FFE9C5;"
	End If
End Sub

Sub Day_MouseExited (EventData As MouseEvent)
	Dim lb As Label = Sender
	If IsToday(lb.Tag) Then
		lb.Style = "-fx-border-color:#000000;-fx-border-radius:0.00;-fx-border-width:2.00;-fx-background-color:#FFFFFF;"
	Else
		lb.Style = "-fx-border-color:#FFFFFF;-fx-border-radius:0.00;-fx-border-width:0.00;-fx-background-color:#FFFFFF;"
	End If
End Sub
