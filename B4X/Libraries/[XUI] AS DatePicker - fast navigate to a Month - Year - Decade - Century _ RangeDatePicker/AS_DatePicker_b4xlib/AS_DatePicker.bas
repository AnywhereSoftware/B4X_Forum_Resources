B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
'AS_DatePicker
'Author: Alexander Stolte
'Version: V1.00

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-Add Scroll2Date - Scrolls to the date
	-B4J Resize BugFixes
V1.02
	-BugFixes
	-Add designer property InactiveDaysVisible - Displays the days that are not in the current month
		-Default: False
	-Add Type ASDatePicker_BodyProperties
		-Font of the Text
		-TextColor of the Text
	-The month view now has 6 lines instead of 5
		-It may be that if InactiveDaysVisible = False that an empty line is seen
V1.03
	-B4J Only - Add Designer Property MouseHoverFeedback
		-Default: True
V1.04
	-Add Refresh
V1.05
	-Added a border to the current month, year, or century in the quick navigation
V1.06
	-Add get and set SelectedDate
	-Add Event CustomDrawDay
	-Add Type ASDatePicker_CustomDrawDay
V1.07
	-BugFix
V1.08
	-Add get and set BodyProperties
	-Add get and set HeaderProperties
	-Function "Refresh" is now even better
		-No visual flickering
		-Changes are instant
V1.09
	-Add get and set MaxDate - Will restrict date navigations features of forward, and also cannot swipe the control using touch gesture beyond the max date range
	-Add get and set MinDate - Will restrict date navigations features of backward, and also cannot swipe the control using touch gesture beyond the max date range
	-Add Rebuild - Clears the DatePicker and builds the DatePicker new
V1.10
	-Add Designer property SelectMode - 
		-Default: Date
V1.11
	-BugFixes
V1.12
	-Add RefreshHeader - Applies the header properties if any have been changed
	-New ASDatePicker_HeaderProperties properties
V1.13
	-Add ShowWeekNumbers - Shows the week number for each week
	-Add Type ASDatePicker_WeekNumberProperties
V1.14
	-Add Designer Property ShowGridLines
	-Add Designer Property GridLineColor
V1.15
	-Add get and set MonthNameShort
	-Add get and set WeekNameShort
V1.16
	-BugFixes
V1.17
	-Add "Range" to SelectMode
	-Add Event SelectedDateRangeChanged
	-Debug Mode optimizations
	-Add get SelectedStartDate and SelectedEndDate
V1.18
	-Add compatibility for AS_ViewPager Version 2.0
V1.19
	-BugFixes
	-Add get and set WeekNameProperties
V1.20
	-BugFixes
V1.21
	-BugFixes
	-Add ArrowsVisible to Type HeaderProperties
V1.22
	-Big performance improvements
		-The view should now load much faster
V1.23
	-Add Event PageChanged
V1.24
	-Add get CurrentView
	-Add Event CustomDrawHeader
	-BugFixes
V1.25
	-Add "Height" to ASDatePicker_WeekNameProperties
		-Default: 20dip
	-Add "CurrentAndSelectedDayHeight" to ASDatePicker_BodyProperties
		-Default: 30dip
	-Add "SelectedTextColor" to ASDatePicker_BodyProperties
		-Default: White
V1.26
	-Important crash fix
V1.27
	-BugFixes and Improvements
	-Add Themes - You can now switch to Light or Dark mode
		-Add set Theme
		-Add get Theme_Dark
		-Add get Theme_Light
	-Add Designer Property ThemeChangeTransition
		-Default: Fade
V1.28
	-Add ClearSelections - Deselect the selections
		-Updated the description text of the set Selection properties
V1.29
	-BugFix B4J - The CustomDrawDay event is now also triggered when leaving the mouse at a day, e.g. if you have colored the text color day of month
V1.30
	-BugFixes
V1.31
	-BugFix for B4J
V1.32
	-New MaxViewLevel Desinger Property - Defines the highest level of calendar views the user can navigate to when clicking the header (e.g., from month to year to decade).
		-Default: CenturyView
#End If

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: Fade, List: None|Fade
#DesignerProperty: Key: SelectMode, DisplayName: Select Mode, FieldType: String, DefaultValue: Date, List: Date|Month|Range
#DesignerProperty: Key: HeaderColor, DisplayName: Header Color, FieldType: Color, DefaultValue: 0xFF131416, Description: Background Color of the week days
#DesignerProperty: Key: BodyColor, DisplayName: Body Color, FieldType: Color, DefaultValue: 0xFF202125

#DesignerProperty: Key: CurrentDateColor, DisplayName: Current Date Color, FieldType: Color, DefaultValue: 0x502D8879
#DesignerProperty: Key: SelectedDateColor, DisplayName: Selected Date Color, FieldType: Color, DefaultValue: 0xFF2D8879

#DesignerProperty: Key: ShowWeekNumbers, DisplayName: Show Week Numbers, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: FirstDayOfWeek, DisplayName: First Day of Week, FieldType: String, DefaultValue: Monday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
#DesignerProperty: Key: InactiveDaysVisible, DisplayName: Inactive Days Visible, FieldType: Boolean, DefaultValue: False, Description: Displays the days that are not in the current month
#DesignerProperty: Key: MouseHoverFeedback, DisplayName: Mouse Hover Feedback, FieldType: Boolean, DefaultValue: True, Description: B4J only

#DesignerProperty: Key: ShowGridLines, DisplayName: ShowGridLines, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: GridLineColor, DisplayName: GridLineColor, FieldType: Color, DefaultValue: 0x50FFFFFF
#DesignerProperty: Key: MaxViewLevel, DisplayName: MaxViewLevel, FieldType: String, DefaultValue: CenturyView, List: MonthView|YearView|DecadeView|CenturyView , Description: Defines the highest level of calendar views the user can navigate to when clicking the header (from month to year to decade)

#Event: SelectedDateChanged(Date As Long)
#Event: SelectedDateRangeChanged(StartDate As Long, EndDate As Long)
#Event: CustomDrawDay (Date As Long, Views As ASDatePicker_CustomDrawDay)
#Event: PageChanged
#Event: CustomDrawHeader(Date As Long,Views As ASDatePicker_CustomDrawHeader)

Sub Class_Globals
	
	Type ASDatePicker_MonthNameShort(January As String,February As String,March As String,April As String,May As String,June As String, July As String,August As String, September As String,October As String,November As String, December As String)
	Type ASDatePicker_WeekNameShort(Monday As String,Tuesday As String,Wednesday As String,Thursday As String,Friday As String,Saturday As String,Sunday As String)
	
	Type ASDatePicker_HeaderProperties(Height As Float,xFont As B4XFont,TextColor As Int,ButtonIconSize As Float,ArrowsVisible As Boolean)
	Type ASDatePicker_BodyProperties(xFont As B4XFont,TextColor As Int,SelectedTextColor As Int,CurrentAndSelectedDayHeight As Float)
	Type ASDatePicker_CustomDrawDay(BackgroundPanel As B4XView,xlbl_Date As B4XView)
	Type ASDatePicker_CustomDrawHeader(BackgroundPanel As B4XView,xlbl_Text As B4XView,xlbl_ArrowLeft As B4XView,xlbl_ArrowRight As B4XView)
	Type ASDatePicker_WeekNumberProperties(Width As Float,Color As Int,xFont As B4XFont,TextColor As Int,Text As String)
	Type ASDatePicker_WeekNameProperties(Color As Int,xFont As B4XFont,TextColor As Int,Height As Float)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private m_isReady As Boolean = False
	
	Private g_HeaderProperties As ASDatePicker_HeaderProperties
	Private g_BodyProperties As ASDatePicker_BodyProperties
	
	Private g_MonthNameShort As ASDatePicker_MonthNameShort
	Private g_WeekNameShort As ASDatePicker_WeekNameShort
	Private g_WeekNumberProperties As ASDatePicker_WeekNumberProperties
	Private g_WeekNameProperties As ASDatePicker_WeekNameProperties
	
	Private xASVP_Main As ASViewPager
	
	Private xpnl_LoadingPanel As B4XView
	Private xpnl_Header As B4XView
	Private xpnl_ViewPager As B4XView
	Private xpnl_SelectedDate As B4XView
	Private xpnl_SelectedDate2 As B4XView
	#If B4J
	Private xpnl_HoverDate As B4XView
	#End If
	
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_CurrentDateColor As Int
	Private m_SelectedDateColor As Int
	Private m_MouseHoverFeedback As Boolean 'Ignore
	Private m_SelectedDate As Long
	Private m_SelectedDate2 As Long
	Private m_ShowWeekNumbers As Boolean
	Private m_FirstDayOfWeek As Int = 5 'Monday
	Private m_ShowGridLines As Boolean
	Private m_GridLineColor As Int
	Private m_ThemeChangeTransition As String
	Private m_MaxViewLevel As String
	
	Private m_CurrentView As String
	Private m_StartDate As Long
	Private m_InactiveDaysVisible As Boolean
	Private m_MinDate,m_MaxDate As Long
	Private m_SelectMode As String
	
	Private xiv_RefreshImage As B4XView
	
	Type AS_DatePicker_Theme(SelectedTextColor As Int,WeekNumberTextColor As Int,WeekNumberColor As Int,WeekNameColor As Int,WeekNameTextColor As Int,HeaderTextColor As Int,BodyTextColor As Int,GridLineColor As Int,SelectedDateColor As Int,CurrentDateColor As Int,HeaderColor As Int,BodyColor As Int)
	
End Sub

