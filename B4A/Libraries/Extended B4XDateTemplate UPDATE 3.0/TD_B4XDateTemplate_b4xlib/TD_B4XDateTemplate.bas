B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'## Basic Code from lmB4XDateTemplate
'## (C) LucaMS https://www.b4x.com/android/forum/threads/b4x-lmb4xdatetemplate.164207/#content
'## Added functionality and modfication
'## (C) TechDoc G. Becker
'## Attached Time Pane to layout
'## Attached Properties setMarker, getMarker, getTime, setTime, hideTime
'## Attached Marker storage as KeyValue Store
'## Attached Week number pane
'## Set Weekend textcolor diffrent from workdays textcolor

#region custom events
#Event: EnabledDays(Year As Int, Month As Int) As Int
#end region

Sub Class_Globals
	Public HighlightedColor As Int = 0xFF001BBD
	Public SelectedColor As Int = 0xFF0BA29B
	Public DaysInMonthColor As Int = xui.Color_White
	Public DaysInWeekColor As Int = xui.Color_Gray
	Public FirstDay As Int = 0
	Public MinYear = 1970, MaxYear = 2030 As Int
	Public btnYearLeft As B4XView
	Public btnYearRight As B4XView
	Public CloseOnSelection As Boolean = True
	Public DaysOfWeekNames As List
	Public xpmYear As B4XPlusMinus
	Public EnabledDayColor As Int
	Public RoundedEnabledDays As Boolean = True

	Private xui As XUI
	Private month, year As Int
	Private boxW, boxH As Float
	Private vCorrection As Float
	Private tempSelectedDay As Int
	Private dayOfWeekOffset As Int
	Private daysInMonth As Int
	Private DaysPaneBg As B4XView
	Private DaysPaneFg As B4XView
	Private cvs As B4XCanvas
	Private cvsBackground As B4XCanvas
	Private selectedDate As Long
	Private PreviousSelectedDate As Long
	Private selectedYear, selectedMonth, selectedDay As Int
	Private cvsDays As B4XCanvas
	Private DaysTitlesPane As B4XView
	Private pnlDialog As B4XView
	Private MonthsNames As List
	Private mDialog As B4XDialog
	Private mCallback As Object
	Private mEventName As String
	Private mlstEnabledDays As List
	Private mAllDaysClickable As Boolean
	Private xpmMonth As B4XPlusMinus
	
	
	Public kvs As KeyValueStore
	Private selectedTime As Long
	Private hour, minute, second As Int
	Private UTCdiff As Long
	
	Private pmHour As B4XPlusMinus
	Private pmMinute As B4XPlusMinus
	Private pmSecond As B4XPlusMinus
	Private cbam As CheckBox
	Private cbpm As CheckBox
	Private cbUTC As CheckBox
	
	Private TimePane As B4XView
	Public daysInWeekendCol As Int = 0xFFFF8C00
End Sub

Public Sub Initialize(CallBack As Object, EventName As String)
	mCallback = CallBack
	mEventName = EventName

	pnlDialog = xui.CreatePanel("")
	pnlDialog.SetLayoutAnimated(0, 0, 0, 320dip,50%y)
	pnlDialog.LoadLayout("DateTemplate2")
	pnlDialog.Tag = Me
	month = DateTime.GetMonth(DateTime.Now)
	year = DateTime.GetYear(DateTime.Now)
	MonthsNames = DateUtils.GetMonthsNames
	xpmMonth.SetStringItems(MonthsNames)
	selectedDate = DateTime.Now
	setDate(selectedDate)
	cvs.Initialize(DaysPaneFg)
	cvsBackground.Initialize(DaysPaneBg)
	boxW = cvs.TargetRect.Width / 7
	boxH = cvs.TargetRect.Height / 6
	vCorrection = 5dip
	cvsDays.Initialize(DaysTitlesPane)
	#if B4J
	Dim p As Pane = DaysPaneFg
	Private fx As JFX
	p.MouseCursor = fx.Cursors.HAND
	#End If
	DaysOfWeekNames.Initialize
	DaysOfWeekNames.AddAll(DateUtils.GetDaysNames)
	
	EnabledDayColor = xui.Color_Magenta
	
	mlstEnabledDays.Initialize
	
	xpmYear.Formatter.GetDefaultFormat.GroupingCharacter = ""
	xpmYear.SetNumericRange(MinYear, MaxYear, 1)
	xpmYear.SelectedValue = year
	SetDarkTheme
	
	PeriodChanged
	
	'## TechDoc added Functionality
	xui.SetDataFolder("kvs")
	kvs.Initialize(xui.DefaultFolder, "TD_DateTimekvs.dat")
	
	selectedTime = DateTime.now
	hour = DateTime.GetHour(selectedTime)
	minute = DateTime.GetMinute(selectedTime)
	second=DateTime.Getsecond(selectedTime)
	pmHour.SetNumericRange(0,23,1)
	pmMinute.SetNumericRange(0,59,1)
	pmSecond.SetNumericRange(0,59,1)
	pmHour.SelectedValue = hour
	pmMinute.SelectedValue = minute
	pmSecond.SelectedValue= second
	cbam.checked = False: cbpm.checked=False
	UTCdiff = DateTime.TimeZoneOffset
	cbUTC.Checked = True
