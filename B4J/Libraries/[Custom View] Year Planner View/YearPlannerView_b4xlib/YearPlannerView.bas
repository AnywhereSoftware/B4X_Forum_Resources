B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'YearPlannerView is a B4J Custom View class. 
'

'Version 1.01 2023-05-11
'Removed border from year selection B4XComboBox in layout.
'Added property subs getUseHoverColor and setDayLabelColor.
'Added get/set property subs for HeaderTextColor, DayLabelTextColor, HoverColor, and MonthLabelTextColor
'Moved pnlDays.RemoveAllViews from cmbYear_SelectedIndexChanged to LoadDayLabels
'Added ID (pane.id) to pnlMain ("ypv_pnlMain"), pnlDays ("ypv_pnlDays"), pnlMonths ("ypv_pnlMonths"), pnlDaysHeader ("ypv_pnlDaysHeader"), 
'and pnlHeader ("ypv_pnlHeader") for easier referencing in CSS Style files.
'Added Public global Int DayLabelOriginalColour which holds the colour of lblDay when MouseEntered, so that we can revert to it on MouseExited...
'DayLabelOriginalColour is public so that user can set it if they change the label colour in a click event for example.
'Fixed error in setting of mDaysHoverColor in DesignerCreateView. Had it as Props.GetDefault("mDaysHoverColor"..., corrected to ...("DaysHoverColor"...
'Removed If Not(setSelectedDays.Contains(dld.date)) condition in the Day Label MouseEntered/Exited subs 
'Added lblSelAll to layout. This is a transparent label containing an arrowed cross that allows selection of all days on view with a single click.
'Added SelectAllClick event which is raised when lblSelAll is clicked.
'
'
'
'Version 1.00 2023-01-12
'First Effort
'
'Written by chris2

'YearPlannerView Custom View class 
'Events declarations
#Event: DayLabelClick (EventData As MouseEvent, ClickedDate as string)
#Event: DaysHeaderLabelClick (EventData As MouseEvent, DayNumber as Int)
#Event: MonthLabelClick (EventData As MouseEvent, MonthNumber as Int)
#Event: SelectAllClick (EventData As MouseEvent, Year as Int)
#Event: YearChanged (Year as int)
#RaisesSynchronousEvents: DayLabelClick
#RaisesSynchronousEvents: DaysHeaderLabelClick
#RaisesSynchronousEvents: MonthLabelClick
#RaisesSynchronousEvents: SelectAllClick
#RaisesSynchronousEvents: YearChanged

#DesignerProperty: Key: TextSize, DisplayName: TestSize, FieldType: Int, DefaultValue: 12, Description: Text size used for year selection and as min for month & day labels
#DesignerProperty: Key: TextColor, DisplayName: Textcolor, FieldType: Color, DefaultValue: 0xFF000000, Description: Text color

#DesignerProperty: Key: BaseColor, DisplayName: BaseColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Base pane color
#DesignerProperty: Key: HeaderColor, DisplayName: HeaderColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Header pane color
#DesignerProperty: Key: DaysHeadersColor, DisplayName: DaysHeadersColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Days Header pane color
#DesignerProperty: Key: MonthsColor, DisplayName: MonthsColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Months parent pane color
#DesignerProperty: Key: DaysBackgroundColor, DisplayName: DaysBackgroundColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Days parent pane color
#DesignerProperty: Key: DaysColor, DisplayName: DaysColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Day labels color
#DesignerProperty: Key: DaysBorderColor, DisplayName: DaysBorderColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Border color for the Day labels
#DesignerProperty: Key: DaysHoverColor, DisplayName: DaysHoverColor, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Day labels change to this color on mouse entered

#DesignerProperty: Key: MinYear, DisplayName: MinYear, FieldType: Int, DefaultValue: 2020, Description: Minimum selectable year
#DesignerProperty: Key: MaxYear, DisplayName: MaxYear, FieldType: Int, DefaultValue: 2030, Description: Maximum selectable year
#DesignerProperty: Key: InitialYear, DisplayName: InitialYear, FieldType: Int, DefaultValue: 2020, Description: The year displayed when view is opened. Must be between MinYear and MaxYear

