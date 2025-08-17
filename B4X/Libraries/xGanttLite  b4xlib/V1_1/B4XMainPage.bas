B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a 
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i 
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private xGanttLite1 As xGanttLite
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me, "xGanttLite demo")
	
	xGanttLite1.LanguageCode = "fr"
	
	InitTaskData2
	
	Sleep(100)
	xGanttLite1.DrawGantt

'	Sleep(1000)
'	xGanttLite1.JumpToEnd
'	Sleep(1000)
'	xGanttLite1.JumpToBegin
'	Sleep(1000)
'	xGanttLite1.JumpToNow

'	Sleep(1000)
'	xGanttLite1.JumpToDate2("2024-09-21 08:30:00")
	
	'For testing, you can uncomment lines to see what happens
'	Sleep(2000)
'	xGanttLite1.DateFormat = "dd.MM.yyyy"					'changes the date format
'	xGanttLite1.DisplayRowIndexColumn = False			'the RowIndexColumn is hidden
'	xGanttLite1.DisplayResponsibleColumn = False	'the ResponsibleColumn is hidden
'	xGanttLite1.DisplayRowData = False						'no row data is displayed when you press and move the mouse

'	Sleep(2000)
'	xGanttLite1.TextSize = 12
'	xGanttLite1.TextColor = xui.Color_Blue
'	xGanttLite1.BackgroundColor = xui.Color_RGB(202, 255, 225)
'	xGanttLite1.GridFrameColor = xui.Color_Blue
'	xGanttLite1.GridColor = xui.Color_Red

'	SaveSnapshot
End Sub

Private Sub xGanttLite1_SelectedRow(RowIndex As Int)
	Private Row As GanttLiteRowData
	Row = xGanttLite1.Rows.Get(RowIndex)
'	Log(Row.ObjectType & " : " & Row.ObjectID)
End Sub

Private Sub InitTaskData
	xGanttLite1.TimeDisplayMode = "HOUR"
	xGanttLite1.AddGroup("1", "INCENDIO",  xui.Color_Blue, "")
	xGanttLite1.AddTaskTicks("1.1", "Reconociemento", "Manuel", "1", DateTime.DateParse("2024-09-01 21:00:00"), DateTime.DateParse("2024-09-01 23:00:00"), xui.Color_RGB(255, 0, 255), "")
	xGanttLite1.AddTaskTicks("1.2", "Ataque exterior", "Manuel", "1", DateTime.DateParse("2024-09-01 23:20:12"), DateTime.DateParse("2024-09-02 01:15:12"), xui.Color_Red, "")

	xGanttLite1.AddGroup("2", "SALVAMENTO", xui.Color_Blue, "")
	xGanttLite1.AddTaskTicks("2.1", "Entique", "Enrique", "2", DateTime.DateParse("2024-09-02 02:34:12"), DateTime.DateParse("2024-09-02 04:15:12"), xui.Color_Blue, "")
End Sub

Private Sub InitTaskData1
	xGanttLite1.TimeDisplayMode = "HOUR"
	xGanttLite1.AddGroup("2", "SALVAMENTO", xui.Color_Blue, "")
	xGanttLite1.AddTaskTicks("2.1", "Entique", "Enrique", "2", DateTime.DateParse("2024-09-01 12:34:12"), DateTime.DateParse("2024-09-02 12:15:12"), xui.Color_Blue, "")
End Sub

