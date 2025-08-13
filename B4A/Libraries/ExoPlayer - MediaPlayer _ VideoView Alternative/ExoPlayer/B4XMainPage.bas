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
	Private SimpleExoPlayerView1 As SimpleExoPlayerView
	Private player1 As SimpleExoPlayer
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	player1.Initialize("player")
	Dim sources As List
	sources.Initialize
	sources.Add(player1.CreateUriSource("https://html5demos.com/assets/dizzy.mp4"))
	player1.Prepare(player1.CreateListSource(sources))
	SimpleExoPlayerView1.Player = player1
	player1.Play
End Sub

Sub Player_Ready
	Log("Ready")
End Sub

Sub Player_Error (Message As String)
	Log("Error: " & Message)
End Sub

Sub Player_Complete
	Log("complete")
End Sub