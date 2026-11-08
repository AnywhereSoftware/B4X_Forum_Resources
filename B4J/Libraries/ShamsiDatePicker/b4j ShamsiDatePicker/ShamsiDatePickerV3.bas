B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'with arena AI
'Class module: ShamsiDatePicker
private Sub Class_Globals
	Private fx As JFX
	Private frm As Form
	Private MainPane As Pane

	Private CurrentYear, CurrentMonth As Int
	Private SelectedYear, SelectedMonth, SelectedDay As Int
	Private TodayYear, TodayMonth, TodayDay As Int

	Public ResultYear, ResultMonth, ResultDay As Int
	Public IsConfirmed As Boolean
	Public UsePersianDigits As Boolean = False

	Private MonthNames() As String
	Private DayNames() As String
	Private FullDayNames() As String

	Private CELL_SIZE As Int = 36
	Private FORM_WIDTH As Int = 290
	Private FORM_HEIGHT As Int = 335

	Private FNT As String = "-fx-font-family: Tahoma; -fx-font-size: 12;"

	Private DayLabels As List
	Private FirstDow As Int
	Private lblMonthYear As Label
End Sub

Public Sub Initialize
	MonthNames = Array As String("فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", _
	                             "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند")
	DayNames = Array As String("ش", "ی", "د", "س", "چ", "پ", "ج")
	FullDayNames = Array As String("شنبه", "یکشنبه", "دوشنبه", "سه‌شنبه", "چهارشنبه", "پنجشنبه", "جمعه")

	DayLabels.Initialize
	ConvertTodayToShamsi

	CurrentYear = TodayYear
	CurrentMonth = TodayMonth
	SelectedYear = TodayYear
	SelectedMonth = TodayMonth
	SelectedDay = TodayDay
	IsConfirmed = False
End Sub

'==================== نمایش مودال ====================

'نمایش در وسط فرم والد
Public Sub Show(owner As Form) As Boolean
	Return ShowAt(owner, Null)
End Sub

'نمایش زیر نودی که کلیک شده (دکمه / تکست‌فیلد و ...) و محدود به فرم والد
Public Sub ShowAt(owner As Form, anchor As Node) As Boolean
	IsConfirmed = False

	frm.Initialize("frm", FORM_WIDTH, FORM_HEIGHT)
	frm.Resizable = False
	If owner.IsInitialized Then frm.SetOwner(owner)

	MainPane = frm.RootPane
	MainPane.Style = "-fx-background-color: #FFFFFF;"

	DrawCalendar
	PositionForm(owner, anchor)

	frm.ShowAndWait
	Return IsConfirmed
End Sub

'محاسبه محل باز شدن فرم

Private Sub PositionForm(owner As Form, anchor As Node)
	Dim x, y As Double
	Dim hasOwner As Boolean = owner.IsInitialized
	Dim placed As Boolean = False

	'--- 1) تلاش برای قرار گرفتن زیر نود کلیک شده ---
	If anchor <> Null Then
		If anchor.IsInitialized Then
			Try
				Dim jo As JavaObject = anchor
				Dim b As JavaObject = jo.RunMethodJO("getBoundsInLocal", Null)
				Dim nw As Double = b.RunMethod("getWidth", Null)
				Dim nh As Double = b.RunMethod("getHeight", Null)

				Dim pt As JavaObject = jo.RunMethodJO("localToScreen", Array(0.0, nh))
				Dim sx As Double = pt.RunMethod("getX", Null)
				Dim sy As Double = pt.RunMethod("getY", Null)

				x = sx + nw - FORM_WIDTH
				y = sy + 2
				placed = True
			Catch
				placed = False
			End Try
		End If
	End If

	'--- 2) در غیر این صورت وسط فرم والد ---
	If placed = False Then
		If hasOwner Then
			x = owner.WindowLeft + (owner.WindowWidth - FORM_WIDTH) / 2
			y = owner.WindowTop + (owner.WindowHeight - FORM_HEIGHT) / 2
		Else
			Dim scrBounds() As Double = GetScreenBounds
			x = scrBounds(0) + (scrBounds(2) - FORM_WIDTH) / 2
			y = scrBounds(1) + (scrBounds(3) - FORM_HEIGHT) / 2
		End If
	End If

	'--- 3) محدود کردن داخل فرم والد ---
	If hasOwner Then
		Dim oL As Double = owner.WindowLeft
		Dim oT As Double = owner.WindowTop
		Dim oW As Double = owner.WindowWidth
		Dim oH As Double = owner.WindowHeight

		If oW >= FORM_WIDTH Then
			If x < oL Then x = oL
			If x + FORM_WIDTH > oL + oW Then x = oL + oW - FORM_WIDTH
		Else
			x = oL + (oW - FORM_WIDTH) / 2
		End If

		If oH >= FORM_HEIGHT Then
			If y < oT Then y = oT
			If y + FORM_HEIGHT > oT + oH Then y = oT + oH - FORM_HEIGHT
		Else
			y = oT + (oH - FORM_HEIGHT) / 2
		End If
	End If

	'--- 4) محدود کردن داخل صفحه نمایش ---
	Dim scr() As Double = GetScreenBounds
	Dim sL As Double = scr(0)
	Dim sT As Double = scr(1)
	Dim sW As Double = scr(2)
	Dim sH As Double = scr(3)

	If x < sL Then x = sL
	If y < sT Then y = sT
	If x + FORM_WIDTH > sL + sW Then x = sL + sW - FORM_WIDTH
	If y + FORM_HEIGHT > sT + sH Then y = sL + sH - FORM_HEIGHT

	frm.WindowLeft = x
	frm.WindowTop = y
