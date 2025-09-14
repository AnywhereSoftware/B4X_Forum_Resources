B4i=true
Group=Views
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
'AS_WeekdaySelector
'Author: Alexander Stolte
'Version: V1.01

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-New get and set BodySelectedTextColor
	-New Themes - You can now switch to Light or Dark mode
	-New set Theme
	-New get Theme_Dark
	-New get Theme_Light
	-New Designer Property ThemeChangeTransition
		-Default: None
	-New ClearSelections
	-New SelectWeekDay - Values are between 1 to 7, where 1 means sunday
	-New SelectWeekDay2 - Selects the day of the week by date
#End If

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: None, List: None|Fade
#DesignerProperty: Key: FirstDayOfWeek, DisplayName: First Day of Week, FieldType: String, DefaultValue: Monday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
#DesignerProperty: Key: HeaderText, DisplayName: HeaderText, FieldType: String, DefaultValue: WeekDay, List: WeekDay|DayOfMonth|None
#DesignerProperty: Key: BodyText, DisplayName: BodyText, FieldType: String, DefaultValue: DayOfMonth, List: WeekDay|DayOfMonth|None
#DesignerProperty: Key: ClickAmount, DisplayName: ClickAmount, FieldType: Int, DefaultValue: 2, MinRange: 1, MaxRange: 2, Description: Note that MinRange and MaxRange are optional.
#DesignerProperty: Key: NormalColor, DisplayName: NormalColor, FieldType: Color, DefaultValue: 0xFF343434, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: FirstClickColor, DisplayName: FirstClickColor, FieldType: Color, DefaultValue: 0x642D8879, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SecondClickColor, DisplayName: SecondClickColor, FieldType: Color, DefaultValue: 0xFF2D8879, Description: You can use the built-in color picker to find the color values.

#DesignerProperty: Key: HeaderTextColor, DisplayName: HeaderTextColor, FieldType: Color, DefaultValue: 0x87FFFFFF
#DesignerProperty: Key: BodyTextColor, DisplayName: BodyTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: BodySelectedTextColor, DisplayName: BodySelectedTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#Event: WeekDayClicked(WeekDay As AS_WeekdaySelector_WeekDay,ClickState As Int)

Sub Class_Globals
	
	Type AS_WeekdaySelector_WeekNameShort(Monday As String,Tuesday As String,Wednesday As String,Thursday As String,Friday As String,Saturday As String,Sunday As String)
	Type AS_WeekdaySelector_WeekNameLong(Monday As String,Tuesday As String,Wednesday As String,Thursday As String,Friday As String,Saturday As String,Sunday As String)
	Type AS_WeekdaySelector_WeekDay(DayInWeek As Int,Date As Long,WeekNameShort As String,WeekNameLong As String)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private g_WeekNameShort As AS_WeekdaySelector_WeekNameShort
	Private g_WeekNameLong As AS_WeekdaySelector_WeekNameLong
	Private m_WeekNameShortList As List
	Private m_WeekNameLongList As List
	Private m_SelectionMap As Map
	
	Private xpnl_Background As B4XView
	
	Private m_HeaderText As String
	Private m_BodyText As String
	Private m_FirstDayOfWeek As Int
	Private m_NormalColor As Int
	Private m_FirstClickColor As Int
	Private m_SecondClickColor As Int
	Private m_HeaderTextColor As Int
	Private m_BodyTextColor As Int
	Private m_BodySelectedTextColor As Int
	Private m_Week As Long
	Private m_ClickAmount As Int
	Private m_ThemeChangeTransition As String
	
	Private xiv_RefreshImage As B4XView
	
	Type AS_WeekdaySelector_Theme(BackgroundColor As Int,NormalColor As Int,HeaderTextColor As Int,BodyTextColor As Int,BodySelectedTextColor As String)
	
End Sub

Public Sub setTheme(Theme As AS_WeekdaySelector_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)

	xpnl_Background.Color = Theme.BackgroundColor
	m_BodyTextColor = Theme.BodyTextColor
	m_HeaderTextColor = Theme.HeaderTextColor
	m_NormalColor = Theme.NormalColor
	m_BodySelectedTextColor = Theme.BodySelectedTextColor
	
	
	Sleep(0)
	
	CreateWeek

	Select m_ThemeChangeTransition
		Case "None"
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			Sleep(250)
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select

End Sub

