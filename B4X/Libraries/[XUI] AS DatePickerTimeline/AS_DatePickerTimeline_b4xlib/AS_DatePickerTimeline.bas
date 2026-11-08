B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
'AS_DatePickerTimeline
'Author: Alexander Stolte
'Version: V1.00

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-Add Event CustomDrawDay
V1.02
	-Add new Type ASDatePickerTimeline_CustomDrawDay
	-Breaking Change on Event CustomDrawDay - The second parameter has changed to Views As ASDatePickerTimeline_CustomDrawDay
	-Add Designer Property CurrentDateColor
	-Add Designer Property SelectedDateColor
	-BugFixes
V1.03
	-Add get and set SelectedDate
	-Add Scroll2Date
	-BugFixes
V1.04
	-Add set MonthNameShort
	-Add set WeekNameShort
V1.05
	-Add CustomDrawDay - You can make changes on one day without having to reload the entire week, with refresh
V1.06
	-Function "Refresh" is now even better
		-No visual flickering
		-Changes are instant
V1.07
	-Add get and set MaxDate - Will restrict date navigations features of forward, and also cannot swipe the control using touch gesture beyond the max date range
	-Add get and set MinDate - Will restrict date navigations features of backward, and also cannot swipe the control using touch gesture beyond the max date range
	-Add Rebuild - Clears the DatePicker and builds the DatePicker new
V1.08
	-BugFix
V1.09
	-BugFixes
V1.10
	-BugFix
V1.11
	-BugFixes
V1.12
	-Add get and set Enabled - If False then click events and scroll (only on paging mode) is disabled 
V1.13
	-Scroll2Date BugFix
V1.14
	-Add compatibility for AS_ViewPager Version 2.0
V1.15
	-ListMode List
		-Completely rewritten logic
		-Each day now has its own slot, instead of always adding 1 week to the list
		-MinDate and MaxDate can now be used in a more targeted manner
V1.16
	-Add Designer Property CreateMode - If you set it to Manual then you need to call CreateDatePicker
V1.17
	-B4A BugFix
V1.18
	-Add Event PageChanged
V1.19
	-BugFix - The CustomDrawDayEvent is now also triggered when a different day is selected
		-Old Day and New Day
V1.20
	-BugFixes
	-Add Designer Property SelectedDateTextColor
	-Add Designer Property SelectedMonthTextColor
	-Add Designer Property SelectedWeekDayTextColor
	-Add Designer Property ThemeChangeTransition
	-Add set Theme
	-Add get Theme_Light
	-Add get Theme_Dark
V1.21
	-BugFix
V1.22
	-BugFix If the selected day is recreated in LazyLoading, a crash occurs because a view was not initialized
V1.23
	-BugFixes
	-New get LoadingPanel
#End If

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: Fade, List: None|Fade
#DesignerProperty: Key: CreateMode, DisplayName: Create Mode, FieldType: String, DefaultValue: Automatic, List: Automatic|Manual , Description: If you set it to Manual then you need to call CreateDatePicker
#DesignerProperty: Key: ListMode, DisplayName: List Mode, FieldType: String, DefaultValue: Paging, List: Paging|List

#DesignerProperty: Key: CurrentDateColor, DisplayName: Current Date Color, FieldType: Color, DefaultValue: 0xFF202125

#DesignerProperty: Key: BodyColor, DisplayName: BodyColor, FieldType: Color, DefaultValue: 0xFF131416
#DesignerProperty: Key: DateTextColor, DisplayName: DateTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: MonthTextColor, DisplayName: Month TextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: WeekDayTextColor, DisplayName: WeekDay TextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: SelectedDateColor, DisplayName: SelectedDateColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: SelectedDateTextColor, DisplayName: SelectedDateTextColor, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: SelectedMonthTextColor, DisplayName: SelectedMonthTextColor, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: SelectedWeekDayTextColor, DisplayName: SelectedWeekDayTextColor, FieldType: Color, DefaultValue: 0xFF000000

#DesignerProperty: Key: FirstDayOfWeek, DisplayName: First Day of Week, FieldType: String, DefaultValue: Monday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday

#Event: SelectedDateChanged (Date As Long)
#Event: CustomDrawDay (Date As Long, Views As ASDatePickerTimeline_CustomDrawDay)
#Event: PageChanged (FirstDay As Long, LastDay As Long)