#DesignerProperty: Key: UseHoverColor, DisplayName: UseHoverColor, FieldType: Boolean, DefaultValue: False, Description: DaysHoverColor is applied if true

'YearPlannerView is a B4J custom view class. 
'This YearPlanner custom view allows the user to select days from within a year.
'The year displayed is selectable via a B4XComboBox with limits (MinYear, MaxYear) set by the programmer.
'Clicking a day in the year adds the date to the SelectedDays B4XSet and raises the DayLabelClick event which returns the EventData and the date of the day clicked.
'Clicking a month label adds the all dates in that month to the SelectedDays B4XSet and raises the MonthLabelClick event which returns the EventData and month number clicked.
'Changing the year displayed raises the YearChanged event which returns the newly selected year.
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public mBase As B4XView	'ignore
	Public Tag As Object
	
	'views
	Private pnlHeader, pnlMain, pnlMonths, pnlDaysHeader, pnlDays As B4XView
	Private cmbYear As B4XComboBox
	Private lblYear As B4XView
	
	'properties
	Private mStartYear, mEndYear, mSelectedYear As Int
	Private mBackgroundColor, mHeaderColor,  mDaysHeaderColor, mMonthsColor, mDaysBackgroundColor, mDaysColor As Int
	Private mDaysBorderColor, mHeaderTextColor, mMonthLabelTextColor, mDayLabelTextColor As Int
	Private mTextSize As Int
	Private mDaysHoverColor As Int
	Private mUseHoverColor As Boolean
	
	Private mapAllDayLabels As Map		'date in yyyy-MM-dd as key, corresponding DayLabelData as value. Contains all displayed day labels only.
	Private setSelectedDays As B4XSet	'selected days' dates in yyyy-MM-dd
	Private lastClickedDate As String
	
	'date in yyyy-MM-dd. dayInYear is the day of the year, 1 to 366. dayNum with Sunday=1, row is equivalent to month number.
	Type DayLabelData (label As B4XView, date As String, dayInYear As Int, dayNum As Int, row As Int, column As Int)
	
	Public DayLabelOriginalColour As Int
	
End Sub

