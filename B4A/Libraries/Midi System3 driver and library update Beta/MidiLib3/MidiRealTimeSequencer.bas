B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
'http://docjar.com/html/api/com/sun/media/sound/RealTimeSequencer.java.html
#IgnoreWarnings: 12
'@SLHideClass
Sub Class_Globals

	
	Private TH,RTH As Thread				'Ignore
	Private mSeqr As MidiSequencer
	Private mSeq As MidiSequence
'	Private LastPlayTime,TimeNow As Long
	Private Interrupt,RecordInterrupt As Boolean
	Private TrackMuted() As Boolean
	Private TrackSolo() As Boolean
	Private Running As Boolean
	Private Recording As Boolean
	Private mRecordingTracks As List
	
	Private CurrTempo As Float = 500000			'MPQ Tempo
	
	Private mTempoFactor As Float = 1.0
	Private mInverseTempoFactor As Float = 1.0
	Private CacheTempoFactor As Float = -1							'Not set
	Private IgnoreTempoEventAt As Long = -1
	Private Resolution As Int
	Private DivisionType As Float
	Private CheckPointMillis As Long
	Private CheckPointTick As Long
	Private NoteOnCache(128) As Int
	Private Tracks(),ThisTrack As MidiTrack
	Private TrackDisabled() As Boolean
	Private TrackReadPos() As Int
	Private LastTick As Long
	Private NeedReindex As Boolean
	Private EventsNeedChasing As List
	Private FinishedTracks As Int
	Private Disabled As Boolean
	Private ReadPos As Int
	Private CurrEvent As MidiEvent
	Private CurrLoopCounter As Int
	Private LoopStart As Int
	Private LoopEnd As Int = -1
	Private mLoopCount As Int = 0
	Private LOOP_CONTINUOSLY As Int = -1
	Private CurrMillis As Long = -1 			'Set as a global and set to -1 to use as a flag to show if the sequence has been played
	Private CacheTempoMPQ As Double = -1
	
	Private NanoTime As NanoTime			
	Private ResetCheckPoint As Boolean
	Private RCPPlaylast As Int = 0
	Private EOM As Boolean
	Private MetaEventListeners,ControllerEventListeners As List
	Private EventDispatcher1 As MidiEventDispatcher
	
	Private LoadingSeq As Boolean
	Private LoadingSequence As MidiSequence
	Private PlayThreadLock,RecordLock As Lock
	Private mLoopChaseEvents As Boolean = True
	'DEBUG
	'Dim LockReleased As Boolean
	
End Sub

'Initializes the object.
'@SLHide
Public Sub Initialize(Seqr As MidiSequencer,Seq As MidiSequence)

	'From RTS init / PlayThread Constructor / DataPump Constructor
'	InitDP(Seq)
	mSeqr = Seqr
	PlayThreadLock.Initialize(False)
	RecordLock.Initialize(True)
	mRecordingTracks.Initialize
	MetaEventListeners.Initialize
	ControllerEventListeners.Initialize
	EventDispatcher1.Initialize
	EventsNeedChasing.Initialize
	SetSequence(Seq)
	TH.Initialise("TH")
	RTH.Initialise("RTH")
	
	Dim TrackReadPos(Tracks.Length) As Int
	ResetCheckPoint = True
	NeedReindex = True
	
	
	
End Sub
'@SLHide
Sub GetSequence As MidiSequence
	Return mSeq
End Sub
'@SLHide
Sub SetSequence(Seq As MidiSequence)
	'Loading a different sequence, reinitialize everything
	If mSeq = Null Or Not(mSeq.IsInitialized) Or mSeq <> Seq Then
		mSeq = Seq
		If IsRunning Then Stop
			
		Dim TrackMuted() As Boolean
		Dim TrackSolo() As Boolean
		LoopStart = 0
		LoopEnd = -1
		mLoopCount = 0
		ResetLoopCount

		MidiTempoCache_Static.InitializeSeq(mSeq)
		SetCaches
		SetTickPosition(0)
		PropogateCaches
		InitDP(mSeq)
		SetSequenceDP(mSeq)
		mRecordingTracks.Clear
	Else
		'Loading the same sequence, reinitialize track info in case track has been added / deleted
		MidiTempoCache_Static.InitializeSeq(mSeq)
		SetSequenceDP(mSeq)
		RCPPlaylast = 1
	End If
End Sub

Private Sub SetSequenceDP(Seq As MidiSequence)
	PlayThreadLock.Wait
	Tracks = Seq.GetTracks
	MuteSoloChanged
	Dim TrackReadPos(Tracks.Length) As Int
	ResetCheckPoint = True
	NeedReindex = True
	PlayThreadLock.Unlock
End Sub
Private Sub InitDP(Seq As MidiSequence)
	IgnoreTempoEventAt = -1
	mTempoFactor = 1
	mInverseTempoFactor = 1
	Resolution = Seq.Resolution
	DivisionType = Seq.DivisionType
	Dim NoteOnCache(128) As Int
	Dim Tracks() As MidiTrack
	Dim TrackDisabled() As Boolean
End Sub

