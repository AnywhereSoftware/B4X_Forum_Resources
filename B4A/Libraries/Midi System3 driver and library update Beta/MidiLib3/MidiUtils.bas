B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module
'http://docjar.com/docs/api/com/sun/media/sound/MidiUtils.html
#IgnoreWarnings: 12
'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private Const META_END_OF_TRACK_TYPE As Int = 0x2F
	Private Const META_TEMPO_TYPE As Int = 0x51
	Public Const MICROSECONDS_PER_MINUTE As Long = 60000000
End Sub

'@SLHide
Sub Microsec2Ticks(us As Double,TempoMPQ As Double,Resolution As Int) As Long
	Return((us * Resolution) / TempoMPQ)
End Sub
'@SLHide
Sub Ticks2Microsec(Tick As Long, TempoMPQ As Double,Resolution As Int) As Long
	Return Tick * (TempoMPQ / Resolution)
End Sub
'@SLHide
Sub Millis2Ticks(ms As Long,TempoMPQ As Double,Resolution As Int) As Long
	'Return ((TempoMPQ * Resolution) / 60000) * ms
	Return((ms * 1000 * Resolution) / TempoMPQ)
End Sub
'@SLHide
Sub Ticks2Millis(Tick As Long,TempoMPQ As Double,Resolution As Int) As Long
	'Return Ticks / ((TempoMPQ * Resolution) / 60000)
	Return (Tick * (TempoMPQ / Resolution)) / 1000
End Sub
'@SLHide
Sub IsMetaEndOfTrack(MidiMsg As MidiMessage) As Boolean
'	Log("MU MMLength " & MidiMsg.Length)
'	Log("MU MMStatus " & MidiMsg.Status)
'	Log("MU MMStatic MetaStatus " & MidiMessage_Static.METAStatus)
	If MidiMsg.Status <> MidiMessage_Static.METAStatus Or MidiMsg.Length <> 3 Then Return False
	Dim Msg() As Byte = MidiMsg.Message
'	Log("MU Msg(2) " & Msg(2))
	Return MidiMsg.MetaType = META_END_OF_TRACK_TYPE And Msg(2) = 0
End Sub
'@SLHide
Sub ISMetaTempo(MidiMsg As MidiMessage) As Boolean
	If MidiMsg.Length <> 6 Or MidiMsg.Status <> MidiMessage_Static.METAStatus Then Return False
	Dim Msg() As Byte = MidiMsg.getMessage
	Return Bit.And(Msg(1) ,0XFF) = META_TEMPO_TYPE And Msg(2) = 3
End Sub
'In Microseconds Per Quarter Note
'@SLHide
Sub getTempoMPQ(MidiMsg As MidiMessage)	As Int
	If MidiMsg.Length <> 6 Or MidiMsg.Status <> MidiMessage_Static.METAStatus Then Return -1
	Dim Msg() As Byte = MidiMsg.getMessage
	If Bit.And(Msg(1),0xFF) <> META_TEMPO_TYPE Or Msg(2) <> 3 Then Return -1
	Dim Tempo As Int = Bit.Or( _
		Bit.Or( _ 
		Bit.And(Msg(5), 0xFF) , _
		Bit.ShiftLeft( Bit.And(Msg(4), 0xFF) , 8)), _
		Bit.ShiftLeft(Bit.And(Msg(3), 0xFF), 16))
	Return Tempo
End Sub
'@SLHide
Sub Tick2Millisecond(Seq As MidiSequence,Tick As Long) As Long
	Return Tick2Microsecond(Seq,Tick) / 1000
