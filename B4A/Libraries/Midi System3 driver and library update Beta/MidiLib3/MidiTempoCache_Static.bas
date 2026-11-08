B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Private Ticks() As Long
	Private Tempos() As Int					' in MPQ
	Private mSnapshotIndex As Int			' index in ticks/tempos at the snapshot
	Private mSnapShotMicro As Int			' microsecond at the snapshot
	Private mCurrTempo As Int				'MPQ, used as return value for microsecond2tick                 'Ignore
	Private FirstTempoIsFake As Boolean
	Private mIsAvailable As Boolean
	'Pulses Per Microsecond
	Dim Const DEFAULT_TEMPO_MPQ As Double = 500000 '// 120BPM
	Private Lock As Lock
End Sub
'@SLHide
Sub Initialize
	Dim Ticks(1) As Long
	Dim Tempos(1) As Int
	Tempos(0) = DEFAULT_TEMPO_MPQ
	mSnapshotIndex = 0
	mSnapShotMicro = 0
	mIsAvailable = False
	Lock.Initialize(False)
End Sub
'@SLHide
Sub InitializeSeq(Seq As MidiSequence)
	Initialize
	Refresh(Seq)
End Sub
'@SLHide
Sub Refresh(Seq As MidiSequence)
	Lock.Wait
	Dim List1 As List
	List1.Initialize
	Dim Tracks() As MidiTrack = Seq.GetTracks
	If Tracks.Length > 0 Then
		'Tempo events only occur in track 0
		Dim Track0 As MidiTrack = Tracks(0)
		Dim c As Int = Track0.Size
		For i = 0 To c - 1
			Dim Ev As MidiEvent = Track0.get(i)
			Dim Msg As MidiMessage = Ev.Message
			If MidiUtils.IsMetaTempo(Msg) Then List1.Add(Ev)
		Next
		
		Dim Size As Int = List1.Size + 1
		FirstTempoIsFake = True
		
		If Size > 1 Then
			Dim Ev As MidiEvent = List1.get(0)
			If Ev.Tick = 0 Then
				'Do not need to add an initial tempo event at beginning
				Size = Size - 1
				FirstTempoIsFake = False
			End If
		End If
		
		Dim Ticks(Size) As Long
		Dim Tempos(Size) As Int
		Dim e As Int
		
		If FirstTempoIsFake Then
			'Add tempo 120 to beginning
			Ticks(0) = 0
			Tempos(0) = DEFAULT_TEMPO_MPQ
			e = e + 1
		End If
		
		For i = 0 To List1.Size - 1
			Dim Ev As MidiEvent = List1.get(i)
			Ticks(e) = Ev.Tick
			Tempos(e) = MidiUtils.getTempoMPQ(Ev.Message)
			e = e + 1
		Next
		
		mSnapshotIndex = 0
		mSnapShotMicro = 0
	End If
	mIsAvailable = True
	Lock.Unlock
End Sub
'Sub getCurrtempoMPQ As Int
'	Return CurrTempo
'End Sub

'Get Tempo in Microseconds at tick
'@SLHide
Sub getTempoMPQAt(Tick As Long) As Float
	Return getTempoMPQAt1(Tick,-1)
End Sub
'@SLHide
'Get Tempo in Microseconds at tick
Sub getTempoMPQAt1(Tick As Long,StartTempoMPQ As Float) As Float
	Lock.Wait
	For i = 0 To Ticks.Length - 1
		If Ticks(i) > Tick Then
			If i > 0 Then i = i - 1
			If StartTempoMPQ > 0 AND i = 0 AND FirstTempoIsFake Then
				Lock.Unlock
				Return StartTempoMPQ
			End If
			Lock.Unlock
			Return Tempos(i)
		End If
	Next
	Lock.Unlock
	Return Tempos(Tempos.Length - 1)
End Sub
'@SLHide
Sub GetTicks As Long()
	Return Ticks
End Sub
'@SLHide
Sub GetTempos As Int()
	Return Tempos
End Sub
'@SLHide
Sub IsAvailble As Boolean
	Return mIsAvailable
End Sub
'@SLHide
Sub setCurrTempo(Tempo As Int)
	mCurrTempo = Tempo
End Sub
'@SLHide
Sub GetSnapshotIndex As Int
	Return mSnapshotIndex
End Sub
'@SLHide
Sub GetSnapshotMicro As Int
	Return mSnapShotMicro
End Sub
'@SLHide
Sub SetSnapShotIndex(SSI As Int)
	mSnapshotIndex = SSI
End Sub
'@SLHide
Sub SetSnapShotMicro(SSM As Int)
	mSnapShotMicro = SSM
End Sub