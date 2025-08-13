B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.78
@EndOfDesignText@
'AnotherDatePicker - v2.00 - Hijri Calendar
#Event: Closed (Cancelled As Boolean, Date As Long)
#DesignerProperty: Key: CancelVisible, DisplayName: Cancel Visible, FieldType: Boolean, DefaultValue: True, Description: Whether the cancel button should be displayed.
#DesignerProperty: Key: TodayVisible, DisplayName: Today Visible, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: MinYear, DisplayName: Minimum Year, FieldType: Int, DefaultValue: 1356, MinRange: 0, MaxRange: 3000
#DesignerProperty: Key: MaxYear, DisplayName: Maximum Year, FieldType: Int, DefaultValue: 1500, MinRange: 0, MaxRange: 3000
#DesignerProperty: Key: FirstDay, DisplayName: First Day, FieldType: String, DefaultValue: Sunday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday, Description: Sets the first day of week.
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: #FFCFDCDC
#DesignerProperty: Key: SelectedColor, DisplayName: Selected Color, FieldType: Color, DefaultValue: 0xFF0BA29B
#DesignerProperty: Key: HighlightedColor, DisplayName: Highlighted Color, FieldType: Color, DefaultValue: 0xFFABFFFB
Sub Class_Globals
	Private holder As Panel
	Private cvs, cvsBackground As Canvas
	Private DaysPanel As Panel
	Private month, year As Int
	Private Months As Spinner
	Private Years As Spinner
	Private boxW, boxH As Float
	Private vCorrection As Float
	Private ACTION_UP = 1, ACTION_MOVE = 2, ACTION_DOWN = 0 As Int
	Private tempSelectedDay As Int
	Private DaysPanelBackground As Panel
	Private dayOfWeekOffset As Int
	Private daysInMonth As Int
	Private tempSelectedColor As Int
	Private selectedColor As Int
	Private lblSelectedDay As Label
	Private selectedDate As Long
	Private targetLabel As Label
	Private selectedYear, selectedMonth, selectedDay As Int
	Private Label1 As Label
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
	Private Label5 As Label
	Private Label6 As Label
	Private Label7 As Label
	Private daysNames() As Label
	Private mTarget As Object
	Private mEventName As String
	Private waitForAddToActivity As Boolean
	Private minYear, maxYear, firstDay As Int
	Private btnCancel, btnToday As Button
	Private Hijrimonths As List
End Sub

'Initializes the picker
Public Sub Initialize (Target As Object, EventName As String)
	mTarget = Target
	mEventName = EventName
	Hijrimonths.Initialize2(Array As Int(1,2,3,4,5,6,7,8,9,10,11,12))
	
End Sub

Public Sub DesignerCreateView(base As Panel, lbl As Label, props As Map)
	Dim targetLabel As Label
	targetLabel.Initialize("lbl")
	targetLabel.TextSize = lbl.TextSize
	targetLabel.TextColor = lbl.TextColor
	base.AddView(targetLabel, 0, 0, base.Width, base.Height)
	base.Color = Colors.Transparent
	waitForAddToActivity = True
	'It is not possible to load a layout when inside the process of loading a layout.
	'AddToActivity loads the DatePicker layout. The solution is to use CallSubDelayed.
	CallSubDelayed2(Me, "AfterLoadLayout", props)
End Sub

Private Sub lbl_Click
	Show
End Sub

Public Sub AfterLoadLayout (Props As Map)
	waitForAddToActivity = False
	holder.Initialize("holder")
	holder.Visible = False
	holder.Color = Colors.Transparent
	Dim act As Activity = Props.Get("activity")
	act.AddView(holder, 0, 0, 100%x, 100%y)
	holder.LoadLayout("DatePicker")
	Dim p As Panel = holder.GetView(0)
	p.Color = Props.Get("BackgroundColor")
	If Props.Get("CancelVisible") = False And Props.Get("TodayVisible") = False Then p.Height = p.Height - 40dip
	btnToday.Visible = Props.Get("TodayVisible")
	btnCancel.Visible = Props.Get("CancelVisible")
	daysNames = Array As Label(Label1, Label2, Label3, Label4, Label5, Label6, Label7)
	Dim et As EditText
	et.Initialize("")
	targetLabel.Background = et.Background 'make the label look like an EditText
	cvs.Initialize(DaysPanel)
	cvsBackground.Initialize(DaysPanelBackground)
	selectedColor = Props.Get("SelectedColor")
	tempSelectedColor = Props.Get("HighlightedColor")	
	month = GregorianToHijri(DateTime.Now).Get(1) 
	year = GregorianToHijri(DateTime.Now).Get(0) 
	minYear = 1356 'Props.Get("MinYear")
	maxYear = 1500 'Props.Get("MaxYear")
	For y = minYear To maxYear
		Years.Add(y)
	Next
	For Each m As String In Hijrimonths 'DateUtils.GetMonthsNames
		Months.Add(m)
	Next
	Dim alldays As List = Regex.Split("\|", "Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday") 'need to escape the splitting character.
	firstDay = alldays.IndexOf(Props.Get("FirstDay"))
	Dim days As List = DateUtils.GetDaysNames
	For i = firstDay To firstDay + 7 - 1
		Dim d As String = days.Get(i Mod 7)
		daysNames(i - firstDay).Text = d.SubString2(0, 2)
	Next
	SetDate(DateTime.Now, False)
	vCorrection = cvs.MeasureStringHeight("1", Typeface.DEFAULT_BOLD, Label1.TextSize) / 2
	boxW = cvs.Bitmap.Width / 7
	boxH = cvs.Bitmap.Height / 6
	lblSelectedDay.Visible = False
	DrawDays
