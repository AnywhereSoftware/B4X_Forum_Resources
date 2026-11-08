B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
#IgnoreWarnings:12
Sub Class_Globals
	Private eMsg As MidiMessage
	Private mTick As Long
End Sub

'Initializes the object.
Public Sub Initialize(Msg As MidiMessage,Tick As Long)
	eMsg = Msg
	mTick = Tick
End Sub
'Gets the MIDI message contained in the event.
Sub getMessage As MidiMessage
	Return eMsg
End Sub
'Get / Set the time-stamp for the event, in MIDI ticks, this is a cumulative DeltaTime
Sub getTick As Long
	Return mTick
End Sub
Sub setTick(Tick As Long)
	mTick = Tick
End Sub
Sub ToString(ChrSet As String) As String					'Ignore
	
	Dim Sysex As Boolean
	
	If Not(MidiETN_Static.IsInitialized) Then MidiETN_Static.Initialize
	
	Dim ID As Int = eMsg.Status
	If ID = 0XF0 OR ID = 0xF7 Then
		Sysex = True
	Else
		'Check for Meta Messages
		Dim SType As Int = Bit.AND(ID,0XF0)
		If SType = 0xF0 Then ID = Bit.AND(eMsg.getMessage(1),0xFF)
	End If
	
	DateTime.SetTimeZone(0)
	DateTime.TimeFormat = "mm:ss:SSS"
	
	'Create the Formatter Object
    Dim Format As JavaObject
    Format.InitializeStatic("java.lang.String")
	
	Dim FormatStringsList As List
	FormatStringsList.Initialize
	FormatStringsList.AddAll(Array As String("%-8s", "%#4X"))
	Dim FormatString As String
	
	Dim Data(12) As Object
	Data(0) = mTick
	If Sysex Then
		Data(1) = ID
		Data(2) = MidiETN_Static.ShortName(ID)
		Data(3) = eMsg.Length
		FormatStringsList.AddAll(Array As String("%-8s","%-8s"))
	Else
		Data(1) = Bit.AND(ID,0XFF)
		Data(2) = MidiETN_Static.ShortName(Bit.AND(ID,0xFF))
		
		If eMsg.HasText Then
			FormatStringsList.AddAll(Array As String("%-8s"," %-8s"))
			Data(3) = eMsg.GetMetaText(ChrSet)
		Else
			FormatStringsList.AddAll(Array As String("%-8s", "%#4X", "%-3s", "%-3s", " %-15s"))
			For i = 0 To Min(6,eMsg.getMessage.Length - 1)
				Data(i+3) = eMsg.getMessage(i)
			Next
			If Bit.AND(Data(4),0XF) = 0xB Then 
				Data(i+3) = MidiETN_Static.CCName(Data(4))
			End If
		End If
	End If
	For i = 0 To FormatStringsList.Size - 1
		Dim Test As String = Data(i)
		If Test.StartsWith("java.lang.Object") Then Exit
		FormatString = FormatString & " " & FormatStringsList.Get(i)
	Next
	
	DateTime.TimeFormat = "mm:ss"
	Return Format.RunMethod("format",Array As Object(FormatString,Data))
	
End Sub
'@SLHIDE
Sub ToStringBBT(Seq As MidiSequence) As String
	
	If Not(MidiETN_Static.IsInitialized) Then MidiETN_Static.Initialize
	
	Dim ID As Int = Bit.AND(eMsg.getMessage(0),0XFF)
	
	Dim SType As Int = Bit.AND(ID,0XF0)
	
	If SType = 0xF0 Then ID = Bit.AND(eMsg.getMessage(1),0xFF)
	
	DateTime.SetTimeZone(0)
	DateTime.TimeFormat = "mm:ss:SSS"
	
	'Create the Formatter Object
    Dim Format As JavaObject
    Format.InitializeStatic("java.lang.String")
	Dim FormatStrings() As String = Array As String("%-10s", "%#4X", "%-8s", "%-3s", "%-3s", "%-3s", " %-15s")
	Dim FormatString As String
	
	Dim Data(11) As Object
	Data(0) = BBT(Seq,mTick)
	Data(0) = mTick
	Data(1) = Bit.AND(ID,0XFF)
	Data(2) = MidiETN_Static.ShortName(Bit.AND(ID,0xFF))
	'Log(Message(0))
	For i = 0 To Min(6,eMsg.getMessage.Length - 1)
		Data(i+3) = eMsg.getMessage(i)
	Next
	If Bit.AND(Data(4),0XF) = 0xB Then 
		Data(i+3) = MidiETN_Static.CCName(Data(4))
	End If
	For i = 0 To FormatStrings.Length - 1
		Dim Test As String = Data(i)
		If Test.StartsWith("java.lang.Object") Then Exit
		FormatString = FormatString & " " & FormatStrings(i)
	Next
	DateTime.TimeFormat = "mm:ss"
	Return Format.RunMethod("format",Array As Object(FormatString,Data))
	
End Sub
'Return string in the format Bar:Beat:Tick
Private Sub BBT(Seq As MidiSequence,Tick As Long) As String
	'!TODO change to match if Resolution holds ticks per frame or Time Sig is not 4/4
	'Assuming Time Sig of 4/4 for now
	Dim NoBeats As Int = 4
	Dim Bar As Int
	Dim Beat As Int
	Dim Ticks As Int
	If Seq.DivisionType = 0.0 Then
		'Resolution holds Ticks Per beat.
		Bar = (Tick / (Seq.Resolution * NoBeats))
		Tick = Tick - (Bar * Seq.Resolution * NoBeats)
		Beat = (Tick / Seq.Resolution)
		Ticks = Tick - (Beat * Seq.Resolution)
	Else
	End If
	Return (Bar + 1) & ":" & (Beat + 1) & ":" & Ticks
End Sub