B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' xGanttLite CustomView
'
'Written by Klaus CHRISTL (klaus)
'
'Version 1.1
'Amended some bugs
'
'Version 1.0

#Event: SelectedRow(RowIndex As Int)
#RaisesSynchronousEvents: SelectedRow(RowIndex As Int)

#DesignerProperty: Key: TimeDisplayMode, DisplayName: TimeDisplayMode, FieldType: String, DefaultValue: HOUR, List: HOUR|DAY_LARGE|DAY_SMALL, Description: Time display HOUR 24 hours; DAY_LARGE only days with a a large column; DAY_SMALL only days with a small column; default value HOUR
#DesignerProperty: Key: DateFormat, DisplayName: DateFormat, FieldType: String, DefaultValue: yyyy-MM-dd, List: yyyy-MM-dd|dd.MM.yyyy, Description: DateFormat; default format yyyy-MM-dd
#DesignerProperty: Key: TextSize, DisplayName: TextSizet, FieldType: Int, DefaultValue: 14
#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0xFFFEFEFE, Description: Grid frame color
#DesignerProperty: Key: GridFramwColor, DisplayName: GridFrameColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Grid frame color
#DesignerProperty: Key: GridColor, DisplayName: GridColor, FieldType: Color, DefaultValue: #FFD3D3D3, Description: Grid color
#DesignerProperty: Key: TextColor, DisplayName: TextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Text color
#DesignerProperty: Key: DisplayRowIndexColumn, DisplayName: DisplayRowIndexColumn, FieldType: Boolean, DefaultValue: True, Description: Displays the row index column
#DesignerProperty: Key: DisplayResponsibleColumn, DisplayName: DisplayResponsibleColumn, FieldType: Boolean, DefaultValue: False, Description: Displays responsible column
#DesignerProperty: Key: DisplayRowData, DisplayName: DisplayRowData, FieldType: Boolean, DefaultValue: True, Description: Displays the row data; when True the row data is displayed when the user presses or moves the mouse on a row

Sub Class_Globals
	Type GanttLiteData(FirstColumsWidth As Int, FirstColumsPath As B4XPath, CalendarWidth As Int, CalendarPath As B4XPath, Left As Int, Right As Int, Top As Int, Bottom As Int, Width As Int, Height As Int, NbRows As Int, NbVisibleRows As Int, NbColumns As Int, NbVisibleColumns As Int, Duration As Long)
	Type GanttLiteRowData (ObjectType As String, ObjectID As String)
	Type GanttLiteTaskData(ID As String, Row As Int, Name As String, GroupID As String, Responsible As String, BeginTimeTicks As Long, EndTimeTicks As Long, Color As Int, Comment As String, BeginTimeX As Int, EndTimeX As Int)
	Type GanttLiteGroupData(ID As String, Row As Int, Name As String, TaskList As List, Color As Int, BeginTimeTicks As Long, EndTimeTicks As Long, BeginTimeTX As Int, EndTimeX As Int, Comment As String)
	Type ScrollBarData(Active As Boolean, BeginIndex As Int, EndIndex As Int, Rows As Int, BarLength As Int, BarWidth As Int, ButtonLength As Int, CornerRadius As Int, CursorBegin As Int, CursorBegin0 As Int, CursorLength As Int, Cursor0 As Int, CursorOn As Boolean, ColorBar As Int, ColorButton As Int, ColorButtonFrame As Int, ScalesOnScrolledPart As Boolean)

	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
		
'	Public txtRow, txtID, txtTask, txtResponsible, txtComment, txtEmpty, txtGroup, txtName As String
	Public txtBeginTime, txtEndTime As String
	
	Public Rows, Groups, Tasks As List
	Public GroupIDs, TaskIDs As List
	
	Private pnlCalendar, pnlDiagram, pnlCursor, pnlDisplayData, pnlScaleButtons, pnlEditRow As B4XView
	Private cvsCalendar, cvsDiagram, cvsCursor, cvsDisplayData, cvsScaleButtons As B4XCanvas
	Private pnlScrollBarV, pnlScrollBarH As B4XView
	Private cvsScrollBarV, cvsScrollBarH As B4XCanvas
	Private mTextFont, mTextFontBold As B4XFont
	Private FirstColumnsRect, GanttRect As B4XRect
	Private CalendarPath As B4XPath
	
	Private Gantt As GanttLiteData
	
	Private ScrollH, ScrollV As ScrollBarData
	Private Scrolling As Boolean
	Private mTimeDisplayMode As String
	Private mLeft, mTop, mWidth, mHeight As Int
	
	Private mDisplayRowIndexColumn, mDisplayResponsibleColumn, mDisplayRowData As Boolean
	Private mTextSize As Float
	Private mBeginDate, mEndDate, mDateFormat, OriginalDateFormat As String
	Private mBeginDayTicks, mBeginChartTicks, mBeginHourTicks, mBeginTimeTicks As Long
	Private mEndDayTicks, mEndTimeTicks, mEndChartTicks  As Long
	Private mRowHeight, mColumnRowWidth, mFirstColumsWidth, mColumnIDWidth, mColumnNameWidth, mColumnResponsibleWidth, mColumnTimeWidth As Int
	Private mTextHeight, mTextCenterY, mPadding As Int
	Private NbRows, NbRowsTotal, NbRowsVisible, NbColumns, NbColumnsTotal, NbColumnsVisible As Int
	Private mBackgroundColor, mGridFrameColor, mGridColor, mTextColor As Int
	Private CursorRow As Int
	Private TicksToTimeWidthScale As Double
	Private AutomaticBeginEndDates As Boolean
	
	Private EditMode As String
	Private SelectedRow = -1 As Int
	Private SelectedTask As GanttLiteTaskData
	Private rectSelectedRow, rectSelectedTask As B4XRect
	Private TaskX1, TaskXm, TaskX2, TaskW2, TaskY0, TaskY1 As Int
	
	Public DayNames(8), MonthNames(12) As String
	Private DownTime As Long
	Private DoubleClickTime As Int
	Private Texts As List
	Private mLanguageCode As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	Rows.Initialize
	Groups.Initialize
	GroupIDs.Initialize
	Tasks.Initialize
	TaskIDs.Initialize
	Texts.Initialize

	mTextSize = 14
	mRowHeight = 25dip
	mGridFrameColor = xui.Color_Black
	mGridColor = xui.Color_Gray
	mTextColor = xui.Color_Black
	mColumnRowWidth = 60dip
	mColumnIDWidth = 40dip
	mColumnNameWidth = 200dip
	mColumnTimeWidth = 30dip
	mTimeDisplayMode = "HOUR"
	mLanguageCode = "en"
	
	MonthNames = Array As String("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
	DayNames = Array As String("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	mLeft = mBase.Left
	mTop = mBase.Top
	mWidth = mBase.Width
	mHeight = mBase.Height
	
	mTimeDisplayMode = Props.GetDefault("TimeDisplayMode", "HOUR")
	mDateFormat = Props.GetDefault("DateFormat", "yyyy-MM-dd")
	mTextSize = Props.GetDefault("TextSize", 14)
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor", 0xFFFEFEFE))
	mGridFrameColor = xui.PaintOrColorToColor(Props.GetDefault("GridFrameColor", xui.Color_Black))
	mGridColor = xui.PaintOrColorToColor(Props.GetDefault("GridColor", 0xFFD3D3D3))
	mTextColor = xui.PaintOrColorToColor(Props.GetDefault("TextColor", xui.Color_Black))
	mDisplayRowIndexColumn = Props.GetDefault("DisplayRowIndexColumn", True)
	mDisplayResponsibleColumn = Props.GetDefault("DisplayResponsibleColumn", False)
	mDisplayRowData = Props.GetDefault("DisplayRowData", True)
	Sleep(0)
#If B4A
	Base_Resize(mWidth, mHeight)
#End If

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mWidth = Width
	mHeight = Height
	If pnlCalendar.IsInitialized = False Then
		SetupGantt
		LoadTexts
	Else
		pnlCalendar.Width = mWidth - 1.2 * ScrollH.BarWidth
		pnlCalendar.Height = mHeight - 1.2 * ScrollH.BarWidth + 2dip
		pnlCalendar.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_Transparent, 0)
		cvsCalendar.Resize(pnlCalendar.Width, pnlCalendar.Height)

		pnlDiagram.Width = mWidth -  1.2 * ScrollH.BarWidth
		pnlDiagram.Height = mHeight - 1.2 * ScrollH.BarWidth + 2dip
		pnlDiagram.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_Transparent, 0)
		cvsDiagram.Resize(pnlDiagram.Width, pnlDiagram.Height)
		
		pnlCursor.Width = mWidth -  1.2 * ScrollH.BarWidth
		pnlCursor.Height = mHeight - 1.2 * ScrollH.BarWidth + 2dip
		pnlCursor.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_Transparent, 0)
		cvsCursor.Resize(pnlCursor.Width, pnlCursor.Height)
		
		DrawGantt
	End If
End Sub

Private Sub SetupGantt
	mBase.SetColorAndBorder(mBackgroundColor, 0, xui.Color_Transparent, 0)

#If B4A
	ScrollBarsInit
#Else If B4J
	ScrollBarsInit
#Else
	Sleep(0)
	ScrollBarsInit
#End If
	pnlScaleButtons = xui.CreatePanel("pnlScaleButtons")
	mBase.AddView(pnlScaleButtons, ScrollH.BarWidth, mBase.Height - ScrollH.BarWidth, 3 * ScrollH.ButtonLength + 1dip, ScrollH.BarWidth)
	cvsScaleButtons.Initialize(pnlScaleButtons)
	
	pnlScrollBarH = xui.CreatePanel("pnlScrollBarH")
	mBase.AddView(pnlScrollBarH, 0, 0, 100dip, ScrollH.BarWidth)
	cvsScrollBarH.Initialize(pnlScrollBarH)
	pnlScrollBarH.Visible = False
	
	pnlScrollBarV = xui.CreatePanel("pnlScrollBarV")
	mBase.AddView(pnlScrollBarV, 0, 0, 100dip, ScrollH.BarWidth)
	cvsScrollBarV.Initialize(pnlScrollBarV)
	pnlScrollBarV.Visible = False

	pnlDiagram = xui.CreatePanel("")
	mBase.AddView(pnlDiagram, 0, 0, mBase.Width - 1.2 * ScrollH.BarWidth, mBase.Height - 1.2 * ScrollH.BarWidth)
	cvsDiagram.Initialize(pnlDiagram)
	
	pnlCalendar = xui.CreatePanel("")
'	mBase.AddView(pnlCalendar, 0, 0, mBase.Width - 1.2 * ScrollH.BarWidth, mBase.Height - 1.2 * ScrollH.BarWidth)
	pnlDiagram.AddView(pnlCalendar, 0, 0, mBase.Width - 1.2 * ScrollH.BarWidth, mBase.Height - 1.2 * ScrollH.BarWidth)
	cvsCalendar.Initialize(pnlCalendar)
	
	pnlCursor = xui.CreatePanel("pnlCursor")
	mBase.AddView(pnlCursor, 0, 0, mBase.Width - 1.2 * ScrollH.BarWidth, mBase.Height - 1.2 * ScrollH.BarWidth)
	cvsCursor.Initialize(pnlCursor)

	pnlDisplayData = xui.CreatePanel("")
	pnlDisplayData.SetColorAndBorder(mBackgroundColor, 1dip, xui.Color_Black, 0)
	mBase.AddView(pnlDisplayData, 0, 0, 250dip, 150dip)
	cvsDisplayData.Initialize(pnlDisplayData)
	pnlDisplayData.Visible = False
	
	#If B4J
	Private R As Reflector
	R.Target = pnlScrollBarV
	R.AddEventFilter("cvsScrollBarV","javafx.scene.input.ScrollEvent.SCROLL")
	R.Target = pnlCursor
	R.AddEventFilter("cvsCursor","javafx.scene.input.ScrollEvent.SCROLL")
	R.Target = pnlScrollBarH
	R.AddEventFilter("cvsScrollBarH","javafx.scene.input.ScrollEvent.SCROLL")
#End If

	Gantt.Top = 0
	Gantt.NbVisibleRows = pnlCalendar.Height / mRowHeight - 2
	Gantt.Height = (Gantt.NbVisibleRows + 2) * mRowHeight

'	Rows.Initialize
'	Groups.Initialize
'	GroupIDs.Initialize
'	Tasks.Initialize
'	TaskIDs.Initialize
	
	AutomaticBeginEndDates = True
	OriginalDateFormat = DateTime.DateFormat
	
	InitSizes
	InitScaleButtons
End Sub

Private Sub InitSizes
	Private GraphSize As Int
	GraphSize = Min(mBase.Width, mBase.Height) / xui.Scale
	Private Scale As Double
	Scale = Max(0.8, (1 + (GraphSize - 500)/1000))
	Scale = Min(1.2, Scale)
	mTextFont = xui.CreateDefaultFont(mTextSize)
	mTextFontBold = xui.CreateDefaultBoldFont(mTextSize)
	Private rect As B4XRect
	rect = cvsCursor.MeasureText("Mg", mTextFont)
	mTextHeight = rect.Height
	mPadding = 0.7 * mTextHeight
	mTextCenterY = -0.45 * mTextHeight
	mRowHeight = 1.6 * mTextHeight
	mColumnTimeWidth = rect.Width * 1.6
	Gantt.Top = 0
	Gantt.NbVisibleRows = pnlCalendar.Height / mRowHeight - 2
	Gantt.Height = (Gantt.NbVisibleRows + 2) * mRowHeight
