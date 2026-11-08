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

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private streamer As AudioStreamer
	Private rp As RuntimePermissions
	Private su As StringUtils
	Private socket As WebSocket
	Private sessionId As String
	Private apiKey As String = "sk-proj-..."
	Private lblStatus As Label
	Private btnToggle As ToggleButton
End Sub

' Initializes the audio streamer and WebSocket connection
Public Sub Initialize
	streamer.Initialize("streamer", 24000, True, 16, streamer.VOLUME_MUSIC)
	socket.Initialize("socket")
End Sub

' Page setup and permission request
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "Realtime Speech2Speech")
	Root.LoadLayout("MainPage")

	rp.CheckAndRequest(rp.PERMISSION_RECORD_AUDIO)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		lblStatus.Text = "Microphone permission is required"
		btnToggle.Enabled = False
	End If
End Sub

' Establishes the WebSocket connection to OpenAI's Realtime API
Private Sub Connect
	socket.Headers = CreateMap( _
        "Authorization": "Bearer " & apiKey, _
        "OpenAI-Beta": "realtime=v1")
	socket.Connect("wss://api.openai.com/v1/realtime?model=gpt-4o-realtime-preview")
End Sub

' Handles incoming messages from the WebSocket
Private Sub socket_TextMessage (Message As String)
	Dim response As Map = Message.As(JSON).ToMap
	Dim eventType As String = response.Get("type")
	Select eventType
		Case "response.created"
			streamer.StopRecording
			streamer.StartPlaying
		Case "session.created"
			sessionId = response.Get("event_id")
		Case "session.updated"
			lblStatus.Text = "Listening..."
		Case "response.audio.delta"
			Dim audioData As String = response.Get("delta")
			streamer.Write(su.DecodeBase64(audioData))
			lblStatus.Text = "Playing response..."
		Case "response.audio.done"
			streamer.Write(Null)
	End Select
End Sub

' Sends the recorded audio buffer to the WebSocket
Private Sub streamer_RecordBuffer (Buffer() As Byte)
	Dim encoded As String = su.EncodeBase64(Buffer)
	socket.SendText($"{
        "event_id": "${sessionId}",
        "type": "input_audio_buffer.append",
        "audio": "${encoded}"
    }"$)
End Sub

' Restarts recording after playback finishes
Private Sub streamer_PlaybackComplete
	streamer.StartRecording
	lblStatus.Text = "Listening..."
End Sub

' Handles toggle button to start or stop the streaming session
Private Sub btnToggle_CheckedChange(Checked As Boolean)
	If Checked Then
		lblStatus.Text = "Connecting..."
		Connect
		Wait For socket_Connected
		socket.SendText(SessionUpdateMessage)
		streamer.StartRecording
	Else
		socket.Close
		streamer.StopRecording
		streamer.StopPlaying
		lblStatus.Text = "Session stopped"
	End If
End Sub

' Returns the JSON string for session setup
Private Sub SessionUpdateMessage As String
	Return $"{
        "event_id": "${sessionId}",
        "type": "session.update",
        "session": {
            "modalities": ["text", "audio"],
            "voice": "sage",
            "input_audio_format": "pcm16",
            "output_audio_format": "pcm16",
            "input_audio_transcription": {
                "model": "whisper-1"
            },
            "input_audio_noise_reduction": {
                "type": "far_field"
            },
            "turn_detection": {
                "type": "server_vad",
                "threshold": 0.5,
                "prefix_padding_ms": 300,
                "silence_duration_ms": 500,
                "create_response": true
            },
            "tools": [],
            "tool_choice": "auto",
            "temperature": 0.8,
            "max_response_output_tokens": "inf"
        }
    }"$
End Sub