Private Sub InitTaskData2
	xGanttLite1.TimeDisplayMode = "HOUR"
	Private DateNow_1, DateNow, DateNow1, DateNow2  As String
	Private CommentShort, CommentMiddle, CommentLong As String
	
	CommentShort = "This is a short comment"
	CommentMiddle = "just found this old post by Erel with a sample project to send email using gmail"
	CommentLong = "This is the first paragraphe of the long comment." & CRLF
	CommentLong = CommentLong & "This is the second paragraphe of the long comment." & CRLF
	CommentLong = CommentLong & "This is the third paragraphe of the long comment."

	DateTime.DateFormat = "yyyy-MM-dd"
	DateNow_1 = DateTime.Date(DateTime.Now - DateTime.TicksPerDay)
	DateNow = DateTime.Date(DateTime.Now)
	DateNow1 = DateTime.Date(DateTime.Now + DateTime.TicksPerDay)
	DateNow2 = DateTime.Date(DateTime.Now + 2 * DateTime.TicksPerDay)
	DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
	
	xGanttLite1.AddGroup("1", "INCENDIO", xui.Color_Blue, CommentMiddle)
	xGanttLite1.AddTaskDates("1.1", "Reconociemento", "Manuel", "1", DateNow_1 & " 08:05:12", DateNow_1 & " 09:15:12", xui.Color_RGB(255, 0, 255), CommentShort)
	xGanttLite1.AddTaskDates("1.2", "Ataque exterior", "Manuel", "1", DateNow_1 & " 12:00:00", DateNow_1 & " 18:00:00", xui.Color_Red, CommentShort)
	xGanttLite1.AddTaskDates("1.3", "Ataque exterior", "Manuel", "1", DateNow_1 & " 21:00:00", DateNow_1 & " 23:00:00", xui.Color_Blue, CommentShort)

	xGanttLite1.AddEmpty
	
	xGanttLite1.AddGroup("2", "SALVAMENTO", xui.Color_Blue, CommentShort)
	xGanttLite1.AddTaskDates("2.1", "Evacuacion de personas", "Enrique", "2", DateNow_1 & " 09:34:12", DateNow_1 & " 11:23:12", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("2.2", "Evacuacion de personas", "Enrique", "2", DateNow_1 & " 11:34:12", DateNow_1 & " 15:23:12", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("2.3", "Evacuacion de personas", "Enrique", "2", DateNow_1 & " 17:34:12", DateNow_1 & " 20:23:12", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("2.4", "Evacuacion de personas", "Enrique", "2", DateNow_1 & " 21:34:12", DateNow_1 & " 23:23:12", xui.Color_Blue, "")

	xGanttLite1.AddGroup("3", "INCENDIO", xui.Color_RGB(255, 0, 255), "")
	xGanttLite1.AddTaskDates("3.1", "Ataque exterior", "Manuel", "3", DateNow1 & " 12:00:00", DateNow1 & " 18:00:00", xui.Color_Red, CommentShort)
	xGanttLite1.AddTaskDates("3.3", "Ataque exterior", "Manuel", "3", DateNow1 & " 21:00:00", DateNow1 & " 23:00:00", xui.Color_Blue, CommentShort)

	xGanttLite1.AddEmpty
	
	xGanttLite1.AddGroup("4", "SALVAMENTO", xui.Color_Blue, CommentMiddle)
	xGanttLite1.AddTaskDates("4.1", "Evacuacion de personas", "Enrique", "4", DateNow & " 09:34:12", DateNow & " 11:23:12", xui.Color_Blue, CommentMiddle)
	xGanttLite1.AddTaskDates("4.2", "Evacuacion de personas", "Enrique", "4", DateNow & " 11:34:12", DateNow & " 15:23:12", xui.Color_Blue, CommentMiddle)
	xGanttLite1.AddTaskDates("4.3", "Evacuacion de personas", "Enrique", "4", DateNow & " 17:34:12", DateNow & " 20:23:12", xui.Color_Blue, CommentMiddle)
	xGanttLite1.AddTaskDates("4.4", "Evacuacion de personas", "Enrique", "4", DateNow & " 21:34:12", DateNow & " 23:23:12", xui.Color_Blue, CommentMiddle)

	xGanttLite1.AddGroup("5", "INCENDIO", xui.Color_Blue, CommentMiddle)
	xGanttLite1.AddTaskDates("5.1", "Reconociemento", "Manuel", "5", DateNow1 & " 08:05:12", DateNow1 & " 09:15:12", xui.Color_RGB(255, 0, 255), CommentMiddle)
	xGanttLite1.AddTaskDates("5.2", "Ataque exterior", "Manuel", "5", DateNow1 & " 12:00:00", DateNow1 & " 18:00:00", xui.Color_Red, CommentMiddle)
	xGanttLite1.AddTaskDates("5.3", "Ataque exterior", "Manuel", "5", DateNow1 & " 21:00:00", DateNow1 & " 23:00:00", xui.Color_Blue, CommentMiddle)

	xGanttLite1.AddEmpty

	xGanttLite1.AddGroup("6", "SALVAMENTO", xui.Color_Blue, CommentLong)
	xGanttLite1.AddTaskDates("6.1", "Evacuacion de personas", "Enrique", "6", DateNow1 & " 09:34:12", DateNow1 & " 11:23:12", xui.Color_Blue, CommentLong)
	xGanttLite1.AddTaskDates("6.2", "Evacuacion de personas", "Enrique", "6", DateNow1 & " 11:34:12", DateNow1 & " 15:23:12", xui.Color_Blue, CommentLong)
	xGanttLite1.AddTaskDates("6.3", "Evacuacion de personas", "Enrique", "6", DateNow1 & " 17:34:12", DateNow1 & " 20:23:12", xui.Color_Blue, CommentLong)
	xGanttLite1.AddTaskDates("6.4", "Evacuacion de personas", "Enrique", "6", DateNow1 & " 21:34:12", DateNow1 & " 23:23:12", xui.Color_Blue, CommentLong)

	xGanttLite1.AddGroup("7", "INCENDIO", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("7.1", "Reconociemento", "Manuel", "7", DateNow2 & " 08:05:12", DateNow2 & " 09:15:12", xui.Color_RGB(255, 0, 255), "")
	xGanttLite1.AddTaskDates("7.2", "Ataque exterior", "Manuel", "7", DateNow2 & " 12:00:00", DateNow2 & " 18:00:00", xui.Color_Red, "")
	xGanttLite1.AddTaskDates("7.3", "Ataque exterior", "Manuel", "7", DateNow2 & " 19:00:00", DateNow2 & " 21:00:00", xui.Color_Blue, "")

	xGanttLite1.AddEmpty

	xGanttLite1.AddGroup("8", "SALVAMENTO", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("8.1", "Evacuacion de personas", "Enrique", "8", DateNow2 & " 09:34:12", DateNow2 & " 11:23:12", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("8.2", "Evacuacion de personas", "Enrique", "8", DateNow2 & " 11:34:12", DateNow2 & " 15:23:12", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("8.3", "Evacuacion de personas", "Enrique", "8", DateNow2 & " 16:34:12", DateNow2 & " 18:23:12", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("8.4", "Evacuacion de personas", "Enrique", "8", DateNow2 & " 19:34:12", DateNow2 & " 21:23:12", xui.Color_Blue, "")
End Sub

Private Sub InitTaskData3
	Private DateNow_23, DateNow_10, DateNow_4, DateNow, DateNow3, DateNow8, DateNow15, DateNow20, DateNow25, DateNow30  As String

	DateTime.DateFormat = "yyyy-MM-dd"
	DateNow_23 = DateTime.Date(DateTime.Now - 23 * DateTime.TicksPerDay)
	DateNow_10 = DateTime.Date(DateTime.Now - 10 * DateTime.TicksPerDay)
	DateNow_4 = DateTime.Date(DateTime.Now - 4 * DateTime.TicksPerDay)
	DateNow = DateTime.Date(DateTime.Now)
	DateNow3 = DateTime.Date(DateTime.Now + DateTime.TicksPerDay)
	DateNow8 = DateTime.Date(DateTime.Now + 3 * DateTime.TicksPerDay)
	DateNow15 = DateTime.Date(DateTime.Now + 15 * DateTime.TicksPerDay)
	DateNow20 = DateTime.Date(DateTime.Now + 20 * DateTime.TicksPerDay)
	DateNow25 = DateTime.Date(DateTime.Now + 25 * DateTime.TicksPerDay)
	DateNow30 = DateTime.Date(DateTime.Now + 30 * DateTime.TicksPerDay)
	DateTime.DateFormat = "yyyy-MM-dd HH:mm"	

	xGanttLite1.TimeDisplayMode = "DAY_LARGE"
	xGanttLite1.AddGroup("1", "Group 1", xui.Color_Blue, "")
	xGanttLite1.AddTaskDates("1.1", "Task 1.1", "John", "1", DateNow_23 & " 08:05:12", DateNow_10 & " 09:15:12", xui.Color_RGB(255, 0, 255), "No comment")
	xGanttLite1.AddTaskDates("1.2", "Task 1.2", "John", "1", DateNow_23 & " 12:00:00", DateNow_4 & " 18:00:00", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("1.3", "Task 1.3", "John", "1", DateNow_10 & " 21:00:00", DateNow & " 23:00:00", xui.Color_Blue, "No comment")
	xGanttLite1.AddEmpty
	xGanttLite1.AddGroup("2", "Group 2", xui.Color_Red, "")
	xGanttLite1.AddTaskDates("2.1", "Task 2.1", "Michael", "2", DateNow_10 & " 08:05:12", DateNow_4 & " 09:15:12", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("2.2", "Task 2.2", "Michael", "2", DateNow_10 & " 10:00:00", DateNow & " 18:00:00", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("2.3", "Task 2.3", "Michael", "2", DateNow_10 & " 12:00:00", DateNow3 & " 20:00:00", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("2.4", "Task 2.4", "Michael", "2", DateNow_4 & " 15:00:00", DateNow3 & " 22:00:00", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("2.5", "Task 2.5", "Michael", "2", DateNow & " 18:00:00", DateNow8 & " 23:59:00", xui.Color_Red, "No comment")
	xGanttLite1.AddEmpty
	xGanttLite1.AddGroup("3", "Group 3", xui.Color_Red, "")
	xGanttLite1.AddTaskDates("3.1", "Task 3.1", "Michael", "3", DateNow & " 08:05:12", DateNow & " 09:15:12", xui.Color_Green, "No comment")
	xGanttLite1.AddTaskDates("3.2", "Task 3.2", "Michael", "3", DateNow & " 10:00:00", DateNow3 & " 18:00:00", xui.Color_Green, "No comment")
	xGanttLite1.AddTaskDates("3.3", "Task 3.3", "Michael", "3", DateNow3 & " 12:00:00", DateNow8 & " 20:00:00", xui.Color_Green, "No comment")
	xGanttLite1.AddTaskDates("3.4", "Task 3.4", "Michael", "3", DateNow3 & " 15:00:00", DateNow15 & " 22:00:00", xui.Color_Green, "No comment")
	xGanttLite1.AddTaskDates("3.5", "Task 3.5", "Michael", "3", DateNow8 & " 18:00:00", DateNow20 & " 23:59:00", xui.Color_Green, "No comment")
	xGanttLite1.AddEmpty
	xGanttLite1.AddGroup("4", "Group 4", xui.Color_Red, "")
	xGanttLite1.AddTaskDates("4.1", "Task 4.1", "Michael", "4", DateNow15 & " 08:05:12", DateNow20 & " 09:15:12", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("4.2", "Task 4.2", "Michael", "4", DateNow15 & " 10:00:00", DateNow25 & " 18:00:00", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("4.3", "Task 4.3", "Michael", "4", DateNow20 & " 12:00:00", DateNow25 & " 20:00:00", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("4.4", "Task 4.4", "Michael", "4", DateNow25 & " 15:00:00", DateNow30 & " 22:00:00", xui.Color_Red, "No comment")
	xGanttLite1.AddTaskDates("4.5", "Task 4.5", "Michael", "4", DateNow25 & " 18:00:00", DateNow30 & " 23:59:00", xui.Color_Red, "No comment")

End Sub

Private Sub SaveSnapshot
	Private bmp As B4XBitmap
	Private Out As OutputStream
	xui.SetDataFolder("GanttLiteDemo")
	Out = File.OpenOutput(xui.DefaultFolder, "Test.jpg", False)
	Log(xui.DefaultFolder)
	bmp = xGanttLite1.Snapshot
	bmp.WriteToStream(Out, 100, "JPEG")
	Out.Close
End Sub