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
	Private btnPlay As B4XView
	Private btnStop As B4XView
	Private btnIsPalying As B4XView
	Private btnPrev As B4XView
	Private btnNext As B4XView
	Private seekVolume As SeekBar	
	Public lblRadioStationName As B4XView
	Public lblSong As B4XView
	Public lblBitRate As B4XView
	Public lblGenre As B4XView
	Public lblStatus As B4XView
End Sub

Public Sub Initialize
End Sub


' Check manifest in this example project
' CreateResourceFromFile(Macro, Core.NetworkClearText) - must be addedd for HTTP streams, without NetworkClearText only HTTPS streams work


Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "PndAudioExoPlayer Example")
	StartService(ServicePlayer)
End Sub

Private Sub btnPlay_Click
	ClearAll
	If IsPaused(ServicePlayer) Then
		StartService(ServicePlayer)
		Sleep(1000)
	End If
	CallSub(ServicePlayer, "Play")
End Sub

Private Sub btnStop_Click
	ClearAll
	CallSub(ServicePlayer, "Stop")
End Sub

Private Sub btnPrev_Click
	ClearAll
	If IsPaused(ServicePlayer) Then
		StartService(ServicePlayer)
		Sleep(1000)
	End If
	CallSub(ServicePlayer, "PreviousStation")
End Sub

Private Sub btnNext_Click
	ClearAll
	If IsPaused(ServicePlayer) Then
		StartService(ServicePlayer)
		Sleep(1000)
	End If
	CallSub(ServicePlayer, "NextStation")
End Sub

Private Sub btnIsPalying_Click
	If IsPaused(ServicePlayer) Then
		StartService(ServicePlayer)
		Sleep(1000)
	End If
	ToastMessageShow("Is playing: " & CallSub(ServicePlayer, "IsPlayerPlaying"), False)
End Sub

Private Sub seekVolume_ValueChanged (Value As Int, UserChanged As Boolean)	
	Dim Volume As Float = Value / 100
	CallSub2(ServicePlayer, "SetPlayerVolume", Volume)
End Sub

Public Sub ClearAll
	lblRadioStationName.Text = ""
	lblSong.Text = ""
	lblBitRate.Text = ""
	lblGenre.Text = ""
End Sub