#Region Working Subs
Private Sub Play								'Ignore

	CurrMillis = 0								'Unset the flag as the fist thing even though it's updated almost immediately
	Dim TargetTick As Long = LastTick
	Dim ChangesPending As Boolean
	Dim TrackSize As Int
	Running = True
	CurrMillis = GetCurrentTimeMillis
	EOM = False
	Dim DoLoop As Boolean
	
	Do While True
		ChangesPending = False
		
		'Give other threads a chance to lock this thread
'		Log("play: Unlock")
		PlayThreadLock.Unlock
		
		'Chasing events will set this lock if it receives updates
'		Log("play:Lock")

		PlayThreadLock.Wait
		
'		If ResetCheckPoint Then Log("LastTick " & LastTick)
		
		If NeedReindex Then
		'Resize the ReadPos Array if a track has been added
			If TrackReadPos.Length < Tracks.Length Then
				Dim TrackReadPos(Tracks.Length) As Int
			End If
			TargetTick = TargetTick + RCPPlaylast
			TargetTick = TargetTick
			
			For t = 0 To Tracks.Length - 1
				ReindexTrack(t,TargetTick)
			Next
			NeedReindex = False
			ResetCheckPoint = True
		End If
		
		If ResetCheckPoint Then
			'New Checkpoint
			CurrMillis = GetCurrentTimeMillis
			CheckPointMillis = CurrMillis
			TargetTick = LastTick + RCPPlaylast
			CheckPointTick = TargetTick
			RCPPlaylast = 0
			ResetCheckPoint = False
		Else
			'Calculate Current Tick based on current time in milliseconds
			TargetTick = CheckPointTick + Millis2Tick(GetCurrentTimeMillis - CheckPointMillis)
			
			If LoopEnd <> -1 And ((mLoopCount > 0 And CurrLoopCounter > 0) Or mLoopCount = LOOP_CONTINUOSLY) Then
				If LastTick <= LoopEnd And TargetTick >= LoopEnd Then
					'Need to loop
					'only play until the end of the loop
					TargetTick = LoopEnd - 1
					DoLoop = True
				End If
			End If
			
			LastTick = TargetTick
		End If
'		Log("TT " & TargetTick)
'		Log("TracksLength " & Tracks.Length)
		FinishedTracks = 0
		For t = 0 To Tracks.Length - 1
'			Log("TrackNo : " & t)
			Disabled = TrackDisabled(t)
			ThisTrack = Tracks(t)
			ThisTrack.EventLock.Wait
			ReadPos = TrackReadPos(t)
			TrackSize = ThisTrack.Size
			
			'Debug
'			If LockReleased Then
''				Log("LRTT " &TargetTick)
'				LockReleased = False
'			End If
			Do While Not(ChangesPending) And ReadPos < TrackSize And GetAndCheckEvent(TargetTick)
			
'				Log("CET " & CurrEvent.Tick)
'				Log("RP  " & ReadPos)
'				Log("Track " & t)
'				Log("Size " & TrackSize)
'				Log("TL " & Tracks.Length)
				If ReadPos = TrackSize - 1 And MidiUtils.IsMetaEndOfTrack(CurrEvent.Message) Then
'					Log("Here")
					'do not send out this message. Finished with this track
					ReadPos = TrackSize
					ThisTrack.EventLock.Unlock
					Exit
				End If
				
				ReadPos = ReadPos + 1
				If Not(Disabled) Or (t = 0 And MidiUtils.IsMetaTempo(CurrEvent.Message)) Then
					ChangesPending = DispatchMessage(t,CurrEvent)
				End If
				
			Loop
'			Log("RP2 " & ReadPos)
'			Log("Size2 " & TrackSize)
			

			If ReadPos >= TrackSize Then FinishedTracks = FinishedTracks + 1
			TrackReadPos(t) = ReadPos
			
			ThisTrack.EventLock.Unlock
			If ChangesPending Then Exit
		Next
		'If FinishedTracks = Tracks.Length Then EOM = True
		EOM = FinishedTracks = Tracks.Length

'		Log("EOM1 " & EOM)
		If DoLoop Or (((mLoopCount > 0 And CurrLoopCounter > 0) Or mLoopCount = LOOP_CONTINUOSLY) And Not(ChangesPending) And LoopEnd = -1 And EOM) Then
'			Log("SettingLoop")
			Dim OldCheckPointMillis As Long = CheckPointMillis
			Dim LoopEndTick As Long = LoopEnd
			If LoopEndTick = -1 Then LoopEndTick = LastTick
			If mLoopCount <> LOOP_CONTINUOSLY Then CurrLoopCounter = CurrLoopCounter - 1 
'			Log("Setting TickPos")
			PlayThreadLock.Unlock
			SetTickPos(LoopStart,True,mLoopChaseEvents)
			PlayThreadLock.Lock
'			Log("TickPosSet")
			' now patch the CheckPointMillis so that
			' it points To the exact beginning of when the Loop was finished

			CheckPointMillis = OldCheckPointMillis + Tick2Millis(LoopEndTick - CheckPointTick)
			CheckPointTick = LoopStart
			'No Need to reindex, it's done in SetTickPos
			NeedReindex = False
			ChangesPending = False
			DoLoop = False
			EOM = False
		End If
		
		If Interrupt Then Exit
'		Log(FinishedTracks)
'		Log(EOM)
		If EOM Then Exit
	Loop

	NotesOff(True)
	PlayThreadLock.Unlock
End Sub

