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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
#Macro: Title, Error Analyzer, ide://run?File=%ADDITIONAL%\errorAnalyzer.jar&Args=%PROJECT%

Sub Class_Globals
	Private Root As B4XView		'ignore
	Private xui As XUI
	
	Public Arguments() As String
	Public stateFile As String
	
	Private projectA As String
	Private projectB As String
	
	Private diff As ShowDif
	Private mods As Modules
End Sub

Public Sub Initialize
	diff.initialize
	mods.initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
		
	projectA = "C:\Users\willi\Desktop\WiLPlayer\B4A"
	If Arguments.Length > 0 Then 
		Dim v() As String = Regex.Split("\~", Arguments(0))
		projectA = v(0)
	End If

	If File.Exists(projectA & "\Objects", "SubComparator_projectB.txt") Then
		projectB = File.readString(projectA & "\Objects", "SubComparator_projectB.txt")
	Else
		projectB = chooseProject("Select folder for Project 'B'   This is the folder that contains subfolder '\Objects'")
		Do While Not(File.exists(projectB, "\Objects"))
			Dim sf As Object = xui.MsgboxAsync("Project folder does not contain subfolder '\Objects'" & CRLF & "Try again", "Error")
			Wait For (sf) Msgbox_Result (Result As Int)
			projectB = chooseProject("Select folder for Project 'B'   This is the folder that contains subfolder '\Objects'")
		Loop
		File.WriteString(projectA & "\Objects", "SubComparator_projectB.txt", projectB)
	End If
	
	B4XPages.AddPageAndCreate("mods", mods)
	B4XPages.AddPageAndCreate("diff", diff)

	Sleep(10)
	startProcess
End Sub

private Sub startProcess
	mods.show(projectA, projectB)
	B4XPages.ShowPage("mods")
	Sleep(0)
	B4XPages.ClosePage(Me)
End Sub

Private Sub chooseProject(title As String) As String	'ignore
	Public dirchoose As DirectoryChooser
	dirchoose.initialize
	dirchoose.Title = title
	Dim myDir As String = projectA
	myDir = myDir.subString2(0, myDir.LastIndexOf("\"))
	If File.Exists(myDir, "B4XMainPage.bas") Then 
		myDir = myDir.subString2(0, myDir.LastIndexOf("\"))	
	End If
	dirchoose.InitialDirectory = myDir
	Return dirchoose.Show(B4XPages.GetNativeParent(Me))
End Sub

Public Sub resetModuleA
	projectA = chooseProject("Select folder for Project 'A'   This is the folder that contains subfolder '\Objects'")
	Do While Not(File.exists(projectB, "\Objects"))
		Dim sf As Object = xui.MsgboxAsync("Project folder does not contain subfolder '\Objects'" & CRLF & "Try again", "Error")
		Wait For (sf) Msgbox_Result (Result As Int)
		projectA = chooseProject("Select folder for Project 'A'   This is the folder that contains subfolder '\Objects'")
	Loop
	mods.show(projectA, projectB)
	Sleep(10)
	B4XPages.ShowPage("mods")
End Sub

Public Sub resetModuleB
	projectB = chooseProject("Select folder for Project 'B'   This is the folder that contains subfolder '\Objects'")
	Do While Not(File.exists(projectB, "\Objects"))
		Dim sf As Object = xui.MsgboxAsync("Project folder does not contain subfolder '\Objects'" & CRLF & "Try again", "Error")
		Wait For (sf) Msgbox_Result (Result As Int)
		projectB = chooseProject("Select folder for Project 'B'   This is the folder that contains subfolder '\Objects'")
	Loop
	File.WriteString(projectA & "\Objects", "SubComparator_projectB.txt", projectB)
	mods.show(projectA, projectB)
	Sleep(10)
	B4XPages.ShowPage("mods")
End Sub

'    Dim jo As JavaObject
'    jo.InitializeStatic("java.awt.Toolkit")
'    jo = jo.RunMethodJO("getDefaultToolkit", Null)
'    Dim ScreenSize As JavaObject = jo.RunMethodJO("getScreenSize", Null)
'    screenW = ScreenSize.RunMethod("getWidth", Null)
'	screenH = ScreenSize.RunMethod("getHeight", Null)