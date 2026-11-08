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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private ime As IME
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	ime.Initialize("")
	SetTopBarColorAndTitle(0xFF005CE2, xui.Color_White, "title here")
	Root.LoadLayout("MainPage")
End Sub

Private Sub SetTopBarColorAndTitle(BackgroundColor As Int, TitleColor As String, Title As String)
	Dim top As B4XView = xui.CreatePanel("")
	top.Color = BackgroundColor
	Dim act As Activity = B4XPages.GetNativeParent(Me)
	Dim r As Rect = ime.GetContentRect
	act.AddView(top, 0, 0, act.Width, r.Top)
	Dim cs As CSBuilder
	cs.Initialize.Color(TitleColor).Append(Title).Pop
	B4XPages.SetTitle(Me, cs)
End Sub

