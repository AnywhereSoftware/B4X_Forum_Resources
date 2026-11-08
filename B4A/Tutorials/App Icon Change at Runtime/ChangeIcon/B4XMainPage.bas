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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=ChangeIcon.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private JavaObject1 As JavaObject
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	JavaObject1.InitializeContext
End Sub

Private Sub btnIcon1_Click
	JavaObject1.RunMethod("changeIcon", Array($"${Application.PackageName}.main"$)) 'icon default
	Log("Close App")
	CloseActivity
End Sub

Private Sub btnIcon2_Click
	JavaObject1.RunMethod("changeIcon", Array($"${Application.PackageName}.special1"$))
	Log("Close App")
	CloseActivity
End Sub

Private Sub CloseActivity
'	Dim jo As JavaObject
'	jo.InitializeContext
	JavaObject1.RunMethod("finishAffinity", Null)
End Sub