B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.8
@EndOfDesignText@

'Code module

Sub Process_Globals
	Private nome As NativeObject
	Public isVisible As Boolean = False
	Public peerId As String = ""
	Public callType As String = ""
	Private SAMPLE_RATE As Float = 44100
	
	Private AudioEngine As NativeObject
	Private inAudioConverter,outAudioConverter As NativeObject
	Private AudioPlayerNode As NativeObject
	Public connected As Boolean = False
	Private callTimer As Timer
	Private ringer As MediaPlayer
	
	Private Page1 As Page
	Private peerIDLbl As Label
	Private AcceptCall As Button
	Private callStatus As Label
	Private endCall As Button
	Private RejectCall As Button
End Sub

Public Sub ShowPage
	nome = Me
	isVisible = True
	If peerId = "" Or callType = "" Then Main.NavControl.RemoveCurrentPage
	Page1.Initialize("Page1")
	Page1.RootPanel.LoadLayout("Call")
	Main.NavControl.ShowPage(Page1)
	callTimer.Initialize("callTimer",1000)
	callStatus.Tag = 0
	
	peerIDLbl.Text = peerId
	If callType = "out" Then
		endCall.Visible=True
		Dim j As JSONGenerator
		j.Initialize(CreateMap("from":Main.myID,"to":peerId))
		Main.socket.EmitString("call_out",j.ToString)
		callStatus.Text = "Calling"
		nome.RunMethod("SetAudioSessionInCall:",Array(True))
		EnableProximityMonitoring(True)
	Else
		nome.RunMethod("SetAudioSessionInCall:",Array(False))
		ringer.Initialize(File.DirAssets,"classic_ringtone.mp3","")
		ringer.Volume = 1
		ringer.Looping=True
		ringer.Play
	
		callStatus.Text = "Incoming Call"
		AcceptCall.Visible = True
		RejectCall.Visible = True
	End If
End Sub

Sub Page1_Disappear
	isVisible = False
	peerId = ""
	connected = False
	callType = ""
	Main.busy = False
	Main.socket.RemoveAllListener("audio_broadcast")
End Sub

Sub audiorecived(buffer() As Byte)
	If connected Then
		Dim nm As NativeObject = Me
		''The output format is float32 so we have to convert incoming int16 buffer to float32
		Dim data As Object = nm.RunMethod("NSDataToPCM:::",Array(nm.ArrayToNSData(buffer),outAudioConverter,SAMPLE_RATE))

		''Reseting the AudioConverter so that it can process the next buffer
		outAudioConverter.RunMethod("reset",Null)
		
		AudioPlayerNode.RunMethod("scheduleBuffer:completionHandler:",Array(data,Null))
		AudioPlayerNode.RunMethod("play",Null)
	End If
End Sub

Sub call_status(status As String)
	Select status
		Case "accept"
			initMicAndSpeaker
		Case "end"
			If Not(Main.busy) Then
				ringer.Stop
			End If
			Dim p As Phone
			p.Vibrate
			callStatus.Text = "Call Ended"
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
	
	startAudioEngine
	
	Main.socket.AddListener("audio_broadcast","audiorecived")
	
	connected = True
	Main.busy = True
End Sub

Sub stopRecording
	AcceptCall.Visible=False
	RejectCall.Visible=False
	endCall.Visible = True
	callTimer.Enabled=False
	endCall.Text = "Close"
	connected = False
	stopAudioEngine
	Main.busy = False
	nome.RunMethod("SetAudioSessionInCall:",Array(False))
	EnableProximityMonitoring(False)
End Sub

Sub RejectCall_Click
	ringer.Stop
	Dim j As JSONGenerator
	j.Initialize(CreateMap("from":Main.myID,"to":peerId))
	Main.socket.EmitString("call_reject",j.ToString)
	Main.NavControl.RemoveCurrentPage
End Sub

Sub endCall_Click
	If endCall.Text = "Close" Then
		Main.NavControl.RemoveCurrentPage
		Return
	End If
	stopRecording
	Dim j As JSONGenerator
	j.Initialize(CreateMap("from":Main.myID,"to":peerId))
	Main.socket.EmitString("call_end",j.ToString)
	Main.NavControl.RemoveCurrentPage