End Sub

#Region PROPERTIES 

'It determines whether all days should be clickable or only the "enabled" (highlighted) ones.
'By default it is False.
Public Sub setAllDaysClickable(Clickable As Boolean)
	mAllDaysClickable = Clickable
End Sub
Public Sub getAllDaysClickable As Boolean
	Return mAllDaysClickable
End Sub

Public Sub setMonthNames(lstMonthNames As List)
	MonthsNames = lstMonthNames
	xpmMonth.SetStringItems(MonthsNames)
End Sub
Public Sub getMonthNames As List
	Return MonthsNames
End Sub

#End Region

#Region PUBLIC METHODS 

'Gets or sets the selected date
Public Sub getDate As Long
	Return selectedDate
End Sub

Public Sub setDate(date As Long)
	'The layout is not loaded immediately so we need to make sure that the layout was loaded.
	If xpmYear.IsInitialized = False Then
		selectedDate = date
		Return 'the date will be set after the layout is loaded
	End If
	year = DateTime.GetYear(date)
	month = DateTime.GetMonth(date)
	SelectDay(DateTime.GetDayOfMonth(date))
	xpmYear.SelectedValue = year
	xpmMonth.SelectedValue = MonthsNames.Get(month - 1)
End Sub

Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return pnlDialog
End Sub

Public Sub SetMinAndMaxYear(YearMin As Int, YearMax As Int)
	MinYear = YearMin
	MaxYear = YearMax
	xpmYear.SetNumericRange(MinYear, MaxYear, 1)
End Sub

Public Sub SetYear(pYear As Int)
	xpmYear.SelectedValue = year
End Sub

'## Function:	Mark a Date and set a note
'## Parameter:	Date and note text
'## Notice:		Dateformat MM/dd/yyyy
'## (C):		added/modified by TecDoc
'## Tested:		2025/04
public Sub setMarker(Date As String, Text As String)
	kvs.Put(DateTime.dateparse(Date),"GBETest")
End Sub

'## Function:	get the applied marker text
'## Parameter:	Marked Date
'## Notice:		Dateformat MM/dd/yyyy
'## (C):		added/modified by TecDoc
'## Tested:		2025/04
public Sub getMarker(Date As String) As String
	Dim d As Long = DateTime.DateParse(Date)
	If kvs.ContainsKey(d) Then
		Return kvs.Get(d)
	Else
		Return ""
	End If
End Sub

'## Function:	 get  selected time
'## Notice:		If ampm or UTC is selected a or p or UTC is added
'## (C):		added/modified by TecDoc
'## Tested:		2025/04
public Sub getTime As String
	Dim t As String = _
		NumberFormat(pmHour.SelectedValue,2,0) & ":" & _
		NumberFormat(pmMinute.SelectedValue,2,0) & ":" & _
		NumberFormat(pmSecond.SelectedValue,2,0)
	
	If cbam.Checked Then
		t = t & " a"
	else If cbpm.Checked Then
		t = t & " p"
	End If
	If cbUTC.Checked Then
		t = t  & " UTC"
	Else
		t = t  & " LOC"
	End If
	
	Return t
End Sub

