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

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

Private Sub SpinnerX1_ChangeValue(value As Int)
	Log("Spinner1 value : "&value)
End Sub

Private Sub SpinnerX2_ChangeValue(value As Int)
	Log("Spinner2 value : "&value)
End Sub

Private Sub SpinnerX3_ChangeValue(value As Int)
	Log("Spinner3 value : "&value)
End Sub

Private Sub SpinnerX4_ChangeValue(value As Int)
	Log("Spinner4 value : "&value)
End Sub

Private Sub SpinnerX5_ChangeValue(value As Int)
	Log("Spinner5 value : "&value)
End Sub

Private Sub SpinnerX6_ChangeValue(value As Int)
	Log("Spinner6 value : "&value)
End Sub