Private Sub DispatchMessage(TrackNum As Int,Event As MidiEvent) As Boolean
	
	Dim ChangesPending As Boolean
	Dim Message As MidiMessage = Event.Message
	Dim MsgStatus As Int = Message.Status
	Dim MsgLen As Int = Message.Length
	
'	Log(MsgStatus = Message.METAStatus)
'	If MsgStatus = MidiMessage_Static.METAStatus Then
'		Log("MRT Tick " & Event.Tick)
'		Log("MRT MsgLen " & MsgLen)
'		Log("MRT MMetaType " & Message.MetaType)
'		Log("MRT MsgStatus " & MsgStatus)
'	End If
	If MsgStatus = MidiMessage_Static.METAStatus And MsgLen >=2 Then
		' a meta Message. Do Not send it To the device.
		' 0xFF with length=1 Is a MIDI realtime Message
		' which shouldn't be in a Sequence, but we play it
		' nonetheless.
		
		'See if this is a tempo message(Only track 0)
		If Message.MetaType = 88 And TrackNum = 0 Then
			Dim NewTempo As Int = MidiUtils.getTempoMPQ(Message)
			If NewTempo > 0 Then
				If Event.Tick <> IgnoreTempoEventAt Then
					SetTempoMPQ(NewTempo) 'Sets IgnoreTempoEventAt
					ChangesPending = True
				End If
				IgnoreTempoEventAt = -1
			End If
		End If
		'Send to listeners
		SendMetaEvents(Event)
	Else
		'Not Meta, send to device
		Send(Message,-1)
		
		If Bit.And(MsgStatus,0xF0) = MidiMessage_Static.STATUS_NOTE_OFF Then
			Dim Note As Int = Bit.And(Message.ShortMessageData1,0x7F)
			NoteOnCache(Note) = Bit.And(NoteOnCache(Note),(Power(0xFFFF,Bit.ShiftLeft(1,Bit.And(MsgStatus,0x0F)))))
		Else
			If Bit.And(MsgStatus,0xF0) = MidiMessage_Static.STATUS_NOTE_ON Then
				Dim Note As Int = Bit.And(Message.ShortMessageData1,0x7F)
				Dim Vel As Int = Bit.And(Message.ShortMessageData2,0x7F)
				If Vel > 0 Then
					NoteOnCache(Note) = Bit.Or(NoteOnCache(Note),(Bit.ShiftLeft(1,Bit.And(MsgStatus,0x0F))))
				Else
					NoteOnCache(Note) = Bit.And(NoteOnCache(Note),(Power(0xFFFF,Bit.ShiftLeft(1,Bit.And(MsgStatus,0x0F)))))
				End If
			Else
				If Bit.And(MsgStatus,0xF0) = MidiMessage_Static.STATUS_CONTROL_CHANGE Then
					SendControllerEvents(Event)
				End If
			End If
		End If
	End If
	
	Return ChangesPending
End Sub
Private Sub ReindexTrack(TrackNum As Int,Tick As Long)
	If TrackNum < TrackReadPos.Length And TrackNum < Tracks.Length Then
		TrackReadPos(TrackNum) = MidiUtils.Tick2Index(Tracks(TrackNum),Tick)
	End If
End Sub
Private Sub ClearNoteOnCache
	For I = 0 To 127
		NoteOnCache(I) = 0
	Next
End Sub
Private Sub Send(Message As MidiMessage,TimeStamp As Long)													'ignore
	'Timestamp is currently ignored until I find a reason to implement it.
	Dim ReceiverList As List = mSeqr.Receivers
	For Each R As MidiReceiver In ReceiverList
		R.Send(Message.getMessage)
	Next
End Sub
Private Sub SendMessage(Message() As Byte,TimeStamp As Long)												'ignore
	'Timestamp is currently ignored until I find a reason to implement it.
	Dim ReceiverList As List = mSeqr.Receivers
	For Each R As MidiReceiver In ReceiverList
		R.Send(Message)
	Next
End Sub
Private Sub NotesOff(DoControllers As Boolean)
	Dim M As MidiMessage
	M.Initialize
	
	For Ch = 0 To 15
		Dim ChannelMask As Int = Bit.ShiftLeft(1,Ch)
		For I = 0 To 127
			If Bit.And(NoteOnCache(I),ChannelMask) <> 0 Then
				NoteOnCache(I) = Power(NoteOnCache(I),ChannelMask)		
				SendMessage(Array As Byte(Bit.Or(MidiMessage_Static.STATUS_CONTROL_CHANGE,Ch),I,0),-1)
			End If
		Next
		'All notes off
		SendMessage(Array As Byte(Bit.Or(MidiMessage_Static.STATUS_CONTROL_CHANGE,Ch),123,0),-1)
		'Sustain Off
		SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_CONTROL_CHANGE,Ch),64,0),-1)
		If DoControllers Then
			'Controllers
			SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_CONTROL_CHANGE,Ch),121,0),-1)
		End If
	Next
End Sub
Private Sub Reset						'Ignore
	SendMessage(Array As Byte(0xFF),-1)
	Dim M As MidiMessage
	M.Initialize
	For Ch = 0 To 15
		'Controllers
		SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_CONTROL_CHANGE,Ch),121,0),-1)
		'Reset Bank and ProgChange
		SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_CONTROL_CHANGE,Ch),0,0),-1)
		SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_PROGRAM_CHANGE,Ch),0),-1)
	Next
