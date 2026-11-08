B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module

#IgnoreWarnings: 12

'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Private mLoading As Boolean
End Sub
'Load a sequence from a File
Sub GetSequence(FilePath As String,FileName As String,StrictParser As Boolean) As MidiSequence
	mLoading = True
	Dim MFR As MidiFileReader
	MFR.Initialize
	Dim Seq As MidiSequence = MFR.GetSequenceFromMidiFile(FilePath,FileName,StrictParser)
	mLoading = False
	Return Seq
End Sub
'Load a sequence from an input Stream
Sub GetSequenceFromInputStream(Stream As InputStream,StrictParser As Boolean) As MidiSequence
	mLoading = True
	Dim MFR As MidiFileReader
	MFR.Initialize
	Dim Seq As MidiSequence = MFR.GetSequenceFromInputStream(Stream,StrictParser)
	mLoading = False
	Return Seq
End Sub
'Save a sequence to a file
Sub WriteSequence(Seq As MidiSequence,FileType As Int,FilePath As String,FileName As String)
	Dim MFW As MidiFileWriter
	MFW.Initialize
	MFW.WriteFile(Seq,FileType,FilePath,FileName)
End Sub
'Send a sequence to an output stream
Sub WriteSequence1(Seq As MidiSequence,FileType As Int,Out As OutputStream)
	Dim MFW As MidiFileWriter
	MFW.Initialize
	MFW.Write(Seq,FileType,Out)
End Sub
'Get an array of mididevice Info
Sub GetMidiDeviceInfo As MidiDeviceInfo()
	Return MidiDevice_Static.getDeviceList
End Sub
'@SLHide
Sub GetSynthesizer As MidiSynthesizer
	'ToDo Get a synth
	Return Null
End Sub
'Returns the current loading state
Sub Loading As Boolean
	Return mLoading
End Sub
'Helper sub to Initialize midi system
Public Sub Initialize
	MidiGeneralMidi_Static.Initialize
	MidiUSBManager_Static.Initialize
	MidiDevice_Static.Initialize
End Sub