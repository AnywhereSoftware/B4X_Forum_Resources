Type=Class
Version=5.9
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
'xAnotherDatePicker v1.00
#Event: DateChanged (NewDate As Long)
#DesignerProperty: Key: MinYear, DisplayName: Minimum Year, FieldType: Int, DefaultValue: 1970, MinRange: 0, MaxRange: 3000
#DesignerProperty: Key: MaxYear, DisplayName: Maximum Year, FieldType: Int, DefaultValue: 2030, MinRange: 0, MaxRange: 3000
#DesignerProperty: Key: FirstDay, DisplayName: First Day, FieldType: String, DefaultValue: Sunday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday, Description: Sets the first day of week.
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: #FFCFDCDC
#DesignerProperty: Key: SelectedColor, DisplayName: Selected Color, FieldType: Color, DefaultValue: 0xFF0BA29B
#DesignerProperty: Key: HighlightedColor, DisplayName: Highlighted Color, FieldType: Color, DefaultValue: 0xFFABFFFB
Sub Class_Globals
	Private xui As XUI
	Private EventName As String
	Private CallBack As Object
	
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
	Private selectedYear, selectedMonth, selectedDay As Int
	Private tempSelectedColor As Int
	Private selectedColor As Int
	Private cvsDays As B4XCanvas
	Private DaysTitlesPane As B4XView
	Private dateField As B4XView
	Private btnOpen As B4XView
	Private btnToday As B4XView
	Private btnCancel As B4XView
	Private minYear, maxYear, firstDay As Int
	Private btnMonthLeft As B4XView
	Private btnMonthRight As B4XView
	Private btnYearLeft As B4XView
	Private btnYearRight As B4XView
	Private lblMonth As B4XView
	Private lblYear As B4XView
	Private pnlDialog As B4XView
	Private MainPanel As B4XView
	Private mBase As B4XView
	Private months As List
	Private visible As Boolean
End Sub

Public Sub Initialize (vCallback As Object, vEventName As String)
	EventName = vEventName
	CallBack = vCallback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Dim mlbl As B4XView = Lbl
#if B4J
	Dim form As Form = Props.Get("Form")
	MainPanel = form.RootPane
	Dim df As TextField
	df.Initialize("DateField")
	Dim b As Button
	b.Initialize("btnOpen")
	Dim fx As JFX
	b.Font = fx.CreateFontAwesome(30)
#else if B4A
	MainPanel = Props.Get("activity")
	Dim df As EditText
	df.Initialize("DateField")
	df.SingleLine = True
	Dim b As Button
	b.Initialize("btnOpen")
	b.Typeface = Typeface.FONTAWESOME
#else if B4i
	MainPanel = Props.Get("page")
	Dim df As TextField
	df.Initialize("DateField")
	Dim b As Button
	b.Initialize("btnOpen", b.STYLE_SYSTEM)
	b.CustomLabel.Font = Font.CreateFontAwesome(30)
#end if
	btnOpen = b
	dateField = df
	dateField.Font = mlbl.Font
	dateField.Color = xui.Color_White
	dateField.TextColor = mlbl.TextColor
	mBase.AddView(dateField, 0,0,0,0)
	btnOpen.Text = Chr(0xF073)
	mBase.AddView(btnOpen, 0,0,0,0)
	'It is not possible to load a layout file directly from DesignerCreateView.
	Sleep(0)
	pnlDialog = xui.CreatePanel("")
	MainPanel.AddView(pnlDialog, 0, 0, 320dip,300dip)
	pnlDialog.LoadLayout("DatePicker")
	pnlDialog.Visible = False
	pnlDialog.SetColorAndBorder(xui.PaintOrColorToColor(Props.Get("BackgroundColor")), 1dip, xui.Color_Black, 10dip)
	pnlDialog.Tag = Me
	selectedColor = xui.PaintOrColorToColor(Props.Get("SelectedColor"))
	tempSelectedColor = xui.PaintOrColorToColor(Props.Get("HighlightedColor"))
	month = DateTime.GetMonth(DateTime.Now)
	year = DateTime.GetYear(DateTime.Now)
	minYear = Props.Get("MinYear")
	maxYear = Props.Get("MaxYear")
	months = DateUtils.GetMonthsNames
	If selectedDate = 0 Then selectedDate = DateTime.Now
	setDate(selectedDate)
	cvs.Initialize(DaysPaneFg)
	cvsBackground.Initialize(DaysPaneBg)
	boxW = cvs.TargetRect.Width / 7
	boxH = cvs.TargetRect.Height / 6
	vCorrection = 5dip
	If xui.IsB4i Then vCorrection = 9dip
	cvsDays.Initialize(DaysTitlesPane)
	Dim alldays As List = Regex.Split("\|", "Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday") 'need to escape the splitting character.
	firstDay = alldays.IndexOf(Props.Get("FirstDay"))
	Dim daysFont As B4XFont = xui.CreateDefaultBoldFont(14)
	Dim i As Int
	Dim days As List = DateUtils.GetDaysNames
	For i = firstDay To firstDay + 7 - 1
		Dim d As String = days.Get(i Mod 7)
		cvsDays.DrawText(d.SubString2(0, 2), (i - firstDay + 0.5) * boxW, 20dip, daysFont, xui.Color_Gray, "CENTER")
	Next
	cvsDays.Invalidate
	#if B4J
	Dim p As Pane = DaysPaneFg
	p.MouseCursor = fx.Cursors.HAND
	#End If
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	dateField.SetLayoutAnimated(0, 0, 0, Width - Height, Height)
	btnOpen.SetLayoutAnimated(0, Max(0, Width - Height), 0, Height, Height)