End Sub

Private Sub InitScaleButtons
	Private rect As B4XRect
	Private path As B4XPath
	rect.Initialize(0, 0, ScrollH.ButtonLength, ScrollH.BarWidth)
	path.InitializeRoundedRect(rect, ScrollH.CornerRadius)
	cvsScaleButtons.DrawPath(path, ScrollV.ColorButton, True, 1dip)
	cvsScaleButtons.DrawPath(path, ScrollV.ColorButtonFrame, False, 1dip)
	
	rect.Initialize(ScrollH.ButtonLength, 0, 2 * ScrollH.ButtonLength, ScrollH.BarWidth)
	path.InitializeRoundedRect(rect, ScrollH.CornerRadius)
	cvsScaleButtons.DrawPath(path, ScrollV.ColorButton, True, 1dip)
	cvsScaleButtons.DrawPath(path, ScrollV.ColorButtonFrame, False, 1dip)
	
	rect.Initialize(2 * ScrollH.ButtonLength, 0, 3 * ScrollH.ButtonLength, ScrollH.BarWidth)
	path.InitializeRoundedRect(rect, ScrollH.CornerRadius)
	cvsScaleButtons.DrawPath(path, ScrollV.ColorButton, True, 1dip)
	cvsScaleButtons.DrawPath(path, ScrollV.ColorButtonFrame, False, 1dip)	
	
	DrawScaleButtons
End Sub

'Adds a Task, the times are Strings
'ID = identification of the task.
'Name = description of the task.
'Responsible = person un charge of the task
'GroupID = ID of the group the Task belongs to, empty string if the task does not belong to a group.
'BeginTime = time of the start of the task; DateFormat yyyy-MM-dd HH.mm.ss
'EndTime = time of the end of the task; DateFormat yyyy-MM-dd HH.mm.ss
'Color = color of the bar in the chart
'Comment = a comment for the task
Public Sub AddTaskDates(ID As String, Name As String, Responsible As String, GroupID As String, BeginTime As String, EndTime As String, Color As Int, Comment As String)
	AddTaskTicks(ID, Name, Responsible, GroupID, DateTime.DateParse(BeginTime), DateTime.DateParse(EndTime), Color, Comment)
End Sub

'Adds a Task, the times are Ticks
'ID = identification of the task.
'Name = description of the task.
'Responsible = person un charge of the task
'GroupID = ID of the group the Task belongs to, empty string if the task does not belong to a group.
'BeginTimeTicks = time of the start of the task in Ticks
'EndTimeTicks = time of the end of the task in Ticks
'Color = color of the bar in the chart
'Comment = a comment for the task
Public Sub AddTaskTicks(ID As String, Name As String, Responsible As String, GroupID As String, BeginTimeTicks As Long, EndTimeTicks As Long, Color As Int, Comment As String)
	Private Task As GanttLiteTaskData
	Task.ID = ID
	Task.Name = Name
	Task.GroupID = GroupID
	Task.Responsible = Responsible
	Task.BeginTimeTicks = BeginTimeTicks
	Task.EndTimeTicks = EndTimeTicks
	Task.Color = Color
	Task.Comment = Comment
	Task.Row = Rows.Size
	Tasks.Add(Task)
	TaskIDs.Add(Task.ID)
	Private RowData As GanttLiteRowData
	RowData.Initialize
	RowData.ObjectType = "Task"
	RowData.ObjectID = Task.ID
	Rows.Add(RowData)
	Private Group As GanttLiteGroupData
	Group = GetGroup(Task.GroupID)
	Group.TaskList.Add(Task.ID)
End Sub

'Adds a Group
'ID = identification of the group.
'Name = description of the group.
'Color = color of the bar in the chart
'Comment = a comment for the group
Public Sub AddGroup(ID As String, Name As String, Color As Int, Comment As String)
	Private Group As GanttLiteGroupData
	Group.Initialize
	Group.ID = ID
	Group.Name = Name
	Group.TaskList.Initialize
	Group.Color = Color
	Group.Comment = Comment
	Group.Row = Rows.Size
	Groups.Add(Group)
	GroupIDs.Add(Group.ID)
	Private RowData As GanttLiteRowData
	RowData.Initialize
	RowData.ObjectType = "Group"
	RowData.ObjectID = Group.ID
	Rows.Add(RowData)
End Sub

'Adds an empty row
Public Sub AddEmpty
	Private RowData As GanttLiteRowData
	RowData.Initialize
	RowData.ObjectType = "Empty"
	Rows.Add(RowData)
End Sub

'Returns the Task data for the given Task ID
Public Sub GetTask(TaskID As String) As GanttLiteTaskData
	Private Task As GanttLiteTaskData
	
	Task = Tasks.Get(TaskIDs.IndexOf(TaskID))
	Return Task
End Sub

'Returns the Group data for the given Group ID
Public Sub GetGroup(GroupID As String) As GanttLiteGroupData
	Private Group As GanttLiteGroupData
	
	Group = Groups.Get(GroupIDs.IndexOf(GroupID))
	Return Group
End Sub

'Draws the Gantt chart
Public Sub DrawGantt
	ResizeChart
	ReDrawGantt
End Sub

'Redraws the chart without resizing
Private Sub ReDrawGantt
	DateTime.DateFormat = mDateFormat
	
	
	ScrollH.EndIndex = ScrollH.BeginIndex + NbColumns - 1
	Select mTimeDisplayMode
		Case "HOUR"
			mBeginChartTicks = mBeginHourTicks + ScrollH.BeginIndex * mColumnTimeWidth / TicksToTimeWidthScale
		Case "DAY_LARGE", "DAY_SMALL"
			mBeginChartTicks = mBeginDayTicks + ScrollH.BeginIndex * mColumnTimeWidth / TicksToTimeWidthScale
	End Select
	mEndChartTicks = mBeginChartTicks + NbColumns * mColumnTimeWidth / TicksToTimeWidthScale
	If NbColumnsTotal > NbColumnsVisible Then
		ScrollCursorDrawH
	End If
	DrawScaleButtons
	DrawFixedColumns
	DrawTasks
	DateTime.DateFormat = OriginalDateFormat
End Sub

'Draws the fixed columns, at least the ID and Name columns
Private Sub DrawFixedColumns
	DrawFixedColumnsGrid
	DrawFixedColumnsData
End Sub

