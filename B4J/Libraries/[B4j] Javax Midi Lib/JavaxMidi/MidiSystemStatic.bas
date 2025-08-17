B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Class Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	MidiMetaMessage_Static.Initialize
	MidiSequence_Static.Initialize
	MidiSysexMessage_Static.Initialize
	MidiTypeNames_Static.Initialize
	MidiMetaMessage_Static.Initialize
	Midi_GM.Initialize
End Sub

'Obtains the requested MIDI device.
Public Sub GetMidiDevice(Info As MidiDeviceInfo) As MidiDevice
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim D As MidiDevice
	D.Initialize
	D.SetObject(MidiSystem1.RunMethod("getMidiDevice",Array As Object(Info.GetObject)))
	Return D
End Sub
'Obtains an array of information objects representing the set of all MIDI devices available on the system.
Public Sub GetMidiDeviceInfo As MidiDeviceInfo()
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim DI() As Object = MidiSystem1.RunMethod("getMidiDeviceInfo",Null)
	Dim MDI(DI.Length) As MidiDeviceInfo
	For i = 0 To DI.Length - 1
		MDI(i).Initialize
		MDI(i).SetObject(DI(i))
	Next
	Return MDI
End Sub
'Obtains the MIDI file format of the specified File.
Public Sub GetMidiFileFormat(DirName As String, FileName As String) As MidiFileFormat
	'Code for File Object Creation
	Dim ThisFile As JavaObject
	ThisFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim Wrapper As MidiFileFormat
	Wrapper.Initialize
	Wrapper.SetObject(MidiSystem1.RunMethod("getMidiFileFormat",Array As Object(ThisFile)))
	Return Wrapper
End Sub
'Obtains the MIDI file format of the data in the specified input stream.
Public Sub GetMidiFileFormat2(Stream As InputStream) As MidiFileFormat
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim Wrapper As MidiFileFormat
	Wrapper.Initialize
	Wrapper.SetObject(MidiSystem1.RunMethod("getMidiFileFormat",Array As Object(Stream)))
	Return Wrapper
End Sub
'Obtains the MIDI file format of the data in the specified URL.
'Pass a FileUri obtained with File.GetUri(Dir, FileName)
Public Sub GetMidiFileFormat3(Url As String) As MidiFileFormat
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim jURL As JavaObject
	jURL.InitializeNewInstance("java.net.URL",Array(Url))
	Dim Wrapper As MidiFileFormat
	Wrapper.Initialize
	Wrapper.SetObject(MidiSystem1.RunMethod("getMidiFileFormat",Array As Object(jURL)))
	Return Wrapper
End Sub
'Obtains the set of MIDI file types for which file writing support is provided by the system.
Public Sub GetMidiFileTypes As Int()
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Return MidiSystem1.RunMethod("getMidiFileTypes",Null)
End Sub
'Obtains the set of MIDI file types that the system can write from the sequence specified.
Public Sub GetMidiFileTypes2(ThisSequence As MidiSequence) As Int()
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Return MidiSystem1.RunMethod("getMidiFileTypes",Array As Object(ThisSequence.GetObject))
End Sub
'Obtains a MIDI receiver from an external MIDI port or other default device.
Public Sub GetReceiver As MidiReceiver
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim Wrapper As MidiReceiver
	Wrapper.Initialize
	Wrapper.SetObject(MidiSystem1.RunMethod("getReceiver",Null))
	Return Wrapper
End Sub
'Obtains a MIDI sequence from the specified File.
Public Sub GetSequence(DirName As String, FileName As String) As MidiSequence
	'Code for File Object Creation
	Dim ThisFile As JavaObject
	ThisFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	
	Dim Seq As MidiSequence
	Seq.Initialize
	Seq.SetObject(MidiSystem1.RunMethod("getSequence",Array As Object(ThisFile)))
	Return Seq
End Sub
'Obtains a MIDI sequence from the specified input stream.
Public Sub GetSequence2(Stream As InputStream) As MidiSequence
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim Seq As MidiSequence
	Seq.Initialize
	Seq.SetObject(MidiSystem1.RunMethod("getSequence",Array As Object(Stream)))
	Return Seq
End Sub
'Obtains a MIDI sequence from the specified URL.
'Pass a FileUri obtained with File.GetUri(Dir, FileName)
Public Sub GetSequence3(Url As String) As MidiSequence
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim jURL As JavaObject
	jURL.InitializeNewInstance("java.net.URL",Array(Url))
	Dim Seq As MidiSequence
	Seq.Initialize
	Seq.SetObject(MidiSystem1.RunMethod("getSequence",Array As Object(jURL)))
	Return Seq
End Sub

