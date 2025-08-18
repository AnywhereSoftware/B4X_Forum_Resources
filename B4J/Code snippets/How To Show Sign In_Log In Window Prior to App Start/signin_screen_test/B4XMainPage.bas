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
	Private win_SignIn As page_SignIn
End Sub

Public Sub Initialize
	Log("MainPage initialize")
	win_SignIn.Initialize
	B4XPages.AddPage("SignIn",win_SignIn)
	B4XPages.ShowPage("SignIn")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Log("MainPage created")
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"Home")
	B4XPages.GetNativeParent(Me).SetWindowSizeLimits(600.0,600.0,600.0,600.0)
End Sub