Public Sub setTheme(Theme As AS_DatePicker_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	
	m_BodyColor = Theme.BodyColor
	m_HeaderColor = Theme.HeaderColor
	m_CurrentDateColor = Theme.CurrentDateColor
	m_SelectedDateColor = Theme.SelectedDateColor
	m_GridLineColor = Theme.GridLineColor
	g_BodyProperties.TextColor = Theme.BodyTextColor
	g_HeaderProperties.TextColor = Theme.HeaderTextColor
	g_WeekNameProperties.Color = Theme.WeekNameColor
	g_WeekNameProperties.TextColor = Theme.WeekNameTextColor
	g_WeekNumberProperties.Color = Theme.WeekNumberColor
	g_WeekNumberProperties.TextColor = Theme.WeekNumberTextColor
	g_BodyProperties.SelectedTextColor = Theme.SelectedTextColor
	
	Sleep(0)
	
	xpnl_LoadingPanel.Color = m_BodyColor
	xASVP_Main.LoadingPanelColor = m_BodyColor
	xASVP_Main.Base.Color = m_BodyColor
	
	RefreshHeader
	Refresh
	
	Select m_ThemeChangeTransition
		Case "None"
			Sleep(0)
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			Sleep(250)
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select
	
End Sub

Public Sub getTheme_Dark As AS_DatePicker_Theme
	
	Dim Theme As AS_DatePicker_Theme
	Theme.Initialize
	Theme.BodyColor = 0xFF202125
	Theme.HeaderColor = 0xFF202125
	Theme.CurrentDateColor = 0x502D8879
	Theme.SelectedDateColor = 0xFF2D8879
	Theme.GridLineColor = xui.Color_ARGB(80,255,255,255)
	Theme.BodyTextColor = xui.Color_White
	Theme.SelectedTextColor = xui.Color_White
	Theme.HeaderTextColor = xui.Color_White
	Theme.WeekNameColor =  0xFF202125'xui.Color_ARGB(255,32, 33, 37)
	Theme.WeekNameTextColor = xui.Color_White
	Theme.WeekNumberColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.WeekNumberTextColor = xui.Color_White
	
	Return Theme
	
End Sub

Public Sub getTheme_Light As AS_DatePicker_Theme
	
	Dim Theme As AS_DatePicker_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_White
	Theme.HeaderColor = xui.Color_White
	Theme.CurrentDateColor = 0x502D8879
	Theme.SelectedDateColor = 0xFF2D8879
	Theme.GridLineColor = xui.Color_ARGB(80,0,0,0)
	Theme.BodyTextColor = xui.Color_Black
	Theme.SelectedTextColor = xui.Color_White
	Theme.HeaderTextColor = xui.Color_Black
	Theme.WeekNameColor = xui.Color_White'xui.Color_ARGB(255,235, 235, 235)
	Theme.WeekNameTextColor = xui.Color_Black
	Theme.WeekNumberColor = xui.Color_White
	Theme.WeekNumberTextColor = xui.Color_Black
	
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
	'm_SelectedDate = DateTime.Now
	
	xpnl_LoadingPanel = xui.CreatePanel("")
	xpnl_LoadingPanel.Visible = True
	xpnl_LoadingPanel.Color = m_BodyColor
	mBase.AddView(xpnl_LoadingPanel,0,0,mBase.Width,mBase.Height)
	
	xpnl_Header = xui.CreatePanel("")
	mBase.AddView(xpnl_Header,0,0,mBase.Width,g_HeaderProperties.Height)
	
	xpnl_ViewPager = xui.CreatePanel("")
	mBase.AddView(xpnl_ViewPager,0,g_HeaderProperties.Height,mBase.Width,mBase.Height - g_HeaderProperties.Height)
	
	ini_viewpager
	CreateHeader
	If m_SelectMode = "Date" Or m_SelectMode = "Range" Then
		m_CurrentView = getCurrentView_MonthView
		CreateMonthView
	else if m_SelectMode = "Month" Then
		m_CurrentView = getCurrentView_YearView
		CreateYearView
	End If
	
	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
	xpnl_LoadingPanel.SetVisibleAnimated(250,False)
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_CurrentView = getCurrentView_MonthView
	
	m_HeaderColor = xui.PaintOrColorToColor(Props.Get("HeaderColor"))
	m_BodyColor = xui.PaintOrColorToColor(Props.Get("BodyColor"))
	m_CurrentDateColor = xui.PaintOrColorToColor(Props.Get("CurrentDateColor"))
	m_SelectedDateColor = xui.PaintOrColorToColor(Props.Get("SelectedDateColor"))
	m_InactiveDaysVisible = Props.GetDefault("InactiveDaysVisible",False)
	m_MouseHoverFeedback = Props.GetDefault("MouseHoverFeedback",True)
	m_SelectMode = Props.GetDefault("SelectMode","Date")
	m_ShowWeekNumbers = Props.GetDefault("ShowWeekNumbers",False)
	m_ShowGridLines = Props.GetDefault("ShowGridLines",False)
	m_GridLineColor = xui.PaintOrColorToColor(Props.GetDefault("GridLineColor",0x50FFFFFF))
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition","Fade")
	m_MaxViewLevel = Props.GetDefault("MaxViewLevel","CenturyView")
	
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
	
	g_WeekNumberProperties = CreateASDatePicker_WeekNumberProperties(20dip,xui.Color_ARGB(255,32, 33, 37),xui.CreateDefaultFont(10),xui.Color_White,"")
	g_HeaderProperties = CreateASDatePicker_HeaderProperties(40dip,xui.CreateDefaultBoldFont(12),xui.Color_White,15,True)
	g_BodyProperties = CreateASDatePicker_BodyProperties(xui.CreateDefaultBoldFont(12),xui.Color_White,xui.Color_White,30dip)
	g_WeekNameProperties = CreateASDatePicker_WeekNameProperties(xui.Color_ARGB(255,32, 33, 37),xui.CreateDefaultFont(10),xui.Color_White,20dip)

	g_MonthNameShort = CreateASDatePicker_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")
	g_WeekNameShort = CreateASDatePicker_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")
	
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
	xASVP_Main.DesignerCreateView(xpnl_ViewPager,tmplbl,tmpmap)
	xASVP_Main.LoadingPanelColor = m_BodyColor
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xiv_RefreshImage.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_Header.SetLayoutAnimated(0,0,0,Width,g_HeaderProperties.Height)
	xpnl_ViewPager.SetLayoutAnimated(0,0,g_HeaderProperties.Height,Width,Height - g_HeaderProperties.Height)
	xASVP_Main.Base_Resize(Width,xpnl_ViewPager.Height)
	
	'Header
	xpnl_Header.GetView(0).SetLayoutAnimated(0,xpnl_Header.Height,0,mBase.Width - xpnl_Header.Height*2,xpnl_Header.Height)'xlbl_Header
	xpnl_Header.GetView(1).SetLayoutAnimated(0,0,0,xpnl_Header.Height,xpnl_Header.Height)'xlbl_ArrowLeft
	xpnl_Header.GetView(2).SetLayoutAnimated(0,xpnl_Header.Width - xpnl_Header.Height,0,xpnl_Header.Height,xpnl_Header.Height)'xlbl_ArrowRight
	
	xASVP_Main.ResetLazyLoadingPanels
	Sleep(0)
	xASVP_Main.ResetLazyloadingIndex
	xASVP_Main.Commit
End Sub

Private Sub CreateHeader
	
	xpnl_Header.Color = m_HeaderColor
	
	Dim xlbl_Header As B4XView = CreateLabel("xlbl_Header")
	xpnl_Header.AddView(xlbl_Header,xpnl_Header.Height,0,mBase.Width - xpnl_Header.Height*2,xpnl_Header.Height)
	
	Dim xlbl_ArrowLeft As B4XView = CreateLabel("xlbl_HeaderArrowLeft")
	xpnl_Header.AddView(xlbl_ArrowLeft,0,0,xpnl_Header.Height,xpnl_Header.Height)
	
	Dim xlbl_ArrowRight As B4XView = CreateLabel("xlbl_HeaderArrowRight")
	xpnl_Header.AddView(xlbl_ArrowRight,xpnl_Header.Width - xpnl_Header.Height,0,xpnl_Header.Height,xpnl_Header.Height)
	
	xlbl_ArrowLeft.Font = xui.CreateMaterialIcons(g_HeaderProperties.ButtonIconSize)
	xlbl_ArrowLeft.Text = Chr(0xE314)
	xlbl_ArrowLeft.TextColor = g_HeaderProperties.TextColor
	xlbl_ArrowLeft.SetTextAlignment("CENTER","CENTER")
	xlbl_ArrowLeft.Visible = g_HeaderProperties.ArrowsVisible
	
	xlbl_ArrowRight.Font = xui.CreateMaterialIcons(g_HeaderProperties.ButtonIconSize)
	xlbl_ArrowRight.Text = Chr(0xE315)
	xlbl_ArrowRight.TextColor = g_HeaderProperties.TextColor
	xlbl_ArrowRight.SetTextAlignment("CENTER","CENTER")
	xlbl_ArrowRight.Visible = g_HeaderProperties.ArrowsVisible
	
	xlbl_Header.Font = g_HeaderProperties.xFont
	xlbl_Header.Text = DateUtils.GetMonthName(m_StartDate) & " " & DateTime.GetYear(m_StartDate)
	xlbl_Header.TextColor = g_HeaderProperties.TextColor
	xlbl_Header.SetTextAlignment("CENTER","CENTER")
	
End Sub

Private Sub AddWeekName(xpnl_Background As B4XView,i As Int,Text As String)
	
	Dim BlockHeight As Float = g_WeekNameProperties.Height 'xpnl_ViewPager.Height/7
	Dim BlockWidth As Float = Floor(IIf(m_ShowWeekNumbers,(xpnl_ViewPager.Width - g_WeekNumberProperties.Width)/7,IIf(i = -1,g_WeekNumberProperties.Width, xpnl_ViewPager.Width/7)))
	
	Dim xlbl_WeekName As B4XView = CreateLabel("")
		
	xlbl_WeekName.SetTextAlignment("CENTER","CENTER")
	xlbl_WeekName.Text = Text
	If i = -1 Then
		xlbl_WeekName.Color = g_WeekNumberProperties.Color
		xlbl_WeekName.Font = g_WeekNumberProperties.xFont
		xlbl_WeekName.TextColor = g_WeekNumberProperties.TextColor
	Else
		xlbl_WeekName.Color = g_WeekNameProperties.Color
		xlbl_WeekName.Font = g_WeekNameProperties.xFont
		xlbl_WeekName.TextColor = g_WeekNameProperties.TextColor
	End If
		
	xpnl_Background.AddView(xlbl_WeekName,IIf(i = -1,0,IIf(m_ShowWeekNumbers,g_WeekNumberProperties.Width,0) + (BlockWidth*i)),0,IIf(i = -1,g_WeekNumberProperties.Width, BlockWidth),BlockHeight)
End Sub

Private Sub xASVP_Main_PageChanged2(NewIndex As Int, OldIndex As Int)
	
	If m_MinDate > 0 And m_MaxDate > 0 Then Return
	
	Dim Forward As Boolean = False
	Dim DoIt As Boolean = False
	
	If NewIndex <= OldIndex Then
		If NewIndex <= 2 Then
			DoIt = True
			Forward = False
		End If
	Else
		If NewIndex = xASVP_Main.Size -2 Then
			DoIt = True
			Forward = True
		End If
	End If
	
	If DoIt Then
		
		If m_CurrentView = getCurrentView_MonthView Then
			Dim xpnl_Background As B4XView = xui.CreatePanel("")
			xpnl_Background.Color = xui.Color_Transparent
			xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
	
			Dim p2 As Period
			p2.Initialize
			p2.Months = IIf(Forward,1,-1)
	
			Dim CurrentTime As Long = DateUtils.AddPeriod(xASVP_Main.GetValue(IIf(Forward,xASVP_Main.Size -1,0)),p2)
			Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
	
			If Forward Then
				If m_MaxDate > 0 And FirstDayOfMonth > DateUtils.SetDate(DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),1)  Then
					Return
				End If			
				xASVP_Main.AddPage(xpnl_Background,FirstDayOfMonth)
			Else
				If m_MinDate > 0 And FirstDayOfMonth < DateUtils.SetDate(DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate),1)  Then
					Return
				End If
				xASVP_Main.AddPageAt(0,xpnl_Background,FirstDayOfMonth)
			End If
			
		else If m_CurrentView = getCurrentView_YearView Then
			
			Dim xpnl_Background As B4XView = xui.CreatePanel("")
			xpnl_Background.Color = xui.Color_Transparent
			xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
	
			Dim p2 As Period
			p2.Initialize
			p2.Years = IIf(Forward,1,-1)
	
			Dim CurrentTime As Long = DateUtils.AddPeriod(xASVP_Main.GetValue(IIf(Forward,xASVP_Main.Size -1,0)),p2)
			'Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
	
			If Forward Then
				If m_MaxDate > 0 And DateTime.GetYear(CurrentTime) > DateTime.GetYear(m_MaxDate)  Then
					Return
				End If
				xASVP_Main.AddPage(xpnl_Background,CurrentTime)
			Else
				If m_MinDate > 0 And DateTime.GetYear(CurrentTime) < DateTime.GetYear(m_MinDate)  Then
					Return
				End If
				xASVP_Main.AddPageAt(0,xpnl_Background,CurrentTime)
			End If
			
		else If m_CurrentView = getCurrentView_DecadeView Then
			
			If Forward Then
				
				Dim xpnl_Background As B4XView = xui.CreatePanel("")
				xpnl_Background.Color = xui.Color_Transparent
				xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
	
				Dim p2 As Period
				p2.Initialize
				p2.Years = 10
	
				Dim CurrentTime As Long = DateUtils.AddPeriod(xASVP_Main.GetValue(xASVP_Main.Size -1),p2)
				'Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
	
				If m_MaxDate > 0 And DateTime.GetYear(CurrentTime) > DateTime.GetYear(m_MaxDate)  Then
					Return
				End If
				xASVP_Main.AddPage(xpnl_Background,CurrentTime)
				
			End If
			
		End If
		
	End If
