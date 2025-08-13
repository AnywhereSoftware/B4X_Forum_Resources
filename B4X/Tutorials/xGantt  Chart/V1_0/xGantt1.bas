B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
'xGantt Custom View class
'
'Version 0.4
'Author: Klaus CHRISTL (klaus)
#Event: TaskLongClick(Task As GanttTaskData)
#Event: CalendarLongClick(Task As GanttTaskData)
#Event: DayLongClick(Task As GanttTaskData)
'#Event: CursorTouch (Action As Int, CursorIndex As Int)
#RaisesSynchronousEvents: TaskLongClick(Task As GanttTaskData)
#RaisesSynchronousEvents: CalendarLongClick(Day As Long, Task As GanttTaskData)
#RaisesSynchronousEvents: DayLongClick(Day As Long)
'#RaisesSynchronousEvents: CursorTouch (Action As Int, CursorIndex As Int)

#DesignerProperty: Key: DisplayType, DisplayName: DisplayType, FieldType: String, DefaultValue: GANTT, List: GANTT|TABLE, Description: Chart type either GANTT or TABLE.
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: Gantt chart
#DesignerProperty: Key: SubTitle, DisplayName: SubTitle, FieldType: String, DefaultValue: 
#DesignerProperty: Key: AutomaticTextSizes, DisplayName: AutomaticTextSizes, FieldType: Boolean, DefaultValue: True, Description: Automatic text sizes. They are automatically calculated according to the chart size.
#DesignerProperty: Key: DisplayTaskTable, DisplayName: DisplayTaskTable, FieldType: Boolean, DefaultValue: True, Description: Displays the table of the task on the left side of the Gantt chart.
#DesignerProperty: Key: IgnoreCompleted, DisplayName: IgnoreCompleted, FieldType: Boolean, DefaultValue: False, Description: True: ignores the completed parameter. False: Displays differently the not completed part of a task in the Gantt chart.
#DesignerProperty: Key: CalendarDisplayMode, DisplayName: CalendarDisplayMode, FieldType: String, List: DAY_OF_WEEK|DAY_OF_MONTH, DefaultValue: DAY_OF_WEEK, Description: Automatic text sizes. Displays the days eiter S M T W T F S or 1 2 3 4.
#DesignerProperty: Key: TitleTextSize, DisplayName: TitleTextSize, FieldType: Int, DefaultValue: 20, Description: Title text size
#DesignerProperty: Key: TitleTextColor, DisplayName: TitleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Title text color
#DesignerProperty: Key: SubTitleTextSize, DisplayName: SubTitleTextSize, FieldType: Int, DefaultValue: 16, Description: SubTitle text size
#DesignerProperty: Key: SubTitleTextColor, DisplayName: SubTitleTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: SubTitle text color
#DesignerProperty: Key: CalendarTextSize, DisplayName: CalendarTextSize, FieldType: Int, DefaultValue: 12, Description: SubTitle text size
#DesignerProperty: Key: CalendarTextColor, DisplayName: CalendarTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: SubTitle text color
#DesignerProperty: Key: ValuesTextSize, DisplayName: ValuesTextSize, FieldType: Int, DefaultValue: 12, Description: Values text size
#DesignerProperty: Key: ValuesTextColor, DisplayName: ValuesTiteTextColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Values test title color.
#DesignerProperty: Key: ValuesDisplayPosition, DisplayName: ValuesDisplayPosition, FieldType: String, DefaultValue: "CURSOR", List: CURSOR|TOP, Description: Position of the values display.
#DesignerProperty: Key: ChartBackgroundColor, DisplayName: ChartBackgroundColor, FieldType: Color, DefaultValue: 0xFFF5F5DC, Description: Chart background color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridColor, DisplayName: GridColor, FieldType: Color, DefaultValue: 0xFFA9A9A9, Description: Grid color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: GridFrameColor, DisplayName: GridFrameColor, FieldType: Color, DefaultValue: 0xFF000000, Description: Grid frame color. You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SundayColor, DisplayName: SundayColor, FieldType: Color, DefaultValue: 0xFFD3D3D3, Description: Saturday and sunday color in the calendar.

Sub Class_Globals
	Type GanttChartData (DisplayType As String, Title As String, SubTitle As String, BeginTicks As Long, EndTicks As Long, Left As Int, Right As Int, Top As Int, Bottom As Int, Width As Int, Height As Int, ChartIsInitialized As Boolean, Duration As Int, XInterval As Int, XNbIntervals As Int, YInterval As Int, YNbIntervals As Int, TableRect As B4XRect, GraphRect As B4XRect, GraphPath As B4XPath, IgnoreCompleted As Boolean, CalendarDisplayMode As String, CalendarRect As B4XRect, CalendarPath As B4XPath, CalendarMonthsRect As B4XRect, CalendarDaysRect As B4XRect, XOffset As Int, ChartBackgroundColor As Int, GridFrameColor As Int, GridColor As Int, GridColorDark As Int, SundayColor As Int, GradientColors As Boolean, GradientColorsAlpha As Int, Rotation As Double, DrawOuterFrame As Boolean, DrawGridFrame As Boolean, DrawHorizontalGridLines As Boolean, DrawVerticalGridLines As Boolean, EditOldDisplay As String)
	Type GanttTaskData (ID As String, Name As String, Responsible As String, BeginDate As String, Duration As Int, Dependency As String, Completion As Int, PredecessorID As String, SuccessorIDs As List, LagLead As Int, EndDate As String, BeginTicks As Long, EndTicks As Long, BeginDayIndex As Int, EndDayIndex As Int, Color As Int)
	Type GanttTaskTableData (Display As Boolean, Left As Int, Width As Int, Right As Int)
	Type GanttZoomBarData(Active As Boolean, BeginIndex As Int, EndIndex As Int, NbVisibleItems As Int, BarLength As Int, BarWidth As Int, ButtonLength As Int, CornerRadius As Int, CursorBegin As Int, CursorBegin0 As Int, CursorLength As Int, Cursor0 As Int, CursorOn As Boolean, ColorBar As Int, ColorButton As Int, ColorButtonFrame As Int, ScalesOnZoomedPart As Boolean)
	Type GanttTextData (TitleFont As B4XFont, SubtitleFont As B4XFont, CalendarFont As B4XFont, TaskDataFont As B4XFont, AutomaticTextSizes As Boolean, TitleTextSize As Float, SubtitleTextSize As Float, CalendarTextSize As Float, TaskDataTextSize As Float, TitleTextColor As Int, SubtitleTextColor As Int, CalendarTextColor As Int, TextDataTextColor As Int, TitleTextHeight As Int, SubtitleTextHeight As Int, CalendarTextHeight As Int, TaskTextHeight As Int, TitleTextWidth As Int, SubtitleTextWidth As Int)
	Type GanttValuesData (DataFont As B4XFont, TextSize As Float, TextColor As Int, TextHeight As Int, Position As String)

	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Private mTag As Object
	
	Private xpnlChart, xpnlCursor, xpnlZoomBarH, xpnlZoomBarV, xpnlValues As B4XView
	Private xcvsChart, xcvsCursor, xcvsZoomBarH, xcvsZoomBarV, xcvsValues As B4XCanvas
	Private xpnlEdit As B4XView
	
	Private ZoomH(2), ZoomV As GanttZoomBarData
	Private Zooming As Boolean
	
	Public Tasks, TaskIDs As List
'	Private lstDependencies, lstDependenciesShort As List
	
	Private Gantt As GanttChartData
	Private Texts As GanttTextData
	Private Values As GanttValuesData
	Private FixedTaskTable As GanttTaskTableData
	
	Private TaskToEdit As GanttTaskData
	
	Private Days(), MonthNamesShort(), MonthNamesLong() As String
	Private CurrentDay1, CurrentDay2 As String
	Private mAlphaCursorH, mAlphaCursorV, mAlphaValues As Int
	Private CurrentTaskIndex, CurrentDayIndex As Int
	Private CursorX0, CursorY0, CursorClickLimit As Int
	
	Private mLeft, mTop, mWidth, mHeight As Int
	
	Private TimerTaskLongClick As Timer
	
	Private TableColumnWidth() As Int
	Private TableColumnLeft() As Int
	Private ChartIndex As Int	'used for horizontal scrolling 0 = Gantt chart 1 = Table chart

	Private ButtonCurrentIndex As Int
	Private ButtonWidth As Int
	Private ButtonTextSize As Float
	Private ButtonTextY As Int
	Private ButtonFont As B4XFont
	Private ButtonTextColor, ButtonTextSetColor As Int
	Private ButtonBackgroundColor, ButtonBackgroundSetColor As Int
	Private ButtonBorderColor, ButtonBorderSetColor As Int
	Private ButtonText(3) As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	mAlphaCursorH = 48
	mAlphaCursorV = 48
	mAlphaValues = 168
	
	Gantt.Initialize
	Tasks.Initialize
	TaskIDs.Initialize
	TaskIDs.Add("None")
'	lstDependencies.Initialize
'	lstDependenciesShort.Initialize
	Texts.Initialize
	Values.Initialize
	
	CursorClickLimit = 5dip
	
	TimerTaskLongClick.Initialize("TimerTaskLongClick", 1000)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mTag = mBase.Tag
	mBase.Tag = Me
	
	mLeft = mBase.Left
	mTop = mBase.Top
	mWidth = mBase.Width
	mHeight = mBase.Height
	
	mBase.SetColorAndBorder(mBase.Color, 0, mBase.Color, 0)
	
	Gantt.DisplayType = Props.GetDefault("DisplayType", "GANTT")
	Gantt.Title = Props.Get("Title")
	Gantt.SubTitle = Props.Get("SubTitle")
	Texts.AutomaticTextSizes = Props.GetDefault("AutomaticTextSizes", True)
	Gantt.CalendarDisplayMode = Props.GetDefault("CalendarDisplayMode", "DAY_OF_WEEK")
	FixedTaskTable.Display = Props.GetDefault("DisplayTaskTable", True)
	Gantt.IgnoreCompleted = Props.GetDefault("IgnoreCompleted", False)
	Gantt.ChartBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("ChartBackgroundColor", 0xFFF5F5DC))
	If Gantt.ChartBackgroundColor = 16777215 Then
		Gantt.ChartBackgroundColor = xui.Color_Transparent
	End If
	
	Texts.TitleTextSize = Props.GetDefault("TitleTextSize", 20)
	Texts.TitleTextColor = xui.PaintOrColorToColor(Props.GetDefault("TitleTextColor", 0xFF000000))
	Texts.SubTitleTextSize = Props.GetDefault("SubTitleTextSize", 18)
	Texts.SubTitleTextColor = xui.PaintOrColorToColor(Props.GetDefault("SubTitleTextColor", 0xFF000000))
	Texts.CalendarTextSize = Props.GetDefault("CalendarTextSize", 12)
	Texts.CalendarTextColor = xui.PaintOrColorToColor(Props.GetDefault("CalendarTextColor", 0xFF000000))
	Values.TextSize = Props.GetDefault("ValuesTextSize", 12)
	Values.TextColor = xui.PaintOrColorToColor(Props.GetDefault("ValuesTextColor", 0xFF000000))
	Values.Position = Props.GetDefault("ValuesDisplayPosition", "CURSOR")
	Gantt.GridFrameColor = xui.PaintOrColorToColor(Props.Get("GridFrameColor"))
	Gantt.DrawGridFrame = Props.GetDefault("DrawGridFrame", True)
	Gantt.GridColor = xui.PaintOrColorToColor(Props.Get("GridColor"))
'	Gantt.GridColorDark = CalcDarkColor(Graph.GridColor)
	Gantt.SundayColor = xui.PaintOrColorToColor(Props.GetDefault("SundayColor",0xFFD3D3D3))
	
	xpnlChart = xui.CreatePanel("")
	mBase.AddView(xpnlChart, 0, 0, 100dip, mBase.Height)
	xcvsChart.Initialize(xpnlChart)
	
	xpnlCursor = xui.CreatePanel("xpnlCursor")
	mBase.AddView(xpnlCursor, 0, 0, 100dip, mBase.Height)
	xcvsCursor.Initialize(xpnlCursor)
	
	xpnlZoomBarH = xui.CreatePanel("xpnlZoomBarH")
	mBase.AddView(xpnlZoomBarH, 0, 0, 100dip, mBase.Height)
	xcvsZoomBarH.Initialize(xpnlZoomBarH)

	xpnlZoomBarV = xui.CreatePanel("xpnlZoomBarV")
	mBase.AddView(xpnlZoomBarV, 0, 0, 100dip, mBase.Height)
	xcvsZoomBarV.Initialize(xpnlZoomBarV)

	xpnlValues = xui.CreatePanel("")
	mBase.AddView(xpnlValues, 0, 0, 100dip, mBase.Height)
	xcvsValues.Initialize(xpnlValues)
	xpnlValues.Visible = False
	
	xpnlEdit = xui.CreatePanel("")
	mBase.AddView(xpnlEdit, 0, 0, mBase.Width, mBase.Height)

	ToolboxInit
	
#If B4A
	ZoomBarsInit
	Sleep(0)
	Base_Resize (mBase.Width, mBase.Height)
#Else If B4J
	ZoomBarsInit
#Else
	Sleep(0)
	ZoomBarsInit
#End If
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	mWidth = Width
	mHeight = Height
	
	xpnlChart.Width = Width
	xpnlChart.Height = Height
	xpnlCursor.Width = Width
	xpnlCursor.Height = Height - ZoomH(0).BarWidth
	xcvsCursor.Resize(Width, Height)
	
'	xpnlZoomBarV.Left = Width - ZoomV.BarWidth
	xcvsChart.ClearRect(xcvsChart.TargetRect)
	xcvsChart.Resize(Width, Height)
	xcvsChart.ClearRect(xcvsChart.TargetRect)
	
	If Gantt.XNbIntervals > 0 Then
		ZoomV.Active = False
		
		InitChart
		
		xpnlZoomBarH.Width = Width - ZoomH(0).BarWidth
		xpnlZoomBarH.Top = Height - ZoomH(0).BarWidth
		ZoomH(0).BarLength = Gantt.Width
		xcvsZoomBarH.Resize(Gantt.Width, ZoomH(0).BarWidth)

		xpnlZoomBarV.Left = Width - ZoomV.BarWidth
		xpnlZoomBarV.Top = Gantt.Top
		xpnlZoomBarV.Height = Height - ZoomV.BarWidth
		ZoomV.BarLength = Height - ZoomV.BarWidth
'		xcvsZoomBarV.Resize(Width, Height - ZoomV.BarWidth)
		xcvsZoomBarV.Resize(ZoomV.BarWidth, Gantt.Height)
		
		ZoomBarResizeH
		ZoomBarResizeV
		DrawChart
	End If
End Sub

'Adds a task.
'ID = identification of the task.
'Nmae = description of the task.
'Responsible = person un charge of the task
'BeginDate = date of the start of the task
'Duration = duration of the task in in days
'Dependency = depedency of the task with its predecessor
'possible values None = no dependency
'FS =  Finish To Start  The predecessor ends before the successor can begin.
'SS =  Start To Start   The predecessor begins before the successor can begin.
'FF =  Finish To Finish The predecessor ends before the successor can End.
'SF =  Start To Finish  The predecessor begins before the successor can End.
'Color = color of the bar in the chart
Public Sub AddTask(ID As String, Name As String, Responsible As String, BeginDate As String, Duration As Int, Dependency As String, PredecessorID As String, LagLead As Int, Color As Int) As Boolean
	Private TaskData As GanttTaskData
	
	If ID = "" Then
		xui.MsgboxAsync("There is no ID !", " Add tasks error")
		Return True
	Else If TaskAlreadyExists(ID) = True Then
		xui.MsgboxAsync("The task with this ID '" & ID & "' does already exist !", " Add tasks error")
		Return True
	Else
		TaskData.Initialize
		TaskData.ID = ID
		TaskIDs.Add(ID)	'adds the current task ID to the TaskID list
		TaskData.Name = Name
		TaskData.Responsible = Responsible
		TaskData.BeginDate = BeginDate
		TaskData.Duration = Duration
		TaskData.Dependency = Dependency
		TaskData.PredecessorID = PredecessorID
		TaskData.LagLead = LagLead
		TaskData.SuccessorIDs.Initialize
		TaskData.Color = Color
		Tasks.Add(TaskData)
	
		TaskCalculateParameters(TaskData)
		TaskAddAsSuccessor(TaskData)
		Return False
	End If
End Sub

