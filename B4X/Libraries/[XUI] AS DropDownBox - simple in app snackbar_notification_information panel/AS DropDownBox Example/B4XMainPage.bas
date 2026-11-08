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
	Private ddb As ASDropDownBox
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS DropDownBox Example")
	
	Sleep(250)
	
	ddb.Initialize(Me,"ddb")
	ddb.Padding = 20dip 'standard is 0
	ddb.ShowAlignment = ddb.ShowAlignment_TOP 'standard is TOP
	ddb.ShowAnimationDuration = 250 'standard is 500
	
	Sleep(3000)
	ddb.Show(Root,"Test text only one line...")
	Sleep(3000)
	ddb.Hide
	Sleep(3000)	
	ddb.Show(Root,$"B4A includes all the features needed to quickly develop any type of Android app.
B4A is used by tens of thousands of developers from all over the world, including companies such as NASA, HP, IBM and others.
Together with B4i you can easily develop applications for both Android and iOS.
B4A is 100% free."$)
	
End Sub

Private Sub ddb_Click
	Log("click")
End Sub