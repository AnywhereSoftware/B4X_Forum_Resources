B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: DateChanged (NewDate As Long)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private Root As B4XView
	Private xui As XUI
	Private pnlWrapper As Panel
	Private pnlDays As Panel
	Private pnlWeek As Panel
	Private lblYear As Label
	Private lblMonth As Label
	Private pnlYear As Panel
	Private pnlMonth As Panel
	Private lblDay(45) As Label
	Private fDay As Int
	Private maxDay As Int
	Private currentYear As Int
	Private btnBackYear As Label
	Private btnNextYear As Label
	Private currentMonth As Int
	Private currentDay As Int
	Private btnBackMonth As Label
	Private btnNextMonth As Label
	Private btnConfirm As B4XView
	Private valueLong As Long
	Private valueString As String
	Private pnlBackground As Panel
	Private pnlbg As Panel
	Private pnlShadow As Panel
	Private color1 As Int = Colors.ARGB(255, 151, 94, 236)
	Private color2 As Int = Colors.ARGB(255, 242, 224, 253)
End Sub

Public Sub Initialize (Callback As Object, EventName As String, rootPanel As Panel)
	mEventName = EventName
	mCallBack = Callback
	rootPanel.LoadLayout("MainPage")
	'pnlWrapper.LoadLayout("MainPage")
	'pnlWrapper.Color = Colors.Transparent
	pnlShadow.SendToBack
	pnlShadow.Visible = False
	pnlBackground.Elevation = 3dip
	
	currentYear = 2026
	currentDay = 1
	currentMonth = 1
	
	ChangeColor
End Sub

Private Sub ChangeColor
	pnlYear.Color = color1
	lblMonth.TextColor = color1
	btnConfirm.As(B4XView).SetColorAndBorder(color1, 1dip, color2, 4dip)
	btnConfirm.TextColor = Colors.White
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
	
End Sub

public Sub SetColor1(value As Int)
	color1 = value
	ChangeColor
End Sub

public Sub SetColor2(value As Int)
	color2 = value
	ChangeColor
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub Show(date As Long)
	pnlShadow.BringToFront
	pnlShadow.Visible = True
	DrawCalendar(date)
End Sub

Private Sub DrawCalendar(date As Long)
		
	Dim widthOfDayBox As Int = (pnlBackground.Width / 7)
	Dim positionY As Int = 0dip
	Dim positionX As Int = 0dip
	
	Dim lblWeek(7) As Label
	Dim weekName(7) As String = Array As String("Su","Mo","Tu","We","Th","Fr","Sa")
	Dim nameOfMonths As Map
	nameOfMonths.Initialize
		
	currentYear = DateTime.GetYear(date)
	currentDay = 1
	currentMonth = 1
		
	nameOfMonths.Put("January", 31)
	If isLeapYear(currentYear) Then
		nameOfMonths.Put("February", 29)
	Else
		nameOfMonths.Put("February", 28)
	End If
	
	nameOfMonths.Put("March", 31)
	nameOfMonths.Put("April", 30)
	nameOfMonths.Put("May", 31)
	nameOfMonths.Put("June", 30)
	nameOfMonths.Put("July", 31)
	nameOfMonths.Put("August", 31)
	nameOfMonths.Put("September", 30)
	nameOfMonths.Put("October", 31)
	nameOfMonths.Put("November",30 )
	nameOfMonths.Put("December", 31)
	
	lblYear.Text = DateTime.GetYear(date)
	
	Dim cMonth As Int = DateTime.GetMonth(date)
	currentMonth = cMonth
	Dim cDay As Int = DateTime.GetDayOfMonth(date)
	
	lblMonth.Text = nameOfMonths.GetKeyAt(cMonth - 1)
		
	Dim firstMonth As String = $"${cMonth}/1/${lblYear.Text}"$
	Dim fMonth As Long = DateTime.DateParse(firstMonth)
	fDay = DateTime.GetDayOfWeek(fMonth) - 1
	Dim countDay As Int = 1
	maxDay = nameOfMonths.GetValueAt(cMonth - 1)
	
	' Draw week
	For i=0 To 6
		lblWeek(i).Initialize("week")
		lblWeek(i).Text = weekName(i)
		lblWeek(i).TextColor = Colors.Gray
		lblWeek(i).Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
		pnlWeek.AddView(lblWeek(i), positionX, 0,  widthOfDayBox, widthOfDayBox)
		positionX = positionX + widthOfDayBox
	Next
	
	If fDay = 7 Then
		positionY = -40dip
	End If
	positionX = 0
	
	pnlDays.RemoveAllViews
		
	For i=0 To lblDay.Length - 1
		' Draw days
		lblDay(i).Initialize("days")
		lblDay(i).Tag = i
		If i >= fDay And countDay <= maxDay Then
			
			lblDay(i).Text = countDay
			lblDay(i).TextColor = Colors.Black
			lblDay(i).Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
			
			countDay = countDay + 1
		Else
			lblDay(i).Text = ""
		End If
		
			
		pnlDays.AddView(lblDay(i), positionX + 4dip, positionY, widthOfDayBox - 8dip, widthOfDayBox - 8dip)
		positionX = positionX + widthOfDayBox
		
		If (i Mod 7) = 6 Then
			positionY = positionY + 40dip
			positionX = 0
		End If
		'lblDay(i).Color = Colors.ARGB(255, 241, 241, 241)
		
	Next