Sub Class_Globals
	
	Type ASDatePickerTimeline_SelectedDayProperties(Color As Int,CornerRadius As Float,DateTextColor As Int,MonthTextColor As Int,WeekDayTextColor As Int)
	Type ASDatePickerTimeline_BodyProperties(BodyColor As Int,CurrentDateColor As Int,DateTextColor As Int,DateTextFont As B4XFont,MonthTextColor As Int,MonthTextFont As B4XFont,WeekDayTextColor As Int,WeekDayTextFont As B4XFont)
	
	Type ASDatePickerTimeline_MonthNameShort(January As String,February As String,March As String,April As String,May As String,June As String, July As String,August As String, September As String,October As String,November As String, December As String)
	Type ASDatePickerTimeline_WeekNameShort(Monday As String,Tuesday As String,Wednesday As String,Thursday As String,Friday As String,Saturday As String,Sunday As String)
	
	Type ASDatePickerTimeline_CustomDrawDay(BackgroundPanel As B4XView,xlbl_Date As B4XView,xlbl_Month As B4XView,xlbl_WeekDay As B4XView,xpnl_CurrentDay As B4XView)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private m_isReady As Boolean = False
	
	Private g_SelectedDayProperties As ASDatePickerTimeline_SelectedDayProperties
	Private g_BodyProperties As ASDatePickerTimeline_BodyProperties
	
	Private g_MonthNameShort As ASDatePickerTimeline_MonthNameShort
	Private g_WeekNameShort As ASDatePickerTimeline_WeekNameShort
	
	Private xpnl_ListBackground As B4XView
	Private xASVP_Main As ASViewPager
	Private xclv_Main As CustomListView
	Private xpnl_LoadingPanel As B4XView
	
	Private xpnl_SelectedPanel As B4XView
	
	Private m_CreateMode As String
	Private m_ListMode As String
	Private m_FirstDayOfWeek As Int = 5 'Monday
	Private m_StartDate As Long
	Private m_SelectedDate As Long
	Private m_MinDate,m_MaxDate As Long
	Private m_Enabled As Boolean = True
	Private m_ThemeChangeTransition As String
	
	Private xiv_RefreshImage As B4XView
	
	Type ASDatePickerTimeline_Theme(Body_Color As Int,Body_CurrentDateColor As Int,Body_DateTextColor As Int,Body_MonthTextColor As Int,Body_WeekDayTextColor As Int,SelectedDay_Color As Int,SelectedDay_DateTextColor As Int,SelectedDay_MonthTextColor As Int,SelectedDay_WeekDayTextColor As Int)
	
End Sub

Public Sub setTheme(Theme As ASDatePickerTimeline_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	
	g_BodyProperties.BodyColor = Theme.Body_Color
	g_BodyProperties.CurrentDateColor = Theme.Body_CurrentDateColor
	g_BodyProperties.DateTextColor = Theme.Body_DateTextColor
	g_BodyProperties.MonthTextColor = Theme.Body_MonthTextColor
	g_BodyProperties.WeekDayTextColor = Theme.Body_WeekDayTextColor
	
	g_SelectedDayProperties.Color = Theme.SelectedDay_Color
	g_SelectedDayProperties.DateTextColor = Theme.SelectedDay_DateTextColor
	g_SelectedDayProperties.MonthTextColor = Theme.SelectedDay_MonthTextColor
	g_SelectedDayProperties.WeekDayTextColor = Theme.SelectedDay_WeekDayTextColor
	
	Sleep(0)
	
	xpnl_LoadingPanel.Color = g_BodyProperties.BodyColor
	Refresh
	
	Sleep(250)
	
	Select m_ThemeChangeTransition
		Case "None"
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select
	
End Sub

Public Sub getTheme_Dark As ASDatePickerTimeline_Theme
	
	Dim Theme As ASDatePickerTimeline_Theme
	Theme.Initialize
	Theme.Body_Color = xui.Color_ARGB(255,19, 20, 22)
	Theme.Body_CurrentDateColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.Body_DateTextColor = xui.Color_White
	Theme.Body_MonthTextColor = xui.Color_White
	Theme.Body_WeekDayTextColor = xui.Color_White
	
	Theme.SelectedDay_Color = xui.Color_White
	Theme.SelectedDay_DateTextColor = xui.Color_Black
	Theme.SelectedDay_MonthTextColor = xui.Color_Black
	Theme.SelectedDay_WeekDayTextColor = xui.Color_Black
	
	Return Theme
	
End Sub

Public Sub getTheme_Light As ASDatePickerTimeline_Theme
	
	Dim Theme As ASDatePickerTimeline_Theme
	Theme.Initialize
	Theme.Body_Color = xui.Color_White
	Theme.Body_CurrentDateColor = 0xFFE9E9E9
	Theme.Body_DateTextColor = xui.Color_Black
	Theme.Body_MonthTextColor = xui.Color_Black
	Theme.Body_WeekDayTextColor = xui.Color_Black
	
	Theme.SelectedDay_Color = xui.Color_Black
	Theme.SelectedDay_DateTextColor = xui.Color_White
	Theme.SelectedDay_MonthTextColor = xui.Color_White
	Theme.SelectedDay_WeekDayTextColor = xui.Color_White
	
	Return Theme
	
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

	IniProps(Props)
	m_StartDate = DateTime.Now
	xpnl_ListBackground = xui.CreatePanel("")
	mBase.AddView(xpnl_ListBackground,0,0,mBase.Width,mBase.Height)

	xpnl_LoadingPanel = xui.CreatePanel("")
	xpnl_LoadingPanel.Color = g_BodyProperties.BodyColor
	mBase.AddView(xpnl_LoadingPanel,0,0,mBase.Width,mBase.Height)

	If m_ListMode = "Paging" Then
		ini_viewpager
	Else
		ini_xclv
	End If
	
	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)
	
	If m_CreateMode = "Automatic" Then
		AddWeeks
	End If
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Private Sub IniProps(Props As Map)
	
	#If B4J
	m_ListMode = "Paging"
	#Else
	m_ListMode = Props.Get("ListMode")
	#End If
	
	m_CreateMode = Props.GetDefault("CreateMode","Automatic")
	
	If "Friday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 1
	else If "Thursday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 2
	else If "Wednesday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 3
	else If "Tuesday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 4
	else If "Monday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 5
	else If "Sunday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 6
	else If "Saturday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 7
	End If
	
	g_SelectedDayProperties.Initialize
	g_SelectedDayProperties.CornerRadius = 10dip
	g_SelectedDayProperties.Color = xui.PaintOrColorToColor(Props.GetDefault("SelectedDateColor",0xFF4962A4))
	g_SelectedDayProperties.DateTextColor = xui.PaintOrColorToColor(Props.GetDefault("SelectedDateTextColor",0xFF000000))
	g_SelectedDayProperties.WeekDayTextColor = xui.PaintOrColorToColor(Props.GetDefault("SelectedWeekDayTextColor",0xFF000000))
	g_SelectedDayProperties.MonthTextColor = xui.PaintOrColorToColor(Props.GetDefault("SelectedMonthTextColor",0xFF000000))
	
	g_BodyProperties.Initialize
	g_BodyProperties.BodyColor = xui.PaintOrColorToColor(Props.Get("BodyColor"))
	g_BodyProperties.CurrentDateColor = xui.PaintOrColorToColor(Props.GetDefault("CurrentDateColor",0xFF3C4043))
	g_BodyProperties.DateTextColor = xui.PaintOrColorToColor(Props.Get("DateTextColor"))
	g_BodyProperties.DateTextFont = xui.CreateDefaultBoldFont(20)
	g_BodyProperties.MonthTextColor = xui.PaintOrColorToColor(Props.Get("MonthTextColor"))
	g_BodyProperties.MonthTextFont = xui.CreateDefaultFont(12)
	g_BodyProperties.WeekDayTextColor = xui.PaintOrColorToColor(Props.Get("WeekDayTextColor"))
	g_BodyProperties.WeekDayTextFont = xui.CreateDefaultFont(12)
	
	g_MonthNameShort = CreateASDatePickerTimeline_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")
	g_WeekNameShort = CreateASDatePickerTimeline_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")
	
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition","Fade")
	
