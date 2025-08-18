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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XCheckInternetLM_1_1_ex.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Public pagSomething As clspagSomething
	
	Private mFirstTimeAppeared As Boolean
	Public CheckInternet As B4XCheckInternetLM
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	mFirstTimeAppeared = True
	
	pagSomething.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.AddPage("pagSomething", pagSomething)
	CheckInternet.Initialize(Root)
End Sub

Private Sub B4XPage_Appear
	CheckInternet.ParentView = Root
	Wait For (CheckInternet.Check(True)) Complete(Result As Boolean)
	
	Dim Toast As BCToast
	Dim Msg As String = "Internet enabled = " & Result
	Toast.Initialize(Root)
	Toast.Show(Msg)
	Log(Msg)
	
	If Result Then
		ContinueHere
	Else
		ExitApplication
	End If
End Sub

Private Sub ContinueHere
	If mFirstTimeAppeared Then
		Root.LoadLayout("MainPage")
		mFirstTimeAppeared = False
	End If
End Sub


Private Sub btnOpenSomething_Click
	B4XPages.ShowPage("pagSomething")
End Sub