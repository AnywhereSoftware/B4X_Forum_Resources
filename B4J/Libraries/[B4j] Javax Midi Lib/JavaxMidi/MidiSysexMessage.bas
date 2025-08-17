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

  Private JO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
  'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
End Sub

'Constructs a new MidiSysexMessage.
Public Sub Create
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.SysexMessage",Null)
End Sub

'Constructs a new MidiSysexMessage.
Public Sub Create2(Data() As Byte)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.SysexMessage",Array As Object(Data))
End Sub

'Constructs a new MidiSysexMessage and sets the data for the message.
Public Sub Create3(Data() As Byte, Length As Int)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.SysexMessage",Array As Object(Data, Length))
End Sub

'Constructs a new MidiSysexMessage and sets the data for the message.
Public Sub Create4(Status As Int, Data() As Byte, Length As Int)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.SysexMessage",Array As Object(Status, Data, Length))
End Sub

'Creates a new object of the same class and with the same contents as this object.
Public Sub Clone As MidiSysexMessage
	Dim Wrapper As MidiSysexMessage
	Wrapper.Initialize
	Wrapper.SetObject(JO.RunMethod("clone",Null))
	Return Wrapper
End Sub
'Obtains a copy of the data for the system exclusive message.
Public Sub GetData As Byte()
  Return JO.RunMethod("getData",Null)
End Sub
'Returns a hash code value for the object.
Public Sub getHashCode As Int
	Return JO.RunMethod("hashCode",Null)
End Sub
'Sets the data for the system exclusive message.
Public Sub SetMessage(Data() As Byte, Length As Int)
  JO.RunMethod("setMessage",Array As Object(Data, Length))
End Sub
'Sets the data for the system exclusive message.
Public Sub SetMessage2(Status As Int, Data() As Byte, Length As Int)
  JO.RunMethod("setMessage",Array As Object(Status, Data, Length))
End Sub
'Obtains the total length of the MIDI message in bytes.
Public Sub GetLength As Int
  Return JO.RunMethod("getLength",Null)
End Sub
'Obtains the MIDI message data.
Public Sub GetMessage As Byte()
  Return JO.RunMethod("getMessage",Null)
End Sub
'Obtains the status byte for the MIDI message.
Public Sub GetStatus As Int
  Return JO.RunMethod("getStatus",Null)
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
  Return JO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
  Return JO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	JO = Obj
End Sub