End Sub

Private Sub ini_viewpager
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("Orientation","Horizontal")
	tmpmap.Put("Carousel",False)
	tmpmap.Put("LazyLoading",True)
	tmpmap.Put("LazyLoadingExtraSize",3)
	xASVP_Main.Initialize(Me,"xASVP_Main")
	xASVP_Main.DesignerCreateView(xpnl_ListBackground,tmplbl,tmpmap)
	xASVP_Main.LoadingPanelColor = xui.Color_Transparent
End Sub

Private Sub ini_xclv
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x00FFFFFF)
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation","Horizontal")
	tmpmap.Put("ShowScrollBar",False)
	xclv_Main.Initialize(Me,"xclv_main")
	xclv_Main.DesignerCreateView(xpnl_ListBackground,tmplbl,tmpmap)
	xclv_Main.AnimationDuration = 0
	#IF B4A
'	Private objPages As Reflector
'	objPages.Target = xclv_Main.sv
'	objPages.SetOnTouchListener("xpnl_PageArea2_Touch")
	#Else IF B4I		
	
	xclv_Main.sv.As(ScrollView).Bounces = False
	#Else IF B4J
	'Dim r As Reflector
	'r.Target = xclv_Main.sv
'	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_PRESSED")
'	r.AddEventFilter("et", "javafx.scene.input.KeyEvent.KEY_RELEASED")
	'r.AddEventFilter("et", "javafx.scene.input.Scroll")
	
	Dim sp As ScrollPane = xclv_Main.sv
	sp.Style="-fx-background:transparent;-fx-background-color:transparent;"
	#End if
	
	#If B4I
	Do While xclv_Main.sv.IsInitialized = False
	'Sleep(0)
	Loop
	Dim sv As ScrollView = xclv_Main.sv
	sv.Color = xui.Color_Transparent'xui.Color_ARGB(255,32, 33, 37)
	#End If
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xpnl_ListBackground.SetLayoutAnimated(0,0,0,Width,Height)
	If m_ListMode = "Paging" Then
		xASVP_Main.Base_Resize(Width,xpnl_ListBackground.Height)
		xASVP_Main.ResetLazyLoadingPanels
		Sleep(0)
		xASVP_Main.ResetLazyloadingIndex
		xASVP_Main.Commit
		Else
		xclv_Main.AsView.SetLayoutAnimated(0,xclv_Main.AsView.Left,xclv_Main.AsView.Top,Width,Height)
		xclv_Main.Base_Resize(xclv_Main.AsView.Width,xclv_Main.AsView.Height)
	End If
End Sub

'Only call this if you set the CreateMode in the designer to Manual!!!
Public Sub CreateDatePicker
	AddWeeks
End Sub

Private Sub AddWeeks
	
	Dim YearGap As Int = 3
	#If Debug
	YearGap = 1
	#End If
	
	Dim StartDate As Long
	If m_MinDate = 0 Then
		StartDate =	DateUtils.SetDate(DateTime.GetYear(m_StartDate)-YearGap,1,1)
	Else
		StartDate =	m_MinDate
	End If
	
	Dim StartIndex As Int = 0
	
	If m_ListMode = "Paging" Then
	
		Dim FirstDay As Long = GetFirstDayOfWeek2(StartDate,m_FirstDayOfWeek)
	
		Dim p2 As Period
		p2.Initialize
		p2.Days = -7
	
		Dim LastStartDay As Long = DateUtils.AddPeriod(FirstDay,p2)'FirstDay - (DateTime.TicksPerDay*7)
	
		Dim WeekCount As Int
	
		If m_MaxDate = 0 Then
			WeekCount = NumberOfWeeksBetween(StartDate,DateUtils.SetDate(DateTime.GetYear(m_StartDate)+YearGap,12,31))
		Else
			Dim WeeksBetween As Int = NumberOfWeeksBetween(FirstDay,GetFirstDayOfWeek2(m_MaxDate,m_FirstDayOfWeek)+DateTime.TicksPerDay*4)
			WeekCount = Max(IIf(WeeksBetween = 0,WeeksBetween +1,WeeksBetween),1)
		End If
	
	
		Dim StartDateFirstDay As Long = GetFirstDayOfWeek2(m_StartDate,m_FirstDayOfWeek)
	
		For i = 0 To WeekCount -1
	
			Dim p As Period
			p.Initialize
			p.Days = 7
			'Dim CurrentWeek As Long = LastStartDay + (DateTime.TicksPerDay*7) 'FirstDay + (DateTime.TicksPerDay*7)*i
			Dim CurrentWeek As Long = DateUtils.AddPeriod(LastStartDay,p) 'FirstDay + (DateTime.TicksPerDay*7)*i
			LastStartDay = CurrentWeek
	
			Dim xpnl_Background As B4XView = xui.CreatePanel("")
			xpnl_Background.Color = g_BodyProperties.BodyColor
			xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ListBackground.Width,xpnl_ListBackground.Height)
		
