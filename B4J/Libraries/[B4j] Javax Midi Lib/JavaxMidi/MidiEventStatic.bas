B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.98
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

'Helper sub to create tempo Midi Event
Public Sub TempoEvent(BPM As Int, Tick As Long) As MidiEvent
	Dim MM As MidiMetaMessage = MidiMetaMessage_Static.TempoMsg(180)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub

'Helper sub to create Track Name Midi Event
Public Sub TrackNameEvent(TrackName As String,Tick As Long,ChrSet As String) As MidiEvent
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create
	MM.setMessage(0x03,TrackName.GetBytes(ChrSet), TrackName.length)
	
	Dim Mev As MidiEvent
	Mev.Initialize
	Mev.CreateMeta(MM,Tick)
	Return Mev
End Sub