B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: RequestData(Date As Long) As String
#DesignerProperty: Key: WeekStart, DisplayName: Week starts, FieldType: String, DefaultValue: Sunday, List: Sunday|Monday, Description: Start day of week
#DesignerProperty: Key: StartYear, DisplayName: Start Year, FieldType: Int, DefaultValue: 1900, Description: Start year for calendar dropdown
#DesignerProperty: Key: EndYear, DisplayName: End Year, FieldType: Int, DefaultValue: -1, Description: End year for calendar dropdown set to -1 for current year
#DesignerProperty: Key: LineColor, DisplayName: Line Colour, FieldType: Color, DefaultValue: 0xFF000000, Description: Line colour for calendar

Sub Class_Globals
	Private FX As JFX
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private Months As List
	Private DayNames As List
	Private LastDays As List = Array(31,28,31,30,31,30,31,31,30,31,30,31)
	Private btnPrevYear As B4XView
	Private lblYear As B4XView
	Private btnNextYear As B4XView
	Private btnNextMonth As B4XView
	Private lblMonth As B4XView
	Private btnPrevMonth As B4XView
	Private pnCalendar As B4XView
	Private pnCalendarLines As B4XView
	Private ShowingYear,ShowingMonth As Int
	Private pnDays As B4XView
	Private WeekStartDay As String
	Private PopupList As Popup
	Private clvPopup As CustomListView				'ignore
	Private lblPopup As B4XView						'ignore
	Private StartYearDD As Int
	Private EndYearDD As Int
	Private CLU As calendarlayout_Utils
	Private Linecolor As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	CLU.Initialize
	xui.RegisterDesignerClass(CLU)
	PopupList.Initialize
	PopupList.SetAutoHide(True)
	PopupList.SetOnAutoHide(Me,"Popup1AutoHide")
	
End Sub