End Sub

Private Sub CreateMonthView
	
	Dim StartIndex As Int = 0
	Dim YearGap As Int = 1
	Dim StartDate As Long = DateUtils.SetDate(DateTime.GetYear(m_StartDate)-YearGap,DateTime.GetMonth(m_StartDate),1)
	Dim Enddate As Long = DateUtils.SetDate(DateTime.GetYear(m_StartDate)+YearGap,DateTime.GetMonth(m_StartDate),1)
	
	If m_MinDate > 0 Then StartDate = m_MinDate
	Dim NumberOfMonths As Int = IIf(m_MaxDate=0, MonthBetween(StartDate,Enddate),0)
	
	If m_MaxDate > 0 Then
		Dim MonthsBetween As Int = MonthBetween(StartDate,m_MaxDate)
		Dim tmp As Period
		tmp.Initialize
		tmp.Months = MonthsBetween
		If DateUtils.AddPeriod(StartDate,tmp) < m_MaxDate Then MonthsBetween = MonthsBetween +1
		NumberOfMonths = Max(MonthsBetween,1)
	End If
	
	For i = 0 To NumberOfMonths -1
		
		Dim xpnl_Background As B4XView = xui.CreatePanel("")
		xpnl_Background.Color = xui.Color_Transparent
		xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
	
		Dim p2 As Period
		p2.Initialize
		p2.Months = i
	
		Dim CurrentTime As Long = DateUtils.AddPeriod(StartDate,p2)
		Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
		
		xASVP_Main.AddPage(xpnl_Background,FirstDayOfMonth)
		
		If DateTime.GetYear(m_StartDate) = DateTime.GetYear(CurrentTime) And DateTime.GetMonth(m_StartDate) = DateTime.GetMonth(CurrentTime) Then StartIndex = i

		
	Next
	
	#If B4A
	Sleep(250)
	#Else
	Sleep(0)
	#End If
	
	xASVP_Main.CurrentIndex2 = StartIndex
	xASVP_Main.Commit
	'Log(xASVP_Main.CustomListView.Size)
	Sleep(0)
	m_isReady = True
	
'	Dim YearGap As Int = 5
'	
'	#If B4J
'	YearGap = 20
'	#End If
'	
'	Dim StartDate As Long
'	If m_MinDate = 0 Then
'		#If Debug
'		Dim peri As Period
'		peri.Initialize
'		peri.Months = -2
'		StartDate =	DateUtils.AddPeriod(m_StartDate,peri)
'		#Else
'		StartDate =	DateUtils.SetDate(DateTime.GetYear(m_StartDate)-YearGap,1,1)
'		#End If
'		
'	Else
'		StartDate =	m_MinDate
'	End If
'	
'	Dim FirstDateOfFuture As Long = DateUtils.SetDate(DateTime.GetYear(m_StartDate)+YearGap,12,31)
'	
'	Dim NumberOfMonths As Int 
'	
'	If m_MaxDate = 0 Then
'		NumberOfMonths = MonthBetween(StartDate,FirstDateOfFuture)
'	Else
'		Dim MonthsBetween As Int = MonthBetween(StartDate,m_MaxDate)
'		Dim tmp As Period
'		tmp.Initialize
'		tmp.Months = MonthsBetween
'		If DateUtils.AddPeriod(StartDate,tmp) < m_MaxDate Then MonthsBetween = MonthsBetween +1
'		NumberOfMonths = Max(MonthsBetween,1)
'	End If
'	
'	Dim StartIndex As Int = 0
'	
''	Log(DateUtils.TicksToString(FirstDateOfPast))
''	Log(DateUtils.TicksToString(FirstDateOfFuture))
''	Log(NumberOfMonths)
'	
'	For i = 0 To NumberOfMonths -1
'	
'		Dim xpnl_Background As B4XView = xui.CreatePanel("")
'		xpnl_Background.Color = m_BodyColor
'		xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
'	
'		Dim p2 As Period
'		p2.Initialize
'		p2.Months = i
'	
'		Dim CurrentTime As Long = DateUtils.AddPeriod(StartDate,p2)
'		Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
'	
'		xASVP_Main.AddPage(xpnl_Background,FirstDayOfMonth)
'	
'		If DateTime.GetYear(m_StartDate) = DateTime.GetYear(CurrentTime) And DateTime.GetMonth(m_StartDate) = DateTime.GetMonth(CurrentTime) Then StartIndex = i
'
'	
'		
'	Next
'	
'	Sleep(0)

'	If StartIndex = 0 Then
'		xASVP_Main.CurrentIndex2 = StartIndex
'	Else
'		Do While  xASVP_Main.CurrentIndex = 0
'			Sleep(0)
'			If xASVP_Main.Size > 0 Then
'				xASVP_Main.CurrentIndex2 = StartIndex
'			End If
'		Loop
'	End If

'	Sleep(0)
'	xASVP_Main.Commit
'	'Log(xASVP_Main.CustomListView.Size)
'	Sleep(0)
'	m_isReady = True
End Sub

Private Sub CreateYearView
	
	Dim YearGap As Int = 10
	
	Dim StartDate As Long
	If m_MinDate = 0 Then
		StartDate =	DateUtils.SetDate(DateTime.GetYear(m_StartDate)-YearGap,1,1)
	Else
		StartDate =	m_MinDate
	End If
	
	Dim FirstDateOfFuture As Long = DateUtils.SetDate(DateTime.GetYear(m_StartDate)+YearGap,12,31)
	
	Dim NumberOfYears As Int
	
	If m_MaxDate = 0 Then
		NumberOfYears = MonthBetween(StartDate,FirstDateOfFuture)/12
	Else
		Dim YearsBetween As Int = Ceil(MonthBetween(StartDate,m_MaxDate)/12)
		NumberOfYears = Max(YearsBetween,1)
	End If
	
	Dim StartIndex As Int = 0
	
'	Log(DateUtils.TicksToString(FirstDateOfPast))
'	Log(DateUtils.TicksToString(FirstDateOfFuture))
'	Log(NumberOfMonths)
	
	For i = 0 To NumberOfYears -1
	
		Dim xpnl_Background As B4XView = xui.CreatePanel("")
		xpnl_Background.Color = xui.Color_Transparent
		xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
	
		Dim p2 As Period
		p2.Initialize
		p2.Years = i
	
		Dim CurrentTime As Long = DateUtils.AddPeriod(StartDate,p2)
		'Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
	
		xASVP_Main.AddPage(xpnl_Background,CurrentTime)
	
		If DateTime.GetYear(m_StartDate) = DateTime.GetYear(CurrentTime) Then StartIndex = i

	
		
	Next
	
	Sleep(0)
'	If StartIndex = 0 Then
'		xASVP_Main.CurrentIndex2 = StartIndex
'	Else
'		Do While xASVP_Main.CurrentIndex = 0
'			Sleep(0)
'			xASVP_Main.CurrentIndex2 = StartIndex
'		Loop
'	End If

	xASVP_Main.CurrentIndex2 = StartIndex
	xASVP_Main.Commit
	'Log(xASVP_Main.CustomListView.Size)
End Sub

Private Sub CreateDecadeView
	
	'Log(DateUtils.TicksToString(m_StartDate))
	
	'Log(DateTime.GetYear(DateUtils.SetDate(DateTime.GetYear(m_StartDate),1,1)))
	
	Dim CurrentDecade As Long = DateUtils.SetDate(DateTime.GetYear(DateUtils.SetDate(DateTime.GetYear(m_StartDate),1,1)),1,1)
	'Log(DateUtils.TicksToString(CurrentDecade))
	Dim YearGap As Int = 50
	
	Dim StartDate As Long
	If m_MinDate = 0 Then
		StartDate =	DateUtils.SetDate(1400,12,31)
	Else
		StartDate =	m_MinDate
	End If
	
	Dim FirstDateOfFuture As Long
	If m_MaxDate = 0 Then
		FirstDateOfFuture = DateUtils.SetDate(DateTime.GetYear(m_StartDate)+YearGap,12,31)
	Else
		FirstDateOfFuture = m_MaxDate
	End If
	
	'Log(DateUtils.TicksToString(FirstDateOfPast))
	Dim NumberOfDecades As Int = Ceil(Max((MonthBetween(StartDate,FirstDateOfFuture)/12)/10,1))
	
	Dim StartIndex As Int = 0
	
