B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Type TimeSignatureType (Numerator As Int, Denominator As Int, BarTicks As Long,MetronomeMidiTicks As Int, Notated32ndNotes As Int)
End Sub

Public Sub int24bit(Val As Int) As Byte()
	Dim B(3) As Byte
	
	B(0) = Bit.And(Bit.ShiftRight(Val,16),0xff)
	B(1) = Bit.And(Bit.ShiftRight(Val,8),0xff)
	B(2) = Bit.And(Val,0xFF)
	Return B
End Sub

Public Sub NewPatch(Bank As Int,Prog As Int) As MidiPatch
	Dim P As MidiPatch
	P.Initialize
	P.Create(Bank,Prog)
	Return P
End Sub

Public Sub GetMsgType(Msg As Object) As String
'	Log(GetType(Msg))
	
	
	Dim Status As Int = CallSub(Msg,"GetStatus")
	
	If Status = 0xFF Then Return CallSub(Msg,"GetTypeName")
	
	If Status < 0x80 Then
		Select Status
			Case 0x79
				Return "Reset All Controllers"
			Case 0x7A
				Return "Local Control"
			Case 0x7B
				Return "All Notes Off"
			Case 0x7C
				Return "Omni Mode Off"
			Case 0x7D
				Return "Omni Mode On"
			Case 0x7E
				Return "Mono Mode On"
			Case 0x7F
				Return "Mono Mode Off"
		End Select
	Else If Status > 0xF0 Then
		Select Status
			Case 0xF1
				Return "MIDI Timing Code"
			Case 0xF2
				Return "Song Position Pointer"
			Case 0xF3
				Return "Song Select"
			Case 0xF6
				Return "Tune Request"
			Case 0xF8
				Return "Timing Clock"
			Case 0xFA
				Return "Start Sequence"
			Case 0xFB
				Return "Continue Sequence"
			Case 0xFC
				Return "Stop Sequence"
			Case 0xFE
				Return "Active Sensing"
			Case 0xFF
				Return "System Reset"
		End Select
	Else
		Select Bit.And(Bit.ShiftRight(Status,4),0xF)
			Case 8
				Return "Note Off"
			Case 9
				Return "Note On"
			Case 10
				Return "Poly Key Pressure"
			Case 11
				Return "Control Change"
			Case 12
				Return "Program Change"
			Case 13
				Return "Channel Pressure"
			Case 14
				Return "Pitch Bend"
		End Select
	End If
	Return "Not Found"
End Sub

Public Sub TransposeTrack(TTrack As MidiTrack,Semitones As Int)
	Dim Msg() As Byte
	For i = 0 To TTrack.Size - 1
		Dim E As MidiEvent = TTrack.Get(i)
		If GetMsgType(E.GetMessage) = "Note On" Or GetMsgType(E.GetMessage) = "Note Off" Then
			Dim SM As MidiShortMessage = MidiEventBuilder.WrapShortMessage(E.GetMessage.GetObject)
			Msg = E.GetMessage.GetMessage
			Msg(1) = Bit.And(Msg(1),0xFF) + Semitones
			SM.SetMessage2(Msg(0),Msg(1),Msg(2))
		End If
	Next
End Sub

'Transpose track except for exclueded channels
'Usage:<code>
'MidiUtils.TransposeTrack2(Track,5,Array As Int(9))
'</code>
Public Sub TransposeTrack2(TTrack As MidiTrack,Semitones As Int, ExcludeChannels As List)
	Dim Msg() As Byte
	For i = 0 To TTrack.Size - 1
		Dim E As MidiEvent = TTrack.Get(i)
		If E.GetMessage.IsShortMessage Then
			Dim SM As MidiShortMessage = MidiEventBuilder.WrapShortMessage(E.GetMessage.GetObject)
			If SM.GetCommand = MidiStatus.NOTE_ON Or SM.GetCommand = MidiStatus.NOTE_OFF Then
				Dim Chnl As Int = SM.GetChannel
				If ExcludeChannels.size > 0 And ExcludeChannels.IndexOf(Chnl) > -1 Then Return
				Msg = E.GetMessage.GetMessage
				Msg(1) = Bit.And(Msg(1),0xFF) + Semitones
				SM.SetMessage2(Msg(0),Msg(1),Msg(2))
			End If
		End If
	Next
End Sub

Public Sub TimeSigFromEvent(Evt As MidiEvent,Seq As MidiSequence) As TimeSignatureType
	Log("TS " & MidiTypeNames_Static.ShortName(Bit.And(Evt.GetMessage.AsMidiMetaMessage.GetType_,0xFF)))
	Dim TSM() As Byte = Evt.GetMessage.GetMessage
	Dim TS As TimeSignatureType
	TS.Initialize
	TS.Numerator = TSM(3)
	TS.Denominator = Power(2,TSM(4))
	TS.BarTicks = TS.Numerator * Seq.GetResolution * (4 / TS.Denominator)
	'Appears to be optional
	If TSM.Length > 5 Then TS.MetronomeMidiTicks = TSM(5)
	If TSM.Length > 6 Then TS.Notated32ndNotes = TSM(6)
	Return TS
End Sub

'In Microseconds Per Quarter Note
Public Sub getTempoMPQ(MetaMsg As MidiMetaMessage)	As Int
	If MetaMsg.GetLength <> 6 Then Return -1
	Dim Msg() As Byte = MetaMsg.getMessage
	If Bit.And(Msg(1),0xFF) <> MidiMetaMessage_Static.TEMPO Or Msg(2) <> 3 Then Return -1
	Dim Tempo As Int = Bit.Or( _
		Bit.Or( _ 
		Bit.And(Msg(5), 0xFF) , _
		Bit.ShiftLeft( Bit.And(Msg(4), 0xFF) , 8)), _
		Bit.ShiftLeft(Bit.And(Msg(3), 0xFF), 16))
	Return Tempo
End Sub

Public Sub GetTempoBPM(MetaMsg As MidiMetaMessage)	As Int
	Dim TMPQ As Int = getTempoMPQ(MetaMsg)
	If TMPQ = -1 Then
		Return -1
	Else
		Return 60000000 / TMPQ
	End If
End Sub