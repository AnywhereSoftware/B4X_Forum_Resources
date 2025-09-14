B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFixes
V1.02
	-Add set Hour
	-Add set Minute
	-Add set Date
V1.03
	-Add Refresh
V1.04
	-BugFixes
	-PickerType = DatePicker - The days in the month now adjust automatically
	-Add Designer Property TextColor
	-Add Designer Property FadeColor
	-Add Designer Property HapticFeedback
V1.05
	-Add Designer Property TodayText
		-Default: Today
	-Add get and set TodayText - Call Refresh if you change something
V1.06
	-BugFixes
V1.07
	-BugFixes - AM and PM mode works now as expected
	-BugFixes - setDate Number of days is now adjusted
V1.08
	-Add get and set FadeColor
	-Add get and set TextColor
	-Add get and set SelectorColor
	-Add get and set BackgroundColor
	-MonthName now comes from the DateUtils
V1.09
	-BugFixes
V1.10
	-BugFixes
V1.11
	-Add Designer Property MinuteSteps - 1-5-10-15 Block Interval
		-Default: False
V1.12
	-BugFixes
V1.13
	-Add get WheelPicker - gets the wheelpicker to modify font etc.
V1.14
	-If a month has 30 or 28 days, then these are now no longer removed from the list, but the new EnabledRow is used and the affected items are deactivated.
		-This prevents the list from behaving in an unusual way.
	-Add MinDate and MaxDate - You can specify a DateRange what may be selected
V1.15
	-Breaking Change: You need to call Create
		-The view will not be built without it
		-Now you can make changes to the proepties without calling refresh at the beginning
		-Faster loading time
		-No crashes
	-BugFixes
	-Add Event CustomDrawItemChange
V1.16
	-New Themes - You can now switch to Light or Dark mode
		-New set Theme
		-New get Theme_Dark
		-New get Theme_Light
	-New Designer Property ThemeChangeTransition
		-Default: Fade
V1.17
	-New all designer properties, now as get and set too
	-New designer property descriptions
	-BugFixes
V1.18
	-BugFix
V1.19
	-Adjustments for AS_WheelPicker V3.25
#End If

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: Fade, List: None|Fade
#DesignerProperty: Key: PickerType, DisplayName: Picker Type, FieldType: String, DefaultValue: TimePicker, List: TimePicker|DatePicker

#DesignerProperty: Key: TodayText, DisplayName: Today Text, FieldType: String, DefaultValue: Today

#DesignerProperty: Key: TimeDivider, DisplayName: TimeDivider, FieldType: Boolean, DefaultValue: True, Description: The separator between hour and minute is usually a colon ( : )
#DesignerProperty: Key: TimeUnit, DisplayName: Time Unit, FieldType: Boolean, DefaultValue: True, Description: Display time unit (12hour 05 min) can be changed with the HourShort and MinuteShort property
#DesignerProperty: Key: AMPM, DisplayName: AM/PM, FieldType: Boolean, DefaultValue: False, Description: Show the AM and PM column
#DesignerProperty: Key: Date, DisplayName: Date, FieldType: Boolean, DefaultValue: False, Description: Show the date column in the TimePicker
'#DesignerProperty: Key: WeekDays, DisplayName: Week Days, FieldType: Boolean, DefaultValue: True, Description: Example of a boolean property.

#DesignerProperty: Key: MinuteShort, DisplayName: Minute Short, FieldType: String, DefaultValue: min
#DesignerProperty: Key: HourShort, DisplayName: Hour Short, FieldType: String, DefaultValue: hour
#DesignerProperty: Key: MinuteSteps, DisplayName: MinuteSteps, FieldType: String, DefaultValue: 1, List: 1|5|10|15

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF202125
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: DisabledTextColor, DisplayName: DisabledTextColor, FieldType: Color, DefaultValue: 0x50FFFFFF
#DesignerProperty: Key: SelectorColor, DisplayName: Selector Color, FieldType: Color, DefaultValue: 0x14FFFFFF
#DesignerProperty: Key: FadeColor, DisplayName: Fade Color, FieldType: Color, DefaultValue: 0xFF131416
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: False, Description: Enables Haptic Feedback on scrolling

#Event: SelectedTimeChanged(Hour As Int,Minute as Int)
#Event: SelectedDateChanged(Date As Long)
#Event: CustomDrawItemChange(NewItem As ASWheelPicker_CustomDraw,OldItem As ASWheelPicker_CustomDraw)

Sub Class_Globals
	
	Type ASWheelDateTimePicker_MonthNameShort(January As String,February As String,March As String,April As String,May As String,June As String, July As String,August As String, September As String,October As String,November As String, December As String)
	Type ASWheelDateTimePicker_MonthName(January As String,February As String,March As String,April As String,May As String,June As String, July As String,August As String, September As String,October As String,November As String, December As String)
	Type ASWheelDateTimePicker_WeekNameShort(Monday As String,Tuesday As String,Wednesday As String,Thursday As String,Friday As String,Saturday As String,Sunday As String)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private xpnl_WheelBackground As B4XView
	Private xwp_Wheel As ASWheelPicker
	Private xpnl_LoadingPanel As B4XView
	
	Private g_MonthNameShort As ASWheelDateTimePicker_MonthNameShort
	Private g_MonthName As ASWheelDateTimePicker_MonthName
	Private g_WeekNameShort As ASWheelDateTimePicker_WeekNameShort
	Private m_ThemeChangeTransition As String
	
	
	Private m_StartDate As Long
	Private m_PickerType As String
	Private m_TodayText As String
	Private m_TimeUnit As Boolean
	Private m_TimeDivider As Boolean
	Private m_AMPM As Boolean
	Private m_ShowDate As Boolean
