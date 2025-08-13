B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class Module
Sub Class_Globals
  'Private fx As JFX ' Uncomment if required. For B4j only

  Private JO As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
  JO.InitializeStatic("javax.sound.midi.MidiMessage")
End Sub

'Creates a new object of the same class and with the same contents as this object.
Public Sub Clone As MidiMessage
	Dim Wrapper As MidiMessage
	Wrapper.Initialize
	Wrapper.SetObject(JO.RunMethod("clone",Null))
	Return Wrapper
End Sub
'Returns a hash code value for the object.
Public Sub getHashCode As Int
	Return JO.RunMethod("hashCode",Null)
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
Public Sub SetMessage(bdata() As Byte, ThisLength As Int)
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


Public Sub IsShortMessage As Boolean
	Return GetStatus < 0xF0 And GetLength < 4
End Sub

Public Sub AsShortMessage As MidiShortMessage
	Dim SM As MidiShortMessage
	SM.Initialize
	SM.SetObject(JO)
	Return SM
End Sub

Public Sub IsMidiMetaMessage As Boolean
	Return GetStatus = MidiMetaMessage_Static.META
End Sub

Public Sub AsMidiMetaMessage As MidiMetaMessage
	Dim MM As MidiMetaMessage
	MM.Initialize
	MM.SetObject(JO)
	Return MM
End Sub

Public Sub IsSysexMessage As Boolean
	Return GetStatus = MidiSysexMessage_Static.SYSTEM_EXCLUSIVE Or GetStatus = MidiSysexMessage_Static.SPECIAL_SYSTEM_EXCLUSIVE
End Sub

Public Sub AsSysexMessage As MidiSysexMessage
	Dim SM As MidiSysexMessage
	SM.Initialize
	SM.SetObject(JO)
	Return SM
End Sub
