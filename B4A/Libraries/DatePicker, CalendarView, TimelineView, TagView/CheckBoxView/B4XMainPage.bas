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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CheckBoxView1 As CheckBoxView
	Private CheckBoxView2 As CheckBoxView
	Private CheckBoxView3 As CheckBoxView
	Private RadioButtonView1 As RadioButtonView
	Private RadioButtonView2 As RadioButtonView
	Private RadioButtonView3 As RadioButtonView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	CheckBoxView1.setText("Conduct user interview to understand financial habits.")
	CheckBoxView2.setText("Define key user personas And journey maps.")
	CheckBoxView2.Color(Colors.Red)
	CheckBoxView2.Checked = True
	
	CheckBoxView3.setText("Analyze competitor finance apps for feuture gaps.")
	CheckBoxView3.Color(Colors.Green)
	CheckBoxView3.Disabled = True
	
	RadioButtonView1.setText("Radio Button View 1")
	
	RadioButtonView2.Color(Colors.Magenta)
	RadioButtonView2.Checked = True
	
	RadioButtonView3.Disabled = True
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub