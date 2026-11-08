B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.2
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	Dim peerId As String = ""
	Dim callType As String = ""
	Dim SAMPLE_RATE As Int = 44100
	Private ProximityWakeLock As JavaObject
	Dim callTimer As Timer
	Dim ringer As MediaPlayer
End Sub

Sub Globals
	Dim audioManager As JavaObject
	
	Public recoder As AudioStreamer
	
	Private peerIDLbl As Label
	Private AcceptCall As Button
	Private callStatus As Label
	Private endCall As Button
	Private RejectCall As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	If peerId = "" Or callType = "" Then Activity.Finish
	
	If ProximityWakeLock.IsInitialized = False Then
		Dim ctxt As JavaObject
		ProximityWakeLock = ctxt.InitializeContext.RunMethodJO("getSystemService", Array("power")).RunMethod("newWakeLock", Array(32, "proximity"))
	End If
	
	audioManager.InitializeContext
	audioManager = audioManager.RunMethod("getSystemService", Array("audio"))
	audioManager.RunMethod("setBluetoothScoOn",Array(False))
	audioManager.RunMethod("stopBluetoothSco",Null)
	
	recoder.Initialize2(7,"recoder",SAMPLE_RATE,True,16,recoder.VOLUME_VOICE_CALL)
	
	Activity.LoadLayout("Call")
	callTimer.Initialize("callTimer",1000)
	callStatus.Tag = 0
	
	peerIDLbl.Text = peerId
	If callType = "out" Then
		endCall.Visible=True
		Dim j As JSONGenerator
		j.Initialize(CreateMap("from":Starter.myID,"to":peerId))
		Starter.socket.emit("call_out",j.ToString)
		callStatus.Text = "Calling"
		audioManager.RunMethod("setMode",Array(3)) ''communication
		audioManager.RunMethod("setSpeakerphoneOn",Array(False)) ''output through earpiece
		ProximityWakeLock.RunMethod("acquire", Null)
	Else
		audioManager.RunMethod("setMode",Array(1)) ''ringing
		ringer.Initialize
		Dim jo As JavaObject=ringer
		jo.GetFieldJO("mp").runmethod("setAudioStreamType", Array(2))
		ringer.Load(File.DirAssets,"classic_ringtone.mp3")
		ringer.Looping=True
		ringer.Play
	
		callStatus.Text = "Incoming Call"
		AcceptCall.Visible = True
		RejectCall.Visible = True
	End If
	
End Sub

Sub Activity_Resume
	If Not(callTimer.Enabled) And Starter.busy Then callTimer.Enabled=True
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	If callTimer.Enabled Then callTimer.Enabled=False
End Sub

Sub recoder_RecordBuffer (Data() As Byte)
	If Starter.busy Then
		Dim b As B4XSerializator
		Starter.socket.emit("audio_received",b.ConvertObjectToBytes(Data))
	End If
End Sub

Sub audiorecived(buffer() As Byte)
	If Starter.busy Then
		recoder.Write(buffer)
	End If
End Sub

Sub call_status(status As String)
	Select status
		Case "accept"
			initMicAndSpeaker
		Case "end"
			If Not(Starter.busy) Then
				ringer.Stop
				ringer.Release
			End If
			callStatus.Text = "Call Ended"
			Dim v As PhoneVibrate
			v.Vibrate(300)
			stopRecording
		Case Else
			callStatus.Text = status.ToUpperCase
			stopRecording
	End Select
End Sub

Sub initMicAndSpeaker
	callStatus.Tag = 0
	callStatus.Text = "00:00"
	callTimer.Enabled=True
	AcceptCall.Visible=False
	RejectCall.Visible=False
	endCall.Visible = True
	
	Dim R As Reflector
	R.Target = recoder
	R.Target = R.GetField("track")
	Dim AudioSessionID As Int = R.RunMethod("getAudioSessionId")
	
	Dim NoiseSuppressor As JavaObject
	NoiseSuppressor.InitializeStatic("android.media.audiofx.NoiseSuppressor")
	If NoiseSuppressor.RunMethod("isAvailable",Null) Then NoiseSuppressor.RunMethod("create",Array(AudioSessionID))
	
	Dim AutomaticGainControl As JavaObject
	AutomaticGainControl.InitializeStatic("android.media.audiofx.AutomaticGainControl")
	If AutomaticGainControl.RunMethod("isAvailable",Null) Then AutomaticGainControl.RunMethod("create",Array(AudioSessionID))
	
	Dim AcousticEchoCanceler As JavaObject
	AcousticEchoCanceler.InitializeStatic("android.media.audiofx.AcousticEchoCanceler")
	If AcousticEchoCanceler.RunMethod("isAvailable",Null) Then AcousticEchoCanceler.RunMethod("create",Array(AudioSessionID))
	
	recoder.StartRecording
	recoder.StartPlaying
	
	Dim ctxt As JavaObject
	ctxt.InitializeContext.RunMethod("setVolumeControlStream",Array(0))
	
	Starter.busy = True
End Sub

Sub stopRecording
	AcceptCall.Visible=False
	RejectCall.Visible=False
	endCall.Visible = True
	callTimer.Enabled=False
	endCall.Text = "Close"
	recoder.Write(Null)
	recoder.StopPlaying
	recoder.StopRecording
	Starter.busy = False
	audioManager.RunMethod("setMode",Array(0)) ''normal
	ProximityWakeLock.RunMethod("release", Null)
	peerId = ""
	callType = ""
End Sub

Sub RejectCall_Click
	ringer.Stop
	ringer.Release
	Dim j As JSONGenerator
	j.Initialize(CreateMap("from":Starter.myID,"to":peerId))
	Starter.socket.emit("call_reject",j.ToString)
	Activity.Finish
End Sub

Sub endCall_Click
	If endCall.Text = "Close" Then
		Activity.Finish
		Return
	End If
	Dim j As JSONGenerator
	j.Initialize(CreateMap("from":Starter.myID,"to":peerId))
	stopRecording
	Starter.socket.emit("call_end",j.ToString)
	Activity.Finish
End Sub

Sub AcceptCall_Click
	ringer.Stop
	ringer.Release
	Dim j As JSONGenerator
	j.Initialize(CreateMap("from":Starter.myID,"to":peerId))
	Starter.socket.emit("call_accept",j.ToString)
	audioManager.RunMethod("setMode",Array(0)) ''communication
	audioManager.RunMethod("setSpeakerphoneOn",Array(False)) ''output through earpiece
	ProximityWakeLock.RunMethod("acquire", Null)
	initMicAndSpeaker
End Sub

Sub callTimer_Tick
	Dim s As Int = callStatus.Tag
	s = s+1
	callStatus.Tag = s
	Dim m As Int = s/60
	Dim ss As Int = s-(m*60)
	callStatus.Text = m &":"& ss
End Sub