End Sub
'Returns the selected date.
Public Sub GetDate As Long
	Return selectedDate
End Sub
'Sets the selected date.
'UpdateLabel - Whether to update the label text.
Public Sub SetDate(date As Long, UpdateLabel As Boolean)
	If waitForAddToActivity Then
		CallSubDelayed3(Me, "SetDate", date, UpdateLabel)
		Return
	End If
	year = GregorianToHijri(date).Get(0)
	month = GregorianToHijri(date).Get(1)
	SelectDay(GregorianToHijri(date).Get(2), UpdateLabel)
	Years.SelectedIndex = year - minYear
	Months.SelectedIndex = month - 1
End Sub

Private Sub DrawDays
	cvsBackground.DrawColor(Colors.Transparent)
	cvs.DrawColor(Colors.Transparent)
	Dim firstDayOfMonth As Long = HijriToGregorian(year,month,1)-1 'DateUtils.SetDate(year, month, 1) - 1
	dayOfWeekOffset = (7 + DateTime.GetDayOfWeek(firstDayOfMonth) - firstDay) Mod 7
	daysInMonth = DateUtils.NumberOfDaysInMonth(month, year)
	If year = selectedYear And month = selectedMonth Then
		'draw the selected box
		DrawBox(cvs, selectedColor, (selectedDay - 1 + dayOfWeekOffset) Mod 7, _
			(selectedDay - 1 + dayOfWeekOffset) / 7)
	End If
	For day = 1 To daysInMonth
		Dim dxx As Int=GregorianToHijri(DateUtils.SetDate(year, month, day)).Get(2)
		Dim row As Int = (dxx - 1 + dayOfWeekOffset) / 7
		cvs.DrawText(dxx, (((dayOfWeekOffset + dxx - 1) Mod 7) + 0.5) * boxW, _
			(row + 0.5)* boxH + vCorrection, Typeface.DEFAULT_BOLD, Label1.TextSize, Colors.Black, "CENTER")
	Next
	DaysPanel.Invalidate
End Sub

Private Sub SelectDay(day As Int, UpdateLabel As Boolean)
	selectedDate = DateUtils.SetDate(year, month, day)
	selectedDay = day
	selectedMonth = month
	selectedYear = year
	If UpdateLabel Then targetLabel.Text = DateTime.Date(selectedDate)
End Sub
'Hides the picker.
Public Sub Hide
	holder.SetVisibleAnimated(500, False)
	
End Sub

Private Sub DrawBox(c As Canvas, clr As Int, x As Int, y As Int)
	Dim r As Rect
	r.Initialize(x * boxW, y * boxH, (x + 1) * boxW, (y + 1) * boxH)
	c.DrawRect(r, clr, True, 0)
End Sub

Private Sub DaysPanel_Touch (ACTION As Int, X As Float, Y As Float)
	Dim boxX = X / boxW, boxY = Y / boxH As Int
	Dim newSelectedDay As Int = boxY * 7 + boxX + 1 - dayOfWeekOffset
	Dim validDay As Boolean = newSelectedDay > 0 And newSelectedDay <= daysInMonth
	If ACTION = ACTION_DOWN Or ACTION = ACTION_MOVE Then
		If newSelectedDay = tempSelectedDay Then Return
		cvsBackground.DrawColor(Colors.Transparent) 'clear background
		tempSelectedDay = newSelectedDay
		If validDay Then
			DrawBox(cvsBackground, tempSelectedColor, boxX, boxY)
			lblSelectedDay.Text = newSelectedDay
			lblSelectedDay.Visible = True
		Else
			lblSelectedDay.Visible = False
		End If
	Else If ACTION = ACTION_UP Then
		lblSelectedDay.Visible = False
		cvsBackground.DrawColor(Colors.Transparent)
		If validDay Then
			SelectDay(newSelectedDay, True)
			CallSub3(mTarget, mEventName & "_Closed", False, GetDate)
			Hide
		End If
	End If
	DaysPanelBackground.Invalidate
End Sub
'Shows the picker.
Public Sub Show
	If waitForAddToActivity Then 
		'not ready yey
		CallSubDelayed(Me, "show")
		Return
	End If
	holder.SetVisibleAnimated(500, True)
	DrawDays
End Sub

Private Sub btnToday_Click
	SetDate(DateTime.Now, True)
	CallSub3(mTarget, mEventName & "_Closed", False, GetDate)
	Hide
End Sub

Public Sub btnCancel_Click
	CallSub3(mTarget, mEventName & "_Closed", True, GetDate)
	Hide
End Sub

Private Sub Months_ItemClick (Position As Int, Value As Object)
	month = Position + 1
	DrawDays
End Sub

Private Sub Years_ItemClick (Position As Int, Value As Object)
	year = Value
	DrawDays
End Sub
Public Sub IsVisible As Boolean
	Return holder.Visible
End Sub
Private Sub holder_Click
	btnCancel_Click
End Sub


Sub HijriToGregorian( Y As Int,M As Int,D As Int) As Long
	Dim jd As Long
	Dim I As Long
	Dim N As Long
	Dim J As Long
	Dim K As Long
	Dim H As Long

	jd = Fix((11 * Y + 3) / 30) + 354 * Y + 30 * M - Fix((M - 1) / 2) + D + 1948440 - 385
	If jd > 2299160 Then
		I = jd + 68569
		N = Fix((4 * I) / 146097)
		I = I - Fix((146097 * N + 3) / 4)
		H = Fix((4000 * (I + 1)) / 1461001)
		I = I - Fix((1461 * H) / 4) + 31
		J = Fix((80 * I) / 2447)
		D = I - Fix((2447 * J) / 80)
		I = Fix(J / 11)
		M = J + 2 - 12 * I
		Y = 100 * (N - 49) + H + I
	Else
		J = jd + 1402
		K = Fix((J - 1) / 1461)
		I = J - 1461 * K
		N = Fix((I - 1) / 365) - Fix(I / 1461)
		H = I - 365 * N + 30
		J = Fix((80 * H) / 2447)
		D = H - Fix((2447 * J) / 80)
		H = Fix(J / 11)
		M = J + 2 - 12 * H
		Y = 4 * K + N + H - 4716
	End If
	DateTime.DateFormat="dd/MM/yyyy"
	Return DateTime.DateParse(D&"/"&M&"/"&Y)
End Sub

Sub GregorianToHijri(TheDate As Long) As List
	Dim jd As Long
	Dim I As Long
	Dim N As Long
	Dim J As Long
   

	Dim D As Long
	Dim M As Long
	Dim Y As Long

	D = DateTime.GetDayOfMonth( TheDate)
	M = DateTime.getMonth(TheDate)
	Y = DateTime.GetYear(TheDate)
	If ((Y > 1582) Or ((Y = 1582) And (M > 10)) Or ((Y = 1582) And (M = 10) And (D > 14))) Then
		jd = Fix((1461 * (Y + 4800 + Fix((M - 14) / 12))) / 4) + Fix((367 * (M - 2 - 12 * (Fix((M - 14) / 12)))) / 12) - Fix((3 * (Fix((Y + 4900 + Fix((M - 14) / 12)) / 100))) / 4) + D - 32075
	Else
		jd = 367 * Y - Fix((7 * (Y + 5001 + Fix((M - 9) / 7))) / 4) + Fix((275 * M) / 9) + D + 1729777
	End If
	I = jd - 1948440 + 10632
	N = Fix((I - 1) / 10631)
	I = I - 10631 * N + 354
	J = (Fix((10985 - I) / 5316)) * (Fix((50 * I) / 17719)) + (Fix(I / 5670)) * (Fix((43 * I) / 15238))
	I = I - (Fix((30 - J) / 15)) * (Fix((17719 * J) / 50)) - (Fix(J / 16)) * (Fix((15238 * J) / 43)) + 29
	M = Fix((24 * I) / 709)
	D = I - Fix((709 * M) / 24)
	Y = 30 * N + J - 30
	Return Array (Y,M,D)
End Sub

Sub Fix(arg As Int) As Int
	Return Ceil(arg )
End Sub

