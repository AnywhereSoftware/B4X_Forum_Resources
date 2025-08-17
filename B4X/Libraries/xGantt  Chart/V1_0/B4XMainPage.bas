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
	
	Private pnlToolboxEdit As B4XView
	Private btnEdit, btnGantt, btnTable As B4XView
	Private ProjectDir, ProjectFilename As String
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(B4XPages.MainPage, "Gantt chart demo V1.0")
	
'	ProjectDir = File.DirData("xGanttDemo")
	Private Index As Int
	Index = 0
	Select Index
		Case 0
			InitGanttTasks
		Case 1
			InitGanttTasks1
		Case 2
			InitGanttTasks2
		Case 3
			InitGanttTasks3
	End Select
	
	If Not(xui.IsB4i) Then
		Sleep(0)
		Start
	End If
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	If xui.IsB4i Then
		Start
	End If
End Sub

Private Sub Start
	If MyGantt.Items.Size > 0 Then
		MyGantt.DrawChart
	Else
		xui.MsgboxAsync("No Gantt data available", "Error")
	End If
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = xui.Msgbox2Async("Exit application?", "Exit", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Return True
	End If
	Return False
End Sub

Private Sub btnGantt_Click
	MyGantt.DisplayType = "GANTT"
	MyGantt.DrawChart
	MyGantt.Visible = True
End Sub

Private Sub btnTable_Click
	MyGantt.DisplayType = "TABLE"
	MyGantt.DrawChart
	MyGantt.Visible = True
End Sub

Private Sub MyGantt_SelectedIndexChanged(Index As Int)
	If Index = -1 Then
		pnlToolboxEdit.Visible = False
	Else
		pnlToolboxEdit.Visible = True
	End If
End Sub

Private Sub btnEdit_Click
'	MyGantt.Visible = False
'	MyGanttEdit.Visible = True
	MyGantt.ItemEdit
End Sub

Private Sub btnAdd_Click
	MyGantt.ItemAdd
End Sub

Private Sub btnInsertAt_Click
	MyGantt.ItemInsertAt
End Sub

Private Sub btnDelete_Click
	MyGantt.ItemDelete
End Sub

Private Sub btnSave_Click
	Private FileName As String
	
#If B4J
	Private FileChooser1 As FileChooser
	FileChooser1.Initialize
	FileChooser1.Title = "Select a Gantt project"
	FileChooser1.InitialDirectory = ProjectDir
	FileChooser1.InitialFileName = ProjectFilename
	FileChooser1.SetExtensionFilter("Gantt project", Array As String("*.gtp"))

	FileName = FileChooser1.ShowSave(Main.MainForm)
	
		ProjectFilename = File.GetName(FileName)

	If FileName <> "" Then
		If Not(ProjectFilename.EndsWith(".gtp")) Then
			ProjectFilename = ProjectFilename & ".gtp"
		End If
		MyGantt.SaveProject(File.GetFileParent(FileName), ProjectFilename)
	End If
#Else If B4A
#End If


End Sub

Private Sub btnLoad_Click
	Private FileName As String

#If B4J
	Private FileChooser1 As FileChooser
	FileChooser1.Initialize
	FileChooser1.Title = "Select a Gantt project"
	FileChooser1.InitialDirectory = ProjectDir
	FileChooser1.InitialFileName = ProjectFilename
	FileChooser1.SetExtensionFilter("Gantt project", Array As String("*.gtp"))
	FileName = FileChooser1.ShowOpen(Main.MainForm)
	
	ProjectFilename = File.GetName(FileName)

	If FileName <> "" Then
		MyGantt.LoadProject(File.GetFileParent(FileName), ProjectFilename)
		MyGantt.DrawChart
	End If
#Else If B4A
#End If

End Sub

Private Sub InitGanttTasks
	
	MyGantt.Title = "Demo project"
	MyGantt.SubTitle = "with 22 tasks"
	MyGantt.AddGroup("1", "Group 1", "1.1", "1.5", xui.Color_Red)
	MyGantt.AddTask("1.1", "Task 1.1", "Paul", "2021.05.12", 4, "None", "", 0, xui.Color_Red)
	MyGantt.AddTask("1.2", "Task 1.2", "Peter", "", 4, "FS", "1.1", 0, xui.Color_Cyan)
	MyGantt.AddTask("1.3", "Task 1.3", "John", "2", 2, "FS", "1.2", 0, xui.Color_Blue)
	MyGantt.AddTask("1.4", "Task 1.4", "Johnny", "", 2, "SS", "1.2", 2, xui.Color_RGB(0, 165, 255))
	MyGantt.AddTask("1.5", "Task 1.5", "Johnny", "2021.05.18", 3, "SF", "1.2", 1, xui.Color_RGB(0, 105, 255))
	MyGantt.AddMilestone("1", "Milestone 1", "", "TE", "1.3", xui.Color_Green)
	MyGantt.AddGroup("2", "Group 2", "2.1", "2.5", xui.Color_Green)
	MyGantt.AddTask("2.1", "Task 2.1", "Carol", "", 9, "FS", "1.3", 0, xui.Color_Green)
	MyGantt.AddTask("2.2", "Task 2.2", "Nancy", "", 2, "FS", "2.1", 2, xui.Color_Yellow)
	MyGantt.AddTask("2.3", "Task 2.3", "Nick", "", 6, "FS", "2.2", 0, xui.Color_Magenta)
	MyGantt.AddTask("2.4", "Task 2.4", "Brian", "", 4, "FF", "2.3", 0, xui.Color_RGB(165, 42, 42))
	MyGantt.AddTask("2.5", "Task 2.5", "Sharon", "", 3, "FF", "2.3", 0, xui.Color_RGB(255, 0, 255))
	MyGantt.AddMilestone("2", "Milestone 2", "", "TE", "2.5", xui.Color_RGB(138, 43, 226))
	MyGantt.AddGroup("3", "Group 3", "3.1", "3.3", xui.Color_RGB(138, 43, 226))
	MyGantt.AddTask("3.1", "Task 3.1", "Bruce", "", 8, "FS", "2.3", 0, xui.Color_RGB(138, 43, 226))
	MyGantt.AddTask("3.2", "Task 3.2", "Charles", "", 4, "FF", "3.1", 2, xui.Color_RGB(165, 42, 42))
	MyGantt.AddTask("3.3", "Task 3.3", "Mary", "", 13, "FS", "2.3", 0, xui.Color_Red)
	MyGantt.AddGroup("4", "Group 4", "4.1", "4.6", xui.Color_Blue)
	MyGantt.AddTask("4.1", "Task 4.1", "Elton", "", 11, "FS", "3.3", 0, xui.Color_Blue)
	MyGantt.AddTask("4.2", "Task 4.2", "Mike", "", 3, "FS", "3.3", 0, xui.Color_Cyan)
	MyGantt.AddTask("4.3", "Task 4.3", "Suzan", "", 12, "FS", "4.2", 0, xui.Color_Green)
	MyGantt.AddTask("4.4", "Task 4.4", "Shean", "", 9, "FF", "4.3", 0, xui.Color_Yellow)
	MyGantt.AddTask("4.5", "Task 4.5", "Sheyla", "", 7, "FF", "4.3", 0 , xui.Color_Magenta)
	MyGantt.AddTask("4.6", "Task 4.6", "Brian", "", 6, "FF", "4.3", 0, xui.Color_RGB(165, 42, 42))
	MyGantt.AddMilestone("3", "Milestone 3", "", "TB", "5.1", xui.Color_Red)
	MyGantt.AddGroup("5", "Group 5", "5.1", "5.3", xui.Color_Red)
	MyGantt.AddTask("5.1", "Task 5.1", "Brian", "", 3, "FS", "4.3", 0, xui.Color_RGB(255, 0, 255))
	MyGantt.AddTask("5.2", "Task 5.2", "Bruce", "", 4, "FS", "4.3", 0, xui.Color_RGB(138, 43, 226))
	MyGantt.AddTask("5.3", "Task 5.3", "Charles", "", 8, "FS", "4.3", 0, xui.Color_RGB(165, 42, 42))
	
	MyGantt.SetCompletion("1.1", 100)
	MyGantt.SetCompletion("1.2", 100)
	MyGantt.SetCompletion("1.3", 100)
	MyGantt.SetCompletion("1.4", 100)
	MyGantt.SetCompletion("1.5", 100)
	MyGantt.SetCompletion("2.1", 100)
	MyGantt.SetCompletion("2.2", 100)
	MyGantt.SetCompletion("2.3", 100)
	MyGantt.SetCompletion("2.4", 30)
	MyGantt.SetCompletion("2.5", 10)
	MyGantt.SetCompletion("3.1", 10)
	
'	MyGantt.IgnoreCompleted = True
End Sub

Private Sub InitGanttTasks1
	MyGantt.Title = "Simple demo project"
	MyGantt.SubTitle = "with 10 tasks and no dependencies"
	MyGantt.AddTask("1", "Task 1", "Paul", "2022.04.11", 4, "None", "", 0, xui.Color_Red)
	MyGantt.AddTask("2", "Task 2", "Paul", "2022.04.15", 3, "None", "", 0, xui.Color_Blue)
	MyGantt.AddTask("3", "Task 3", "Paul", "2022.04.20", 8, "None", "", 0, xui.Color_Green)
	MyGantt.AddTask("4", "Task 4", "Paul", "2022.05.02", 5, "None", "", 0, xui.Color_Yellow)
	MyGantt.AddTask("5", "Task 5", "Paul", "2022.05.09", 6, "None", "", 0, xui.Color_Magenta)
	MyGantt.AddTask("6", "Task 6", "Paul", "2022.05.18", 1, "None", "", 0, xui.Color_Red)
	MyGantt.AddTask("7", "Task 7", "Paul", "2022.05.19", 2, "None", "", 0, xui.Color_Blue)
	MyGantt.AddTask("8", "Task 8", "Paul", "2022.05.23", 6, "None", "", 0, xui.Color_Green)
	MyGantt.AddTask("9", "Task 9", "Paul", "2022.06.01", 3, "None", "", 0, xui.Color_Yellow)
	MyGantt.AddTask("10", "Task 10", "Paul", "2022.06.06", 5, "None", "", 0, xui.Color_Magenta)
End Sub

Private Sub InitGanttTasks2
	MyGantt.Title = "Simple demo project"
	MyGantt.SubTitle = "with 10 tasks and Finish to Start dependencies"
	MyGantt.AddTask("1", "Task 1", "Paul", "2022.04.11", 4, "None", "", 0, xui.Color_Red)
	MyGantt.AddTask("2", "Task 2", "Paul", "", 3, "FS", "1", 0, xui.Color_Blue)
	MyGantt.AddTask("3", "Task 3", "Paul", "", 8, "FS", "2", 0, xui.Color_Green)
	MyGantt.AddTask("4", "Task 4", "Paul", "", 5, "FS", "3", 0, xui.Color_Yellow)
	MyGantt.AddTask("5", "Task 5", "Paul", "", 6, "FS", "4", 0, xui.Color_Magenta)
	MyGantt.AddTask("6", "Task 6", "Paul", "", 1, "FS", "5", 0, xui.Color_Red)
	MyGantt.AddTask("7", "Task 7", "Paul", "", 2, "FS", "6", 0, xui.Color_Blue)
	MyGantt.AddTask("8", "Task 8", "Paul", "", 6, "FS", "7", 0, xui.Color_Green)
	MyGantt.AddTask("9", "Task 9", "Paul", "", 3, "FS", "8", 0, xui.Color_Yellow)
	MyGantt.AddTask("10", "Task 10", "Paul", "", 5, "FS", "9", 0, xui.Color_Magenta)
End Sub

Private Sub InitGanttTasks3
	MyGantt.Title = "Simple demo project"
	MyGantt.SubTitle = "with 10 tasks and Finish to Start dependencies 3 milestones and two groups"
	MyGantt.AddMilestone("1", "Milestone 1", "", "TB", "1.1", xui.Color_Green)
	MyGantt.AddGroup("1", "Group 1", "1.1", "1.5", xui.Color_Green)
	MyGantt.AddTask("1.1", "Task 1.1", "Paul", "2022.04.11", 4, "None", "", 0, xui.Color_Red)
	MyGantt.AddTask("1.2", "Task 1.2", "Paul", "", 3, "FS", "1.1", 0, xui.Color_Blue)
	MyGantt.AddTask("1.3", "Task 1.3", "Paul", "", 8, "FS", "1.2", 0, xui.Color_Green)
	MyGantt.AddTask("1.4", "Task 1.4", "Paul", "", 5, "FS", "1", 0, xui.Color_Yellow)
	MyGantt.AddTask("1.5", "Task 1.5", "Paul", "", 6, "FS", "1.4", 0, xui.Color_Magenta)
	MyGantt.AddMilestone("2", "Milestone 2", "", "TE", "1.5", xui.Color_Green)
	MyGantt.AddGroup("2", "Group 1", "2.1", "2.5", xui.Color_Blue)
	MyGantt.AddTask("2.1", "Task 2.1", "Paul", "", 1, "FS", "1.5", 0, xui.Color_Red)
	MyGantt.AddTask("2.2", "Task 2.2", "Paul", "", 2, "FS", "2.1", 0, xui.Color_Blue)
	MyGantt.AddTask("2.3", "Task 2.3", "Paul", "", 6, "FS", "2.2", 0, xui.Color_Green)
	MyGantt.AddTask("2.4", "Task 2.4", "Paul", "", 3, "FS", "2.3", 0, xui.Color_Yellow)
	MyGantt.AddTask("2.5", "Task 2.5", "Paul", "", 5, "FS", "2.4", 0, xui.Color_Magenta)
	MyGantt.AddMilestone("3", "Milestone 3", "", "TE", "2.5", xui.Color_Red)
End Sub

Private Sub MyGantt_ItemClick(Row As Int)
	Log("ItemClick row " & Row)
End Sub

Private Sub MyGantt_ItemLongClick(Row As Int)
	Log("ItemLongClick row " & Row)
End Sub

