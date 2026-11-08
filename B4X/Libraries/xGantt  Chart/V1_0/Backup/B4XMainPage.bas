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
	
	Private MyGantt As xGantt
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(B4XPages.MainPage, "Gantt chart demo")
	InitGantt
#If B4A
	MyGantt.DrawChart
#End If
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	Log("B4XPage_Resize")
'	InitGantt
	MyGantt.DrawChart
	
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = xui.Msgbox2Async("Exit application?", "Exit", "Yes", "Cancel", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Return True
	End If
	Return False
End Sub

Private Sub InitGantt
	DateTime.DateFormat = "yyyy.MM.dd"
	
	MyGantt.AddTask("0001", "Task 1", "Paul", "2021.05.12", 4, "None", "None", 0, xui.Color_Red)
	MyGantt.AddTask("0002", "Task 2", "Peter", "", 4, "FS", "0001", 0, xui.Color_Cyan)
	MyGantt.AddTask("0003", "Task 3", "John", "2", 2, "FS", "0002", 0, xui.Color_Blue)
	MyGantt.AddTask("0004", "Task 4", "Johnny", "", 2, "SS", "0002", 2, xui.Color_RGB(0, 165, 255))
	MyGantt.AddTask("0005", "Task 5", "Johnny", "2021.05.18", 3, "SF", "0002", 0, xui.Color_RGB(0, 105, 255))
	MyGantt.AddTask("0006", "Task 6", "Carol", "", 9, "FS", "0003", -2, xui.Color_Green)
	MyGantt.AddTask("0007", "Task 7", "Nancy", "", 2, "FS", "0006", 2, xui.Color_Yellow)
	MyGantt.AddTask("0008", "Task 8", "Nick", "", 6, "FS", "0007", 0, xui.Color_Magenta)
	MyGantt.AddTask("0009", "Task 9", "Brian", "", 4, "FF", "0008", 0, xui.Color_RGB(165, 42, 42))
	MyGantt.AddTask("0010", "Task 10", "Sharon", "", 3, "FF", "0008", 0, xui.Color_RGB(255, 0, 255))
	MyGantt.AddTask("0011", "Task 11", "Bruce", "", 8, "FS", "0008", 0, xui.Color_RGB(138, 43, 226))
	MyGantt.AddTask("0012", "Task 12", "Charles", "", 4, "FF", "0011", 2, xui.Color_RGB(165, 42, 42))
	MyGantt.AddTask("0013", "Task 13", "Mary", "", 13, "FS", "0008", 0, xui.Color_Red)
	MyGantt.AddTask("0014", "Task 14", "Elton", "", 11, "FS", "0013", 0, xui.Color_Blue)
	MyGantt.AddTask("0015", "Task 15", "Mike", "", 3, "FS", "0013", 0, xui.Color_Cyan)
	MyGantt.AddTask("0016", "Task 16", "Suzan", "", 12, "FS", "0015", 0, xui.Color_Green)
	MyGantt.AddTask("0017", "Task 17", "Shean", "", 9, "FF", "0016", 0, xui.Color_Yellow)
	MyGantt.AddTask("0018", "Task 18", "Sheyla", "", 7, "FF", "0016", 0 , xui.Color_Magenta)
	MyGantt.AddTask("0019", "Task 19", "Brian", "", 6, "FF", "0016", 0, xui.Color_RGB(165, 42, 42))
	MyGantt.AddTask("0020", "Task 20", "Brian", "", 3, "FS", "0016", 0, xui.Color_RGB(255, 0, 255))
	MyGantt.AddTask("0021", "Task 21", "Bruce", "", 4, "FS", "0016", 0, xui.Color_RGB(138, 43, 226))
	MyGantt.AddTask("0022", "Task 22", "Charles", "", 8, "FS", "0016", 0, xui.Color_RGB(165, 42, 42))
	
	MyGantt.SetCompletion("0001", 100)
	MyGantt.SetCompletion("0002", 100)
	MyGantt.SetCompletion("0003", 100)
	MyGantt.SetCompletion("0004", 100)
	MyGantt.SetCompletion("0005", 100)
	MyGantt.SetCompletion("0006", 100)
	MyGantt.SetCompletion("0007", 100)
	MyGantt.SetCompletion("0008", 100)
	MyGantt.SetCompletion("0009", 30)
	MyGantt.SetCompletion("0010", 10)
	MyGantt.SetCompletion("0011", 10)
	
	MyGantt.IgnoreCompleted = True
	Log("Gantt")
'	MyGantt.DrawChart
	
'	Sleep(400)
'	MyGantt.Tasks.RemoveAt(10)
'	MyGantt.DrawChart
End Sub

'Private Sub MyGantt_TaskClick(Task As GanttTaskData)
'	Log("TaskClick " & Task.ID)
'End Sub

Private Sub MyGantt_TaskLongClick(Task As GanttTaskData)
	Log("TaskLongClick " & Task.ID)
End Sub