End Sub

'دریافت ابعاد صفحه نمایش اصلی -> Array(minX, minY, width, height)
Private Sub GetScreenBounds As Double()
	Dim jo As JavaObject
	jo.InitializeStatic("javafx.stage.Screen")
	Dim primary As JavaObject = jo.RunMethod("getPrimary", Null)
	Dim bounds As JavaObject = primary.RunMethod("getVisualBounds", Null)

	Dim minX As Double = bounds.RunMethod("getMinX", Null)
	Dim minY As Double = bounds.RunMethod("getMinY", Null)
	Dim w As Double = bounds.RunMethod("getWidth", Null)
	Dim h As Double = bounds.RunMethod("getHeight", Null)

	Return Array As Double(minX, minY, w, h)
End Sub


'==================== رسم تقویم ====================
Private Sub DrawCalendar
	MainPane.RemoveAllNodes
	DayLabels.Clear

	Dim startX As Int = (FORM_WIDTH - (7 * CELL_SIZE)) / 2

	'----- نوار ناوبری -----
	'  چیدمان :   [ماه ❮][سال ❮❮]   عنوان   [سال ❯❯][ماه ❯]
	'  بیرونی‌ها = ماه        داخلی‌ها = سال
	Dim navPane As Pane
	navPane.Initialize("")
	navPane.Style = "-fx-background-color: #2196F3;"
	MainPane.AddNode(navPane, 0, 0, FORM_WIDTH, 38)

	'--- سمت راست ---
	Dim btnMonthNext As Button          'بیرونی راست  =  ماه
	btnMonthNext.Initialize("btnMonthNext")
	btnMonthNext.Text = "❯"
	btnMonthNext.Style = $"-fx-background-color: transparent; -fx-text-fill: white; ${FNT} -fx-cursor: hand;"$
	navPane.AddNode(btnMonthNext, FORM_WIDTH - 40, 2, 34, 34)

	Dim btnYearNext As Button           'داخلی راست  =  سال
	btnYearNext.Initialize("btnYearNext")
	btnYearNext.Text = "❯❯"
	btnYearNext.Style = $"-fx-background-color: transparent; -fx-text-fill: white; ${FNT} -fx-cursor: hand;"$
	navPane.AddNode(btnYearNext, FORM_WIDTH - 76, 2, 36, 34)

	'--- سمت چپ ---
	Dim btnMonthPrev As Button          'بیرونی چپ  =  ماه
	btnMonthPrev.Initialize("btnMonthPrev")
	btnMonthPrev.Text = "❮"
	btnMonthPrev.Style = $"-fx-background-color: transparent; -fx-text-fill: white; ${FNT} -fx-cursor: hand;"$
	navPane.AddNode(btnMonthPrev, 6, 2, 34, 34)

	Dim btnYearPrev As Button           'داخلی چپ  =  سال
	btnYearPrev.Initialize("btnYearPrev")
	btnYearPrev.Text = "❮❮"
	btnYearPrev.Style = $"-fx-background-color: transparent; -fx-text-fill: white; ${FNT} -fx-cursor: hand;"$
	navPane.AddNode(btnYearPrev, 40, 2, 36, 34)

	lblMonthYear.Initialize("")
	lblMonthYear.Alignment = "CENTER"
	lblMonthYear.Style = $"-fx-text-fill: white; -fx-font-weight: bold; ${FNT}"$
	navPane.AddNode(lblMonthYear, 78, 2, FORM_WIDTH - 156, 34)

	Dim yPos As Int = 42

	'----- نام روزهای هفته (راست به چپ) -----
	For i = 0 To 6
		Dim lblDN As Label
		lblDN.Initialize("")
		lblDN.Text = DayNames(i)
		lblDN.Alignment = "CENTER"
		Dim c As String = "#555555"
		If i = 6 Then c = "#E53935"
		lblDN.Style = $"-fx-text-fill: ${c}; -fx-font-weight: bold; ${FNT}"$
		MainPane.AddNode(lblDN, startX + ((6 - i) * CELL_SIZE), yPos, CELL_SIZE, 22)
	Next
	yPos = yPos + 23

	Dim sep As Pane
	sep.Initialize("")
	sep.Style = "-fx-background-color: #E0E0E0;"
	MainPane.AddNode(sep, startX, yPos, 7 * CELL_SIZE, 1)
	yPos = yPos + 4

	'----- روزهای ماه -----
	Dim daysInMonth As Int = GetDaysInMonth(CurrentYear, CurrentMonth)
	FirstDow = GetFirstDayOfWeek(CurrentYear, CurrentMonth)

	Dim row As Int = 0
	Dim col As Int = FirstDow

	For day = 1 To daysInMonth
		Dim lbl As Label
		lbl.Initialize("dayLabel")
		lbl.Text = FormatNum(day)
		lbl.Alignment = "CENTER"
		lbl.Tag = day
		MainPane.AddNode(lbl, startX + ((6 - col) * CELL_SIZE), yPos + (row * CELL_SIZE), CELL_SIZE, CELL_SIZE)
		DayLabels.Add(lbl)

		col = col + 1
		If col > 6 Then
			col = 0
			row = row + 1
		End If
	Next

	'----- دکمه‌های پایین -----
	Dim btnY As Int = FORM_HEIGHT - 40

	Dim sep2 As Pane
	sep2.Initialize("")
	sep2.Style = "-fx-background-color: #E0E0E0;"
	MainPane.AddNode(sep2, 0, btnY - 7, FORM_WIDTH, 1)

	Dim btnConfirm As Button
	btnConfirm.Initialize("btnConfirm")
	btnConfirm.Text = "تایید"
	btnConfirm.Style = $"-fx-background-color: #1976D2; -fx-text-fill: white; ${FNT} -fx-background-radius: 4; -fx-cursor: hand;"$
	MainPane.AddNode(btnConfirm, FORM_WIDTH - 90, btnY, 78, 30)

	Dim btnToday As Button
	btnToday.Initialize("btnToday")
	btnToday.Text = "امروز"
	btnToday.Style = $"-fx-background-color: #FF5722; -fx-text-fill: white; ${FNT} -fx-background-radius: 4; -fx-cursor: hand;"$
	MainPane.AddNode(btnToday, 12, btnY, 78, 30)

	RefreshStyles
