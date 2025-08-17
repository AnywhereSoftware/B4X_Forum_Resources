B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

'Create a TimeSignature Midi Event
Public Sub TimesignatureEvent(Numerator As Int, Denominator As Int, Tick As Long) As MidiEvent
	Dim MM As MidiMetaMessage = MidiMetaMessage_Static.TimeSignatureMsg(Numerator,Denominator)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub

'Create tempo Midi Event
Public Sub TempoEvent(BPM As Float, Tick As Long) As MidiEvent
	Dim MM As MidiMetaMessage = MidiMetaMessage_Static.TempoMsg(BPM)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub

'Create Text Midi Event
Public Sub TextEvent(Text As String,Tick As Long,Chrset As String) As MidiEvent
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create
	MM.setMessage(MidiMetaMessage_Static.TEXT,Text.GetBytes(Chrset), Text.length)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub

'Create Cuepoit Midi Event
Public Sub CuePointEvent(Text As String,Tick As Long,ChrSet As String) As MidiEvent
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create
	MM.setMessage(MidiMetaMessage_Static.CUEPOINT,Text.GetBytes(ChrSet), Text.length)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub

'Create Lyric Midi Event
Public Sub Lyric(Text As String,Tick As Long,ChrSet As String) As MidiEvent
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create
	MM.setMessage(MidiMetaMessage_Static.LYRIC,Text.GetBytes(ChrSet), Text.length)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub



'Create Track Name Midi Event
Public Sub TrackNameEvent(TrackName As String,Tick As Long,ChrSet As String) As MidiEvent
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create
	MM.setMessage(MidiMetaMessage_Static.SEQ_OR_TRACK_NAME,TrackName.GetBytes(ChrSet), TrackName.length)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub

Public Sub NoteOn(Channel As Int,Note As Int, Velocity As Int,Tick As Long) As MidiEvent
	Dim ShM As MidiShortMessage
	ShM.Initialize
	ShM.Create2Bytes(Bit.Or(MidiStatus.NOTE_ON,Channel),Note,Velocity)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateShort(ShM,Tick)
	Return Mev
End Sub

Public Sub WrapNativeEvent(Event As Object) As MidiEvent
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.SetObject(Event)
	Return Mev
End Sub

Public Sub WrapShortMessage(Msg As Object) As MidiShortMessage
	Dim Wrapper As MidiShortMessage
	Wrapper.Initialize
	Wrapper.SetObject(Msg)
	Return Wrapper
End Sub

Public Sub NoteOff(Channel As Int, Note As Int, Tick As Long) As MidiEvent
	Dim ShM As MidiShortMessage
	ShM.Initialize
	ShM.Create2Bytes(Bit.Or(MidiStatus.NOTE_OFF,Channel),Note,0)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateShort(ShM,Tick)
	Return Mev
End Sub

Public Sub ProgramChangeEvent(Channel As Int,Program As Int,Tick As Long) As MidiEvent
	Dim ShM As MidiShortMessage
	ShM.Initialize
	ShM.Create1Byte(Bit.Or(MidiStatus.PROGRAM_CHANGE,Channel),Program)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateShort(ShM,Tick)
	Return Mev
End Sub

Public Sub Sysex(B() As Byte, Tick As Long) As MidiEvent
	Dim SM As MidiSysexMessage
	SM.Initialize
	SM.Create
	SM.setMessage(b, b.Length)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateSysex(SM,Tick)
	Return Mev
End Sub

Public Sub EndOfTrack(Tick As Long) As MidiEvent
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MidiMetaMessage_Static.EOTMsg(),Tick)
	Return Mev
End Sub