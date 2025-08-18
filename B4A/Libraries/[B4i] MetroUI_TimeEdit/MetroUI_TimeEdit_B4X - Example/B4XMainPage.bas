B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True

#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private MetroUI_TimeEdit1 As MetroUI_TimeEdit
	Private MetroUI_TimeEdit2 As MetroUI_TimeEdit
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	MetroUI_TimeEdit1.Hour_Text.Text="23"
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Log(MetroUI_TimeEdit1.Time)
End Sub

Private Sub Time_Second_Button_Click
	Log(MetroUI_TimeEdit1.Time)
End Sub

Private Sub Time_Button_Click
	Log(MetroUI_TimeEdit2.Time)
End Sub
