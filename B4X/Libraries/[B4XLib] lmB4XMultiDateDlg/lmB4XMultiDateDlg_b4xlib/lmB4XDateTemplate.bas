B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
#Event: EnabledDays(Year As Int, Month As Int) As Int

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
End Sub

Public Sub Initialize(CallBack As Object, EventName As String)
	mCallback = CallBack
	mEventName = EventName

	pnlDialog = xui.CreatePanel("")
	pnlDialog.SetLayoutAnimated(0, 0, 0, 320dip,300dip)
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
		Dim row As Int = (day - 1 + dayOfWeekOffset) / 7
		cvs.DrawText(day, (((dayOfWeekOffset + day - 1) Mod 7) + 0.5) * boxW, _
			(row + 0.5)* boxH + vCorrection, daysFont, DaysInMonthColor , "CENTER")
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

Private Sub HandleMouse(x As Double, y As Double, move As Boolean)
	Dim boxX = x / boxW, boxY =  y / boxH As Int
	Dim newSelectedDay As Int = boxY * 7 + boxX + 1 - dayOfWeekOffset

	Dim validDay As Boolean
	Dim validDay As Boolean = newSelectedDay > 0 And newSelectedDay <= daysInMonth
	If mlstEnabledDays.Size > 0 Then
		validDay = validDay And (mlstEnabledDays.IndexOf(newSelectedDay) <> - 1)
	End If

	If move Then
		If newSelectedDay = tempSelectedDay _
		Or mlstEnabledDays.Size > 0 Then 
			Return
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

Private Sub Show (Dialog As B4XDialog)
	Dim days As List = DaysOfWeekNames
	Dim daysFont As B4XFont = xui.CreateDefaultBoldFont(14)
	cvsDays.ClearRect(cvsDays.TargetRect)
	For i = FirstDay To FirstDay + 7 - 1
		Dim d As String = days.Get(i Mod 7)
		If d.Length > 2 Then d = d.SubString2(0, 2)
		cvsDays.DrawText(d, (i - FirstDay + 0.5) * boxW, 20dip, daysFont, DaysInWeekColor, "CENTER")
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

#End Region