Public Sub getTheme_Dark As AS_WeekdaySelector_Theme
	
	Dim Theme As AS_WeekdaySelector_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	Theme.NormalColor = 0xFF343434
	Theme.HeaderTextColor = xui.Color_White
	Theme.BodyTextColor = xui.Color_White
	Theme.BodySelectedTextColor = xui.Color_White
	
	Return Theme
	
End Sub

Public Sub getTheme_Light As AS_WeekdaySelector_Theme
	
	Dim Theme As AS_WeekdaySelector_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_White
	Theme.NormalColor = xui.Color_ARGB(255,233, 233, 233)
	Theme.HeaderTextColor = xui.Color_Black
	Theme.BodyTextColor = xui.Color_Black
	Theme.BodySelectedTextColor = xui.Color_White
	
	Return Theme
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	m_WeekNameShortList.Initialize
	m_WeekNameLongList.Initialize
	m_SelectionMap.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
  
	IniProps(Props)
  
	xpnl_Background = xui.CreatePanel("")
	mBase.AddView(xpnl_Background,0,0,mBase.Width,mBase.Height)
  
	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)
  
	CreateWeek
  
End Sub

Private Sub CreateWeek
	
	xpnl_Background.RemoveAllViews
	Dim tmpList As List = GenerateWeekDayList
  
	Dim HeaderHeight As Float = IIf(m_HeaderText = "None",0,20dip)
	Dim WeekDayHeight As Float = 40dip
	Dim GapBetween As Float = 5dip
  
	For Each i As Int In tmpList
		
		Dim xpnl_WeekDayBackground As B4XView = xui.CreatePanel("")
		xpnl_Background.AddView(xpnl_WeekDayBackground,(mBase.Width/7)*i,0,mBase.Width/7,mBase.Height)
		xpnl_WeekDayBackground.Tag = tmpList.Get(i)
		Dim xlbl_HeaderText As B4XView = CreateLabel("")
		xpnl_WeekDayBackground.AddView(xlbl_HeaderText,0,0,xpnl_WeekDayBackground.Width,HeaderHeight)
		
		xlbl_HeaderText.TextColor = m_HeaderTextColor
		xlbl_HeaderText.SetTextAlignment("CENTER","CENTER")
		xlbl_HeaderText.Font = xui.CreateDefaultFont(14)
		
		Dim xlbl_WeekDay As B4XView = CreateLabel("xlbl_WeekDay")
		xpnl_WeekDayBackground.AddView(xlbl_WeekDay,xpnl_WeekDayBackground.Width/2 - WeekDayHeight/2,IIf(m_HeaderText = "None",xpnl_WeekDayBackground.Height/2-WeekDayHeight/2,HeaderHeight + GapBetween),WeekDayHeight,WeekDayHeight)
		xlbl_WeekDay.Text = m_WeekNameShortList.Get(tmpList.Get(i))
		xlbl_WeekDay.TextColor = m_BodyTextColor
		xlbl_WeekDay.SetTextAlignment("CENTER","CENTER")
		xlbl_WeekDay.Font = xui.CreateDefaultBoldFont(15)
		xlbl_WeekDay.SetColorAndBorder(m_NormalColor,0,0,xlbl_WeekDay.Height/2)
		xlbl_WeekDay.Tag = 0
		
		Select m_HeaderText
			Case "None"
				xlbl_HeaderText.Text = ""
			Case "WeekDay"
				xlbl_HeaderText.Text = m_WeekNameShortList.Get(tmpList.Get(i))
			Case "DayOfMonth"
				xlbl_HeaderText.Text = DateTime.GetDayOfMonth(GetFirstDayOfWeek2(m_Week,m_FirstDayOfWeek)+DateTime.TicksPerDay*i)
		End Select
		
		Select m_BodyText
			Case "None"
				xlbl_WeekDay.Text = ""
			Case "WeekDay"
				xlbl_WeekDay.Text = m_WeekNameShortList.Get(tmpList.Get(i))
			Case "DayOfMonth"
				xlbl_WeekDay.Text = DateTime.GetDayOfMonth(GetFirstDayOfWeek2(m_Week,m_FirstDayOfWeek)+DateTime.TicksPerDay*i)
		End Select
		
		Dim WeekDay As AS_WeekdaySelector_WeekDay
		WeekDay.Initialize
		WeekDay.Date = JustDate(GetFirstDayOfWeek2(m_Week,m_FirstDayOfWeek)+DateTime.TicksPerDay*i)
		WeekDay.DayInWeek = DateTime.GetDayOfWeek(WeekDay.Date)
		WeekDay.WeekNameShort = m_WeekNameShortList.Get(tmpList.Get(i))
		WeekDay.WeekNameLong = m_WeekNameLongList.Get(tmpList.Get(i))
		xpnl_WeekDayBackground.Tag = WeekDay
		
		If m_SelectionMap.ContainsKey(WeekDay.Date) Then
		
			If m_SelectionMap.Get(WeekDay.Date).As(Int) = 1 Then
				xlbl_WeekDay.SetColorAnimated(0,xlbl_WeekDay.Color,m_FirstClickColor)
				xlbl_WeekDay.TextColor = m_BodySelectedTextColor
				xlbl_WeekDay.Tag = 1
			else If m_SelectionMap.Get(WeekDay.Date).As(Int) = 2 And m_ClickAmount = 2 Then
				xlbl_WeekDay.SetColorAnimated(0,xlbl_WeekDay.Color,m_SecondClickColor)
				xlbl_WeekDay.TextColor = m_BodySelectedTextColor
				xlbl_WeekDay.Tag = 2
			Else
				xlbl_WeekDay.SetColorAnimated(0,xlbl_WeekDay.Color,m_NormalColor)
				xlbl_WeekDay.TextColor = m_BodyTextColor
				xlbl_WeekDay.Tag = 0
			End If
		
		End If
		
	Next
	