End Sub
Private Sub TH_Ended(endedOK As Boolean, error As String) 'The thread has terminated. If endedOK is False error holds the reason for failure
'	Log("RTS TH Ended OK: " & endedOK & error)
	
	If Recording Then RecordLock.Unlock
	Dim Reason As Int
	'Song Ended
	Running = False
'	Log("Interrupt " & Interrupt)
	If Not(Interrupt) Then
		Reason = mSeqr.PLAYING_FINISHED
	Else
		Reason = mSeqr.PLAYING_INTERRUPTED
	End If
	
	'Reset the Interrupt flag
	Interrupt = False
	If LoadingSeq Then 
		SetSequence(LoadingSequence)
		LoadingSeq = False
	End If
	If Not(Recording) AND SubExists(mSeqr,"Stopped") Then CallSub2(mSeqr,"Stopped",Reason)
	
End Sub
Private Sub GetAndCheckEvent (TargetTick As Long)As Boolean
	CurrEvent = ThisTrack.get(ReadPos)
	Return CurrEvent.Tick <= TargetTick
End Sub
Private Sub ChaseEvents(StartTick As Long, EndTick As Long)

	'Start from the beginning
	If StartTick > EndTick Then StartTick = 0
	
	Dim TempArray(128,16) As Byte
'	Log("__________________________")
'	Log("Last Tick & " & LastTick)
'	Log("End Tick " & EndTick)
	For t = 0 To Tracks.Length - 1
		If TrackDisabled.Length = 0 OR TrackDisabled.Length <= t OR Not(TrackDisabled(t)) Then
			ChaseTrackEvents(t,StartTick,EndTick,True,TempArray)
		End If
	Next
End Sub
'@SLHide
Sub ChaseTrackEvents(TrackNum As Int,StartTick As Long,EndTick As Long,DoReindex As Boolean,TempArray(,) As Byte)
	
	Dim i,ch,co As Int
	Dim Progs(16) As Byte
	
	'Init temp array with impossible values
	For ch = 0 To 15
		Progs(ch) = -1
		For co = 0 To 127
			TempArray(co,ch) = -1
		Next
	Next
	Dim TTrack As MidiTrack = Tracks(TrackNum)
	Dim Size As Int = TTrack.Size
	Try
		For i = 0 To Size - 1
			
			Dim Event As MidiEvent = TTrack.get(i)
			If Event.Tick >= EndTick Then
				If DoReindex AND TrackNum < TrackReadPos.Length Then
					If i > 0 Then
						TrackReadPos(TrackNum) = i - 1
					Else
						TrackReadPos(TrackNum) = 0
					End If
				End If
				Exit
			End If
			
			Dim msg As MidiMessage = Event.Message
			Dim Status As Int = msg.Status
			Dim len As Int = msg.Length
			
			If len = 3 AND Bit.AND(Status,0xF0) = MidiMessage_Static.STATUS_CONTROL_CHANGE Then
				TempArray(Bit.AND(msg.ShortMessageData1,0x7F),Bit.AND(Status,0x0F)) = msg.ShortMessageData2
			End If
			
			If len = 2 AND Bit.AND(Status,0xF0) = MidiMessage_Static.STATUS_PROGRAM_CHANGE Then
				Progs(Bit.AND(Status,0x0F)) = msg.ShortMessageData1
			End If
		Next
	Catch
		'Can get array index out of bounds if messages are removed while this is running
		Log("Error in Chasing Events " & LastException.Message)
	End Try

	If EndTick > 0 Then
		'Now send the aggregated conrollers and program changes
		For ch = 0 To 15
			For co = 0 To 127
				Dim ControllerValue As Byte = TempArray(co,ch)
				If ControllerValue >=0 Then
					SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_CONTROL_CHANGE,ch),co,ControllerValue),-1)
				End If
			Next
			'Initialize the banks
			If Progs(ch) >= 0 Then SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_PROGRAM_CHANGE,ch),Progs(ch)),-1)
			
			If Progs(ch) >= 0 AND(StartTick = 0 OR EndTick = 0) Then
				'Reset Pitchbend on this channel
				SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_PITCH_BEND,ch),0x40),-1)
				'Reset Sustain Pedal
				SendMessage(Array As Byte(Bit.OR(MidiMessage_Static.STATUS_CONTROL_CHANGE,ch),64),-1)
			End If
		Next
	End If
End Sub
'@SLHide
Sub GetCurrentTimeMillis As Long
	Return NanoTime.NanoTime / 1000000
End Sub
'@SLHide
Sub getTickLength As Long
	If mSeq.IsInitialized = False Then Return 0
	Return mSeq.getTickLength
End Sub
'@SLHide
Sub getTrackCount As Int
	If mSeq.IsInitialized Then Return mSeq.GetTracks.Length
	Return 0
End Sub
Private Sub EnsureBoolArraySize(Arr() As Boolean,DesiredSize As Int) As Boolean()
	If Arr = Null Then
		Dim Arr1(DesiredSize) As Boolean
		Return Arr1
	End If
	If Arr.Length < DesiredSize Then
		Dim NewArray(DesiredSize) As Boolean
		'BC.ArrayCopy(Arr,0,NewArray,0,Arr.Length)
		MidiLibUtils.ArrayCopy(Arr,0,NewArray,0,Arr.Length)
		Return NewArray
	End If
	Return Arr