'	Private m_WeekDays As Boolean
	Private m_MinuteSteps As Int
	Private m_HapticFeedback As Boolean
	Private m_BackgroundColor As Int
	Private m_SelectorColor As Int
	Private m_TextColor As Int
	Private m_DisabledTextColor As Int
	Private m_FadeColor As Int
	Private m_MinuteShort As String
	Private m_HourShort As String
	Private m_Hour,m_Minute As Int = 0
	Private m_MinDate,m_MaxDate As Long
	Private m_DateTextOrder As B4XOrderedMap
	Private isDateCreated As Boolean = False
	
	Private xiv_RefreshImage As B4XView
	
	Type AS_WheelDateTimePicker_Theme(BackgroundColor As Int,SelectorColor As Int,TextColor As Int,DisabledTextColor As Int,FadeColor As Int)
	
End Sub

Public Sub getTheme_Light As AS_WheelDateTimePicker_Theme
	
	Dim Theme As AS_WheelDateTimePicker_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_White
	Theme.SelectorColor = xui.Color_ARGB(40,0,0,0)
	Theme.TextColor = xui.Color_Black
	Theme.DisabledTextColor = xui.Color_ARGB(152,0,0,0)
	Theme.FadeColor = 0xFFe9e9e9

	Return Theme
	
End Sub

Public Sub getTheme_Dark As AS_WheelDateTimePicker_Theme
	
	Dim Theme As AS_WheelDateTimePicker_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.SelectorColor = xui.Color_ARGB(20,255,255,255)
	Theme.TextColor = xui.Color_White
	Theme.DisabledTextColor = xui.Color_ARGB(152,255,255,255)
	Theme.FadeColor = xui.Color_ARGB(255,19, 20, 22)

	Return Theme
	
End Sub

Public Sub setTheme(Theme As AS_WheelDateTimePicker_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	
	xpnl_LoadingPanel.Color = Theme.BackgroundColor
	setBackgroundColor(Theme.BackgroundColor)
	setSelectorColor(Theme.SelectorColor)
	setFadeColor(Theme.FadeColor)
	setDisabledTextColor(Theme.DisabledTextColor)
	setTextColor(Theme.TextColor)
	
	Refresh
	
	If m_ThemeChangeTransition = "Fade" Then Sleep(250)
	
	Select m_ThemeChangeTransition
		Case "None"
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select
	
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
	
	xpnl_WheelBackground = xui.CreatePanel("")
	mBase.AddView(xpnl_WheelBackground,0,0,mBase.Width,mBase.Height)

	xpnl_LoadingPanel = xui.CreatePanel("")
	xpnl_LoadingPanel.Color = m_BackgroundColor
	mBase.AddView(xpnl_LoadingPanel,0,0,mBase.Width,mBase.Height)

	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)

	'FillWheelPicker
	CreateWheelPicker

	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Private Sub IniProps(Props As Map)
	
	
	m_TodayText = Props.GetDefault("TodayText","Today")
	m_PickerType = Props.Get("PickerType")
	m_TimeUnit = Props.Get("TimeUnit")
	m_TimeDivider = Props.GetDefault("TimeDivider",False)
	m_AMPM = Props.Get("AMPM")
	m_ShowDate = Props.Get("Date")
'	m_WeekDays = Props.Get("WeekDays")
	m_MinuteShort = Props.Get("MinuteShort")
	m_HourShort = Props.Get("HourShort")
	m_HapticFeedback = Props.GetDefault("HapticFeedback",False)
	m_MinuteSteps = Props.GetDefault("MinuteSteps",1)
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition","Fade")
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor",0xFF202125))
	m_SelectorColor = xui.PaintOrColorToColor(Props.GetDefault("SelectorColor",0x14FFFFFF))
	m_TextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor",0xFFFFFFFF))
	m_DisabledTextColor = xui.PaintOrColorToColor(Props.GetDefault("DisabledTextColor",0x50FFFFFF))
	m_FadeColor = xui.PaintOrColorToColor(Props.GetDefault("FadeColor",0xFF131416))
	
	m_StartDate = DateTime.Now
	m_Hour = DateTime.GetHour(m_StartDate)
	m_Minute = DateTime.GetMinute(m_StartDate)
	
	g_MonthNameShort = CreateASWheelDateTimePicker_MonthNameShort("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec")
	
	Dim MonthNames As List = DateUtils.GetMonthsNames
	g_MonthName = CreateASWheelDateTimePicker_MonthName(MonthNames.Get(0),MonthNames.Get(1),MonthNames.Get(2),MonthNames.Get(3),MonthNames.Get(4),MonthNames.Get(5),MonthNames.Get(6),MonthNames.Get(7),MonthNames.Get(8),MonthNames.Get(9),MonthNames.Get(10),MonthNames.Get(11))
	g_WeekNameShort = CreateASWheelDateTimePicker_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")
	
	m_DateTextOrder.Initialize
	m_DateTextOrder = B4XCollections.CreateOrderedMap2(Array(1,2,3), Array("WeekName", "MonthName", "DayOfMonth"))
	m_DateTextOrder.Keys.Sort(True)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xiv_RefreshImage.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_LoadingPanel.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_WheelBackground.SetLayoutAnimated(0,0,0,Width,Height)
	SelectorDesign
	xwp_Wheel.Base_Resize(Width,Height)
End Sub

Private Sub SelectorDesign
	xwp_Wheel.SelectionBarColor = m_SelectorColor