End Sub

'رفرش استایل بدون حذف نودها (لازم برای کارکرد دابل‌کلیک)
Private Sub RefreshStyles
	lblMonthYear.Text = MonthNames(CurrentMonth - 1) & "  " & FormatNum(CurrentYear)
	frm.Title = FormatNum(SelectedYear) & "/" & FormatNum2(SelectedMonth) & "/" & FormatNum2(SelectedDay) & _
	            "   -   " & GetDayOfWeekName(SelectedYear, SelectedMonth, SelectedDay)

	For Each lbl As Label In DayLabels
		Dim day As Int = lbl.Tag
		Dim col As Int = (FirstDow + day - 1) Mod 7

		Dim isToday As Boolean = (day = TodayDay And CurrentMonth = TodayMonth And CurrentYear = TodayYear)
		Dim isSel   As Boolean = (day = SelectedDay And CurrentMonth = SelectedMonth And CurrentYear = SelectedYear)
		Dim isFri   As Boolean = (col = 6)

		Dim s As String = $"${FNT} -fx-cursor: hand; -fx-background-radius: ${CELL_SIZE / 2};"$

		If isSel And isToday Then
			s = s & $" -fx-background-color: #1976D2; -fx-text-fill: white; -fx-font-weight: bold; -fx-border-color: #FF5722; -fx-border-width: 2; -fx-border-radius: ${CELL_SIZE / 2};"$
		Else If isSel Then
			s = s & " -fx-background-color: #1976D2; -fx-text-fill: white; -fx-font-weight: bold;"
		Else If isToday Then
			s = s & $" -fx-border-color: #FF5722; -fx-border-width: 2; -fx-border-radius: ${CELL_SIZE / 2}; -fx-text-fill: #FF5722; -fx-font-weight: bold;"$
		Else If isFri Then
			s = s & " -fx-text-fill: #E53935;"
		Else
			s = s & " -fx-text-fill: #333333;"
		End If

		lbl.Style = s
	Next