Public Sub Initialize (CallBack As Object, EventName As String)
	mEventName = EventName
	mCallBack = CallBack
	
	mapAllDayLabels.Initialize
	setSelectedDays = B4XCollections.CreateSet
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	mBase.Tag = Me
	Tag = mBase.Tag
	
	Sleep(0)
	mBase.LoadLayout("YearPlannerViewLayout")
	
	mTextSize = Props.GetDefault("TextSize", 12)
	mHeaderTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_Black))
	mMonthLabelTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_Black))
	mDayLabelTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_Black))
	
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BaseColor", xui.Color_Transparent))
	mHeaderColor = xui.PaintOrColorToColor(Props.GetDefault("HeaderColor", xui.Color_Transparent))
	mDaysHeaderColor = xui.PaintOrColorToColor(Props.GetDefault("DaysHeadersColor", xui.Color_Transparent))
	mMonthsColor = xui.PaintOrColorToColor(Props.GetDefault("MonthsColor", xui.Color_Transparent))
	mDaysBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("DaysBackgroundColor", xui.Color_Transparent))
	mDaysColor = xui.PaintOrColorToColor(Props.GetDefault("DaysColor", xui.Color_Transparent))
	DayLabelOriginalColour=mDaysColor
	mDaysBorderColor = xui.PaintOrColorToColor(Props.GetDefault("DaysBorderColor", xui.Color_Transparent))
	
	mDaysHoverColor = xui.PaintOrColorToColor(Props.GetDefault("DaysHoverColor", xui.Color_Transparent))
	mUseHoverColor = Props.GetDefault("UseHoverColor", False)
	
	mStartYear = Props.GetDefault("MinYear", 2020)
	mEndYear = Props.GetDefault("MaxYear", 2030)
	Dim y As Int = Props.GetDefault("InitialYear", mStartYear)
	Dim initialYear As Int = IIf(mStartYear <= y And y <= mEndYear, y, mStartYear)
	
	
	'set the view properties
	cmbYear.mBase.TextSize=mTextSize
	lblYear.TextColor = mHeaderTextColor
	lblYear.TextSize = mTextSize
	pnlHeader.Color = mHeaderColor
	pnlMain.Color = mBackgroundColor
	pnlDaysHeader.Color = mDaysHeaderColor
	pnlMonths.Color = mMonthsColor
	pnlDays.Color = mDaysBackgroundColor
	
	'add the month names
	For Each v As B4XView In pnlMonths.GetAllViewsRecursive
		v.TextSize = mTextSize
		v.TextColor = mMonthLabelTextColor
		v.Text = DateUtils.GetMonthsNames.Get(v.Tag-1)
	Next
	
	' add the days names to pnlDaysHeader
	FillDaysHeader(pnlDaysHeader.Width/37)
	
	'populate and select initialYear year in cmbBox
	PopulateYearCmbBox
	If cmbYear.IndexOf(initialYear)<>-1 Then
		cmbYear.SelectedIndex = cmbYear.IndexOf(initialYear.As(String))
		cmbYear_SelectedIndexChanged(cmbYear.SelectedIndex)
	Else if cmbYear.Size>0 Then
		cmbYear.SelectedIndex = 0
		cmbYear_SelectedIndexChanged(0)
	End If
	
	'add IDs for the panels
	pnlMain.As(Pane).Id="ypv_pnlMain"
	pnlDays.As(Pane).Id="ypv_pnlDays"
	pnlHeader.As(Pane).Id="ypv_pnlHeader"
	pnlDaysHeader.As(Pane).Id="ypv_pnlDaysHeader"
	pnlMonths.As(Pane).Id="ypv_pnlMonths"
	
End Sub


'Public Sub AddToParent(Parent As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)   
'	mBase.Initialize("mBase")   'Error unknown member: initialize
'	Parent.AddView(mBase, Left, Top, Width, Height) 
'End Sub 


Public Sub GetBase As Object
	Return mBase
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
End Sub



#Region  load the views 


Private Sub PopulateYearCmbBox
	
	cmbYear.SetItems(Array())
	Dim l As  List 
	l.Initialize
	If mStartYear<=mEndYear Then

		For i=mStartYear To mEndYear
			l.Add(i.As(String))
		Next
		
	Else
		Log("YearPlannerView StartYear>EndYear!")
	End If
	
	cmbYear.SetItems(l)
	
End Sub



Private Sub LoadDayLabels (year As Int)
	
	Dim lblWidth As Int = pnlDays.Width/37		'37 days worth of labels in each row
	Dim lblHeight As Int = pnlDays.Height/12 	'a row for each month
	
	mapAllDayLabels.Clear
	pnlDays.RemoveAllViews
	
	Dim dayInYear As Int = 1	'the day number in the year of each label
	For m=1 To 12	'one for each month
		
		'get the day of the 1st of the month so we know where to put the first day label
		Dim firstDay As Int = FindMonths1stDay(year, m)	'1=sun, 2=mon, 3=tues, ... .
		
		Dim dOfM As Int = 1	'day of month
		For x=0 To 36		'37 possible label positions (5 weeks +2 days)

			If x<firstDay-1 Then Continue	'just leave a gap until we hit the firstDay's position
			
			Dim lbl As Label
			lbl.Initialize("lblDay")
			Dim v As B4XView = lbl
			v.Font = xui.CreateDefaultFont(mTextSize)
			v.TextColor = mDayLabelTextColor
			v.SetColorAndBorder(mDaysColor, 1, mDaysBorderColor, 0)
			v.SetTextAlignment("CENTER", "CENTER")
			lbl.Text=dOfM
			Dim date As String = year & "-" & NumberFormat(m, 2, 0) & "-" & NumberFormat(dOfM, 2, 0)	'in yyyy-MM-dd
			Dim dayNum As Int = DateTime.GetDayOfWeek(DateUtils.SetDate(year, m, dOfM))
			Dim dld As DayLabelData = CreateDayLabelData(v, date, dayInYear, dayNum, m, x)
			lbl.Tag=dld	
			
			Dim lblWidth As Int = pnlDays.Width/37
			Dim lblHeight As Int = pnlDays.Height/12
			v.Width=lblWidth
			v.Height=lblHeight
			v.Top=(dld.row-1)*lblHeight
			v.Left=dld.column*lblWidth
			
			pnlDays.AddView(v, x*lblWidth, (m-1)*lblHeight, lblWidth, lblHeight)
			mapAllDayLabels.Put(date, dld)

			dOfM=dOfM+1
			dayInYear=dayInYear+1
			
			If dOfM>DateUtils.NumberOfDaysInMonth(m, year) Then Exit	'exit the loop when we've done the last day of the month
			
		Next
		
	Next
	