End Sub

Sub AcceptCall_Click
	ringer.Stop
	Dim j As JSONGenerator
	j.Initialize(CreateMap("from":Main.myID,"to":peerId))
	Main.socket.EmitString("call_accept",j.ToString)
	nome.RunMethod("SetAudioSessionInCall:",Array(True))
	EnableProximityMonitoring(True)
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


Sub startAudioEngine
	''check if its already running or not
	If AudioEngine.IsInitialized Then
		If AudioEngine.GetField("isRunning").AsBoolean = True Then
			Return
		End If
	End If
	
	''Initialize AudioEngine
	AudioEngine.Initialize("AVAudioEngine")
	AudioEngine = AudioEngine.RunMethod("alloc",Null).RunMethod("init",Null)
	
	
	''Intall a tap on the microphone, the buffer will be available in the AudioNodeTap_Event
	Dim AudioInputNode As NativeObject = AudioEngine.GetField("inputNode")
	AudioInputNode.RunMethodWithBlocks("installTapOnBus:bufferSize:format:block:",Array(0,1024,AudioInputNode.RunMethod("outputFormatForBus:",Array(0)),AudioEngine.CreateBlock("AudioNodeTap",2,False)))
	
	''Initialize audio player
	Dim AudioPlayerNode As NativeObject
	AudioPlayerNode.Initialize("AVAudioPlayerNode")
	AudioPlayerNode = AudioPlayerNode.RunMethod("alloc",Null).RunMethod("init",Null)
	AudioEngine.RunMethod("attachNode:",Array(AudioPlayerNode))
	AudioEngine.RunMethod("connect:to:format:",Array(AudioPlayerNode,AudioEngine.GetField("outputNode"),AudioInputNode.RunMethod("outputFormatForBus:",Array(0))))
	
	''Initailize the output format (iOS default sample rate is 44100)
	Dim toformatIn As NativeObject
	toformatIn.Initialize("AVAudioFormat")
	toformatIn=toformatIn.RunMethod("alloc",Null).RunMethod("initWithCommonFormat:sampleRate:channels:interleaved:",Array(3,SAMPLE_RATE,1,False))
	
	''Initialize the input AudioConverter
	inAudioConverter.Initialize("AVAudioConverter")
	inAudioConverter=inAudioConverter.RunMethod("alloc",Null).RunMethod("initFromFormat:toFormat:",Array(AudioInputNode.RunMethod("outputFormatForBus:",Array(0)),toformatIn))
	
	''Initailize the output format (iOS default sample rate is 44100)
	Dim toformatOut As NativeObject
	toformatOut.Initialize("AVAudioFormat")
	toformatOut=toformatOut.RunMethod("alloc",Null).RunMethod("initWithCommonFormat:sampleRate:channels:interleaved:",Array(1,SAMPLE_RATE,1,False))
	
	''Initialize the output AudioConverter
	outAudioConverter.Initialize("AVAudioConverter")
	outAudioConverter=outAudioConverter.RunMethod("alloc",Null).RunMethod("initFromFormat:toFormat:",Array(toformatIn,toformatOut))
	
	''Run the AudioEngine
	AudioEngine.RunMethod("prepare",Null)
	If AudioEngine.RunMethod("startAndReturnError:",Null).AsBoolean = False Then
		Msgbox("Cannot start audio engine","")
	End If
End Sub

Sub AudioNodeTap_Event(args() As Object)
	Dim no As NativeObject = Me

	''The first object is the uncompressed raw PCM buffer
	''The Objective C code is converting the Float32 buffer to Int16
	''And returning the buffer bytes as NSData
	Dim data As Object = no.RunMethod("PCMtoNSData::",Array(args(0),inAudioConverter))

	''We have to convert it to B4IArray to be able to send over internet
	Dim buffer() As Byte = no.NSDataToArray(data)
	
	''Reseting the AudioConverter so that it can process the next buffer
	inAudioConverter.RunMethod("reset",Null)
	
	''Send the byte array to the server
	Main.socket.EmitBinary("audio_received",buffer)
