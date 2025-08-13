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
	MidiMetaMessage_Static.Initialize
End Sub

'Constructs a new MidiMetaMessage.
Public Sub Create
	JO.InitializeNewInstance("javax.sound.midi.MetaMessage",Null)
End Sub

'Constructs a new MidiMetaMessage and sets the message parameters.
Public Sub Create2(TType As Int, Data() As Byte, Length As Int)
		JO.InitializeNewInstance("javax.sound.midi.MetaMessage",Array As Object(TType, Data, Length))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return JO
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return JO
End Sub
'Creates a new object of the same class and with the same contents as this object.
Public Sub Clone As MidiMetaMessage
	Dim Msg As MidiMetaMessage
	Msg.Initialize
	Msg.SetObject(JO.RunMethod("clone",Null))
	Return Msg
End Sub
'Constructs a new MidiMetaMessage and sets the message parameters.
Public Sub Create3(ThisType As Int, Msg As String, Encoding As String)
		Dim BC As ByteConverter
	Dim Data() As Byte = BC.StringToBytes(Msg,Encoding)
	JO.InitializeNewInstance("javax.sound.midi.MetaMessage",Array As Object(ThisType, Data, Data.Length))
End Sub
'Obtains a copy of the data for the meta message.
Public Sub GetData As Byte()
	Return JO.RunMethod("getData",Null)
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
'Obtains the type of the MidiMetaMessage.
Public Sub GetType_ As Int
	Return JO.RunMethod("getType",Null)
End Sub

Public Sub GetTypeName As String
	Return MidiMetaMessage_Static.GetTypeName(Me)
End Sub

Public Sub GetMetaText(Encoding As String) As String
	Dim Msg() As Byte = GetMessage
	Dim Text(Msg.Length - 3) As Byte
	For i = 3 To Msg.Length -1
		Text(i-3) = Msg(i)
	Next
	Dim BC As ByteConverter
	Return BC.StringFromBytes(Text,Encoding)
End Sub
'Sets the message parameters for a MidiMetaMessage.
Public Sub SetMessage(TType As Int, Data() As Byte, Length As Int)
	JO.RunMethod("setMessage",Array As Object(TType, Data, Length))
End Sub

Public Sub SetMetaText(Text As String, Encoding As String)
	Dim BC As ByteConverter
	Dim Out() As Byte = BC.StringToBytes(Text,Encoding)
	Log(Out.Length)
	SetMessage(GetType_,Out,Out.Length)
End Sub
'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	JO = Obj
End Sub

Public Sub ToString(ChrSet As String) As String
	
	'Create the Formatter Object
	Dim Format As JavaObject
	Format.InitializeStatic("java.lang.String")
	Dim FormatStrings() As String = Array As String("%#4X", "%-8s", "%#4X", "%#4X", "%#4X", " %-15s")
	Dim FormatString As String
	
	Dim MetaText As List = Array( _
	MidiMetaMessage_Static.COPYRIGHT, _
	MidiMetaMessage_Static.DEVICE_NAME, _
	MidiMetaMessage_Static.INSTRUMENT_NAME, _
	MidiMetaMessage_Static.LYRIC, _
	MidiMetaMessage_Static.PROGRAM_NAME, _
	MidiMetaMessage_Static.SEQ_OR_TRACK_NAME, _
	MidiMetaMessage_Static.TEXT)
	
	Dim ID As Int = GetMessage(1)
	
	Dim Data(11) As Object
	
	Data(0) = Bit.And(ID,0XFF)
	Data(1) = MidiTypeNames_Static.ShortName(Bit.And(ID,0xFF))

	'Message Data
	For i = 0 To Min(2,GetLength - 1)
		Data(i+2) = GetMessage(i)
	Next
	
	If MetaText.IndexOf(GetMessage(1)) > -1 Then
		'Meta text
		Data(5) = GetMetaText(ChrSet)
		
	Else If Bit.And(GetType_,0xFF) = MidiMetaMessage_Static.TIME_SIGNATURE Then
		Dim TSM() As Byte = GetMessage
		Data(5) = TSM(3) & "/" & Power(2,TSM(4))
	Else If Bit.And(GetType_,0xFF) = MidiMetaMessage_Static.TEMPO Then
		Data(5) = MidiUtils.GetTempoBPM(Me)
	Else If GetLength > 3 Then
		'Testing
		For i = 3 To GetLength - 1
			Data(5) = Data(5) & GetMessage(i)
		Next
	End If

	For i = 0 To FormatStrings.Length - 1
		Dim Test As String = Data(i)
		If Test.StartsWith("java.lang.Object") Then
			Data(i) = ""
			If FormatStrings(i) = "%#4X" Then FormatStrings(i) = "%-4s"
		End If
		FormatString = FormatString & " " & FormatStrings(i)
	Next
	DateTime.TimeFormat = "mm:ss"
	Return Format.RunMethod("format",Array As Object(FormatString,Data))
	
End Sub