'	xwp_Wheel.SelectorPanel.SetColorAndBorder(m_SelectorColor,0,0,5dip)
'	xwp_Wheel.SelectorPanel.SetLayoutAnimated(0,5dip,xwp_Wheel.SelectorPanel.Top,mBase.Width - 10dip,xwp_Wheel.SelectorPanel.Height)
End Sub

Private Sub CreateWheelPicker
	
	xwp_Wheel.Initialize(Me,"xwp_Wheel")

	Dim lbl As Label
	lbl.Initialize("")
	
	Dim m As Map
	m.Initialize
	
	'm.Put("WidthMode","Manual")
	
	xwp_Wheel.HapticFeedback = m_HapticFeedback
	
	xwp_Wheel.DesignerCreateView(xpnl_WheelBackground,lbl,m)
	
	xwp_Wheel.BackgroundColor = m_BackgroundColor
	xwp_Wheel.FadeColor = m_FadeColor

	Dim ItemTextProperties As ASWheelPicker_ItemTextProperties = xwp_Wheel.ItemTextProperties
	ItemTextProperties.BackgroundColor = m_BackgroundColor
	ItemTextProperties.TextColor = m_TextColor
	ItemTextProperties.DisabledTextColor = m_DisabledTextColor
	xwp_Wheel.ItemTextProperties = ItemTextProperties
	
	xwp_Wheel.SeperatorProperties.BackgroundColor = m_BackgroundColor
	xwp_Wheel.SeperatorProperties.TextColor = m_TextColor

End Sub

Public Sub Create
	'CreateWheelPicker
	FillWheelPicker
End Sub

Public Sub Refresh
	FillWheelPicker
End Sub

Private Sub FillWheelPicker
	If m_PickerType = "TimePicker" Then
	
		For i = xwp_Wheel.NumberOfColumns -1 To 0  Step -1
			xwp_Wheel.RemoveColumn(i)
		Next
	
		'Date
		If m_ShowDate = True Then
			Wait For (AddDate2TimePicker) Complete (Result As Boolean)
		End If
	
		'Hour
		Dim tmp_lst As List : tmp_lst.Initialize
		For i = 0 To IIf(m_AMPM = True,13,24) -1
			Dim Item As ASWheelPicker_Item
			Item.Initialize
			Item.Text = NumberFormat(i,2,0)
			Item.Value = i
			Item.ItemTextProperties = xwp_Wheel.ItemTextProperties
			'If m_TimeUnit Or m_TimeDivider Then
			If m_TimeUnit Then
				Item.ItemTextProperties.TextAlignment_Horizontal = "RIGHT"
			Else
				Item.ItemTextProperties.TextAlignment_Horizontal = "CENTER"
			End If
			
			tmp_lst.Add(Item)
		Next
		xwp_Wheel.SetItems(IIf(m_ShowDate,1,0),tmp_lst)
		
		If m_TimeDivider Then
			xwp_Wheel.SeperatorProperties.TextAlignment_Horizontal = "CENTER"
			xwp_Wheel.SeperatorProperties.TextFont = xui.CreateDefaultBoldFont(18)
			xwp_Wheel.SetSeperator(IIf(m_ShowDate,1,0),MeasureTextWidth(":",xwp_Wheel.SeperatorProperties.TextFont) + 2dip,":")
			xwp_Wheel.SeperatorProperties.TextFont = xui.CreateDefaultFont(12)
		End If
		
		'Minutes
		Dim tmp_lst As List : tmp_lst.Initialize
		For i = 0 To 60 -1
			
			If m_MinuteSteps = 1 Or (m_MinuteSteps > 1 And i Mod m_MinuteSteps = 0) Then
			
				Dim Item As ASWheelPicker_Item
				Item.Initialize
				Item.Text = NumberFormat(i,2,0)
				Item.Value = i
			
				Item.ItemTextProperties = xwp_Wheel.ItemTextProperties
				If m_TimeUnit Then
					Item.ItemTextProperties.TextAlignment_Horizontal = "RIGHT"
				else if  m_TimeDivider Then
					'Item.ItemTextProperties.TextAlignment_Horizontal = "LEFT"
					Item.ItemTextProperties.TextAlignment_Horizontal = "CENTER"
				Else
					Item.ItemTextProperties.TextAlignment_Horizontal = "CENTER"
				End If
			
				tmp_lst.Add(Item)
			End If
		Next
		xwp_Wheel.SetItems(IIf(m_ShowDate,2,1),tmp_lst)
	
		'AM and PM
		If m_AMPM = True Then
			xwp_Wheel.SetItems(IIf(m_ShowDate,3,2),Array As String("AM","PM"))
		End If
	
		'Space between Hour and Minutes
		
		If m_TimeUnit Then
			xwp_Wheel.SeperatorProperties.TextAlignment_Horizontal = "LEFT"
			xwp_Wheel.SetSeperator(IIf(m_ShowDate,1,0),MeasureTextWidth(" " & m_HourShort,xwp_Wheel.ItemTextProperties.TextFont) + 5dip," " & m_HourShort)
			
			Dim MinuteSeperatorWidth As Float = MeasureTextWidth(m_MinuteShort,xwp_Wheel.ItemTextProperties.TextFont)
			MinuteSeperatorWidth = (mBase.Width/xwp_Wheel.NumberOfColumns)/2
			
			
			
			xwp_Wheel.SetSeperator(IIf(m_ShowDate,2,1),MinuteSeperatorWidth," " & m_MinuteShort)
			
		Else if m_TimeDivider Then