End Sub

'==================== رویدادها ====================
private Sub dayLabel_MouseClicked (EventData As MouseEvent)
	Dim lbl As Label
	lbl = Sender

	If lbl.Tag <> Null Then
		Dim day As Int = lbl.Tag

		SelectedYear = CurrentYear
		SelectedMonth = CurrentMonth
		SelectedDay = day

		If EventData.ClickCount >= 2 Then     'دابل کلیک = تایید
			ConfirmAndClose
			Return
		End If

		RefreshStyles
	End If
End Sub

'--- ماه (دکمه‌های بیرونی) ---
Private Sub btnMonthNext_Action
	CurrentMonth = CurrentMonth + 1
	If CurrentMonth > 12 Then
		CurrentMonth = 1
		CurrentYear = CurrentYear + 1
	End If
	AdjustSelectedDay
	DrawCalendar
End Sub

Private Sub btnMonthPrev_Action
	CurrentMonth = CurrentMonth - 1
	If CurrentMonth < 1 Then
		CurrentMonth = 12
		CurrentYear = CurrentYear - 1
	End If
	AdjustSelectedDay
	DrawCalendar
End Sub

'--- سال (دکمه‌های داخلی) ---
Private Sub btnYearNext_Action
	CurrentYear = CurrentYear + 1
	AdjustSelectedDay
	DrawCalendar
End Sub

Private Sub btnYearPrev_Action
	CurrentYear = CurrentYear - 1
	AdjustSelectedDay
	DrawCalendar
End Sub

Private Sub btnToday_Action
	CurrentYear = TodayYear
	CurrentMonth = TodayMonth
	SelectedYear = TodayYear
	SelectedMonth = TodayMonth
	SelectedDay = TodayDay
	DrawCalendar
End Sub

Private Sub btnConfirm_Action
	ConfirmAndClose
End Sub

Private Sub ConfirmAndClose
	ResultYear = SelectedYear
	ResultMonth = SelectedMonth
	ResultDay = SelectedDay
	IsConfirmed = True
	frm.Close
End Sub

Private Sub frm_CloseRequest (EventData As Event)
	If IsConfirmed = False Then
		ResultYear = 0
		ResultMonth = 0
		ResultDay = 0
	End If
End Sub

Private Sub AdjustSelectedDay
	If SelectedYear = CurrentYear And SelectedMonth = CurrentMonth Then
		Dim maxDay As Int = GetDaysInMonth(CurrentYear, CurrentMonth)
		If SelectedDay > maxDay Then SelectedDay = maxDay
	End If
End Sub

'==================== خروجی‌ها ====================

Public Sub GetSelectedDateString As String
	Return ResultYear & "/" & NumberFormat2(ResultMonth, 2, 0, 0, False) & "/" & NumberFormat2(ResultDay, 2, 0, 0, False)
End Sub

'Tick با ساعتِ فعلی سیستم
Public Sub GetSelectedTicks As Long
	Dim n As Long = DateTime.Now
	Return ShamsiToTicksWithTime(ResultYear, ResultMonth, ResultDay, _
		DateTime.GetHour(n), DateTime.GetMinute(n), DateTime.GetSecond(n))
