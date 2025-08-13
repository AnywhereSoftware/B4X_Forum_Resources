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
	Dim SecondPage As NoActionbarPage
	SecondPage.Initialize
	B4XPages.AddPage("SecondPage", SecondPage)
End Sub

Private Sub Button1_Click
	B4XPages.ShowPage("SecondPage")
End Sub

Private Sub B4XPage_Appear
	Dim jo As JavaObject = B4XPages.GetManager.ActionBar
	jo.RunMethod("show", Null)
	Root.Parent.Height = 100%y
End Sub