'Draws the fixed columns grid
Private Sub DrawFixedColumnsGrid
	Private x0, xt, xt1, xt2, xt3, xt4, y0, y1, yt As Int
	
	cvsCalendar.ClearRect(FirstColumnsRect)	'KC
	cvsCursor.ClearRect(cvsCursor.TargetRect)
	
	y1 = (NbRows + 2) * mRowHeight
	x0 = mFirstColumsWidth
	cvsCalendar.DrawLine(0, 0, x0, 0, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(0, mRowHeight, x0, mRowHeight, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(0, 2 * mRowHeight, x0, 2 * mRowHeight, mGridFrameColor, 1dip)
	
	For y = 3 To NbRows + 1
		cvsCalendar.DrawLine(0, y * mRowHeight, x0, y * mRowHeight, mGridColor, 1dip)
	Next
	cvsCalendar.DrawLine(0, y * mRowHeight, x0, y * mRowHeight, mGridFrameColor, 2dip)
	
	cvsCalendar.DrawLine(1dip, 0, 1dip, y1, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(x0 - 1dip, 0, x0 - 1dip, y1, mGridFrameColor, 1dip)
	y0 = mRowHeight

	If mDisplayRowIndexColumn = True Then
		xt = mColumnRowWidth
	Else
		xt = 0
	End If
	cvsCalendar.DrawLine(xt, y0, xt, y1, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(xt + mColumnIDWidth, y0, xt + mColumnIDWidth, y1, mGridFrameColor, 1dip)
	If mDisplayResponsibleColumn = True Then
		cvsCalendar.DrawLine(xt + mColumnIDWidth + mColumnNameWidth, y0, xt + mColumnIDWidth + mColumnNameWidth, y1, mGridFrameColor, 1dip)
	End If
	xt1 = xt - mPadding
	xt2 = xt + mColumnIDWidth - mPadding
	xt3 =  xt + mColumnIDWidth + mPadding
	xt4 =  xt + mColumnIDWidth + mColumnNameWidth + mPadding
	yt = 1.5 * mRowHeight - mTextCenterY
	cvsCalendar.DrawLine(x0, 0, x0, y1, mGridFrameColor, 1dip)
	If mDisplayRowIndexColumn = True Then
		cvsCalendar.DrawText(Texts.Get(0), xt1, yt, mTextFont, mTextColor, "RIGHT")
	End If
	cvsCalendar.DrawText(Texts.Get(1), xt2, yt, mTextFont, mTextColor, "RIGHT")
	cvsCalendar.DrawText(Texts.Get(3), xt3, yt, mTextFont, mTextColor, "LEFT")
	If mDisplayResponsibleColumn = True Then
		cvsCalendar.DrawText(Texts.Get(9), xt4, yt, mTextFont, mTextColor, "LEFT")
	End If
End Sub

'Draws the fixed columns grid
Private Sub DrawFixedColumnsData
	Private xt, xt1, xt2, xt3, xt4, yt As Int

	cvsDiagram.DrawRect(FirstColumnsRect, mBackgroundColor, True, 1dip)
	
	If mDisplayRowIndexColumn = True Then
		xt = mColumnRowWidth
	Else
		xt = 0
	End If
	xt1 = xt - mPadding
	xt2 = xt + mColumnIDWidth - mPadding
	xt3 =  xt + mColumnIDWidth + mPadding
	xt4 =  xt + mColumnIDWidth + mColumnNameWidth + mPadding

	For i = 0 To NbRows - 1
		Private Row As GanttLiteRowData
		
		yt = (i + 2.5) * mRowHeight - mTextCenterY
		
		If mDisplayRowIndexColumn = True Then
			cvsDiagram.DrawText(ScrollV.BeginIndex + i, xt1, yt, mTextFont, mTextColor, "RIGHT")
		End If
		Row = Rows.Get(ScrollV.BeginIndex + i)
		Select Row.ObjectType
			Case "Empty"
			Case "Group"
				Private Group As GanttLiteGroupData
				Group = GetGroup(Row.ObjectID)
				cvsDiagram.DrawText(Group.ID, xt2, yt, mTextFont, mTextColor, "RIGHT")
				cvsDiagram.DrawText(Group.Name, xt3, yt, mTextFont, mTextColor, "LEFT")
			Case "Task"
				Private Task As GanttLiteTaskData
				Task = GetTask(Row.ObjectID)
				cvsDiagram.DrawText(Task.ID, xt2, yt, mTextFont, mTextColor, "RIGHT")
				cvsDiagram.DrawText(Task.Name, xt3, yt, mTextFont, mTextColor, "LEFT")
				If mDisplayResponsibleColumn = True Then
					cvsDiagram.DrawText(Task.Responsible, xt4, yt, mTextFont, mTextColor, "LEFT")				
				End If
		End Select
	Next
	cvsDiagram.Invalidate
End Sub

'Draws the Tasks
Private Sub DrawTasks
	Select mTimeDisplayMode
		Case "HOUR"
			DrawTasksGridHour
		Case "DAY_LARGE"
			DrawTasksGridDayLarge
		Case "DAY_SMALL"
			DrawTasksGridDaySmall
	End Select
	DrawTasksData
End Sub

'Draws the Tasks grid four HOUR
Private Sub DrawTasksGridHour
	Private i, j As Int
	Private x0, x1, xt, y0, y1, yt As Int
	Private CurrentDate As String
	
	cvsDiagram.DrawRect(GanttRect, mBackgroundColor, True, 1dip)
	cvsCalendar.ClearRect(GanttRect)

	cvsDiagram.ClipPath(CalendarPath)

	x0 = mFirstColumsWidth
	x1 = x0 + NbColumns * mColumnTimeWidth
	y1 = (NbRows + 2) * mRowHeight
	cvsCalendar.DrawLine(x0, 0, x1, 0, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(x0, mRowHeight, x1, mRowHeight, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(x0, 2 * mRowHeight, x1, 2 * mRowHeight, mGridFrameColor, 1dip)
	
	For y = 3 To NbRows + 1
		cvsCalendar.DrawLine(x0, y * mRowHeight, x1, y * mRowHeight, mGridColor, 1dip)
	Next
	cvsCalendar.DrawLine(x0, y * mRowHeight, x1, y * mRowHeight, mGridFrameColor, 2dip)
	
	CurrentDate = DateTime.Date(mBeginHourTicks + ScrollH.BeginIndex * DateTime.TicksPerHour)
	Private CurrentBeginHour, CurrentEndHour As Int
	CurrentBeginHour = DateTime.GetHour(mBeginHourTicks + ScrollH.BeginIndex * DateTime.TicksPerHour)
	CurrentEndHour = DateTime.GetHour(mBeginTimeTicks + (ScrollH.BeginIndex + NbColumns - 1) * DateTime.TicksPerHour)

	If mBeginDate = mEndDate Then
		cvsCalendar.DrawText(CurrentDate, x0 + mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "LEFT")
	Else
		If i < 11 And CurrentBeginHour < 16 Then
			cvsCalendar.DrawText(CurrentDate, x0 + mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "LEFT")
		End If
	End If
	
	y0 = mRowHeight
	yt = 1.5 * mRowHeight - mTextCenterY
	For i = 0 To NbColumns - 1
		j = i + CurrentBeginHour
		x1 = x0 + (i + 1) * mColumnTimeWidth
		xt = x1 - 0.5 * mColumnTimeWidth
		If (j + 1) Mod 24 = 0 Then
			cvsCalendar.DrawLine(x1, 0, x1, y1, mGridFrameColor, 1dip)
			If i >= 2 Then
				cvsCalendar.DrawText(CurrentDate, x1 - mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "RIGHT")
			End If
			CurrentDate = DateTime.Date(DateTime.DateParse(CurrentDate) + DateTime.TicksPerDay)
			If i < NbColumns - 3 Then
				cvsCalendar.DrawText(CurrentDate, x1 + mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "LEFT")
			End If
		Else
			cvsCalendar.DrawLine(x1, y0, x1, y1, mGridColor, 1dip)
		End If
		cvsCalendar.DrawText(j Mod 24, xt, yt, mTextFont, mTextColor, "CENTER")
	Next
	cvsCalendar.DrawLine(x1, 0, x1, y1, mGridFrameColor, 2dip)
	If CurrentEndHour > 11 And CurrentEndHour < 23 Then
		cvsCalendar.DrawText(CurrentDate, x1 - mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "RIGHT")
	End If
End Sub

'Draws the Tasks grid four DAY_LARGE
Private Sub DrawTasksGridDayLarge
	Private i As Int
	Private x0, x1, x2, xt, y0, y1, yt As Int
	Private Month As String
	Private CurrentDayTicks As Long
	
	cvsDiagram.DrawRect(GanttRect, mBackgroundColor, True, 1dip)
	cvsCalendar.ClearRect(GanttRect)

	cvsDiagram.ClipPath(CalendarPath)

	x0 = mFirstColumsWidth
	x1 = x0 + NbColumns * mColumnTimeWidth
	y1 = (NbRows + 2) * mRowHeight
	cvsCalendar.DrawLine(x0, 0, x1, 0, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(x0, mRowHeight, x1, mRowHeight, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(x0, 2 * mRowHeight, x1, 2 * mRowHeight, mGridFrameColor, 1dip)
	
	For i = 3 To NbRows + 1
		cvsCalendar.DrawLine(x0, i * mRowHeight, x1, i * mRowHeight, mGridColor, 1dip)
	Next
	cvsCalendar.DrawLine(x0, i * mRowHeight, x1, i * mRowHeight, mGridFrameColor, 2dip)
	
	CurrentDayTicks = mBeginHourTicks + ScrollH.BeginIndex * DateTime.TicksPerDay
	Month = GetMonth(CurrentDayTicks)
	Private CurrentBeginDay, CurrentEndDay As Int
	CurrentBeginDay = DateTime.GetDayOfMonth(mBeginDayTicks + ScrollH.BeginIndex * DateTime.TicksPerDay)
	CurrentEndDay = DateTime.GetDayOfMonth(mBeginTimeTicks + (ScrollH.BeginIndex + NbColumns - 1) * DateTime.TicksPerDay)

	If CurrentBeginDay >= 1 And CurrentBeginDay < 29 Then
		cvsCalendar.DrawText(Month, x0 + mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "LEFT")
	End If
	
	y0 = mRowHeight
	yt = 1.5 * mRowHeight - mTextCenterY
	For i = 0 To NbColumns - 1
		x1 = x0 + (i + 1) * mColumnTimeWidth
		x2 = x1 - mColumnTimeWidth
		xt = x1 - 0.5 * mColumnTimeWidth
		
		Private DayOfWeek, DayOfMonth As Int
		Private Day As String
		CurrentDayTicks = mBeginDayTicks + (i + ScrollH.BeginIndex) * DateTime.TicksPerDay
		Month = GetMonth(CurrentDayTicks)
		DayOfMonth = DateTime.GetDayOfMonth(CurrentDayTicks)
		DayOfWeek = DateTime.GetDayOfWeek(CurrentDayTicks)
		Day = DayNames(DayOfWeek - 1)
		Day = Day & "  " & DayOfMonth
		cvsCalendar.DrawText(Day, xt, yt, mTextFont, mTextColor, "CENTER")
		
		If DayOfMonth = 1 Then
			cvsCalendar.DrawLine(x1, y0, x1, y1, mGridColor, 1dip)
			cvsCalendar.DrawLine(x2, 0, x2, y1, mGridFrameColor, 1dip)
			Month = GetMonth(CurrentDayTicks - DateTime.TicksPerDay)
			If i >= 2 Then
				cvsCalendar.DrawText(Month, x2 - mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "RIGHT")
			End If
			Month = GetMonth(CurrentDayTicks)
			If i < NbColumns - 1 Then
				cvsCalendar.DrawText(Month, x2 + mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "LEFT")
			End If
		Else
			cvsCalendar.DrawLine(x1, y0, x1, y1, mGridColor, 1dip)
		End If
	Next
	cvsCalendar.DrawLine(x1, 0, x1, y1, mGridFrameColor, 2dip)

	Private m, y As Int
	m = DateTime.GetMonth(CurrentDayTicks)
	y = DateTime.GetYear(CurrentDayTicks)
	If CurrentEndDay > 5 And CurrentEndDay <= DateUtils.NumberOfDaysInMonth(m, y) Then
		cvsCalendar.DrawText(Month, x1 - mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "RIGHT")
	End If
End Sub

'Draws the Tasks grid four DAY_SMALL
Private Sub DrawTasksGridDaySmall
	Private i As Int
	Private x0, x1, x2, xt, y0, y1, yt As Int
	Private Date As String
	Private CurrentDayTicks As Long
	
	cvsDiagram.DrawRect(GanttRect, mBackgroundColor, True, 1dip)
	cvsCalendar.ClearRect(GanttRect)

	cvsDiagram.ClipPath(CalendarPath)

	x0 = mFirstColumsWidth
	x1 = x0 + NbColumns * mColumnTimeWidth
	y1 = (NbRows + 2) * mRowHeight
	cvsCalendar.DrawLine(x0, 0, x1, 0, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(x0, mRowHeight, x1, mRowHeight, mGridFrameColor, 1dip)
	cvsCalendar.DrawLine(x0, 2 * mRowHeight, x1, 2 * mRowHeight, mGridFrameColor, 1dip)
	
	For i = 3 To NbRows + 1
		cvsCalendar.DrawLine(x0, i * mRowHeight, x1, i * mRowHeight, mGridColor, 1dip)
	Next
	cvsCalendar.DrawLine(x0, i * mRowHeight, x1, i * mRowHeight, mGridFrameColor, 2dip)
	
	CurrentDayTicks = mBeginHourTicks + ScrollH.BeginIndex * DateTime.TicksPerDay
	Private CurrentBeginDay As Int
	CurrentBeginDay = DateTime.GetDayOfMonth(mBeginDayTicks + ScrollH.BeginIndex * DateTime.TicksPerDay)

	If CurrentBeginDay >= 10 And CurrentBeginDay < 20 Then
		cvsCalendar.DrawText(Date, x0 + mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "LEFT")
	End If
	
	y0 = mRowHeight
	yt = 1.5 * mRowHeight - mTextCenterY
	For i = 0 To NbColumns - 1
		x1 = x0 + (i + 1) * mColumnTimeWidth
		x2 = x1 - mColumnTimeWidth
		xt = x1 - 0.5 * mColumnTimeWidth
		
		Private DayOfWeek As Int
		Private Day As String
		CurrentDayTicks = mBeginDayTicks + (i + ScrollH.BeginIndex) * DateTime.TicksPerDay
		Date = GetDate(CurrentDayTicks, mDateFormat)
		DayOfWeek = DateTime.GetDayOfWeek(CurrentDayTicks)
		Day = DayNames(DayOfWeek - 1).CharAt(0)
		cvsCalendar.DrawText(Day, xt, yt, mTextFont, mTextColor, "CENTER")
		
		If DayOfWeek = 2 Then
			cvsCalendar.DrawLine(x1, y0, x1, y1, mGridColor, 1dip)
			cvsCalendar.DrawLine(x2, 0, x2, y1, mGridFrameColor, 1dip)
			If i < NbColumnsVisible - 3 Then
				cvsCalendar.DrawText(Date, x2 + mPadding, 0.5 * mRowHeight - mTextCenterY, mTextFont, mTextColor, "LEFT")
			End If
		Else
			cvsCalendar.DrawLine(x1, y0, x1, y1, mGridColor, 1dip)
		End If
	Next
	cvsCalendar.DrawLine(x1, 0, x1, y1, mGridFrameColor, 2dip)
End Sub

'Draws the Task data
Private Sub DrawTasksData
	Private x0, x1, x2, y0, y1, y2, y3 As Int
	Private TicksBegin, BeginTicks, EndTicks As Long
	
	Select mTimeDisplayMode
		Case "HOUR"
			BeginTicks = mBeginHourTicks + ScrollH.BeginIndex * DateTime.TicksPerHour
			EndTicks = mBeginHourTicks + ScrollH.EndIndex * DateTime.TicksPerHour
			TicksBegin = mBeginHourTicks
		Case Else
			BeginTicks = mBeginDayTicks + ScrollH.BeginIndex * DateTime.TicksPerDay
			EndTicks = mBeginDayTicks + NbColumns * DateTime.TicksPerDay
			TicksBegin = mBeginDayTicks
	End Select
	
	x0 = mFirstColumsWidth - ScrollH.BeginIndex * mColumnTimeWidth
	For i = 0 To NbRows - 1
		Private Row As GanttLiteRowData
		
		Row = Rows.Get(ScrollV.BeginIndex + i)

		Select Row.ObjectType
			Case "Task"
				Private Task As GanttLiteTaskData
				Private rect As B4XRect
				Task = GetTask(Row.ObjectID)
				Task.BeginTimeX = x0 + (Task.BeginTimeTicks - TicksBegin) * TicksToTimeWidthScale
				Task.EndTimeX = x0 + (Task.EndTimeTicks - TicksBegin) * TicksToTimeWidthScale
				If Task.BeginTimeTicks > EndTicks Then
					DrawArrowRight(i, Task.Color)
				Else If Task.EndTimeTicks < BeginTicks Then
					DrawArrowLeft(i, Task.Color)
				Else
					If Task.BeginTimeTicks < DateTime.Now And  Task.EndTimeTicks < DateTime.Now Then
						x1 = Task.BeginTimeX
						x2 = Task.EndTimeX
						y1 = (i + 2) * mRowHeight + 2dip
						y2 = (i + 3) * mRowHeight - 2dip
						rect.Initialize(x1, y1, x2, y2)
						cvsDiagram.DrawRect(rect, Task.Color, True, 1dip)
					Else If Task.BeginTimeTicks < DateTime.Now And  Task.EndTimeTicks > DateTime.Now Then
						x1 = Task.BeginTimeX
						x2 = x0 + (DateTime.Now - TicksBegin) * TicksToTimeWidthScale
						y1 = (i + 2) * mRowHeight + 2dip
						y2 = (i + 3) * mRowHeight - 2dip
						rect.Initialize(x1, y1, x2, y2)
						cvsDiagram.DrawRect(rect, Task.Color, True, 1dip)
						x1 = x0 + (DateTime.Now - TicksBegin) * TicksToTimeWidthScale - 2dip
						x2 = Task.EndTimeX - 2dip
						y1 = (i + 2) * mRowHeight + 4dip
						y2 = (i + 3) * mRowHeight - 4dip
						rect.Initialize(x1, y1, x2, y2)
						cvsDiagram.DrawRect(rect, Task.Color, False, 4dip)
					Else
						x1 = Task.BeginTimeX
						x2 = Task.EndTimeX
						y1 = (i + 2) * mRowHeight + 4dip
						y2 = (i + 3) * mRowHeight - 4dip
						rect.Initialize(x1, y1, x2, y2)
						cvsDiagram.DrawRect(rect, Task.Color, False, 4dip)
					End If
				End If
			Case "Group"
				Private Group As GanttLiteGroupData
				Private rect As B4XRect
				Private path As B4XPath
				Group = GetGroup(Row.ObjectID)
				If Group.BeginTimeTicks > EndTicks Then
					DrawArrowRight(i, Group.Color)
				Else If Group.EndTimeTicks < BeginTicks Then
					DrawArrowLeft(i, Group.Color)
				Else
					x1 = x0 + (Group.BeginTimeTicks - TicksBegin) * TicksToTimeWidthScale
					x2 = x0 + (Group.EndTimeTicks - TicksBegin) * TicksToTimeWidthScale
					y1 = (i + 2) * mRowHeight + 1dip
					y2 = (i + 2.5) * mRowHeight - 1dip
					y3 = (i + 3) * mRowHeight - 1dip
					rect.Initialize(x1, y1, x2, y2)
					cvsDiagram.DrawRect(rect, Group.Color, True, 1dip)
					path.Initialize(x1, y1)
					path.LineTo(x1 + 0.8 * mRowHeight, y1)
					path.LineTo(x1, y3)
					cvsDiagram.DrawPath(path, Group.Color, True, 1dip)
					path.Initialize(x2 - 0.8 * mRowHeight, y1)
					path.LineTo(x2, y1)
					path.LineTo(x2, y3)
					cvsDiagram.DrawPath(path, Group.Color, True, 1dip)
				End If
		End Select
	Next
	
	If mBeginTimeTicks < DateTime.Now And mEndTimeTicks > DateTime.Now Then
		y0 = 2 * mRowHeight
		y1 = (NbRows + 2) * mRowHeight
		x1 = x0 + (DateTime.Now - TicksBegin) * TicksToTimeWidthScale
		cvsDiagram.DrawLine(x1, y0, x1, y1, xui.Color_Red, 1dip)
	End If
	
	cvsDiagram.Invalidate
	cvsCursor.Invalidate
	
	cvsDiagram.RemoveClip
End Sub

Private Sub DrawScaleButtons
	Private xt, yt As Int
	Private Color As Int
	Private rect As B4XRect
	
	rect = cvsScaleButtons.MeasureText("H", mTextFont)
	Color = xui.Color_DarkGray
	Select mTimeDisplayMode
		Case "HOUR"
			yt = ScrollH.BarWidth / 2 - rect.CenterY
			xt = 0.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("H", xt, yt, mTextFont, xui.Color_Red, "CENTER")
			xt = 1.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("D", xt, yt, mTextFont, Color, "CENTER")
			xt = 2.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("d", xt, yt, mTextFont, Color, "CENTER")
		Case "DAY_LARGE"
			yt = ScrollH.BarWidth / 2 - rect.CenterY
			xt = 0.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("H", xt, yt, mTextFont, Color, "CENTER")
			xt = 1.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("D", xt, yt, mTextFont, xui.Color_Red, "CENTER")
			xt = 2.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("d", xt, yt, mTextFont, Color, "CENTER")
		Case "DAY_SMALL"
			yt = ScrollH.BarWidth / 2 - rect.CenterY
			xt = 0.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("H", xt, yt, mTextFont, Color, "CENTER")
			xt = 1.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("D", xt, yt, mTextFont, Color, "CENTER")
			xt = 2.5 * ScrollH.ButtonLength
			cvsScaleButtons.DrawText("d", xt, yt, mTextFont, xui.Color_Red, "CENTER")
	End Select
	cvsScaleButtons.Invalidate
End Sub

Private Sub DisplayData(X As Int, Y As Int)
	If mDisplayRowData = False Then
		Return
	End If
	
	If X < 0 Or Y < 2 * mRowHeight Or X > pnlDiagram.Width Or Y > pnlDiagram.Height Then
		pnlDisplayData.Visible = False
		Return
	End If
	
	Private x0, xc, yt As Int
	Private rectTitle, rectInternal As B4XRect
	Private Comment As String
	Private Height As Int
	
	pnlDisplayData.Left = 0
	pnlDisplayData.Top = 0
'	pnlDisplayData.Top = mRowHeight

	pnlDisplayData.Visible = True

	DateTime.DateFormat = mDateFormat & "  HH:mm"
	
	rectTitle.Initialize(0, 0, pnlDisplayData.Width, 1.8 * mTextHeight)
	rectInternal.Initialize(2dip, 2dip, pnlDisplayData.Width - 2dip, pnlDisplayData.Height - 2dip)
	Private Row As GanttLiteRowData
	Row = Rows.Get(CursorRow)
	
	x0 = mPadding
	xc = pnlDisplayData.Width / 2
	yt = 1.8 * mTextHeight + mTextCenterY

	Select Row.ObjectType
		Case "Empty"
			pnlDisplayData.Visible = False
			Return
		Case "Group"
			Private Group As GanttLiteGroupData
			Group = GetGroup(Row.ObjectID)
			Comment = Group.Comment
			Height = 8 * mTextHeight
		Case "Task"
			Private Task As GanttLiteTaskData
			Task = GetTask(Row.ObjectID)
			Comment = Task.Comment
			Height =  11 * mTextHeight
	End Select
	
	Private Comments As List
	If Comment <> "" Then
		Comments = GetCommentLines(Comment, rectInternal.Width - 2 * mPadding)
		Height = Height + (Comments.Size + 1.7) * 1.5 * mTextHeight
	End If
	pnlDisplayData.Height = Height
	cvsDisplayData.Resize(pnlDisplayData.Width, pnlDisplayData.Height)
	
	cvsDisplayData.ClearRect(rectInternal)
	cvsDisplayData.DrawRect(cvsDisplayData.TargetRect, mBackgroundColor, True, 1dip)

	Select Row.ObjectType
		Case "Group"
			Private Group As GanttLiteGroupData
			cvsDisplayData.DrawRect(rectTitle, xui.Color_Gray, True, 1dip)
			Group = GetGroup(Row.ObjectID)
			cvsDisplayData.DrawRect(rectTitle,Group.Color, True, 1dip)
			cvsDisplayData.DrawText(Texts.Get(2), xc, yt, mTextFontBold, ContrastColor(Group.Color), "CENTER")
			yt = yt + 1.8 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(1) & " : " & Group.ID, x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(5) & " : " & Group.Name, x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(7) & " : " & DateTime.Date(Group.BeginTimeTicks), x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(8) & " : " & DateTime.Date(Group.EndTimeTicks), x0, yt, mTextFont, xui.Color_Black, "LEFT")
			Comment = Group.Comment
		Case "Task"
			Private Task As GanttLiteTaskData
			Task = GetTask(Row.ObjectID)
			cvsDisplayData.DrawRect(rectTitle,Task.Color, True, 1dip)
			cvsDisplayData.DrawText(Texts.Get(3), xc, yt, mTextFontBold, ContrastColor(Task.Color), "CENTER")
			yt = yt + 1.8 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(1) & " : " & Task.ID, x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(5) & " : " & Task.Name, x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(9) & " : " & Task.Responsible, x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(7) & " : " & DateTime.Date(Task.BeginTimeTicks), x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Texts.Get(8) & " : " & DateTime.Date(Task.EndTimeTicks), x0, yt, mTextFont, xui.Color_Black, "LEFT")
			yt = yt + 1.5 * mTextHeight
			Private txt As String
			If Task.GroupID = "" Then
				txt = "-"
			Else
				txt = Task.GroupID
			End If
			cvsDisplayData.DrawText(Texts.Get(2) & " : " & txt, x0, yt, mTextFont, xui.Color_Black, "LEFT")
			Comment = Task.Comment
	End Select
	
	If Comment <> "" Then
		yt = yt + 2.5 * mTextHeight
		cvsDisplayData.DrawText(Texts.Get(6) & " :", x0, yt, mTextFont, xui.Color_Black, "LEFT")
		For i = 0 To Comments.Size - 1
			yt = yt + 1.5 * mTextHeight
			cvsDisplayData.DrawText(Comments.Get(i), x0, yt, mTextFont, xui.Color_Black, "LEFT")
		Next
	End If

	cvsDisplayData.DrawRect(cvsDisplayData.TargetRect, xui.Color_Black, False, 3dip)

	DateTime.DateFormat = mDateFormat
End Sub

Private Sub DrawArrowLeft(i As Int, Color As Int)
	Private rect As B4XRect
	Private path As B4XPath
	Private x0, y0 As Int
	
	y0 = (i + 2.5) * mRowHeight
	x0 = mFirstColumsWidth + 5dip
	rect.Initialize(x0, y0 - 2dip, x0 + 9dip, y0 + 2dip)
	cvsDiagram.DrawRect(rect, Color, True, 1dip)

	path.Initialize(mFirstColumsWidth + 2dip, y0)
	path.LineTo(mFirstColumsWidth + 8dip, y0 + 6dip)
	path.LineTo(mFirstColumsWidth + 8dip, y0 - 6dip)
	cvsDiagram.DrawPath(path, Color, True, 1dip)	
End Sub

Private Sub DrawArrowRight(i As Int, Color As Int)
	Private rect As B4XRect
	Private path As B4XPath
	Private x0, y0 As Int
	
	y0 = (i + 2.5) * mRowHeight
	x0 = pnlDiagram.Width - 14dip
	rect.Initialize(x0, y0 - 2dip, x0 + 7dip, y0 + 2dip)
	cvsDiagram.DrawRect(rect, Color, True, 1dip)
	
	path.Initialize(pnlDiagram.Width - 2dip, y0)
	path.LineTo(pnlDiagram.Width - 8dip, y0 + 6dip)
	path.LineTo(pnlDiagram.Width - 8dip, y0 - 6dip)
	cvsDiagram.DrawPath(path, Color, True, 1dip)
End Sub

'Resizes the chart
Private Sub ResizeChart
	GetColumnWidths
	GetDisplayDataWidth
	GetBeginAndEndTicks
	
	Private rect As B4XRect
	Select mTimeDisplayMode
		Case "HOUR"
			rect = cvsCursor.MeasureText("Mg", mTextFont)
			mColumnTimeWidth = rect.Width * 1.6
			TicksToTimeWidthScale = mColumnTimeWidth / DateTime.TicksPerHour
		Case "DAY_LARGE"
			rect = cvsCursor.MeasureText("2024-08-12", mTextFont)
			mColumnTimeWidth = rect.Width + mRowHeight
			TicksToTimeWidthScale = mColumnTimeWidth / DateTime.TicksPerDay
		Case "DAY_SMALL"
			rect = cvsCursor.MeasureText("M", mTextFont)
			mColumnTimeWidth = rect.Width * 1.6
			TicksToTimeWidthScale = mColumnTimeWidth / DateTime.TicksPerDay
	End Select

	NbRowsTotal = Rows.Size

	NbRowsVisible = (mHeight  - 1.2 * ScrollH.BarWidth) / mRowHeight - 2
	NbColumnsVisible = (mWidth - mFirstColumsWidth - 1.2 * ScrollH.BarWidth)/ mColumnTimeWidth

	If NbRowsVisible < Rows.Size Then
		pnlDiagram.Height = mHeight - 1.2 * ScrollH.BarWidth
		NbRowsVisible = (mHeight  - 1.2 * ScrollH.BarWidth) / mRowHeight - 2
	Else
		pnlDiagram.Height = mHeight - 1.2 *  ScrollH.BarWidth + 2dip
	End If
	
	If NbColumnsVisible < NbColumnsTotal Then
		pnlDiagram.Height = mHeight - 1.2 *  ScrollH.BarWidth + 2dip
		NbRowsVisible = (mHeight  - 1.2 * ScrollH.BarWidth) / mRowHeight - 2
	Else
		pnlDiagram.Height = mHeight -1.2 *  ScrollH.BarWidth + 2dip
	End If

	NbRows = Min(NbRowsVisible, NbRowsTotal)
	NbColumns = Min(NbColumnsVisible, NbColumnsTotal)
	
	pnlDiagram.Width = mFirstColumsWidth + NbColumns * mColumnTimeWidth
	pnlDiagram.Height = (NbRows + 2) * mRowHeight
	cvsDiagram.Resize(pnlDiagram.Width, pnlDiagram.Height)
	
	pnlCursor.Width = pnlDiagram.Width
	pnlCursor.Height = pnlDiagram.Height
	cvsCursor.Resize(pnlDiagram.Width, pnlDiagram.Height)

	pnlCalendar.Width = pnlDiagram.Width
	pnlCalendar.Height = pnlDiagram.Height
	cvsCalendar.Resize(pnlDiagram.Width, pnlDiagram.Height)
	
	FirstColumnsRect.Initialize(0, 0, mFirstColumsWidth, pnlDiagram.Height)
	GanttRect.Initialize(mFirstColumsWidth, 0, pnlDiagram.Width, pnlDiagram.Height)
	
	CalendarPath.Initialize(mFirstColumsWidth, 0)
	CalendarPath.LineTo(pnlDiagram.Width, 0)
	CalendarPath.LineTo(pnlDiagram.Width, pnlDiagram.Height)
	CalendarPath.LineTo(mFirstColumsWidth, pnlDiagram.Height)
	
	ScrollBarResizeH
	ScrollBarResizeV
	If NbRowsVisible < Rows.Size Then
		ScrollCursorDrawV		
	End If
	If NbColumnsVisible < NbColumnsTotal Then
		ScrollCursorDrawH
	End If
End Sub

Private Sub GetColumnWidths
	Private i As Int
	Private rect As B4XRect
	
	rect = cvsCursor.MeasureText(Texts.Get(0), mTextFont)
	mColumnRowWidth = rect.Width
	rect = cvsCursor.MeasureText(Rows.Size, mTextFont)
	mColumnRowWidth = Max(rect.Width, mColumnRowWidth)
	mColumnRowWidth = mColumnRowWidth + 2 * mPadding
	
	rect = cvsCursor.MeasureText(Texts.Get(1), mTextFont)
	mColumnIDWidth = rect.Width
	rect = cvsCursor.MeasureText(Texts.Get(3), mTextFont)
	mColumnNameWidth = rect.Width
	rect = cvsCursor.MeasureText(Texts.Get(9), mTextFont)
	mColumnResponsibleWidth = rect.Width
	
	For i = 0 To Groups.Size - 1
		Private Group As GanttLiteGroupData
		Group = Groups.Get(i)
		rect = cvsCursor.MeasureText(Group.ID, mTextFont)
		If rect.Width > mColumnIDWidth Then
			mColumnIDWidth = rect.Width
		End If
		rect = cvsCursor.MeasureText(Group.Name, mTextFont)
		If rect.Width > mColumnNameWidth Then
			mColumnNameWidth = rect.Width
		End If
	Next

	For i = 0 To Tasks.Size - 1
		Private Tk As GanttLiteTaskData
		Tk = Tasks.Get(i)
		rect = cvsCursor.MeasureText(Tk.ID, mTextFont)
		If rect.Width > mColumnIDWidth Then
			mColumnIDWidth = rect.Width
		End If
		rect = cvsCursor.MeasureText(Tk.Name, mTextFont)
		If rect.Width > mColumnNameWidth Then
			mColumnNameWidth = rect.Width
		End If
		rect = cvsCursor.MeasureText(Tk.Responsible, mTextFont)
		If rect.Width > mColumnResponsibleWidth Then
			mColumnResponsibleWidth = rect.Width
		End If
	Next
	mColumnIDWidth = mColumnIDWidth + 2 * mPadding
	mColumnNameWidth = mColumnNameWidth + 2 * mPadding
	mColumnResponsibleWidth = mColumnResponsibleWidth + 2 * mPadding
	
	mFirstColumsWidth = 0
	If mDisplayRowIndexColumn = True Then
		mFirstColumsWidth = mColumnRowWidth
	End If
	mFirstColumsWidth = mFirstColumsWidth + mColumnIDWidth + mColumnNameWidth
	If mDisplayResponsibleColumn = True Then
		mFirstColumsWidth = mFirstColumsWidth + mColumnResponsibleWidth
	End If
End Sub

Private Sub GetDisplayDataWidth
	Private i, DisplayWidth As Int
	Private rect As B4XRect
	
	rect = cvsDisplayData.MeasureText(Texts.Get(7) & " = " & mDateFormat & "23:59", mTextFont)
	DisplayWidth = rect.Width
	
	For i = 0 To Groups. Size - 1
		Private Group As GanttLiteGroupData
		
		Group = Groups.Get(i)
		rect = cvsDisplayData.MeasureText(Texts.Get(5) & " = " & Group.Name, mTextFont)
		If DisplayWidth < rect.Width Then
			DisplayWidth = rect.Width
		End If
	Next
	
	For i = 0 To Tasks.Size - 1
		Private Task As GanttLiteTaskData
		
		Task = Tasks.Get(i)
		rect  = cvsDisplayData.MeasureText(Texts.Get(5) & " = " & Task.Name, mTextFont)
		If DisplayWidth < rect.Width Then
			DisplayWidth = rect.Width
		End If
		rect  = cvsDisplayData.MeasureText(Texts.Get(9) & " = " & Task.Responsible, mTextFont)
		If DisplayWidth < rect.Width Then
			DisplayWidth = rect.Width
		End If
	Next
	pnlDisplayData.Width = DisplayWidth + 2 * mPadding
End Sub

'Splits a long text into a List of strings for a given width
Private Sub GetCommentLines(Comment As String, Width As Int) As List
	Private txts As List
	Private t As String
	Private x1, x2, x3, xp, length As Int
	Private rect As B4XRect
	
	txts.Initialize
	
	rect = cvsCursor.MeasureText(Comment, mTextFont)
	x3 = Comment.IndexOf2(CRLF, x3 + 1)
	If rect.Width <= Width Then
		txts.Add(Comment)
	Else If x3 = -1 Then
		x2 = 1
		Do While x2 > 0
			length = 0
			Do While (length < Width And x2 > 0)
				xp = x2
				x2 = Comment.IndexOf2(" ", x2 + 1)
				If x2 = -1 Then
					t = Comment.SubString(x1)
				Else
					t = Comment.SubString2(x1, x2)
				End If
				rect = cvsCursor.MeasureText(t, mTextFont)
				length = Floor(rect.Width)
				If length > Width Then
					t = Comment.SubString2(x1, xp)
					x2 = xp
				End If
			Loop
			txts.Add(t)
			x1 = x2 + 1
		Loop
	Else
		Private ttxt() As String
		ttxt = Regex.Split(CRLF, Comment)
		For i = 0 To ttxt.Length - 1
			x2 = 1
			Do While x2 > 0
				length = 0
				Do While (length < Width And x2 > 0)
					xp = x2
					x2 = ttxt(i).IndexOf2(" ", x2 + 1)
					If x2 = -1 Then
						t = ttxt(i).SubString(x1)
					Else
						t = ttxt(i).SubString2(x1, x2)
					End If
					rect = cvsCursor.MeasureText(t, mTextFont)
					length = Ceil(rect.Width)
					If length > Width Then
						t = ttxt(i).SubString2(x1, xp)
						x2 = xp
					End If
				Loop
				txts.Add(t)
				x1 = x2 + 1
			Loop
		Next
	End If
	Return txts
End Sub

'Gets the beginn (earliest) and end (latest) time of the chart
Private Sub GetBeginAndEndTicks
	Private i As Int
'	Private mBeginTimeTicks, mEndTimeTicks As Long
	Private Tk As GanttLiteTaskData
	
	If AutomaticBeginEndDates = True Then
		mBeginTimeTicks = 1000000000000000000
		mEndTimeTicks = 0
	
		For i = 0 To Tasks.Size - 1
			Tk = Tasks.Get(i)
			If Tk.BeginTimeTicks < mBeginTimeTicks Then
				mBeginTimeTicks = Tk.BeginTimeTicks
			End If
			If Tk.EndTimeTicks > mEndTimeTicks Then
				mEndTimeTicks = Tk.EndTimeTicks
			End If
		Next
		mBeginDate = DateTime.Date(mBeginTimeTicks).SubString2(0, 10)
		mEndDate = DateTime.Date(mEndTimeTicks).SubString2(0, 10)
	End If

	DateTime.DateFormat = "yyyy-MM-dd HH:mm"
	mBeginHourTicks = mBeginTimeTicks - DateTime.GetMinute(mBeginTimeTicks) * DateTime.TicksPerMinute
	mBeginDayTicks = DateTime.DateParse(mBeginDate & " 00:00")
	mEndDayTicks = DateTime.DateParse(mEndDate & " 00:00")
	Select mTimeDisplayMode
		Case "HOUR"
			NbColumnsTotal = (mEndTimeTicks - mBeginTimeTicks) / DateTime.TicksPerHour + 1
			If 60 - DateTime.GetMinute(mBeginTimeTicks) + DateTime.GetMinute(mEndTimeTicks) < 60 Then
				NbColumnsTotal = NbColumnsTotal + 1
			End If
		Case Else
			NbColumnsTotal = (mEndTimeTicks - mBeginTimeTicks) / DateTime.TicksPerDay + 1
	End Select
	
	For i = 0 To Groups.Size - 1
		Private Group As GanttLiteGroupData
		
		Group = Groups.Get(i)
		Group.BeginTimeTicks = 1000000000000000000
		Group.EndTimeTicks = 0
		
		For j = 0 To Group.TaskList.Size - 1
			Private Task As GanttLiteTaskData
			
			Task = GetTask(Group.TaskList.Get(j))
			If Task.BeginTimeTicks < Group.BeginTimeTicks Then
				Group.BeginTimeTicks = Task.BeginTimeTicks
			End If
			If Task.EndTimeTicks > Group.EndTimeTicks Then
				Group.EndTimeTicks = Task.EndTimeTicks
			End If
		Next
	Next
End Sub

'Initializes the ScrollBar parameters
Private Sub ScrollBarsInit
#If B4J
	ScrollV.BarWidth = 18dip
	ScrollV.ButtonLength = 20dip
#Else
	ScrollV.BarWidth = 22dip
	ScrollV.ButtonLength = 24dip
#End If
	ScrollV.CornerRadius = 2dip

	ScrollH.ColorBar = xui.Color_RGB(196, 196, 196)
	ScrollH.ColorButton = xui.Color_RGB(240, 240, 240)
	ScrollH.ColorButtonFrame = xui.Color_RGB(148, 148, 148)
	ScrollH.BarWidth = ScrollV.BarWidth
	ScrollH.ButtonLength = ScrollV.ButtonLength
	ScrollH.CornerRadius = ScrollV.CornerRadius
	
	ScrollV.ColorBar = xui.Color_RGB(196, 196, 196)
	ScrollV.ColorButton = xui.Color_RGB(240, 240, 240)
	ScrollV.ColorButtonFrame = xui.Color_RGB(148, 148, 148)
End Sub

'Resizes the vertical ScrollBar object
Private Sub ScrollBarResizeV
	Private pth As B4XPath
	Private rect As B4XRect
	Private y0 As Int

	pnlScrollBarV.Visible = True
	cvsScrollBarV.ClearRect(cvsScrollBarV.TargetRect)
	rect.Initialize(0, ScrollV.CornerRadius, ScrollV.BarWidth, ScrollV.BarLength - ScrollV.CornerRadius)
	cvsScrollBarV.DrawRect(rect, ScrollV.ColorBar, True, 1dip)
	cvsScrollBarV.Invalidate
	
	pnlScrollBarV.Left = mBase.Width - ScrollV.BarWidth - 2dip
	pnlScrollBarV.Top = 2 * mRowHeight
	pnlScrollBarV.Height = NbRowsVisible * mRowHeight
	pnlScrollBarV.Width = ScrollV.BarWidth
	ScrollV.BarLength = pnlScrollBarV.Height
	ScrollV.CursorLength = (pnlScrollBarV.Height - 4 * ScrollV.ButtonLength) / NbRowsTotal * NbRowsVisible

	If ScrollV.CursorLength >= (ScrollV.BarLength - 4 * ScrollV.ButtonLength) Then
		ScrollV.Active = False
		pnlScrollBarV.Visible = False
		Return
	End If
	cvsScrollBarV.Resize(pnlScrollBarV.Width, pnlScrollBarV.Height)
	
	cvsScrollBarV.ClearRect(cvsScrollBarV.TargetRect)
	rect.Initialize(0, ScrollV.CornerRadius, ScrollV.BarWidth, ScrollV.BarLength - ScrollV.CornerRadius)
	cvsScrollBarV.DrawRect(rect, ScrollV.ColorBar, True, 1dip)
	cvsScrollBarV.Invalidate

	'Draw begin button
	rect.Initialize(0, 0, ScrollV.BarWidth, ScrollV.ButtonLength)
	pth.InitializeRoundedRect(rect, ScrollV.CornerRadius)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButton, True, 1dip)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, False, 1dip)
	
	'Draw begin button arrow
	pth.Initialize(0.5 * pnlScrollBarV.Width, 0.37 * ScrollV.ButtonLength)
	pth.LineTo(0.23 * pnlScrollBarV.Width, 0.62 * ScrollV.ButtonLength)
	pth.LineTo(0.77 * pnlScrollBarV.Width, 0.62 * ScrollV.ButtonLength)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, True, 1dip)
	cvsScrollBarV.DrawLine(0.25 * pnlScrollBarV.Width, 0.37 * ScrollV.ButtonLength - 1dip, 0.75 * pnlScrollBarV.Width, 0.37 * ScrollV.ButtonLength - 1dip, ScrollV.ColorButtonFrame, 2dip)
	
	'Draw up button
	y0 = ScrollV.ButtonLength
	rect.Initialize(0, y0, ScrollV.BarWidth, y0 + ScrollV.ButtonLength)
	pth.InitializeRoundedRect(rect, ScrollV.CornerRadius)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButton, True, 1dip)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, False, 1dip)
	
	'Draw up button arrow
	pth.Initialize(0.5 * pnlScrollBarV.Width, y0 + 0.37 * ScrollV.ButtonLength)
	pth.LineTo(0.23 * pnlScrollBarV.Width, y0 + 0.62 * ScrollV.ButtonLength)
	pth.LineTo(0.77 * pnlScrollBarV.Width, y0 + 0.62 * ScrollV.ButtonLength)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, True, 1dip)
	
	'Draw down button
	y0 = pnlScrollBarV.Height - 2 * ScrollV.ButtonLength
	rect.Initialize(0, y0, pnlScrollBarV.Width, pnlScrollBarV.Height)
	pth.InitializeRoundedRect(rect, ScrollV.CornerRadius)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButton, True, 1dip)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, False, 1dip)
	
	'Draw down button arrow
	pth.Initialize(0.23 * ScrollV.BarWidth, y0 + 0.38 * ScrollV.ButtonLength)
	pth.LineTo(0.5 * ScrollV.BarWidth, y0 + 0.62 * ScrollV.ButtonLength)
	pth.LineTo(0.77 * ScrollV.BarWidth, y0 + 0.38 * ScrollV.ButtonLength)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, True, 1dip)
	
	'Draw end button
	y0 = pnlScrollBarV.Height - ScrollV.ButtonLength
	rect.Initialize(0, y0, pnlScrollBarV.Width, pnlScrollBarV.Height)
	pth.InitializeRoundedRect(rect, ScrollV.CornerRadius)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButton, True, 1dip)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, False, 1dip)
	
	'Draw right end arrow
	pth.Initialize(0.23 * ScrollV.BarWidth, y0 + 0.38 * ScrollV.ButtonLength)
	pth.LineTo(0.5 * ScrollV.BarWidth, y0 + 0.62 * ScrollV.ButtonLength)
	pth.LineTo(0.77 * ScrollV.BarWidth, y0 + 0.38 * ScrollV.ButtonLength)
	cvsScrollBarV.DrawPath(pth, ScrollV.ColorButtonFrame, True, 1dip)
	cvsScrollBarV.DrawLine(0.25 * pnlScrollBarV.Width, y0 + 0.62 * ScrollV.ButtonLength + 1dip, 0.75 * pnlScrollBarV.Width, y0 + 0.62 * ScrollV.ButtonLength + 1dip, ScrollV.ColorButtonFrame, 2dip)
	
	cvsScrollBarV.Invalidate
