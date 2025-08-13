B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub

'Constructs a MidiFileFormat.
Public Sub Create(TType As Int, DivisionType As Float, Resolution As Int, Bytes As Int, Microseconds As Long)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javax.sound.midi.MidiFileFormat",Array As Object(TType, DivisionType, Resolution, Bytes, Microseconds))
End Sub

'Construct a MidiFileFormat with a set of properties.
Public Sub Create2(TType As Int, DivisionType As Float, Resolution As Int, Bytes As Int, Microseconds As Long, ThisProperties As Map)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javax.sound.midi.MidiFileFormat",Array As Object(TType, DivisionType, Resolution, Bytes, Microseconds, ThisProperties))
End Sub

'Obtains the length of the MIDI file, expressed in 8-bit bytes.
Public Sub GetByteLength As Int
	Return TJO.RunMethod("getByteLength",Null)
End Sub
'Obtains the timing division type for the MIDI file.
Public Sub GetDivisionType As Float
	Return TJO.RunMethod("getDivisionType",Null)
End Sub
'Obtains the length of the MIDI file, expressed in microseconds.
Public Sub GetMicrosecondLength As Long
	Return TJO.RunMethod("getMicrosecondLength",Null)
End Sub
'Obtain the property value specified by the key.
Public Sub GetProperty(Key As String) As Object
	Return TJO.RunMethod("getProperty",Array As Object(Key))
End Sub
'Obtains the timing resolution for the MIDI file.
Public Sub GetResolution As Int
	Return TJO.RunMethod("getResolution",Null)
End Sub
'Obtains the MIDI file type.
Public Sub GetType_ As Int
	Return TJO.RunMethod("getType",Null)
End Sub
'Obtain an unmodifiable map of properties.
Public Sub Properties As Map
	Return TJO.RunMethod("properties",Null)
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub


