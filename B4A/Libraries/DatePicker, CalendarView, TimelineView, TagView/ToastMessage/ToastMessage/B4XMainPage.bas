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
	
	Private mPanel As B4XView
	Private mLabel As B4XView
	Private mTarget As B4XView
	Private DurationMs As Int = 3000
	Private Panel1 As Panel
	Private Tmsg As ToastMessage
	Private Button2 As Button
	Private Button3 As Button
	Private Button4 As Button
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Tmsg.Initialize(Me, "Tmsg", Root)
	
End Sub

Private Sub Button1_Click
	Tmsg.MakeText("This event will be called once", Tmsg.TYPE_ERROR)
	Tmsg.Show(500)
End Sub

Private Sub Button2_Click
	Tmsg.MakeText("Design Toast is a custom Toast Library in Android using B4X", Tmsg.TYPE_INFO)
	Tmsg.Show(500)
End Sub

Private Sub Button3_Click
	Tmsg.MakeText("This is a SUCCESS Toast", Tmsg.TYPE_SUCCESS)
	Tmsg.Show(500)
End Sub

Private Sub Button4_Click
	Tmsg.MakeText("This is a WARNING Toast", Tmsg.TYPE_WARNING)
	Tmsg.Show(500)
End Sub