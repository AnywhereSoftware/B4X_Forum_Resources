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
	Private fB4XPage2 As B4XPage2
	Private fB4XPage3 As B4XPage3
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("B4XMainPage")
	fB4XPage2.Initialize
	B4XPages.AddPage("page2",fB4XPage2)
	fB4XPage3.Initialize
	B4XPages.AddPage("page3",fB4XPage3)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub fButton2_Click
	B4XPages.ShowPage("page2")
End Sub

Private Sub fButton3_Click
	B4XPages.ShowPage("page3")
End Sub