End Sub

'Resizes the horizontal ScrollBar object
Private Sub ScrollBarResizeH
	Private pth As B4XPath
	Private rect As B4XRect
	Private x0 As Int
	
	cvsScrollBarH.ClearRect(cvsScrollBarH.TargetRect)
	rect.Initialize(ScrollH.CornerRadius, 0, ScrollH.BarLength - ScrollH.CornerRadius, ScrollH.BarWidth)
	cvsScrollBarH.DrawRect(rect, ScrollH.ColorBar, True, 1dip)
	cvsScrollBarH.Invalidate
	
	pnlScrollBarH.Left = mFirstColumsWidth
	pnlScrollBarH.Top = mBase.Height - ScrollH.BarWidth
	pnlScrollBarH.Height = ScrollH.BarWidth
	pnlScrollBarH.Width = NbColumns * mColumnTimeWidth
	cvsScrollBarH.Resize(pnlScrollBarH.Width, pnlScrollBarH.Height)
	ScrollH.BarLength = pnlScrollBarH.Width
	ScrollH.CursorLength = (pnlScrollBarH.Width - 4 * ScrollH.ButtonLength) / NbColumnsTotal * NbColumnsVisible
	
	pnlScaleButtons.Top = mBase.Height - ScrollH.BarWidth
	
	If NbColumnsVisible >= NbColumnsTotal Then
		ScrollH.Active = False
		ScrollH.BeginIndex = 0
		ScrollH.EndIndex = NbColumns - 1
		ScrollH.CursorLength = (pnlScrollBarH.Width - 4 * ScrollH.ButtonLength) / NbColumnsTotal * NbColumnsVisible
	Else
		ScrollH.Active = True
		ScrollH.BeginIndex = 0
		ScrollH.EndIndex = ScrollV.BeginIndex + NbColumns - 1
	End If
	pnlScrollBarH.Visible = ScrollH.Active
	
	'button begin
	rect.Initialize(0, 0, ScrollH.ButtonLength, ScrollH.BarWidth)
	pth.InitializeRoundedRect(rect, ScrollH.CornerRadius)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButton, True, 1dip)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, False, 1dip)

	pth.Initialize(0.37 * ScrollH.ButtonLength, 0.5 * ScrollH.BarWidth)
	pth.LineTo(0.62 * ScrollH.ButtonLength, 0.23 * ScrollH.BarWidth)
	pth.LineTo(0.62 * ScrollH.ButtonLength, 0.77 * ScrollH.BarWidth)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, True, 1dip)
	cvsScrollBarH.DrawLine(0.37 * ScrollH.ButtonLength - 1dip, 0.3 * ScrollH.BarWidth, 0.37 * ScrollH.ButtonLength - 1dip, 0.7 * ScrollH.BarWidth, ScrollH.ColorButtonFrame, 2dip)

	'button left
	x0 = ScrollH.ButtonLength
	rect.Initialize(x0, 0, x0 + ScrollH.ButtonLength, ScrollH.BarWidth)
	pth.InitializeRoundedRect(rect, ScrollH.CornerRadius)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButton, True, 1dip)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, False, 1dip)

	pth.Initialize(x0 + 0.37 * ScrollH.ButtonLength, 0.5 * ScrollH.BarWidth)
	pth.LineTo(x0 + 0.62 * ScrollH.ButtonLength, 0.23 * ScrollH.BarWidth)
	pth.LineTo(x0 + 0.62 * ScrollH.ButtonLength, 0.77 * ScrollH.BarWidth)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, True, 1dip)
	
	'button right
	x0 = pnlScrollBarH.Width - 2 * ScrollH.ButtonLength
	rect.Initialize(x0, 0, pnlScrollBarH.Width, pnlScrollBarH.Height)
	pth.InitializeRoundedRect(rect, ScrollH.CornerRadius)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButton, True, 1dip)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, False, 1dip)
	
	pth.Initialize(x0 + 0.38 * ScrollH.ButtonLength, 0.23 * ScrollH.BarWidth)
	pth.LineTo(x0 + 0.62 * ScrollH.ButtonLength, 0.5 * ScrollH.BarWidth)
	pth.LineTo(x0 + 0.38 * ScrollH.ButtonLength, 0.77 * ScrollH.BarWidth)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, True, 1dip)
	
	'button end
	x0 = pnlScrollBarH.Width - ScrollH.ButtonLength
	rect.Initialize(x0, 0, pnlScrollBarH.Width, pnlScrollBarH.Height)
	pth.InitializeRoundedRect(rect, ScrollH.CornerRadius)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButton, True, 1dip)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, False, 1dip)
	
	pth.Initialize(x0 + 0.38 * ScrollH.ButtonLength, 0.23 * ScrollH.BarWidth)
	pth.LineTo(x0 + 0.62 * ScrollH.ButtonLength, 0.5 * ScrollH.BarWidth)
	pth.LineTo(x0 + 0.38 * ScrollH.ButtonLength, 0.77 * ScrollH.BarWidth)
	cvsScrollBarH.DrawPath(pth, ScrollH.ColorButtonFrame, True, 1dip)
	cvsScrollBarH.DrawLine(x0 + 0.62 * ScrollH.ButtonLength + 1dip, 0.25 * ScrollH.BarWidth,x0 +  0.62 * ScrollH.ButtonLength + 1dip, 0.75 * ScrollH.BarWidth, ScrollH.ColorButtonFrame, 2dip)
	
	cvsScrollBarH.Invalidate
End Sub

'Draws the vertical scroll cursor
Private Sub ScrollCursorDrawV
	Private rectCursor, rectBar As B4XRect
	Private pthCursor As B4XPath
	
	rectBar.Initialize(0, 2 * ScrollV.ButtonLength, ScrollV.BarWidth, pnlScrollBarV.Height - 2 * ScrollV.ButtonLength)
	cvsScrollBarV.DrawRect(rectBar, ScrollV.ColorBar, True, 1dip)

	ScrollV.CursorBegin = (pnlScrollBarV.Height - 4 * ScrollV.ButtonLength - ScrollV.CursorLength) / (NbRowsTotal - NbRowsVisible) * ScrollV.BeginIndex +  2 * ScrollV.ButtonLength
	If ScrollV.CursorBegin + ScrollV.CursorLength > ScrollV.BarLength - ScrollV.ButtonLength Then
		ScrollV.BeginIndex = (NbRowsTotal - NbRowsVisible)
		ScrollV.EndIndex = ScrollV.BeginIndex + NbRowsVisible - 1
		ScrollV.CursorBegin = (pnlScrollBarV.Width - 4 * ScrollV.ButtonLength - ScrollV.CursorLength) / (NbRowsTotal - NbRowsVisible) * ScrollV.BeginIndex + 2 * ScrollV.ButtonLength
	End If
	rectCursor.Initialize(0, ScrollV.CursorBegin, ScrollV.BarWidth, ScrollV.CursorBegin + ScrollV.CursorLength)
	pthCursor.InitializeRoundedRect(rectCursor, ScrollV.CornerRadius)
	cvsScrollBarV.DrawPath(pthCursor, ScrollV.ColorButton, True, 1dip)
	cvsScrollBarV.DrawPath(pthCursor, ScrollV.ColorButtonFrame, False, 1dip)

	cvsScrollBarV.Invalidate
	
	If ScrollV.Active = False Then
		If Scrolling = False Then
			If NbRowsVisible >= NbRowsTotal Then
				ScrollV.Active = False
				ScrollV.BeginIndex = 0
				ScrollV.EndIndex = NbRowsTotal - 1
				ScrollV.CursorLength = (pnlScrollBarV.Height - 2 * ScrollV.ButtonLength) / NbRowsTotal * NbRowsVisible
			Else
				ScrollV.Active = True
				ScrollV.BeginIndex = 0
				ScrollV.EndIndex = ScrollV.BeginIndex + NbRowsVisible - 1
			End If
		End If
	End If
