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
	Private streamer As AudioStreamer
	Private buffers As List
	Private timer1 As Timer
	Private recordingStart As Long
	Dim Label1 As B4XView
	Dim btnPlay As B4XView
	Dim btnStartRecording As B4XView
	Private rp As RuntimePermissions
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	
	buffers.Initialize
	timer1.Initialize("timer1", 1000)
End Sub

Private Sub streamer_RecordBuffer (Buffer() As Byte)
	buffers.Add(Buffer)
End Sub

Private Sub btnStartRecording_Click
	rp.CheckAndRequest(rp.PERMISSION_RECORD_AUDIO)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		xui.MsgboxAsync("No permission", "")
		Return
	End If
	If streamer.PlayerBufferSize = 0 Then
		streamer.Initialize("streamer", 44100, True, 16, streamer.VOLUME_MUSIC)
	End If
	buffers.Clear
	streamer.StartRecording
	recordingStart = DateTime.Now
	timer1.Enabled = True
	Timer1_Tick
	btnPlay.Enabled = False
End Sub

Private Sub Timer1_Tick
	Label1.Text = "Recording: " & _
		Round((DateTime.Now - recordingStart) / DateTime.TicksPerSecond) & " seconds"
End Sub

Private Sub btnStopRecording_Click
	streamer.StopRecording
	timer1.Enabled = False
	btnPlay.Enabled = True
	Label1.Text = ""
End Sub

Private Sub btnPlay_Click
	btnStartRecording.Enabled = False
	streamer.StartPlaying
	For Each b() As Byte In buffers
		streamer.Write(b)
	Next
	streamer.Write(Null) 'when this "message" will be processed, the player will stop.
End Sub

Private Sub streamer_PlaybackComplete
	Log("PlaybackComplete")
	btnStartRecording.Enabled = True
End Sub