'			xwp_Wheel.AddSeperator(1,10dip,"")
			
			If mBase.Width >= 300dip Then
				
				If m_AMPM Then
					xwp_Wheel.SetSeperator(xwp_Wheel.NumberOfColumns -1,(mBase.Width/xwp_Wheel.NumberOfColumns)/2," ")
				Else
					xwp_Wheel.SetSeperator(-1,(mBase.Width/xwp_Wheel.NumberOfColumns)/2," ")
					xwp_Wheel.SetSeperator(xwp_Wheel.NumberOfColumns -1,(mBase.Width/xwp_Wheel.NumberOfColumns)/2," ")
				End If
				

			End If

		End If
	
		'xwp_Wheel.SetWheelWidth(0,mBase.Width/2)
'		
'		For o = 0 To xwp_Wheel.NumberOfColumns -1
'			If o > 0 Then
'				xwp_Wheel.SetWheelWidth(o,(mBase.Width/2)/(xwp_Wheel.NumberOfColumns-1))
'			End If
'		Next
	
		'xwp_Wheel.AddSeperator(1,10dip,"")
		#If B4A
		Sleep(0)
		#End If
		
		If m_MinuteSteps > 1 Then
			If m_Minute Mod m_MinuteSteps <> 0 Then
				Dim rounded As Int = (Floor(m_Minute / m_MinuteSteps) + 1) * m_MinuteSteps
				If rounded = 60 Then rounded = 0
				m_Minute = rounded
			End If
		End If
		
		If m_AMPM And m_Hour > 12 Then
			xwp_Wheel.SelectRow2(IIf(m_ShowDate,1,0),m_Hour-12,False)
			xwp_Wheel.SelectRow(IIf(m_ShowDate,3,2),1,False)
		Else
			xwp_Wheel.SelectRow2(IIf(m_ShowDate,1,0),m_Hour,False)
		End If
		xwp_Wheel.SelectRow2(IIf(m_ShowDate,2,1),m_Minute,False)
		
	Else
		
		'Wait For (AddDatePicker) Complete (Result As Boolean)
		AddDatePicker
	End If

	xwp_Wheel.Refresh
	
	SelectorDesign
	
'	If (m_PickerType = "TimePicker" And m_ShowDate) Or m_PickerType = "DatePicker"  Then
'		Sleep(250)
'	Else
'		Sleep(250)
'	End If
#IF Debug
	Sleep(800)
#Else
	Sleep(250)
#End If
	xpnl_LoadingPanel.SetVisibleAnimated(250,False)
End Sub

Private Sub AddDatePicker

	For i = xwp_Wheel.NumberOfColumns -1 To 0  Step -1
		xwp_Wheel.RemoveColumn(i)
	Next
	
	Dim lstMonths As List
	lstMonths.Initialize
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.January,1))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.February,2))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.March,3))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.April,4))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.May,5))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.June,6))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.July,7))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.August,8))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.September,9))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.October,10))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.November,11))
	lstMonths.Add(xwp_Wheel.CreateASWheelPicker_Item(g_MonthName.December,12))
	xwp_Wheel.AddItems(lstMonths)
	
	Dim tmp_lst As List : tmp_lst.Initialize
	For i = 1 To 32 -1
		tmp_lst.Add(NumberFormat(i,2,0))
	Next
	xwp_Wheel.AddItems(tmp_lst)
	
	'Dim StartIndex As Int = 0
	Dim tmp_lst2 As List : tmp_lst2.Initialize
	Dim MinimumYear As Int = IIf(m_MinDate > 0,DateTime.GetYear(m_MinDate), 1700)
	Dim MaximumYear As Int = IIf(m_MaxDate > 0, DateTime.GetYear(m_MaxDate), 2200)
	#If Debug
	MinimumYear = IIf(m_MinDate > 0,DateTime.GetYear(m_MinDate),1900)
	MaximumYear = IIf(m_MaxDate > 0, DateTime.GetYear(m_MaxDate),2100)
	#End If
	For i = MinimumYear To MaximumYear
		tmp_lst2.Add(i)
		'If i = DateTime.GetYear(m_StartDate) Then StartIndex = i
	Next
	xwp_Wheel.AddItems(tmp_lst2)
	'Sleep(0)
		
		#If B4A
	Sleep(0)
	#Else IF B4I
	Sleep(0)
		#End If
		
	#If B4A
	

	Do While xwp_Wheel.GetSelectedItem(1).Value.As(Int) <> (DateTime.GetDayOfMonth(m_StartDate))
		xwp_Wheel.SelectRow(1,DateTime.GetDayOfMonth(m_StartDate)-1,False)
		Sleep(0)
	Loop

	#Else
		xwp_Wheel.SelectRow(1,DateTime.GetDayOfMonth(m_StartDate)-1,False)
	#End If
	
	xwp_Wheel.SelectRow2(0,DateTime.GetMonth(m_StartDate),False)
	xwp_Wheel.SelectRow2(2,DateTime.GetYear(m_StartDate),False)
	isDateCreated = True
End Sub

