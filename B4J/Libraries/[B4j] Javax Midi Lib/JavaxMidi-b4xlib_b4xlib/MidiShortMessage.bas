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
End Sub

'Constructs a new Empty MidiShortMessage.
Public Sub CreateEmpty
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.ShortMessage",Null)
End Sub

'Constructs a new MidiShortMessage which represents a MIDI message that takes no data bytes.
Public Sub CreateStatus(Status As Int)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	JO.InitializeNewInstance("javax.sound.midi.ShortMessage",Array As Object(Status))
End Sub

'Constructs a new MidiShortMessage which represents a MIDI message that takes one data bytes.
Public Sub Create1Byte(Status As Int,Data1 As Int)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	JO.InitializeNewInstance("javax.sound.midi.ShortMessage",Array As Object(Status,Data1,0))
End Sub


'Constructs a new MidiShortMessage which represents a MIDI message that takes two data bytes.
Public Sub Create2Bytes(Status As Int, Data1 As Int, Data2 As Int)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.ShortMessage",Array As Object(Status, Data1, Data2))
End Sub

'Constructs a new MidiShortMessage which represents a channel MIDI message that takes one data bytes.
Public Sub Create3(Command As Int, Channel As Int, Data1 As Int)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	JO.InitializeNewInstance("javax.sound.midi.ShortMessage",Array As Object(Command, Channel, Data1))
End Sub

'Constructs a new MidiShortMessage which represents a channel MIDI message that takes up to two data bytes.
Public Sub Create4(Command As Int, Channel As Int, Data1 As Int, Data2 As Int)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.ShortMessage",Array As Object(Command, Channel, Data1, Data2))
End Sub

'Creates a new object of the same class and with the same contents as this object.
Public Sub Clone As MidiShortMessage
	Dim Wrapper As MidiShortMessage
	Wrapper.Initialize
	Wrapper.SetObject(JO.RunMethod("clone",Null))
	Return Wrapper
End Sub
'Obtains the MIDI channel associated with this event.
Public Sub GetChannel As Int
  Return JO.RunMethod("getChannel",Null)
End Sub
'Obtains the MIDI command associated with this event.
Public Sub GetCommand As Int
  Return JO.RunMethod("getCommand",Null)
End Sub

'Gets the data for this message
Sub getData() As Byte()
	If GetLength = 3 Then Return Array As Byte(GetStatus,GetData1,GetData2)
	If GetLength = 2 Then Return Array As Byte(GetStatus,GetData1)
	Return Array As Byte()
End Sub

'Obtains the first data byte in the message.
Public Sub GetData1 As Int
  Return JO.RunMethod("getData1",Null)
End Sub
'Obtains the second data byte in the message.
Public Sub GetData2 As Int
  Return JO.RunMethod("getData2",Null)
End Sub
'Retrieves the number of data bytes associated with a particular status byte value.
Private Sub GetDataLength(Status As Int) As Int
  Return JO.RunMethod("getDataLength",Array As Object(Status))
End Sub

'Returns a hash code value for the object.
Public Sub getHashCode As Int
	Return JO.RunMethod("hashCode",Null)
End Sub
'Sets the parameters for a MIDI message that takes no data bytes.
Public Sub SetMessage(Status As Int)
  JO.RunMethod("setMessage",Array As Object(Status))
End Sub
'Sets the parameters for a MIDI message that takes one or two data bytes.
Public Sub SetMessage2(Status As Int, Data1 As Int, Data2 As Int)
  JO.RunMethod("setMessage",Array As Object(Status, Data1, Data2))
End Sub
'Sets the short message parameters for a channel message which takes up to two data bytes.
Public Sub SetMessage3(Command As Int, Channel As Int, Data1 As Int, Data2 As Int)
  JO.RunMethod("setMessage",Array As Object(Command, Channel, Data1, Data2))
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
Public Sub GetTypeName As String
	Return MidiMessage_Static.GetTypeName(Me)
End Sub
'Sets the data for the MIDI message.
Private Sub SetMessage4(bdata() As Byte, ThisLength As Int)
  JO.RunMethod("setMessage",Array As Object(bdata, ThisLength))
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