'Inserts a task at the given index.
'Index = index where the tasks is inserted, all tasks above the index are moved upward.
'ID = identification of the task.
'Name = description of the task.
'Responsible = person un charge of the task
'BeginDate = date of the start of the task
'Duration = duration of the task in in days
'Dependency = depedency of the task with its predecessor
'possible values None = no dependency
'FS =  Finish To Start  The predecessor ends before the successor can begin.
'SS =  Start To Start   The predecessor begins before the successor can begin.
'FF =  Finish To Finish The predecessor ends before the successor can End.
'SF =  Start To Finish  The predecessor begins before the successor can End.
'Color = color of the bar in the chart
'Private Sub UpdateTask(Index As Int, ID As String, Name As String, Responsible As String, BeginDate As String, Duration As Int, Dependency As String, PredecessorID As String, LagLead As Int, Completion As Int, Color As Int)
Public Sub UpdateTask(Index As Int, TaskToUpdate As GanttTaskData)' As String, Name As String, Responsible As String, BeginDate As String, Duration As Int, Dependency As String, PredecessorID As String, LagLead As Int, Completion As Int, Color As Int)
'	Private TaskToEdit As GanttTaskData
'	TaskToEdit.ID = ID
'	TaskToEdit.Name = Name
'	TaskToEdit.Responsible =Responsible
'	TaskToEdit.BeginDate = BeginDate
'	TaskToEdit.Duration = Duration
'	TaskToEdit.Duration = Abs(TaskToEdit.Duration)
'	TaskToEdit.Completion = Completion
'	TaskToEdit.Completion = Max(TaskToEdit.Completion, 0)
'	TaskToEdit.Completion = Min(TaskToEdit.Completion, 100)
'	TaskToEdit.Color = xcpkTaskColor.Color
'	TaskToEdit.Dependency = lstDependenciesShort.Get(xcbxTaskDependency.SelectedIndex)
'	TaskToEdit.PredecessorID = xcbxTaskPredecessorID.SelectedItem
'	TaskToEdit.LagLead = LagLead
	
	Tasks.Set(Index, TaskToUpdate)
	TaskCalculateParameters(TaskToUpdate)
	TaskUpdateDependencies(TaskToUpdate)
End Sub

'Inserts a task at the given index.
'Index = index where the tasks is inserted, all tasks above the index are moved upward.
'ID = identification of the task.
'Name = description of the task.
'Responsible = person un charge of the task
'BeginDate = date of the start of the task
'Duration = duration of the task in in days
'Dependency = depedency of the task with its predecessor
'possible values None = no dependency
'FS =  Finish To Start  The predecessor ends before the successor can begin.
'SS =  Start To Start   The predecessor begins before the successor can begin.
'FF =  Finish To Finish The predecessor ends before the successor can End.
'SF =  Start To Finish  The predecessor begins before the successor can End.
'Color = color of the bar in the chart
Public Sub TaskInsertAt(Index As Int, ID As String, Name As String, Responsible As String, BeginDate As String, Duration As Int, Dependency As String, PredecessorID As String, LagLead As Int, Color As Int) As Boolean
	Private TD, TaskData As GanttTaskData
	Private i As Int
	
	If ID = "" Then
		xui.MsgboxAsync("There is no ID !", " Add tasks error")
		Return True
	Else If TaskAlreadyExists(ID) = True Then
		xui.MsgboxAsync("The task with this ID '" & ID & "' does already exist !", " Add tasks error")
		Return True
	Else
		TD = Tasks.Get(CurrentTaskIndex)
		TaskData.Initialize
		TaskData.ID = ID
		TaskData.Name = Name
		TaskData.Responsible = Responsible
		TaskData.BeginDate = BeginDate
		TaskData.BeginTicks = DateTime.DateParse(BeginDate)
		TaskData.Duration = Duration
		TaskData.Dependency = Dependency
		TaskData.PredecessorID = PredecessorID
		If TaskData.Dependency <> "None" Then
			TaskData.LagLead = LagLead
		End If
		TaskData.SuccessorIDs.Initialize
		TaskData.Color = Color
		If TD.PredecessorID = "None" Then
'		TD.PredecessorID = TaskData.ID
		End If
		CalcEndDate(TaskData)
		Tasks.InsertAt(Index, TaskData)
		TaskIDs.InsertAt(Index + 1, ID)
	
		TaskCalculateParameters(TaskData)
		TaskPermuteSuccessor(TaskData)
	
		For i = 0 To TaskData.SuccessorIDs.Size - 1
			Private TD As GanttTaskData
			TD = Tasks.Get(TaskIDs.IndexOf(TaskData.SuccessorIDs.Get(i)) - 1)
			TaskUpdateDependencies(TD)
		Next
		Return False
	End If
End Sub





'Calculates the other parameters depending on the task dependenies
Private Sub TaskCalculateParameters(TDC As GanttTaskData)
	Select TDC.Dependency
		Case "FS"
			TDC.BeginDate = CalcBeginDate(TDC)
		Case "FF"
			GetEndAndBeginDate(TDC)
		Case "SS"
			GetBeginAndEndDate(TDC)
		Case "SF"
			GetEndAndBeginDate(TDC)
	End Select

	TDC.BeginTicks = DateTime.DateParse(TDC.BeginDate)
	CalcEndDate(TDC)
	Tasks.Set(TaskIDs.IndexOf(TDC.ID) - 1, TDC)
End Sub

Private Sub TaskAlreadyExists(ID As String) As Boolean
	Private i As Int
	
	For i = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(i)
		If TD.ID = ID Then
			Return True
		End If
	Next
	Return False
End Sub

'Adds this task as a successor to the predecessor task
Private Sub TaskAddAsSuccessor(TDC As GanttTaskData)
	If TDC.PredecessorID <> "None" Then
		Private PreTask As GanttTaskData
		Private PreTaskIndex As Int
		PreTaskIndex = TaskIDs.IndexOf(TDC.PredecessorID) - 1
		PreTask = Tasks.Get(PreTaskIndex)
		PreTask.SuccessorIDs.Add(TDC.ID)
		Tasks.Set(PreTaskIndex, PreTask)
	End If
End Sub

'Adds this task as a successor to the predecessor task
Private Sub TaskPermuteSuccessor(TDC As GanttTaskData)
	Private Index As Int
	
	If TDC.PredecessorID <> "None" Then
		Private PreTask, SuccTask As GanttTaskData
		Private PreTaskIndex, SuccTaskIndex As Int
		PreTaskIndex = TaskIDs.IndexOf(TDC.PredecessorID) - 1
		PreTask = Tasks.Get(PreTaskIndex)
		PreTask.SuccessorIDs.Add(TDC.ID)
		SuccTaskIndex = TaskIDs.IndexOf(TDC.ID)
		SuccTask = Tasks.Get(SuccTaskIndex)
		Index = PreTask.SuccessorIDs.IndexOf(SuccTask.ID)
		If Index > -1 Then
			PreTask.SuccessorIDs.RemoveAt(Index)
			Tasks.Set(PreTaskIndex, PreTask)
			SuccTask.PredecessorID = TDC.ID
			TDC.SuccessorIDs.Add(SuccTask.ID)
			Tasks.Set(SuccTaskIndex, SuccTask)
		End If
	End If
End Sub

'Updates the Gantt dependecies.
Private Sub TaskUpdateDependencies(TDC As GanttTaskData)
	Private i As Int
	
	Log(TDC.ID)
	TaskCalculateParameters(TDC)
	
	For i = 0 To TDC.SuccessorIDs.Size - 1
		Private TD As GanttTaskData
		Private Index As Int
		Index = TaskIDs.IndexOf(TDC.SuccessorIDs.Get(i)) - 1
		TD = Tasks.Get(Index)
		TaskUpdateDependencies(TD)
	Next
End Sub

'Initializes the xGantt chart parameters
Private Sub InitChart
	Gantt.ChartIsInitialized = True
	
	InitTextSizes
	
	Select Gantt.DisplayType
		Case "GANTT"
			InitGantt
		Case "TABLE"
			InitTable
	End Select
End Sub

'initializes the GANTT chart parameters
Private Sub InitGantt
	ChartIndex = 0
	
	SetBeginEndTicks
	
	Gantt.Top = 0.05 * mBase.Height
	If Gantt.Title <> "" Then
		Gantt.Top = Gantt.Top + 1.0 * Texts.TitleTextHeight
	End If

	If Gantt.SubTitle <> "" Then
		Gantt.Top = Gantt.Top + 1.0 * Texts.SubTitleTextHeight
	End If

	InitTextSizes
	
	Gantt.YInterval = 1.8 * Texts.CalendarTextHeight
	Gantt.YNbIntervals = Min(Tasks.Size, (0.95 * mBase.Height - Gantt.Top - ZoomH(ChartIndex).BarWidth) / Gantt.YInterval - 1)
	Gantt.Height = Gantt.YInterval * (Gantt.YNbIntervals + 2)
	Gantt.Bottom = Gantt.Top + Gantt.Height
	
	If ZoomV.Active = False Then
		If Zooming = False Then
			If Gantt.YNbIntervals >= Tasks.Size Then
				ZoomV.Active = False
				ZoomV.BeginIndex = 0
				ZoomV.EndIndex = Tasks.Size - 1
				ZoomV.CursorLength = (xpnlZoomBarV.Height - 2 * ZoomV.ButtonLength) / Tasks.Size * Gantt.YNbIntervals
			Else
				ZoomV.Active = True
				ZoomV.BeginIndex = 0
				ZoomV.EndIndex = ZoomV.BeginIndex + Gantt.YNbIntervals - 1
			End If
		End If
	End If
	
	GetColumnWidths
	
	If FixedTaskTable.Display = False Then
		Gantt.Left = 0.025 * mBase.Width
		Gantt.Width = 0.95 * mBase.Width
	Else
		FixedTaskTable.Left = 0.025 * mBase.Width
		FixedTaskTable.Right = FixedTaskTable.Left + FixedTaskTable.Width
		Gantt.Left = FixedTaskTable.Right
		Gantt.Width = 0.975 * mBase.Width - Gantt.Left
	End If
	
	If Gantt.CalendarDisplayMode = "DAY_OF_WEEK" Then
		Gantt.XInterval = MeasureTextWidth("W", Texts.CalendarFont) * 1.5
	Else
		Gantt.XInterval = MeasureTextWidth("30", Texts.CalendarFont) * 1.8
	End If
	
	Gantt.XNbIntervals = Min(Gantt.Width / Gantt.XInterval, Gantt.Duration)
	Gantt.Width = Gantt.XInterval * Gantt.XNbIntervals
	Gantt.Right = Gantt.Left + Gantt.Width
	
	If ZoomH(ChartIndex).Active = False Then
		If Gantt.XNbIntervals >= Gantt.Duration Then
			ZoomH(ChartIndex).Active = False
			ZoomH(ChartIndex).BeginIndex = 0
			ZoomH(ChartIndex).EndIndex = Gantt.Duration - 1
		Else
			ZoomH(ChartIndex).Active = True
			ZoomH(ChartIndex).BeginIndex = 0
			ZoomH(ChartIndex).EndIndex = ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1
			ZoomH(ChartIndex).CursorLength = (xpnlZoomBarH.Width - 2 * ZoomH(ChartIndex).ButtonLength) / Gantt.Duration * Gantt.XNbIntervals
		End If
	Else
		If ZoomH(ChartIndex).EndIndex - ZoomH(ChartIndex).BeginIndex + 1 <> Gantt.Duration Then
			ZoomH(ChartIndex).EndIndex = Min(ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1, Gantt.Duration + 1)
			ZoomH(ChartIndex).BeginIndex = ZoomH(ChartIndex).EndIndex - Gantt.XNbIntervals + 1
			xpnlZoomBarH.Visible = True
		Else
			ZoomH(ChartIndex).Active = False
			ZoomH(ChartIndex).BeginIndex = 0
			ZoomH(ChartIndex).EndIndex = Gantt.Duration - 1
			xpnlZoomBarH.Visible = False
		End If
	End If
	
	Gantt.GraphRect.Initialize(Gantt.Left, Gantt.Top + 2 * Gantt.YInterval, Gantt.Right, Gantt.Bottom)
	Gantt.CalendarRect.Initialize(Gantt.Left, Gantt.Top, Gantt.Right, Gantt.Bottom)
	Gantt.CalendarMonthsRect.Initialize(Gantt.Left, Gantt.Top, Gantt.Right, Gantt.Top + Gantt.YInterval)
	Gantt.CalendarDaysRect.Initialize(Gantt.Left, Gantt.Top + Gantt.YInterval, Gantt.Right, Gantt.Top + 2 * Gantt.YInterval)
	Gantt.GraphPath.InitializeRoundedRect(Gantt.GraphRect, 0)
	Gantt.CalendarPath.InitializeRoundedRect(Gantt.CalendarRect, 0)

	If ZoomH(ChartIndex).Active = True Then
		ZoomBarResizeH
		ZoomCursorDrawH
		xpnlZoomBarH.Visible = True
	End If
	
	If ZoomV.Active = True Then
		ZoomBarResizeV
		ZoomCursorDrawV
		xpnlZoomBarV.Visible = True
	End If
End Sub

'Initializes the TABLE chart
Private Sub InitTable
	ChartIndex = 1
	
	Gantt.Top = 0.05 * mBase.Height
	If Gantt.Title <> "" Then
		Gantt.Top = Gantt.Top + 1.0 * Texts.TitleTextHeight
	End If

	If Gantt.SubTitle <> "" Then
		Gantt.Top = Gantt.Top + 1.0 * Texts.SubTitleTextHeight
	End If

	InitTextSizes
	
	Gantt.YInterval = 1.8 * Texts.CalendarTextHeight
	Gantt.YNbIntervals = Min(Tasks.Size, (0.95 * mBase.Height - Gantt.Top - ZoomH(ChartIndex).BarWidth) / Gantt.YInterval - 1)
	Gantt.Height = Gantt.YInterval * (Gantt.YNbIntervals + 2)
	Gantt.Bottom = Gantt.Top + Gantt.Height
	
	If ZoomV.Active = False Then
		If Zooming = False Then
			If Gantt.YNbIntervals >= Tasks.Size Then
				ZoomV.Active = False
				ZoomV.BeginIndex = 0
				ZoomV.EndIndex = Tasks.Size - 1
				ZoomV.CursorLength = (xpnlZoomBarV.Height - 2 * ZoomV.ButtonLength) / Tasks.Size * Gantt.YNbIntervals
			Else
				ZoomV.Active = True
				ZoomV.BeginIndex = 0
				ZoomV.EndIndex = ZoomV.BeginIndex + Gantt.YNbIntervals - 1
			End If
		End If
	End If
	
	GetColumnWidths
	
	FixedTaskTable.Left = 0.025 * mBase.Width
	FixedTaskTable.Right = FixedTaskTable.Left + FixedTaskTable.Width
'	Gantt.Left = FixedTaskTable.Left
	Gantt.Left = FixedTaskTable.Right
'	Gantt.Width = 0.975 * mBase.Width - Gantt.Left	'???
	Gantt.Width = 0.95 * mBase.Width - Gantt.Left

	If TableColumnLeft(TableColumnLeft.Length - 1) - FixedTaskTable.Right < Gantt.Width Then
		Gantt.Width = TableColumnLeft(TableColumnLeft.Length - 1) - Gantt.Left + 0.025 * mBase.Width
	End If
	Gantt.XNbIntervals = Gantt.Width
	
	If ZoomH(ChartIndex).Active = False Then
		If Gantt.XNbIntervals >= Gantt.Duration Then
			ZoomH(ChartIndex).Active = False
			ZoomH(ChartIndex).BeginIndex = 0
			ZoomH(ChartIndex).EndIndex = Gantt.Duration - 1
		Else
			ZoomH(ChartIndex).Active = True
			ZoomH(ChartIndex).BeginIndex = 0
			ZoomH(ChartIndex).EndIndex = ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1
			ZoomH(ChartIndex).CursorLength = (xpnlZoomBarH.Width - 2 * ZoomH(ChartIndex).ButtonLength) / Gantt.Duration * Gantt.XNbIntervals
		End If
	Else
		If ZoomH(ChartIndex).EndIndex - ZoomH(ChartIndex).BeginIndex + 1 <> Gantt.Duration Then
			ZoomH(ChartIndex).EndIndex = Min(ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1, Gantt.Duration + 1)
			ZoomH(ChartIndex).BeginIndex = ZoomH(ChartIndex).EndIndex - Gantt.XNbIntervals + 1
			xpnlZoomBarH.Visible = True
		Else
			ZoomH(ChartIndex).Active = False
			ZoomH(ChartIndex).BeginIndex = 0
			ZoomH(ChartIndex).EndIndex = Gantt.Duration - 1
			xpnlZoomBarH.Visible = False
		End If
	End If
	
	Gantt.Right = Gantt.Left + Gantt.Width
	Gantt.GraphRect.Initialize(Gantt.Left, Gantt.Top + 2 * Gantt.YInterval, Gantt.Right, Gantt.Bottom)
	Gantt.CalendarRect.Initialize(Gantt.Left, Gantt.Top, Gantt.Right, Gantt.Bottom)
	Gantt.CalendarMonthsRect.Initialize(Gantt.Left, Gantt.Top, Gantt.Right, Gantt.Top + Gantt.YInterval)
	Gantt.CalendarDaysRect.Initialize(Gantt.Left, Gantt.Top + Gantt.YInterval, Gantt.Right, Gantt.Top + 2 * Gantt.YInterval)
	Gantt.GraphPath.InitializeRoundedRect(Gantt.GraphRect, 0)
	Gantt.CalendarPath.InitializeRoundedRect(Gantt.CalendarRect, 0)
	
	If TableColumnLeft(TableColumnLeft.Length - 1) - TableColumnLeft(3) <= Gantt.Width Then
		ZoomH(ChartIndex).Active = False
		xpnlZoomBarH.Visible = False
	Else
		ZoomH(ChartIndex).Active = True
		ZoomBarResizeH
		ZoomCursorDrawH
		xpnlZoomBarH.Visible = True
	End If
	
	If ZoomV.Active = True Then
		ZoomBarResizeV
		ZoomCursorDrawV
		xpnlZoomBarV.Visible = True
	End If
End Sub

'initialize text sizes
Private Sub InitTextSizes
	If Texts.AutomaticTextSizes = True Then
		Private GraphSize As Int
		GraphSize = Min(xpnlChart.Width, xpnlChart.Height) / xui.Scale
		Private Scale As Double
		Scale = Max(0.8, (1 + (GraphSize - 500)/1000))
		Scale = Min(1.2, Scale)
		Texts.TitleTextSize = Scale * 18
		Texts.SubtitleTextSize = Scale * 15
		Texts.CalendarTextSize = Scale * 11
		Values.TextSize = Scale * 14
	End If
	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.SubtitleFont = xui.CreateDefaultFont(Texts.SubtitleTextSize)
	Texts.CalendarFont = xui.CreateDefaultFont(Texts.CalendarTextSize)
	Texts.TaskDataFont = xui.CreateDefaultFont(Texts.CalendarTextSize)
	Values.DataFont = xui.CreateDefaultFont(Values.TextSize)
	
	Texts.TitleTextHeight = MeasureTextHeight("Mg", Texts.TitleFont)
	Texts.TitleTextWidth = MeasureTextWidth(Gantt.Title, Texts.TitleFont)
	Texts.SubtitleTextHeight = MeasureTextHeight("Mg", Texts.SubtitleFont)
	Texts.SubtitleTextWidth = MeasureTextWidth(Gantt.Subtitle, Texts.SubtitleFont)
	Texts.CalendarTextHeight =  MeasureTextHeight("Mg", Texts.CalendarFont)
	Texts.TaskTextHeight =  MeasureTextHeight("Mg", Texts.TaskDataFont)
	Values.TextHeight = MeasureTextHeight("Mg", Values.DataFont)
End Sub

'initializes the Toolbox parameters
Private Sub ToolboxInit
	ButtonText = Array As String("Gantt", "Table", "Edit")
	ButtonTextColor = xui.Color_DarkGray
	ButtonTextSetColor = xui.Color_Black
	ButtonBackgroundColor = Gantt.ChartBackgroundColor
	ButtonBackgroundSetColor = xui.Color_Cyan
	ButtonBorderColor = xui.Color_DarkGray
	ButtonBorderSetColor = xui.Color_Blue
End Sub

'initializes the ZoomBar parameters
Private Sub ZoomBarsInit
	Private i As Int
	
	For i = 0 To 1
	ZoomH(i).ColorBar = xui.Color_RGB(196, 196, 196)
	ZoomH(i).ColorButton = xui.Color_RGB(240, 240, 240)
		ZoomH(i).ColorButtonFrame = xui.Color_RGB(148, 148, 148)
		ZoomH(i).BarWidth = 16dip
		ZoomH(i).ButtonLength = 18dip
		ZoomH(i).CornerRadius = 2dip
	Next
	xpnlZoomBarH.Visible = False
	
	ZoomV.ColorBar = xui.Color_RGB(196, 196, 196)
	ZoomV.ColorButton = xui.Color_RGB(240, 240, 240)
	ZoomV.ColorButtonFrame = xui.Color_RGB(148, 148, 148)
	
	ZoomV.BarWidth = 16dip
	ZoomV.ButtonLength = 18dip
	ZoomV.CornerRadius = 2dip
	xpnlZoomBarV.Visible = False
End Sub

'resizes the vertical ZoomBar object
Private Sub ZoomBarResizeV
	Private pth As B4XPath
	Private rect As B4XRect
	Private y0 As Int

	xpnlZoomBarV.Visible = True
	xcvsZoomBarV.ClearRect(xcvsZoomBarV.TargetRect)
	rect.Initialize(0, ZoomV.CornerRadius, ZoomV.BarWidth, ZoomV.BarLength - ZoomV.CornerRadius)
	xcvsZoomBarV.DrawRect(rect, ZoomV.ColorBar, True, 1dip)
	xcvsZoomBarV.Invalidate
	
	xpnlZoomBarV.Left = mBase.Width - ZoomV.BarWidth - 2dip
	xpnlZoomBarV.Top = Gantt.Top
	xpnlZoomBarV.Height = Gantt.Height
	xpnlZoomBarV.Width = ZoomV.BarWidth
	ZoomV.BarLength = xpnlZoomBarV.Height
	ZoomV.CursorLength = (xpnlZoomBarV.Height - 2 * ZoomV.ButtonLength) / Tasks.Size * Gantt.YNbIntervals
	
	If ZoomV.CursorLength >= (ZoomV.BarLength - 2 * ZoomV.ButtonLength) Then
		ZoomV.Active = False
		xpnlZoomBarV.Visible = False
		Return
	End If
	
	'Draw left button
	rect.Initialize(0, 0, ZoomV.BarWidth, ZoomV.ButtonLength)
	pth.InitializeRoundedRect(rect, ZoomV.CornerRadius)
	xcvsZoomBarV.DrawPath(pth, ZoomV.ColorButton, True, 1dip)
	xcvsZoomBarV.DrawPath(pth, ZoomV.ColorButtonFrame, False, 1dip)
	
	'Draw left button arrow
	pth.Initialize(0.5 * xpnlZoomBarV.Width, 0.37 * ZoomV.ButtonLength)
	pth.LineTo(0.23 * xpnlZoomBarV.Width, 0.62 * ZoomV.ButtonLength)
	pth.LineTo(0.77 * xpnlZoomBarV.Width, 0.62 * ZoomV.ButtonLength)
	xcvsZoomBarV.DrawPath(pth, ZoomV.ColorButtonFrame, True, 1dip)
	
	'Draw right button	
	y0 = xpnlZoomBarV.Height - ZoomV.ButtonLength
	rect.Initialize(0, y0, xpnlZoomBarV.Width, xpnlZoomBarV.Height)
	pth.InitializeRoundedRect(rect, ZoomV.CornerRadius)
	xcvsZoomBarV.DrawPath(pth, ZoomV.ColorButton, True, 1dip)
	xcvsZoomBarV.DrawPath(pth, ZoomV.ColorButtonFrame, False, 1dip)
	
	'Draw right button arrow
	pth.Initialize(0.23 * ZoomV.BarWidth, y0 + 0.38 * ZoomV.ButtonLength)
	pth.LineTo(0.5 * ZoomV.BarWidth, y0 + 0.62 * ZoomV.ButtonLength)
	pth.LineTo(0.77 * ZoomV.BarWidth, y0 + 0.38 * ZoomV.ButtonLength)
	xcvsZoomBarV.DrawPath(pth, ZoomV.ColorButtonFrame, True, 1dip)
	
	xcvsZoomBarV.Invalidate
End Sub
 
'resizes the horizontal ZoomBar object
Private Sub ZoomBarResizeH
	Private pth As B4XPath
	Private rect As B4XRect
	Private x0 As Int
	
	xpnlZoomBarH.Visible = True
	xcvsZoomBarH.ClearRect(xcvsZoomBarH.TargetRect)
	rect.Initialize(ZoomH(ChartIndex).CornerRadius, 0, ZoomH(ChartIndex).BarLength - ZoomH(ChartIndex).CornerRadius, ZoomH(ChartIndex).BarWidth)
	xcvsZoomBarH.DrawRect(rect, ZoomH(ChartIndex).ColorBar, True, 1dip)
	xcvsZoomBarH.Invalidate
	
	xpnlZoomBarH.Left = Gantt.Left
	xpnlZoomBarH.Top = mBase.Height - ZoomH(ChartIndex).BarWidth
	xpnlZoomBarH.Height = ZoomH(ChartIndex).BarWidth
'	xpnlZoomBarH.Width = mBase.Width - ZoomH.BarWidth
	xpnlZoomBarH.Width = Gantt.Width
	xcvsZoomBarH.Resize(xpnlZoomBarH.Width, xpnlZoomBarH.Height)
	ZoomH(ChartIndex).BarLength = xpnlZoomBarH.Width
	ZoomH(ChartIndex).CursorLength = (xpnlZoomBarH.Width - 2 * ZoomH(ChartIndex).ButtonLength) / Gantt.Duration * Gantt.XNbIntervals
	
	If ZoomH(ChartIndex).CursorLength >= (ZoomH(ChartIndex).BarLength - 2 * ZoomH(ChartIndex).ButtonLength) Then
		ZoomH(ChartIndex).Active = False
		xpnlZoomBarH.Visible = False
		Return
	End If
	rect.Initialize(0, 0, ZoomH(ChartIndex).ButtonLength, ZoomH(ChartIndex).BarWidth)
	pth.InitializeRoundedRect(rect, ZoomH(ChartIndex).CornerRadius)
	xcvsZoomBarH.DrawPath(pth, ZoomH(ChartIndex).ColorButton, True, 1dip)
	xcvsZoomBarH.DrawPath(pth, ZoomH(ChartIndex).ColorButtonFrame, False, 1dip)

	pth.Initialize(0.37 * ZoomH(ChartIndex).ButtonLength, 0.5 * ZoomH(ChartIndex).BarWidth)
	pth.LineTo(0.62 * ZoomH(ChartIndex).ButtonLength, 0.23 * ZoomH(ChartIndex).BarWidth)
	pth.LineTo(0.62 * ZoomH(ChartIndex).ButtonLength, 0.77 * ZoomH(ChartIndex).BarWidth)
	xcvsZoomBarH.DrawPath(pth, ZoomH(ChartIndex).ColorButtonFrame, True, 1dip)

	x0 = xpnlZoomBarH.Width - ZoomH(ChartIndex).ButtonLength
	rect.Initialize(x0, 0, xpnlZoomBarH.Width, xpnlZoomBarH.Height)
	pth.InitializeRoundedRect(rect, ZoomH(ChartIndex).CornerRadius)
	xcvsZoomBarH.DrawPath(pth, ZoomH(ChartIndex).ColorButton, True, 1dip)
	xcvsZoomBarH.DrawPath(pth, ZoomH(ChartIndex).ColorButtonFrame, False, 1dip)
	
	pth.Initialize(x0 + 0.38 * ZoomH(ChartIndex).ButtonLength, 0.23 * ZoomH(ChartIndex).BarWidth)
	pth.LineTo(x0 + 0.62 * ZoomH(ChartIndex).ButtonLength, 0.5 * ZoomH(ChartIndex).BarWidth)
	pth.LineTo(x0 + 0.38 * ZoomH(ChartIndex).ButtonLength, 0.77 * ZoomH(ChartIndex).BarWidth)
	xcvsZoomBarH.DrawPath(pth, ZoomH(ChartIndex).ColorButtonFrame, True, 1dip)
	
	xcvsZoomBarH.Invalidate
End Sub


'draws the vertical zoom cursor
Private Sub ZoomCursorDrawV
	Private rectCursor, rectBar As B4XRect
	Private pthCursor As B4XPath
	
	rectBar.Initialize(0, ZoomV.ButtonLength, ZoomV.BarWidth, xpnlZoomBarV.Height - ZoomV.ButtonLength)
	xcvsZoomBarV.DrawRect(rectBar, ZoomV.ColorBar, True, 1dip)

	ZoomV.CursorBegin = (xpnlZoomBarV.Height - 2 * ZoomV.ButtonLength - ZoomV.CursorLength) / (Tasks.Size - Gantt.YNbIntervals) * ZoomV.BeginIndex + ZoomV.ButtonLength
	If ZoomV.CursorBegin + ZoomV.CursorLength > ZoomV.BarLength - ZoomV.ButtonLength Then
		ZoomV.BeginIndex = (Tasks.Size - Gantt.YNbIntervals)
		ZoomV.EndIndex = ZoomV.BeginIndex + Gantt.YNbIntervals - 1
		ZoomV.CursorBegin = (xpnlZoomBarV.Width - 2 * ZoomV.ButtonLength - ZoomV.CursorLength) / (Tasks.Size - Gantt.YNbIntervals) * ZoomV.BeginIndex + ZoomV.ButtonLength
	End If
	rectCursor.Initialize(0, ZoomV.CursorBegin, ZoomV.BarWidth, ZoomV.CursorBegin + ZoomV.CursorLength)
	pthCursor.InitializeRoundedRect(rectCursor, ZoomV.CornerRadius)
	xcvsZoomBarV.DrawPath(pthCursor, ZoomV.ColorButton, True, 1dip)
	xcvsZoomBarV.DrawPath(pthCursor, ZoomV.ColorButtonFrame, False, 1dip)

	xcvsZoomBarV.Invalidate
End Sub

'draws the horizonal zoom cursor
Private Sub ZoomCursorDrawH
	Private rectCursor, rectBar As B4XRect
	Private pthCursor As B4XPath
	
	rectBar.Initialize(ZoomH(ChartIndex).ButtonLength, 0, ZoomH(ChartIndex).BarLength - ZoomH(ChartIndex).ButtonLength, xpnlZoomBarH.Height)
	xcvsZoomBarH.DrawRect(rectBar, ZoomH(ChartIndex).ColorBar, True, 1dip)
	xcvsZoomBarH.Invalidate
	
	Select Gantt.DisplayType
		Case "GANTT"
			ZoomH(ChartIndex).CursorBegin = (xpnlZoomBarH.Width - 2 * ZoomH(ChartIndex).ButtonLength - ZoomH(ChartIndex).CursorLength) / (Gantt.Duration - Gantt.XNbIntervals) * ZoomH(ChartIndex).BeginIndex + ZoomH(ChartIndex).ButtonLength
			If ZoomH(ChartIndex).CursorBegin + ZoomH(ChartIndex).CursorLength > ZoomH(ChartIndex).BarLength - ZoomH(ChartIndex).ButtonLength Then
				ZoomH(ChartIndex).BeginIndex = (Gantt.Duration - Gantt.XNbIntervals)
				ZoomH(ChartIndex).EndIndex = ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1
				ZoomH(ChartIndex).CursorBegin = (xpnlZoomBarH.Width - 2 * ZoomH(ChartIndex).ButtonLength - ZoomH(ChartIndex).CursorLength) / (Gantt.Duration - Gantt.XNbIntervals) * ZoomH(ChartIndex).BeginIndex + ZoomH(ChartIndex).ButtonLength
			End If
		Case "TABLE"
			ZoomH(ChartIndex).CursorBegin = (xpnlZoomBarH.Width - 2 * ZoomH(ChartIndex).ButtonLength - ZoomH(ChartIndex).CursorLength) / (Gantt.Duration - Gantt.XNbIntervals) * ZoomH(ChartIndex).BeginIndex + ZoomH(ChartIndex).ButtonLength
			If ZoomH(ChartIndex).CursorBegin + ZoomH(ChartIndex).CursorLength > ZoomH(ChartIndex).BarLength - ZoomH(ChartIndex).ButtonLength Then
				ZoomH(ChartIndex).BeginIndex = (Gantt.Duration - Gantt.XNbIntervals)
				ZoomH(ChartIndex).EndIndex = ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1
				ZoomH(ChartIndex).CursorBegin = (xpnlZoomBarH.Width - 2 * ZoomH(ChartIndex).ButtonLength - ZoomH(ChartIndex).CursorLength) / (Gantt.Duration - Gantt.XNbIntervals) * ZoomH(ChartIndex).BeginIndex + ZoomH(ChartIndex).ButtonLength
			End If
	End Select
	rectCursor.Initialize(ZoomH(ChartIndex).CursorBegin, 0, ZoomH(ChartIndex).CursorBegin + ZoomH(ChartIndex).CursorLength, xpnlZoomBarH.Height)
	pthCursor.InitializeRoundedRect(rectCursor, 3dip)
	xcvsZoomBarH.DrawPath(pthCursor, ZoomH(ChartIndex).ColorButton, True, 1dip)
	xcvsZoomBarH.DrawPath(pthCursor, ZoomH(ChartIndex).ColorButtonFrame, False, 1dip)

	xcvsZoomBarH.Invalidate
End Sub

Public Sub DrawChart
	xcvsChart.ClearRect(xcvsChart.TargetRect)
	xcvsChart.DrawRect(xcvsChart.TargetRect, Gantt.ChartBackgroundColor, True, 1dip)
	
	InitChart
	Select Gantt.DisplayType
		Case "GANTT"
			DrawCalendar
			If FixedTaskTable.Display = True Then
				DrawColumnsFixed
			End If
			DrawTasksInGantt
		Case "TABLE"
			DrawTable
'		Case "EDIT"
'			xpnlEdit.Visible = True
'			EditFillTasks
'			EditUpdate
	End Select
End Sub

