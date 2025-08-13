B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
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
	B4XPages.GetManager.LogEvents = False
	B4XPages.GetManager.TransitionAnimationDuration = 0
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	B4XPages.SetTitle(Me, "MediaView Example")
	Root = Root1
	Root.LoadLayout("MainPage")

'	***********  MediaViewController ***********

	'Example 1	
	MediaViewController1.SetBackgroundColor = xui.Color_ARGB(190,0,0,0)
	MediaViewController1.SetTextIconColor = xui.Color_White
	
	'Example 2
'	Dim Colors() As Int = Array As Int(xui.Color_Black, xui.Color_White)
'	MediaViewController1.SetBackgroundColorGradient(Colors, "BOTTOM_TOP")
'	MediaViewController1.SetTextIconColor = xui.Color_Black

	MediaViewController1.SetOnMouseOverVideo = True 
	
'	***********  MediaView ***********
	
	MediaView1.SetBackgroundColor = xui.Color_Black
	MediaView1.SetPreserveRatio = False

'	***********  Visualize ***********

'   Video
	Dim VideoURL As String = "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"

	MediaViewController1.SetMediaView(MediaView1)
	MediaView1.Source = VideoURL
	MediaView1.Play
End Sub

Private Sub MediaView1_Error (Message As String)
	Log("ERROR: " & Message)
End Sub

Private Sub MediaView1_Complete
	Log("COMPLETE")
End Sub

Private Sub MediaView1_StateChanged (State As String)
	Log(State)
End Sub
