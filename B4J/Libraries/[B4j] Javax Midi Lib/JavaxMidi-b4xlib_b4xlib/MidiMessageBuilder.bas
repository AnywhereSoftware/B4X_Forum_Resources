B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.51
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub NoteOn(Channel As Int,Note As Int, Velocity As Int) As MidiShortMessage
	Dim ShM As MidiShortMessage
	ShM.Initialize
	ShM.Create2Bytes(Bit.Or(MidiStatus.NOTE_ON,Channel),Note,Velocity)
	Return ShM
End Sub


Public Sub WrapMidiShortMessage(Msg As Object) As MidiShortMessage
	Dim Wrapper As MidiShortMessage
	Wrapper.Initialize
	Wrapper.SetObject(Msg)
	Return Wrapper
End Sub

Public Sub NoteOff(Channel As Int, Note As Int) As MidiShortMessage
	Dim ShM As MidiShortMessage
	ShM.Initialize
	ShM.Create2Bytes(Bit.Or(MidiStatus.NOTE_OFF,Channel),Note,0)
	Return ShM
End Sub

Public Sub ProgramChange(Channel As Int,Program As Int,Tick As Long) As MidiShortMessage
	Dim ShM As MidiShortMessage
	ShM.Initialize
	ShM.Create1Byte(Bit.Or(MidiStatus.PROGRAM_CHANGE,Channel),Program)
	Return ShM
End Sub

Public Sub TrackName(Name As String,ChrSet As String) As MidiMetaMessage
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.Create3(MidiMetaMessage_Static.SEQ_OR_TRACK_NAME,Name,ChrSet)
	Return MM
End Sub