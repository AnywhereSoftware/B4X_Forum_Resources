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
	Private ProgressBar_JE1 As ProgressBar_JE
	Private ProgressBar_JE2 As ProgressBar_JE
	Private ProgressBar_JE3 As ProgressBar_JE
	Private ProgressBar_JE4 As ProgressBar_JE
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	ProgressBar_JE1.SetAlarm1(True, 80, xui.Color_Red, xui.Color_Red)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	ProgressBar_JE1.Progress(Rnd(1, 101), 0)
	
	Dim value As Float = Rnd(1, 3001)
	Dim maxvalue As Float = 3000
	ProgressBar_JE2.Progress(value * 100 / maxvalue, value)

	ProgressBar_JE3.Progress(Rnd(1, 101), 0)
	
	Dim value2 As Float = Rnd(1, 901)
	Dim maxvalue2 As Float = 900
	ProgressBar_JE4.Progress(value2 * 100 / maxvalue2, value2)

End Sub

Private Sub ProgressBar_JE1_Alarm1(Value As Float)
	Log(Value)
End Sub