End Sub

Sub ClearSelected
	For i=0 To lblDay.Length - 1
		lblDay(i).TextColor = Colors.Black
		lblDay(i).As(B4XView).SetColorAndBorder(Colors.White, 0dip, Colors.White, 0dip)
	Next
End Sub

Sub isLeapYear(year As Int) As Boolean
	Return (year Mod 4 = 0) And (year Mod 100 <> 0) Or (year Mod 400 = 0)
End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub days_Click
	ClearSelected
	Dim b As B4XView = Sender
	
	If b.Tag >= fDay And b.Tag <= maxDay Then
		b.As(B4XView).SetColorAndBorder(color1, 1dip, color2, 4dip)
		b.TextColor = Colors.White
		currentDay = b.Text
		SetNewValue
	End If
End Sub

Sub SetNewValue
	valueString = $"${currentMonth}/${currentDay}/${currentYear}"$
	btnConfirm.Text = valueString
	valueLong = DateTime.DateParse(valueString)
	CallSub2(mCallBack, mEventName & "_DateChanged", GetLong)
End Sub

Private Sub btnBackYear_Click
	currentYear = currentYear - 1
	Dim dt As String = $"${currentMonth}/01/${currentYear}"$
	DrawCalendar(DateTime.DateParse(dt))
	SetNewValue
End Sub

Private Sub btnNextYear_Click
	currentYear = currentYear + 1
	Dim dt As String = $"${currentMonth}/01/${currentYear}"$
	DrawCalendar(DateTime.DateParse(dt))
	SetNewValue
End Sub

Private Sub btnBackMonth_Click
	If currentMonth > 0 And currentMonth < 13 Then
		currentMonth = currentMonth - 1
		Dim dt As String = $"${currentMonth}/01/${currentYear}"$
		DrawCalendar(DateTime.DateParse(dt))
		SetNewValue
		
	End If
	
End Sub

Private Sub btnNextMonth_Click
	If currentMonth > 0 And currentMonth < 13 Then
		currentMonth = currentMonth + 1
		Dim dt As String = $"${currentMonth}/01/${currentYear}"$
		DrawCalendar(DateTime.DateParse(dt))
		SetNewValue
	End If
End Sub

Sub GetLong() As Long
	Return valueLong
End Sub

Sub GetString As String
	Return valueString
End Sub

Private Sub btnConfirm_Click	
	CallSub2(mCallBack, mEventName & "_DateChanged", GetLong)
	pnlShadow.SendToBack
	pnlShadow.Visible = False
End Sub