'	Log(DateUtils.TicksToString(FirstDateOfPast))
'	Log(DateUtils.TicksToString(FirstDateOfFuture))
'	Log(NumberOfMonths)
	
	For i = 0 To NumberOfDecades -1
	
		Dim xpnl_Background As B4XView = xui.CreatePanel("")
		xpnl_Background.Color = xui.Color_Transparent
		xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
	
		Dim p2 As Period
		p2.Initialize
		p2.Years = i*10
	
		Dim CurrentTime As Long = DateUtils.AddPeriod(StartDate,p2)
		'Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
	
		xASVP_Main.AddPage(xpnl_Background,CurrentTime)
	
		If DateTime.GetYear(CurrentDecade) >= DateTime.GetYear(CurrentTime) And DateTime.GetYear(CurrentDecade) <= (DateTime.GetYear(CurrentTime) +11) Then StartIndex = i

		If DateTime.GetYear(CurrentDecade) >= DateTime.GetYear(CurrentTime)  Then StartIndex = i
		
	Next
	
	Sleep(0)
	xASVP_Main.CurrentIndex2 = StartIndex
	xASVP_Main.Commit
	'Log(xASVP_Main.CustomListView.Size)
End Sub

Private Sub CreateCenturyView


	Dim CurrentCenturyStart As Long = DateUtils.SetDate(DateTime.GetYear(m_StartDate) - Round(((DateTime.GetYear(m_StartDate)/100) - (DateTime.GetYear(m_StartDate)/100).As(Int))*100),1,1)
	'Log(DateUtils.TicksToString(CurrentCenturyStart))
	
	Dim p As Period
	p.Initialize
	
	Dim FirstDateOfPast As Long = DateUtils.SetDate(1,1,1)
	
	If m_MinDate > 0 Or m_MaxDate > 0 Then
		If m_MinDate > 0 Then
			FirstDateOfPast = DateUtils.SetDate(DateTime.GetYear(m_MinDate)-40,1,1)
		Else
			FirstDateOfPast = DateUtils.SetDate(DateTime.GetYear(m_MaxDate)-40,1,1)
		End If
	End If
	
'	For i = 0 To 100 -1
'		
'		p.Years = i*10*12
'		Dim Test As Long = DateUtils.AddPeriod(FirstDateOfPast,p)
'		If i > 0 Then
'			Test = DateUtils.SetDate((DateTime.GetYear(Test) - Round(((DateTime.GetYear(Test)/100) - (DateTime.GetYear(Test)/100).As(Int))*100))+1,1,1)
'			If DateTime.GetMonth(Test) = 1 Then
'				Test = DateUtils.SetDate(DateTime.GetYear(Test) - Round(((DateTime.GetYear(Test)/100) - (DateTime.GetYear(Test)/100).As(Int))*100),1,1)
'			End If
'		End If
'		Log(DateUtils.TicksToString(Test))
'	Next
	
	Dim StartIndex As Int = 0
	
'	Log(DateUtils.TicksToString(FirstDateOfPast))
'	Log(DateUtils.TicksToString(FirstDateOfFuture))
'	Log(NumberOfMonths)
	
	Dim NumberOfCentries As Int = 80
	If m_MinDate > 0 Or m_MaxDate > 0 Then NumberOfCentries = 1
	
	For i = 0 To NumberOfCentries -1
	
		Dim xpnl_Background As B4XView = xui.CreatePanel("")
		xpnl_Background.Color = xui.Color_Transparent
		xpnl_Background.SetLayoutAnimated(0,0,0,xpnl_ViewPager.Width,xpnl_ViewPager.Height)
	
		p.Years = i*10*12
		Dim CurrentTime As Long = DateUtils.AddPeriod(FirstDateOfPast,p)
		If i > 0 Then
			CurrentTime = DateUtils.SetDate((DateTime.GetYear(CurrentTime) - Round(((DateTime.GetYear(CurrentTime)/100) - (DateTime.GetYear(CurrentTime)/100).As(Int))*100))+1,1,1)
			If DateTime.GetMonth(CurrentTime) = 1 Then
				CurrentTime = DateUtils.SetDate(DateTime.GetYear(CurrentTime) - Round(((DateTime.GetYear(CurrentTime)/100) - (DateTime.GetYear(CurrentTime)/100).As(Int))*100),1,1)
			End If
		End If
		'Dim FirstDayOfMonth As Long = DateUtils.SetDate(DateTime.GetYear(CurrentTime),DateTime.GetMonth(CurrentTime),1)
	
		xASVP_Main.AddPage(xpnl_Background,CurrentTime)
	
		If DateTime.GetYear(CurrentCenturyStart) = DateTime.GetYear(CurrentTime)  Then StartIndex = i

		'Log(DateUtils.TicksToString(CurrentTime))
		
	Next
	
	Sleep(0)
	xASVP_Main.CurrentIndex2 = StartIndex
	xASVP_Main.Commit
	'Log(xASVP_Main.CustomListView.Size)
End Sub

Private Sub AddMonth(Parent As B4XView,CurrentDate As Long)
	
	Dim BlockHeight As Float = (Parent.Height-g_WeekNameProperties.Height)/6
	Dim BlockWidth As Float = IIf(m_ShowWeekNumbers,(xpnl_ViewPager.Width - g_WeekNumberProperties.Width)/7, xpnl_ViewPager.Width/7)
	
	If m_ShowWeekNumbers Then AddWeekName(Parent,-1,g_WeekNumberProperties.Text)
	AddWeekName(Parent,0,g_WeekNameShort.Monday)
	AddWeekName(Parent,1,g_WeekNameShort.Tuesday)
	AddWeekName(Parent,2,g_WeekNameShort.Wednesday)
	AddWeekName(Parent,3,g_WeekNameShort.Thursday)
	AddWeekName(Parent,4,g_WeekNameShort.Friday)
	AddWeekName(Parent,5,g_WeekNameShort.Saturday)
	AddWeekName(Parent,6,g_WeekNameShort.Sunday)
	
	Dim FirstDay As Long = GetFirstDayOfWeek2(CurrentDate,m_FirstDayOfWeek)

	Parent.Tag = CurrentDate
	Parent.Color = m_BodyColor
'	Parent.Color = xui.Color_Red

	For i = 1 To 43 -1
		
		Dim CurrentDay As Long = FirstDay + DateTime.TicksPerDay*(i-1) + DateTime.TicksPerHour
		
		Dim Rest As Int = (i-1)/7
		Dim test As Int = (i-1) Mod 7
		
		Dim xpnl_Date As B4XView = xui.CreatePanel("xpnl_MonthDate")
		xpnl_Date.Tag = CurrentDay
		Parent.AddView(xpnl_Date,IIf(m_ShowWeekNumbers,g_WeekNumberProperties.Width,0) + (BlockWidth*test),g_WeekNameProperties.Height + (BlockHeight*Rest),BlockWidth,BlockHeight)
		BuildDay(CurrentDay,xpnl_Date)

		'Create WeekNumbers
		If m_ShowWeekNumbers = True Then
			Dim xpnl_WeekNumber As B4XView = xui.CreatePanel("")
			Dim xlbl_WeekNumber As B4XView = CreateLabel("")
			Parent.AddView(xpnl_WeekNumber,0,g_WeekNameProperties.Height + (BlockHeight*Rest),g_WeekNumberProperties.Width,BlockHeight)
			xpnl_WeekNumber.AddView(xlbl_WeekNumber,0,0,g_WeekNumberProperties.Width,xpnl_Date.Height)
		
			xpnl_WeekNumber.Color = g_WeekNumberProperties.Color
		
			xlbl_WeekNumber.SetTextAlignment("CENTER","CENTER")
			xlbl_WeekNumber.TextColor = g_WeekNumberProperties.TextColor
			xlbl_WeekNumber.Font = g_WeekNumberProperties.xFont
			xlbl_WeekNumber.Text = GetWeekNumberStartingFromMonday(CurrentDay)
		End If

	Next
	
	If m_ShowGridLines Then
		Dim xpnl_CanvasBackground As B4XView = xui.CreatePanel("")
		Parent.AddView(xpnl_CanvasBackground,0,0,Parent.Width,Parent.Height)
		xpnl_CanvasBackground.Color = xui.Color_Transparent

		#If B4I
		xpnl_CanvasBackground.As(Panel).UserInteractionEnabled = False
		#Else If B4J
		xpnl_CanvasBackground.As(JavaObject).RunMethod("setMouseTransparent", Array As Object(True))
		#End If

		Dim xcv As B4XCanvas
		xcv.Initialize(xpnl_CanvasBackground)
		xcv.ClearRect(xcv.TargetRect)

		For i = 0 To 6 -1 'Add Divider Vertical
			xcv.DrawLine(IIf(m_ShowWeekNumbers,g_WeekNumberProperties.Width,0) + (BlockWidth*(i+1)),0,IIf(m_ShowWeekNumbers,g_WeekNumberProperties.Width,0) + (BlockWidth*(i+1)),Parent.Height,m_GridLineColor,1dip)
		
			If i < 5 Then xcv.DrawLine(0,g_WeekNameProperties.Height + (BlockHeight*(i+1)),Parent.Width,g_WeekNameProperties.Height + (BlockHeight*(i+1)),m_GridLineColor,1dip)
		Next
	
		xcv.DrawLine(IIf(m_ShowWeekNumbers,g_WeekNumberProperties.Width,0),g_WeekNameProperties.Height,Parent.Width,g_WeekNameProperties.Height,m_GridLineColor,1dip)
	
		xcv.Invalidate
	End If
	
End Sub

