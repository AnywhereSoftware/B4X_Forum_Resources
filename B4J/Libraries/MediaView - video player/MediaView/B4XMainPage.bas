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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=MediaViewExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private MediaView1 As MediaView
	
	Private MediaViewController1 As MediaViewController
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	B4XPages.SetTitle(Me, "MediaView Example")
	Root = Root1
	Root.LoadLayout("MainPage")
	MediaViewController1.SetMediaView(MediaView1)
	MediaView1.Source = "https://player.vimeo.com/external/354886143.hd.mp4?s=2e182d1b22282a63a9533ffda5bb0b2295cdb8e6&profile_id=175"
	MediaView1.Volume = 1
End Sub


Private Sub MediaView1_Error (Message As String)
	Log("Error: " & Message)
End Sub

Private Sub MediaView1_Complete
	Log("complete")
End Sub
