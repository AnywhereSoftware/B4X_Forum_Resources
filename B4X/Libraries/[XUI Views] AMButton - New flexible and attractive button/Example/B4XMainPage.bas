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
	
	Private AMButton1 As AMButton
	Private AMButton2 As AMButton
	Private AMButton3 As AMButton
	Private AMButton4 As AMButton
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub AMButton4_Click
	AMButton4.mLbl.Text = "Clicked"
End Sub

Private Sub AMButton3_Click
	AMButton3.mLbl.Text = "Clicked"
End Sub

Private Sub AMButton2_Click
	AMButton2.mLbl.Text = "Clicked"
End Sub

Private Sub AMButton1_Click
	AMButton1.mLbl.Text = "Clicked"
End Sub