End Sub

'Tick با ساعت 00:00:00
Public Sub GetSelectedTicksNoTime As Long
	Return ShamsiToTicksWithTime(ResultYear, ResultMonth, ResultDay, 0, 0, 0)
End Sub

Public Sub GetSelectedTicksWithTime(hour As Int, minute As Int, second As Int) As Long
	Return ShamsiToTicksWithTime(ResultYear, ResultMonth, ResultDay, hour, minute, second)
End Sub

Public Sub ShamsiToTicks(jy As Int, jm As Int, jd As Int) As Long
	Dim n As Long = DateTime.Now
	Return ShamsiToTicksWithTime(jy, jm, jd, DateTime.GetHour(n), DateTime.GetMinute(n), DateTime.GetSecond(n))
End Sub

Public Sub ShamsiToTicksWithTime(jy As Int, jm As Int, jd As Int, hour As Int, minute As Int, second As Int) As Long
	Dim g() As Int = ShamsiToGregorian(jy, jm, jd)

	Dim pd As String = DateTime.DateFormat
	Dim pt As String = DateTime.TimeFormat
	DateTime.DateFormat = "yyyy/MM/dd"
	DateTime.TimeFormat = "HH:mm:ss"

	Dim ds As String = g(0) & "/" & NumberFormat2(g(1), 2, 0, 0, False) & "/" & NumberFormat2(g(2), 2, 0, 0, False)
	Dim ts As String = NumberFormat2(hour, 2, 0, 0, False) & ":" & NumberFormat2(minute, 2, 0, 0, False) & ":" & NumberFormat2(second, 2, 0, 0, False)

	Dim ticks As Long = DateTime.DateTimeParse(ds, ts)

	DateTime.DateFormat = pd
	DateTime.TimeFormat = pt
	Return ticks
End Sub

Public Sub TicksToShamsi(ticks As Long) As Int()
	Return GregorianToShamsi(DateTime.GetYear(ticks), DateTime.GetMonth(ticks), DateTime.GetDayOfMonth(ticks))
End Sub

Public Sub TicksToShamsiString(ticks As Long) As String
	Dim j() As Int = TicksToShamsi(ticks)
	Return j(0) & "/" & NumberFormat2(j(1), 2, 0, 0, False) & "/" & NumberFormat2(j(2), 2, 0, 0, False)
End Sub

Public Sub SetDate(year As Int, month As Int, day As Int)
	SelectedYear = year
	SelectedMonth = month
	SelectedDay = day
	CurrentYear = year
	CurrentMonth = month
End Sub

Public Sub SetDateFromTicks(ticks As Long)
	Dim j() As Int = TicksToShamsi(ticks)
	SetDate(j(0), j(1), j(2))
End Sub

'==================== تبدیل تاریخ ====================

Private Sub ConvertTodayToShamsi
	Dim n As Long = DateTime.Now
	Dim r() As Int = GregorianToShamsi(DateTime.GetYear(n), DateTime.GetMonth(n), DateTime.GetDayOfMonth(n))
	TodayYear = r(0)
	TodayMonth = r(1)
	TodayDay = r(2)
End Sub

Public Sub GregorianToShamsi(gy As Int, gm As Int, gd As Int) As Int()
	Dim g_d_m() As Int = Array As Int(0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334)
	Dim jy As Int
	If gy > 1600 Then
		jy = 979
		gy = gy - 1600
	Else
		jy = 0
		gy = gy - 621
	End If

	Dim gy2 As Int = gy
	If gm > 2 Then gy2 = gy + 1

	Dim days As Long = (365 * gy) + IDiv(gy2 + 3, 4) - IDiv(gy2 + 99, 100) + IDiv(gy2 + 399, 400) - 80 + gd + g_d_m(gm - 1)

	jy = jy + 33 * IDiv(days, 12053)
	days = days Mod 12053

	jy = jy + 4 * IDiv(days, 1461)
	days = days Mod 1461

	If days > 365 Then
		jy = jy + IDiv(days - 1, 365)
		days = (days - 1) Mod 365
	End If

	Dim jm, jd As Int
	If days < 186 Then
		jm = 1 + IDiv(days, 31)
		jd = 1 + (days Mod 31)
	Else
		jm = 7 + IDiv(days - 186, 30)
		jd = 1 + ((days - 186) Mod 30)
	End If

	Return Array As Int(jy, jm, jd)