Private Sub BuildDay(CurrentDay As Long,xpnl_Date As B4XView)
	
	Dim clr() As Int = GetARGB(m_SelectedDateColor)
	
	xpnl_Date.Color = xui.Color_Transparent'm_BodyColor
	
	Dim xlbl_Date As B4XView = CreateLabel("")
	xlbl_Date.Tag = "xlbl_Date"
	xlbl_Date.Font = g_BodyProperties.xFont
	xlbl_Date.TextColor = g_BodyProperties.TextColor
	xlbl_Date.SetTextAlignment("CENTER","CENTER")
	xlbl_Date.Text = DateTime.GetDayOfMonth(CurrentDay)
		
		
	xpnl_Date.AddView(xlbl_Date,0,0,xpnl_Date.Width,xpnl_Date.Height)

	If DateTime.GetMonth(CurrentDay) <> DateTime.GetMonth(xpnl_Date.Parent.Tag) Then
		If m_InactiveDaysVisible = False Then
			xlbl_Date.Visible = False
		Else
			Dim Color() As Int = GetARGB(g_BodyProperties.TextColor)
			xlbl_Date.TextColor = xui.Color_ARGB(100,Color(1),Color(2),Color(3))
		End If
	End If

	If (m_MaxDate > 0 And DateUtils.SetDate(DateTime.GetYear(CurrentDay),DateTime.GetMonth(CurrentDay),DateTime.GetDayOfMonth(CurrentDay)) > DateUtils.SetDate(DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),DateTime.GetDayOfMonth(m_MaxDate))) Or (m_MinDate > 0 And DateUtils.SetDate(DateTime.GetYear(CurrentDay),DateTime.GetMonth(CurrentDay),DateTime.GetDayOfMonth(CurrentDay)) < DateUtils.SetDate(DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate),DateTime.GetDayOfMonth(m_MinDate))) Then
		xlbl_Date.Visible = False
	End If

		

	CreateSelectDates(xpnl_Date,clr)

	If DateUtils.IsSameDay(DateTime.Now,CurrentDay) = True And xlbl_Date.Visible = True Then
		Dim xpnl_CurrentDay As B4XView = xui.CreatePanel("")
		xpnl_CurrentDay.SetColorAndBorder(m_CurrentDateColor,0,0,g_BodyProperties.CurrentAndSelectedDayHeight/2)
		xpnl_Date.AddView(xpnl_CurrentDay,xpnl_Date.Width/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,xpnl_Date.Height/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,g_BodyProperties.CurrentAndSelectedDayHeight,g_BodyProperties.CurrentAndSelectedDayHeight)
	End If

	CustomDrawDay(CurrentDay,xpnl_Date)
End Sub

Private Sub AddYear(Parent As B4XView,CurrentDate As Long) 'Ignore
	
	Dim BlockHeight As Float = xpnl_ViewPager.Height/4
	Dim BlockWidth As Float = xpnl_ViewPager.Width/3
	
	Parent.Color = m_BodyColor
	
	For i = 1 To 13 -1
		
		'Dim CurrentDay As Long = DateUtils.SetDate(DateTime.GetYear(CurrentDate),i,1)
		
		Dim Rest As Int = (i-1)/3
		Dim test As Int = (i-1) Mod 3
		
		Dim Text As String = ""
		Dim xpnl_Date As B4XView
		Dim SelectThisPanel As Boolean = False
		If m_CurrentView = getCurrentView_YearView Then
			Text = GetMonthNameByIndex(i)
			xpnl_Date = xui.CreatePanel("xpnl_YearMonth")
			xpnl_Date.Tag = DateUtils.SetDate(DateTime.GetYear(CurrentDate),i,1)
			If DateTime.GetMonth(xpnl_Date.Tag) = DateTime.GetMonth(DateTime.Now) And DateTime.GetYear(xpnl_Date.Tag) = DateTime.GetYear(DateTime.Now) Then SelectThisPanel = True
			
			If (m_MaxDate > 0 Or m_MinDate > 0) And (DateTime.GetYear(xpnl_Date.Tag) = DateTime.GetYear(m_MaxDate) And DateTime.GetMonth(xpnl_Date.Tag) > DateTime.GetMonth(m_MaxDate)) Or (DateTime.GetYear(xpnl_Date.Tag) = DateTime.GetYear(m_MinDate) And DateTime.GetMonth(xpnl_Date.Tag) < DateTime.GetMonth(m_MinDate)) Then
				xpnl_Date.Visible = False
			End If
			
		else if m_CurrentView = getCurrentView_DecadeView Then
			Text = DateTime.GetYear(CurrentDate)+(i-1)
			xpnl_Date = xui.CreatePanel("xpnl_DecadeYear")
			xpnl_Date.Tag = DateUtils.SetDate(DateTime.GetYear(CurrentDate)+(i-1)*1,1,1)
			If DateTime.GetYear(xpnl_Date.Tag) = DateTime.GetYear(DateTime.Now) Then SelectThisPanel = True
			
			If (m_MaxDate > 0 Or m_MinDate > 0) And ((DateTime.GetYear(xpnl_Date.Tag) > DateTime.GetYear(m_MaxDate)) Or (DateTime.GetYear(xpnl_Date.Tag) < DateTime.GetYear(m_MinDate))) Then
				xpnl_Date.Visible = False
			End If
			
		else if m_CurrentView = getCurrentView_CenturyView Then
			Text = (DateTime.GetYear(CurrentDate)+(i-1)*10) & " - " & ((DateTime.GetYear(CurrentDate)+(i-1)*10)+9)
			xpnl_Date = xui.CreatePanel("xpnl_CenturyDecade")
			xpnl_Date.Tag = DateUtils.SetDate(DateTime.GetYear(CurrentDate)+(i-1)*10,1,1)
			If DateTime.GetYear(DateTime.Now) >= (DateTime.GetYear(CurrentDate)+(i-1)*10) And DateTime.GetYear(DateTime.Now) <= ((DateTime.GetYear(CurrentDate)+(i-1)*10)+9) Then SelectThisPanel = True
			'Log(DateUtils.TicksToString(xpnl_Date.Tag))
			
'			If (m_MaxDate > 0 Or m_MinDate > 0) And (DateTime.GetYear(xpnl_Date.Tag) > DateTime.GetYear(m_MaxDate)) Or (DateTime.GetYear(xpnl_Date.Tag) < DateTime.GetYear(m_MinDate)) Then
'				xpnl_Date.Visible = False
'			End If
			
			If (m_MaxDate > 0 Or m_MinDate > 0) And (DateTime.GetYear(xpnl_Date.Tag) > DateTime.GetYear(m_MaxDate) Or ((DateTime.GetYear(CurrentDate)+(i-1)*10)+9) < DateTime.GetYear(m_MinDate))  Then
				xpnl_Date.Visible = False
			End If
			
		End If
		
		xpnl_Date.Color = xui.Color_Transparent
		Parent.AddView(xpnl_Date,BlockWidth*test,BlockHeight*Rest,BlockWidth,BlockHeight)
		Dim xlbl_Date As B4XView = CreateLabel("")
		
		xlbl_Date.Font = g_BodyProperties.xFont
		xlbl_Date.TextColor = g_BodyProperties.TextColor
		xlbl_Date.SetTextAlignment("CENTER","CENTER")
		
		xlbl_Date.Text = Text
		
		xpnl_Date.AddView(xlbl_Date,0,0,BlockWidth,BlockHeight)

		If SelectThisPanel Then
			Dim xpnl_Current As B4XView = xui.CreatePanel("")
			Dim StrokeWidth As Float = 2dip
			xpnl_Date.AddView(xpnl_Current,StrokeWidth,StrokeWidth,BlockWidth - StrokeWidth*2,BlockHeight - StrokeWidth*2)
			
			xpnl_Current.SetColorAndBorder(xui.Color_Transparent,StrokeWidth,m_CurrentDateColor,5dip)
		End If
	Next
	
End Sub

Public Sub ChangeView(NewView As String)
	xpnl_LoadingPanel.SetVisibleAnimated(250,True)
	m_CurrentView = NewView
	xASVP_Main.Clear
	Sleep(250)
	Select Case NewView
		Case getCurrentView_MonthView
			CreateMonthView
		Case getCurrentView_YearView
			CreateYearView
		Case getCurrentView_DecadeView
			CreateDecadeView
		Case getCurrentView_CenturyView
			CreateCenturyView
	End Select
	xpnl_LoadingPanel.SetVisibleAnimated(250,False)
End Sub

'Public Sub Refresh
'	'ResizeGrid
'	xASVP_Main.ResetLazyLoadingPanels
'	xASVP_Main.ResetLazyloadingIndex
'	Sleep(0)
'	xASVP_Main.Commit
'End Sub

Public Sub Refresh
	For i = 0 To xASVP_Main.Size -1
		If xASVP_Main.GetPanel(i).NumberOfViews > 0 Then
			xASVP_Main.GetPanel(i).RemoveAllViews
			If m_CurrentView = getCurrentView_MonthView Then
				AddMonth(xASVP_Main.GetPanel(i),xASVP_Main.GetValue(i))
			Else If m_CurrentView = getCurrentView_YearView Or m_CurrentView = getCurrentView_DecadeView Or m_CurrentView = getCurrentView_CenturyView Then
				AddYear(xASVP_Main.GetPanel(i),xASVP_Main.GetValue(i))
			End If
		End If
	Next
End Sub

Public Sub RefreshSelectedDate
	Dim clr() As Int = GetARGB(m_SelectedDateColor)
	'Dim Start As Long = DateTime.now
	For i = 0 To xASVP_Main.Size -1
		If xASVP_Main.GetPanel(i).NumberOfViews > 0 Then
			If m_CurrentView = getCurrentView_MonthView Then
	'AddMonth(xASVP_Main.CustomListView.GetPanel(i),xASVP_Main.CustomListView.GetValue(i))
				Dim counter As Int = xASVP_Main.GetPanel(i).NumberOfViews
				For z = 0 To counter -1
					Dim xpnl_Day As B4XView = xASVP_Main.GetPanel(i).GetView(z)
					If xpnl_Day.tag Is Long And xpnl_Day.NumberOfViews > 0 Then 
						CreateSelectDates(xpnl_Day,clr)
					End If
				Next
			End If
		End If
	Next
	'Log((DateTime.Now-Start) & "ms")
End Sub