Private Sub AddDate2TimePicker As ResumableSub
	
	Dim YearGap As Int = 5
	#If Debug
	YearGap = 1
	#End If
	
	'Dim StartDate As Long = DateUtils.SetDate(DateTime.GetYear(m_StartDate)-YearGap,1,1)
	Dim StartDate As Long = IIf(m_MinDate > 0,m_MinDate, DateUtils.SetDate(DateTime.GetYear(m_StartDate)-YearGap,1,1))
	
	Dim DayCount As Int = DateUtils.PeriodBetweenInDays(StartDate,DateUtils.SetDate(DateTime.GetYear(m_StartDate)+YearGap,12,31)).Days
	Dim StartIndex As Int = 0
	
	Dim tmp_lst As List : tmp_lst.Initialize
	
	For i = 0 To DayCount -1
		
		Dim CurrentDate As Long = StartDate + DateTime.TicksPerDay*(i-1)
		
		Dim Text As String = ""
		
		If DateUtils.IsSameDay(DateTime.Now,CurrentDate) Then
			Text = m_TodayText
			StartIndex = i
			Else
			
			For Each k As Int In m_DateTextOrder.Keys
				Select m_DateTextOrder.Get(k)
					Case "WeekName"
						Text = Text & GetWeekNameByIndex(DateTime.GetDayOfWeek(CurrentDate)) & " "
					Case "MonthName"
						Text = Text & GetMonthNameByIndex(DateTime.GetMonth(CurrentDate)) & " "
					Case "DayOfMonth"
						Text = Text & DateTime.GetDayOfMonth(CurrentDate) & " "
				End Select
			Next
			Text = Text.Trim
			'Text = GetWeekNameByIndex(DateTime.GetDayOfWeek(CurrentDate)) & " " & GetMonthNameByIndex(DateTime.GetMonth(CurrentDate)) & " " & DateTime.GetDayOfMonth(CurrentDate)
		End If
		
		Dim Item As ASWheelPicker_Item
		Item.Initialize
		Item.Text = Text
		Item.Value = CurrentDate
		
		Item.ItemTextProperties = xwp_Wheel.ItemTextProperties
		Item.ItemTextProperties.TextAlignment_Horizontal = "RIGHT"
		'Item.ItemTextProperties.BackgroundColor = xui.Color_Red
		
		tmp_lst.Add(Item)
		
	Next
	
	
	Dim ListIndex As Int = 0
	xwp_Wheel.SetItems(ListIndex,tmp_lst)
	'Sleep(250)
			'#If B4A
	Sleep(0)
		'#End If
	
	xwp_Wheel.SelectRow(ListIndex,StartIndex,False)
	isDateCreated = True
Return True
	
End Sub

'Fade or None
Public Sub setThemeChangeTransition(ThemeChangeTransition As String)
	m_ThemeChangeTransition = ThemeChangeTransition
End Sub

Public Sub getThemeChangeTransition As String
	Return m_ThemeChangeTransition
End Sub

'Weekname - Fri
'Monthname - Jun
'DayOfMonth - 19
'Example:1,2,3 = Fri Jun 19
'Example:2,1,3 = Jun Fri 19
'Example:3,2,1 = 19 Jun Fri
Public Sub SetDateTextOrder(WeekName As Int,MonthName As Int,DayOfMonth As Int)
	m_DateTextOrder = B4XCollections.CreateOrderedMap2(Array(WeekName, MonthName, DayOfMonth), Array("WeekName", "MonthName", "DayOfMonth"))
	m_DateTextOrder.Keys.Sort(True)
End Sub

Public Sub getWheelPicker As ASWheelPicker
	Return xwp_Wheel
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
	mBase.Color = Color
	xpnl_WheelBackground.Color = Color
	xwp_Wheel.SeperatorProperties.BackgroundColor = m_BackgroundColor
	xwp_Wheel.BackgroundColor = m_BackgroundColor
	Dim ItemTextProperties As ASWheelPicker_ItemTextProperties = xwp_Wheel.ItemTextProperties
	ItemTextProperties.BackgroundColor = Color
	xwp_Wheel.ItemTextProperties = ItemTextProperties
End Sub

Public Sub getSelectorColor As Int
	Return m_SelectorColor
End Sub

Public Sub setSelectorColor(Color As Int)
	m_SelectorColor = Color
	SelectorDesign
End Sub

Public Sub getTextColor As Int
	Return m_TextColor
End Sub

Public Sub setTextColor(Color As Int)
	m_TextColor = Color
	xwp_Wheel.SeperatorProperties.TextColor = m_TextColor
	Dim ItemTextProperties As ASWheelPicker_ItemTextProperties = xwp_Wheel.ItemTextProperties
	ItemTextProperties.TextColor = Color
	xwp_Wheel.ItemTextProperties = ItemTextProperties
End Sub

Public Sub getDisabledTextColor As Int
	Return m_DisabledTextColor
End Sub

Public Sub setDisabledTextColor(Color As Int)
	m_DisabledTextColor = Color
	Dim ItemTextProperties As ASWheelPicker_ItemTextProperties = xwp_Wheel.ItemTextProperties
	ItemTextProperties.DisabledTextColor = Color
	xwp_Wheel.ItemTextProperties = ItemTextProperties
End Sub

Public Sub getFadeColor As Int
	Return m_FadeColor
End Sub

Public Sub setFadeColor(Color As Int)
	m_FadeColor = Color
	xwp_Wheel.FadeColor = Color
End Sub

'Call Refresh if you change something
Public Sub getTodayText As String
	Return m_TodayText
End Sub

Public Sub setTodayText(Text As String)
	m_TodayText = Text
End Sub

Public Sub getMonthNameShort As ASWheelDateTimePicker_MonthNameShort
	Return g_MonthNameShort
End Sub

Public Sub setMonthNameShort(MonthName As ASWheelDateTimePicker_MonthNameShort)
	g_MonthNameShort= MonthName
End Sub

Public Sub getMonthName As ASWheelDateTimePicker_MonthName
	Return g_MonthName
End Sub