'## Function:	set time value
'## Parameter:
'##				Now Time is now all others are 0 or "" or false
'##				valHour, valMin, ValSec Time values
'##				AMPM a or p if ampm is used
'##				UTC true if time is utc (causes AMPM to false)
'## Notice:		Timeformat hh:MM:ss or HH:mm:ss
'## (C):		added/modified by TecDoc
'## Tested:		2025/04
public Sub setTime(Now As Boolean,valHour As Int,valMin As Int, valSec As Int, AMPM As String, UTC As Boolean)
	Try
		If Now Then
			pmHour.SelectedValue = DateTime.GetHour(DateTime.Now)
			pmMinute.SelectedValue  = DateTime.Getminute(DateTime.Now)
			pmSecond.SelectedValue  = DateTime.Getsecond(DateTime.Now)
			cbam.Checked=False : cbpm.checked=False : cbUTC.checked = True
		Else
			If AMPM.ToLowerCase = "a" And valHour >=1 And valHour <=12 Then
				cbam.Checked=True
				UTC=False
				pmHour.SetNumericRange(1,12,1)
			else If AMPM.ToLowerCase = "p" And valHour >=1 And valHour <=12 Then
				cbpm.Checked=True
				UTC=False
				pmHour.SetNumericRange(1,12,1)
			Else
				pmHour.SetNumericRange(9,23,1)
			End If
			pmHour.SelectedValue = valHour
			pmMinute.SelectedValue = valMin
			pmSecond.SelectedValue = valSec
			cbUTC.Checked = UTC
		End If
	Catch
		Log(LastException)
	End Try
End Sub

'## Function:	hide/show time pane
'## (C):		added/modified by TecDoc
'## Tested:		2025/04
public Sub hideTime(showTime As Boolean)
	TimePane.Visible=showTime	
End Sub

'"Unfortunately" I couldn't use the following lines inside this class.
'Click on "Copy" and then paste.
'Replace "Dialog" with the name of your dialog, "mDateTempl" with the name of your variable,
'and the colors, If you want.
'<code>
'	mDlg.TitleBarColor = 0xFFFF7505
'	mDlg.TitleBarHeight = 80dip
'	mDlg.BackgroundColor = xui.Color_White
'	mDlg.ButtonsColor = xui.Color_White
'	mDlg.ButtonsTextColor = mDlg.TitleBarColor
'	mDlg.BorderColor = xui.Color_Transparent
'	mDateTempl.SetLightTheme
'</code>
Public Sub SetLightTheme
	Dim TextColor As Int = 0xFF5B5B5B
	DaysInWeekColor = xui.Color_Blue
	HighlightedColor = 0xFF00CEFF
	DaysInMonthColor = TextColor
	SelectedColor = 0xFFFFA761

	Dim xpm_Year_Base As B4XView = xpmYear.mBase
	Dim xpm_Year_lblMinus As B4XView = xpmYear.lblMinus
	Dim xpm_Year_lblPlus As B4XView = xpmYear.lblPlus
	Dim xpm_Year_MainLabel As B4XView = xpmYear.MainLabel

	Dim xpm_Month_Base As B4XView = xpmMonth.mBase
	Dim xpm_Month_lblMinus As B4XView = xpmMonth.lblMinus
	Dim xpm_Month_lblPlus As B4XView = xpmMonth.lblPlus
	Dim xpm_Month_MainLabel As B4XView = xpmMonth.MainLabel

	xpm_Year_Base.SetColorAndBorder(xpm_Year_Base.Color, 0, 0, 0)
	xpm_Month_Base.SetColorAndBorder(xpm_Month_Base.Color, 0, 0, 0)
	For Each xView As B4XView In Array(xpm_Year_lblMinus, xpm_Year_lblPlus, xpm_Month_lblMinus, xpm_Month_lblPlus)
		xView.SetColorAndBorder(xui.Color_Transparent, 1dip, xui.Color_Gray, 3dip)
		xView.TextColor = xui.Color_Black
		xView.TextSize = xpmYear.MainLabel.TextSize
	Next

	xpm_Year_MainLabel.TextColor = TextColor
	xpm_Month_MainLabel.TextColor = TextColor
End Sub

