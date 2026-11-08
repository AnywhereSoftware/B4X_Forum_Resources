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
	Public SimpleExoPlayerView1 As SimpleExoPlayerView
	Public Player As SimpleExoPlayer
	Private lblEnterFullScreen As B4XView
	Private VideoWidth, VideoHeight As Int
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Player.Initialize("Player")
	Player.Prepare(Player.CreateUriSource("https://bestvpn.org/html5demos/assets/dizzy.mp4"))
	SimpleExoPlayerView1.Player = Player
	Player.Play
	lblEnterFullScreen.Visible = False
End Sub

Private Sub Player_Ready
	Dim VideoFormat As JavaObject = Player
	VideoFormat = VideoFormat.GetFieldJO("player").RunMethod("getVideoFormat", Null)
	VideoWidth = VideoFormat.GetField("width")
	VideoHeight = VideoFormat.GetField("height")
	lblEnterFullScreen.Visible = True
	PutLabelInVideoTopRightCorner(SimpleExoPlayerView1, lblEnterFullScreen)
End Sub

Public Sub PutLabelInVideoTopRightCorner(PlayerView As SimpleExoPlayerView, Label As B4XView)
	Dim PlayerRatio As Float = PlayerView.Width / PlayerView.Height
	Dim VideoRatio As Float = VideoWidth / VideoHeight
	Dim scale As Float = IIf(PlayerRatio > VideoRatio, PlayerView.Height / VideoHeight, PlayerView.Width / VideoWidth)
	Label.Top = PlayerView.Top + PlayerView.Height / 2 - VideoHeight / 2 * scale
	Label.Left = PlayerView.Left + PlayerView.Width / 2 + VideoWidth / 2 * scale - Label.Width
End Sub

Private Sub lblEnterFullScreen_Click
	StartActivity(FullScreen)
End Sub