End Sub

Private Sub JustDate(Date As Long) As Long
	Return DateUtils.SetDate(DateTime.GetYear(Date),DateTime.GetMonth(Date),DateTime.GetDayOfMonth(Date))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	xiv_RefreshImage.SetLayoutAnimated(0,0,0,Width,Height)
  
End Sub

#IF B4J
Private Sub xlbl_WeekDay_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_WeekDay_Click
#End If
	Dim xlbl_WeekDay As B4XView = Sender
	Dim ThisDate As Long = JustDate(xlbl_WeekDay.Parent.Tag.As(AS_WeekdaySelector_WeekDay).Date)
	If xlbl_WeekDay.Tag.As(Int) = 0 Then
		xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_FirstClickColor)
		xlbl_WeekDay.TextColor = m_BodySelectedTextColor
		xlbl_WeekDay.Tag = 1
		m_SelectionMap.Put(ThisDate,1)
	else If xlbl_WeekDay.Tag.As(Int) = 1 And m_ClickAmount = 2 Then
		xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_SecondClickColor)
		xlbl_WeekDay.TextColor = m_BodySelectedTextColor
		xlbl_WeekDay.Tag = 2
		m_SelectionMap.Put(ThisDate,2)
	Else
		xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_NormalColor)
		xlbl_WeekDay.TextColor = m_BodyTextColor
		xlbl_WeekDay.Tag = 0
		m_SelectionMap.Remove(ThisDate)
	End If
	WeekDayClicked(xlbl_WeekDay.Parent.Tag,xlbl_WeekDay.Tag)
End Sub

'Values are between 1 to 7, where 1 means sunday
Public Sub SelectWeekDay(WeekDay As Int)
	For i = 0 To xpnl_Background.NumberOfViews -1
		Dim WeekDayItem As AS_WeekdaySelector_WeekDay = xpnl_Background.GetView(i).Tag
		If WeekDayItem.DayInWeek = WeekDay Then
			Dim xlbl_WeekDay As B4XView = xpnl_Background.GetView(i).GetView(1)
			xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_FirstClickColor)
			xlbl_WeekDay.Tag = 1
			m_SelectionMap.Put(WeekDayItem.Date,1)
			Exit
		End If
	Next
End Sub

'Selects the day of the week by date
Public Sub SelectWeekDay2(Date As Long)
	For i = 0 To xpnl_Background.NumberOfViews -1
		Dim WeekDayItem As AS_WeekdaySelector_WeekDay = xpnl_Background.GetView(i).Tag
		If WeekDayItem.Date = DateUtils.SetDate(DateTime.GetYear(Date),DateTime.GetMonth(Date),DateTime.GetDayOfMonth(Date)) Then
			Dim xlbl_WeekDay As B4XView = xpnl_Background.GetView(i).GetView(1)
			xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_FirstClickColor)
			xlbl_WeekDay.Tag = 1
			m_SelectionMap.Put(WeekDayItem.Date,1)
			Exit
		End If
	Next
End Sub