Private Sub DrawColumnsFixed
	Private j, row, col As Int
	Private xt, yt, yl As Int
	
	For j = 0 To ZoomV.EndIndex - ZoomV.BeginIndex + 3
		yl = Gantt.Top + j * Gantt.YInterval
		If j <> 1 Or Gantt.DisplayType = "GANTT" Then
			xcvsChart.DrawLine(FixedTaskTable.Left, yl, FixedTaskTable.Right, yl, Gantt.GridColor, 1dip)
		End If
	Next
	
	For col = 0 To 3
		xcvsChart.DrawLine(FixedTaskTable.Left + TableColumnLeft(col), Gantt.Top, FixedTaskTable.Left + TableColumnLeft(col), Gantt.Bottom, Gantt.GridColor, 1dip)
	Next
	
	yt = Gantt.Top + 2 * Gantt.YInterval - 0.5 * Texts.TaskTextHeight
	xt = FixedTaskTable.Left + TableColumnLeft(0) + Texts.TaskTextHeight
	xcvsChart.DrawText("Row", xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt = FixedTaskTable.Left + TableColumnLeft(1) + Texts.TaskTextHeight
	xcvsChart.DrawText("ID", xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt = FixedTaskTable.Left + TableColumnLeft(2) + Texts.TaskTextHeight
	xcvsChart.DrawText("Name", xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	
	
	For row = ZoomV.BeginIndex To ZoomV.EndIndex
		Private TD As GanttTaskData
	
		j = row - ZoomV.BeginIndex + 1
		yl = Gantt.Top + j * Gantt.YInterval
		yt = yl - 0.5 * Texts.TaskTextHeight
'		xcvsChart.DrawLine(FixedTaskTable.Left, yl, FixedTaskTable.Right, yl, Gantt.GridColor, 1dip)
	
		TD = Tasks.Get(row)
		yt = Gantt.Top + (j + 2) * Gantt.YInterval - 0.5 * Texts.TaskTextHeight
		xt = FixedTaskTable.Left + TableColumnLeft(1) - Texts.TaskTextHeight
		xcvsChart.DrawText(row, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "RIGHT")
		xt = FixedTaskTable.Left + TableColumnLeft(1) + Texts.TaskTextHeight
		xcvsChart.DrawText(TD.ID, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
		xt = FixedTaskTable.Left + TableColumnLeft(2) + Texts.TaskTextHeight
		xcvsChart.DrawText(TD.Name, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	Next
End Sub

Private Sub DrawTaskData(IndexTask As Int, X As Int, Y As Int)
	Private i, WidthL, WidthR, xt, yt, ht, NbLines As Int
	Private TD As GanttTaskData
	Private rectText As B4XRect
	
	TD = Tasks.Get(IndexTask)
	
	'Draws the cursor	FixedTaskTable
	Private rectCursorV, rectCursorH As B4XRect
	Private x0, y0 As Int
	If X > Gantt.Left Then
		x0 = (X - Gantt.Left) / Gantt.XInterval
		x0 = x0 * Gantt.XInterval + Gantt.Left
		rectCursorV.Initialize(x0, Gantt.Top + Gantt.YInterval, x0 + Gantt.XInterval, Gantt.Bottom)
		xcvsCursor.DrawRect(rectCursorV, xui.Color_ARGB(mAlphaCursorV, 0, 0, 0), True, 1dip)
		xcvsCursor.DrawRect(rectCursorV, xui.Color_Red, False, 1dip)
	End If
	y0 = (Y - Gantt.Top) / Gantt.YInterval
	y0 = y0 * Gantt.YInterval + Gantt.Top
	rectCursorH.Initialize(FixedTaskTable.Left, y0, Gantt.Right, y0 + Gantt.YInterval)
	xcvsCursor.DrawRect(rectCursorH, SetColorAlpha(TD.Color, mAlphaCursorH), True, 1dip)
	xcvsCursor.DrawRect(rectCursorH, xui.Color_Red, False, 1dip)

	rectText = xcvsValues.MeasureText("Mg", Values.DataFont)

	If FixedTaskTable.Display = False Or X >= Gantt.Left Then
		NbLines = 10
	Else
		WidthL = Max(WidthL, MeasureTextWidth("Day : ", Values.DataFont))
		NbLines = 9
	End If
	WidthL = Max(WidthL, MeasureTextWidth("Dependency : ", Values.DataFont))
	If TD.SuccessorIDs.Size > 0 Then
		WidthL = Max(WidthL, MeasureTextWidth("Successor IDs : ", Values.DataFont))		
	End If
	If TD.Dependency <> "None" Then
		WidthL = Max(WidthL, MeasureTextWidth("Predecessor ID : ", Values.DataFont))
		NbLines = NbLines + 2
	End If
	If TD.SuccessorIDs.Size > 0 Then
		NbLines = NbLines + TD.SuccessorIDs.Size
	End If
	WidthL = WidthL + 0.5 * Values.TextHeight
	
	WidthR = Max(WidthR, MeasureTextWidth(CurrentDay2, Values.DataFont))
	WidthR = Max(WidthR, MeasureTextWidth(TD.ID, Values.DataFont))
	WidthR = Max(WidthR, MeasureTextWidth(TD.Name, Values.DataFont))
	WidthR = Max(WidthR, MeasureTextWidth(TD.Responsible, Values.DataFont))
	WidthR = Max(WidthR, MeasureTextWidth(TD.BeginDate, Values.DataFont))
	WidthR = Max(WidthR, MeasureTextWidth(TD.EndDate, Values.DataFont))
	WidthR = Max(WidthR, MeasureTextWidth(TD.Duration & " days", Values.DataFont))
	WidthR = Max(WidthR, MeasureTextWidth(TD.PredecessorID, Values.DataFont))
	
	ht = 1.2 * Values.TextHeight
	xpnlValues.Height = NbLines * ht
	xpnlValues.Width = WidthL + WidthR + Values.TextHeight
	xpnlValues.Left = Max(Gantt.Left + 2dip, X - xpnlValues.Width / 2)
	xpnlValues.Left = Min(Gantt.Right - 2dip - xpnlValues.Width, xpnlValues.Left)
	Select Values.Position
		Case "TOP"
			xpnlValues.Top = Gantt.Top + 2 * Gantt.YInterval
			If X >= FixedTaskTable.Left And X < FixedTaskTable.Right Then
				xpnlValues.Left = Gantt.Left + (Gantt.Width - xpnlValues.Width) / 2
			Else
				If X < Gantt.Left + Gantt.Width / 2 Then
					xpnlValues.Left = Gantt.Right - xpnlValues.Width
				Else
					xpnlValues.Left = Gantt.Left
				End If
			End If
		Case "CURSOR"
			If X >= FixedTaskTable.Left And X < FixedTaskTable.Right Then
				xpnlValues.Left = Gantt.Left
				xpnlValues.Top = Max(Y - xpnlValues.Height / 2, Gantt.Top)
				xpnlValues.Top = Min(Y - xpnlValues.Height / 2, mBase.Height - xpnlValues.Height)
			Else
				xpnlValues.Left = Max(Gantt.Left + 2dip, X - xpnlValues.Width / 2)
				xpnlValues.Left = Min(Gantt.Right - 2dip - xpnlValues.Width, xpnlValues.Left)
				If Y - xpnlValues.Height + 2dip < Gantt.Top Then
					xpnlValues.Top = Y

					If X < Gantt.Left + Gantt.Width / 2 Then
						xpnlValues.Left = X + Values.TextHeight / 2
					Else
						xpnlValues.Left = X - xpnlValues.Width - Values.TextHeight / 2
					End If
				Else
					xpnlValues.Top = Y - xpnlValues.Height - Values.TextHeight
				End If
			End If
	End Select
	
	xcvsValues.Resize(xpnlValues.Width, xpnlValues.Height)
	xcvsValues.ClearRect(xcvsValues.TargetRect)
'	xcvsValues.DrawRect(xcvsValues.TargetRect, SetColorAlpha(TD.Color, mAlphaValues), True, 0)
'	xcvsValues.DrawRect(xcvsValues.TargetRect, 0xDDFFFFFF, True, 0)
	xcvsValues.DrawRect(xcvsValues.TargetRect, xui.Color_ARGB(mAlphaValues, 255, 255, 255), True, 0)
	xcvsValues.DrawRect(xcvsValues.TargetRect, TD.Color, False, 4dip)
	
	xt = WidthL + 0.5 * Values.TextHeight
	yt = -rectText.Top + 0.7 * ht
	If FixedTaskTable.Display = False Or X >= Gantt.Left Then
		xcvsValues.DrawText("Day : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
		xcvsValues.DrawText(CurrentDay2, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
		yt = yt + ht
	End If
	xcvsValues.DrawText("Task ID : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.ID, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("Task : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.Name, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("Responsible : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.Responsible, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("Begin date : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.BeginDate, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("End date : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.EndDate, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("Duration : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.Duration & " days", xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("Completion : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.Completion & " %", xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("Dependency : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
	xcvsValues.DrawText(TD.Dependency, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	If TD.Dependency <> "None" Then
		yt = yt + ht
		xcvsValues.DrawText("Predecessor ID : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
		xcvsValues.DrawText(TD.PredecessorID, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
		yt = yt + ht
		xcvsValues.DrawText("Lag / Lead : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
		xcvsValues.DrawText(TD.LagLead, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	End If
	If TD.SuccessorIDs.Size > 0 Then
		yt = yt + ht
		xcvsValues.DrawText("Successor IDs : ", xt, yt, Values.DataFont, Values.TextColor, "RIGHT")
		xcvsValues.DrawText(TD.SuccessorIDs.Get(0), xt, yt, Values.DataFont, Values.TextColor, "LEFT")
		For i = 1 To TD.SuccessorIDs.Size - 1
			yt = yt + ht
			xcvsValues.DrawText(TD.SuccessorIDs.Get(i), xt, yt, Values.DataFont, Values.TextColor, "LEFT")		
		Next
	End If
	xcvsValues.Invalidate
	xcvsCursor.Invalidate
	
	xpnlValues.Visible = True
End Sub

Private Sub DrawActiveTasks(DayIndex As Int, X As Int, Y As Int)
	Private Width, xt, yt, ht As Int
	Private rectText As B4XRect
	Private lstActiveTasks As List
	
	'Draws the cursor	FixedTaskTable
	Private rectCursorV, rectCursorH As B4XRect
	Private x0, y0 As Int
	If X > Gantt.Left Then
		x0 = (X - Gantt.Left) / Gantt.XInterval
		x0 = x0 * Gantt.XInterval + Gantt.Left
		rectCursorV.Initialize(x0, Gantt.Top + Gantt.YInterval, x0 + Gantt.XInterval, Gantt.Bottom)
		xcvsCursor.DrawRect(rectCursorV, xui.Color_ARGB(mAlphaCursorV, 0, 0, 0), True, 1dip)
		xcvsCursor.DrawRect(rectCursorV, xui.Color_Red, False, 1dip)
		y0 = (Y - Gantt.Top) / Gantt.YInterval
		y0 = Gantt.Top + Gantt.YInterval
		rectCursorH.Initialize(Gantt.Left, y0, Gantt.Right, y0 + Gantt.YInterval)
		xcvsCursor.DrawRect(rectCursorH, xui.Color_Red, False, 1dip)
	End If

	lstActiveTasks.Initialize
	Width = MeasureTextWidth("Active tasks", Values.DataFont)
	For i = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(i)
		If DayIndex >= TD.BeginDayIndex And DayIndex <= TD.EndDayIndex Then
			lstActiveTasks.Add(i)
			Width = Max(Width, MeasureTextWidth(TD.Name, Values.DataFont))
		End If
	Next
	rectText = xcvsValues.MeasureText("Mg", Values.DataFont)
	
	ht = 1.2 * Values.TextHeight
	xpnlValues.Height = (lstActiveTasks.Size + 3) * ht
	xpnlValues.Width = Width + Values.TextHeight
	Select Values.Position
		Case "TOP"
			xpnlValues.Top = Gantt.Top + 2 * Gantt.YInterval
			If X < Gantt.Left + Gantt.Width / 2 Then
				xpnlValues.Left =  Gantt.Right - xpnlValues.Width
			Else
				xpnlValues.Left =  Gantt.Left
			End If
		Case "CURSOR"
			xpnlValues.Left = Max(2dip, X - xpnlValues.Width / 2)
			xpnlValues.Left = Min(Gantt.Right - 2dip, xpnlValues.Left)
			If Y - xpnlValues.Height + 2dip < Gantt.Top Then
				xpnlValues.Top = Y
				If X < Gantt.Left + Gantt.Width / 2 Then
					xpnlValues.Left = X + Values.TextHeight / 2
				Else
					xpnlValues.Left = X - xpnlValues.Width - Values.TextHeight / 2
				End If
			Else
				xpnlValues.Top = Y - xpnlValues.Height - Values.TextHeight
			End If
	End Select
	
	xcvsValues.Resize(xpnlValues.Width, xpnlValues.Height)
	xcvsValues.ClearRect(xcvsValues.TargetRect)
	xcvsValues.DrawRect(xcvsValues.TargetRect, 0xDDFFFFFF, True, 0)
	xcvsValues.DrawRect(xcvsValues.TargetRect, xui.Color_DarkGray, False, 4dip)
	
	xt = 0.5 * Values.TextHeight
	yt = -rectText.Top + 0.7 * ht
	xcvsValues.DrawText(CurrentDay1, xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	yt = yt + ht
	xcvsValues.DrawText("Active tasks :", xt, yt, Values.DataFont, Values.TextColor, "LEFT")
	For i = 0 To lstActiveTasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(lstActiveTasks.Get(i))
		yt = yt + ht
		xcvsValues.DrawText(TD.Name, xt, yt, Values.DataFont, TD.Color, "LEFT")
	Next
	xcvsValues.Invalidate
	xcvsCursor.Invalidate
	
	xpnlValues.Visible = True
End Sub

Private Sub DrawCalendar
	Private i, x, y As Int
	Private rectDay As B4XRect
	
	If Gantt.Title <> "" Then
		xcvsChart.DrawText(Gantt.Title, Gantt.Left + Gantt.Width / 2, 1.4 * Texts.TitleTextHeight, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
	End If
	If Gantt.SubTitle <> "" Then
		xcvsChart.DrawText(Gantt.SubTitle, Gantt.Left + Gantt.Width / 2, Gantt.Top - 0.6 * Texts.SubTitleTextHeight, Texts.SubTitleFont, Texts.SubTitleTextColor, "CENTER")
	End If
	
	Private CurrentTicks As Long
	
	CurrentTicks = Gantt.BeginTicks
	CurrentTicks = Gantt.BeginTicks + ZoomH(ChartIndex).BeginIndex * DateTime.TicksPerDay
	y = Min(Gantt.Top + (Tasks.Size + 2) * Gantt.YInterval, Gantt.Bottom)
	For i = ZoomH(0).BeginIndex To ZoomH(ChartIndex).EndIndex
		x = Gantt.Left + (i - ZoomH(ChartIndex).BeginIndex) * Gantt.XInterval
		If DateTime.GetDayOfWeek(CurrentTicks) = 1 Or DateTime.GetDayOfWeek(CurrentTicks) = 7 Then
			rectDay.Initialize(x, Gantt.CalendarDaysRect.Top, x + Gantt.XInterval, y)
			xcvsChart.DrawRect(rectDay, Gantt.SundayColor, True, 1dip)
		End If
		CurrentTicks = CurrentTicks + DateTime.TicksPerDay
		If i = ZoomH(ChartIndex).BeginIndex Then
			xcvsChart.DrawLine(x, Gantt.Top, x, y, Gantt.GridColor, 1dip)
		End If
		If i = ZoomH(ChartIndex).EndIndex Then
			xcvsChart.DrawLine(x + Gantt.XInterval, Gantt.Top, x + Gantt.XInterval, y, Gantt.GridColor, 1dip)
		End If
		xcvsChart.DrawLine(x, Gantt.CalendarDaysRect.Top, x, y, Gantt.GridColor, 1dip)
	Next
	
	For i = ZoomV.BeginIndex To ZoomV.EndIndex + 3
		y = Gantt.Top + (i - ZoomV.BeginIndex) * Gantt.YInterval
		xcvsChart.DrawLine(Gantt.Left, y, Gantt.Right, y, Gantt.GridColor, 1dip)
	Next
	
	DrawCalendarDays
	xcvsChart.Invalidate
End Sub

Private Sub DrawCalendarDays
	Private i, x1, x2, y1, y2 As Int
	Private txt As String
	Private CurrentTicks As Long
	Days = Array As String("", "S", "M", "T", "W", "T", "F", "S")
	MonthNamesShort = Array As String("", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
	MonthNamesLong = Array As String("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
	CurrentTicks = Gantt.BeginTicks
	CurrentTicks = Gantt.BeginTicks + ZoomH(ChartIndex).BeginIndex * DateTime.TicksPerDay
	y1 = Gantt.CalendarDaysRect.Bottom - 0.5 * Texts.CalendarTextHeight
	xcvsChart.ClipPath(Gantt.CalendarPath)
	
	For i = ZoomH(ChartIndex).BeginIndex To ZoomH(ChartIndex).EndIndex
		x1 = Gantt.Left + (i - ZoomH(ChartIndex).BeginIndex + 0.5) * Gantt.XInterval
		If Gantt.CalendarDisplayMode = "DAY_OF_WEEK" Then
			txt = Days(DateTime.GetDayOfWeek(CurrentTicks))
		Else
			txt = DateTime.GetDayOfMonth(CurrentTicks)
		End If
		xcvsChart.DrawText(txt, x1, y1, Texts.CalendarFont, Texts.CalendarTextColor, "CENTER")
		
		x2 = Gantt.Left + (i - ZoomH(ChartIndex).BeginIndex) * Gantt.XInterval
		y2 = Gantt.CalendarMonthsRect.Bottom - 0.5 * Texts.CalendarTextHeight
		If Gantt.CalendarDisplayMode = "DAY_OF_WEEK" Then
			If DateTime.GetDayOfWeek(CurrentTicks) = 2 Then
				txt = DateTime.GetDayOfMonth(CurrentTicks) & "  " & MonthNamesShort(DateTime.GetMonth(CurrentTicks)) & "  " & DateTime.GetYear(CurrentTicks)
				xcvsChart.DrawText(txt, x2 + 0.1 * Texts.CalendarTextHeight, y2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
				xcvsChart.DrawLine(x2, Gantt.CalendarMonthsRect.Top, x2, Gantt.CalendarMonthsRect.Bottom, Gantt.GridColor, 1dip)
			End If
		Else
			If DateTime.GetDayOfMonth(CurrentTicks) = 1 Then
				txt = MonthNamesLong(DateTime.GetMonth(CurrentTicks)) & "  " & DateTime.GetYear(CurrentTicks)
				xcvsChart.DrawText(txt, x2 + 0.25 * Texts.CalendarTextHeight, y2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
				xcvsChart.DrawLine(x2, Gantt.CalendarMonthsRect.Top, x2, Gantt.CalendarMonthsRect.Bottom, Gantt.GridColor, 1dip)
			End If
		End If
		CurrentTicks = CurrentTicks + DateTime.TicksPerDay
	Next
	xcvsChart.RemoveClip
End Sub

Private Sub DrawTasksInGantt
	Private i, x0, x1, x2, y1, y2 As Int
	Private rectTask, rectCompletion As B4XRect
	
	xcvsChart.ClipPath(Gantt.GraphPath)
	
	For i = ZoomV.BeginIndex To ZoomV.EndIndex
		Private TD As GanttTaskData
		TD = Tasks.Get(i)
		If TD.EndDayIndex < ZoomH(ChartIndex).BeginIndex Or TD.BeginDayIndex > ZoomH(ChartIndex).EndIndex Then
			If TD.EndDayIndex < ZoomH(ChartIndex).BeginIndex Then
				DrawArrowBegin(i, TD.Color)
			Else
				DrawArrowEnd(i, TD.Color)
			End If
		Else
			y1 = Gantt.GraphRect.Top + (i - ZoomV.BeginIndex + 0.2) * Gantt.YInterval
			y2 = y1 + 0.7 * Gantt.YInterval
			If TD.BeginDayIndex >= ZoomH(ChartIndex).BeginIndex Then
				x0 = Gantt.Left + (TD.BeginDayIndex - ZoomH(ChartIndex).BeginIndex) * Gantt.XInterval + 0.2 * Gantt.XInterval
			Else
				x0 = Gantt.Left
			End If
			If TD.EndDayIndex <= ZoomH(ChartIndex).EndIndex Then
				x2 = Gantt.Left + (TD.EndDayIndex - ZoomH(ChartIndex).BeginIndex) * Gantt.XInterval + 0.8 * Gantt.XInterval
			Else
				x2 = Gantt.Right
			End If
'			rectTask.Initialize(x0 + 1dip, y1 + 1dip, x2 - 1dip, y2 - 1dip)
'			xcvsChart.DrawRect(rectTask, TD.Color, False, 2dip)
			rectTask.Initialize(x0, y1, x2, y2)
			If Gantt.IgnoreCompleted = True Then
				xcvsChart.DrawRect(rectTask,TD.Color, True, 1dip)
			Else
				xcvsChart.DrawRect(rectTask, SetColorAlpha(TD.Color, 80), True, 1dip)
				xcvsChart.DrawRect(rectTask,TD.Color, False, 1dip)
				xcvsChart.DrawLine(x0, y1, x0, y2, TD.Color, 3dip)
				xcvsChart.DrawLine(x2, y1, x2, y2, TD.Color, 3dip)
			End If
			If TD.Completion > 0 Then
				x1 = x0 + (x2 - x0) * TD.Completion / 100
				rectCompletion.Initialize(x0, y1, x1, y2)
				xcvsChart.DrawRect(rectCompletion, TD.Color, True, 1dip)
			End If
			If TD.EndDayIndex > ZoomH(ChartIndex).EndIndex Then
				If TD.Completion < 100 And (x2 - x1) > 0.4 * Gantt.XInterval Then
					DrawArrowEnd(i, xui.Color_RGB(100, 100, 100))
				Else
					DrawArrowEnd(i, GetContrastColor(TD.Color))
				End If
			End If
			If TD.BeginDayIndex < ZoomH(ChartIndex).BeginIndex Then
				If TD.Completion < 100 And (x1 - x0) > 0.4 * Gantt.XInterval Then
					DrawArrowBegin(i, xui.Color_RGB(100, 100, 100))
				Else
					DrawArrowBegin(i, GetContrastColor(TD.Color))
				End If
			End If
			
			If TD.Dependency = "FS" And TD.BeginDayIndex <= ZoomH(ChartIndex).EndIndex And TD.PredecessorID <> "None" Then
				DrawFinishToStart(TD)
			End If
			If TD.Dependency = "FF" And TD.EndDayIndex >= ZoomH(ChartIndex).BeginIndex And TD.EndDayIndex <= ZoomH(ChartIndex).EndIndex Then
				DrawFinishToFinish(TD)
			End If
			If TD.Dependency = "SS" And TD.BeginDayIndex >= ZoomH(ChartIndex).BeginIndex And TD.BeginDayIndex <= ZoomH(ChartIndex).EndIndex Then
				DrawStartToStart(TD)
			End If
			If TD.Dependency = "SF" And TD.BeginDayIndex >= ZoomH(ChartIndex).BeginIndex And TD.BeginDayIndex <= ZoomH(ChartIndex).EndIndex Then
				DrawStartToFinish(TD)
			End If
		End If
	Next
	xcvsChart.RemoveClip
	xcvsChart.Invalidate
End Sub

Private Sub DrawArrowEnd(i As Int, Color As Int)
	Private path As B4XPath
	Private xc, yc, dd As Int
	
	xc = Gantt.Right - 0.5 * Gantt.XInterval 
	yc = Gantt.GraphRect.Top + (i - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	dd = 0.4 * Gantt.XInterval
	path.Initialize(xc, yc + dd)
	path.LineTo(xc + dd, yc)
	path.LineTo(xc, yc - dd)
	xcvsChart.DrawPath(path, Color, True, 1dip)
	xcvsChart.DrawLine(xc - dd, yc, xc + dd, yc, Color, 1dip)
End Sub

Private Sub DrawArrowBegin(i As Int, Color As Int)
	Private path As B4XPath
	Private xc, yc, dd As Int
	
	xc = Gantt.Left + 0.5 * Gantt.XInterval
	yc = Gantt.GraphRect.Top + (i - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	dd = 0.4 * Gantt.XInterval
	path.Initialize(xc - dd, yc)
	path.LineTo(xc, yc - dd)
	path.LineTo(xc, yc + dd)
	xcvsChart.DrawPath(path, Color, True, 1dip)
	xcvsChart.DrawLine(xc - dd, yc, xc + dd, yc, Color, 1dip)
End Sub

Private Sub DrawFinishToStart(TDC As GanttTaskData)
	Private TDP As GanttTaskData
	Private xPath As B4XPath
	Private xRect As B4XRect
	Private iP, iC As Int
	Private x0, x1, x2, x3, y0, y1, y2 As Int

	iC = TaskIDs.IndexOf(TDC.ID) - 1
	iP = TaskIDs.IndexOf(TDC.PredecessorID) - 1
	TDP = Tasks.Get(iP)
	
	x0 = Gantt.Left + (TDP.EndDayIndex - ZoomH(ChartIndex).BeginIndex + 0.8) * Gantt.XInterval
	x1 = Gantt.Left + (TDC.BeginDayIndex - ZoomH(ChartIndex).BeginIndex + 0.2) * Gantt.XInterval
	x2 = Gantt.Left + (TDP.EndDayIndex - ZoomH(ChartIndex).BeginIndex + 1.5) * Gantt.XInterval
	x3 = Gantt.Left + (TDC.BeginDayIndex - ZoomH(ChartIndex).BeginIndex - 0.5) * Gantt.XInterval
	y0 = Gantt.GraphRect.Top + (iP - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	y1 = Gantt.GraphRect.Top + (iC - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	y2 = Gantt.GraphRect.Top + (iP - ZoomV.BeginIndex + 1) * Gantt.YInterval

	xcvsChart.DrawLine(x0, y0 - 0.3 * Gantt.YInterval, x0, y0 + 0.3 * Gantt.YInterval, xui.Color_DarkGray, 3dip)
	xRect.Initialize(x0 - 3dip, y0 - 0.3 * Gantt.YInterval, x0, y0 + 0.3 * Gantt.YInterval)
'	xcvsChart.DrawRect(xRect, xui.Color_DarkGray, True, 1dip)
	xPath.Initialize(x1 - 0.3 * Gantt.XInterval, y1 - 0.3 * Gantt.XInterval)
	xPath.LineTo(x1, y1)
	xPath.LineTo(x1 - 0.3 * Gantt.XInterval, y1 + 0.3 * Gantt.XInterval)
	xcvsChart.DrawPath(xPath, xui.Color_DarkGray, True, 1dip)
	If TDC.BeginDayIndex + TDC.LagLead >= TDP.EndDayIndex Then
		xcvsChart.DrawLine(x0, y0 - 0.3 * Gantt.YInterval, x0, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y1, x1, y1, xui.Color_DarkGray, 1dip)
	Else
		xcvsChart.DrawLine(x0, y0, x2, y0, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y0, x2, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y2, x3, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x3, y2, x3, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x3, y1, x1, y1, xui.Color_DarkGray, 1dip)
	End If
End Sub

Private Sub DrawFinishToFinish(TDC As GanttTaskData)
	Private TDP As GanttTaskData
	Private iP, iC As Int
	Private x0, x1, x2, y0, y1 As Int
	
	iC = TaskIDs.IndexOf(TDC.ID) - 1
	iP = TaskIDs.IndexOf(TDC.PredecessorID) - 1
	TDP = Tasks.Get(iP)
	
	x0 = Gantt.Left + (TDP.EndDayIndex - ZoomH(ChartIndex).BeginIndex + 0.8) * Gantt.XInterval
	x1 = Gantt.Left + (TDC.EndDayIndex - ZoomH(ChartIndex).BeginIndex + 0.8) * Gantt.XInterval
	x2 = Gantt.Left + (TDC.EndDayIndex - ZoomH(ChartIndex).BeginIndex + 1.5) * Gantt.XInterval
	y0 = Gantt.GraphRect.Top + (iP - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	y1 = Gantt.GraphRect.Top + (iC - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	xcvsChart.DrawLine(x0, y0 - 0.3 * Gantt.YInterval, x0, y0 + 0.3 * Gantt.YInterval, xui.Color_DarkGray, 3dip)
	If TDP.EndDayIndex = TDC.EndDayIndex Then
		xcvsChart.DrawLine(x0, y0, x2, y0, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y0, x2, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y1, x1, y1, xui.Color_DarkGray, 1dip)
	Else If TDC.LagLead > 0 Then
		xcvsChart.DrawLine(x0, y0, x2, y0, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y0, x2, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y1, x1, y1, xui.Color_DarkGray, 1dip)		
	Else
		xcvsChart.DrawLine(x0, y0, x1, y0, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x1, y0, x1, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y1, x1, y1, xui.Color_DarkGray, 1dip)
	End If
	Private xPath As B4XPath
	xPath.Initialize(x1 + 0.3 * Gantt.XInterval, y1 - 0.3 * Gantt.XInterval)
	xPath.LineTo(x1, y1)
	xPath.LineTo(x1 + 0.3 * Gantt.XInterval, y1 + 0.3 * Gantt.XInterval)
	xcvsChart.DrawPath(xPath, xui.Color_DarkGray, True, 1dip)
End Sub

Private Sub DrawStartToStart(TDC As GanttTaskData)
	Private TDP As GanttTaskData
	Private iP, iC As Int
	Private x0, x1, x2, y0, y1, y2 As Int
	
	iC = TaskIDs.IndexOf(TDC.ID) - 1
	iP = TaskIDs.IndexOf(TDC.PredecessorID) - 1
	TDP = Tasks.Get(iP)
	
	x0 = Gantt.Left + (TDP.BeginDayIndex - ZoomH(ChartIndex).BeginIndex + 0.2) * Gantt.XInterval
	x1 = Gantt.Left + (TDC.BeginDayIndex - ZoomH(ChartIndex).BeginIndex + 0.2) * Gantt.XInterval
	x2 = Gantt.Left + (TDC.BeginDayIndex - ZoomH(ChartIndex).BeginIndex - 0.5) * Gantt.XInterval
	y0 = Gantt.GraphRect.Top + (iP - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	y1 = Gantt.GraphRect.Top + (iC - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	y2 = Gantt.GraphRect.Top + (iP - ZoomV.BeginIndex + 1) * Gantt.YInterval
	
	xcvsChart.DrawLine(x0, y0 - 0.3 * Gantt.YInterval, x0, y0 + 0.3 * Gantt.YInterval, xui.Color_DarkGray, 3dip)
	If TDP.BeginDayIndex = TDC.BeginDayIndex Then
		xcvsChart.DrawLine(x0, y0 + 0.3 * Gantt.YInterval, x0, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y2, x2, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y2, x2, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y1, x2, y1, xui.Color_DarkGray, 1dip)
	Else If TDC.LagLead > 0 Then
		xcvsChart.DrawLine(x0, y0 + 0.3 * Gantt.YInterval, x0, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y1, x1, y1, xui.Color_DarkGray, 1dip)
	Else
		xcvsChart.DrawLine(x0, y0 , x0, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y2, x2, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y2, x2, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y1, x1, y1, xui.Color_DarkGray, 1dip)
	End If
	Private xPath As B4XPath
	xPath.Initialize(x1 - 0.3 * Gantt.XInterval, y1 - 0.3 * Gantt.XInterval)
	xPath.LineTo(x1, y1)
	xPath.LineTo(x1 - 0.3 * Gantt.XInterval, y1 + 0.3 * Gantt.XInterval)
	xcvsChart.DrawPath(xPath, xui.Color_DarkGray, True, 1dip)
End Sub

Private Sub DrawStartToFinish(TDC As GanttTaskData)
	Private TDP As GanttTaskData
	Private iP, iC As Int
	Private x0, x1, x2, y0, y1, y2 As Int
	
	iC = TaskIDs.IndexOf(TDC.ID) - 1
	iP = TaskIDs.IndexOf(TDC.PredecessorID) - 1
	TDP = Tasks.Get(iP)
	
	x0 = Gantt.Left + (TDP.BeginDayIndex - ZoomH(ChartIndex).BeginIndex + 0.2) * Gantt.XInterval
	x1 = Gantt.Left + (TDC.EndDayIndex - ZoomH(ChartIndex).BeginIndex + 0.8) * Gantt.XInterval
	x2 = Gantt.Left + (TDC.EndDayIndex - ZoomH(ChartIndex).BeginIndex + 1.5) * Gantt.XInterval
	y0 = Gantt.GraphRect.Top + (iP - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	y1 = Gantt.GraphRect.Top + (iC - ZoomV.BeginIndex + 0.5) * Gantt.YInterval
	y2 = Gantt.GraphRect.Top + (iP - ZoomV.BeginIndex + 1) * Gantt.YInterval
	
	xcvsChart.DrawLine(x0, y0 - 0.3 * Gantt.YInterval, x0, y0 + 0.3 * Gantt.YInterval, xui.Color_DarkGray, 3dip)
	If TDP.BeginDayIndex = TDC.EndDayIndex + 1 Then
		xcvsChart.DrawLine(x0, y0, x0, y1, xui.Color_DarkGray, 1dip)
'		xcvsChart.DrawLine(x0, y2, x2, y2, xui.Color_DarkGray, 1dip)
'		xcvsChart.DrawLine(x2, y2, x2, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y1, x1, y1, xui.Color_DarkGray, 1dip)
	Else If TDC.LagLead > 0 Then
		xcvsChart.DrawLine(x0, y0, x0, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y2, x2, y2, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y2, x2, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x2, y1, x1, y1, xui.Color_DarkGray, 1dip)
	Else
		xcvsChart.DrawLine(x0, y0, x0, y1, xui.Color_DarkGray, 1dip)
		xcvsChart.DrawLine(x0, y1, x1, y1, xui.Color_DarkGray, 1dip)
	End If
	Private xPath As B4XPath
	xPath.Initialize(x1 + 0.3 * Gantt.XInterval, y1 - 0.3 * Gantt.XInterval)
	xPath.LineTo(x1, y1)
	xPath.LineTo(x1 + 0.3 * Gantt.XInterval, y1 + 0.3 * Gantt.XInterval)
	xcvsChart.DrawPath(xPath, xui.Color_DarkGray, True, 1dip)
End Sub

Private Sub DrawTable
	InitTable
	GetColumnWidths
	DrawColumnsFixed
	DrawTasksInTable
End Sub

Private Sub DrawTasksInTable
	Private j, row As Int
	Private xt, x1, x2, yt, yt2, y1, y2, yl, OffsetX As Int
	Private txt As String
	
	OffsetX = FixedTaskTable.Left - ZoomH(ChartIndex).BeginIndex

	If Gantt.Title <> "" Then
		xcvsChart.DrawText(Gantt.Title, Gantt.Left + Gantt.Width / 2, 1.4 * Texts.TitleTextHeight, Texts.TitleFont, Texts.TitleTextColor, "CENTER")
	End If
	If Gantt.SubTitle <> "" Then
		xcvsChart.DrawText(Gantt.SubTitle, Gantt.Left + Gantt.Width / 2, Gantt.Top - 0.6 * Texts.SubTitleTextHeight, Texts.SubTitleFont, Texts.SubTitleTextColor, "CENTER")
	End If
	
	xcvsChart.ClipPath(Gantt.CalendarPath)

	For j = 0 To ZoomV.EndIndex - ZoomV.BeginIndex + 3
		yl = Gantt.Top + j * Gantt.YInterval
		If j <> 1 Or Gantt.DisplayType = "GANTT" Then
			xcvsChart.DrawLine(Gantt.Left, yl, Gantt.Right, yl, Gantt.GridColor, 1dip)
		End If
	Next
	For col = 3 To TableColumnLeft.Length - 1
		xcvsChart.DrawLine(OffsetX + TableColumnLeft(col), Gantt.Top, OffsetX + TableColumnLeft(col), Gantt.Bottom, Gantt.GridColor, 1dip)
	Next
	xcvsChart.DrawLine(Gantt.Right, Gantt.Top, Gantt.Right, Gantt.Bottom, Gantt.GridColor, 1dip)
	
	yt = Gantt.Top + Gantt.YInterval - 0.5 * Texts.TaskTextHeight
	yt2 = Gantt.Top + 2 * Gantt.YInterval - 0.5 * Texts.TaskTextHeight
	xt = OffsetX + TableColumnLeft(3) + Texts.TaskTextHeight
	xcvsChart.DrawText("Responsible", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt = OffsetX + TableColumnLeft(4) + Texts.TaskTextHeight
	xcvsChart.DrawText("Begin date", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt= OffsetX + TableColumnLeft(5) + Texts.TaskTextHeight
	xcvsChart.DrawText("End date", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt = OffsetX + TableColumnLeft(6) + Texts.TaskTextHeight
	xcvsChart.DrawText("Duration", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt = OffsetX + TableColumnLeft(7) + Texts.TaskTextHeight
	xcvsChart.DrawText("Completion", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt = OffsetX + TableColumnLeft(8) + Texts.TaskTextHeight
	xcvsChart.DrawText("Color", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	xt = OffsetX + TableColumnLeft(9) + Texts.TaskTextHeight
	xcvsChart.DrawText("Dependency", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
'	xt = TaskTable.Left + TableColumnLeft(8) + Texts.TaskTextHeight
	xt = OffsetX + TableColumnLeft(10) + TableColumnWidth(10) / 2
	xcvsChart.DrawText("Predecessor", xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "CENTER")
	xcvsChart.DrawText("ID", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "CENTER")
	xt = OffsetX + TableColumnLeft(11) + TableColumnWidth(11) / 2
	xcvsChart.DrawText("Lag", xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "CENTER")
	xcvsChart.DrawText("Lead", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "CENTER")
	xt = OffsetX + TableColumnLeft(12) + Texts.TaskTextHeight
	xcvsChart.DrawText("Successor IDs", xt, yt2, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
	
'	For row = 0 To Tasks.Size - 1
	For row = ZoomV.BeginIndex To ZoomV.EndIndex
		Private TD As GanttTaskData
		
		j = row - ZoomV.BeginIndex + 1
		
		TD = Tasks.Get(row)
		yt = Gantt.Top + (j + 2) * Gantt.YInterval - 0.5 * Texts.TaskTextHeight
		xt = OffsetX + TableColumnLeft(3) + Texts.TaskTextHeight
		xcvsChart.DrawText(TD.Responsible, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
		xt = OffsetX + TableColumnLeft(4) + Texts.TaskTextHeight
		xcvsChart.DrawText(TD.BeginDate, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
		xt = OffsetX + TableColumnLeft(5) + Texts.TaskTextHeight
		xcvsChart.DrawText(TD.EndDate, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
		xt = OffsetX + TableColumnLeft(6) + TableColumnWidth(6) / 2 + Texts.TaskTextHeight
		xcvsChart.DrawText(TD.Duration, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "RIGHT")
		xt = OffsetX + TableColumnLeft(7) + TableColumnWidth(7) / 1.5	'???
		xcvsChart.DrawText(TD.Completion & " %", xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "RIGHT")
		Private rect As B4XRect
		x1 = OffsetX + TableColumnLeft(8) + Texts.TaskTextHeight
		x2 = OffsetX + TableColumnLeft(8) + TableColumnWidth(8) - Texts.TaskTextHeight
		y1 = Gantt.Top + (j + 1) * Gantt.YInterval + 0.25 * Gantt.YInterval
		y2 = y1 + 0.6 * Gantt.YInterval
		rect.Initialize(x1, y1, x2, y2)
		xcvsChart.DrawRect(rect, TD.Color, True, 1dip)
		xt = OffsetX + TableColumnLeft(9) + TableColumnWidth(9) / 2
		xcvsChart.DrawText(TD.Dependency, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "CENTER")
		xt = OffsetX + TableColumnLeft(10) + TableColumnWidth(10) / 2
		xcvsChart.DrawText(TD.PredecessorID, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "CENTER")
		If TD.LagLead <> 0 Then
			xt = OffsetX + TableColumnLeft(11) + (TableColumnWidth(11) + Texts.TaskTextHeight) / 2
			xcvsChart.DrawText(TD.LagLead, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "RIGHT")
		End If
		If TD.SuccessorIDs.Size > 0 Then
			xt = OffsetX + TableColumnLeft(12) + Texts.TaskTextHeight
			txt = TD.SuccessorIDs.Get(0)
			For i = 1 To TD.SuccessorIDs.Size - 1
				txt = txt & " / " & TD.SuccessorIDs.Get(i)
			Next
			xcvsChart.DrawText(txt, xt, yt, Texts.CalendarFont, Texts.CalendarTextColor, "LEFT")
		End If
	Next
	xcvsChart.RemoveClip
	xcvsChart.Invalidate
End Sub

Private Sub GetColumnWidths
	Private TableColumnWidth(13) As Int
	Private TableColumnLeft(TableColumnWidth.Length + 1) As Int
	Private i, row, col As Int
	
	TableColumnWidth(0) = Max(MeasureTextWidth("Row", Texts.TaskDataFont), MeasureTextWidth((Tasks.Size - 1), Texts.TaskDataFont))
	TableColumnLeft(0) = 0
	TableColumnWidth(1) = MeasureTextWidth("ID", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(1) = Max(TableColumnWidth(1), MeasureTextWidth(TD.ID, Texts.TaskDataFont))
	Next
	TableColumnWidth(2) = MeasureTextWidth("Name", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(2) = Max(TableColumnWidth(2), MeasureTextWidth(TD.Name, Texts.TaskDataFont))
	Next
	TableColumnWidth(3) = MeasureTextWidth("Responsible", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(3) = Max(TableColumnWidth(3), MeasureTextWidth(TD.Responsible, Texts.TaskDataFont))
	Next
	TableColumnWidth(4) = MeasureTextWidth("Begin date", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(4) = Max(TableColumnWidth(4), MeasureTextWidth(TD.BeginDate, Texts.TaskDataFont))
	Next
	TableColumnWidth(5) = MeasureTextWidth("End date", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(5) = Max(TableColumnWidth(5), MeasureTextWidth(TD.EndDate, Texts.TaskDataFont))
	Next
	TableColumnWidth(6) = MeasureTextWidth("Duration", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(6) = Max(TableColumnWidth(6), MeasureTextWidth(TD.Duration, Texts.TaskDataFont))
	Next
	TableColumnWidth(7) = MeasureTextWidth("Completion", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(7) = Max(TableColumnWidth(7), MeasureTextWidth(TD.Completion, Texts.TaskDataFont))
	Next
	TableColumnWidth(8) = MeasureTextWidth("Color", Texts.TaskDataFont)
'	For row = 0 To Tasks.Size - 1
'		Private TD As GanttTaskData
'		TD = Tasks.Get(row)
'		TableColumnWidth(8) = Max(TableColumnWidth(8), MeasureTextWidth(TD.Duration, Texts.TaskDataFont))
'	Next
	TableColumnWidth(9) = MeasureTextWidth("Dependency", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(9) = Max(TableColumnWidth(9), MeasureTextWidth(TD.Dependency, Texts.TaskDataFont))
	Next
	TableColumnWidth(10) = MeasureTextWidth("Predecessor", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(10) = Max(TableColumnWidth(10), MeasureTextWidth(TD.PredecessorID, Texts.TaskDataFont))
	Next
	TableColumnWidth(11) = MeasureTextWidth("Lead", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(row)
		TableColumnWidth(11) = Max(TableColumnWidth(11), MeasureTextWidth(TD.LagLead, Texts.TaskDataFont))
	Next
	TableColumnWidth(12) = MeasureTextWidth("Successor IDs", Texts.TaskDataFont)
	For row = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		Private txt As String
		TD = Tasks.Get(row)
		If TD.SuccessorIDs.Size > 0 Then
			txt = TD.SuccessorIDs.Get(0)
			For i = 1 To TD.SuccessorIDs.Size - 1
				txt = txt & " / " & TD.SuccessorIDs.Get(i)
			Next
			TableColumnWidth(12) = Max(TableColumnWidth(12), MeasureTextWidth(txt, Texts.TaskDataFont))
		End If
	Next
	For col = 0 To TableColumnWidth.Length - 1
		TableColumnWidth(col) = TableColumnWidth(col) + 2 * Texts.TaskTextHeight
		TableColumnLeft(col + 1) = TableColumnLeft(col) + TableColumnWidth(col)
	Next
	FixedTaskTable.Width = TableColumnLeft(3)
	FixedTaskTable.Right = FixedTaskTable.Left + FixedTaskTable.Width
	If Gantt.DisplayType = "TABLE" Then
		Gantt.Duration = TableColumnLeft(TableColumnLeft.Length - 1) - TableColumnLeft(3)
		Gantt.XInterval = 1
	End If
End Sub

Private Sub CalcBeginDate(TDC As GanttTaskData) As String
	Private TDP As GanttTaskData
	Private iP As Int
	Private DateTicks As Long
	
	iP = TaskIDs.IndexOf(TDC.PredecessorID) - 1
	TDP = Tasks.Get(iP)
	
	Private Per As Period
	If TDC.Dependency = "FS" Then
		DateTicks = TDP.EndTicks
	Else If TDC.Dependency = "SS" Then
		DateTicks = TDP.BeginTicks
		Per.Days = -1
		DateTicks = DateUtils.AddPeriod(DateTicks, Per)
	End If
	
	If TDC.LagLead = 0 Then
		If DateTime.GetDayOfWeek(DateTicks) = 6 Then 'Saturday
			Per.Days = 3	'Add two days
		Else
			Per.Days = 1	'Next day
		End If
		DateTicks = DateUtils.AddPeriod(DateTicks, Per)
	Else
		If TDC.LagLead > 0 Then
			Per.Days = 1
			DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			For i = 0 To TDC.LagLead - 1
				Select DateTime.GetDayOfWeek(DateTicks)
					Case 7	'Saturday
						Per.Days = 3
					Case 1	'Sunday
						Per.Days = 2
					Case Else
						Per.Days = 1
				End Select
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			Next
			If DateTime.GetDayOfWeek(DateTicks) = 7 Then 'Saturday
				Per.Days = 2	'Add two days
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			End If
		Else
			For i = 1 To Abs(TDC.LagLead) - 1
				Select DateTime.GetDayOfWeek(DateTicks)
					Case 7	'Saturday
						Per.Days = -2
					Case 1	'Sunday
						Per.Days = -3
					Case Else
						Per.Days = -1
				End Select
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			Next
			If DateTime.GetDayOfWeek(DateTicks) = 1 Then 'Sunday
				Per.Days = -2	'Add two days
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			End If
		End If
	End If

	Return DateTime.Date(DateTicks)
End Sub

'Gets the End and Begin date for FinishToFinish dependency.
'Only the duration is taken into account.
Private Sub GetEndAndBeginDate(TDC As GanttTaskData)
	Private TDP As GanttTaskData
	Private iP As Int
	Private DateTicks As Long
	
	iP = TaskIDs.IndexOf(TDC.PredecessorID) - 1
	TDP = Tasks.Get(iP)

	Private Per As Period
	If TDC.Dependency = "FF" Then
		DateTicks = TDP.EndTicks
	Else If TDC.Dependency = "SF" Then
		DateTicks = TDP.BeginTicks
		Per.Days = -1
		DateTicks = DateUtils.AddPeriod(DateTicks, Per)
	End If
'	DateTicks = TDP.EndTicks
	
	If TDC.LagLead = 0 Then
		TDC.EndDate = TDP.EndDate
	Else
		If TDC.LagLead > 0 Then
			For i = 0 To TDC.LagLead - 1
				Select DateTime.GetDayOfWeek(DateTicks)
					Case 7	'Saturday
						Per.Days = 3
					Case 1	'Sunday
						Per.Days = 2
					Case Else
						Per.Days = 1
				End Select
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			Next
			If DateTime.GetDayOfWeek(DateTicks) = 7 Then 'Saturday
				Per.Days = 2	'Add two days
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			End If
		Else
			For i = 0 To Abs(TDC.LagLead) - 1
				Log(DateTime.GetDayOfWeek(DateTicks))
				Select DateTime.GetDayOfWeek(DateTicks)
					Case 7	'Saturday
						Per.Days = -2
					Case 1	'Sunday
						Per.Days = -3
					Case Else
						Per.Days = -1
				End Select
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			Next
			If DateTime.GetDayOfWeek(DateTicks) = 1 Then 'Sunday
				Per.Days = -2	'Add two days
				DateTicks = DateUtils.AddPeriod(DateTicks, Per)
			End If
		End If
		TDC.EndDate = DateTime.Date(DateTicks)
	End If
'	If TDC.LagLead = 0 Then
'		TDC.EndDate = TDP.EndDate
	For i = 0 To TDC.Duration - 2
			If DateTime.GetDayOfWeek(DateTicks) = 2 Then 'Monday
				Per.Days = -3	'Substract two days
			Else
				Per.Days = -1	'Previous day
			End If
			DateTicks = DateUtils.AddPeriod(DateTicks, Per)			
		Next
'	Else
		
'	End If

	TDC.BeginDate = DateTime.Date(DateTicks)
	SetBeginEndTicks
End Sub

'Gets the Begin and End date for StartToStart dependency.
'Only the duration is taken into account.
Private Sub GetBeginAndEndDate(TDC As GanttTaskData)
	Private TDP As GanttTaskData
	Private iP As Int
	
	iP = TaskIDs.IndexOf(TDC.PredecessorID) - 1
	TDP = Tasks.Get(iP)

	If TDC.LagLead = 0 Then
		TDC.BeginDate = TDP.BeginDate
	Else
		TDC.BeginDate = CalcBeginDate(TDC)
	End If
	CalcEndDate(TDC)
End Sub

Private Sub CalcEndDate(Task As GanttTaskData)
	Private i As Int
	Private CurrentTicks As Long
	
	CurrentTicks = DateTime.DateParse(Task.BeginDate) - DateTime.TicksPerDay
	Do Until i = Task.Duration
		CurrentTicks = CurrentTicks + DateTime.TicksPerDay
		If DateTime.GetDayOfWeek(CurrentTicks) > 1 And DateTime.GetDayOfWeek(CurrentTicks) < 7 Then
			i = i + 1
		End If
	Loop
	
	Task.EndTicks = CurrentTicks
	Task.EndDate = DateTime.Date(CurrentTicks)
End Sub

'Sets the Begin and End ticks of the entire chart
Private Sub SetBeginEndTicks	'???? à mettre dans AddTask
	Private i As Int
	
	Private TD As GanttTaskData
	TD = Tasks.Get(0)
	
	Gantt.BeginTicks = TD.BeginTicks
	Gantt.EndTicks = TD.EndTicks
	For i = 1 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(i)
		If TD.BeginTicks < Gantt.BeginTicks Then
			Gantt.BeginTicks = TD.BeginTicks
		End If
		
		If TD.EndTicks > Gantt.EndTicks Then
			Gantt.EndTicks = TD.EndTicks
		End If
	Next
	
	For i = 0 To Tasks.Size - 1
		Private TD As GanttTaskData
		TD = Tasks.Get(i)
		TD.BeginDayIndex = DateUtils.PeriodBetweenInDays(Gantt.BeginTicks, TD.BeginTicks).Days
		TD.EndDayIndex = DateUtils.PeriodBetweenInDays(Gantt.BeginTicks, TD.EndTicks).Days
	Next
	
	Gantt.Duration = DateUtils.PeriodBetweenInDays(Gantt.BeginTicks, Gantt.EndTicks).Days + 1
End Sub

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
	Return rct.Width
End Sub

Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int
	Private rct As B4XRect
	rct = xcvsCursor.MeasureText(Text, Font1)
'	Return rct.Width
	Return rct.Height
End Sub

'returns white for a dark color or returns black for a light color for a good contrast between background and text colors
Private Sub GetContrastColor(Color As Int) As Int
	Private a, r, g, b, yiq As Int	'ignore
	
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
	
	yiq = r * 0.299 + g * 0.587 + b * 0.114
	
	If yiq > 128 Then
		Return xui.Color_RGB(100, 100, 100)
	Else
		Return xui.Color_RGB(200, 200, 200)
	End If
End Sub

'Returns a color with the given alpha value
Private Sub SetColorAlpha(Color As Int, Alpha As Int) As Int
	Private a, r, g, b, yiq As Int	'ignore
	
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	b = Bit.And(Color, 0xff)
	
	Return xui.Color_ARGB(Alpha, r, g, b)
End Sub

'Returns a color with the given alpha value
'Completion in %, values berween 0 and 100
Public Sub SetCompletion(TaskID As String, Completion As Int)
	Private TD As GanttTaskData
	Private TaskIndex As Int
	
	TaskIndex = TaskIDs.IndexOf(TaskID) - 1
	If TaskIndex >= 0 Then
		TD = Tasks.Get(TaskIndex)
		TD.Completion = Completion
	Else
		LogColor("Wrong ID", xui.Color_Red)
	End If
End Sub

Private Sub xpnlCursor_Touch (Action As Int, X As Float, Y As Float)
	If Action = 100 Then
		Return
	End If
	
	xcvsCursor.ClearRect(xcvsCursor.TargetRect)
	
	Select Gantt.DisplayType
		Case "GANTT"
			CursorTouchGantt(Action, X, Y)
		Case "TABLE"
			CursorTouchTable(Action, X, Y)
	End Select
End Sub

Private Sub CursorTouchGantt(Action As Int, X As Float, Y As Float)
	Private CurrentDayTicks As Long
	
	If x > FixedTaskTable.Left And X < FixedTaskTable.Right And Y > Gantt.CalendarDaysRect.Bottom And Y < Gantt.Bottom Then
		'Task table area
		X = Max(X, FixedTaskTable.Left)
		X = Min(X, FixedTaskTable.Right)
		Y = Max(Y, Gantt.Top)
		Y = Min(Y, Gantt.Bottom)
		CurrentTaskIndex = Max(0, (Y - Gantt.GraphRect.Top) / Gantt.YInterval + ZoomV.BeginIndex)
		CurrentTaskIndex = Min(CurrentTaskIndex, Tasks.Size - 1)
		Select Action
			Case xpnlCursor.TOUCH_ACTION_DOWN
				TimerTaskLongClick.Enabled = True
				CursorX0 = X
				CursorY0 = y
				DrawTaskData(CurrentTaskIndex, X, Y)
			Case xpnlCursor.TOUCH_ACTION_MOVE
				DrawTaskData(CurrentTaskIndex, X, Y)
				If Abs(X - CursorX0) > CursorClickLimit Or Abs(Y - CursorY0) > CursorClickLimit Then
					TimerTaskLongClick.Enabled = False
				End If
			Case xpnlCursor.TOUCH_ACTION_UP
				xpnlValues.Visible = False
				TimerTaskLongClick.Enabled = False
		End Select
	Else If x > Gantt.Left And X < Gantt.Right And Y > Gantt.CalendarDaysRect.Bottom And Y < Gantt.Bottom Then
		'Calendar area
		X = Max(X, Gantt.Left)
		X = Min(X, Gantt.Right)
		Y = Max(Y, Gantt.Top)
		Y = Min(Y, Gantt.Bottom)
		CurrentTaskIndex = Max(0, (Y - Gantt.GraphRect.Top) / Gantt.YInterval + ZoomV.BeginIndex)
		CurrentTaskIndex = Min(CurrentTaskIndex, Tasks.Size - 1)
		CurrentDayIndex = (X - Gantt.Left) / Gantt.XInterval + ZoomH(ChartIndex).BeginIndex
		CurrentDayTicks = Gantt.BeginTicks + CurrentDayIndex * DateTime.TicksPerDay
		CurrentDay2 = MonthNamesLong(DateTime.GetMonth(CurrentDayTicks)) & "  " & DateTime.GetDayOfMonth(CurrentDayTicks)
		Select Action
			Case xpnlCursor.TOUCH_ACTION_DOWN, xpnlCursor.TOUCH_ACTION_MOVE
				DrawTaskData(CurrentTaskIndex, X, Y)
			Case xpnlCursor.TOUCH_ACTION_UP
				xpnlValues.Visible = False
		End Select
	Else If x > Gantt.Left And X < Gantt.Right And Y > Gantt.CalendarDaysRect.Top And Y < Gantt.CalendarDaysRect.Bottom Then
		'Days area
		CurrentDayIndex = (X - Gantt.Left) / Gantt.XInterval + ZoomH(ChartIndex).BeginIndex
		CurrentDayTicks = Gantt.BeginTicks + CurrentDayIndex * DateTime.TicksPerDay
		CurrentDay1 = MonthNamesShort(DateTime.GetMonth(CurrentDayTicks)) & "  " & DateTime.GetDayOfMonth(CurrentDayTicks)
		Select Action
			Case xpnlCursor.TOUCH_ACTION_DOWN, xpnlCursor.TOUCH_ACTION_MOVE
				DrawActiveTasks(CurrentDayIndex, X, Y)
			Case xpnlCursor.TOUCH_ACTION_UP
				xpnlValues.Visible = False
		End Select
	Else
		xpnlValues.Visible = False
	End If
	
	If Action = xpnlCursor.TOUCH_ACTION_UP Then
		xcvsCursor.ClearRect(xcvsCursor.TargetRect)
		xcvsCursor.Invalidate
	End If
End Sub

Private Sub CursorTouchTable(Action As Int, X As Float, Y As Float)
	If x > FixedTaskTable.Left And X < Gantt.Right And Y > Gantt.CalendarDaysRect.Bottom And Y < Gantt.Bottom Then
		X = Max(X, Gantt.Left)
		X = Min(X, Gantt.Right)
		Y = Max(Y, Gantt.Top)
		Y = Min(Y, Gantt.Bottom)
		CurrentTaskIndex = Max(0, (Y - Gantt.GraphRect.Top) / Gantt.YInterval + ZoomV.BeginIndex)
		CurrentTaskIndex = Min(CurrentTaskIndex, Tasks.Size - 1)
		Select Action
			Case xpnlCursor.TOUCH_ACTION_DOWN
				TimerTaskLongClick.Enabled = True
				CursorX0 = X
				CursorY0 = y
				DrawHCursor(Y)
			Case xpnlCursor.TOUCH_ACTION_MOVE
				DrawHCursor(Y)
				If Abs(X - CursorX0) > CursorClickLimit Or Abs(Y - CursorY0) > CursorClickLimit Then
					TimerTaskLongClick.Enabled = False
				End If
			Case xpnlCursor.TOUCH_ACTION_UP
				xpnlValues.Visible = False
				TimerTaskLongClick.Enabled = False
		End Select
	End If
End Sub

Private Sub DrawHCursor(y As Int)
	Private rectCursorH As B4XRect
	Private TD As GanttTaskData
	Private y0 As Int
	
	TD = Tasks.Get(CurrentTaskIndex)
	y0 = (Y - Gantt.Top) / Gantt.YInterval
	y0 = y0 * Gantt.YInterval + Gantt.Top
	rectCursorH.Initialize(FixedTaskTable.Left, y0, Gantt.Right, y0 + Gantt.YInterval)
	xcvsCursor.DrawRect(rectCursorH, SetColorAlpha(TD.Color, mAlphaCursorH), True, 1dip)
	xcvsCursor.DrawRect(rectCursorH, xui.Color_Red, False, 1dip)
	xcvsCursor.Invalidate
End Sub

Private Sub TimerTaskLongClick_Tick
	Gantt.EditOldDisplay= Gantt.DisplayType
	TimerTaskLongClick.Enabled = False
	If xui.SubExists(mCallBack, mEventName & "_TaskLongClick", 1) Then
		CallSub2(mCallBack, mEventName & "_TaskLongClick", Tasks.Get(CurrentTaskIndex))
	End If
End Sub

Private Sub xpnlZoomBarH_Touch (Action As Int, X As Float, Y As Float)
	Private IndexBegin As Int
	
	If Action = 100 Then
		Return
	End If
	
	Select Action
		Case xpnlZoomBarH.TOUCH_ACTION_DOWN
			If X > 0 And X < ZoomH(ChartIndex).ButtonLength Then
				IndexBegin = Max(0, ZoomH(ChartIndex).BeginIndex - 1)
				ZoomH(ChartIndex).CursorOn = False
			Else If X > ZoomH(ChartIndex).BarLength - ZoomH(ChartIndex).ButtonLength And X < ZoomH(ChartIndex).BarLength Then
				ZoomH(ChartIndex).EndIndex = Min(ZoomH(ChartIndex).EndIndex + 1, Gantt.Duration - 1)
				IndexBegin = ZoomH(ChartIndex).EndIndex - Gantt.XNbIntervals + 1
				ZoomH(ChartIndex).CursorOn = False
			Else If X > ZoomH(ChartIndex).ButtonLength And X < ZoomH(ChartIndex).CursorBegin Then
				IndexBegin = Max(0, ZoomH(ChartIndex).BeginIndex - 7)
				ZoomH(ChartIndex).CursorOn = False
			Else If X > ZoomH(ChartIndex).CursorBegin + ZoomH(ChartIndex).CursorLength And X < ZoomH(ChartIndex).BarLength - ZoomH(ChartIndex).ButtonLength Then
				IndexBegin = Min(ZoomH(ChartIndex).BeginIndex + 7, Gantt.Duration - Gantt.XNbIntervals)
				ZoomH(ChartIndex).CursorOn = False
			Else
				IndexBegin = ZoomH(ChartIndex).BeginIndex
				ZoomH(ChartIndex).CursorOn = True
			End If
			ZoomH(ChartIndex).Cursor0 = X
			ZoomH(ChartIndex).CursorBegin0 = ZoomH(ChartIndex).CursorBegin

			If IndexBegin <> ZoomH(ChartIndex).BeginIndex Then
				ZoomH(ChartIndex).BeginIndex = IndexBegin
				ZoomH(ChartIndex).EndIndex = ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1
				DrawChart
				ZoomCursorDrawH
			End If
		Case xpnlZoomBarH.TOUCH_ACTION_MOVE
			If ZoomH(ChartIndex).CursorOn = True Then
				ZoomH(ChartIndex).CursorBegin = Min(ZoomH(ChartIndex).CursorBegin0 + X - ZoomH(ChartIndex).Cursor0, ZoomH(ChartIndex).BarLength - ZoomH(ChartIndex).ButtonLength - ZoomH(ChartIndex).CursorLength + 10)
				ZoomH(ChartIndex).CursorBegin = Max(ZoomH(ChartIndex).CursorBegin, ZoomH(ChartIndex).ButtonLength)
				IndexBegin = (ZoomH(ChartIndex).CursorBegin - ZoomH(ChartIndex).ButtonLength) / (ZoomH(ChartIndex).BarLength - 2 * ZoomH(ChartIndex).ButtonLength - ZoomH(ChartIndex).CursorLength) * (Gantt.Duration - Gantt.XNbIntervals + 1) + 0.5
				IndexBegin = Min(IndexBegin, Gantt.Duration - Gantt.XNbIntervals)
				If IndexBegin <> ZoomH(ChartIndex).BeginIndex Then
					ZoomH(ChartIndex).BeginIndex = IndexBegin
					ZoomH(ChartIndex).EndIndex = ZoomH(ChartIndex).BeginIndex + Gantt.XNbIntervals - 1
					DrawChart
					ZoomCursorDrawH
				Else
'					If ZoomH.BeginIndex = 0 And X < ZoomH.CursorBegin0 Then
'						ZoomH.Cursor0 = X
'					End If
'					If ZoomH.EndIndex = Gantt.Duration - 1 And X > ZoomH.CursorBegin0 Then
'						ZoomH.Cursor0 = ZoomH.BarWidth - ZoomH.ButtonLength - ZoomH.CursorLength
'					End If
				End If
			End If
		Case xpnlZoomBarH.TOUCH_ACTION_UP
			ZoomH(ChartIndex).CursorOn = False
	End Select
End Sub

Private Sub xpnlZoomBarV_Touch (Action As Int, X As Float, Y As Float)
	Private IndexBegin As Int
	
	If Action = 100 Then
		Return
	End If
	
	Zooming = False
	Select Action
		Case xpnlCursor.TOUCH_ACTION_DOWN
			If Y > 0 And Y < ZoomV.ButtonLength Then
				IndexBegin = Max(0, ZoomV.BeginIndex - 1)
				ZoomV.CursorOn = False
			Else If Y > ZoomV.BarLength - ZoomV.ButtonLength And Y < ZoomV.BarLength Then
				ZoomV.EndIndex = Min(ZoomV.EndIndex + 1, Tasks.Size - 1)
				IndexBegin = ZoomV.EndIndex - Gantt.YNbIntervals + 1
				ZoomV.CursorOn = False
			Else If Y > ZoomV.ButtonLength And Y < ZoomV.CursorBegin Then
				IndexBegin = Max(0, ZoomV.BeginIndex - 5)
				ZoomV.CursorOn = False
			Else If Y > ZoomV.CursorBegin + ZoomV.CursorLength And Y < ZoomV.BarLength - ZoomV.ButtonLength Then
				IndexBegin = Min(ZoomV.BeginIndex + 5, Tasks.Size - Gantt.YNbIntervals)
				ZoomV.CursorOn = False
			Else
				IndexBegin = ZoomV.BeginIndex
				ZoomV.CursorOn = True
			End If
			ZoomV.Cursor0 = Y
			ZoomV.CursorBegin0 = ZoomV.CursorBegin

			If IndexBegin <> ZoomV.BeginIndex Then
				ZoomV.BeginIndex = IndexBegin
				ZoomV.EndIndex = ZoomV.BeginIndex + Gantt.YNbIntervals - 1
				Zooming = True
				DrawChart
				ZoomCursorDrawH
				Zooming = False
			End If
		Case xpnlCursor.TOUCH_ACTION_MOVE
			If ZoomV.CursorOn = True Then
				ZoomV.CursorBegin = Min(ZoomV.CursorBegin0 + Y - ZoomV.Cursor0, ZoomV.BarLength - ZoomV.ButtonLength - ZoomV.CursorLength + 10)
				ZoomV.CursorBegin = Max(ZoomV.CursorBegin, ZoomV.ButtonLength)
				IndexBegin = (ZoomV.CursorBegin - ZoomV.ButtonLength) / (ZoomV.BarLength - 2 * ZoomV.ButtonLength - ZoomV.CursorLength) * (Tasks.Size - Gantt.YNbIntervals + 1) + 0.5
				IndexBegin = Min(IndexBegin, Tasks.Size - Gantt.YNbIntervals)
				If IndexBegin <> ZoomV.BeginIndex Then
					ZoomV.BeginIndex = IndexBegin
					ZoomV.EndIndex = ZoomV.BeginIndex + Gantt.YNbIntervals - 1
					Zooming = True
					DrawChart
					ZoomCursorDrawH
					Zooming = False
				End If
			End If
		Case xpnlCursor.TOUCH_ACTION_UP
			ZoomV.CursorOn = False
	End Select
End Sub

'Private Sub btnTaskEditClear_Click
'	edtTaskID.Text = ""
'	edtTaskName.Text = ""
'	edtTaskResponsible.Text = ""
'	edtTaskBeginDate.Text = ""
'	lblTaskEndDate.Text = ""
'	edtTaskDuration.Text = 0
'	edtTaskCompletion.Text = 0
'	xcbxTaskDependency_SelectedIndexChanged(0)
'	xcbxTaskDependency.SelectedIndex = 0
'	xcbxTaskPredecessorID_SelectedIndexChanged(0)
'	xcbxTaskPredecessorID.SelectedIndex = 0
'	edtTaskLagLead.Text = 0
'	lblTaskPredecessorID.Visible = True
'	xcbxTaskPredecessorID.mBase.Visible = True
'	lblTaskLagLead.Visible = True
'	edtTaskLagLead.Visible = True
'	edtTaskBeginDate.Enabled = True
'	btnTaskEditUpdate.Visible = False
'	btnTaskEditDelete.Visible = False
'End Sub

'Private Sub btnTaskEditUpdate_Click
'	TaskToEdit.ID = edtTaskID.Text
'	TaskToEdit.Name = edtTaskName.Text
'	TaskToEdit.Responsible = edtTaskResponsible.Text
'	TaskToEdit.BeginDate = edtTaskBeginDate.Text
'	TaskToEdit.Duration = edtTaskDuration.Text
'	TaskToEdit.Duration = Abs(TaskToEdit.Duration)
'	TaskToEdit.Completion = edtTaskCompletion.Text
'	TaskToEdit.Completion = Max(TaskToEdit.Completion, 0)
'	TaskToEdit.Completion = Min(TaskToEdit.Completion, 100)
'	TaskToEdit.Color = xcpkTaskColor.Color
'	TaskToEdit.Dependency = lstDependenciesShort.Get(xcbxTaskDependency.SelectedIndex)
'	TaskToEdit.PredecessorID = xcbxTaskPredecessorID.SelectedItem
'	TaskToEdit.LagLead = edtTaskLagLead.Text
'	Tasks.Set(CurrentTaskIndex, TaskToEdit)
'	EditFillTasks
'	
'	Tasks.Set(CurrentTaskIndex, TaskToEdit)
'	TaskCalculateParameters(TaskToEdit)
'	TaskUpdateDependencies(TaskToEdit)
'End Sub

'Private Sub btnTaskEditAdd_Click
'	If AddTask(edtTaskID.Text, edtTaskName.Text, edtTaskResponsible.Text, edtTaskBeginDate.Text, edtTaskDuration.Text, lstDependenciesShort.Get(xcbxTaskDependency.SelectedIndex), xcbxTaskPredecessorID.SelectedItem, edtTaskLagLead.Text, xcpkTaskColor.Color) = False Then
'		CurrentTaskIndex = Tasks.Size - 1
'		EditFillTasks
'		TaskToEdit = Tasks.Get(CurrentTaskIndex)
'	End If
'End Sub

'Private Sub btnTaskEditInsertAt_Click
'	If TaskInsertAt(CurrentTaskIndex, edtTaskID.Text, edtTaskName.Text, edtTaskResponsible.Text, edtTaskBeginDate.Text, edtTaskDuration.Text, lstDependenciesShort.Get(xcbxTaskDependency.SelectedIndex), xcbxTaskPredecessorID.SelectedItem, edtTaskLagLead.Text, xcpkTaskColor.Color) = False Then
'		TaskToEdit = Tasks.Get(CurrentTaskIndex)
'		EditFillTasks
'	End If
'End Sub

'Private Sub btnTaskEditDelete_Click
'	xui.Msgbox2Async("Do you really want to delete this task?", "Delete task", "Yes", "", "No", Null)
'	Wait For Msgbox_Result (Result As Int)
'	If Result = xui.DialogResponse_Positive Then
'		'Remove this task as successor from the predecessor task
'		If TaskToEdit.PredecessorID <> "None" And TaskToEdit.SuccessorIDs.Size = 0 Then
'			Private PreTask As GanttTaskData
'			Private PreTaskIndex, SuccessorIndex As Int
'			PreTaskIndex = TaskIDs.IndexOf(TaskToEdit.PredecessorID) - 1
'			PreTask = Tasks.Get(PreTaskIndex)
'			SuccessorIndex = PreTask.SuccessorIDs.IndexOf(TaskToEdit.ID)
'			PreTask.SuccessorIDs.RemoveAt(SuccessorIndex)
'		Else If TaskToEdit.PredecessorID <> "None" And TaskToEdit.SuccessorIDs.Size > 0 Then
'			xui.Msgbox2Async("This task has a prededecessor and a successor." & CRLF & "Do you want to join predecessor and successor?", "Join tasks", "Yes", "", "No", Null)
'			Wait For Msgbox_Result (Result As Int)
'			If Result = xui.DialogResponse_Positive Then
'				Private PredecessorTask, SuccessorTask As GanttTaskData
'				Private PredecessorTaskIndex, SuccessorIndex As Int
'				PredecessorTaskIndex = TaskIDs.IndexOf(TaskToEdit.PredecessorID) - 1
'				PredecessorTask = Tasks.Get(PredecessorTaskIndex)
'				For i = 0 To TaskToEdit.SuccessorIDs.Size - 1
'					SuccessorIndex = TaskIDs.IndexOf(TaskToEdit.SuccessorIDs.Get(i)) - 1
'					SuccessorTask = Tasks.Get(SuccessorIndex)
'					SuccessorTask.PredecessorID = PredecessorTask.PredecessorID
'					PredecessorTask.SuccessorIDs.Add(SuccessorTask.ID)
'				Next
'			End If
'		End If
'		
'		Tasks.RemoveAt(CurrentTaskIndex)
'		TaskIDs.RemoveAt(CurrentTaskIndex + 1)
''		If CurrentTaskIndex > 1 Then
'	'		CurrentTaskIndex = CurrentTaskIndex - 1
''		Else 
''			CurrentTaskIndex = CurrentTaskIndex + 1	'???
''		End If
'		TaskToEdit = Tasks.Get(CurrentTaskIndex)
'		EditFillTasks
'		EditUpdate
'	End If
'End Sub

'Private Sub btnTaskEditUp_Click
'	CurrentTaskIndex = Max(CurrentTaskIndex - 1, 0)
'	xcbxTaskToEdit.SelectedIndex = CurrentTaskIndex
'	xcbxTaskToEdit_SelectedIndexChanged(CurrentTaskIndex)
'End Sub

'Private Sub btnTaskEditDown_Click
'	CurrentTaskIndex = Min(CurrentTaskIndex + 1, Tasks.Size - 1)
'	xcbxTaskToEdit.SelectedIndex = CurrentTaskIndex
'	xcbxTaskToEdit_SelectedIndexChanged(CurrentTaskIndex)
'End Sub

'Private Sub xcbxTaskToEdit_SelectedIndexChanged (Index As Int)
'	CurrentTaskIndex = Index
'	TaskToEdit = Tasks.Get(CurrentTaskIndex)
'	EditUpdate
'End Sub

'Private Sub xcbxTaskDependency_SelectedIndexChanged (Index As Int)
'	If Index = 0 Then
'		lblTaskPredecessorID.Visible = False
'		xcbxTaskPredecessorID.mBase.Visible = False
'		lblTaskLagLead.Visible = False
'		edtTaskLagLead.Visible = False
'		edtTaskBeginDate.Enabled = True
'	Else
'		lblTaskPredecessorID.Visible = True
'		xcbxTaskPredecessorID.mBase.Visible = True
'		lblTaskLagLead.Visible = True
'		edtTaskLagLead.Visible = True
'		edtTaskBeginDate.Enabled = False
'	End If
'End Sub

'Private Sub xcbxTaskPredecessorID_SelectedIndexChanged (Index As Int)
'
'End Sub

'Private Sub EditInit
'	lstDependencies.AddAll(Array As String("None", "FS  Finish to Start", "FF  Finish to Finish", "SS  Start to Start", "SF  Start to Finish"))
'	lstDependenciesShort.AddAll(Array As String("None", "FS", "FF", "SS", "SF"))
'	xcbxTaskDependency.SetItems(lstDependencies)
'End Sub

'Updates the Edit screen content

'Private Sub EditFillTasks
'	Private i As Int
'	Private lstTasks As List
'	
'	lstTasks.Initialize
'	
'	For i = 0 To Tasks.Size - 1
'		Private TD As GanttTaskData
'		TD = Tasks.Get(i)
'		lstTasks.Add("ID: " & TD.ID & "  Name: " & TD.Name)
'	Next
'
'	xcbxTaskToEdit.SetItems(lstTasks)
'	xcbxTaskPredecessorID.SetItems(TaskIDs)
'	xcbxTaskToEdit_SelectedIndexChanged(CurrentTaskIndex)
'	xcbxTaskToEdit.SelectedIndex = CurrentTaskIndex
'End Sub

'Public Sub EditClose
'	xpnlEdit.Visible = False
'	Gantt.DisplayType = Gantt.EditOldDisplay
'End Sub

'Gets or sets the Left property
Public Sub setLeft(Left As Int)
	mLeft = Left
	mBase.Left = mLeft
End Sub

Public Sub getLeft As Int
	Return mBase.Left
End Sub

'Gets or sets the Left property
Public Sub setTop(Top As Int)
	mTop = Top
	mBase.Top = mTop
End Sub

Public Sub getTop As Int
	Return mBase.Top
End Sub

'Gets or sets the Width property
Public Sub setWidth(Width As Int)
	mWidth = Width
	mBase.Width = mWidth
	If mBase.IsInitialized Then
		Base_Resize(mWidth, mHeight)
	End If
End Sub

Public Sub getWidth As Int
	Return mBase.Width
End Sub

'Gets or sets the Height property
Public Sub setHeight(Height As Int)
	mHeight = Height
	mBase.Height = mHeight
	If mBase.IsInitialized Then
		Base_Resize(mWidth, mHeight)
	End If
End Sub

Public Sub getHeight As Int
	Return mBase.Height
End Sub

'Gets or sets the Visible property
Public Sub setVisible(Visible As Boolean)
	mBase.Visible = Visible
End Sub

Public Sub getVisible As Boolean
	Return mBase.Visible
End Sub

'Gets or sets the Tag property
Public Sub setTag(Tag As Object)
	mTag = Tag
End Sub

Public Sub getTag As Int
	Return mTag
End Sub

'Gets or sets the DisplayType property
'Either GANTT or TABLE
Public Sub setDisplayType(DisplayType As String)
	Select DisplayType
		Case "GANTT", "TABLE"
			Gantt.DisplayType = DisplayType
		Case "EDIT"
			Gantt.EditOldDisplay = Gantt.DisplayType
			Gantt.DisplayType = DisplayType
		Case Else
			LogColor("Wrong valuue, must be either GANTT or TABLE", xui.Color_Red)
	End Select
End Sub

Public Sub getDisplayType As String
	Return Gantt.DisplayType
End Sub

'Gets or sets the Title property
Public Sub setTitle(Title As String)
	Gantt.Title = Title
End Sub

Public Sub getTitle As String
	Return Gantt.Title
End Sub

'Gets or sets the SubTitle property
Public Sub setSubTitle(SubTitle As String)
	Gantt.SubTitle = SubTitle
End Sub

Public Sub getSubTitle As String
	Return Gantt.SubTitle
End Sub

'Gets or sets the AutomaticTextSizes property
'The text sizes are calculated automatically depending on the chart size.
Public Sub setAutomaticTextSizes(AutomaticTextSizes As Boolean)
	Texts.AutomaticTextSizes = AutomaticTextSizes
End Sub

Public Sub getAutomaticTextSizes As Boolean
	Return Texts.AutomaticTextSizes
End Sub

'Gets or sets the DisplayTaskTable property
'Displays the list of tasks at the left of the chart.
Public Sub setDisplayTaskTable(DisplayTaskTable As Boolean)
	FixedTaskTable.Display = DisplayTaskTable
End Sub

Public Sub getDisplayTaskTable As Boolean
	Return FixedTaskTable.Display
End Sub

'Gets or sets the IgnoreCompleted property
'True: ignores the completed parameter. 
'False: Displays the Not completed part of a task with a lighter color in the Gantt chart.
Public Sub setIgnoreCompleted(IgnoreCompleted As Boolean)
	Gantt.IgnoreCompleted = IgnoreCompleted
	If Gantt.ChartIsInitialized = True Then
		DrawChart
	End If
End Sub

Public Sub getIgnoreCompleted As Boolean
	Return Gantt.IgnoreCompleted
End Sub


'Gets or sets the CalendarDisplayMode property
'Possible values: "DAY_OF_WEEK" or "DAY_OF_MONTH"
Public Sub setCalendarDisplayMode(CalendarDisplayMode As String)
	Select CalendarDisplayMode
		Case "DAY_OF_WEEK", "DAY_OF_MONTH"
			Gantt.CalendarDisplayMode = CalendarDisplayMode
		Case Else
			LogColor("Wrong value! Possible values: ""DAY_OF_WEEK"" or ""DAY_OF_MONTH""", xui.Color_Red)
	End Select
End Sub

Public Sub getCalendarDisplayMode As String
	Return Gantt.CalendarDisplayMode
End Sub

'Gets or sets the TitleTextSize property
'Setting this text size sets automatically AutomaticTextSizes = False.
Public Sub setTitleTextSize(TitleTextSize As Float)
	Texts.TitleTextSize = TitleTextSize
	Texts.TitleFont = xui.CreateDefaultFont(Texts.TitleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

Public Sub getTitleTextSize As Float
	Return Texts.TitleTextSize 
End Sub

'Gets or sets the TitleTextColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.TitleTextColor = xui.Color_Black</code>
Public Sub setTitleTextColor(TitleTextColor As Int)
	Texts.TitleTextColor = TitleTextColor
End Sub

Public Sub getTitleTextColor As Int
	Return Texts.TitleTextColor
End Sub

'Gets or sets the SubTitleTextSize property
'Setting this text size sets automatically AutomaticTextSizes = False.
Public Sub setSubTitleTextSize(SubTitleTextSize As Float)
	Texts.SubTitleTextSize = SubTitleTextSize
	Texts.SubTitleFont = xui.CreateDefaultFont(Texts.SubTitleTextSize)
	Texts.AutomaticTextSizes = False
End Sub

Public Sub getSubTitleTextSize As Float
	Return Texts.SubTitleTextSize
End Sub

'Gets or sets the SubTitleTextColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.SubTitleTextColor = xui.Color_Black</code>
Public Sub setSubTitleTextColor(SubTitleTextColor As Int)
	Texts.SubTitleTextColor = SubTitleTextColor
End Sub

Public Sub getSubTitleTextColor As Int
	Return Texts.SubTitleTextColor
End Sub

'Gets or sets the CalendarTextSize property
'Setting this text size sets automatically CalendarTextSize = False.
Public Sub setCalendarTextSize(CalendarTextSize As Float)
	Texts.CalendarTextSize = CalendarTextSize
	Texts.TitleFont = xui.CreateDefaultFont(Texts.CalendarTextSize)
	Texts.AutomaticTextSizes = False
End Sub

Public Sub getCalendarTextSize As Float
	Return Texts.CalendarTextSize
End Sub

'Gets or sets the CalendarTextColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.CalendarTextColor = xui.Color_Black</code>
Public Sub setCalendarTextColor(CalendarTextColor As Int)
	Texts.CalendarTextColor = CalendarTextColor
End Sub

Public Sub getCalendarTextColor As Int
	Return Texts.CalendarTextColor
End Sub

'Gets or sets the ValuesTextSize property
'Setting this text size sets automatically ValuesTextSize = False.
Public Sub setValuesTextSize(ValuesTextSize As Float)
	Values.TextSize = ValuesTextSize
	Texts.TitleFont = xui.CreateDefaultFont(Values.TextSize)
	Texts.AutomaticTextSizes = False
End Sub

Public Sub getValuesTextSize As Float
	Return Values.TextSize
End Sub

'Gets or sets the ValuesTextColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.ValuesTextColor = xui.Color_Black</code>
Public Sub setValuesTextColor(ValuesTextColor As Int)
	Values.TextColor = ValuesTextColor
End Sub

Public Sub getValuesTextColor As Int
	Return Values.TextColor
End Sub

'Gets or sets the ValuesDisplayPosition property
'Possible values: "CURSOR" or "DAY_OF_MONTH"
Public Sub setValuesDisplayPosition(ValuesDisplayPosition As String)
	Select ValuesDisplayPosition
		Case "CURSOR", "TOP"
			Values.Position = ValuesDisplayPosition
		Case Else
			LogColor("Wrong value! Possible values: ""CURSOR"" or ""TOP""", xui.Color_Red)
	End Select
End Sub

Public Sub getValuesDisplayPosition As String
	Return Values.Position
End Sub

'Gets or sets the ChartBackgroundColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.ChartBackgroundColor = xui.Color_Black</code>
Public Sub setChartBackgroundColor(ChartBackgroundColor As Int)
	Gantt.ChartBackgroundColor = ChartBackgroundColor
End Sub

Public Sub getChartBackgroundColor As Int
	Return Gantt.ChartBackgroundColor
End Sub

'Gets or sets the GridFrameColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.GridFrameColor = xui.Color_Black</code>
Public Sub setGridFrameColor(GridFrameColor As Int)
	Gantt.GridFrameColor = GridFrameColor
End Sub

Public Sub getGridFrameColor As Int
	Return Gantt.GridFrameColor
End Sub

'Gets or sets the DrawGridFrame property
'Displays the list of tasks at the left of the chart.
Public Sub setDrawGridFrame(DrawGridFrame As Boolean)
	Gantt.DrawGridFrame = DrawGridFrame
End Sub

Public Sub getDrawGridFrame As Boolean
	Return Gantt.DrawGridFrame
End Sub

'Gets or sets the GridColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.GridColor = xui.Color_Black</code>
Public Sub setGridColor(GridColor As Int)
	Gantt.GridColor = GridColor
End Sub

Public Sub getGridColor As Int
	Return Gantt.GridColor
End Sub

'Gets or sets the SundayColor property
'The color must be an xui.Color
'Example code: <code>xGantt1.SundayColor = xui.Color_Black</code>
Public Sub setSundayColor(SundayColor As Int)
	Gantt.SundayColor = SundayColor
End Sub

Public Sub getSundayColor As Int
	Return Gantt.SundayColor
End Sub