End Sub



Private Sub FillDaysHeader (lblWidth As Int)

	Dim d As Int =1		'1 because the first day shown is Sunday
	For a=0 To 36
		Dim lbl As Label
		lbl.Initialize("lblDaysHeader")
		Dim v As B4XView = lbl
		v.SetTextAlignment("CENTER", "CENTER")
		v.Font = xui.CreateDefaultFont(mTextSize)
		v.TextColor = mDayLabelTextColor
		lbl.Text= DateUtils.GetDaysNames.Get(((a) Mod 7)).As(String).SubString2(0,1)

		lbl.Tag = d	'day number with 1=Sun
		pnlDaysHeader.AddView(v, a*lblWidth, 0, lblWidth, pnlDaysHeader.Height)
		d=(d Mod 7)+1
	Next
	
End Sub



'1=sun, 2=mon, 3=tues, ..., 
Private Sub FindMonths1stDay (year As Int, month As Int) As Int
	
	Dim firstDay As Long = DateUtils.SetDate(year, month, 1)
	Return DateTime.GetDayOfWeek(firstDay)
	
End Sub



#End Region load views 





#Region properties




'Set the first and last selectable years
'Returns false if startYear>endYear
Public Sub SetStartAndEndYears (startYear As Int, endYear As Int) As Boolean
	
	If startYear>endYear Then Return False
	
	mStartYear=startYear
	mEndYear=endYear
	PopulateYearCmbBox
	
	Return True
End Sub


'the first selectable year
Public Sub getStartYear As Int
	Return mStartYear
End Sub


'get the last selectable year
Public Sub getEndYear As Int
	Return mEndYear
End Sub

'get the currently selected year
Public Sub getSelectedYear As Int
	Return mSelectedYear
End Sub

'Must be between StartYear and EndYear.
'Does nothing if an invalid year is set.
Public Sub setSelectedYear (year As Int) 

	If mStartYear <= year And year <= mEndYear And cmbYear.IndexOf(year)<>-1 Then
		
		cmbYear.SelectedIndex = cmbYear.IndexOf(year)
		cmbYear_SelectedIndexChanged(cmbYear.SelectedIndex)
		
	End If
	
End Sub

'A map of all the day label data for the selected year.
'date as key (in yyyy-MM-dd), corresponding DayLabelData (custom type - see below) as value.
'DayLabelData (label As B4XView, date As String, dayInYear As Int, dayNum As Int, row As Int, column As Int)	
'date in yyyy-MM-dd. dayInYear is the day of the year, 1 to 366. dayNum with Sunday=1, row is equivalent to month number, 1 to 12.
Public Sub getVisibleDayLabels As Map
	Return mapAllDayLabels
End Sub

'clear the selected days B4XSet
Public Sub ClearSelectedDays
	setSelectedDays.Clear
