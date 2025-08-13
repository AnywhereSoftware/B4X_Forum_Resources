B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module

#IgnoreWarnings: 12

Sub Class_Globals

	Private TrackList As List
	Private TrackSoloList As List
	Private TrackMuteList As List
	Private mDivisionType As Float
	Private mResolution As Int
End Sub

'Initializes the object.
Public Sub Initialize(DivisionType As Float,Resolution As Int)
	If DivisionType <> MidiSequence_Static.DIVTYPE_PPQ _
	And DivisionType <> MidiSequence_Static.DIVTYPE_SMPTE_24 _
	And DivisionType <> MidiSequence_Static.DIVTYPE_SMPTE_25 _
	And DivisionType <> MidiSequence_Static.DIVTYPE_SMPTE_30 _
	And DivisionType <> MidiSequence_Static.DIVTYPE_SMPTE_30DROP Then
		MidiLibUtils.ThrowException("Invalid division type " & DivisionType)
	End If
	
	mDivisionType = DivisionType
	mResolution = Resolution
	TrackList.Initialize
	TrackMuteList.Initialize
	TrackSoloList.Initialize
'	MidiSequence_Static.IndexedEvents.Initialize
	MidiTempoCache_Static.Initialize
	MidiUSBManager_Static.Initialize
	
End Sub

Sub CreateTrack As MidiTrack
	Dim T As MidiTrack
	T.Initialize
	TrackList.Add(T)
	TrackSoloList.Add(False)
	TrackMuteList.Add(False)
	Dim Seqr As MidiSequencer = MidiSequence_Static.GetSequencer
	If Seqr.IsInitialized Then Seqr.SetSequence(Me)
	Return T
End Sub
Sub DeleteTrack(T As MidiTrack) As Boolean
	Dim Pos As Int = TrackList.IndexOf(T)
	If Pos > -1 Then
		TrackList.RemoveAt(Pos)
		TrackMuteList.RemoveAt(Pos)
		TrackSoloList.RemoveAt(Pos)
		Dim Seqr As MidiSequencer = MidiSequence_Static.GetSequencer
		If Seqr.IsInitialized Then Seqr.SetSequence(Me)
		Return True
	End If
	Return False
End Sub
Sub GetTracks As MidiTrack()
	Dim TL As JavaObject = TrackList
	Return TL.RunMethod("toArray",Array As Object(Array As MidiTrack()))
End Sub
Sub GetTracksList As List
	Return TrackList
End Sub
Sub getDivisionType As Float
	Return mDivisionType
End Sub
Sub getResolution As Int
	Return mResolution
End Sub
'Get the length of the Sequence in MIDI ticks.
Sub GetTickLength As Long
	Dim Length As Long
	For Each Tr As MidiTrack In TrackList
		Length = Max(Tr.Ticks,Length)
	Next
	Return Length
End Sub
Sub GetMillisecondLength As Long
	Return GetMicrosecondLength / 1000
End Sub
Sub GetMicrosecondLength As Long
	Return MidiUtils.Tick2Microsecond(Me,GetTickLength)
End Sub
Sub LogSeqInfo

	Log("Sub in Sequence : LogSeqInfo ___________________________")
	Log("No Tracks " & TrackList.Size)
	Log("")
	Dim i As Int
	For Each TR As MidiTrack In TrackList
		Log("Track " & i & " " & TR.Size)
		If TR.ReadError <> "" Then LogColor(" ___________________ Read Error ________________________" & CRLF & TR.ReadError,Colors.Red)
		Dim TEvent As MidiEvent = TR.EventList.Get(TR.EventList.Size - 1)
		Log("    Last Event Meta Status " & MidiMessage_Static.METAStatus)
		If TEvent.Message.METAType <> 47 Then
			LogColor("    Last Event Meta Type " & TEvent.Message.MetaType,Colors.Red)
		Else
			Log("    Last Event Meta Type " & TEvent.Message.MetaType)
		End If
		Log("    Last Tick " & TEvent.Tick)
		Log("    Track Dur " & DateTime.Time(MidiUtils.Tick2Millisecond(Me,TEvent.Tick)))
		
		i=i+1
	Next
	Log("________________________________")
	Log("Division Type " & mDivisionType)
	Log("Resolution " & mResolution)
	Log("Tick Length " & GetTickLength)
	Log("Tempos: _____")
	Dim Ticks() As Long = MidiTempoCache_Static.GetTicks
	Dim Tempos() As Int = MidiTempoCache_Static.GetTempos
	For i = 0 To Ticks.Length - 1
		Log(Ticks(i) & " : " & Tempos(i) & " : ")
	Next
End Sub
Sub ReadError As Boolean
	Dim E As Boolean
	For Each T As MidiTrack In TrackList
		If T.IsInitialized And T.ReadError <> "" Then E = True
	Next
	Return E
End Sub