Public Sub SetDarkTheme
	Dim TextColor As Int = xui.Color_White
	DaysInWeekColor = xui.Color_Yellow
	HighlightedColor = 0xFF00CEFF
	DaysInMonthColor = TextColor
	SelectedColor = 0xFF0BA29B

	Dim xpm_Year_Base As B4XView = xpmYear.mBase
	Dim xpm_Year_lblMinus As B4XView = xpmYear.lblMinus
	Dim xpm_Year_lblPlus As B4XView = xpmYear.lblPlus
	Dim xpm_Year_MainLabel As B4XView = xpmYear.MainLabel

	Dim xpm_Month_Base As B4XView = xpmMonth.mBase
	Dim xpm_Month_lblMinus As B4XView = xpmMonth.lblMinus
	Dim xpm_Month_lblPlus As B4XView = xpmMonth.lblPlus
	Dim xpm_Month_MainLabel As B4XView = xpmMonth.MainLabel

	xpm_Year_Base.SetColorAndBorder(xpm_Year_Base.Color, 0, 0, 0)
	xpm_Month_Base.SetColorAndBorder(xpm_Month_Base.Color, 0, 0, 0)
	For Each xView As B4XView In Array(xpm_Year_lblMinus, xpm_Year_lblPlus, xpm_Month_lblMinus, xpm_Month_lblPlus)
		xView.SetColorAndBorder(0xFF587478, 1dip, xui.Color_LightGray, 3dip)
		xView.TextColor = xui.Color_White
		xView.TextSize = xpmYear.MainLabel.TextSize
	Next
	
	xpm_Year_MainLabel.TextColor = xui.Color_White
	xpm_Month_MainLabel.TextColor = xui.Color_White
End Sub

#End Region

#Region PRIVATE METHODS 
'## (C):		added/modified by TecDoc
Private Sub DrawDays
	xpmYear.SelectedValue = year
	cvs.ClearRect(cvs.TargetRect)
	cvsBackground.ClearRect(cvsBackground.TargetRect)
	Dim firstDayOfMonth As Long = DateUtils.setDate(year, month, 1) - 1
	dayOfWeekOffset = (7 + DateTime.GetDayOfWeek(firstDayOfMonth) - FirstDay) Mod 7
	daysInMonth = DateUtils.NumberOfDaysInMonth(month, year)
	If year = selectedYear And month = selectedMonth Then
		'draw the selected box
		DrawBox(cvs, SelectedColor, (selectedDay - 1 + dayOfWeekOffset) Mod 7, _
			(selectedDay - 1 + dayOfWeekOffset) / 7)
	End If
	
	'Draw boxes for enabled days.
	If mlstEnabledDays.Size > 0 Then
		For day = 1 To daysInMonth
			If mlstEnabledDays.IndexOf(day) <> - 1 Then
				If RoundedEnabledDays Then
					DrawCircle(cvs, EnabledDayColor, (day - 1 + dayOfWeekOffset) Mod 7, _
					(day - 1 + dayOfWeekOffset) / 7)
				Else
					DrawBox(cvs, EnabledDayColor, (day - 1 + dayOfWeekOffset) Mod 7, _
					(day - 1 + dayOfWeekOffset) / 7)
				End If
			End If
		Next
	End If
	
	Dim daysFont As B4XFont = xui.CreateDefaultBoldFont(14)
	For day = 1 To daysInMonth
		Dim lm As List = DateUtils.GetMonthsNames
		Dim d As String = NumberFormat(lm.IndexOf(xpmMonth.SelectedValue)+1,2,0)
		d = d & "/" & NumberFormat(day,2,0) & "/" & xpmYear.SelectedValue
		Dim d1 As  Int = DateTime.GetDayOfWeek(DateTime.DateParse(d))
		Dim col As Int = DaysInMonthColor
		If d1 = 1 Or d1 = 7 Then col = daysInWeekendCol
		Dim row As Int = (day - 1 + dayOfWeekOffset) / 7
		cvs.DrawText(day, (((dayOfWeekOffset + day - 1) Mod 7) + 0.5) * boxW, _
			(row + 0.5)* boxH + vCorrection, daysFont, col , "CENTER")
	Next
	cvsBackground.Invalidate
	cvs.Invalidate
End Sub

Private Sub DrawBox(c As B4XCanvas, clr As Int, x As Int, y As Int)
	Dim r As B4XRect
	r.Initialize(x * boxW, y * boxH, x * boxW + boxW,  y * boxH + boxH)
	c.DrawRect(r, clr, True, 1dip)
End Sub

Private Sub DrawCircle(c As B4XCanvas, clr As Int, x As Int, y As Int)
	Dim cx As Float = x * boxW + boxW / 2
	Dim cy As Float = y * boxH + boxH / 2
	Dim radius As Float = boxW / 2 * .75
	c.DrawCircle(cx, cy, radius, clr, True, 1dip)