End Sub

'Draws the horizonal scroll cursor
Private Sub ScrollCursorDrawH
	Private rectCursor, rectBar As B4XRect
	Private pthCursor As B4XPath
	
	If ScrollH.Active = False Then
		Return
	End If
	
	rectBar.Initialize(2 * ScrollH.ButtonLength, 0, ScrollH.BarLength - 2 * ScrollH.ButtonLength, pnlScrollBarH.Height)
	cvsScrollBarH.DrawRect(rectBar, ScrollH.ColorBar, True, 1dip)
	
	ScrollH.CursorBegin = (pnlScrollBarH.Width - 4 * ScrollH.ButtonLength - ScrollH.CursorLength) / (NbColumnsTotal - NbColumnsVisible) * ScrollH.BeginIndex + 2 * ScrollH.ButtonLength
	If ScrollH.CursorBegin + ScrollH.CursorLength > ScrollH.BarLength - ScrollH.ButtonLength Then
		ScrollH.BeginIndex = (NbColumnsTotal - NbColumnsVisible)
		ScrollH.EndIndex = ScrollH.BeginIndex + NbColumnsVisible - 1
		ScrollH.CursorBegin = (pnlScrollBarH.Width - 4 * ScrollH.ButtonLength - ScrollH.CursorLength) / (NbColumnsTotal - NbColumnsVisible) * ScrollH.BeginIndex + 2 * ScrollH.ButtonLength
	End If
	rectCursor.Initialize(ScrollH.CursorBegin, 0, ScrollH.CursorBegin + ScrollH.CursorLength, pnlScrollBarH.Height)
	pthCursor.InitializeRoundedRect(rectCursor, 3dip)
	cvsScrollBarH.DrawPath(pthCursor, ScrollH.ColorButton, True, 1dip)
	cvsScrollBarH.DrawPath(pthCursor, ScrollH.ColorButtonFrame, False, 1dip)

	cvsScrollBarH.Invalidate
End Sub

Private Sub pnlCursor_Touch (Action As Int, X As Float, Y As Float)
	If Action = 100 Then Return
	
	CursorRow = Y / mRowHeight - 2 + ScrollV.BeginIndex
	Select Action
		Case pnlCursor.TOUCH_ACTION_DOWN
			DoubleClickTime = 300
			If DateTime.Now - DownTime < DoubleClickTime  Then
				Private Row As GanttLiteRowData
				Row = Rows.Get(CursorRow)
				If Row.ObjectType = "Task" Then
					Private Task As GanttLiteTaskData
					Task = GetTask(Row.ObjectID)
					If X > Task.BeginTimeX And X < Task.EndTimeX Then
						SelectRow(True)
					End If
				End If
			Else
				DownTime = DateTime.Now
				Select EditMode
					Case "EditTask"
						If CursorRow <> SelectedRow Then
							SelectRow(False)
							EditMode = ""
						Else
							EditTask(Action, X, Y)
						End If
					Case Else
						DisplayData(X, Y)
						If CursorRow <> SelectedRow Then
							SelectRow(False)
						End If
				End Select
			End If
		Case pnlCursor.TOUCH_ACTION_MOVE
			Select EditMode.Contains("EditTask")
				Case True
					EditTask(Action , X, Y)
				Case Else
					DisplayData(X, Y)
			End Select
		Case pnlCursor.TOUCH_ACTION_UP
			Select EditMode.Length > 8
				Case True
					EditTask(Action , X, Y)
				Case Else
					If Y >= 2 * mRowHeight And Y <= (NbRows + 2) * mRowHeight Then
						If xui.SubExists(mCallBack, mEventName & "_SelectedRow", 1) Then
							CallSub2(mCallBack, mEventName & "_SelectedRow", CursorRow)
						End If
					End If
					pnlDisplayData.Visible = False
			End Select
	End Select
	
	If Action = pnlCursor.TOUCH_ACTION_UP Then

		If X >= mFirstColumsWidth And X <= mFirstColumsWidth + mColumnTimeWidth And Y <= (NbRows + 2) * mRowHeight Then
'			CheckJumpToEnd
			CheckJumpToBegin("Begin")
		Else If X >= pnlDiagram.Width - mColumnTimeWidth And X <= pnlDiagram.Width And Y <= (NbRows + 2) * mRowHeight Then
			CheckJumpToBegin("End")
		Else
			pnlDisplayData.Visible = False
		End If
	End If
End Sub
            
Private Sub pnlScrollBarH_Touch (Action As Int, X As Float, Y As Float)
	Private IndexBegin As Int
	
	If Action = 100 Or ScrollH.Active = False Then
		Return
	End If
	
	Select Action
		Case pnlScrollBarH.TOUCH_ACTION_DOWN
			If X > 0 And X < ScrollH.ButtonLength Then 'button begin
				IndexBegin = 0
				ScrollH.CursorOn = False
			Else If X > ScrollH.ButtonLength And X < 2 * ScrollH.ButtonLength Then 'button left
				IndexBegin = Max(0, ScrollH.BeginIndex - 1)
				ScrollH.CursorOn = False
			Else If X > ScrollH.BarLength - 2 * ScrollH.ButtonLength And X < ScrollH.BarLength - ScrollH.ButtonLength Then 'button right
				ScrollH.EndIndex = Min(ScrollH.EndIndex + 1, NbColumnsTotal - 1)
				IndexBegin = Min(ScrollH.BeginIndex + 1, NbColumnsTotal - NbColumnsVisible)
				ScrollH.CursorOn = False
			Else If X > ScrollH.BarLength - ScrollH.ButtonLength And X < ScrollH.BarLength Then ' button end
				IndexBegin = NbColumnsTotal - NbColumnsVisible
				ScrollH.CursorOn = False
			Else If X > ScrollH.ButtonLength And X < ScrollH.CursorBegin Then
				IndexBegin = Max(0, ScrollH.BeginIndex - NbColumnsVisible / 2)
				ScrollH.CursorOn = False
			Else If X > ScrollH.CursorBegin + ScrollH.CursorLength And X < ScrollH.BarLength - ScrollH.ButtonLength Then
				IndexBegin = Min(ScrollH.BeginIndex + NbColumnsVisible / 2, NbColumnsTotal - NbColumnsVisible)
				ScrollH.CursorOn = False
			Else
				IndexBegin = ScrollH.BeginIndex
				ScrollH.CursorOn = True
			End If
			ScrollH.Cursor0 = X
			ScrollH.CursorBegin0 = ScrollH.CursorBegin

			If IndexBegin <> ScrollH.BeginIndex Then
				ScrollH.BeginIndex = IndexBegin
				ReDrawGantt
				ScrollCursorDrawH
			End If
		Case pnlScrollBarH.TOUCH_ACTION_MOVE
			If ScrollH.CursorOn = True Then
				ScrollH.CursorBegin = Min(ScrollH.CursorBegin0 + X - ScrollH.Cursor0, ScrollH.BarLength - 2 * ScrollH.ButtonLength - ScrollH.CursorLength + 10)
				ScrollH.CursorBegin = Max(ScrollH.CursorBegin, 2 * ScrollH.ButtonLength)
				IndexBegin = (ScrollH.CursorBegin - 2 * ScrollH.ButtonLength) / (ScrollH.BarLength - 4 * ScrollH.ButtonLength - ScrollH.CursorLength) * (NbColumnsTotal - NbColumnsVisible + 1) + 0.5
				IndexBegin = Min(IndexBegin, NbColumnsTotal - NbColumnsVisible)
				If IndexBegin <> ScrollH.BeginIndex Then
					ScrollH.BeginIndex = IndexBegin
					ReDrawGantt
				End If
			End If
		Case pnlScrollBarH.TOUCH_ACTION_UP
			ScrollH.CursorOn = False
	End Select
