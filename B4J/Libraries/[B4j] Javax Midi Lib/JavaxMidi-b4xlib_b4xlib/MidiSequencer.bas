B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#Event: MetaEvent(Msg As MidiMetaMessage)
#Event: ControllerEvent(Msg As MidiShortMessage)
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private TJO As JavaObject
	Private MetaListeners As List
	Private ControlListeners As List
	Private mMetaListener As Object
	Private mControlListener As Object

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	MetaListeners.Initialize
	ControlListeners.Initialize
End Sub


'Registers a meta-event listener to receive notification whenever a meta-event is encountered in the sequence and processed by the sequencer.
Public Sub AddControllerEventListener(Module As Object,EventName As String,Controllers() As Int)
	If SubExists(Module,EventName & "_ControllerEvent") And FindControlListener(Module,EventName) = -1 Then
		Dim MLT As MidiListenerClass
		MLT.Initialize(Module,EventName)
		If ControlListeners.Size = 0 Then
			mControlListener = TJO.CreateEvent("javax.sound.midi.ControllerEventListener","ControlerListener",Null)
			TJO.RunMethod("addControllerEventListener",Array As Object(mControlListener,Controllers))
		End If
		ControlListeners.Add(MLT)
	End If
End Sub

'Removes a controller event listener's interest in one or more types of controller event.
Public Sub RemoveControlListener(Module As Object,EventName As String) As Boolean
'	For i = 0 To ControlListeners.Size - 1
		Dim Pos As Int = FindControlListener(Module,EventName)
		If Pos > -1 Then
			ControlListeners.RemoveAt(Pos)
			If ControlListeners.Size = 0 Then
				TJO.RunMethod("removeControllerEventListener",Array(mControlListener))
			End If
			Return True
		End If
'	Next
	Return False
End Sub

Private Sub FindControlListener(Module As Object,EventName As String) As Int
	For  i = 0 To ControlListeners.Size - 1
		Dim T As MidiListenerClass = ControlListeners.Get(i)
		If T.Callback = Module And T.EventName = EventName Then
			Return i
		End If
	Next
	Return -1
End Sub

Private Sub ControlerListener_Event(MethodName As String,Args() As Object) As Object				'ignore
	If MethodName = "hashCode" Then Return 0
	If MethodName = "toString" Then Return ""
	If MethodName = "equals" Then Return False
	For Each MLT As MidiListenerClass In ControlListeners
		Dim SM As MidiShortMessage
		SM.Initialize
		SM.SetObject(Args(0))
		CallSub2(MLT.Callback,MLT.EventName & "_ControllerEvent",SM)
	Next
End Sub

'Registers a meta-event listener to receive notification whenever a meta-event is encountered in the sequence and processed by the sequencer.
Public Sub AddMetaEventListener(Module As Object,EventName As String)
	If SubExists(Module,EventName & "_MetaEvent") And FindMetaListener(Module,EventName) = -1 Then
		Dim MLT As MidiListenerClass
		MLT.Initialize(Module,EventName)
		If MetaListeners.Size = 0 Then
			mMetaListener = TJO.CreateEvent("javax.sound.midi.MetaEventListener","MetaListener","")
			TJO.RunMethod("addMetaEventListener",Array As Object(mMetaListener))
		End If
		MetaListeners.Add(MLT)
	End If
End Sub

'Removes the specified meta-event listener from this sequencer's list of registered listeners, if in fact the listener is registered.
Public Sub RemoveMetaListener(Module As Object,EventName As String) As Boolean
'	For i = 0 To MetaListeners.Size - 1
		Dim Pos As Int = FindMetaListener(Module,EventName)
		If Pos > -1 Then
			MetaListeners.RemoveAt(Pos)
			If MetaListeners.Size = 0 Then
				TJO.RunMethod("removeMetaEventListener",Array(mMetaListener))
			End If
			Return True
		End If
'	Next
	Return False
End Sub

Private Sub FindMetaListener(Module As Object,EventName As String) As Int
	For  i = 0 To MetaListeners.Size - 1
		Dim T As MidiListenerClass = MetaListeners.Get(i)
		If T.Callback = Module And T.EventName = EventName Then
			Return i
		End If
	Next
	Return -1
End Sub

Private Sub MetaListener_Event(MethodName As String,Args() As Object) As Object				'ignore
	If MethodName = "hashCode" Then Return 0
	If MethodName = "toString" Then Return ""
	If MethodName = "equals" Then Return False
	For Each MLT As MidiListenerClass In MetaListeners
		Dim MM As MidiMetaMessage
		MM.Initialize
		MM.SetObject(Args(0))
		CallSub2(MLT.Callback,MLT.EventName & "_MetaEvent",MM)
	Next
End Sub

'Obtains the number of repetitions for playback.
Public Sub GetLoopCount As Int
	Return TJO.RunMethod("getLoopCount",Null)
