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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XFallingSand.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private gm As Game
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'Root.LoadLayout("1")
	gm.Initialize(Root)
	gm.Utils.Start
End Sub

Private Sub B4XPage_Foreground
	If gm.IsInitialized Then
		gm.Utils.Start
	End If
End Sub

Private Sub B4XPage_Background
	gm.Utils.Stop
End Sub