End Sub

#if B4J
Private Sub BtnOpen_Action
#else
Private Sub BtnOpen_Click
#end if
	Show
End Sub

Private Sub DateField_TextChanged (Old As String, New As String)
	Dim ticks As Long = GetCurrentDateFromTextField (New)
	If ticks > 0 Then
		setDate(ticks)
		dateField.SetColorAndBorder(dateField.Color, 2dip, 0xFFA1A1A1, 0)
		CallSub2(CallBack, EventName & "_DateChanged", ticks)
	Else
		dateField.SetColorAndBorder(dateField.Color, 2dip, xui.Color_Red, 0)
	End If
End Sub

Private Sub GetCurrentDateFromTextField (DateString As String) As Long
	Try
		Dim ticks As Long = DateTime.DateParse(DateString)
		If DateTime.GetYear(ticks) >= minYear And DateTime.GetYear(ticks) <= maxYear Then
			Return ticks
		End If
	Catch
		'invalid date
	End Try 'ignore
	Return 0
End Sub



Private Sub DrawDays
	
	lblMonth.Text = months.Get(month - 1)
	lblYear.Text = year
	btnYearLeft.Enabled = year > minYear
	btnYearRight.Enabled = year < maxYear
	cvs.ClearRect(cvs.TargetRect)
	cvsBackground.ClearRect(cvsBackground.TargetRect)
	Dim firstDayOfMonth As Long = DateUtils.setDate(year, month, 1) - 1
	dayOfWeekOffset = (7 + DateTime.GetDayOfWeek(firstDayOfMonth) - firstDay) Mod 7
	daysInMonth = DateUtils.NumberOfDaysInMonth(month, year)
	If year = selectedYear And month = selectedMonth Then
		'draw the selected box
		DrawBox(cvs, selectedColor, (selectedDay - 1 + dayOfWeekOffset) Mod 7, _
			(selectedDay - 1 + dayOfWeekOffset) / 7)
	End If
	Dim daysFont As B4XFont = xui.CreateDefaultBoldFont(14)
	For day = 1 To daysInMonth
		Dim row As Int = (day - 1 + dayOfWeekOffset) / 7
		cvs.DrawText(day, (((dayOfWeekOffset + day - 1) Mod 7) + 0.5) * boxW, _
			(row + 0.5)* boxH + vCorrection, daysFont, xui.Color_Black, "CENTER")
	Next
	cvsBackground.Invalidate
	cvs.Invalidate
End Sub

Private Sub DrawBox(c As B4XCanvas, clr As Int, x As Int, y As Int)
	Dim r As B4XRect
	r.Initialize(x * boxW, y * boxH, x * boxW + boxW,  y * boxH + boxH)
	c.DrawRect(r, clr, True, 1dip)
End Sub

'Gets or sets the selected date
Public Sub getDate As Long
	Return selectedDate
End Sub

