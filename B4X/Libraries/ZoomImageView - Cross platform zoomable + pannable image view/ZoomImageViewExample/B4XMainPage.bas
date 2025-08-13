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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=ZoomIVExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private ZoomImageView1 As ZoomImageView
End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	ZoomImageView1.SetBitmap(xui.LoadBitmap(File.DirAssets, "Wkipedia_blank_world_map.jpg"))
End Sub

Private Sub ZoomImageView1_Click
	Log("Click")
End Sub