End Sub
'Obtains the end position of the loop, in MIDI ticks.
Public Sub GetLoopEndPoint As Long
	Return TJO.RunMethod("getLoopEndPoint",Null)
End Sub
'Obtains the start position of the loop, in MIDI ticks.
Public Sub GetLoopStartPoint As Long
	Return TJO.RunMethod("getLoopStartPoint",Null)
End Sub
'Obtains the current master synchronization mode for this sequencer.
Public Sub GetMasterSyncMode As JavaObject
	Return TJO.RunMethod("getMasterSyncMode",Null)
End Sub
'Obtains the set of master synchronization modes supported by this sequencer.
Public Sub GetMasterSyncModes As JavaObject
	Return TJO.RunMethod("getMasterSyncModes",Null)
End Sub
'Obtains the length of the current sequence, expressed in microseconds, or 0 if no sequence is set.
Public Sub GetMicrosecondLength As Long
	Return TJO.RunMethod("getMicrosecondLength",Null)
End Sub
'Obtains the current position in the sequence, expressed in microseconds.
Public Sub GetMicrosecondPosition As Long
	Return TJO.RunMethod("getMicrosecondPosition",Null)
End Sub
'Obtains the sequence on which the Sequencer is currently operating.
Public Sub GetSequence As MidiSequence
	Dim S As MidiSequence
	S.Initialize
	S.SetObject(TJO.RunMethod("getSequence",Null))
	Return S
End Sub
'Obtains the current slave synchronization mode for this sequencer.
Public Sub GetSlaveSyncMode As JavaObject
	Return TJO.RunMethod("getSlaveSyncMode",Null)
End Sub
'Obtains the set of slave synchronization modes supported by the sequencer.
Public Sub GetSlaveSyncModes As JavaObject
	Return TJO.RunMethod("getSlaveSyncModes",Null)
End Sub
'Returns the current tempo factor for the sequencer.
Public Sub GetTempoFactor As Float
	Return TJO.RunMethod("getTempoFactor",Null)
End Sub
'Obtains the current tempo, expressed in beats per minute.
Public Sub GetTempoInBPM As Float
	Return TJO.RunMethod("getTempoInBPM",Null)
End Sub
'Obtains the current tempo, expressed in microseconds per quarter note.
Public Sub GetTempoInMPQ As Float
	Return TJO.RunMethod("getTempoInMPQ",Null)
End Sub
'Obtains the length of the current sequence, expressed in MIDI ticks, or 0 if no sequence is set.
Public Sub GetTickLength As Long
	Return TJO.RunMethod("getTickLength",Null)
End Sub
'Obtains the current position in the sequence, expressed in MIDI ticks.
Public Sub GetTickPosition As Long
	Return TJO.RunMethod("getTickPosition",Null)
End Sub
'Obtains the current mute state for a track.
Public Sub GetTrackMute(T As Int) As Boolean
	Return TJO.RunMethod("getTrackMute",Array As Object(T))
End Sub
'Obtains the current solo state for a track.
Public Sub GetTrackSolo(T As Int) As Boolean
	Return TJO.RunMethod("getTrackSolo",Array As Object(T))
End Sub
'Indicates whether the Sequencer is currently recording.
Public Sub IsRecording As Boolean
	Return TJO.RunMethod("isRecording",Null)
End Sub
'Indicates whether the Sequencer is currently running.
Public Sub IsRunning As Boolean
	Return TJO.RunMethod("isRunning",Null)
End Sub
'Disables recording to the specified track.
Public Sub RecordDisable(T As MidiTrack)
	TJO.RunMethod("recordDisable",Array As Object(T.GetObject))
End Sub
'Prepares the specified track for recording events received on a particular channel.
Public Sub RecordEnable(T As MidiTrack, Channel As Int)
	TJO.RunMethod("recordEnable",Array As Object(T.GetObject, Channel))
End Sub
'Sets the number of repetitions of the loop for playback.
Public Sub SetLoopCount(Count As Int)
	TJO.RunMethod("setLoopCount",Array As Object(Count))
End Sub
'Sets the last MIDI tick that will be played in the loop.
Public Sub SetLoopEndPoint(Tick As Long)
	TJO.RunMethod("setLoopEndPoint",Array As Object(Tick))
End Sub
'Sets the first MIDI tick that will be played in the loop.
Public Sub SetLoopStartPoint(Tick As Long)
	TJO.RunMethod("setLoopStartPoint",Array As Object(Tick))
End Sub
'Sets the source of timing information used by this sequencer.
Public Sub SetMasterSyncMode(Sync As JavaObject)
	TJO.RunMethod("setMasterSyncMode",Array As Object(Sync))
End Sub
'Sets the current position in the sequence, expressed in microseconds
Public Sub SetMicrosecondPosition(Microseconds As Long)
	TJO.RunMethod("setMicrosecondPosition",Array As Object(Microseconds))