End Sub

Private Sub SelectDay(day As Int)
	selectedDate = DateUtils.setDate(year, month, day)
	selectedDay = day
	selectedMonth = month
	selectedYear = year
End Sub

'## (C):		added/modified by TecDoc
Private Sub HandleMouse(x As Double, y As Double, move As Boolean)
	Dim boxX = x / boxW, boxY =  y / boxH As Int
	Dim newSelectedDay As Int = boxY * 7 + boxX + 1 - dayOfWeekOffset

	Dim validDay As Boolean
	Dim validDay As Boolean = newSelectedDay > 0 And newSelectedDay <= daysInMonth
	
	'If mlstEnabledDays.Size > 0 Then
	'	validDay = validDay And (mlstEnabledDays.IndexOf(newSelectedDay) <> - 1)
	'End If

	If move Then
		If newSelectedDay = tempSelectedDay _
		Or mlstEnabledDays.Size > 0 Then 
			'Return
		End If
		cvsBackground.ClearRect(cvsBackground.TargetRect)
		tempSelectedDay = newSelectedDay
		If validDay Then
			DrawBox(cvsBackground, HighlightedColor, boxX, boxY)
		End If
	Else
		cvsBackground.ClearRect(cvsBackground.TargetRect)
		If validDay Or mAllDaysClickable Then
			SelectDay(newSelectedDay)
			If CloseOnSelection Then
				Hide
			Else
				DrawDays
			End If
		End If
	End If
	
	cvsBackground.Invalidate
End Sub

Private Sub Hide
	mDialog.Close(xui.DialogResponse_Positive)
End Sub

'## (C):		added/modified by TecDoc
Private Sub Show (Dialog As B4XDialog)
	Dim days As List = DaysOfWeekNames
	Dim daysFont As B4XFont = xui.CreateDefaultBoldFont(14)
	cvsDays.ClearRect(cvsDays.TargetRect)
	
	Dim lm As List = DateUtils.GetMonthsNames
	Dim m As Int = lm.IndexOf(xpmMonth.SelectedValue) + 1
	
	For i = FirstDay To FirstDay + 7 - 1
		Dim d As String = days.Get(i Mod 7)
		Dim col As Int = DaysInWeekColor
		If 	i =0 Or i = 6 Then col = daysInWeekendCol
		If d.Length > 2 Then d = d.SubString2(0, 2)
		cvsDays.DrawText(d, (i - FirstDay + 0.5) * boxW, 20dip, daysFont, col, "CENTER")
	Next
	cvsDays.Invalidate
	mDialog = Dialog
	DrawDays
	PreviousSelectedDate = selectedDate
	Sleep(0)
End Sub

Private Sub DialogClosed(Result As Int) 'ignore
	If Result <> xui.DialogResponse_Positive Then
		setDate(PreviousSelectedDate)
	End If
End Sub

Private Sub PeriodChanged
	Dim FullSubName As String = mEventName & "_EnabledDays"
	If xui.SubExists(mCallback, FullSubName, 0) Then
		mlstEnabledDays = CallSub3(mCallback, FullSubName, year, month)
	End If
End Sub

'## Function:	get only time
'## Return:		DialogResponse_Negative
'## (C):		added/modified by TecDoc
'## Tested:		2025/04
Private Sub btTime_Click
	mDialog.Close(xui.DialogResponse_Negative)
End Sub
#End Region

#Region VIEWS' EVENTS 

Private Sub xpmMonth_ValueChanged (Value As Object)
	month = MonthsNames.IndexOf(Value) + 1
	PeriodChanged
	DrawDays
End Sub

Private Sub DaysPaneFg_Touch (Action As Int, X As Float, Y As Float)
	Dim p As B4XView = DaysPaneFg
	HandleMouse(X, Y, Action <> p.TOUCH_ACTION_UP)
End Sub

Private Sub xpmYear_ValueChanged (Value As Object)
	year = Value
	PeriodChanged
	DrawDays
End Sub

Private Sub cbam_CheckedChange(Checked As Boolean)
	If Checked Then cbpm.Checked=False
End Sub

Private Sub cbpm_CheckedChange(Checked As Boolean)
	If Checked Then cbam.Checked=False
End Sub
#End Region
