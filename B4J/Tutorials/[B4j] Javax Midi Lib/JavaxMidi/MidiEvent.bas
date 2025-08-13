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
Public Sub Initialize As MidiEvent
	Return Me
End Sub 

'Constructs a new MidiEvent for sysex Message.
Public Sub CreateSysex(Message As MidiSysexMessage, Tick As Long)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.MidiEvent",Array As Object(Message.GetObject, Tick))
End Sub

'Constructs a new MidiEvent for Meta Message.
Public Sub CreateMeta(Message As MidiMetaMessage, Tick As Long)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	JO.InitializeNewInstance("javax.sound.midi.MidiEvent",Array As Object(Message.GetObject, Tick))
End Sub

'Constructs a new MidiEvent for Short Message.
Public Sub CreateShort(Message As MidiShortMessage, Tick As Long)
  'If a JavaObject has been passed, you may need to create it here and remove the parameter
  JO.InitializeNewInstance("javax.sound.midi.MidiEvent",Array As Object(Message.GetObject, Tick))
End Sub

'Constructs a new MidiEvent With a Short Message.
Public Sub CreateShort2(Status As Int, Data1 As Int, Data2 As Int, Tick As Long)
	Dim SM As JavaObject
	SM.InitializeNewInstance("javax.sound.midi.ShortMessage",Array As Object(Status, Data1, Data2))
  	JO.InitializeNewInstance("javax.sound.midi.MidiEvent",Array As Object(SM, Tick))
End Sub

'Returns a hash code value for the object.
Public Sub getHashCode As Int
	Return JO.RunMethod("hashCode",Null)
End Sub

'Obtains the MIDI message contained in the event.
Public Sub GetMessage As MidiMessage
  Dim Wrapper As MidiMessage
  Wrapper.Initialize
  Wrapper.SetObject(JO.RunMethod("getMessage",Null))
  Return Wrapper
End Sub
'Obtains the time-stamp for the event, in MIDI ticks
Public Sub GetTick As Long
  Return JO.RunMethod("getTick",Null)
End Sub
'Sets the time-stamp for the event, in MIDI ticks
Public Sub SetTick(Tick As Long)
  JO.RunMethod("setTick",Array As Object(Tick))
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


'Returns a string representation of the midi event.
Sub ToString(ChrSet As String) As String					'Ignore
	
	'Create the Formatter Object
	Dim Format As JavaObject
	Format.InitializeStatic("java.lang.String")
	Dim FormatStrings() As String = Array As String("%-10s", "%#4X", "%-8s", "%#4X", "%#4X", "%#4X", " %-15s")
	Dim FormatString As String
	
	Dim MetaText As List = Array( _
	MidiMetaMessage_Static.COPYRIGHT, _
	MidiMetaMessage_Static.DEVICE_NAME, _
	MidiMetaMessage_Static.INSTRUMENT_NAME, _
	MidiMetaMessage_Static.LYRIC, _
	MidiMetaMessage_Static.PROGRAM_NAME, _
	MidiMetaMessage_Static.SEQ_OR_TRACK_NAME, _
	MidiMetaMessage_Static.TEXT)
	
	Dim eMsg As MidiMessage = GetMessage
	
	Dim ID As Int
	If eMsg.IsMidiMetaMessage Then
		ID = eMsg.GetMessage(1)
	Else
		ID = eMsg.GetMessage(0)
	End If
	
	DateTime.SetTimeZone(0)
	DateTime.TimeFormat = "mm:ss:SSS"
	
	Dim Data(11) As Object
	'Time
	Data(0) = GetTick
	
	Data(1) = Bit.And(ID,0XFF)
	Data(2) = MidiTypeNames_Static.ShortName(Bit.And(ID,0xFF))

	'Message Data
	For i = 0 To Min(2,eMsg.GetLength - 1)
		Data(i+3) = eMsg.getMessage(i)
	Next
	
	If Bit.And(ID,0xF0) = 0xB0 Then
		'Controller Name
		Data(6) = MidiTypeNames_Static.CCName(eMsg.GetMessage(1))
		
	Else If Bit.And(ID,0xF0) = 0xC0 Then
		'Patch Change
		Data(6) = Midi_GM.GetProgName(eMsg.GetMessage(1))
		
	Else If eMsg.IsMidiMetaMessage Then
		If MetaText.IndexOf(Bit.And(eMsg.AsMidiMetaMessage.GetType_,0xFF)) > -1 Then
			'Meta text
			Data(6) = eMsg.AsMidiMetaMessage.GetMetaText(ChrSet)
		Else If Bit.And(eMsg.AsMidiMetaMessage.GetType_,0xFF) = MidiMetaMessage_Static.TIME_SIGNATURE Then
			Dim TSM() As Byte = eMsg.GetMessage
			Data(6) = TSM(3) & "/" & Power(2,TSM(4))
		Else If Bit.And(eMsg.AsMidiMetaMessage.GetType_,0xFF) = MidiMetaMessage_Static.TEMPO Then
			Data(6) = MidiUtils.GetTempoBPM(eMsg.AsMidiMetaMessage)
		End If
	Else If eMsg.GetLength > 3 Then
		'Testing
		For i = 3 To eMsg.GetLength - 1
			Data(6) = Data(6) & eMsg.GetMessage(i)
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