Public Sub setDate(date As Long)
	'The layout is not loaded immediately so we need to make sure that the layout was loaded.
	If lblYear.IsInitialized = False Then
		selectedDate = date
		Return 'the date will be set after the layout is loaded
	End If
	year = DateTime.GetYear(date)
	month = DateTime.GetMonth(date)
	SelectDay(DateTime.GetDayOfMonth(date))
	lblYear.Text = year
	lblMonth.Text = months.Get(month - 1)
End Sub

Private Sub SelectDay(day As Int)
	selectedDate = DateUtils.setDate(year, month, day)
	selectedDay = day
	selectedMonth = month
	selectedYear = year
	If GetCurrentDateFromTextField (dateField.Text) <> selectedDate Then
		dateField.Text = DateTime.Date(selectedDate)
		If xui.IsB4i Then
			'the TextChanged event is not raised in B4i for programmatic changes.
			DateField_TextChanged("", dateField.Text)
		End If
	End If
End Sub


Private Sub HandleMouse(x As Double, y As Double, move As Boolean)
	Dim boxX = x / boxW, boxY =  y / boxH As Int
	Dim newSelectedDay As Int = boxY * 7 + boxX + 1 - dayOfWeekOffset
	Dim validDay As Boolean = newSelectedDay > 0 And newSelectedDay <= daysInMonth
	If move Then
		If newSelectedDay = tempSelectedDay Then Return
		cvsBackground.ClearRect(cvsBackground.TargetRect)
		tempSelectedDay = newSelectedDay
		If validDay Then
			DrawBox(cvsBackground, tempSelectedColor, boxX, boxY)
		End If
	Else
		cvsBackground.ClearRect(cvsBackground.TargetRect)
		If validDay Then
			SelectDay(newSelectedDay)
			Hide
		End If
	End If
	
	cvsBackground.Invalidate
End Sub

Private Sub Show
	If visible Then Return
	CloseAllDialogs
	visible = True
	dateField.Enabled = False
	DrawDays
	pnlDialog.SetLayoutAnimated(0, MainPanel.Width / 2 - pnlDialog.Width / 2, MainPanel.Height / 2 - pnlDialog.Height / 2, _
		pnlDialog.Width, pnlDialog.Height)
	pnlDialog.BringToFront
	pnlDialog.SetVisibleAnimated(200, True)
End Sub

Public Sub Hide
	If visible = False Then Return
	pnlDialog.SetVisibleAnimated(200, False)
	dateField.Enabled = True
	visible = False
End Sub

Public Sub getIsVisible As Boolean
	Return visible
End Sub

'Returns true if there was a visible dialog
Public Sub CloseAllDialogs As Boolean
	Dim res As Boolean = False
	For i = 0 To MainPanel.NumberOfViews - 1
		Dim x As B4XView = MainPanel.GetView(i)
		If x.Tag Is AnotherDatePicker Then
			Dim adp As AnotherDatePicker = x.Tag
			adp.Hide
			res = True
		End If
	Next
	Return res
End Sub

#if B4J
Private Sub btnYear_Action
#Else
Private Sub btnYear_Click
#End If
	Dim btn As B4XView = Sender
	year = year + btn.Tag
	DrawDays
End Sub

#if B4J
Private Sub btnMonth_Action
#Else
Private Sub btnMonth_Click
#End If
	Dim btn As B4XView = Sender
	Dim m As Int = 12 + month - 1 + btn.Tag
	month = (m Mod 12) + 1
	DrawDays
End Sub

#if B4J
Private Sub btnToday_Action
#Else
Private Sub btnToday_Click
#End If
	setDate(DateTime.Now)
	Hide
End Sub

#if B4J
Private Sub btnCancel_Action
#Else
Private Sub btnCancel_Click
#End If
	Hide
End Sub



#if B4J
Private Sub DaysPaneFg_MouseMoved (EventData As MouseEvent)
	HandleMouse(EventData.X, EventData.Y, True)
End Sub

Private Sub DaysPaneFg_MousePressed (EventData As MouseEvent)
	HandleMouse(EventData.X, EventData.Y, False)
End Sub
#else if B4A or B4i
Private Sub DaysPaneFg_Touch (Action As Int, X As Float, Y As Float)
	Dim p As Panel = DaysPaneFg
	HandleMouse(X, Y, Action <> p.ACTION_UP)
End Sub
#end if
