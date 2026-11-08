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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private fx As JFX
	
	Private slv As SelectionListView
	
	Private AviableList As List 'list to pass to the class
	
	Private Pane1 As B4XView 'Container
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	AviableList.Initialize
	For i = 1 To 20
		AviableList.Add("#Item " & i)
	Next
	AviableList.Sort(True)
	
	slv.Initialize(Me, "NewList")
	slv.Setup(Pane1, B4XPages.MainPage.Root)
	slv.SetAvailableList(AviableList)
End Sub

Sub NewList(mList As List) 'Ignore
	Log("List received : " & mList)
End Sub

