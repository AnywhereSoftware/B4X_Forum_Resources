B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: ItemClick (NewDate As Long)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As Panel
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private pnlDays As Panel
	Private pnlWeek As Panel
	Private lblMonth As Label
	Private pnlMonth As Panel
	Private lblDay(45) As CalendarBox
	Private fDay As Int
	Private maxDay As Int
	Private currentYear As Int
	Private currentMonth As Int
	Private currentDay As Int
	
	Private valueLong As Long
	Private valueString As String
	Private pnlBackground As Panel
	
	Private color1 As Int = Colors.ARGB(255, 151, 94, 236)
	Private color2 As Int = Colors.ARGB(255, 242, 224, 253)
	Private lstBitmap As Map
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lstBitmap.Initialize
	
	'mBase.Initialize("mBase")
	

End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
	
	lblMonth.Initialize("")
	mBase.AddView(lblMonth, 0, 0, mBase.Width, 30dip)
	lblMonth.Color = Colors.Red
	lblMonth.Text = "April 2026"
	lblMonth.Color = Colors.ARGB(255, 0, 27, 183)
	lblMonth.TextColor = Colors.White
	lblMonth.Gravity = Gravity.CENTER
	
	pnlWeek.Initialize("")
	mBase.AddView(pnlWeek, 0, 30dip, mBase.Width, 30dip)
	pnlWeek.Color = Colors.ARGB(255, 245, 241, 220)
	
	pnlDays.Initialize("")
	mBase.AddView(pnlDays, 0, 70dip, mBase.Width, 260dip)
	pnlDays.Color = Colors.White
	
	DrawCalendar(DateTime.Now)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub


Public Sub AddBitmap(date As Long, image As Bitmap)
	lstBitmap.Put(date, image)
End Sub

Private Sub HasBitmap(day As Int) As Boolean
	Dim result As Boolean = False
	For i=0 To lstBitmap.Size - 1
		Dim kDay As Long = lstBitmap.GetKeyAt(i)
		Dim vDay As Int = DateTime.GetDayOfMonth(kDay)
		If vDay = day Then
			result = True
		End If
	Next
	Return result
End Sub

Private Sub GetBitmap(day As Int) As Bitmap
	
	For i=0 To lstBitmap.Size - 1
		Dim kDay As Long = lstBitmap.GetKeyAt(i)
		Dim vDay As Int = DateTime.GetDayOfMonth(kDay)
		If vDay = day Then
			Return lstBitmap.GetValueAt(i)
		End If
	Next
	Return Null
End Sub


Public Sub DrawCalendar(date As Long)
		
	Dim widthOfDayBox As Int = (mBase.Width / 7)
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
			
	Dim cMonth As Int = DateTime.GetMonth(date)
	currentMonth = cMonth
	Dim cDay As Int = DateTime.GetDayOfMonth(date)
	Dim cYear As Int = DateTime.GetYear(date)
	
	lblMonth.Text = nameOfMonths.GetKeyAt(cMonth - 1) & " " & cYear
		
	Dim firstMonth As String = $"${cMonth}/1/${cYear}"$
	Dim fMonth As Long = DateTime.DateParse(firstMonth)
	fDay = DateTime.GetDayOfWeek(fMonth) - 1
	Dim countDay As Int = 1
	maxDay = nameOfMonths.GetValueAt(cMonth - 1)
	
	' Draw week
	For i=0 To 6
		lblWeek(i).Initialize("week")
		lblWeek(i).Text = weekName(i)
		lblWeek(i).TextColor =Colors.ARGB(255, 84, 119, 146)
		'lblWeek(i).Color = Colors.ARGB(255, 232, 226, 219)
		lblWeek(i).Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
		pnlWeek.AddView(lblWeek(i), positionX, 0,  widthOfDayBox, 30dip)
		positionX = positionX + widthOfDayBox
	Next
	
	If fDay = 7 Then
		positionY = -40dip
	End If
	positionX = 0
	
	pnlDays.RemoveAllViews
		
	For i=0 To lblDay.Length - 1
		' Draw days
		lblDay(i).Initialize(Me,"lblDay", widthOfDayBox, 35dip)
		lblDay(i).Tag = i
		If i >= fDay And countDay <= maxDay Then
			' Draw a bitmap
			If HasBitmap(countDay) Then
				lblDay(i).BitMap = GetBitmap(countDay)
			Else
				lblDay(i).SetText(countDay)
			End If
						
			Dim lDate As Long = DateTime.DateParse($"${cMonth}/${countDay}/${cYear}"$)
			lblDay(i).Date = lDate
						
			countDay = countDay + 1
		Else
			lblDay(i).SetText("")
		End If
		
			
		pnlDays.AddView(lblDay(i).GetView, positionX + 4dip, positionY, widthOfDayBox - 8dip, widthOfDayBox - 8dip)
		positionX = positionX + widthOfDayBox
		
		If (i Mod 7) = 6 Then
			positionY = positionY + 40dip
			positionX = 0
		End If
	Next
End Sub

Sub isLeapYear(year As Int) As Boolean
	Return (year Mod 4 = 0) And (year Mod 100 <> 0) Or (year Mod 400 = 0)
End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub SetNewValue
	valueString = $"${currentMonth}/${currentDay}/${currentYear}"$
	
	valueLong = DateTime.DateParse(valueString)
	'CallSub2(mCallBack, mEventName & "_DateChanged", GetLong)
End Sub


Private Sub Button1_Click
	Dim event_time As Long = DateTime.DateParse("2/4/2026")
	Dim color As Int = Colors.ARGB(255,91, 35, 255)
	
	AddEvent(color, "Add event", event_time)
End Sub

Public Sub AddEvent(color As Int, content As String, date As Long)
	For i=0 To lblDay.Length - 1
		Dim ldt As Long = lblDay(i).Date
		Dim m1 As Int = DateTime.GetDayOfMonth(ldt)
		Dim m2 As Int = DateTime.GetDayOfMonth(date)
		If m1 = m2 Then
			lblDay(i).AddEvent(color, content, date)
		End If
	Next
End Sub

Sub lblDay_Click(date As Long)
	CallSub2(mCallBack, mEventName & "_ItemClick", date)
End Sub