End Sub
'@SLHide
Sub addMetaEventListener(Listener As MidiMetaEventListener) As Boolean
	If MetaEventListeners.IndexOf(Listener) = -1 Then
		MetaEventListeners.Add(Listener)
		Return True
	End If
	Return False
End Sub
'@SLHide
Sub RemoveMetaEventListener(Listener As MidiMetaEventListener)					'Ignore	
	Dim Index As Int = MetaEventListeners.IndexOf(Listener)
	If Index > -1 Then
		MetaEventListeners.RemoveAt(Index)
	End If
End Sub
'@SLHide
Sub GetMetaEventListeners As List											'Ignore
	Return MetaEventListeners
End Sub
Private Sub SendMetaEvents(Event As MidiEvent)
	If MetaEventListeners.Size = 0 Then Return
	EventDispatcher1.SendAudioEvents(Event,MetaEventListeners)
End Sub
'@SLHide
 Sub AddControllerEventListener(Listener As MidiControllerEventListener) As Boolean		'Ignore
	If ControllerEventListeners.IndexOf(Listener) = -1 Then
		ControllerEventListeners.Add(Listener)
		Return True
	End If
	Return False
End Sub
'@SLHide
'@SLHide
Sub RemoveControllerEventListener(Listener As MidiControllerEventListener)		'Ignore
	Dim Index As Int = ControllerEventListeners.IndexOf(Listener)
	If Index > -1 Then ControllerEventListeners.RemoveAt(Index)
End Sub
'@SLHide
'@SLHide
Sub getControllerEventListeners As List
	Return ControllerEventListeners
End Sub
Private Sub SendControllerEvents(Event As MidiEvent)
	Dim Size As Int = ControllerEventListeners.Size
	If Size = 0 Then Return
	If Event.Message.MessageType <> MidiMessage_Static.TYPE_SHORTMESSAGE Then Return
	Dim Controller As Int = Event.Message.ShortMessageData1
	Dim SendToListeners As List
	SendToListeners.Initialize
	For I = 0 To Size - 1
		Dim CVE As MidiControllerEventListener = ControllerEventListeners.get(I)
		For j = 0 To CVE.Controllers.Length - 1
			If CVE.Controllers(j) = Controller Then
				SendToListeners.Add(CVE)
				Exit
			End If
		Next
	Next
	
	EventDispatcher1.SendAudioEvents(Event,SendToListeners)
End Sub

#End Region Working subs

#Region Setup / Reconfigure Subs

Private Sub MakeDisabledArray As Boolean()
	If Tracks.Length = 0 Then Return Array As Boolean()
	Dim NewTrackDisabled(Tracks.Length) As Boolean
	'PlayThreadLock.Wait
	Dim Solo() As Boolean = TrackSolo
	Dim Mute() As Boolean = TrackMuted
	'PlayThreadLock.Unlock
	
	Dim HasSolo As Boolean
	Dim i As Int
	If Solo.Length <> 0 Then
		For i = 0 To Solo.Length - 1
			If Solo(i) Then
				HasSolo = True
				Exit
			End If
		Next
	End If
	If HasSolo Then
		'only the channels with solo play, regardless of mute

		For i = 0 To NewTrackDisabled.Length - 1
			NewTrackDisabled(i) = i >= Solo.Length OR Not(Solo(i))
		Next
	Else
		'Mute the selected channels
		For i = 0 To NewTrackDisabled.Length - 1
			NewTrackDisabled(i) = (Mute.Length > 0) AND i < Mute.Length AND Mute(i)
		Next
	End If
	Return NewTrackDisabled

End Sub 
#End Region Setup / Reconfigure Subs

#Region Conversion Subs
Private Sub Millis2Tick(Millis As Long) As Long
	If mSeq.DivisionType <> MidiSequence_Static.DIVTYPE_PPQ Then
		Return (Millis * mTempoFactor * DivisionType * Resolution) / 1000
	End If
	Return MidiUtils.Microsec2Ticks(Millis * 1000,CurrTempo * mInverseTempoFactor,mSeq.Resolution)
End Sub
'@SLHide
Sub Tick2Millis(Tick As Long) As Long
	If DivisionType <> MidiSequence_Static.DIVTYPE_PPQ Then
		Return (Tick * 1000) / (mTempoFactor * DivisionType * Resolution)
	End If
	Return MidiUtils.Ticks2Microsec(Tick,CurrTempo * mInverseTempoFactor,Resolution) / 1000
End Sub
#End Region Conversion Subs



#Region Control Subs
'@SLHide
Sub Start
	
	If Running Then Return
	
	'Update added tracks etc
	
	
	MidiTempoCache_Static.Refresh(mSeq)
	SetSequenceDP(mSeq)
'	If EOM Then 
'		setTickPos(0)
'		IgnoreTempoEventAt = -1
'		EOM = False
'	End If
	
	If Not(HasCachedTempo) Then
		Dim TickPos As Long = GetTickPosition
		SetTempoMPQ(MidiTempoCache_Static.getTempoMPQAt(TickPos))
	End If

	ClearNoteOnCache
	ResetCheckPoint = True
	NeedReindex = True
'	Log("Start LastTick" & LastTick)
	
	ResetLoopCount
	RCPPlaylast = 0
	
	If Not(Running) Then TH.Start(Me,"Play",Null)