Public Sub setMonthName(MonthName As ASWheelDateTimePicker_MonthName)
	g_MonthName = MonthName
End Sub

Public Sub getWeekNameShort As ASWheelDateTimePicker_WeekNameShort
	Return g_WeekNameShort
End Sub

Public Sub setWeekNameShort(WeekNameShort As ASWheelDateTimePicker_WeekNameShort)
	g_WeekNameShort = WeekNameShort
End Sub

Public Sub getHapticFeedback As Boolean
	Return m_HapticFeedback
End Sub

Public Sub setHapticFeedback(Enabled As Boolean)
	m_HapticFeedback = Enabled
	xwp_Wheel.HapticFeedback = Enabled
End Sub

Public Sub getHour As Int
	Return xwp_Wheel.GetSelectedItem(0).Value
End Sub

Public Sub getMinute As Int
	Return xwp_Wheel.GetSelectedItem(1).Value
End Sub

Public Sub getMinDate As Long
	Return m_MinDate
End Sub

Public Sub getMaxDate As Long
	Return m_MaxDate
End Sub
'Call Refresh if you change something
Public Sub setMinDate(Date As Long)
	m_MinDate = Date
End Sub
'Call Refresh if you change something
Public Sub setMaxDate(Date As Long)
	m_MaxDate = Date
End Sub

Public Sub setHour(Hour As Int)
	m_Hour = Hour
	If m_PickerType = "TimePicker" Then		
		
		#If Debug
		Sleep(0)
		#End If
		
		If m_AMPM Then
			
			If Hour > 12 Then
				Hour = Hour - 12
				xwp_Wheel.SelectRow(IIf(m_ShowDate,3,2),1,False)
				Else
				xwp_Wheel.SelectRow(IIf(m_ShowDate,3,2),0,False)
			End If
			
		End If
		
		xwp_Wheel.SelectRow(IIf(m_ShowDate,1,0),Hour,False)
	End If
End Sub

Public Sub setMinute(Minute As Int)
	m_Minute = Minute
	If m_PickerType = "TimePicker" Then
		
		If m_MinuteSteps > 1 Then
			m_Minute = m_Minute - (Minute Mod m_MinuteSteps)
		End If
		
		#If Debug
		Sleep(0)
		#End If
		xwp_Wheel.SelectRow2(IIf(m_ShowDate,2,1),m_Minute,False)
		
	End If
End Sub

Public Sub setDate(Date As Long)
	
	If isDateCreated Then
	
		If m_PickerType = "TimePicker" And m_ShowDate Then
			xwp_Wheel.SelectRow2(0,Date,False)
		Else if m_PickerType = "DatePicker" Then

			Dim MinimumYear As Int = xwp_Wheel.GetItem(2,0).Value

			xwp_Wheel.SelectRow2(0,DateTime.GetMonth(Date) -1,False)
			xwp_Wheel.SelectRow2(1,DateTime.GetDayOfMonth(Date) -1,False)
			xwp_Wheel.SelectRow2(2,DateTime.GetYear(Date) - MinimumYear,False)
		
			ItemChange(0,DateTime.GetMonth(Date) -1,False)
			ItemChange(1,DateTime.GetDayOfMonth(Date) -1,False)
			ItemChange(2,DateTime.GetYear(Date) -1,False)
			
		End If
	
	Else
		
		m_StartDate = Date
		
	End If
	
End Sub

Public Sub getDate As Long
	Dim Date As Long = 0
	If m_PickerType = "TimePicker" And m_ShowDate Then
		Date = DateUtils.SetDateAndTime(DateTime.GetYear(xwp_Wheel.GetSelectedItem(0).Value),DateTime.GetMonth(xwp_Wheel.GetSelectedItem(0).Value),DateTime.GetDayOfMonth(xwp_Wheel.GetSelectedItem(0).Value),xwp_Wheel.GetSelectedItem(1).Value,xwp_Wheel.GetSelectedItem(2).Value,0)
	Else if m_PickerType = "DatePicker" Then
		
		Dim Month As Int = xwp_Wheel.GetSelectedItem(0).Value
		Dim Day As Int = xwp_Wheel.GetSelectedItem(1).Value
		Dim Year As Int = xwp_Wheel.GetSelectedItem(2).Value
		
		Date = DateUtils.SetDate(Year,Month,Min(DateUtils.NumberOfDaysInMonth(Month,Year), Day))
		
		If m_MaxDate > 0 And DateUtils.IsSameDay(Date,m_MaxDate) = False And Date > m_MaxDate Then Date = m_MaxDate
		If m_MinDate > 0 And DateUtils.IsSameDay(Date,m_MaxDate) = False And Date < m_MinDate Then Date = m_MinDate
		
	End If
	Return Date
End Sub

'Call Refresh if you change something
Public Sub getPickerType As String
	Return m_PickerType
End Sub

Public Sub setPickerType(PickerType As String)
	m_PickerType = PickerType
End Sub

'The separator between hour and minute is usually a colon ( : )
Public Sub getShowTimeDivider As Boolean
	Return m_TimeDivider
End Sub

Public Sub setShowTimeDivider(TimeDivider As Boolean)
	m_TimeDivider = TimeDivider
End Sub

'Display time unit (12hour 05 min) can be changed with the HourShort and MinuteShort property
Public Sub getShowTimeUnit As Boolean
	Return m_TimeUnit
End Sub

Public Sub setShowTimeUnit(TimeUnit As Boolean)
	m_TimeUnit = TimeUnit
End Sub

'Show the AM and PM column
Public Sub getShowAMPM As Boolean
	Return m_AMPM