End Sub

'Remove the specified date from the selected days set
'date supplied must be in yyyy-MM-dd format
'Returns False if date is in an incorrect format or does not exist in the Selected Days set.
Public Sub RemoveFromSelectedDays (date As String) As Boolean
	
	If Not(IsValidDate(date)) Then Return False
	If Not(setSelectedDays.Contains(date)) Then Return False
	
	setSelectedDays.Remove(date)
	Return True

End Sub

'gets the selected days set which is a B4XSet of dates in yyyy-MM-dd
Public Sub getSelectedDays As B4XSet
	Return setSelectedDays
End Sub

'gets the last selected date in yyyy-MM-dd
Public Sub getLastSelectedDate As String
	Return lastClickedDate
End Sub


Public Sub getDayLabelColor As Int
	Return mDaysColor
End Sub

Public Sub setDayLabelColor (color As Int)
	mDaysColor=color
End Sub

'Use the applied hover cover or not.
'Day labels will change to DaysHoverColor on mouse entered
Public Sub setUseHoverColor (enable As Boolean)
	mUseHoverColor=enable
End Sub

'If true, Day labels will change to DaysHoverColor on mouse entered
Public Sub getUseHoverColor As Boolean
	 Return mUseHoverColor
End Sub

'If UseHoverColor is true, Day labels will change to HoverColor on mouse entered
Public Sub setHoverColor (color As Int)
	mDaysHoverColor=color
End Sub

'If UseHoverColor is true, Day labels will change to HoverColor on mouse entered
Public Sub getHoverColor As Int
	 Return mDaysHoverColor
End Sub


Public Sub getDayLabelTextColor As Int
	 Return mDayLabelTextColor
End Sub

Public Sub setDayLabelTextColor (color As Int)
	 mDayLabelTextColor=color
End Sub

Public Sub getHeaderTextColor As Int
	 Return mHeaderTextColor
End Sub

Public Sub setHeaderTextColor (color As Int)
	 mHeaderTextColor=color

End Sub

Public Sub getMonthLabelTextColor As Int
	 Return mMonthLabelTextColor
End Sub

Public Sub setMonthLabelTextColor (color As Int)
	 mMonthLabelTextColor=color

End Sub


	
	


#End Region properties




#Region events



'Raises the YearChanged event which sends the newly selected year.
Private Sub cmbYear_SelectedIndexChanged (Index As Int)

	If cmbYear.SelectedItem.As(Int)<>mSelectedYear Then
		
		Dim year As Int = cmbYear.SelectedItem		
		LoadDayLabels(year)
		mSelectedYear=year
		
		If xui.SubExists(mCallBack, mEventName & "_YearChanged", 1) Then
			CallSubDelayed2(mCallBack, mEventName & "_YearChanged", mSelectedYear)
		End If
		
	End If
	
End Sub


'A day label has been clicked
'The date is added to the SelectedDays set.
'The DayLabelClick event is raised which includes the EventData and the clicked date in yyyy-MM-dd.
Private Sub lblDay_MouseClicked (EventData As MouseEvent)
	
	Dim lbl As B4XView = Sender
	Dim dld As DayLabelData = lbl.Tag
	lastClickedDate = dld.date
		
	setSelectedDays.Add(dld.date)
	
	If xui.SubExists(mCallBack, mEventName & "_DayLabelClick", 2) Then
		CallSubDelayed3(mCallBack, mEventName & "_DayLabelClick", EventData, lastClickedDate)
	End If

End Sub


'One of the month labels has been clicked.
'All days in the clicked month are added to the SelectedDays set.
'The MonthLabelClick event is raised which includes the EventData and the month number.
Private Sub mLabel_MouseClicked (EventData As MouseEvent)
	
	Dim lbl As Label = Sender
	Dim monthNum As Int = lbl.tag

	For Each date As String In mapAllDayLabels.Keys	'date in yyyy-MM-dd as key, corresponding DayLabelData as value
	
		Dim ld As DayLabelData = mapAllDayLabels.Get(date)
		If ld.row=monthNum Then
			
			setSelectedDays.Add(date)
			lastClickedDate = date

		End If
	
	Next
	
	If xui.SubExists(mCallBack, mEventName & "_MonthLabelClick", 2) Then
		CallSubDelayed3(mCallBack, mEventName & "_MonthLabelClick", EventData, monthNum)
	End If
	
	