'		Log(DateUtils.TicksToString(CurrentWeek))
'		Log(DateUtils.TicksToString(StartDateFirstDay))
		
			If DateUtils.IsSameDay(CurrentWeek,StartDateFirstDay) Then
				StartIndex = Max(0,i)
			End If
		
			xASVP_Main.AddPage(xpnl_Background,CurrentWeek)
	
		Next

	Else
		
		Dim DayCount As Int
	
		If m_MaxDate = 0 Then
			DayCount = DateUtils.PeriodBetweenInDays(StartDate,DateUtils.SetDate(DateTime.GetYear(m_StartDate)+YearGap,12,31)).Days
		Else
			DayCount = Max(1,DateUtils.PeriodBetweenInDays(StartDate,m_MaxDate).Days) +1
		End If
		
		Dim LastStartDay As Long = StartDate
		
		For i = 0 To DayCount -1
			
			Dim p As Period
			p.Initialize
			p.Days = 1
			
			Dim CurrentWeek As Long = IIf(i = 0,LastStartDay, DateUtils.AddPeriod(LastStartDay,p))
			LastStartDay = CurrentWeek
			
			Dim xpnl_Background As B4XView = xui.CreatePanel("")
			xpnl_Background.Color = g_BodyProperties.BodyColor
			xpnl_Background.SetLayoutAnimated(0,0,0,mBase.Width/7,mBase.Height)
			
			If DateUtils.IsSameDay(CurrentWeek,m_StartDate) Then
				StartIndex = Max(0,i)
				StartIndex = Max(0,StartIndex - DateTime.GetDayOfWeek(CurrentWeek) +1)
				StartIndex = Max(0,IIf(StartIndex > DayCount,StartIndex -1,StartIndex))
			End If
		
			xclv_Main.Add(xpnl_Background,CurrentWeek)
		Next

	End If
	
	#If B4A
	'Sleep(250)
	#Else
	Sleep(0)
	#End If
	If m_ListMode = "Paging" Then

#If B4A
		Do While xASVP_Main.CustomListView.FirstVisibleIndex = 0 And xASVP_Main.Size > 0 And StartIndex > 0
			Sleep(0)
			If xASVP_Main.Size > 0 Then	xASVP_Main.CurrentIndex2 = StartIndex
		Loop
		Sleep(0)
#End If
		If xASVP_Main.Size > 0 Then	xASVP_Main.CurrentIndex2 = StartIndex
		Sleep(0)
		xASVP_Main.Commit
	Else
		#If B4I
		Sleep(250)
		If xclv_Main.Size > 0 Then
			xclv_Main.JumpToItem(StartIndex)
		End If
			#Else if B4A
			#If Debug
		Sleep(500)
		#Else
		Sleep(250)
		#End If
		xclv_Main.sv.ScrollViewOffsetX = xclv_Main.GetRawListItem(StartIndex).Offset
		
		#End If
	
	End If
	xpnl_LoadingPanel.SetVisibleAnimated(250,False)
	Sleep(0)
	m_isReady = True
End Sub