End Sub

Public Sub ShamsiToGregorian(jy As Int, jm As Int, jd As Int) As Int()
	Dim gy As Int
	If jy > 979 Then
		gy = 1600
		jy = jy - 979
	Else
		gy = 621
	End If

	Dim mDays As Int
	If jm < 7 Then
		mDays = (jm - 1) * 31
	Else
		mDays = ((jm - 7) * 30) + 186
	End If

	Dim days As Long = (365 * jy) + (IDiv(jy, 33) * 8) + IDiv((jy Mod 33) + 3, 4) + 78 + jd + mDays

	gy = gy + 400 * IDiv(days, 146097)
	days = days Mod 146097

	If days > 36524 Then
		days = days - 1
		gy = gy + 100 * IDiv(days, 36524)
		days = days Mod 36524
		If days >= 365 Then days = days + 1
	End If

	gy = gy + 4 * IDiv(days, 1461)
	days = days Mod 1461

	If days > 365 Then
		gy = gy + IDiv(days - 1, 365)
		days = (days - 1) Mod 365
	End If

	Dim leap As Int = 0
	If (gy Mod 4 = 0 And gy Mod 100 <> 0) Or (gy Mod 400 = 0) Then leap = 1
	Dim md() As Int = Array As Int(31, 28 + leap, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

	Dim gd As Int = days + 1
	Dim gm As Int = 0
	Do While gm < 12 And gd > md(gm)
		gd = gd - md(gm)
		gm = gm + 1
	Loop

	Return Array As Int(gy, gm + 1, gd)
End Sub

Private Sub GetFirstDayOfWeek(jy As Int, jm As Int) As Int
	Return GetShamsiDayOfWeek(jy, jm, 1)
End Sub

'0=شنبه ... 6=جمعه   (با JDN - مستقل از Locale سیستم)
Public Sub GetShamsiDayOfWeek(jy As Int, jm As Int, jd As Int) As Int
	Dim g() As Int = ShamsiToGregorian(jy, jm, jd)
	Dim a As Int = IDiv(14 - g(1), 12)
	Dim y As Long = g(0) + 4800 - a
	Dim m As Int = g(1) + (12 * a) - 3
	Dim jdn As Long = g(2) + IDiv((153 * m) + 2, 5) + (365 * y) + IDiv(y, 4) - IDiv(y, 100) + IDiv(y, 400) - 32045
	Return ((jdn Mod 7) + 2) Mod 7
End Sub

Public Sub GetDayOfWeekName(jy As Int, jm As Int, jd As Int) As String
	Return FullDayNames(GetShamsiDayOfWeek(jy, jm, jd))
End Sub

Public Sub GetDaysInMonth(jy As Int, jm As Int) As Int
	If jm <= 6 Then Return 31
	If jm <= 11 Then Return 30
	If IsLeapShamsi(jy) Then Return 30
	Return 29
End Sub

Public Sub IsLeapShamsi(jy As Int) As Boolean
	Dim r As Int = jy Mod 33
	Dim leaps() As Int = Array As Int(1, 5, 9, 13, 17, 22, 26, 30)
	For Each l As Int In leaps
		If r = l Then Return True
	Next
	Return False
End Sub

'==================== ابزار ====================

Private Sub IDiv(a As Long, b As Long) As Long
	Return Floor(a / b)
End Sub

Private Sub FormatNum(n As Int) As String
	If UsePersianDigits Then Return ToPersianDigits(n)
	Return n
End Sub

Private Sub FormatNum2(n As Int) As String
	Dim s As String = NumberFormat2(n, 2, 0, 0, False)
	If UsePersianDigits Then Return ToPersianDigits(s)
	Return s
End Sub

Public Sub ToPersianDigits(input As String) As String
	Dim en() As String = Array As String("0","1","2","3","4","5","6","7","8","9")
	Dim fa() As String = Array As String("۰","۱","۲","۳","۴","۵","۶","۷","۸","۹")
	Dim s As String = input
	For i = 0 To 9
		s = s.Replace(en(i), fa(i))
	Next
	Return s
End Sub