End Sub
'@SLHide
Sub Stop
	StopRecording
	Interrupt = True
End Sub
'@SLHide
Sub StopAndLoad(Seq As MidiSequence)
	Interrupt = True
	LoadingSequence = Seq
End Sub
'@SLHide
Sub IsRunning As Boolean
	Return Running
End Sub

'@SLHide
Sub setTrackMute(TTrack As Int,Mute As Boolean)
	Dim TrackCount As Int = getTrackCount
	If TTrack < 0 OR TTrack > TrackCount Then Return
	TrackMuted = EnsureBoolArraySize(TrackMuted,TrackCount)
	TrackMuted(TTrack) = Mute
	MuteSoloChanged
End Sub
'@SLHide
Sub getTrackMute(TTrack As Int)As Boolean
	If TTrack < 0 OR TTrack > getTrackCount Then Return False
	If TrackMuted = Null OR TrackMuted.Length <= TTrack Then Return False
	Return TrackMuted(TTrack)
End Sub
'@SLHide
Sub setTrackSolo(TTrack As Int, Solo As Boolean)
	Dim TrackCount As Int = getTrackCount
	If TTrack < 0 OR TTrack >= TrackCount Then Return
	TrackSolo = EnsureBoolArraySize(TrackSolo,TrackCount)
	TrackSolo(TTrack) = Solo
	MuteSoloChanged
End Sub
'@SLHide
Sub getTrackSolo(TTrack As Int) As Boolean
	If TTrack < 0 OR TTrack > getTrackCount Then Return False
	If TrackSolo = Null OR TrackSolo.Length <= TTrack Then Return False
	Return TrackSolo(TTrack)
End Sub
Private Sub MuteSoloChanged
	Dim NewDisabled() As Boolean = MakeDisabledArray
	If Running Then ApplyDisabledTracks(TrackDisabled,NewDisabled)
	TrackDisabled = NewDisabled
End Sub
  'Runtime application of mute/solo:
 'If a Track Is muted that was previously playing, Send note off events For all currently playing notes
 Private Sub ApplyDisabledTracks(OldDisabled() As Boolean,NewDisabled() As Boolean)
	Dim TempArray(,) As Byte
	For I = 0 To NewDisabled.Length - 1
		If (OldDisabled.Length = 0 OR I >= OldDisabled.Length OR Not(OldDisabled(I))) AND NewDisabled(I) Then
			If Tracks.Length > I Then SendNoteOffIfOn(Tracks(I),LastTick)
		Else

			If OldDisabled.Length > 0 AND I < OldDisabled.Length AND OldDisabled(I) AND Not(NewDisabled(I)) Then
				'Case that a Track was muted AND Is now unmuted
	 			'need To chase events AND re-index this Track
				Dim TempArray(128,16) As Byte
				ChaseTrackEvents(I,0,LastTick,True,TempArray)
			End If
		End If
	Next
End Sub
'@SLHide
Sub SendAllNotesOff
	Dim Msg() As Byte = MidiMessage_Static.ALLNOTESOFF
	For i = 0 To 15
		SendMessage(Array As Byte(Bit.OR(Msg(0),i),Msg(1),Msg(2)),-1)
	Next
'	For i = 0 To 15
'		SendMessage()
'	Next
'	SendMessage(MidiMessageStatic.ALLNOTESOFF,-1)
End Sub
 'chase all events from beginning of Track
 'AND Send note off For those events that are active
 'In NoteOnCache Array.
'@SLHide
Sub SendNoteOffIfOn(TTrack As MidiTrack,EndTick As Long)
	Dim Size As Int = TTrack.Size
	Dim Done As Int = 0
	Try
		For I = 0 To Size - 1
			Dim Event As MidiEvent = TTrack.get(I)
			If Event.Tick > EndTick Then Exit
			Dim Msg As MidiMessage = Event.Message
			Dim Status As Int = Msg.Status
			Dim Len As Int = Msg.Length
			If Len = 3 AND Bit.AND(Status,0xF0) = MidiMessage_Static.STATUS_NOTE_ON Then
				Dim Note As Int = -1
				If Msg.MessageType = MidiMessage_Static.TYPE_SHORTMESSAGE Then
					If Msg.ShortMessageData2 > 0 Then
						Note = Msg.ShortMessageData1
					End If
				Else
					Dim Data() As Byte = Msg.getMessage
					If Bit.AND(Data(2),0x7F) > 0 Then
						Note = Data(1)
					End If
				End If
				
				If Note > 0 Then
					Dim bbit As Int = Bit.ShiftLeft(1,Bit.AND(Status,0x0F))
					If Bit.AND(NoteOnCache(Note),bbit) <> 0 Then
						'the bit is set send note off
						SendMessage(Array As Byte(Status,Note,0),-1)
						'Clear the bit
						NoteOnCache(Note) = Bit.AND(NoteOnCache(Note),Power(0xFFFF,bbit))
						Done = Done + 1
					End If
				End If
			End If
		Next
	Catch
	' this happens when messages are removed from the Track While this method executes
	End Try				'Ignore
End Sub
'@SLHide
Sub getPlayLock As Lock
	Return PlayThreadLock
End Sub
#End Region Control Subs