Private Sub AddWeek(Parent As B4XView,CurrentDate As Long)
	
	Parent.Color = g_BodyProperties.BodyColor
	Dim BlockWidth As Float = IIf(m_ListMode = "Paging",Parent.Width/7,Parent.Width)
	
	Dim FirstDay As Long = GetFirstDayOfWeek2(CurrentDate,m_FirstDayOfWeek)
	
	'Dim CurrenMonth As Int = DateTime.GetMonth(CurrentDate)
	
	Dim Looper As Int
	If m_ListMode = "Paging" Then
		Looper = 9
	Else
		Looper = 2
	End If
	
	For i = 1 To Looper -1
		
		Dim CurrentDay As Long
		
		If m_ListMode = "Paging" Then
			CurrentDay = FirstDay + DateTime.TicksPerDay*(i-1)
		Else
			CurrentDay = CurrentDate
		End If
		
		
		Dim xpnl_Date As B4XView = xui.CreatePanel("xpnl_WeekDay")
		xpnl_Date.Tag = CurrentDay
		xpnl_Date.Color = xui.Color_Transparent
		If m_ListMode = "Paging" Then
			Parent.AddView(xpnl_Date,BlockWidth*(i-1),0,BlockWidth,Parent.Height)
		Else
			Parent.AddView(xpnl_Date,0,0,BlockWidth,Parent.Height)
		End If
		
		
		Dim xlbl_Date As B4XView = CreateLabel("")
		
		xlbl_Date.Font = g_BodyProperties.DateTextFont
		If DateUtils.IsSameDay(m_SelectedDate,CurrentDay) Then
			xlbl_Date.TextColor = g_SelectedDayProperties.DateTextColor
		Else
			xlbl_Date.TextColor = g_BodyProperties.DateTextColor
		End If
		xlbl_Date.SetTextAlignment("CENTER","CENTER")
		xlbl_Date.Text = DateTime.GetDayOfMonth(CurrentDay)
		xlbl_Date.Tag = "xlbl_Date"
		'xlbl_Date.Color = xui.Color_Red
		
		xpnl_Date.AddView(xlbl_Date,0,0,BlockWidth,Parent.Height)

		Dim xlbl_Month As B4XView = CreateLabel("")
		xpnl_Date.AddView(xlbl_Month,0,0,BlockWidth,30dip)
		xlbl_Month.Font = g_BodyProperties.MonthTextFont
		If DateUtils.IsSameDay(m_SelectedDate,CurrentDay) Then
			xlbl_Month.TextColor = g_SelectedDayProperties.MonthTextColor
		Else
			xlbl_Month.TextColor = g_BodyProperties.MonthTextColor
		End If
		xlbl_Month.SetTextAlignment("CENTER","CENTER")
		xlbl_Month.Text = GetMonthNameByIndex(DateTime.GetMonth(CurrentDay))
		xlbl_Month.Tag = "xlbl_Month"

		Dim xlbl_WeekDay As B4XView = CreateLabel("")
		xpnl_Date.AddView(xlbl_WeekDay,0,xpnl_Date.Height - 30dip,BlockWidth,30dip)
		xlbl_WeekDay.Font = g_BodyProperties.WeekDayTextFont
		If DateUtils.IsSameDay(m_SelectedDate,CurrentDay) Then
			xlbl_WeekDay.TextColor = g_SelectedDayProperties.WeekDayTextColor
		Else
			xlbl_WeekDay.TextColor = g_BodyProperties.WeekDayTextColor
		End If
		xlbl_WeekDay.SetTextAlignment("CENTER","CENTER")
		xlbl_WeekDay.Text = GetWeekNameByIndex(DateTime.GetDayOfWeek(CurrentDay))
		xlbl_WeekDay.Tag = "xlbl_WeekDay"
		
		Dim xpnl_CurrentDay As B4XView = xui.CreatePanel("")
		xpnl_CurrentDay.SetColorAndBorder(g_BodyProperties.CurrentDateColor,0,0,g_SelectedDayProperties.CornerRadius)
		xpnl_Date.AddView(xpnl_CurrentDay,0,0,xpnl_Date.Width,xpnl_Date.Height)
		xpnl_CurrentDay.Tag = "xpnl_CurrentDay"
		xpnl_CurrentDay.SendToBack

		CustomDrawDayIntern(CurrentDay,xpnl_Date)
		
		If DateUtils.IsSameDay(DateTime.Now,CurrentDay) = False Then xpnl_CurrentDay.Visible = False
		If DateUtils.IsSameDay(m_SelectedDate,CurrentDay) Then WeekDayClick(xpnl_Date,False)
		
	Next
	
End Sub

'Public Sub Refresh
'	If m_ListMode = "Paging" Then
'		'ResizeGrid
'		xASVP_Main.ResetLazyLoadingPanels
'		xASVP_Main.ResetLazyloadingIndex
'		Sleep(0)
'		xASVP_Main.Commit
'	Else
'		xclv_Main.Clear
'		xpnl_LoadingPanel.SetVisibleAnimated(0,True)
'		Sleep(0)
'		AddWeeks
'	End If
'End Sub
'Rebuilds the visible items
Public Sub Refresh
	If m_ListMode = "Paging" Then
		For i = 0 To xASVP_Main.Size -1
			If xASVP_Main.GetPanel(i).NumberOfViews > 0 Then
				xASVP_Main.GetPanel(i).RemoveAllViews
				AddWeek(xASVP_Main.GetPanel(i),xASVP_Main.GetValue(i))
			End If
		Next
	Else
		For i = 0 To xclv_Main.Size -1
			If xclv_Main.GetPanel(i).NumberOfViews > 0 Then
				xclv_Main.GetPanel(i).RemoveAllViews
				AddWeek(xclv_Main.GetPanel(i),xclv_Main.GetValue(i))
			End If
		Next
	End If
End Sub

Public Sub Scroll2Date(Date As Long)
	If (m_MaxDate > 0 And DateUtils.SetDate(DateTime.GetYear(Date),DateTime.GetMonth(Date),DateTime.GetDayOfMonth(Date)) > DateUtils.SetDate(DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),DateTime.GetDayOfMonth(m_MaxDate))) Or (m_MinDate > 0 And DateUtils.SetDate(DateTime.GetYear(Date),DateTime.GetMonth(Date),DateTime.GetDayOfMonth(Date)) < DateUtils.SetDate(DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate),DateTime.GetDayOfMonth(m_MinDate))) Then Return
	Dim ScrollIndex As Int = -1
	If m_ListMode = "Paging" Then
		For i = 0 To xASVP_Main.Size -1
			Dim StartDate As Long = xASVP_Main.GetValue(i)
		
			If DateUtils.IsSameDay(GetFirstDayOfWeek2(Date,m_FirstDayOfWeek),GetFirstDayOfWeek2(StartDate,m_FirstDayOfWeek)) Then
				ScrollIndex = i
			End If
		
		Next
	End If
	
	If m_ListMode = "Paging" Then
	
		If ScrollIndex <> -1 Then
			xASVP_Main.CurrentIndex = ScrollIndex
		Else
			m_StartDate = Date
			xASVP_Main.Clear
			AddWeeks
		End If
	Else
		
		If ScrollIndex <> -1 Then
			xclv_Main.ScrollToItem(ScrollIndex)
		Else
			m_StartDate = Date
			xclv_Main.Clear
			AddWeeks
		End If
	End If