End Sub

Public Sub setShowAMPM(AMPM As Boolean)
	m_AMPM = AMPM
End Sub

'Show the date column in the TimePicker
Public Sub getShowDate As Boolean
	Return m_ShowDate
End Sub

Public Sub setShowDate(Show As Boolean)
	m_ShowDate = Show
End Sub

Public Sub getMinuteShortText As String
	Return m_MinuteShort
End Sub

Public Sub setMinuteShortText(MinuteShort As String)
	m_MinuteShort = MinuteShort
End Sub

Public Sub getHourShortText As String
	Return m_HourShort
End Sub

Public Sub setHourShortText(HourShort As String)
	m_HourShort = HourShort
End Sub

Public Sub getMinuteSteps As Int
	Return m_MinuteSteps
End Sub

Public Sub setMinuteSteps(MinuteSteps As Int)
	m_MinuteSteps = MinuteSteps
End Sub

#Region ViewEvents

Private Sub ItemChange(Column As Int,Row As Int,Event As Boolean)'ignore
	If Event Then SelectedTimeChanged
	
	If m_PickerType = "DatePicker" Then
		'xwp_Wheel.GetSelectedItem(0).Value
		
		If Column = 2 Or Column = 0 Then
			
			Dim ItemProps As ASWheelPicker_ItemTextProperties = xwp_Wheel.ItemTextProperties
			ItemProps.Width = xwp_Wheel.GetItem(1,1).ItemTextProperties.Width
			xwp_Wheel.ItemTextProperties = ItemProps
			
			'Dim NumerOfDaysInMonth As Int = DateUtils.NumberOfDaysInMonth(xwp_Wheel.GetSelectedItem(0).Value,xwp_Wheel.GetSelectedItem(2).Value)
			
'			If (xwp_Wheel.GetListView(1).Size -2) < NumerOfDaysInMonth Then
'			
'				For i = (xwp_Wheel.GetListView(1).Size -1) To (NumerOfDaysInMonth+1) -1
'				
'					Dim Item As ASWheelPicker_Item
'					Item.Initialize
'					Item.Text = NumberFormat(i,2,0)
'					Item.Value = i
'					Item.ItemTextProperties = xwp_Wheel.ItemTextProperties
'				
'					xwp_Wheel.AddItemAt(1,i,Item)
'				Next
'				xwp_Wheel.GetListView(1).Refresh
'			Else
'				
''				For i = (xwp_Wheel.GetListView(1).Size-1) -1 To (NumerOfDaysInMonth+1) Step -1
''					xwp_Wheel.RemoveItemAt(1,i)
''				Next
'				
'			End If
			
'			If xwp_Wheel.GetIndex(1) >= xwp_Wheel.Size(1) Then
'				xwp_Wheel.SelectRow(1,xwp_Wheel.Size(1)-1,False)
'			End If
		
		

		End If
		
	End If
	
	If Event Then SelectedDateChanged
End Sub

Private Sub xwp_Wheel_ItemChange(Column As Int,ListIndex As Int)

	ItemChange(Column,ListIndex,True)
		
	Sleep(0)
	
	If m_PickerType = "TimePicker" And m_ShowDate Then

	Else if m_PickerType = "DatePicker" Then

		Dim MaxDay As Int = DateUtils.NumberOfDaysInMonth(DateTime.GetMonth(getDate),DateTime.GetYear(getDate))
		
		For i = xwp_Wheel.Size(1) To MaxDay Step -1
			xwp_Wheel.EnabledRow(1,i,False)
		Next
		
		For i = 0 To MaxDay -1
			xwp_Wheel.EnabledRow(1,i,True)
		Next
			
		If m_MinDate > 0 Or m_MaxDate > 0 Then
			
'			Log(DateTime.GetYear(getDate))
'			Log(DateTime.GetYear(m_MaxDate))
			
			Dim MaxMonth As Int = IIf(m_MaxDate > 0 And DateTime.GetYear(getDate) = DateTime.GetYear(m_MaxDate),DateTime.GetMonth(m_MaxDate),12)
			Dim MinMonth As Int = IIf(m_MinDate > 0 And DateTime.GetYear(getDate) = DateTime.GetYear(m_MinDate),DateTime.GetMonth(m_MinDate)-1,0)
			
			For i = xwp_Wheel.Size(0) To MaxMonth Step -1
				xwp_Wheel.EnabledRow(0,i,False)
			Next
			 
			For i = 0 To MaxMonth -1
				xwp_Wheel.EnabledRow(0,i,True)
			Next
			 
			For i = 0 To MinMonth -1
				xwp_Wheel.EnabledRow(0,i,False)
			Next
			 
			For i = MinMonth To MaxMonth -1
				xwp_Wheel.EnabledRow(0,i,True)
			Next
			 
			Dim MaxDays As Int = IIf(m_MaxDate > 0 And DateTime.GetYear(getDate) = DateTime.GetYear(m_MaxDate) And DateTime.GetMonth(getDate) = DateTime.GetMonth(m_MaxDate),DateTime.GetDayOfMonth(m_MaxDate),DateUtils.NumberOfDaysInMonth(DateTime.GetMonth(getDate),DateTime.GetYear(getDate)))
			Dim MinDays As Int = IIf(m_MinDate > 0 And DateTime.GetYear(getDate) = DateTime.GetYear(m_MinDate) And DateTime.GetMonth(getDate) = DateTime.GetMonth(m_MinDate),DateTime.GetDayOfMonth(m_MinDate)-1,0)
			
			For i = xwp_Wheel.Size(1) To MaxDays Step -1
				xwp_Wheel.EnabledRow(1,i,False)
			Next
		
			For i = 0 To MaxDays -1
				xwp_Wheel.EnabledRow(1,i,True)
			Next
			 
			For i = 0 To MinDays -1
				xwp_Wheel.EnabledRow(1,i,False)
			Next
			 
			For i = MinDays To MaxDays -1
				xwp_Wheel.EnabledRow(1,i,True)
			Next
			 
		End If
			
	End If
	
