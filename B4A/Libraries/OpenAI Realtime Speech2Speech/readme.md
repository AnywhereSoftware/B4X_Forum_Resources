### OpenAI Realtime Speech2Speech by Blueforcer
### 05/01/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/166810/)

[HEADING=1]🔊 Realtime Speech-to-Speech with OpenAI GPT-4o[/HEADING]  
  
This small example project demonstrates how to build a **realtime speech-to-speech assistant** in B4A using OpenAI’s **GPT-4o realtime API** and a direct **WebSocket** connection — all in just about 100 lines of code!  
  
**Example with functioncalls in my current and biggest B4A Project (german audio).   
Code with function calls will be added soon!**   
  
[MEDIA=youtube]W33VXSAqlp8[/MEDIA]  
  
**You need to enter a valid OpenAI API Key with access to GPT-4o realtime in the class globals!**  
[HEADING=2]🎯 Features:[/HEADING]  

- Realtime speech input & AI-generated speech output via multimodal model
- Uses the AudioStreamer object for input and playback
- Fully event-driven WebSocket communication
- Minimal layout with a ToggleButton and Label

[HEADING=2]🧠 How It Works[/HEADING]  

1. **Audio Input (Microphone → AI):**

- When you press the ToggleButton, the app starts recording audio via AudioStreamer.
- Each audio buffer is base64-encoded and sent in realtime using a WebSocket message of type input\_audio\_buffer.append.

2. **Session Initialization:**

- On connection, the app sends a session.update JSON payload defining:

- Input/output audio format (pcm16)
- Voice ("sage")
- Transcription model (whisper-1)
- Turn detection and silence thresholds
- Modalities (["text", "audio"])

3. **AI Response (Audio):**

- The API sends audio chunks as response.audio.delta messages, base64-encoded.
- Audio response chunks are decoded and written directly to AudioStreamer.

4. **Looping Conversation:**

- On response.audio.done, playback finishes and switches back to recording — enabling seamless continuous conversation.

To ensure a clean audio interaction and avoid false detections or feedback issues, **the microphone is deactivated during the playback of the AI's response**. This design decision was made because in testing, the recorder consistently picked up the spoken output from the device’s speakers and interpreted it as new input.  
As a result:  

- The response cannot be interrupted once playback starts. (Except of the toggle switch, but new start will create a new session)
- The system resumes listening **only after** the full audio response has finished.
- This avoids self-triggering loops or premature cut-offs of speech.

  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private streamer As AudioStreamer  
    Private rp As RuntimePermissions  
    Private su As StringUtils  
    Private socket As WebSocket  
    Private sessionId As String  
    Private apiKey As String = "sk-proj-…"  
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
            lblStatus.Text = "Listening…"  
        Case "response.audio.delta"  
            Dim audioData As String = response.Get("delta")  
            streamer.Write(su.DecodeBase64(audioData))  
            lblStatus.Text = "Playing response…"  
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
    lblStatus.Text = "Listening…"  
End Sub  
  
' Handles toggle button to start or stop the streaming session  
Private Sub btnToggle_CheckedChange(Checked As Boolean)  
    If Checked Then  
        lblStatus.Text = "Connecting…"  
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
```