End Sub
'Clears the DatePicker and builds the DatePicker new
Public Sub Rebuild
	
	Do While m_isReady = False
		Sleep(0)
	Loop
	
	If m_ListMode = "Paging" Then
		xASVP_Main.Clear
	Else
		xclv_Main.Clear
	End If
	Sleep(0)
	AddWeeks
End Sub

Public Sub CustomDrawDay(Date As Long) As ASDatePickerTimeline_CustomDrawDay
	
	Dim Views As ASDatePickerTimeline_CustomDrawDay
	Views.Initialize
	
	Dim BackgroundPanel As B4XView
	
	Dim TargetDate As Long = GetFirstDayOfWeek2(Date,m_FirstDayOfWeek)
	
	If m_ListMode = "Paging" Then
	
		For i = 0 To xASVP_Main.Size -1
			Dim StartDate As Long = xASVP_Main.GetValue(i)
		
			If DateUtils.IsSameDay(TargetDate,GetFirstDayOfWeek2(StartDate,m_FirstDayOfWeek)) Then
			
				If xASVP_Main.GetPanel(i).NumberOfViews > 0 Then
					For y = 0 To 7 -1
				
						If DateUtils.IsSameDay(TargetDate + (DateTime.TicksPerDay*y),Date) Then
							'Log("found")
								
							BackgroundPanel = xASVP_Main.GetPanel(i).GetView(y)
				
							Exit
				
						End If
				
			
				
					Next
				
				Else
					Exit
				End If
					
			End If
		
		Next
	
	Else
		
		For i = 0 To xclv_Main.Size -1
					
			Dim StartDate As Long = xclv_Main.GetValue(i)
		
			If DateUtils.IsSameDay(TargetDate,GetFirstDayOfWeek2(StartDate,m_FirstDayOfWeek)) Then
			
				If xclv_Main.GetPanel(i).NumberOfViews > 0 Then
			
					For y = 0 To 7 -1
				
						If DateUtils.IsSameDay(TargetDate + (DateTime.TicksPerDay*y),Date) Then
							'Log("found")
								
							BackgroundPanel = xclv_Main.GetPanel(i).GetView(y)
				
							Exit
				
						End If
				
					Next
					
				Else
					Exit
				End If
					
			End If
			
		Next
		
	End If
	
	If BackgroundPanel.IsInitialized = True Then
		Views.BackgroundPanel = BackgroundPanel
		
		For Each View As B4XView In BackgroundPanel.GetAllViewsRecursive
			
			If "xlbl_Date" = View.Tag Then
				Views.xlbl_Date = View
			else If "xlbl_Month" = View.Tag Then
				Views.xlbl_Month = View
			else If "xlbl_WeekDay" = View.Tag Then
				Views.xlbl_WeekDay = View
			else If "xpnl_CurrentDay" = View.Tag Then
				Views.xpnl_CurrentDay = View
			End If
			
		Next
	End If
	Return Views
	
End Sub

#Region Properties

Public Sub getLoadingPanel As B4XView
	Return xpnl_LoadingPanel
End Sub

'If False then click events and scroll (only on paging mode) is disabled 
Public Sub getEnabled As Boolean
	Return m_Enabled
End Sub

Public Sub setEnabled(Enable As Boolean)
	m_Enabled = Enable
	If m_ListMode = "Paging" Then
		xASVP_Main.Scroll = Enable
	End If
End Sub

'Call Refresh if you change something
Public Sub getSelectedDate As Long
	Return m_SelectedDate
End Sub

Public Sub setSelectedDate(Date As Long)
	If (m_MaxDate > 0 And DateUtils.SetDate(DateTime.GetYear(Date),DateTime.GetMonth(Date),DateTime.GetDayOfMonth(Date)) > DateUtils.SetDate(DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),DateTime.GetDayOfMonth(m_MaxDate))) Or (m_MinDate > 0 And DateUtils.SetDate(DateTime.GetYear(Date),DateTime.GetMonth(Date),DateTime.GetDayOfMonth(Date)) < DateUtils.SetDate(DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate),DateTime.GetDayOfMonth(m_MinDate))) Then Return
	m_SelectedDate = Date
End Sub

Public Sub getSelectedDayProperties As ASDatePickerTimeline_SelectedDayProperties
	Return g_SelectedDayProperties
End Sub
'Call Refresh if you change something
Public Sub getBodyProperties As ASDatePickerTimeline_BodyProperties
	Return g_BodyProperties
End Sub
'Call Refresh if you change something
Public Sub getMonthNameShort As ASDatePickerTimeline_MonthNameShort
	Return g_MonthNameShort
End Sub
Public Sub setMonthNameShort(MonthNameShort As ASDatePickerTimeline_MonthNameShort)
	g_MonthNameShort = MonthNameShort
End Sub
'Call Refresh if you change something
Public Sub getWeekNameShort As ASDatePickerTimeline_WeekNameShort
	Return g_WeekNameShort
End Sub
Public Sub setWeekNameShort(WeekNameShort As ASDatePickerTimeline_WeekNameShort)
	g_WeekNameShort = WeekNameShort
End Sub
Public Sub getStartDate As Long
	Return m_StartDate
End Sub