End Sub

#End Region

#Region Events

Private Sub xwp_Wheel_CustomDrawItemChange(NewItem As ASWheelPicker_CustomDraw,OldItem As ASWheelPicker_CustomDraw)
	CustomDrawItemChange(NewItem,OldItem)
End Sub

Private Sub CustomDrawItemChange(NewItem As ASWheelPicker_CustomDraw,OldItem As ASWheelPicker_CustomDraw)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawItemChange", 2) Then
		CallSub3(mCallBack, mEventName & "_CustomDrawItemChange",NewItem,OldItem)
	End If
End Sub

Private Sub SelectedTimeChanged
	If xui.SubExists(mCallBack, mEventName & "_SelectedTimeChanged", 2) And m_PickerType = "TimePicker" Then
		Dim str_1 As String = xwp_Wheel.GetSelectedItem(IIf(m_ShowDate,1,0)).Value
		Dim str_2 As String = xwp_Wheel.GetSelectedItem(IIf(m_ShowDate,2,1)).Value
		If IsNumber(str_1) And IsNumber(str_2) Then			
			CallSub3(mCallBack, mEventName & "_SelectedTimeChanged",xwp_Wheel.GetSelectedItem(IIf(m_ShowDate,1,0)).Value.As(Int),xwp_Wheel.GetSelectedItem(IIf(m_ShowDate,2,1)).Value.As(Int))
		End If
	End If
End Sub

Private Sub SelectedDateChanged
	If xui.SubExists(mCallBack, mEventName & "_SelectedDateChanged", 1) Then
		Dim Date As Long = 0
		If m_PickerType = "TimePicker" And m_ShowDate Then
			Dim str_1 As String = xwp_Wheel.GetSelectedItem(0).Value
			Dim str_2 As String = xwp_Wheel.GetSelectedItem(1).Value
			If IsNumber(str_1) And IsNumber(str_2) Then
				Date = DateUtils.SetDateAndTime(DateTime.GetYear(xwp_Wheel.GetSelectedItem(0).Value),DateTime.GetMonth(xwp_Wheel.GetSelectedItem(0).Value),DateTime.GetDayOfMonth(xwp_Wheel.GetSelectedItem(0).Value),xwp_Wheel.GetSelectedItem(1).Value,xwp_Wheel.GetSelectedItem(2).Value,0)
			End If
		Else if m_PickerType = "DatePicker" Then
			Dim str_1 As String = xwp_Wheel.GetSelectedItem(2).Value
			Dim str_2 As String = xwp_Wheel.GetSelectedItem(1).Value
			If IsNumber(str_1) And IsNumber(str_2) Then
				
				Dim Month As Int = xwp_Wheel.GetSelectedItem(0).Value
				Dim Day As Int = xwp_Wheel.GetSelectedItem(1).Value
				Dim Year As Int = xwp_Wheel.GetSelectedItem(2).Value
				
				Date = DateUtils.SetDate(xwp_Wheel.GetSelectedItem(2).Value,xwp_Wheel.GetSelectedItem(0).Value,Min(DateUtils.NumberOfDaysInMonth(Month,Year),Day))
			End If
		End If
		If Date = 0 Then Return
		CallSub2(mCallBack, mEventName & "_SelectedDateChanged",Date)
	End If
End Sub

#End Region

#Region Enums

Public Sub getThemeChangeTransition_Fade As String
	Return "Fade"
End Sub

Public Sub getThemeChangeTransition_None As String
	Return "None"
End Sub

Public Sub getPickerType_TimePicker As String
	Return "TimePicker"
End Sub

Public Sub getPickerType_DatePicker As String
	Return "DatePicker"
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

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
    Private bmp As Bitmap
    bmp.InitializeMutable(2dip, 2dip)
    Private cvs As Canvas
    cvs.Initialize2(bmp)
    Return cvs.MeasureStringWidth(Text, Font1.ToNativeFont, Font1.Size)
#Else If B4i
	Return Text.MeasureWidth(Font1.ToNativeFont)
#Else If B4J
    Dim jo As JavaObject
    jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
    jo.RunMethod("setFont",Array(Font1.ToNativeFont))
    jo.RunMethod("setLineSpacing",Array(0.0))
    jo.RunMethod("setWrappingWidth",Array(0.0))
    Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
    Return Bounds.RunMethod("getWidth",Null)
#End If
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

#End Region


Public Sub CreateASWheelDateTimePicker_MonthNameShort (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASWheelDateTimePicker_MonthNameShort
	Dim t1 As ASWheelDateTimePicker_MonthNameShort
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

Public Sub CreateASWheelDateTimePicker_WeekNameShort (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As ASWheelDateTimePicker_WeekNameShort
	Dim t1 As ASWheelDateTimePicker_WeekNameShort
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

Public Sub CreateASWheelDateTimePicker_MonthName (January As String, February As String, March As String, April As String, May As String, June As String, July As String, August As String, September As String, October As String, November As String, December As String) As ASWheelDateTimePicker_MonthName
	Dim t1 As ASWheelDateTimePicker_MonthName
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