End Sub
'Given a tick, convert to microsecond
'@SLHide
Sub Tick2Microsecond(Seq As MidiSequence,Tick As Long) As Long

	If Seq.DivisionType <> MidiSequence_Static.DIVTYPE_PPQ Then
		Dim Seconds As Double = Tick / (Seq.DivisionType * Seq.Resolution)
		Return 1000000 * Seconds
	End If
	
	If MidiTempoCache_Static.IsAvailble = False Then MidiTempoCache_Static.InitializeSeq(Seq)
	
	Dim Resolution As Int = Seq.Resolution
	Dim Ticks() As Long = MidiTempoCache_Static.GetTicks
	Dim Tempos() As Int = MidiTempoCache_Static.GetTempos
	Dim CacheCount As Int = Tempos.Length
	
	Dim SnapshotIndex As Int = MidiTempoCache_Static.GetSnapshotIndex
	Dim SnapshotMicro As Int = MidiTempoCache_Static.GetSnapshotMicro
	
	'Walk through all tempo changes and add time for the respective blocks
	
	Dim us As Long
	
	If SnapshotIndex <=0 Or SnapshotIndex >=CacheCount Or Ticks(SnapshotIndex) > Tick Then
		SnapshotIndex = 0
		SnapshotMicro = 0
	End If
	
	'If MidiTempoCache_Static has been created there will be a at least 1 entry
	If CacheCount > 0 Then
		Dim i As Int = SnapshotIndex + 1
		
		Do While i < CacheCount And Ticks(i) <= Tick
			SnapshotMicro = SnapshotMicro + Ticks2Microsec(Ticks(i) - Ticks(i - 1),Tempos(i - 1),Resolution)
			SnapshotIndex = i
			i = i + 1
		Loop
		us = SnapshotMicro + Ticks2Microsec(Tick - Ticks(SnapshotIndex),Tempos(SnapshotIndex),Resolution)
	End If
	
	MidiTempoCache_Static.SetSnapshotIndex(SnapshotIndex)
	MidiTempoCache_Static.SetSnapshotMicro(SnapshotMicro)
	
	Return us
End Sub
'@SLHide
Sub Millisecond2Tick(Seq As MidiSequence,Millis As Long) As Long
	Return Microsecond2Tick(Seq,Millis * 1000)
End Sub
'Given a microsecond time, convert to tick.
'@SLHide
Sub Microsecond2Tick(Seq As MidiSequence,Micros As Long) As Long
	
	If Seq.DivisionType <> MidiSequence_Static.DIVTYPE_PPQ Then
		Dim Tick As Long = Micros * Seq.DivisionType * Seq.Resolution / 1000000
		If MidiTempoCache_Static.IsAvailble Then MidiTempoCache_Static.setCurrTempo(MidiTempoCache_Static.getTempomPQAt(Tick))
		Return Tick
	End If
	If MidiTempoCache_Static.IsAvailble = False Then MidiTempoCache_Static.InitializeSeq(Seq)
	
	Dim Ticks() As Long = MidiTempoCache_Static.GetTicks
	Dim Tempos() As Int = MidiTempoCache_Static.GetTempos
	Dim CacheCount As Int = Tempos.Length
	
	Dim Resolution As Int = Seq.Resolution
	
	Dim us,Tick As Long
	Dim i As Int = 1
	
	'Walk through all tempo changes and add time for the respective blocks to find the right tick
	'If MidiTempoCache_Static has been created there will be a at least 1 entry
	If Micros > 0 And CacheCount > 0 Then
		'this loop requires that the first tempo Event is at time 0
		Dim NextTime As Long
		Do While i < CacheCount
			
			NextTime = us + Ticks2Microsec(Ticks(i) - Ticks(i-1),Tempos(i - 1), Resolution)
'			Log("M2T: NextTime " & NextTime)
			
			If NextTime > Micros Then Exit
			us = NextTime
			i = i + 1
		Loop
'		Log("M2T: Micros " & Micros)
'		Log("M2T: us " & us)
		Tick = Ticks(i - 1) + Microsec2Ticks(Micros - us,Tempos(i - 1),Resolution)
'		Log("M2T: Tick " & Tick)
	End If
	
	MidiTempoCache_Static.setCurrTempo(Tempos(i - 1))
	
	Return Tick
End Sub
'@SLHide
Sub Tick2Index(TTrack As MidiTrack,Tick As Long) As Int
	Dim Ret As Int
	If Tick > 0 Then
		Dim Low As Int = 0
		Dim High As Int = TTrack.Size - 1
		Do While Low < High
			'Take the middle event as our first try
			Ret = Bit.ShiftRight(Low + High,1)
			'Tick Of estimate
			Dim T As Long = TTrack.Get(Ret).Tick
			If T = Tick Then Exit
			If T < Tick Then
				'First try too low
				If Low = High - 1 Then
					'Or after tick
					Ret = Ret + 1
					Exit
				End If
				Low = Ret
			Else
				'first try too high
				High = Ret
			End If
		Loop
	End If
	Return Ret
End Sub
'Tempo is BPM or MicrosecondsPerQuarternote(usPQ)
'@SLHide
Sub ConvertTempo(Tempo As Double) As Double
	If Tempo <= 0 Then Tempo = 1
	Return MidiLibUtils.MICROSECONDS_PER_MINUTE / Tempo
End Sub