Public Sub setStartDate(StartDate As Long)
	If (m_MaxDate > 0 And DateUtils.SetDate(DateTime.GetYear(StartDate),DateTime.GetMonth(StartDate),DateTime.GetDayOfMonth(StartDate)) > DateUtils.SetDate(DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),DateTime.GetDayOfMonth(m_MaxDate))) Or (m_MinDate > 0 And DateUtils.SetDate(DateTime.GetYear(StartDate),DateTime.GetMonth(StartDate),DateTime.GetDayOfMonth(StartDate)) < DateUtils.SetDate(DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate),DateTime.GetDayOfMonth(m_MinDate))) Then Return
	m_StartDate = StartDate
End Sub

Public Sub NextWeek
	If m_ListMode = "Paging" Then
		xASVP_Main.NextPage
	Else
		xclv_Main.ScrollToItem(xclv_Main.FirstVisibleIndex +1)
	End If
End Sub

Public Sub PreviousWeek
	If m_ListMode = "Paging" Then
		xASVP_Main.PreviousPage
	Else
		xclv_Main.ScrollToItem(xclv_Main.FirstVisibleIndex -1)
	End If
End Sub
'Will restrict date navigations features of forward, and also cannot swipe the control using touch gesture beyond the max date range
'You need to call Rebuild
'If you set this at app start, it is better to set the CreateMode in the designer to Manaul and then calling CreateDatePicker after you set the Max oder Min date
Public Sub setMaxDate(MaxDate As Long)
	m_MaxDate = MaxDate
End Sub
Public Sub getMaxDate As Long
	Return m_MaxDate
End Sub
'Will restrict date navigations features of backward, also cannot swipe the control using touch gesture beyond the min date range
'You need to call Rebuild
'If you set this at app start, it is better to set the CreateMode in the designer to Manaul and then calling CreateDatePicker after you set the Max oder Min date
Public Sub setMinDate(MinDate As Long)
	m_MinDate = MinDate
End Sub
Public Sub getMinDate As Long
	Return m_MinDate
End Sub

'1-7
'Friday = 1
'Thursday = 2
'Wednesday = 3
'Tuesday = 4
'Monday = 5
'Sunday = 6
'Saturday = 7
Public Sub setFirstDayOfWeek(number As Int)
	m_FirstDayOfWeek = number
End Sub

#End Region

#Region ViewEvents
'https://www.b4x.com/android/forum/threads/b4x-xui-customlistview-lazy-loading-virtualization.87930/#content
Private Sub xclv_main_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	PageChanged(xclv_Main.GetValue(xclv_Main.FirstVisibleIndex+1),xclv_Main.GetValue(xclv_Main.LastVisibleIndex-1))
	Dim ExtraSize As Int = 10
	For i = 0 To xclv_Main.Size - 1
		Dim p As B4XView = xclv_Main.GetPanel(i)
		If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				AddWeek(p,xclv_Main.GetValue(i))
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews
			End If
		End If
	Next
End Sub

Private Sub xASVP_Main_LazyLoadingAddContent(Parent As B4XView, Value As Object)
	AddWeek(Parent,Value)
End Sub

Private Sub xASVP_Main_PageChanged(Index As Int)
	PageChanged(xASVP_Main.GetValue(xASVP_Main.CurrentIndex),xASVP_Main.GetValue(xASVP_Main.CurrentIndex)+DateTime.TicksPerDay*6)
End Sub

#If B4J
Private Sub xpnl_WeekDay_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xpnl_WeekDay_Click
#End if
	WeekDayClick(Sender,True)
End Sub

Private Sub WeekDayClick(xpnl_WeekDay As B4XView,WithEvent As Boolean)
	If m_Enabled = False Then Return
	Dim CurrentDay As Long = xpnl_WeekDay.Tag
	If (m_MaxDate > 0 And DateUtils.SetDate(DateTime.GetYear(CurrentDay),DateTime.GetMonth(CurrentDay),DateTime.GetDayOfMonth(CurrentDay)) > DateUtils.SetDate(DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),DateTime.GetDayOfMonth(m_MaxDate))) Or (m_MinDate > 0 And DateUtils.SetDate(DateTime.GetYear(CurrentDay),DateTime.GetMonth(CurrentDay),DateTime.GetDayOfMonth(CurrentDay)) < DateUtils.SetDate(DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate),DateTime.GetDayOfMonth(m_MinDate))) Then Return
	
	Dim LastParent As B4XView
	If xpnl_SelectedPanel.IsInitialized = True Then
		LastParent = xpnl_SelectedPanel.Parent
		
		If LastParent.IsInitialized Then
			For Each View As B4XView In LastParent.GetAllViewsRecursive
		
				Select View.Tag.As(String)
					Case "xlbl_WeekDay"
						View.TextColor = g_BodyProperties.WeekDayTextColor
					Case "xlbl_Month"
						View.TextColor = g_BodyProperties.MonthTextColor
					Case "xlbl_Date"
						View.TextColor = g_BodyProperties.DateTextColor
				End Select
		
			Next
		End If
		
		xpnl_SelectedPanel.RemoveViewFromParent
	End If
	xpnl_SelectedPanel = xui.CreatePanel("")
	xpnl_SelectedPanel.SetColorAndBorder(g_SelectedDayProperties.Color,0,0,g_SelectedDayProperties.CornerRadius)
	xpnl_WeekDay.AddView(xpnl_SelectedPanel,0,0,xpnl_WeekDay.Width,xpnl_WeekDay.Height)
	xpnl_SelectedPanel.SendToBack
	For Each View As B4XView In xpnl_WeekDay.GetAllViewsRecursive
		
		Select View.Tag.As(String)
			Case "xpnl_CurrentDay"
				View.SendToBack
			Case "xlbl_WeekDay"
				View.TextColor = g_SelectedDayProperties.WeekDayTextColor
			Case "xlbl_Month"
				View.TextColor = g_SelectedDayProperties.MonthTextColor
			Case "xlbl_Date"
				View.TextColor = g_SelectedDayProperties.DateTextColor
		End Select
		
	Next
	
	m_SelectedDate = xpnl_WeekDay.Tag
	If WithEvent = True Then SelectedDateChanged(xpnl_WeekDay.Tag)
	
	If LastParent.IsInitialized Then CustomDrawDayIntern(LastParent.Tag,LastParent)
	CustomDrawDayIntern(CurrentDay,xpnl_WeekDay)