'To string with Beats Bars and ticks, This is an example and is only really useful if there is only 1
'Time signature event in the midi file.  If there are more than 1 you will need to Map the changes to calculate an
'accurate bar value.
Sub ToStringBBT(Seq As MidiSequence,BeatsPerBar As Int,Chrset As String) As String
		
	'Create the Formatter Object
	Dim Format As JavaObject
	Format.InitializeStatic("java.lang.String")
	Dim FormatStrings() As String = Array As String("%-10s", "%#4X", "%-8s", "%#4X", "%#4X", "%#4X", " %-15s")
	Dim FormatString As String
	
	Dim MetaText As List = Array( _
	MidiMetaMessage_Static.COPYRIGHT, _
	MidiMetaMessage_Static.DEVICE_NAME, _
	MidiMetaMessage_Static.INSTRUMENT_NAME, _
	MidiMetaMessage_Static.LYRIC, _
	MidiMetaMessage_Static.PROGRAM_NAME, _
	MidiMetaMessage_Static.SEQ_OR_TRACK_NAME, _
	MidiMetaMessage_Static.TEXT)
	
	Dim eMsg As MidiMessage = GetMessage
	
	Dim ID As Int
	If eMsg.IsMidiMetaMessage Then
		ID = eMsg.GetMessage(1)
	Else
		ID = eMsg.GetMessage(0)
	End If
	
	DateTime.SetTimeZone(0)
	DateTime.TimeFormat = "mm:ss:SSS"
	
	Dim Data(11) As Object
	'Time
	Data(0) = BBT(Seq,GetTick,BeatsPerBar)
	
	Data(1) = Bit.And(ID,0XFF)
	Data(2) = MidiTypeNames_Static.ShortName(Bit.And(ID,0xFF))

	'Message Data
	For i = 0 To Min(2,eMsg.GetLength - 1)
		Data(i+3) = eMsg.getMessage(i)
	Next
	
	If Bit.And(ID,0xF0) = 0xB0 Then
		'Controller Name
		Data(6) = MidiTypeNames_Static.CCName(eMsg.GetMessage(1))
		
	Else If Bit.And(ID,0xF0) = 0xC0 Then
		'Patch Change
		Data(6) = Midi_GM.GetProgName(eMsg.GetMessage(1))
		
	Else If eMsg.IsMidiMetaMessage Then
		If MetaText.IndexOf(Bit.And(eMsg.AsMidiMetaMessage.GetType_,0xFF)) > -1 Then
			'Meta text
			Data(6) = eMsg.AsMidiMetaMessage.GetMetaText(Chrset)
		Else If Bit.And(eMsg.AsMidiMetaMessage.GetType_,0xFF) = MidiMetaMessage_Static.TIME_SIGNATURE Then
			Dim TSM() As Byte = eMsg.GetMessage
			Data(6) = TSM(3) & "/" & Power(2,TSM(4))
		Else If Bit.And(eMsg.AsMidiMetaMessage.GetType_,0xFF) = MidiMetaMessage_Static.TEMPO Then
			Data(6) = MidiUtils.GetTempoBPM(eMsg.AsMidiMetaMessage)
		End If
	Else If eMsg.GetLength > 3 Then
		'Testing
		For i = 3 To eMsg.GetLength - 1
			Data(6) = Data(6) & eMsg.GetMessage(i)
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
'Return string in the format Bar:Beat:Tick
Private Sub BBT(Seq As MidiSequence,Tick As Long,BeatsPerBar As Int) As String
	'!TODO change to match if Resolution holds ticks per frame or Time Sig is not 4/4
	'Assuming Time Sig of 4/4 for now
	Dim Bar As Int
	Dim Beat As Int
	Dim Ticks As Int
	If Seq.GetDivisionType = 0.0 Then
		'Resolution holds Ticks Per beat.
		Bar = (Tick / (Seq.GetResolution * BeatsPerBar))
		Tick = Tick - (Bar * Seq.GetResolution * BeatsPerBar)
		Beat = (Tick / Seq.GetResolution)
		Ticks = Tick - (Beat * Seq.GetResolution)
	Else
	End If
	Return (Bar + 1) & ":" & (Beat + 1) & ":" & Ticks
End Sub

'Return Ticks from BBT
Public Sub BBT2Ticks(BBTStr As String, Seq As MidiSequence, BeatsPerBar As Int) As Long
	
	'!TODO change to match if Resolution holds ticks per frame or Time Sig is not 4/4
	
	
	
	Dim Pos As Int = BBTStr.IndexOf(":")
	Dim Pos1 As Int = BBTStr.LastIndexOf(":")
	Dim Bar As Int = BBTStr.SubString2(0,Pos)
	Dim Beat As Int = BBTStr.SubString2(Pos+1,Pos1)
	Dim Ticks As Int = BBTStr.SubString(Pos1+1)
	
	Dim Result As Long = Ticks
	Result = Result + Beat * Seq.GetResolution
	Result = Result + Bar * BeatsPerBar * Seq.GetResolution
	
	Return Result
End Sub