B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
#Event: Stopped(Reason As Int)
#IgnoreWarnings: 12
Sub Class_Globals
	Private mReceivers As List
	Private RTS As MidiRealTimeSequencer
	Private mEventName As String
	Private mModule As Object
	
	Public Const PLAYING_INTERRUPTED As Int = -1
	Public Const PLAYING_FINISHED As Int = -2
	Public Const RECORDING_FINISHED As Int = -3

End Sub

'Initializes the object.
Public Sub Initialize(Seq As MidiSequence,Module As Object,EventName As String,AttachDefault As Boolean)
	mEventName = EventName
	mModule = Module
	mReceivers.Initialize
	If Not(MidiDevice_Static.IsInitialized) Then MidiDevice_Static.Initialize
	If AttachDefault Then AttachDefaultReceiver
	RTS.Initialize(Me,Seq)
	MidiSequence_Static.SetSequencer(Me)
	
End Sub
Sub AttachDefaultReceiver
	mReceivers.Add(MidiDevice_Static.GetDefaultReceiverDevice.Receiver)
End Sub
'Set the sequence to be played
Sub SetSequence(Seq As MidiSequence)
	RTS.SetSequence(Seq)
End Sub
'Get a list of the receivers currently added to the sequencer
Sub getReceivers As List
	Return mReceivers
End Sub
'Set a receiver
Sub SetReceiver(MDI As MidiDeviceInfo) As MidiReceiver
	
	If MDI.Receiver.IsInitialized Then
		'Only add a Receiver once
		If mReceivers.IndexOf(MDI.Receiver) = -1 Then
			RTS.PlayLock.Wait
			mReceivers.Add(MDI.Receiver)
			RTS.PlayLock.Unlock		
		End If
	Else
		Dim R As MidiReceiver
		R.Initialize(MDI)
		If mReceivers.IndexOf(MDI.Receiver) = -1 Then
			RTS.PlayLock.Wait
			mReceivers.Add(MDI.Receiver)
			RTS.PlayLock.Unlock
		End If
	End If
	
	Return MDI.Receiver
End Sub
'Removes a receiver from the sequencer
Sub RemoveReceiver(MDI As MidiDeviceInfo)
	
	'Check it's added
	Dim Pos As Int =  mReceivers.IndexOf(MDI.Receiver)
	If Pos > -1 Then
		RTS.PlayLock.Wait
		If RTS.IsRunning Then RTS.SendAllNotesOff
		mReceivers.RemoveAt(Pos)
		RTS.PlayLock.Unlock
	End If
	
End Sub
'Start Playback
Sub Start
	If Not(RTS.GetSequence.IsInitialized) Then
		MidiLibUtils.Logger("Error","Sequencer","Sequence has not been set")
		Return
	End If
	
	RTS.Start
	
End Sub
'Stop Playback
Sub Stop
	If Not(RTS.GetSequence.IsInitialized) Then
		MidiLibUtils.Logger("Error","Sequencer","Sequence has not been set")
		Return
	End If
	
	RTS.Stop
End Sub
'Stops and Removes all receivers and Transmitters, this should be called when the MidiSystem is finished with.
Sub Release
	'Remove and close all receivers currently assigned
	For Each L As List In MidiDevice_Static.getReceiverDriverMap.Values
		For i = L.Size - 1 To 0 Step -1
			Dim MDI As MidiDeviceInfo = L.Get(i)
			MidiDevice_Static.RemoveDriverReceiver(MDI,True)
		Next
	Next
	'Remove and close all transmitters currently assigned
	For Each L As List In MidiDevice_Static.getTransmitterDriverMap.Values
		For i = L.Size - 1 To 0 Step -1
			Dim MDI As MidiDeviceInfo = L.Get(i)
			MidiDevice_Static.RemoveDriverTransmitter(MDI,True)
		Next
	Next
End Sub
'@SLHide
Sub Stopped(Reason As Int)
	If SubExists(mModule,mEventName & "_Stopped") Then CallSub2(mModule,mEventName & "_Stopped",Reason)
End Sub
'Gets the current Midi Tick position in the sequence
Sub getCurrentTick As Long
	Return RTS.GetTickPos
End Sub
'Set the next Midi Tick to be played
Sub setCurrentTick(Tick As Long)
	RTS.SetTickPosition(Tick)
End Sub
Private Sub getCurrentMicrosecondPosition As Long
	Return RTS.getMicrosecondPosition