Private Sub CreateSelectDates(xpnl_Date As B4XView,clr() As Int)
	'Dim Start As Long = DateTime.Now
	Dim xlbl_Date As B4XView
	For Each View As B4XView In xpnl_Date.GetAllViewsRecursive
		If "xlbl_Date" = View.Tag Then xlbl_Date = View
	Next
	Dim CurrentDay As Long = xpnl_Date.Tag
	
	If m_SelectMode = "Range" Then
		If DateUtils.IsSameDay(CurrentDay,m_SelectedDate) And xlbl_Date.Visible Then
			CreateSelectedDate(xpnl_Date,True)
		Else If DateUtils.IsSameDay(CurrentDay,m_SelectedDate2) And xlbl_Date.Visible Then
			CreateSelectedDate(xpnl_Date,False)
		End If
			
		For Each v As B4XView In xpnl_Date.GetAllViewsRecursive
			If "RangeItem" = v.Tag Then
				v.RemoveViewFromParent
				Exit
			End If
		Next
			
		If m_SelectedDate > 0 And m_SelectedDate2 > 0 And ((CurrentDay >= m_SelectedDate And CurrentDay <= m_SelectedDate2) Or (DateUtils.IsSameDay(CurrentDay,m_SelectedDate) Or DateUtils.IsSameDay(CurrentDay,m_SelectedDate2))) Then
			Dim xpnl_selected As B4XView = xui.CreatePanel("")
			xpnl_selected.Tag = "RangeItem"
			If DateUtils.IsSameDay(CurrentDay,m_SelectedDate) Then
				xpnl_Date.AddView(xpnl_selected,xpnl_Date.Width/2,xpnl_Date.Height/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,xpnl_Date.Width/2,g_BodyProperties.CurrentAndSelectedDayHeight)
			Else If DateUtils.IsSameDay(CurrentDay,m_SelectedDate2) Then
				xpnl_Date.AddView(xpnl_selected,0,xpnl_Date.Height/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,xpnl_Date.Width/2,g_BodyProperties.CurrentAndSelectedDayHeight)
			Else
				xpnl_Date.AddView(xpnl_selected,0,xpnl_Date.Height/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,xpnl_Date.Width,g_BodyProperties.CurrentAndSelectedDayHeight)
			End If
				
			xpnl_selected.Color = xui.Color_ARGB(80,clr(1),clr(2),clr(3))
			xpnl_selected.SendToBack
		End If
	Else
		
		If DateUtils.IsSameDay(CurrentDay,m_SelectedDate) And xlbl_Date.Visible = True  Then
			MonthDateClick(xpnl_Date,False)
		End If
		
	End If
	
	'Log((DateTime.Now-Start) & "ms")
End Sub

'Applies the header properties if any have been changed
Public Sub RefreshHeader
	
	xpnl_Header.Color = m_HeaderColor
	
	Dim xlbl_Header As B4XView = xpnl_Header.GetView(0)
	Dim xlbl_ArrowLeft As B4XView = xpnl_Header.GetView(1)
	Dim xlbl_ArrowRight As B4XView = xpnl_Header.GetView(2)
	
	xlbl_ArrowLeft.Font = xui.CreateMaterialIcons(g_HeaderProperties.ButtonIconSize)
	xlbl_ArrowLeft.TextColor = g_HeaderProperties.TextColor
	xlbl_ArrowLeft.Visible = g_HeaderProperties.ArrowsVisible
	
	xlbl_ArrowRight.Font = xui.CreateMaterialIcons(g_HeaderProperties.ButtonIconSize)
	xlbl_ArrowRight.TextColor = g_HeaderProperties.TextColor
	xlbl_ArrowRight.Visible = g_HeaderProperties.ArrowsVisible
	
	xlbl_Header.Font = g_HeaderProperties.xFont
	xlbl_Header.TextColor = g_HeaderProperties.TextColor
	
End Sub

'Clears the DatePicker and builds the DatePicker new
Public Sub Rebuild
	
	Do While m_isReady = False
		Sleep(0)
	Loop
	Sleep(0)
	xASVP_Main.Clear
	Sleep(0)
	If m_SelectMode = "Date" Or m_SelectMode = "Range" Then
		m_CurrentView = getCurrentView_MonthView
		CreateMonthView
	else if m_SelectMode = "Month" Then
		m_CurrentView = getCurrentView_YearView
		CreateYearView
	End If
End Sub

#Region Properties
'Call Refresh if you change something
'<code>AS_DatePicker1.CreateASDatePicker_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")</code>
Public Sub setWeekNameShort(WeekNameShort As ASDatePicker_WeekNameShort)
	g_WeekNameShort = WeekNameShort
End Sub

Public Sub getWeekNameShort As ASDatePicker_WeekNameShort
	Return g_WeekNameShort
End Sub

'Call Refresh if you change something
'<code>AS_DatePicker1.MonthNameShort = AS_DatePicker1.CreateASDatePicker_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>
Public Sub getMonthNameShort As ASDatePicker_MonthNameShort
	Return g_MonthNameShort
End Sub

Public Sub setMonthNameShort(MonthNameShort As ASDatePicker_MonthNameShort)
	g_MonthNameShort = MonthNameShort
End Sub

'Call Refresh if you change something
'Default Values
'Width: <code>20dip</code>
'Color: <code>xui.Color_ARGB(255,32, 33, 37)</code>
'xFont: <code>xui.CreateDefaultFont(15)</code>
'TextColor: <code>xui.Color_White</code>
Public Sub getWeekNumberProperties As ASDatePicker_WeekNumberProperties
	Return g_WeekNumberProperties
End Sub
Public Sub setWeekNumberProperties(WeekNumberProperties As ASDatePicker_WeekNumberProperties)
	g_WeekNumberProperties = WeekNumberProperties
End Sub

'Call Refresh if you change something
'Default Values
'Width: <code>20dip</code>
'Color: <code>xui.Color_ARGB(255,32, 33, 37)</code>
'xFont: <code>xui.CreateDefaultFont(15)</code>
'TextColor: <code>xui.Color_White</code>
Public Sub getWeekNameProperties As ASDatePicker_WeekNameProperties
	Return g_WeekNameProperties
End Sub
Public Sub setWeekNameProperties(WeekNameProperties As ASDatePicker_WeekNameProperties)
	g_WeekNameProperties = WeekNameProperties
End Sub

'Gets or sets the number of visible weeks
'Call Refresh to commit changes
Public Sub getShowWeekNumbers As Boolean
	Return m_ShowWeekNumbers
End Sub

Public Sub setShowWeekNumbers(Show As Boolean)
	m_ShowWeekNumbers = Show
End Sub
'You can customize the appereance of the header
'With the following code you can customize the control elements that are visible in the header:
'<code>
''Middle Text Label
'Dim xlbl_Header As B4XView = AS_DatePicker1.HeaderPanel.GetView(0) 
''Left Arrow Label
'Dim xlbl_ArrowLeft As B4XView = AS_DatePicker1.HeaderPanel.GetView(1)
''Right Arrow Label
'Dim xlbl_ArrowRight As B4XView = AS_DatePicker1.HeaderPanel.GetView(2)
'</code>
Public Sub getHeaderPanel As B4XView
	Return xpnl_Header
End Sub

Public Sub getHeaderColor As Int
	Return m_HeaderColor
End Sub

Public Sub setHeaderColor(Color As Int)
	m_HeaderColor = Color
	xpnl_Header.Color = m_HeaderColor
End Sub
'Call Refresh if you change something
Public Sub getGridLineColor As Int
	Return m_GridLineColor
End Sub

Public Sub setGridLineColor(Color As Int)
	m_GridLineColor = Color
End Sub
'Call Refresh if you change something
Public Sub getShowGridLines As Boolean
	Return m_ShowGridLines
End Sub

Public Sub setShowGridLines(Show As Boolean)
	m_ShowGridLines = Show
End Sub
'Call Refresh if you change something
Public Sub getBodyColor As Int
	Return m_BodyColor
End Sub

Public Sub setBodyColor(Color As Int)
	m_BodyColor = Color
	xpnl_LoadingPanel.Color = m_BodyColor
	xASVP_Main.LoadingPanelColor = m_BodyColor
	xASVP_Main.Base.Color = m_BodyColor
End Sub
'Call Refresh if you change something
Public Sub getCurrentDateColor As Int
	Return m_CurrentDateColor
End Sub

Public Sub setCurrentDateColor(Color As Int)
	m_CurrentDateColor = Color
End Sub
'Call Refresh if you change something
Public Sub getSelectedDateColor As Int
	Return m_SelectedDateColor
End Sub

Public Sub setSelectedDateColor(Color As Int)
	m_SelectedDateColor = Color
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
'Scrolls to the date
'Builds the view new if the date was not in range
Public Sub Scroll2Date(Date As Long)
	Dim ScrollIndex As Int = -1
	For i = 0 To xASVP_Main.Size -1
		Dim StartDate As Long = xASVP_Main.GetValue(i)

		If DateTime.GetYear(StartDate) = DateTime.GetYear(Date) And DateTime.GetMonth(StartDate) = DateTime.GetMonth(Date) Then
			ScrollIndex = i
		End If
		
	Next
	If ScrollIndex <> -1 Then
		xASVP_Main.CurrentIndex = ScrollIndex
	Else
		m_StartDate = Date
		xASVP_Main.Clear
		CreateMonthView
	End If
End Sub

'Call Refresh if you change something
'To deselect, call ClearSelections
Public Sub setSelectedDate(Date As Long)
	m_SelectedDate = Date
End Sub

Public Sub getSelectedDate As Long
	Return m_SelectedDate
End Sub

'Call Refresh if you change something
'To deselect, call ClearSelections
Public Sub getSelectedStartDate As Long
	Return m_SelectedDate
End Sub

Public Sub setSelectedStartDate(Date As Long)
	m_SelectedDate = Date
End Sub
'Call Refresh if you change something
'Only in SelectMode "Range"
'To deselect, call ClearSelections
Public Sub getSelectedEndDate As Long
	Return m_SelectedDate2
End Sub

Public Sub setSelectedEndDate(Date As Long)
	 m_SelectedDate2 = Date
End Sub

'Deselect the selections
'Call Refresh to apply the change
Public Sub ClearSelections
	m_SelectedDate = 0
	m_SelectedDate2 = 0
End Sub

'Call Refresh if you change something
Public Sub getBodyProperties As ASDatePicker_BodyProperties
	Return g_BodyProperties
End Sub

Public Sub setBodyProperties(BodyProperties As ASDatePicker_BodyProperties)
	g_BodyProperties = BodyProperties
End Sub
'Call RefreshHeader if you change something
Public Sub getHeaderProperties As ASDatePicker_HeaderProperties
	Return g_HeaderProperties
End Sub

Public Sub setHeaderProperties(HeaderProperties As ASDatePicker_HeaderProperties)
	g_HeaderProperties = HeaderProperties
End Sub
'Call Rebuild if you change something
'Will restrict date navigations features of forward, and also cannot swipe the control using touch gesture beyond the max date range
Public Sub setMaxDate(MaxDate As Long)
	m_MaxDate = MaxDate