End Sub

Sub stopAudioEngine
	''If its runing then first removing the microphone tap and then stopping the AudioEngine
	If AudioEngine.IsInitialized And AudioEngine.GetField("isRunning").AsBoolean Then
		Dim AudioInputNode As NativeObject = AudioEngine.GetField("inputNode")
		AudioInputNode.RunMethod("removeTapOnBus:",Array(0))
		AudioPlayerNode.RunMethod("stop",Null)
		AudioEngine.RunMethod("reset",Null)
		AudioEngine.RunMethod("stop",Null)
	End If
End Sub

#if objc
-(NSData*) PCMtoNSData:(AVAudioPCMBuffer*) buffer :(AVAudioConverter*) converter{
	
	//Initalizing a Int16 empty buffer with the scaled frame capacity
	AVAudioPCMBuffer *outputBuffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:converter.outputFormat frameCapacity:(converter.outputFormat.sampleRate * buffer.frameLength / buffer.format.sampleRate)];
	outputBuffer.frameLength = outputBuffer.frameCapacity;
	
	//Converting the buffer
	AVAudioConverterOutputStatus oStatus = [converter convertToBuffer:outputBuffer error:nil withInputFromBlock:^(AVAudioPacketCount inNumberOfPackets, AVAudioConverterInputStatus *outStatus){
		*outStatus = AVAudioConverterInputStatus_HaveData;
		return buffer;
	}];
	
	//Storing inner raw buffer byte array to NSData
	NSData *values = [[NSData alloc] initWithBytes:outputBuffer.int16ChannelData[0] length:(outputBuffer.frameCapacity * outputBuffer.format.streamDescription->mBytesPerFrame)];
	return values;
}

-(AVAudioPCMBuffer*) NSDataToPCM:(NSData*) buffer :(AVAudioConverter*) converter :(float) rate{
	AVAudioFormat *bufferformat = [[AVAudioFormat alloc] initWithCommonFormat:3 sampleRate:rate channels:1 interleaved:false];
	
	//Initalizing a Int16 empty buffer with the scaled frame capacity
	AVAudioPCMBuffer *PCMbuffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:bufferformat frameCapacity:(buffer.length / bufferformat.streamDescription->mBytesPerFrame)];
	PCMbuffer.frameLength = PCMbuffer.frameCapacity;
	
	[buffer getBytes:PCMbuffer.int16ChannelData[0] length:buffer.length];
	
	//Initalizing a float32 empty buffer with the scaled frame capacity
	AVAudioPCMBuffer *outputBuffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:converter.outputFormat frameCapacity:(converter.outputFormat.sampleRate * PCMbuffer.frameLength / PCMbuffer.format.sampleRate)];
	outputBuffer.frameLength = outputBuffer.frameCapacity;
	
	//Converting the buffer
	AVAudioConverterOutputStatus oStatus = [converter convertToBuffer:outputBuffer error:nil withInputFromBlock:^(AVAudioPacketCount inNumberOfPackets, AVAudioConverterInputStatus *outStatus){
		*outStatus = AVAudioConverterInputStatus_HaveData;
		return PCMbuffer;
	}];
	
	return outputBuffer;
}

-(bool) SetAudioSessionInCall:(bool)enable{
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	NSError *err = nil;
	BOOL success;
	if(enable){
		success = [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeVoiceChat options:AVAudioSessionCategoryOptionDefaultToSpeaker error:&err];
	}else{
		success = [audioSession setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeDefault options:nil error:&err];
	}
	if (success) {
		success = [audioSession setActive:YES error:&err];
	}
	if (!success) [NSException raise:@"" format:@"Error setting audio session: %@", err];
	return success;
}
#End If

Sub EnableProximityMonitoring (enable As Boolean)
	Dim no As NativeObject
	no = no.Initialize("UIDevice").RunMethod("currentDevice", Null)
	no.SetField("proximityMonitoringEnabled", enable)
End Sub