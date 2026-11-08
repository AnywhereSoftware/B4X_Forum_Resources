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
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private HorizontalScrollView1 As HorizontalScrollView
	
	Private currentYear As Int
	Private currentMonth As Int
	Private currentDay As Int
	
	Private scroll_position As Int
	Private croll_current As Int = 1
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor"))
	
	HorizontalScrollView1.Initialize(100%x,"")
	mBase.AddView(HorizontalScrollView1, 0, 0, mBase.Width, mBase.Height)
	
	DrawCalendar(DateTime.Now)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub DrawCalendar(value As Long)
	Dim weekName(7) As String = Array As String("Su","Mo","Tu","We","Th","Fr","Sa")
	'Dim weekName(7) As String = Array As String("C.Nhật","T.Hai","T.Ba","T.Tư","T.Năm","T.Sáu","T.Bảy")
	Dim width As Int = 100%x / 7
	Dim positionY As Int = 0
				
	'Dim current_date_time As Long = DateTime.DateParse("3/1/2026")
	currentDay = DateTime.GetDayOfMonth(DateTime.Now)
	currentMonth = DateTime.GetMonth(value)
	currentYear = DateTime.GetYear(value)
		
	Dim nameOfMonths As Map
	nameOfMonths.Initialize
	
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
	
	Dim length_month As Int = nameOfMonths.GetValueAt(currentMonth -1)
		
	Dim week_day As Int = DateTime.GetDayOfWeek(DateTime.DateParse(currentMonth & "/1/" & currentYear)) - 1
	
	If week_day = 7 Then
		week_day = 0
	End If
	
	Dim week_count As Int = 0
	Dim week_scroll As Int = 0
	
	HorizontalScrollView1.Panel.RemoveAllViews
	
	For i=1 To length_month
		Dim itd As DayItem
		itd.Initialize(Me, "dayItem", width)
	
		HorizontalScrollView1.Panel.AddView(itd.GetView, positionY, 0dip, width, 50dip)
		
		itd.DayNumber = i
		itd.DayName = weekName(week_day)
		Dim full_date As String = currentMonth & "/" & i & "/" & currentYear
		itd.FulDate = DateTime.DateParse(full_date)
		positionY = positionY + width
	
		If week_day = 6 Then
			week_day = 0
			week_count = week_count + 1
		Else
			week_day = week_day + 1
		End If
		
		If i = currentDay Then
			itd.Active
			week_scroll = week_count
		End If
	Next
	HorizontalScrollView1.Panel.Width = positionY
	
	' Scroll and find current week
	scroll_position = positionY / 4
	CallSubDelayed2(Me,"Scroll2Pos",scroll_position * week_scroll)
End Sub

Sub isLeapYear(year As Int) As Boolean
	Return (year Mod 4 = 0) And (year Mod 100 <> 0) Or (year Mod 400 = 0)
End Sub

Private Sub dayItem_Click(value As Long)	
	CallSub2(mCallBack, mEventName & "_ItemClick", value)
End Sub

Public Sub GoNextWeek()
	croll_current = croll_current + 1
	CallSubDelayed2(Me,"Scroll2Pos",scroll_position * croll_current)
	Log(scroll_position * croll_current)
End Sub

Public Sub GoBackWeek()
	croll_current = croll_current - 1
	CallSubDelayed2(Me,"Scroll2Pos",scroll_position * croll_current)
End Sub


Sub Scroll2Pos (pos As Int)
	HorizontalScrollView1.ScrollPosition=pos
End Sub