#Region Parameter update subs
'Get / Set Tempo in Microseconds per Quarter Note
'@SLHide
Sub setTempoInMPQ(TempoMPQ As Float)
	If TempoMPQ <= 0 Then TempoMPQ = 1
	If NeedCaching Then
		CacheTempoMPQ = TempoMPQ
	Else
		SetTempoMPQ(TempoMPQ)
		CacheTempoMPQ = -1
	End If
End Sub
'@SLHide
Sub SetTempoMPQ(TempoMPQ As Float)
	If TempoMPQ > 0 AND TempoMPQ <> CurrTempo Then
		IgnoreTempoEventAt = LastTick
		CurrTempo =  TempoMPQ
		'Recalculate check point
		ResetCheckPoint = True
	End If

End Sub
'@SLHide
Sub GetTempoInMPQ As Long

	If NeedCaching Then
		If CacheTempoMPQ <> -1 Then
			Return CacheTempoMPQ
		End If
		If mSeq.IsInitialized Then
			Return MidiTempoCache_Static.getTempoMPQAt(GetTickPosition)
		End If
		Return MidiTempoCache_Static.DEFAULT_TEMPO_MPQ
	End If
	Return getTempoMPQ
End Sub
'Get / Set Tempo IN BPM
'@SLHide
Sub setTempoInBPM(BPM As Float)
	If BPM < 0 Then BPM = 1
	setTempoInMPQ(MidiUtils.ConvertTempo(BPM))
End Sub
'@SLHide
Sub getTempoInBPM As Float
	Return MidiUtils.ConvertTempo(GetTempoInMPQ)
End Sub
'@SLHide
Sub GetTickPosition As Long
	If mSeq.IsInitialized = False Then Return 0
	Return GetTickPos
End Sub
'@SLHide
Sub GetTickPos As Long
	Return LastTick
End Sub
'@SLHide
Sub NeedCaching As Boolean
	Return mSeq.IsInitialized = False
End Sub
'@SLHide
Sub getTempoMPQ As Float
	Return CurrTempo
End Sub
Private Sub SetTickPos(TP As Long,DoLock As Boolean,DoChaseEvents As Boolean)
	If DoLock Then PlayThreadLock.Wait
	Dim OldLastTick As Long = LastTick
	LastTick = TP
'	Dim OldLastTick As Long = LastTick
'	MLog.Data2("STP", "Setting to " & TP)
'	MLog.Data2("STP","Curr TP" & LastTick)

	If Running Then NotesOff(False)
	If (Running OR TP > 0) AND DoChaseEvents Then
		ChaseEvents(OldLastTick,TP)
	Else
		NeedReindex = True
'		MLog.Data("LTP","Tick set to " & TP)
	End If
'	MLog.Data("STP","Pos Set to " & mSeqr.CurrentMillisecondPosition)
	
	If Not(HasCachedTempo) Then
		SetTempoMPQ(MidiTempoCache_Static.getTempoMPQAt1(TP,CurrTempo))
		IgnoreTempoEventAt = -1
	End If

	ResetCheckPoint = True
	If DoLock Then PlayThreadLock.Unlock
'	LockReleased = True
End Sub
'@SLHide
Sub SetTickPosition(Tick As Long)
	If Running Then PlayThreadLock.Wait
'	Log("STP Tick " & Tick)
	If Tick >= 0 Then
		If Tick > getTickLength Then Tick = getTickLength
		
		If mSeq.IsInitialized = False AND Tick  <> 0 Then
			MidiLibUtils.ThrowException("Cannot set position if Sequence is not set")
		Else
			SetTickPos(Tick,False,True)
		End If
	
	End If
	PlayThreadLock.Unlock
End Sub
'@SLHide
Sub getMicrosecondLength As Long
	If mSeq.IsInitialized = False Then
		Return 0
	End If
	Return mSeq.getMicrosecondLength
End Sub
'@SLHide
Sub getMicrosecondPosition As Long
	If CurrMillis = -1 OR mSeq.IsInitialized = False Then
		Return 0
	End If
	Return MidiUtils.Tick2Microsecond(mSeq,LastTick)
End Sub	
'@SLHide
Sub SetMicrosecondPosition(Microseconds As Long)
	
	If Microseconds < 0 Then Return
	
'	If CurrMillis = -1 AND Microseconds <> 0 Then
'		MidiLibUtils.ThrowException("Cannot set position in a closed state")
'	Else
		If mSeq.IsInitialized = False AND Microseconds <> 0 Then
			MidiLibUtils.ThrowException("Cannot set position if Sequence is not set")
		Else
			'ResetCheckPoint = True
			SetTickPosition(MidiUtils.Microsecond2Tick(mSeq,Microseconds))
		End If
'	End If
	
End Sub
'@SLHide
Sub HasCachedTempo As Boolean
	If IgnoreTempoEventAt <> LastTick Then IgnoreTempoEventAt = -1
	Return IgnoreTempoEventAt >= 0
End Sub
'@SLHide
Sub setTempoFactor(Factor As Float)
	If Factor < 0 Then Return
	
	If NeedCaching Then
		CacheTempoFactor = Factor
	Else
		If Factor > 0 AND Factor <> mTempoFactor Then
			mTempoFactor = Factor
			mInverseTempoFactor = 1 / Factor
			CacheTempoFactor = -1
			'recalculate the checkpoint
			ResetCheckPoint = True
		End If
	End If