End Sub
Public Sub getMaxDate As Long
	Return m_MaxDate
End Sub
'Will restrict date navigations features of backward, also cannot swipe the control using touch gesture beyond the min date range
Public Sub setMinDate(MinDate As Long)
	m_MinDate = MinDate
End Sub
Public Sub getMinDate As Long
	Return m_MinDate
End Sub

Public Sub getSelectMode As String
	Return m_SelectMode
End Sub

Public Sub setSelectMode(Mode As String)
	m_SelectMode = Mode
End Sub

Public Sub getCurrentView As String
	Return m_CurrentView
End Sub

#End Region

#Region Enums

Public Sub getCurrentView_MonthView As String
	Return "MonthView"
End Sub

Public Sub getCurrentView_YearView As String
	Return "YearView"
End Sub

Public Sub getCurrentView_DecadeView As String
	Return "DecadeView"
End Sub

Public Sub getCurrentView_CenturyView As String
	Return "CenturyView"
End Sub

Public Sub getSelectMode_Day As String
	Return "Date"
End Sub

Public Sub getSelectMode_Month As String
	Return "Month"
End Sub

Public Sub getSelectMode_Range As String
	Return "Range"
End Sub

#End Region

#Region Events

Private Sub CustomDrawHeader(date As Long)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawHeader", 2) Then
		
		Dim m_CustomDrawHeader As ASDatePicker_CustomDrawHeader
		m_CustomDrawHeader.Initialize
		m_CustomDrawHeader.BackgroundPanel = xpnl_Header
		m_CustomDrawHeader.xlbl_Text = xpnl_Header.GetView(0)
		m_CustomDrawHeader.xlbl_ArrowLeft = xpnl_Header.GetView(1)
		m_CustomDrawHeader.xlbl_ArrowRight = xpnl_Header.GetView(2)
		
		CallSub3(mCallBack, mEventName & "_CustomDrawHeader",date,m_CustomDrawHeader)
	End If
End Sub

Private Sub SelectedDateChanged(date As Long)
	If xui.SubExists(mCallBack, mEventName & "_SelectedDateChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_SelectedDateChanged",date)
	End If
End Sub

Private Sub SelectedDateRangeChanged
	If xui.SubExists(mCallBack, mEventName & "_SelectedDateRangeChanged", 2) Then
		CallSub3(mCallBack, mEventName & "_SelectedDateRangeChanged",m_SelectedDate,m_SelectedDate2)
	End If
End Sub

Private Sub CustomDrawDay(Date As Long,BackgroundPanel As B4XView)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawDay", 2) Then
		
		Dim m_CustomDrawDay As ASDatePicker_CustomDrawDay
		m_CustomDrawDay.Initialize
		m_CustomDrawDay.BackgroundPanel = BackgroundPanel
		
		For Each View As B4XView In BackgroundPanel.GetAllViewsRecursive
			
			If "xlbl_Date" = View.Tag Then
				m_CustomDrawDay.xlbl_Date = View
			End If
			
		Next
		
		CallSub3(mCallBack, mEventName & "_CustomDrawDay",Date,m_CustomDrawDay)
	End If
End Sub

Private Sub PageChanged
	If xui.SubExists(mCallBack, mEventName & "_PageChanged", 0) Then
		CallSub(mCallBack, mEventName & "_PageChanged")
	End If
End Sub

#End Region

#Region ViewEvents

Private Sub xASVP_Main_PageChanged(Index As Int)
	PageChanged
End Sub

Private Sub xASVP_Main_LazyLoadingAddContent(Parent As B4XView, Value As Object)
	If m_CurrentView = getCurrentView_MonthView Then
		AddMonth(Parent,Value)
	Else If m_CurrentView = getCurrentView_YearView Or m_CurrentView = getCurrentView_DecadeView Or m_CurrentView = getCurrentView_CenturyView Then
		AddYear(Parent,Value)
	End If
End Sub

Private Sub xASVP_Main_PageChange(Index As Int)
	Dim xlbl_Header As B4XView = xpnl_Header.GetView(0)
	Dim CurrentDate As Long = xASVP_Main.GetValue(Index)
	If m_CurrentView = getCurrentView_MonthView Then
	xlbl_Header.Text = DateUtils.GetMonthName(CurrentDate) & " " & DateTime.GetYear(CurrentDate)
	else if m_CurrentView = getCurrentView_YearView Then
	xlbl_Header.Text = DateTime.GetYear(CurrentDate)
	else if m_CurrentView = getCurrentView_DecadeView Then
		xlbl_Header.Text = DateTime.GetYear(CurrentDate) & " - " & (DateTime.GetYear(CurrentDate) +11)
	else if m_CurrentView = getCurrentView_CenturyView Then
		xlbl_Header.Text = DateTime.GetYear(CurrentDate) & " - " & ((DateTime.GetYear(CurrentDate) +10*12)-1)
	End If
	CustomDrawHeader(CurrentDate)
End Sub

'**************Header*************
#If B4J
Private Sub xlbl_HeaderArrowLeft_MouseClicked (EventData As MouseEvent)
	EventData.Consume
	xASVP_Main.PreviousPage
End Sub
Private Sub xlbl_HeaderArrowRight_MouseClicked (EventData As MouseEvent)
	EventData.Consume
	xASVP_Main.NextPage
End Sub
#Else
Private Sub xlbl_HeaderArrowLeft_Click
	xASVP_Main.PreviousPage
End Sub
Private Sub xlbl_HeaderArrowRight_Click
	xASVP_Main.NextPage
End Sub
#End If

#If B4J
Private Sub xlbl_Header_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub xlbl_Header_Click
#End If

	Select m_CurrentView
		Case getCurrentView_MonthView
			If m_MaxViewLevel <> getCurrentView_MonthView Then ChangeView(getCurrentView_YearView)
		Case getCurrentView_YearView
			If m_MaxViewLevel <> getCurrentView_YearView Then ChangeView(getCurrentView_DecadeView)
		Case getCurrentView_DecadeView
			If m_MaxViewLevel <> getCurrentView_DecadeView Then ChangeView(getCurrentView_CenturyView)
	End Select

End Sub

#IF B4J
Private Sub xpnl_DecadeYear_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub xpnl_DecadeYear_Click
#End If
	Dim xpnl_DecadeYear As B4XView = Sender
	m_StartDate = xpnl_DecadeYear.Tag
	ChangeView(getCurrentView_YearView)
End Sub

#If B4J
Private Sub xpnl_YearMonth_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub xpnl_YearMonth_Click
#End If
	Dim xpnl_YearMonth As B4XView = Sender
	m_StartDate = xpnl_YearMonth.Tag
	If m_SelectMode = "Date"  Or m_SelectMode = "Range" Then
		ChangeView(getCurrentView_MonthView)
	Else If m_SelectMode = "Month" Then
		SelectedDateChanged(xpnl_YearMonth.Tag)
		
		If m_MouseHoverFeedback = True Then
			Dim xlbl_Date As B4XView = xpnl_YearMonth.GetView(0)
			If xlbl_Date.Visible = False Then Return
			#If B4J
			If xpnl_HoverDate <> Null And xpnl_HoverDate.IsInitialized = True Then xpnl_HoverDate.RemoveViewFromParent
			#End If
			Dim xpnl_selected As B4XView = xui.CreatePanel("")
			xpnl_YearMonth.AddView(xpnl_selected,0,0,xpnl_YearMonth.Width,xpnl_YearMonth.Height)
			
			xpnl_selected.SetColorAndBorder(m_SelectedDateColor,0,0,5dip)
			xpnl_selected.SendToBack
			If xpnl_SelectedDate <> Null And xpnl_SelectedDate.IsInitialized = True Then xpnl_SelectedDate.RemoveViewFromParent
			xpnl_SelectedDate = xpnl_selected
			#If B4J
			xpnl_HoverDate = xpnl_selected
			#End If
		End If
		
	End If
End Sub

#If B4J
Private Sub xpnl_CenturyDecade_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub xpnl_CenturyDecade_Click
#End If
	Dim xpnl_CenturyDecade As B4XView = Sender
	m_StartDate = xpnl_CenturyDecade.Tag
	ChangeView(getCurrentView_DecadeView)
End Sub

#If B4J

Private Sub xpnl_MonthDate_MouseEntered (EventData As MouseEvent)
	Dim xpnl_MonthDate As B4XView = Sender
	If m_MouseHoverFeedback = True Then
		
		If xpnl_HoverDate <> Null And xpnl_HoverDate.IsInitialized = True Then
			xpnl_HoverDate.RemoveViewFromParent
		End If
		
		Dim xlbl_Date As B4XView = xpnl_MonthDate.GetView(0)
		If xlbl_Date.Visible = False Then Return
		xpnl_HoverDate = xui.CreatePanel("")
		xpnl_MonthDate.AddView(xpnl_HoverDate,xpnl_MonthDate.Width/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,xpnl_MonthDate.Height/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,g_BodyProperties.CurrentAndSelectedDayHeight,g_BodyProperties.CurrentAndSelectedDayHeight)
		xpnl_HoverDate.SetColorAndBorder(m_SelectedDateColor,0,0,g_BodyProperties.CurrentAndSelectedDayHeight/2)
		xpnl_HoverDate.SendToBack
		xlbl_Date.TextColor = g_BodyProperties.SelectedTextColor
	End If
End Sub

Private Sub xpnl_MonthDate_MouseExited (EventData As MouseEvent)
	If xpnl_HoverDate <> Null And xpnl_HoverDate.IsInitialized And xpnl_HoverDate.Parent <> Null And xpnl_HoverDate.Parent.IsInitialized Then
		For Each View As B4XView In xpnl_HoverDate.Parent.GetAllViewsRecursive
			If "xlbl_Date" = View.Tag Then View.TextColor = g_BodyProperties.TextColor
		Next
		If xui.SubExists(mCallBack, mEventName & "_CustomDrawDay", 2) Then
			Dim xpnl_MonthDate As B4XView = xpnl_HoverDate.Parent
			xpnl_MonthDate.RemoveAllViews
			BuildDay(xpnl_MonthDate.Tag,xpnl_MonthDate)
		End If
		xpnl_HoverDate.RemoveViewFromParent
	End If
End Sub

Private Sub xpnl_MonthDate_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub xpnl_MonthDate_Click
#End If
	MonthDateClick(Sender,True)
End Sub