End Sub


'One of the day header labels has been clicked
'All instances of the clicked day in the selected yeae are added to the SelectedDays set.
'The DaysHeaderLabelClick event is raised which includes the EventData and the day number with 1=Sunday, 2=Mon etc
Private Sub lblDaysHeader_MouseClicked (EventData As MouseEvent)
	
	Dim lbl As B4XView = Sender
	Dim dayNum As Int = lbl.Tag
		
	For Each date As String In mapAllDayLabels.Keys	'date in yyyy-MM-dd as key, corresponding DayLabelData as value
	
		Dim ld As DayLabelData = mapAllDayLabels.Get(date)
		If ld.dayNum=dayNum Then
			
			setSelectedDays.Add(date)
			lastClickedDate = date

		End If
	
	Next
	
	If xui.SubExists(mCallBack, mEventName & "_DaysHeaderLabelClick", 2) Then
		CallSubDelayed3(mCallBack, mEventName & "_DaysHeaderLabelClick", EventData, dayNum)
	End If

End Sub


Private Sub lblDay_MouseEntered (EventData As MouseEvent)
	
	If mUseHoverColor Then
	Dim lbl As B4XView = Sender
		DayLabelOriginalColour=lbl.Color
		lbl.Color=mDaysHoverColor
	End If
	
End Sub


Private Sub lblDay_MouseExited (EventData As MouseEvent)
	
	If mUseHoverColor Then 
	Dim lbl As B4XView = Sender
		lbl.Color=DayLabelOriginalColour
	End If
	
End Sub


'The select all label has been clicked
'All dates in the selected year are added to the SelectedDays set.
'The DayLabelClick event is raised which includes the EventData and the clicked date in yyyy-MM-dd.
Private Sub lblSelAll_MouseClicked (EventData As MouseEvent)
	
	
	For Each date As String In mapAllDayLabels.Keys	'date in yyyy-MM-dd as key, corresponding DayLabelData as value
	
		setSelectedDays.Add(date)
		lastClickedDate = date
	
	Next
	
	If xui.SubExists(mCallBack, mEventName & "_SelectAllClick", 2) Then
		CallSubDelayed3(mCallBack, mEventName & "_SelectAllClick", EventData, mSelectedYear)
	End If

End Sub





#End Region events




#Region helpers

'date in yyyy-MM-dd
'dayInYear is day in year (i.e. 1 to 366)
'dayNum has sun=1,..., sat=7.
'row and col are grid position.  
'row is 1 to 12 (equivalent to month number), col is 0 to 36..
Public Sub CreateDayLabelData (label As B4XView, date As String, dayInYear As Int, dayNum As Int, row As Int, column As Int) As DayLabelData
	Dim t1 As DayLabelData
	t1.Initialize
	t1.label = label
	t1.date = date
	t1.dayInYear = dayInYear
	t1.dayNum = dayNum
	t1.row = row
	t1.column = column
	Return t1
End Sub

'check date is valid and in form yyyy-MM-dd
Private Sub IsValidDate(Date As String) As Boolean
	Dim matcher1 As Matcher
	matcher1 = Regex.Matcher("(\d\d\d\d)-(\d\d)-(\d\d)", Date)
	If matcher1.Find = True Then
		Dim days, month, year As Int
		year = matcher1.Group(1)
		month = matcher1.Group(2)
		days = matcher1.Group(3) 
		If month > 12 Then Return False
		If days > DateUtils.NumberOfDaysInMonth(month, year) Then Return False
		Return True
	Else
		Return False
	End If
End Sub


#Region helpers