Public Sub getSelectedWeekDays As List
	Dim lst_WeekDays As List
	lst_WeekDays.Initialize
	For i = 0 To xpnl_Background.NumberOfViews -1
		If 1 = xpnl_Background.GetView(i).GetView(1).tag Or 2 = xpnl_Background.GetView(i).GetView(1).tag Then
			lst_WeekDays.Add(xpnl_Background.GetView(i).Tag)
		End If
	Next
	Return lst_WeekDays
End Sub

Private Sub GenerateWeekDayList As List

	Dim tmpList As List
	tmpList.Initialize
	
	Dim startIndex As Int = (m_FirstDayOfWeek - 1) Mod 7

	For i = 0 To 6
		Dim index As Int = (startIndex + i) Mod 7
		tmpList.Add(index)
	Next

	Return tmpList

End Sub

Private Sub IniProps(Props As Map)
	
	m_Week = DateTime.Now
	m_HeaderText = Props.Get("HeaderText")
	m_BodyText = Props.Get("BodyText")
	m_ClickAmount = Props.Get("ClickAmount")
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition","None")

	m_NormalColor = xui.PaintOrColorToColor(Props.Get("NormalColor"))
	m_FirstClickColor = xui.PaintOrColorToColor(Props.Get("FirstClickColor"))
	m_SecondClickColor = xui.PaintOrColorToColor(Props.Get("SecondClickColor"))
	m_HeaderTextColor = xui.PaintOrColorToColor(Props.Get("HeaderTextColor"))
	m_BodyTextColor = xui.PaintOrColorToColor(Props.Get("BodyTextColor"))
	m_BodySelectedTextColor = xui.PaintOrColorToColor(Props.GetDefault("BodySelectedTextColor",xui.Color_White))

	If "Sunday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 1
	Else If "Monday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 2
	Else If "Tuesday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 3
	Else If "Wednesday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 4
	Else If "Thursday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 5
	Else If "Friday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 6
	Else If "Saturday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 7
	End If
	
	g_WeekNameShort = CreateWeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")
	g_WeekNameLong = CreateWeekNameLong("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
	RefreshWeekNameShort
End Sub

Private Sub RefreshWeekNameShort
	m_WeekNameShortList.Clear
	m_WeekNameShortList.Add(g_WeekNameShort.Sunday)
	m_WeekNameShortList.Add(g_WeekNameShort.Monday)
	m_WeekNameShortList.Add(g_WeekNameShort.Tuesday)
	m_WeekNameShortList.Add(g_WeekNameShort.Wednesday)
	m_WeekNameShortList.Add(g_WeekNameShort.Thursday)
	m_WeekNameShortList.Add(g_WeekNameShort.Friday)
	m_WeekNameShortList.Add(g_WeekNameShort.Saturday)
	
	m_WeekNameLongList.Clear
	m_WeekNameLongList.Add(g_WeekNameLong.Sunday)
	m_WeekNameLongList.Add(g_WeekNameLong.Monday)
	m_WeekNameLongList.Add(g_WeekNameLong.Tuesday)
	m_WeekNameLongList.Add(g_WeekNameLong.Wednesday)
	m_WeekNameLongList.Add(g_WeekNameLong.Thursday)
	m_WeekNameLongList.Add(g_WeekNameLong.Friday)
	m_WeekNameLongList.Add(g_WeekNameLong.Saturday)
End Sub

#Region Properties



Public Sub ClearSelections
	m_SelectionMap.Clear
	CreateWeek
End Sub

'Fade or None
Public Sub setThemeChangeTransition(ThemeChangeTransition As String)
	m_ThemeChangeTransition = ThemeChangeTransition
End Sub

Public Sub getThemeChangeTransition As String
	Return m_ThemeChangeTransition
End Sub

Public Sub setBodyTextColor(BodyTextColor As Int)
	m_BodyTextColor = BodyTextColor
End Sub

Public Sub getBodyTextColor As Int
	Return m_BodyTextColor
End Sub

Public Sub setHeaderTextColor(HeaderTextColor As Int)
	m_HeaderTextColor = HeaderTextColor
End Sub

Public Sub getHeaderTextColor As Int
	Return m_HeaderTextColor
End Sub

Public Sub setSecondClickColor(SecondClickColor As Int)
	m_SecondClickColor = SecondClickColor
End Sub

Public Sub getSecondClickColor As Int
	Return m_SecondClickColor
End Sub

Public Sub setFirstClickColor(FirstClickColor As Int)
	m_FirstClickColor = FirstClickColor
End Sub

Public Sub getFirstClickColor As Int
	Return m_FirstClickColor
End Sub

Public Sub setNormalColor(NormalColor As Int)
	m_NormalColor = NormalColor
End Sub

Public Sub getNormalColor As Int
	Return m_NormalColor
End Sub

'<code>AS_WeekdaySelector1.BodyText = AS_WeekdaySelector1.BodyText_DayOfMonth</code>
Public Sub getBodyText As String
	Return m_BodyText
End Sub

Public Sub setBodyText(BodyText As String)
	m_BodyText = BodyText
End Sub

'<code>AS_WeekdaySelector1.HeaderText = AS_WeekdaySelector1.HeaderText_WeekDay</code>
Public Sub getHeaderText As String
	Return m_HeaderText
End Sub

Public Sub setHeaderText(HeaderText As String)
	m_HeaderText = HeaderText
End Sub

'Display Week
Public Sub getWeek As Long
	Return m_Week
End Sub

Public Sub setWeek(Week As Long)
	m_Week = Week
End Sub

'Call Refresh if you change something
'<code>AS_WeekdaySelector1.WeekNameShort = AS_WeekdaySelector1.CreateWeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")</code>
Public Sub setWeekNameShort(WeekNameShort As AS_WeekdaySelector_WeekNameShort)
	g_WeekNameShort = WeekNameShort
End Sub

Public Sub getWeekNameShort As AS_WeekdaySelector_WeekNameShort
	Return g_WeekNameShort
End Sub

'Call Refresh if you change something
'<code>AS_WeekdaySelector1.WeekNameLong = AS_WeekdaySelector1.CreateWeekNameLong("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")</code>
Public Sub setWeekNameLong(WeekNameLong As AS_WeekdaySelector_WeekNameLong)
	g_WeekNameLong = WeekNameLong
End Sub

Public Sub getWeekNameLong As AS_WeekdaySelector_WeekNameLong
	Return g_WeekNameLong
End Sub

'1-7
'1 = Sunday
'2 = Monday
'3 = Tuesday
'4 = Wednesday
'5 = Thursday
'6 = Friday
'7 = Saturday
Public Sub setFirstDayOfWeek(number As Int)
	m_FirstDayOfWeek = number
End Sub

Public Sub getFirstDayOfWeek As Int
	Return m_FirstDayOfWeek
End Sub

#End Region

#Region Enums

Public Sub HeaderText_None As String
	Return "None"
End Sub

Public Sub HeaderText_WeekDay As String
	Return "WeekDay"
End Sub

Public Sub HeaderText_DayOfMonth As String
	Return "DayOfMonth"
End Sub

Public Sub BodyText_None As String
	Return "None"
End Sub

Public Sub BodyText_WeekDay As String
	Return "WeekDay"
End Sub

Public Sub BodyText_DayOfMonth As String
	Return "DayOfMonth"
End Sub

Public Sub getThemeChangeTransition_Fade As String
	Return "Fade"
End Sub

Public Sub getThemeChangeTransition_None As String
	Return "None"
End Sub

#End Region

#Region Events

Private Sub WeekDayClicked(WeekDay As AS_WeekdaySelector_WeekDay,ClickState As Int)'Ignore
	If xui.SubExists(mCallBack, mEventName & "_WeekDayClicked", 2) Then
		CallSub3(mCallBack, mEventName & "_WeekDayClicked",WeekDay,ClickState)
	End If
End Sub

#End Region

#Region Functions

'FirstDayOfWeek:
'1 = Sunday
'2 = Monday
'3 = Tuesday
'4 = Wednesday
'5 = Thursday
'6 = Friday
'7 = Saturday
Public Sub GetFirstDayOfWeek2(Ticks As Long,FirstDayOfWeek As Int) As Long
	Dim DayOfWeek As Int = DateTime.GetDayOfWeek(Ticks)
	Dim Delta As Int = (7 + (DayOfWeek - FirstDayOfWeek)) Mod 7
	Dim p As Period
	p.Days = -Delta
	Return DateUtils.AddPeriod(Ticks, p)
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

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

#End Region

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Public Sub CreateWeekNameShort (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As AS_WeekdaySelector_WeekNameShort
	Dim t1 As AS_WeekdaySelector_WeekNameShort
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

Public Sub CreateWeekNameLong (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As AS_WeekdaySelector_WeekNameLong
	Dim t1 As AS_WeekdaySelector_WeekNameLong
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