Private Sub PopupLoadLayout(P As Popup, Layout As String, Width As Double, Height As Double)
	P.GetBase.RemoveAllNodes
	P.GetBase.SetLayoutAnimated(0,0,0,Width,Height)
	
	P.GetBase.LoadLayout(Layout)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	mBase.LoadLayout("calendarlayout")
	
	Dim  O As Object = mBase.As(JavaObject).CreateEventFromUI("javafx.event.EventHandler","Scroll",Null)
	mBase.As(JavaObject).RunMethod("setOnScroll",Array(O))
	
	StartYearDD = Props.GetDefault("StartYear",1900)
	EndYearDD = Props.GetDefault("EndYear",-1)
	If EndYearDD = -1 Then EndYearDD = DateTime.GetYear(DateTime.Now)
	
	WeekStartDay = Props.GetDefault("WeekStart","Sunday")
	Linecolor = xui.PaintOrColorToColor(Props.GetDefault("LineColor",xui.Color_Black))
	
	CLU.LineColor = Linecolor
	
	Months.Initialize
	Months.AddAll(Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))
	
	ShowingYear = DateTime.GetYear(DateTime.Now)
	ShowingMonth = DateTime.GetMonth(DateTime.Now)
	lblMonth.Text = Months.Get(ShowingMonth - 1)
	lblYear.Text = ShowingYear
	
	DayNames.Initialize
	If WeekStartDay = "Sunday" Then
		DayNames.AddAll(Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat"))
	Else
		DayNames.AddAll(Array("Mon","Tue","Wed","Thu","Fri","Sat","Sun"))
	End If
	
	SetDays
	
	ShowDates

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

End Sub

'Pass reset = True to return to the colour defined in the designer
Public Sub SetLineColor(Color  As Int,Reset As Boolean)
	If Reset Then
		CLU.LineColor = Linecolor
	Else
		CLU.LineColor = Color
	End If
	Sleep(0)
	Dim W As JavaObject = mBase.As(JavaObject).RunMethodJO("getScene",Null).RunMethod("getWindow",Null)
	W.RunMethod("setHeight",Array(W.RunMethod("getHeight",Null) - 1))
	Sleep(100)
	W.RunMethod("setHeight",Array(W.RunMethod("getHeight",Null) + 1))
End Sub

Private Sub  Scroll_Event (MethodName As String, Args() As Object)
	Dim ScrollEvent As JavaObject = Args(0)
	
	If ScrollEvent.RunMethod("isControlDown",Null) Then
		If ScrollEvent.RunMethod("getDeltaY",Null) > 0 Then
			btnNextYear_Click
		Else
			btnPrevYear_Click
		End If
	Else
		If ScrollEvent.RunMethod("getDeltaY",Null) > 0 Then
			btnNextMonth_Click
		Else
			btnPrevMonth_Click
		End If
	End If
End Sub

'Start your list on a Sunday
Public Sub SetDayNames(Names As List)
	DayNames.Clear
	DayNames.AddAll(Names)
	If  WeekStartDay = "Monday" Then
		Dim Sunday As String = DayNames.Get(0)
		DayNames.RemoveAt(0)
		DayNames.Add(Sunday)
	End If
	SetDays
End Sub

Public Sub SetMonthNames(Names As List)
	Months.Clear
	Months.AddAll(Names)
	lblMonth.Text = Months.Get(ShowingMonth - 1)
End Sub

Private Sub ShowDates
	Dim LastDay As Int = LastDays.Get(ShowingMonth - 1)
	Dim Format As String = DateTime.DateFormat
	DateTime.DateFormat = "dd/MM/yyyy"
	If ShowingMonth = 2 Then
		Try
			DateTime.DateParse("29/2/"& ShowingYear)
			LastDay = 29
		Catch
'			Log(LastException)
			LastDay = 28
		End Try							'ignore
	End If
	
	Dim DateStub As String = $"${ShowingMonth}/${ShowingYear}"$
	
	Dim FirstDayPos As Int = DateTime.GetDayOfWeek(DateTime.DateParse($"1/${ShowingMonth}/${ShowingYear}"$)) - 1
	
	If WeekStartDay = "Monday" Then
		FirstDayPos  = FirstDayPos - 1
		If FirstDayPos = -1 Then FirstDayPos = 6
	End If
	 
	For i = 0 To FirstDayPos - 1
		pnCalendar.GetView(i).GetView(0).Text = ""
		pnCalendar.GetView(i).GetView(1).Text = ""
	Next
	
	Dim Day As Int = 1
	For i = FirstDayPos To LastDay + FirstDayPos - 1
		pnCalendar.GetView(i).GetView(0).Text = Day
		pnCalendar.GetView(i).GetView(1).Text = CallSub2(mCallBack,mEventName & "_RequestData",DateTime.DateParse($"${Day}/${DateStub}"$))
	
		Day = Day + 1
	Next
	For i = i To pnCalendar.NumberOfViews - 1
		pnCalendar.GetView(i).GetView(0).Text = ""
		pnCalendar.GetView(i).GetView(1).Text = ""
	Next
	
	DateTime.DateFormat = Format
End Sub

Private Sub SetDays
	For i = 0 To pnDays.NumberOfViews - 1
		pnDays.GetView(i).Text = DayNames.Get(i)
	Next
End Sub



Private Sub btnNextMonth_Click
	ShowingMonth = ShowingMonth + 1
	If ShowingMonth = 13 Then 
		ShowingMonth = 1
		ShowingYear = ShowingYear + 1
		lblYear.Text = ShowingYear
	End If
	lblMonth.Text = Months.Get(ShowingMonth - 1)
	ShowDates
End Sub

Private Sub btnNextYear_Click
	ShowingYear = ShowingYear + 1
	lblYear.Text = ShowingYear
	ShowDates
End Sub

Private Sub btnPrevMonth_Click
	ShowingMonth = ShowingMonth - 1
	If ShowingMonth = 0 Then
		ShowingMonth = 12
		ShowingYear = ShowingYear - 1
		lblYear.Text = ShowingYear
	End If
	lblMonth.Text = Months.Get(ShowingMonth - 1)
	ShowDates
End Sub

Private Sub btnPrevYear_Click
	ShowingYear = ShowingYear - 1
	lblYear.Text = ShowingYear
	ShowDates
End Sub

Private Sub btnToday_Click
	ShowingYear = DateTime.GetYear(DateTime.Now)
	ShowingMonth = DateTime.GetMonth(DateTime.Now)
	lblYear.Text = ShowingYear
	lblMonth.Text = Months.Get(ShowingMonth - 1)
	ShowDates
End Sub

Private Sub lblYear_MouseClicked (EventData As MouseEvent)
	PopupLoadLayout(PopupList,"popuplist",100,350)
	lblPopup.Text = "Select Year"
	
	For i = StartYearDD To EndYearDD
		Dim Lbl As B4XView = NewLabel(i)
		Lbl.SetLayoutAnimated(0,0,0,100,30)
		Lbl.SetTextAlignment("CENTER","CENTER")
		clvPopup.Add(Lbl,i)
	Next

	If EndYearDD = DateTime.GetYear(DateTime.Now) Then clvPopup.sv.ScrollViewOffsetY = clvPopup.Size * 32
	If PopupList.IsShowing Then
		PopupList.Hide
	Else
		Dim P2s As JavaObject = lblYear.As(JavaObject).RunMethod("localToScreen",Array(lblYear.Left,lblYear.Top))
		PopupList.Show(lblMonth,P2s.RunMethod("getX",Null),P2s.RunMethod("getY",Null) + lblYear.Height)
	End If
End Sub

Private Sub lblMonth_MouseClicked (EventData As MouseEvent)
	PopupLoadLayout(PopupList,"popuplist",100,350)
	lblPopup.Text = "Select Month"
	For i = 0 To Months.Size - 1
		Dim Lbl As B4XView = NewLabel(Months.Get(i))
		Lbl.SetLayoutAnimated(0,0,0,100,30)
		Lbl.SetTextAlignment("CENTER","CENTER")
		clvPopup.Add(Lbl,i + 1)
	Next
	If PopupList.IsShowing Then
		PopupList.Hide
	Else
		Dim P2D As JavaObject = lblMonth.As(JavaObject).RunMethod("localToScreen",Array(lblMonth.Left,lblMonth.Top))
		PopupList.Show(lblMonth,P2D.RunMethod("getX",Null),P2D.RunMethod("getY",Null) + lblMonth.Height)
	End If
End Sub

Private Sub clvPopup_ItemClick (Index As Int, Value As Object)
	If lblPopup.Text = "Select Year" Then
		ShowingYear = Value
		lblYear.Text = Value	
	Else
	ShowingMonth = Value
	lblMonth.Text = Months.Get(ShowingMonth - 1)
	End If
	PopupList.Hide
	ShowDates
End Sub

Private Sub NewLabel(Text As String) As B4XView
	Dim L As Label
	L.Initialize("")
	L.Text = Text
	Return L
End Sub