End Sub

Private Sub pnlScrollBarV_Touch (Action As Int, X As Float, Y As Float)
	Private IndexBegin As Int
	
	If Action = 100 Or ScrollV.Active = False Then
		Return
	End If
	
	Scrolling = False
	Select Action
		Case pnlScrollBarV.TOUCH_ACTION_DOWN
			If Y > 0 And Y < ScrollV.ButtonLength Then	'button top
				IndexBegin = 0
				ScrollV.CursorOn = False
			Else If Y > ScrollV.ButtonLength And Y < 2 * ScrollV.ButtonLength Then ' button up
				IndexBegin = Max(0, ScrollV.BeginIndex - 1)
				ScrollV.CursorOn = False
			Else If Y > ScrollV.BarLength - 2 * ScrollV.ButtonLength And Y < ScrollV.BarLength - ScrollV.ButtonLength Then 'button down
				IndexBegin= Min(ScrollV.BeginIndex + 1, NbRowsTotal - NbRowsVisible)
				ScrollV.CursorOn = False
			Else If Y > ScrollV.BarLength - ScrollV.ButtonLength And Y < ScrollV.BarLength Then 'button bottom
				IndexBegin = NbRowsTotal - NbRowsVisible
				ScrollV.CursorOn = False
			Else If Y > ScrollV.ButtonLength And Y < ScrollV.CursorBegin Then
				IndexBegin = Max(0, ScrollV.BeginIndex - NbRowsVisible / 2)
				ScrollV.CursorOn = False
			Else If Y > ScrollV.CursorBegin + ScrollV.CursorLength And Y < ScrollV.BarLength - ScrollV.ButtonLength Then
				IndexBegin = Min(ScrollV.BeginIndex + NbRowsVisible / 2, NbRowsTotal - NbRowsVisible)
				ScrollV.CursorOn = False
			Else
				IndexBegin = ScrollV.BeginIndex
				ScrollV.CursorOn = True
			End If
			ScrollV.Cursor0 = Y
			ScrollV.CursorBegin0 = ScrollV.CursorBegin

			If IndexBegin <> ScrollV.BeginIndex Then
				ScrollV.BeginIndex = IndexBegin
				ScrollV.EndIndex = ScrollV.BeginIndex + NbRowsVisible - 1
				Scrolling = True
				ReDrawGantt
				ScrollCursorDrawV
				Scrolling = False
			End If
		Case pnlScrollBarV.TOUCH_ACTION_MOVE
			If ScrollV.CursorOn = True Then
				ScrollV.CursorBegin = Min(ScrollV.CursorBegin0 + Y - ScrollV.Cursor0, ScrollV.BarLength - ScrollV.ButtonLength - ScrollV.CursorLength + 10)
				ScrollV.CursorBegin = Max(ScrollV.CursorBegin, ScrollV.ButtonLength)
				IndexBegin = (ScrollV.CursorBegin - ScrollV.ButtonLength) / (ScrollV.BarLength - 2 * ScrollV.ButtonLength - ScrollV.CursorLength) * (NbRowsTotal - NbRowsVisible + 1) + 0.5
				IndexBegin = Min(IndexBegin, NbRowsTotal - NbRowsVisible)
				If IndexBegin <> ScrollV.BeginIndex Then
					ScrollV.BeginIndex = IndexBegin
					ScrollV.EndIndex = ScrollV.BeginIndex + NbRowsVisible - 1
					Scrolling = True
					ReDrawGantt
					ScrollCursorDrawV
					Scrolling = False
				End If
			End If
		Case pnlScrollBarV.TOUCH_ACTION_UP
			ScrollV.CursorOn = False
	End Select
End Sub

Private Sub pnlScaleButtons_Touch (Action As Int, X As Float, Y As Float)
	If Action = pnlScaleButtons.TOUCH_ACTION_MOVE_NOTOUCH Then
		Return
	Else If Action = pnlScaleButtons.TOUCH_ACTION_DOWN Then
		Private Index As Int
	
		Index = X / ScrollH.ButtonLength
		Select Index
			Case 0
				mTimeDisplayMode = "HOUR"
			Case 1
				mTimeDisplayMode = "DAY_LARGE"
			Case 2
				mTimeDisplayMode = "DAY_SMALL"
		End Select
		DrawScaleButtons
		DrawGantt
	End If
End Sub

Private Sub CheckJumpToBegin(Mode As String)
	Private Row As GanttLiteRowData
	Private BeginTimeTicks, EndTimeTicks As Long
	Private BeginColumnIndex As Int
	
	Row = Rows.Get(CursorRow)
	Select Row.ObjectType
		Case "Group"
			Private Group As GanttLiteGroupData
			Group = GetGroup(Row.ObjectID)
			BeginTimeTicks = Group.BeginTimeTicks
			EndTimeTicks = Group.EndTimeTicks
		Case "Task"
			Private Task As GanttLiteTaskData
			Task = GetTask(Row.ObjectID)
			BeginTimeTicks = Task.BeginTimeTicks
			EndTimeTicks = Task.EndTimeTicks
		Case Else
			Return
	End Select
	If Mode = "Begin" And EndTimeTicks < mBeginChartTicks Or Mode = "End" And BeginTimeTicks > mEndChartTicks Then
		Select mTimeDisplayMode
			Case "HOUR"
				BeginColumnIndex = (BeginTimeTicks - mBeginHourTicks) / DateTime.TicksPerHour
			Case "DAY_LARGE"
				BeginColumnIndex = (BeginTimeTicks - mBeginDayTicks) / DateTime.TicksPerDay
			Case "DAY_SMALL"
				BeginColumnIndex = (BeginTimeTicks - mBeginDayTicks) / DateTime.TicksPerDay
		End Select
		ScrollH.BeginIndex = Min(NbColumnsTotal - NbColumnsVisible, BeginColumnIndex)
		ReDrawGantt
	End If
End Sub

Private Sub CheckJumpToEnd
	Private Row As GanttLiteRowData
	Private EndTimeTicks As Long
	Private EndTimeHourIndex As Int
	
	Row = Rows.Get(CursorRow)
	Select Row.ObjectType
		Case "Group"
			Private Group As GanttLiteGroupData
			Group = GetGroup(Row.ObjectID)
			EndTimeTicks = Group.EndTimeTicks
		Case "Task"
			Private Task As GanttLiteTaskData
			Task = GetTask(Row.ObjectID)
			EndTimeTicks = Task.EndTimeTicks
		Case Else
			Return
	End Select
	EndTimeHourIndex = (EndTimeTicks- mBeginHourTicks) / DateTime.TicksPerHour
	ReDrawGantt
End Sub

'Jumps to the beginning of the chart
Public Sub JumpToBegin
	ScrollH.BeginIndex = 0
	ReDrawGantt
End Sub

'Jumps to the end of the chart
Public Sub JumpToEnd
	ScrollH.BeginIndex = NbColumnsTotal - NbColumnsVisible
	ReDrawGantt
End Sub

'Jumps to the current time, the current time is in the middle of the screen
Public Sub JumpToNow
	JumpToDate(DateTime.Now)
End Sub

'Jumps to the given date in Ticks
Public Sub JumpToDate(Ticks As Long)
	Private ColumnIndex As Int

	If Ticks >= mBeginTimeTicks And Ticks <= mEndTimeTicks Then
		Select mTimeDisplayMode
			Case "HOUR"
				ColumnIndex = (Ticks - mBeginHourTicks) / DateTime.TicksPerHour - 1
			Case "DAY_LARGE"
				ColumnIndex = (Ticks - mBeginDayTicks) / DateTime.TicksPerDay - 1
			Case "DAY_SMALL"
				ColumnIndex = (Ticks - mBeginDayTicks) / DateTime.TicksPerDay - 1
		End Select
	End If
	ScrollH.BeginIndex = Min(Max(0, ColumnIndex - NbColumnsVisible / 2 + 1), NbColumnsTotal - NbColumnsVisible)
	ReDrawGantt
End Sub

'Jumps to the given date in the current DateFormat
'default date format "yyyy-MM-dd HH:mm:ss"
Public Sub JumpToDate2(Date As String)
	JumpToDate(DateTime.DateParse(Date))
End Sub

'Returns white for a dark color or returns black for a light color for a good contrast between background and text colors
Private Sub ContrastColor(Color As Int) As Int
	Private a, r, g, b, yiq As Int	'ignore
	
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
	
	yiq = r * 0.299 + g * 0.587 + b * 0.114
	
	If yiq > 128 Then
		Return xui.Color_Black
	Else
		Return xui.Color_White
	End If
End Sub

Private Sub SelectRow(Selected As Boolean)
	If Selected = False Then
		SelectedRow = -1
		cvsCursor.ClearRect(cvsCursor.TargetRect)
		EditMode = ""
	Else
		SelectedRow = CursorRow
		rectSelectedRow.Initialize(mFirstColumsWidth, (SelectedRow + 2 - ScrollV.BeginIndex) * mRowHeight, pnlDiagram.Width, (SelectedRow + 3 - ScrollV.BeginIndex) * mRowHeight)
		cvsCursor.DrawRect(rectSelectedRow, xui.Color_ARGB(200, 255, 255, 255), True, 1dip)
		Private Row As GanttLiteRowData
		Row = Rows.Get(SelectedRow)
		SelectedTask = GetTask(Row.ObjectID)
		Private BeginTicks As Long
		Select mTimeDisplayMode
			Case "HOUR"
				BeginTicks = mBeginTimeTicks
			Case "DAY_LARGE", "DAY_SMALL"
				BeginTicks = mBeginDayTicks
		End Select
		TaskX1 = mFirstColumsWidth - ScrollH.BeginIndex * mColumnTimeWidth + (SelectedTask.BeginTimeTicks - BeginTicks) * TicksToTimeWidthScale
		TaskX2 = mFirstColumsWidth  - ScrollH.BeginIndex * mColumnTimeWidth + (SelectedTask.EndTimeTicks - BeginTicks) * TicksToTimeWidthScale
		TaskXm = (TaskX1 + TaskX2) / 2
		TaskW2 = (TaskX2 - TaskX1) / 2
		TaskY0 = (SelectedRow + 2 - ScrollV.BeginIndex) * mRowHeight
		TaskY1 = (SelectedRow + 3 - ScrollV.BeginIndex) * mRowHeight
		rectSelectedTask.Initialize(TaskX1, TaskY0, TaskX2, TaskY1)
		EditMode = "EditTask"
		cvsCursor.ClipPath(CalendarPath)
		cvsCursor.Invalidate
		DrawTaskEdit
		cvsCursor.RemoveClip
	End If
End Sub

Private Sub EditTask(Action As Int, X As Int, Y As Int)
	Select Action
		Case pnlCursor.TOUCH_ACTION_DOWN
			If Y > TaskY0 And Y < TaskY1 Then
				If Abs(X - TaskX1) < 5dip Then
					EditMode = "EditTaskX1"
				Else If Abs(X - TaskXm) < 5dip Then
					EditMode = "EditTaskXm"
				Else If Abs(X - TaskX2) < 5dip Then
					EditMode = "EditTaskX2"
				End If
				DrawTaskEdit
			End If
		Case pnlCursor.TOUCH_ACTION_MOVE
			Select EditMode
				Case "EditTaskX1"
					TaskX1 = X
				Case "EditTaskXm"
					TaskXm = X
					TaskX1 = TaskXm - TaskW2
					TaskX2 = TaskXm + TaskW2
				Case "EditTaskX2"
					TaskX2 = X
			End Select
			DrawTaskEdit
		Case pnlCursor.TOUCH_ACTION_UP