End Sub
'Sets the current sequence on which the sequencer operates.
Public Sub SetSequence(Stream As InputStream)
	TJO.RunMethod("setSequence",Array As Object(Stream))
End Sub
'Sets the current sequence on which the sequencer operates.
Public Sub SetSequence2(S As MidiSequence)
	TJO.RunMethod("setSequence",Array As Object(S.GetObject))
End Sub
'Sets the slave synchronization mode for the sequencer.
Public Sub SetSlaveSyncMode(Sync As JavaObject)
	TJO.RunMethod("setSlaveSyncMode",Array As Object(Sync))
End Sub
'Scales the sequencer's actual playback tempo by the factor provided.
Public Sub SetTempoFactor(Factor As Float)
	TJO.RunMethod("setTempoFactor",Array As Object(Factor))
End Sub
'Sets the tempo in beats per minute.
Public Sub SetTempoInBPM(Bpm As Float)
	TJO.RunMethod("setTempoInBPM",Array As Object(Bpm))
End Sub
'Sets the tempo in microseconds per quarter note.
Public Sub SetTempoInMPQ(Mpq As Float)
	TJO.RunMethod("setTempoInMPQ",Array As Object(Mpq))
End Sub
'Sets the current sequencer position in MIDI ticks
Public Sub SetTickPosition(Tick As Long)
	TJO.RunMethod("setTickPosition",Array As Object(Tick))
End Sub
'Sets the mute state for a track.
Public Sub SetTrackMute(T As Int, Mute As Boolean)
	TJO.RunMethod("setTrackMute",Array As Object(T, Mute))
End Sub
'Sets the solo state for a track.
Public Sub SetTrackSolo(T As Int, Solo As Boolean)
	TJO.RunMethod("setTrackSolo",Array As Object(T, Solo))
End Sub
'Starts playback of the MIDI data in the currently loaded sequence.
Public Sub Start
	TJO.RunMethod("start",Null)
End Sub
'Starts recording and playback of MIDI data.
Public Sub StartRecording
	TJO.RunMethod("startRecording",Null)
End Sub
'Stops recording, if active, and playback of the currently loaded sequence, if any.
Public Sub Stop
	TJO.RunMethod("stop",Null)
End Sub
'Stops recording, if active.
Public Sub StopRecording
	TJO.RunMethod("stopRecording",Null)
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

'Closes the device, indicating that the device should now release any system resources it is using.
Public Sub Close
	TJO.RunMethod("close",Null)
End Sub
'Obtains information about the device, including its Java class and Strings containing its name, vendor, and description.
Public Sub GetDeviceInfo As JavaObject
	Return TJO.RunMethod("getDeviceInfo",Null)
End Sub
'Obtains the maximum number of MIDI IN connections available on this MIDI device for receiving MIDI data.
Public Sub GetMaxReceivers As Int
	Return TJO.RunMethod("getMaxReceivers",Null)
End Sub
'Obtains the maximum number of MIDI OUT connections available on this MIDI device for transmitting MIDI data.
Public Sub GetMaxTransmitters As Int
	Return TJO.RunMethod("getMaxTransmitters",Null)
End Sub
'Obtains a MIDI IN receiver through which the MIDI device may receive MIDI data.
Public Sub GetReceiver As MidiReceiver
	Dim Wrapper As MidiReceiver
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getReceiver",Null))
	Return Wrapper
End Sub
'Returns all currently active, non-closed receivers connected with this MidiDevice.
Public Sub GetReceivers As List
	Dim L As List = TJO.RunMethod("getReceivers",Null)
	Dim Wrapper As List
	Wrapper.Initialize
	For i = 0 To L.Size - 1
  		Dim R As MidiReceiver
		R.Initialize
		R.SetObject(L.Get(i))
		Wrapper.Add(R)
	Next
	Return Wrapper
End Sub
'Obtains a MIDI OUT connection from which the MIDI device will transmit MIDI data The returned transmitter must be closed when the application has finished using it.
Public Sub GetTransmitter As MidiTransmitter
	Dim Wrapper As MidiTransmitter
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getTransmitter",Null))
	Return Wrapper
End Sub
'Returns all currently active, non-closed transmitters connected with this MidiDevice.
Public Sub GetTransmitters As List
	Dim Transmitters As List
	Transmitters.Initialize
	Dim l As List = TJO.RunMethod("getTransmitters",Null)
  
	For Each O As Object In l
		Dim T As MidiTransmitter
		T.Initialize
		T.SetObject(O)
		Transmitters.Add(T)
	Next
	Return Transmitters

End Sub
'Reports whether the device is open.
Public Sub IsOpen As Boolean
  Return TJO.RunMethod("isOpen",Null)
End Sub
'Opens the device, indicating that it should now acquire any system resources it requires and become operational.
Public Sub Open
  TJO.RunMethod("open",Null)
End Sub