'Obtains the default Sequencer, connected to a default device.
'DO NOT use this method if you want to control midi in real time.
'Use Getsequencer2 and get the synthesizer separately.  That way you can pass 
'messages to it.
'<code>
'Seqr =  MidiSystemStatic.GetSequencer2(False)
'Seqr.Open
'
''Get a Synth To connect
'Dim Synth As MidiSynthesizer = MidiSystemStatic.GetSynthesizer
'Synth.Open
'
''Connect the synth To the sequencer
'Seqr.GetTransmitter.SetReceiver(Synth.GetReceiver)</code>
Public Sub GetSequencer As MidiSequencer
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim S As MidiSequencer
	S.Initialize
	S.SetObject(MidiSystem1.RunMethod("getSequencer",Null))
	Return S
End Sub

'Obtains the default Sequencer, optionally connected to a default device.
'Use this method if you want to control midi in real time.
'Use Getsequencer2 and get the synthesizer separately.  That way you can pass 
'messages to it.
'<code>
'Seqr =  MidiSystemStatic.GetSequencer2(False)
'Seqr.Open
'
''Get a Synth To connect
'Dim Synth As MidiSynthesizer = MidiSystemStatic.GetSynthesizer
'Synth.Open
'
''Connect the synth To the sequencer
'Seqr.GetTransmitter.SetReceiver(Synth.GetReceiver)</code>
Public Sub GetSequencer2(Connected As Boolean) As MidiSequencer
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim S As MidiSequencer
	S.Initialize
	S.SetObject(MidiSystem1.RunMethod("getSequencer",Array As Object(Connected)))
	Return S
End Sub

'Constructs a Soundbank by reading it from the specified File.
Public Sub GetSoundbank(DirName As String, FileName As String) As MidiSoundbank
	'Code for File Object Creation
	Dim ThisFile As JavaObject
	ThisFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim S As MidiSoundbank
	S.Initialize
	S.SetObject(MidiSystem1.RunMethod("getSoundbank",Array As Object(ThisFile)))
	Return S
End Sub
'Constructs a MIDI sound bank by reading it from the specified stream.
Public Sub GetSoundbank2(Stream As InputStream) As MidiSoundbank
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim S As MidiSoundbank
	S.Initialize
	S.SetObject(MidiSystem1.RunMethod("getSoundbank",Array As Object(Stream)))
	Return S
End Sub
'Constructs a Soundbank by reading it from the specified URL.
Public Sub GetSoundbank3(Url As JavaObject) As MidiSoundbank
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim S As MidiSoundbank
	S.Initialize
	S.SetObject(MidiSystem1.RunMethod("getSoundbank",Array As Object(Url)))
	Return S
End Sub
'Obtains the default synthesizer.
Public Sub GetSynthesizer As MidiSynthesizer
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim Wrapper As MidiSynthesizer
	Wrapper.Initialize
	Wrapper.SetObject(MidiSystem1.RunMethod("getSynthesizer",Null))
	Return Wrapper
End Sub
'Obtains a MIDI transmitter from an external MIDI port or other default source.
Public Sub GetTransmitter As MidiTransmitter
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Dim Wrapper As MidiTransmitter
	Wrapper.Initialize
	Wrapper.SetObject(MidiSystem1.RunMethod("getTransmitter",Null))
	Return Wrapper
End Sub
'Indicates whether file writing support for the specified MIDI file type is provided by the system.
Public Sub IsFileTypeSupported(FileType As Int) As Boolean
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Return MidiSystem1.RunMethod("isFileTypeSupported",Array As Object(FileType))
End Sub
'Indicates whether a MIDI file of the file type specified can be written from the sequence indicated.
Public Sub IsFileTypeSupported2(FileType As Int, ThisSequence As MidiSequence) As Boolean
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Return MidiSystem1.RunMethod("isFileTypeSupported",Array As Object(FileType, ThisSequence.GetObject))
End Sub
'Writes a stream of bytes representing a file of the MIDI file type indicated to the external file provided.
Public Sub Write(Seq As MidiSequence, FileType As Int,DirName As String, FileName As String) As Int
	'Code for File Object Creation
	Dim Out As JavaObject
	Out.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Return MidiSystem1.RunMethod("write",Array As Object(Seq.GetObject, FileType, Out))
End Sub
'Writes a stream of bytes representing a file of the MIDI file type indicated to the output stream provided.
Public Sub Write2(Seq As MidiSequence, FileType As Int, Out As OutputStream) As Int
	Dim MidiSystem1 As JavaObject
	MidiSystem1.InitializeStatic("javax.sound.midi.MidiSystem")
	Return MidiSystem1.RunMethod("write",Array As Object(Seq.GetObject, FileType, Out))
End Sub