End Sub
Private Sub setCurrentMicrosecondPosition(Microseconds As Long)
	RTS.SetMicrosecondPosition(Microseconds)
End Sub
'Get/Set the current millisecond position of the playback
Sub getCurrentMillisecondPosition As Long
	Return RTS.getMicrosecondPosition / 1000
End Sub
Sub setCurrentMillisecondPosition(Milliseconds As Long)
	RTS.SetMicrosecondPosition(Milliseconds * 1000)
End Sub
'Get the Sequence attached to this sequencer
Sub GetSequence As MidiSequence
	Return RTS.GetSequence
End Sub
'Returns the running stat of the sequencer
Sub getIsRunning As Boolean
	Return RTS.IsRunning
End Sub

#Region RealTimeSequencer Param Update Subs
'Get the current BPM of the sequence
Sub getBPM As Float
	Return RTS.TempoInBPM
End Sub
'Returns the current Microsecond Per Quarter Note
Sub GetTempoMPQ As Float
	Return RTS.GetTempoInMPQ
End Sub
'Set the current BPM of the sequence
Sub setBPM(BPM As Float)
	RTS.TempoInBPM = BPM
End Sub
'Get/Set the tempo factor all tempo changes will be affected
Sub setTempoFactor(Factor As Float)
	RTS.TempoFactor = Factor
End Sub
Sub getTempoFactor As Float
	Return RTS.TempoFactor
End Sub
'Get set the current loop start point
Sub setLoopStartPoint(Tick As Long)
	RTS.LoopStartPoint = Tick
End Sub
Sub getLoopStartPoint As Long
	Return RTS.LoopStartPoint
End Sub
'Get / Set the loop end point
Sub setLoopEndPoint(Tick As Long)
    RTS.LoopEndPoint = Tick
End Sub
Sub getLoopEndPoint As Long
    Return RTS.LoopEndPoint
End Sub
'Get/Set the loop count
Sub setLoopCount(Count As Int)
    RTS.LoopCount = Count
End Sub
Sub getLoopCount As Int
    Return RTS.LoopCount
End Sub
'Get / Set the solo stat of a track by it's Track Number
Sub setTrackSolo(TTrack As Int,Solo As Boolean)
	RTS.setTrackSolo(TTrack,Solo)
End Sub
Sub getTrackSolo(TTrack As Int) As Boolean
	Return RTS.getTrackSolo(TTrack)
End Sub
'Get / Set the Mute stat of a track By it's track Number
Sub setTrackMute(TTrack As Int, Mute As Boolean)
	RTS.setTrackMute(TTrack,Mute)
End Sub
Sub getTrackMute(TTrack As Int) As Boolean
	Return RTS.getTrackMute(TTrack)
End Sub
'Add a meta event listener
Sub AddMetaEventListener(Module As Object, EventName As String)
	Dim MEL As MidiMetaEventListener
	MEL.Initialize(Module,EventName)
'	Try
		RTS.AddMetaEventListener(MEL)
'	Catch
'		If LastException.Message.EndsWith("NullPointerException") Then
'			MidiLibUtils.ThrowException("Cannot add MetaEventListeners until after 
'	End Try
End Sub
'Add a controller event listener
Sub AddControllerEventListener(Module As Object,EventName As String,Controllers() As Int)
	Dim CEL As MidiControllerEventListener
	CEL.Initialize(Module,EventName,Controllers)
	RTS.AddControllerEventListener(CEL)
End Sub
'Sen an AllNotesOff message
Sub SendAllNotesOff
	RTS.SendAllNotesOff
End Sub
#End Region RealTimeSequencer Param Update Subs
#Region Recording Subs
'Start Recording
Sub StartRecording
	RTS.StartRecording
End Sub
'Stop Recording
Sub StopRecording
	RTS.StopRecording
End Sub
'Returns the current recording state
Sub IsRecording As Boolean
	Return RTS.IsRecording
End Sub
'Enable recording on a track
Sub RecordEnable(T As MidiTrack,Ch As Int)
	RTS.RecordEnable(T,Ch)
End Sub
'Disable recording on a track
Sub RecordDisable(T As MidiTrack)
	RTS.RecordDisable(T)
End Sub
'Get a list of track currently record Enabled
Sub getRecordingTracks As List
	Return RTS.RecordingTracks
End Sub
#End Region Recording Subs
#Region Constants

#End Region