End Sub

#End Region

#Region Events

Private Sub SelectedDateChanged(date As Long)
	If xui.SubExists(mCallBack, mEventName & "_SelectedDateChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_SelectedDateChanged",date)
	End If
End Sub

Private Sub PageChanged(FirstDate As Long,LastDate As Long)
	If xui.SubExists(mCallBack, mEventName & "_PageChanged", 2) Then
		CallSub3(mCallBack, mEventName & "_PageChanged",FirstDate,LastDate)
	End If
End Sub

Private Sub CustomDrawDayIntern(Date As Long,BackgroundPanel As B4XView)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawDay", 2) Then
		
		Dim m_CustomDrawDay As ASDatePickerTimeline_CustomDrawDay
		m_CustomDrawDay.Initialize
		m_CustomDrawDay.BackgroundPanel = BackgroundPanel
		
		For Each View As B4XView In BackgroundPanel.GetAllViewsRecursive
			
			If "xlbl_Date" = View.Tag Then
				m_CustomDrawDay.xlbl_Date = View
			else If "xlbl_Month" = View.Tag Then
				m_CustomDrawDay.xlbl_Month = View
			else If "xlbl_WeekDay" = View.Tag Then
				m_CustomDrawDay.xlbl_WeekDay = View
			else If "xpnl_CurrentDay" = View.Tag Then
				m_CustomDrawDay.xpnl_CurrentDay = View
			End If
			
		Next
		
		CallSub3(mCallBack, mEventName & "_CustomDrawDay",Date,m_CustomDrawDay)
	End If
End Sub

#End Region

#Region Functions
'1 = Sunday
Private Sub GetWeekNameByIndex(Index As Int) As String
	If Index = 1 Then
		Return g_WeekNameShort.Sunday
	else If Index = 2 Then
		Return g_WeekNameShort.Monday
	else If Index = 3 Then
		Return g_WeekNameShort.Tuesday
	else If Index = 4 Then
		Return g_WeekNameShort.Wednesday
	else If Index = 5 Then
		Return g_WeekNameShort.Thursday
	else If Index = 6 Then
		Return g_WeekNameShort.Friday
	Else
		Return g_WeekNameShort.Saturday
	End If
End Sub
'1 = January
Private Sub GetMonthNameByIndex(Index As Int) As String
	If Index = 1 Then
		Return g_MonthNameShort.January
	else If Index = 2 Then
		Return g_MonthNameShort.February
	else If Index = 3 Then
		Return g_MonthNameShort.March
	else If Index = 4 Then
		Return g_MonthNameShort.April
	else If Index = 5 Then
		Return g_MonthNameShort.May
	else If Index = 6 Then
		Return g_MonthNameShort.June
	else If Index = 7 Then
		Return g_MonthNameShort.July
	else If Index = 8 Then
		Return g_MonthNameShort.August
	else If Index = 9 Then
		Return g_MonthNameShort.September
	else If Index = 10 Then
		Return g_MonthNameShort.October
	else If Index = 11 Then
		Return g_MonthNameShort.November
	Else
		Return g_MonthNameShort.December
	End If
End Sub
'FirstDayOfWeek:
'Friday = 1
'Thursday = 2
'Wednesday = 3
'Tuesday = 4
'Monday = 5
'Sunday = 6
'Saturday = 7
Private Sub GetFirstDayOfWeek2(Ticks As Long,FirstDayOfWeek As Int) As Long
	Dim p As Period
	p.Days = -((DateTime.GetDayOfWeek(Ticks)+FirstDayOfWeek) Mod 7) 'change to 5 to start the week from Monday
	Return DateUtils.AddPeriod(Ticks, p)
End Sub

Private Sub NumberOfWeeksBetween(StartDate As Long,EndDate As Long) As Int
	Return Round(DateUtils.PeriodBetweenInDays(StartDate,EndDate).Days / 7)
End Sub

'Private Sub GetARGB(Color As Int) As Int()
'	Dim res(4) As Int
'	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
'	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
'	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
'	res(3) = Bit.And(Color, 0xff)
'	Return res
'End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

#End Region

#Region Types

Public Sub CreateASDatePickerTimeline_MonthNameShort (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASDatePickerTimeline_MonthNameShort
	Dim t1 As ASDatePickerTimeline_MonthNameShort
	t1.Initialize
	t1.January = January
	t1.February = February
	t1.March = March
	t1.April = April
	t1.May = May
	t1.June = June
	t1.July = July
	t1.August = August
	t1.September = September
	t1.October = October
	t1.November = November
	t1.December = December
	Return t1
End Sub

Public Sub CreateASDatePickerTimeline_WeekNameShort (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASDatePickerTimeline_WeekNameShort
	Dim t1 As ASDatePickerTimeline_WeekNameShort
	t1.Initialize
	t1.Monday = Monday
	t1.Tuesday = Tuesday
	t1.Wednesday = Wednesday
	t1.Thursday = Thursday
	t1.Friday = Friday
	t1.Saturday = Saturday
	t1.Sunday = Sunday
	Return t1
End Sub

#End Region







