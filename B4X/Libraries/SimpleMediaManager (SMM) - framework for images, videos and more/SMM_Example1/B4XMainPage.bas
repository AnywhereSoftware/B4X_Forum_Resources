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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=SMM_Example1.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Pane1 As B4XView
	Private Pane2 As B4XView
	Private Pane3 As B4XView
	Private Pane4 As B4XView
	Private MediaManager As SimpleMediaManager
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	MediaManager.Initialize
	MediaManager.SetMedia(Pane1, "https://b4x-4c17.kxcdn.com/android/forum/data/avatars/o/102/102342.jpg?1496491953")
	
	Dim extra As Map = CreateMap(MediaManager.REQUEST_ROUNDIMAGE: True, MediaManager.REQUEST_BACKGROUND: xui.Color_Yellow)
	MediaManager.SetMediaWithExtra(Pane2, "https://b4x-4c17.kxcdn.com/android/forum/data/avatars/o/102/102342.jpg?1496491953", "", extra)
	'for this one you need to add SMM_GIF to the build configuration (Ctrl + B) and add a reference to B4XGifView
	#if SMM_GIF
	MediaManager.SetMedia(Pane4, "https://www.b4x.com/android/forum/attachments/anywhere-sw-gif.87363/")
	#End If
	'and for this one you need to add SMM_VIDEO to the build configuration (Ctrl + B) and add a reference to: B4J - MediaView, B4i - iUI8, B4A - ExoPlayer
	#if SMM_VIDEO
	MediaManager.SetMedia(Pane3, "https://player.vimeo.com/external/354886143.hd.mp4?s=2e182d1b22282a63a9533ffda5bb0b2295cdb8e6&profile_id=175")
	#End If
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	MediaManager.PanelResized(Pane3)
End Sub