Private Sub MonthDateClick(xpnl_MonthDate As B4XView,WithEvent As Boolean)
	
	Dim CurrentDay As Long = xpnl_MonthDate.Tag
	If (m_MaxDate > 0 And DateUtils.SetDate(DateTime.GetYear(CurrentDay),DateTime.GetMonth(CurrentDay),DateTime.GetDayOfMonth(CurrentDay)) > DateUtils.SetDate(DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),DateTime.GetDayOfMonth(m_MaxDate))) Or (m_MinDate > 0 And DateUtils.SetDate(DateTime.GetYear(CurrentDay),DateTime.GetMonth(CurrentDay),DateTime.GetDayOfMonth(CurrentDay)) < DateUtils.SetDate(DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate),DateTime.GetDayOfMonth(m_MinDate))) Then Return
	
	Dim xlbl_Date As B4XView	
	For Each View As B4XView In xpnl_MonthDate.GetAllViewsRecursive
		If "xlbl_Date" = View.Tag Then xlbl_Date = View
	Next
	
	If xlbl_Date.Visible = False Then Return
	'Log(DateUtils.TicksToString(xpnl_MonthDate.Tag))
	If m_SelectMode = "Range" Then
		If m_SelectedDate = 0 Or xpnl_MonthDate.Tag <= m_SelectedDate Then
			If DateUtils.IsSameDay(m_SelectedDate,xpnl_MonthDate.Tag) = False Then
				m_SelectedDate = xpnl_MonthDate.Tag
				CreateSelectedDate(xpnl_MonthDate,True)
				If m_SelectedDate > m_SelectedDate2 Then
					If xpnl_SelectedDate2 <> Null And xpnl_SelectedDate2.IsInitialized = True Then xpnl_SelectedDate2.RemoveViewFromParent
					m_SelectedDate2 = 0
				End If
			Else
				If xpnl_SelectedDate <> Null And xpnl_SelectedDate.IsInitialized = True Then xpnl_SelectedDate.RemoveViewFromParent
				m_SelectedDate = 0
			End If
		Else
			If DateUtils.IsSameDay(m_SelectedDate2,xpnl_MonthDate.Tag) = False Then
				m_SelectedDate2 = xpnl_MonthDate.Tag
				CreateSelectedDate(xpnl_MonthDate,False)
			Else
				If xpnl_SelectedDate2 <> Null And xpnl_SelectedDate2.IsInitialized = True Then xpnl_SelectedDate2.RemoveViewFromParent
				m_SelectedDate2 = 0
			End If
		End If
		RefreshSelectedDate
	Else
		CreateSelectedDate(xpnl_MonthDate,True)
	End If
	
	xlbl_Date.TextColor = g_BodyProperties.SelectedTextColor
	
	If WithEvent = True Then
		If m_SelectMode = "Range" And m_SelectedDate > 0 And m_SelectedDate2 > 0 Then
			SelectedDateRangeChanged
		Else
			SelectedDateChanged(xpnl_MonthDate.Tag)
		End If
	End If
	
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawDay", 2) Then
		'xpnl_MonthDate.RemoveAllViews
		'BuildDay(xpnl_MonthDate.Tag,xpnl_MonthDate)
		
		'https://www.b4x.com/android/forum/threads/app-crash-when-using-as_datepicker-and-as_datepicker1_customdrawday-function.167208/#post-1025231
		CustomDrawDay(CurrentDay,xpnl_MonthDate)
	End If
	
End Sub

Private Sub CreateSelectedDate(xpnl_MonthDate As B4XView,FirstDatePanel As Boolean)
	
	If FirstDatePanel Then
		If xpnl_SelectedDate <> Null And xpnl_SelectedDate.IsInitialized And xpnl_SelectedDate.Parent.IsInitialized Then
			For Each View As B4XView In xpnl_SelectedDate.Parent.GetAllViewsRecursive
				If "xlbl_Date" = View.Tag Then View.TextColor = g_BodyProperties.TextColor
			Next
			xpnl_SelectedDate.RemoveViewFromParent
		End If
		Dim xpnl_selected As B4XView = xui.CreatePanel("")
		xpnl_MonthDate.AddView(xpnl_selected,xpnl_MonthDate.Width/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,xpnl_MonthDate.Height/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,g_BodyProperties.CurrentAndSelectedDayHeight,g_BodyProperties.CurrentAndSelectedDayHeight)
		xpnl_selected.SetColorAndBorder(m_SelectedDateColor,0,0,g_BodyProperties.CurrentAndSelectedDayHeight/2)
		xpnl_selected.SendToBack
		xpnl_SelectedDate = xpnl_selected
		m_SelectedDate = xpnl_MonthDate.Tag
	Else
		If xpnl_SelectedDate2 <> Null And xpnl_SelectedDate2.IsInitialized And xpnl_SelectedDate2.Parent.IsInitialized Then
			For Each View As B4XView In xpnl_SelectedDate2.Parent.GetAllViewsRecursive
				If "xlbl_Date" = View.Tag Then View.TextColor = g_BodyProperties.TextColor
			Next
			xpnl_SelectedDate2.RemoveViewFromParent
		End If
		Dim xpnl_selected As B4XView = xui.CreatePanel("")
		xpnl_MonthDate.AddView(xpnl_selected,xpnl_MonthDate.Width/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,xpnl_MonthDate.Height/2 - g_BodyProperties.CurrentAndSelectedDayHeight/2,g_BodyProperties.CurrentAndSelectedDayHeight,g_BodyProperties.CurrentAndSelectedDayHeight)
		xpnl_selected.SetColorAndBorder(m_SelectedDateColor,0,0,g_BodyProperties.CurrentAndSelectedDayHeight/2)
		xpnl_selected.SendToBack
		xpnl_SelectedDate2 = xpnl_selected
	End If

End Sub

#End Region

#Region Functions

Private Sub GetARGB(Color As Int) As Int()
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

'1 = Sunday
Public Sub GetWeekNameByIndex(Index As Int) As String
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

Private Sub GetMonthNameByIndex(index As Int) As String
	If index = 1 Then
		Return g_MonthNameShort.January
	else If index = 2 Then
		Return g_MonthNameShort.February
	else If index = 3 Then
		Return g_MonthNameShort.March
	else If index = 4 Then
		Return g_MonthNameShort.April
	else If index = 5 Then
		Return g_MonthNameShort.May
	else If index = 6 Then
		Return g_MonthNameShort.June
	else If index = 7 Then
		Return g_MonthNameShort.July
	else If index = 8 Then
		Return g_MonthNameShort.August
	else If index = 9 Then
		Return g_MonthNameShort.September
	else If index = 10 Then
		Return g_MonthNameShort.October
	else If index = 11 Then
		Return g_MonthNameShort.November
	Else
		Return g_MonthNameShort.December
	End If
End Sub

Private Sub GetWeekNumberStartingFromMonday (ticks As Long) As Int
	Dim WeekDayOfFirstDayOfYear As Int = DateTime.GetDayOfWeek(DateUtils.SetDate(DateTime.GetYear(ticks), 1, 1)) - 1
	Dim FirstMondayInYear As Int = (7 + WeekDayOfFirstDayOfYear - 1) Mod 7
	Dim result As Int
	If WeekDayOfFirstDayOfYear <> 1 Then result = result - 1
	result = result + Floor((DateTime.GetDayOfYear(ticks) - 1 + FirstMondayInYear) / 7) + 1
	Return result
End Sub

'FirstDayOfWeek:
'Friday = 1
'Thursday = 2
'Wednesday = 3
'Tuesday = 4
'Monday = 5
'Sunday = 6
'Saturday = 7
Public Sub GetFirstDayOfWeek2(Ticks As Long,FirstDayOfWeek As Int) As Long
	Dim p As Period
	p.Days = -((DateTime.GetDayOfWeek(Ticks)+FirstDayOfWeek) Mod 7) 'change to 5 to start the week from Monday
	Return DateUtils.AddPeriod(Ticks, p)
End Sub

' Compute month between 2 dates
' Version: 1, ( ) WIP (X) Release
' Prior set DateTime.DateFormat
' Date1/2: Date formatted DateTime.DateFormat
' Return: mont - 0 if same month
Private Sub MonthBetween(Date1 As Long, Date2 As Long) As Int
	Dim y As Long = DateTime.GetYear(Date2) - DateTime.GetYear(Date1)
	Dim m As Long = y * 12
	m = m - DateTime.GetMonth(Date1)
	m = m + DateTime.GetMonth(Date2)
	Return m
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

#End Region

#Region Types

'<code>AS_DatePicker1.MonthNameShort = AS_DatePicker1.CreateASDatePicker_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")</code>
Public Sub CreateASDatePicker_MonthNameShort (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASDatePicker_MonthNameShort
	Dim t1 As ASDatePicker_MonthNameShort
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
'<code>AS_DatePicker1.CreateASDatePicker_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")</code>
Public Sub CreateASDatePicker_WeekNameShort (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASDatePicker_WeekNameShort
	Dim t1 As ASDatePicker_WeekNameShort
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

Public Sub CreateASDatePicker_WeekNumberProperties (Width As Float, Color As Int, xFont As B4XFont, TextColor As Int, Text As String) As ASDatePicker_WeekNumberProperties
	Dim t1 As ASDatePicker_WeekNumberProperties
	t1.Initialize
	t1.Width = Width
	t1.Color = Color
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.Text = Text
	Return t1
End Sub

Public Sub CreateASDatePicker_HeaderProperties (Height As Float, xFont As B4XFont, TextColor As Int, ButtonIconSize As Float, ArrowsVisible As Boolean) As ASDatePicker_HeaderProperties
	Dim t1 As ASDatePicker_HeaderProperties
	t1.Initialize
	t1.Height = Height
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.ButtonIconSize = ButtonIconSize
	t1.ArrowsVisible = ArrowsVisible
	Return t1
End Sub

Public Sub CreateASDatePicker_WeekNameProperties (Color As Int, xFont As B4XFont, TextColor As Int, Height As Float) As ASDatePicker_WeekNameProperties
	Dim t1 As ASDatePicker_WeekNameProperties
	t1.Initialize
	t1.Color = Color
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.Height = Height
	Return t1
End Sub

Public Sub CreateASDatePicker_BodyProperties (xFont As B4XFont, TextColor As Int, SelectedTextColor As Int, CurrentAndSelectedDayHeight As Float) As ASDatePicker_BodyProperties
	Dim t1 As ASDatePicker_BodyProperties
	t1.Initialize
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.SelectedTextColor = SelectedTextColor
	t1.CurrentAndSelectedDayHeight = CurrentAndSelectedDayHeight
	Return t1
End Sub
#End Region