End Sub
'@SLHide
Sub getTempoFactor As Float
	
	If NeedCaching Then
		If CacheTempoFactor <> -1 Then
			Return CacheTempoFactor
		Else
			Return 1
		End If
	End If
	Return mTempoFactor
End Sub
'@SLHide
Sub SetCaches
	CacheTempoFactor = mTempoFactor
	CacheTempoMPQ = GetTempoInMPQ
End Sub
'@SLHide
Sub PropogateCaches
	If mSeq <> Null Then
		If CacheTempoFactor <> -1 Then setTempoFactor(CacheTempoFactor)
		If CacheTempoMPQ = -1 Then 
			setTempoInMPQ(MidiTempoCache_Static.getTempoMPQAt(GetTickPosition))
		Else
			setTempoInMPQ(CacheTempoMPQ)
		End If
	End If
End Sub
#End Region Parameter update subs

#Region Recording Subs
'@SLHide
Sub RecordThread
'	Log("RecordThread Started")
	RecordLock.Wait
'	Log("Record Thread Unlocked")
	Do While RecordInterrupt = False
		'Calculate Current Tick based on current time in milliseconds
		LastTick = CheckPointTick + Millis2Tick(GetCurrentTimeMillis - CheckPointMillis)
	Loop
End Sub
'@SLHide
Sub RTH_Ended(endedOK As Boolean, error As String) 'The thread has terminated. If endedOK is False error holds the reason for failure
	Log("Recordingthread endedOK " & endedOK & " " & error)
	Recording = False
	Interrupt = False
	RecordInterrupt = False
	If SubExists(mSeqr,"Stopped") Then CallSub2(mSeqr,"Stopped",mSeqr.RECORDING_FINISHED)
End Sub
'@SLHide
Sub	StartRecording
	Start
	RTH.Start(Me,"RecordThread",Null)
	Recording = True
End Sub
'@SLHide
Sub StopRecording
	RecordInterrupt = True
End Sub
'@SLHide
Sub IsRecording As Boolean
	Return Recording
End Sub
'@SLHide
Sub getRecordingTracks As List
	Return mRecordingTracks
End Sub
'@SLHide
Sub RecordEnable(T As MidiTrack,Ch As Int)
	If Not(FindTrack(T)) Then MidiLibUtils.ThrowException("RecordEnable: Track not found in sequence")
	Dim RT As MidiRecordingTrack = MidiRecordingTrack_Static.GetRT(mRecordingTracks,T)
	If RT.IsInitialized Then 
		RT.channel = Ch
	Else
		RT.Initialize(T,Ch)
		mRecordingTracks.Add(RT)
	End If
	If Not(MidiSequencerReceiver_Static.IsInitialized) Then MidiSequencerReceiver_Static.Initialize(Me)
End Sub
'@SLHide
Sub RecordDisable(T As MidiTrack)
	Dim RT As MidiRecordingTrack = MidiRecordingTrack_Static.GetRT(mRecordingTracks,T)
	If RT.IsInitialized Then mRecordingTracks.RemoveAt(mRecordingTracks.IndexOf(T))
End Sub
'@SLHide
Sub FindTrack(Tr As MidiTrack) As Boolean
	Dim Tracks() As MidiTrack = mSeq.GetTracks
	Dim Found As Boolean
	For Each T As MidiTrack In Tracks
		If Tr = T Then 
			Found = True
			Exit
		End If
	Next
	Return Found
End Sub
#End Region Recording Subs

#Region Loop Subs
'Get / Set Loop Start Point
'@SLHide
Sub setLoopStartPoint(Tick As Long)
	If Tick > getTickLength OR (LoopEnd <> -1 AND Tick > LoopEnd) OR Tick < 0 Then
		MidiLibUtils.ThrowException("RealTimeSequencer: invalid loop start point: " & Tick)
	End If
	LoopStart = Tick
End Sub
'@SLHide
Sub getLoopStartPoint As Long
	Return LoopStart
End Sub
'Get / Set loop end point, set to -1 (LOOP_CONTINUOSLY) to loop continuosly
'@SLHide
Sub setLoopEndPoint(Tick As Long)
	If Tick > getTickLength OR (LoopStart > Tick AND Tick <> -1) OR Tick < -1 Then
		MidiLibUtils.ThrowException("RealTimeSequencer: invalid loop end point: " & Tick)
	End If
	LoopEnd = Tick
End Sub
'@SLHide
Sub getLoopEndPoint As Long
	Return LoopEnd
End Sub
'Get / set LoopCount
'@SLHide
Sub setLoopCount(Count As Int)
	If Count <> LOOP_CONTINUOSLY AND Count < 0 Then
		MidiLibUtils.ThrowException("RealTimeSequencer: illegal value for loop count: " & Count)
	End If
	mLoopCount = Count
	ResetLoopCount
End Sub
'@SLHide
Sub getLoopCount As Int
	Return mLoopCount
End Sub
Private Sub ResetLoopCount
	CurrLoopCounter = mLoopCount
End Sub
'Determines whether Events are chased when looping
'This should only be used when you are sure patches and controllers are not changed during the loop.
'@SLHide
Sub setLoopChaseEvents(Chase As Boolean)
	mLoopChaseEvents = Chase
End Sub
#End Region Loop Subs