'			EditMode = "EditTask"
			TaskXm = (TaskX2 + TaskX1) / 2
			DrawTaskEdit
			Private sf As Object = xui.Msgbox2Async(Texts.Get(17), Texts.Get(16), Texts.Get(10), Texts.Get(12), Texts.Get(13), Null)
			Wait For (sf) Msgbox_Result (Result As Int)
			If Result = xui.DialogResponse_Positive Then
				Select EditMode
					Case "EditTaskX1", "EditTaskX2"
						Private BeginTimeTicks, EndTimeTicks As Long
						BeginTimeTicks = (TaskX1 - mFirstColumsWidth + ScrollH.BeginIndex * mColumnTimeWidth) / TicksToTimeWidthScale + mBeginHourTicks
						SelectedTask.BeginTimeTicks = BeginTimeTicks
						EndTimeTicks = (TaskX2 - mFirstColumsWidth + ScrollH.BeginIndex * mColumnTimeWidth) / TicksToTimeWidthScale + mBeginHourTicks
						SelectedTask.EndTimeTicks = EndTimeTicks
					Case "EditTaskXm"
						SelectedTask.BeginTimeTicks = (TaskXm - TaskW2 - mFirstColumsWidth + ScrollH.BeginIndex * mColumnTimeWidth) / TicksToTimeWidthScale + mBeginHourTicks
						SelectedTask.EndTimeTicks = (TaskXm + TaskW2 - mFirstColumsWidth + ScrollH.BeginIndex * mColumnTimeWidth) / TicksToTimeWidthScale + mBeginHourTicks
				End Select
				Private BeginIndexOld As Int
				BeginIndexOld = ScrollH.BeginIndex
				ResizeChart
				ScrollH.BeginIndex = BeginIndexOld
				ReDrawGantt
				EditMode = ""
			Else If Result = xui.DialogResponse_Negative Then ' Continue
				TaskW2 = (TaskX2 - TaskX1) / 2
				EditMode = "EditTask"
				DrawTaskEdit
			Else If Result = xui.DialogResponse_Cancel Then
				EditMode = ""
				ReDrawGantt
				SelectRow(False)
			End If
	End Select
End Sub

Private Sub DrawTaskEdit
	cvsCursor.ClearRect(cvsCursor.TargetRect)
	cvsCursor.DrawRect(rectSelectedRow, xui.Color_RGB(250, 250, 250), True, 1dip)
	Select EditMode
		Case "EditTaskX1"
			rectSelectedTask.Initialize(TaskX1, TaskY0, TaskX2, TaskY1)
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_RGB(200, 200, 200), True, 1dip)
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_Red, False, 1dip)
			cvsCursor.DrawLine(TaskX1, TaskY0, TaskX1, TaskY1, xui.Color_Green, 3dip)
		Case "EditTaskXm"
			TaskX1 = TaskXm - TaskW2
			TaskX2 = TaskXm + TaskW2
			rectSelectedTask.Initialize(TaskX1, TaskY0, TaskX2, TaskY1)
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_RGB(200, 200, 200), True, 1dip)
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_Red, False, 1dip)
			cvsCursor.DrawLine(TaskXm, TaskY0, TaskXm, TaskY1, xui.Color_Green, 3dip)
		Case "EditTaskX2"
			rectSelectedTask.Initialize(TaskX1, TaskY0, TaskX2, TaskY1)
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_RGB(200, 200, 200), True, 1dip)
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_Red, False, 1dip)
			cvsCursor.DrawLine(TaskX2, TaskY0, TaskX2, TaskY1, xui.Color_Green, 3dip)
		Case Else
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_RGB(200, 200, 200), True, 1dip)
			cvsCursor.DrawRect(rectSelectedTask, xui.Color_Red, False, 1dip)
			cvsCursor.DrawLine(TaskX1, TaskY0, TaskX1, TaskY1, xui.Color_Red, 3dip)
			cvsCursor.DrawLine(TaskXm, TaskY0, TaskXm, TaskY1, xui.Color_Red, 3dip)
			cvsCursor.DrawLine(TaskX2, TaskY0, TaskX2, TaskY1, xui.Color_Red, 3dip)
	End Select
	cvsCursor.Invalidate
End Sub

#If B4J
Private Sub cvsScrollBarV_Filter(E As Event)
	Private MouseEvent As JavaObject = E
	Private Delta As Int
	
	If NbRowsTotal <= NbRowsVisible Then
		Return
	End If
	
	Delta = MouseEvent.RunMethod("getDeltaY",Null)
	If Delta > 0 Then
		If ScrollV.BeginIndex > 0 Then
			ScrollV.BeginIndex = ScrollV.BeginIndex - 1
		End If
	Else If Delta < 0 Then
		If ScrollV.EndIndex < Rows.Size - 1 Then
			ScrollV.BeginIndex = ScrollV.BeginIndex + 1
		End If
	End If
	ReDrawGantt
	ScrollCursorDrawV
End Sub

Private Sub cvsCursor_Filter(E As Event)
	Private MouseEvent As JavaObject = E
	Private Delta As Int
	
	If NbRowsTotal <= NbRowsVisible Then
		Return
	End If
	
	Delta = MouseEvent.RunMethod("getDeltaY",Null)
	If Delta > 0 Then
		If ScrollV.BeginIndex > 0 Then
			ScrollV.BeginIndex = ScrollV.BeginIndex - 1
		End If
	Else If Delta < 0 Then
		If ScrollV.EndIndex < Rows.Size - 1 Then
			ScrollV.BeginIndex = ScrollV.BeginIndex + 1
		End If
	End If
	ReDrawGantt
	ScrollCursorDrawV
End Sub

Private Sub cvsScrollBarH_Filter(E As Event)
	Private MouseEvent As JavaObject = E
	Private Delta As Int
	
	If NbRowsTotal <= NbRowsVisible Then
		Return
	End If
	
	Delta = MouseEvent.RunMethod("getDeltaY",Null)
	If Delta > 0 Then
		If ScrollH.BeginIndex > 0 Then
			ScrollH.BeginIndex = ScrollH.BeginIndex - 1
		End If
	Else If Delta < 0 Then
		If ScrollH.EndIndex < NbColumnsTotal - 1 Then
			ScrollH.BeginIndex = ScrollH.BeginIndex + 1
		End If
	End If
	ReDrawGantt
End Sub
#End If

'Sets or gets the BeginDate property
'Begin day of the chart
'Default value "" empty string
'This means that the begin date is the first day of all tasks.
Public Sub setBeginDate(BeginDate As String)
	If BeginDate = "" Then
		AutomaticBeginEndDates = True
	Else
		AutomaticBeginEndDates = False
		mBeginDate = BeginDate
		mBeginHourTicks = GetDateTicks(mBeginDate)
		mBeginTimeTicks = GetDateTicks(mBeginDate)
	End If
End Sub

''Sets or gets the BeginHour property
''Begin hour of the chart
''Default value -1
''This means that the begin hour is the first hour of all tasks.
'Public Sub setBeginHour(BeginHour As Int)
'	AutomaticBeginEndDates = False
'	mBeginHour = Min( 23, Max(0, BeginHour))
'	mBeginHourTicks = GetDateTicks(mBeginDate) + (mBeginHour - 1) * DateTime.TicksPerHour
'	If pnlCalendar.IsInitialized = True Then
'		InitSizes
'	End If
'End Sub
'
'Public Sub getBeginHour As Int
'	Return mBeginHour	
'End Sub

'Sets or gets the EndDate property
'End day of the chart
'Default value "" empty string
'This means that the end date is the last day of all tasks.
Public Sub setEndDate(EndDate As String)
	If EndDate = "" Then
		AutomaticBeginEndDates = True
	Else
		AutomaticBeginEndDates = False
		mEndDate = EndDate
		mEndTimeTicks = GetDateTicks(mEndDate) + 23 * DateTime.TicksPerHour + 59.99 * DateTime.TicksPerMinute
	End If
End Sub

'Public Sub getEndHour As Int
'	Return mEndHour	
'End Sub
'
''Sets or gets the EndHour property
''End hour of the chart
''Default value -1
''This means that the end hour is the last hour of all tasks.
'Public Sub setEndHour(EndHour As Int)
'	AutomaticBeginEndDates = False
'	mEndHour = Min( 23, Max(0, EndHour))
'	mEndHourTicks = GetDateTicks(mEndDate) + (mEndHour + 1) * DateTime.TicksPerHour
'	If pnlCalendar.IsInitialized = True Then
'		InitSizes
'	End If
'End Sub

'Returns Ticks for a date with the yyyy-MM-dd format
Public Sub GetDateTicks(Date As String) As Long
	Return DateTime.DateParse(Date & " 00:00:00")
End Sub

'Returns the date string for the given date ticks with the given DateFormat
Public Sub GetDate(Ticks As Long, DateFormat As String) As String
	Private Date, OldFormat As String
	OldFormat = DateTime.DateFormat
	DateTime.DateFormat = DateFormat
	Date = DateTime.Date(Ticks)
	DateTime.DateFormat = OldFormat
	Return Date
End Sub

'Returns the year and month for the given Ticks
'Exemple "2024  February"
Private Sub GetMonth(Ticks As Long) As String
	Return DateTime.GetYear(Ticks) & "  " & MonthNames(DateTime.GetMonth(Ticks) - 1)
End Sub

'Sets or gets the TextSize property
'The row height depends on the text size, it is automatically adjusted
Public Sub setTextSize(TextSize As Float)
	mTextSize = TextSize
	mTextFont = xui.CreateDefaultFont(mTextSize)
	mTextFontBold = xui.CreateDefaultBoldFont(mTextSize)
	If Rows.Size > 0 Then
		InitSizes
		DrawGantt
	End If
End Sub

Public Sub getTextSize As Float
	Return mTextSize
End Sub

'Sets or gets the TextColor property
'It must be an xui color
'Example: xGanttLite1.TextColor = xui.Color_Blue
Public Sub setTextColor(TextColor As Int)
	mTextColor = TextColor
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getTextColor As Int
	Return mTextColor
End Sub

'Sets or gets the BackgroundColor property
'It must be a xui color
'Example: xGanttLite1.BackgroundColor = xui.Color_White
Public Sub setBackgroundColor(BackgroundColor As Int)
	mBackgroundColor = BackgroundColor
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

'Sets or gets the GridFrameColor property
'It must be a xui color
'Example: xGanttLite1.GridFrameColor = xui.Color_Black
Public Sub setGridFrameColor(GridFrameColor As Int)
	mGridFrameColor = GridFrameColor
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getGridFrameColor As Int
	Return mGridFrameColor
End Sub

'Sets or gets the GridColor property
'It must be a xui color
'Example: xGanttLite1.GridColor = xui.Color_Gray
Public Sub setGridColor(GridColor As Int)
	mGridColor = GridColor
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getGridColor As Int
	Return mGridColor
End Sub

'Sets or gets the DateFormat property
'Default value = "yyyyMMdd"
Public Sub setDateFormat(DateFormat As String)
	mDateFormat = DateFormat
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getDateFormat As String
	Return mDateFormat
End Sub

'Sets or gets the DisplayRowIndexColumn property
'When True, the RowIndex column is displayed
Public Sub setDisplayRowIndexColumn(DisplayRowIndexColumn As Boolean)
	mDisplayRowIndexColumn = DisplayRowIndexColumn
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getDisplayRowIndexColumn As Boolean
	Return mDisplayRowIndexColumn
End Sub

'Sets or gets the DisplayResponsibleColumn property
'When True, the Responsible column is displayed
Public Sub setDisplayResponsibleColumn(DisplayResponsibleColumn As Boolean)
	mDisplayResponsibleColumn = DisplayResponsibleColumn
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getDisplayResponsibleColumn As Boolean
	Return mDisplayResponsibleColumn
End Sub

'Sets or gets the DisplayRowData property
'When True, the row data is displayed in the upper left corner when the user presses and moves the mouse on a row
Public Sub setDisplayRowData(DisplayRowData As Boolean)
	mDisplayRowData = DisplayRowData
	If Rows.Size > 0 Then
		DrawGantt
	End If
End Sub

Public Sub getDisplayRowData As Boolean
	Return mDisplayRowData
End Sub

'Sets or gets the TimeDisplayMode property
'Possible values:
'"HOUR" = displays 24 hours a day
'"DAY_LARGE" = diplays days with a large column
'"DAY_SMALL" = diplays days with a samll column
Public Sub setTimeDisplayMode(TimeDisplayMode As String)
	Select TimeDisplayMode
		Case "HOUR", "DAY_LARGE", "DAY_SMALL"
			mTimeDisplayMode = TimeDisplayMode
			If Rows.Size > 0 Then
				DrawGantt
			End If
		Case Else 
			Log("Wrong value: only HOUR, DAY_LARGE, DAY_SMALL are accepted")
	End Select
End Sub

Public Sub getTimeDisplayMode As String
	Return mTimeDisplayMode
End Sub

'Returns a B4XBitmap object of the chart (read only).
Public Sub getSnapshot As B4XBitmap
	Return pnlDiagram.Snapshot
End Sub

'Sets or gets the language code.
'en English
'fr Français
'de Deutsch
Public Sub setLanguageCode(LanguageCode As String)
'	If File.Exists(File.DirAssets, "Texts_" & LanguageCode & ".txt") Then
	mLanguageCode = LanguageCode
	LoadTexts
'	End If
End Sub

Public Sub getLanguageCode As String
	Return mLanguageCode
End Sub

Private Sub LoadTexts
	Texts.Clear
	Texts = File.ReadList(File.DirAssets, "texts_" & mLanguageCode & ".txt")
	
'	btnEditAdd.Text = Texts(18)
'	btnEditDelete.Text = Texts(14)
'	btnEditUpdate.Text = Texts(20)
'	btnEditInsert.Text = Texts(19)
'	lblRowNumber0.Text = Texts(21) & " :"
'	lblName.Text = Texts(5) & " :"
'	lblColor.Text = Texts(24) & " :"
'	lblComment.Text = Texts(6) & " :"
'	lblActivityType.Text = Texts(22) & " :"
'	lblActivityID.Text = Texts(23) & " :"
'	lblGroupID.Text = Texts(2) & " " & Texts(1) & " :"
'	lblResponsible.Text = Texts(9) & " :"
'	lblBeginTime.Text = Texts(7) & " :"
'	lblEndTime.Text = Texts(8) & " :"
End Sub