B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module

#IgnoreWarnings: 9,12

'@SLHideClass
Sub Class_Globals
	Private Const Mthd_MAGIC =  As Int 0x4d546864   'Mthd
	Private Const MIDI_TYPE_0  As Int = 0
	Private Const MIDI_TYPE_1 As Int = 1
	Private bisBuffersize As Int = 1024
	'Private Types() As Int = Array As Int(MIDI_TYPE_0,MIDI_TYPE_1)
End Sub

'Initializes the object.
'@SLHide
Public Sub Initialize

End Sub
Private Sub GetMidiFileFormatFromStream(Stream As InputStream,FileLength As Int,SmfParser1 As MidiSMFParser) As MidiFileFormat

	'Dim MaxReadLength As Int = 16
	Dim Duration As Int = -1   'Unknown Length
	
	Dim Dis As SLDataInputStream
	Dis.Initialize(Stream)
	
	If SmfParser1 <> Null Then SmfParser1.Stream = Dis
	
	Dim FileType As Int
	Dim NumTracks As Int
	Dim DivisionType As Int
	Dim Resolution As Int
	
	Dim Magic As Int = Dis.ReadInt
	If Magic <> Mthd_MAGIC Then
		'Not Midi
		Log("Not a valid midi file")
		Return Null
	End If
	
	Dim BytesRemaining As Int = Dis.ReadInt - 6
	FileType = Dis.ReadShort
	NumTracks = Dis.ReadShort
	Dim Timing As Int = Dis.ReadShort
	
	'Decypher the timing code
	If Bit.AND(Timing,0x8000) = 0 Then
		'Tempo based timing = value is ticks per beat
		DivisionType = MidiSequence_Static.DIVTYPE_PPQ
		Resolution = Bit.AND(Timing,0x7fff)
	Else
		' SMPTE based timing
		Dim FrameCode As Int = -1 * Bit.AND((Bit.ShiftRight(Timing,8)),0xFF)
		
		Select FrameCode
		
			Case 24
				DivisionType = MidiSequence_Static.DIVTYPE_SMPTE_24
			Case 25
				DivisionType = MidiSequence_Static.DIVTYPE_SMPTE_25
			Case 29
				DivisionType = MidiSequence_Static.DIVTYPE_SMPTE_30DROP
			Case 30
				DivisionType = MidiSequence_Static.DIVTYPE_SMPTE_30
			Case Else
				MidiLibUtils.ThrowException("MidiFileReader : Unknown framecode")
		End Select
	
		Resolution = Bit.AND(Timing ,0xFF)
	End If
	
	If SmfParser1 <> Null Then
		Dis.SkipBytes(BytesRemaining)
		SmfParser1.Tracks = NumTracks
	Else
		Dis.Reset
	End If
	
	Dim Format As MidiFileFormat
	Format.Initialize(FileType,DivisionType,Resolution,FileLength,Duration)
	Return Format

End Sub
'@SLHide
Sub GetSequenceFromMidiFile(FilePath As String,FileName As String,StrictParser As Boolean) As MidiSequence
	Dim Stream As InputStream = File.OpenInput(FilePath,FileName)
	Dim Seq As MidiSequence = GetSequenceFromInputStream(Stream,StrictParser)
	Stream.Close
	Return Seq
End Sub
'@SLHide
Sub GetSequenceFromInputStream(Stream As InputStream,StrictParser As Boolean) As MidiSequence
	Dim SMFParser1 As MidiSMFParser
	SMFParser1.Initialize(StrictParser)
	Dim Format As MidiFileFormat = GetMidiFileFormatFromStream(Stream,MidiFileFormat_Static.UNKNOWN_LENGTH,SMFParser1)

	If Format.FileType <> 0 AND Format.FileType <> 1 Then
		MidiLibUtils.ThrowException("MidiFileReader : Invalid or Unsupported file type " & Format.FileType)
	End If
	
	Dim Seq As MidiSequence
	Seq.Initialize(Format.DivisionType,Format.Resolution)
	
	Dim i As Int
	For i = 0 To SMFParser1.Tracks - 1
		If SMFParser1.NextTrack Then
			SMFParser1.ReadTrack(Seq.CreateTrack)
		Else
			Exit
		End If
	Next
	
	Return Seq
End Sub