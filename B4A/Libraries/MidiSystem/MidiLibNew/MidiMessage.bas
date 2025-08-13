B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class Module

#IgnoreWarnings: 12
'http://fuseyism.com/classpath/doc/javax/sound/midi/ShortMessage-source.html
'http://fuseyism.com/classpath/doc/javax/sound/midi/MetaMessage-source.html
Sub Class_Globals

	Private mChannel As Int
	Private mCommand As Int
	
	'MidiMessage Vars
	
	Private mMessage() As Byte
	'The number of bytes in the MIDI message, including the status byte and any data bytes.
	Private mLength As Int
	Private mStatus As Int
	Private mType As Int
	Private mMetaType As Int
	
	'MetaData Length of the variable length data length encoding
	Private LengthLength As Int = 0
	
'	Private StaticClassArrays As JavaObject
'	Private StaticClassSystem As JavaObject
	
End Sub
'Initializes the object.
Public Sub Initialize
'	StaticClassArrays.InitializeStatic("java.util.Arrays")
'	StaticClassSystem.InitializeStatic("java.lang.System")
End Sub
'@SLHide
Sub Clone As MidiMessage
	Dim M As MidiMessage
	M.Initialize
	Select mType
		Case MidiMessage_Static.TYPE_SHORTMESSAGE
			M.FASTShortMessage(mMessage)
		Case MidiMessage_Static.TYPE_METAMESSAGE
			M.SetMetaMessage(mMetaType,mMessage,mLength)
		Case MidiMessage_Static.TYPE_SYSEXMESSAGE
			M.SetSysexMessage(mMessage,mMessage.Length)
	End Select
	Return M
End Sub
'Gets the total length of the MIDI message in bytes.
Public Sub getLength As Int
	Return mLength
End Sub
'Gets the MIDI message data. The first byte of the returned byte array is the status byte of the message.
Public Sub getMessage As Byte()
	Return mMessage
End Sub
'Gets the status byte for the MIDI message.
Public Sub getStatus As Int
	Return mStatus
End Sub
#Region Sysex Subs
'Sysex subs

'Sets the Data For the Message. The first Byte of the Data Array must be a valid system exclusive status Byte (0xF0 OR 0xF7).
'Parameters:
'Data - the system exclusive Message Data including the status Byte
'Length - the Length of the valid Message Data In the Array, including the status Byte.
Sub SetSysexMessage(Data() As Byte, Length As Int)
	mStatus = Bit.And(Data(0),0xFF)
	CheckSysexStatus(mStatus)
	mType = MidiMessage_Static.TYPE_SYSEXMESSAGE
	mLength = Length - 1
	MidiLibUtils.Arraycopy(Data,1,mMessage,0,mLength)
End Sub

'Sets the Data For the Message.
'Parameters:
'Status - the Status Byte For the Message; it must be a valid system exclusive Status Byte (0xF0 OR 0xF7)
'Data - the system exclusive Message Data (without the Status Byte)
'Length - the Length of the valid Message Data In the Array; it should be non-negative AND less than OR equal To Data.length
Sub SetSysexMessage2(Status As Int, Data() As Byte, Length As Int)
	CheckSysexStatus(Status)
	mType = MidiMessage_Static.TYPE_SYSEXMESSAGE
	mStatus = Status
	mLength = Length
	mMessage = Data
End Sub
Private Sub CheckSysexStatus(Status As Int) As Boolean
	If Status <> MidiMessage_Static.SYSTEM_EXCLUSIVE And Status <> MidiMessage_Static.SPECIAL_SYSTEM_EXCLUSIVE Then
		MidiLibUtils.InvalidStatus(Status,"")
		Return False
	End If
	Return True
End Sub
'Gets a copy of the data for the system exclusive message. The returned array of bytes does not include the status byte.
Public Sub getSysexData As Byte()
	CheckSysEx
	Return mMessage
End Sub
#End Region Sysex Subs

#Region ShortMessage Subs

'Obtains the MIDI channel associated with this event.
Public Sub getShortMessageChannel As Int
	CheckShortMesssage
	Return mChannel
End Sub
'Obtains the MIDI command associated with this event.
Public Sub getShortMessageCommand As Int
	CheckShortMesssage
	Return mCommand
End Sub
'Obtains the first data byte in the message.
Public Sub getShortMessageData1 As Int
	CheckShortMesssage
	Return mMessage(1)
End Sub
'Obtains the second data byte in the message.
Public Sub getShortMessageData2 As Int
	CheckShortMesssage
	Return mMessage(2)
End Sub
Public Sub getShortMessageData3 As Int
	CheckShortMesssage
	Return mMessage(3)
End Sub
'@SLHide
Sub FASTShortMessage(Message() As Byte)
	'CheckShortMessageCaller(Caller)
	Select Message.Length
		Case 1
			setShortMessage(Bit.And(Message(0),0XFF))
		Case 2
			setShortMessageWithStatus1(Bit.And(Message(0),0XFF),Bit.And(Message(1),0XFF))
		Case 3
			setShortMessageWithStatus2(Bit.And(Message(0),0XFF),Bit.And(Message(1),0XFF),Bit.And(Message(2),0XFF))
		Case Else
			MidiLibUtils.ThrowException("MidiMessage : Short Message : Invalid number of bytes " & Message.Length)
	End Select
End Sub
'Sets the parameters for a MIDI message that takes no data bytes.
'Status should be in the Format 0xnn - 0xCommand,Channel (0 - 15) 
Public Sub setShortMessage(Status As Int)
	mType = MidiMessage_Static.TYPE_SHORTMESSAGE
	mStatus = Status
	mMessage = Array As Byte(Status)
	CheckShortMessageStatus(Status)
	mCommand = Bit.And(Status,0xF0)
	mChannel = Bit.And(Status,0xF)
	mLength = 1
End Sub
'Sets the parameters for a MIDI message that takes one byte.
'Status should be in the Format 0xnn - 0xCommand,Channel (0 - 15) 
'Data should be valid for the message type
Public Sub setShortMessageWithStatus1(Status As Int, Data1 As Int)
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	mType = MidiMessage_Static.TYPE_SHORTMESSAGE
	mStatus = Status
	mMessage = Array As Byte(Status, Data1)
	CheckShortMessageStatus(Status)
	mCommand = Bit.AND(Status,0xF0)
	mChannel = Bit.AND(Status,0xF)
	mLength = 2
End Sub
'Sets the short message parameters for a channel message which takes up to two data bytes.
'Command should be in the Format 0xnn
'Channel should be in the range (0 - 15)
'Data should be valid for the message type
Public Sub setShortMessageWithChannel1(Command As Int, Channel As Int, Data1 As Int)
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	mType = MidiMessage_Static.TYPE_SHORTMESSAGE
	Dim Status As Int = Command + Channel
	mMessage = Array As Byte(Status, Data1)
	CheckShortMessageStatus(Status)
	mStatus = Status
	mChannel = Channel
	mCommand = Command
	mLength = 2
End Sub
'Sets the parameters for a MIDI message that takes one or two data bytes.
'Status should be in the Format 0xnn - 0xCommand,Channel (0 - 15) 
'Data should be valid for the message type
Public Sub setShortMessageWithStatus2(Status As Int, Data1 As Int, Data2 As Int)
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	If Data1 < 0 OR Data2 > 127 Then MidiLibUtils.ThrowException("Data2 Must be > 0 And < 127")
	mType = MidiMessage_Static.TYPE_SHORTMESSAGE
	mMessage = Array As Byte(Status, Data1, Data2)
	CheckShortMessageStatus(Status)
	mStatus = Status
	mCommand = Bit.AND(Status,0xF0)
	mChannel = Bit.AND(Status,0xF)
	mLength = 3
End Sub
'Sets the short message parameters for a channel message which takes up to two data bytes.
'Command should be in the Format 0xnn
'Channel should be in the range (0 - 15)
'Data should be valid for the message type
Public Sub setShortMessageWithChannel2(Command As Int, Channel As Int, Data1 As Int, Data2 As Int)
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	If Data1 < 0 OR Data2 > 127 Then MidiLibUtils.ThrowException("Data2 Must be > 0 And < 127")
	mType = MidiMessage_Static.TYPE_SHORTMESSAGE
	Dim Status As Int = Command + Channel
	mMessage = Array As Byte(Status, Data1, Data2)
	CheckShortMessageStatus(Status)
	mStatus = Status
	mChannel = Channel
	mCommand = Command
	mLength = 3
End Sub
'Sets the parameters for a MIDI message that takes no data bytes.
'Status should be in the Format 0xnn - 0xCommand,Channel (0 - 15) 
Sub SetShortMessage_Message(Status As Int)
	If mType <> MidiMessage_Static.TYPE_SHORTMESSAGE Then MidiLibUtils.ThrowException("Attempt to set Status on a non ShortMessage Message")
	'If mMessage.Length <> 1 Then MidiLibUtils.ThrowException("Cannot change message length with SetShortMessage_Message")
	mStatus = Status
	mCommand = Bit.AND(Status,0xF0)
	mChannel = Bit.AND(Status,0xF)
End Sub
'Sets the parameters for a MIDI message that takes one data byte.
'Status should be in the Format 0xnn - 0xCommand,Channel (0 - 15) 
'Data should be valid for the message type
Sub SetShortMessage_Message2(Status As Int,Data1 As Int)
	If mType <> MidiMessage_Static.TYPE_SHORTMESSAGE Then MidiLibUtils.ThrowException("Attempt to set Status on a non ShortMessage Message")
	If mMessage.Length <> 2 Then MidiLibUtils.ThrowException("Cannot change message length with SetShortMessage_Message2")
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	mStatus = Status
	mCommand = Bit.AND(Status,0xF0)
	mChannel = Bit.AND(Status,0xF)
	mMessage(1) = Data1
End Sub
'Sets the parameters for a MIDI message that takes two data bytes.
'Status should be in the Format 0xnn - 0xCommand,Channel (0 - 15) 
'Data should be valid for the message type
Sub SetShortMessage_Message3(Status As Int,Data1 As Int,Data2 As Int)
	If mType <> MidiMessage_Static.TYPE_SHORTMESSAGE Then MidiLibUtils.ThrowException("Attempt to set Status on a non ShortMessage Message")
	If mMessage.Length <> 3 Then MidiLibUtils.ThrowException("Cannot change message length with SetShortMessage_Message3")
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	If Data1 < 0 OR Data2 > 127 Then MidiLibUtils.ThrowException("Data2 Must be > 0 And < 127")
	mStatus = Status
	mCommand = Bit.AND(Status,0xF0)
	mChannel = Bit.AND(Status,0xF)
	mMessage(1) = Data1
	mMessage(2) = Data2
End Sub
'Sets the parameters for a channel message that takes one data byte.
'Command should be in the Format 0xnn
'Channel should be in the range (0 - 15)
'Data should be valid for the message type
Sub SetShortMessage_Message4(Command As Int, Channel As Int, Data1 As Int)
	If mType <> MidiMessage_Static.TYPE_SHORTMESSAGE Then MidiLibUtils.ThrowException("Attempt to set Status on a non ShortMessage Message")
	If mMessage.Length <> 2 Then MidiLibUtils.ThrowException("Cannot change message length with SetShortMessage_Message4")
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	mStatus = Bit.AND(Command,Channel)
	mCommand = Command
	mChannel = Channel
	mMessage(1) = Data1
End Sub
'Sets the parameters for a channel message that takes two data bytes.
'Command should be in the Format 0xnn
'Channel should be in the range (0 - 15)
'Data should be valid for the message type
Sub SetShortMessage_Message5(Command As Int, Channel As Int, Data1 As Int, Data2 As Int)
	If mType <> MidiMessage_Static.TYPE_SHORTMESSAGE Then MidiLibUtils.ThrowException("Attempt to set Status on a non ShortMessage Message")
	If mMessage.Length <> 3 Then MidiLibUtils.ThrowException("Cannot change message length with SetShortMessage_Message5")
	If Data1 < 0 OR Data1 > 127 Then MidiLibUtils.ThrowException("Data1 Must be > 0 And < 127")
	If Data1 < 0 OR Data2 > 127 Then MidiLibUtils.ThrowException("Data2 Must be > 0 And < 127")
	mStatus = Bit.AND(Command,Channel)
	mCommand = Command
	mChannel = Channel
	mMessage(1) = Data1
	mMessage(2) = Data2
End Sub

Private Sub CheckShortMessageStatus(Status As Int) As Boolean
	If Bit.AND(Status,0xE0) = 0xE0 Then Status = Bit.OR(Bit.ShiftLeft(Bit.ShiftRight(Status,4),4),0)
	If getDataLength(Status) + 1 <> mMessage.Length Then
		MidiLibUtils.InvalidStatus(Status,mMessage.Length)
		Return False
	End If
	Return True
End Sub

Private Sub CheckShortMesssage
	getDataLength(getStatus)
End Sub

'Retrieves the number of data bytes associated with a particular status byte value.
Private Sub getDataLength(Status As Int) As Int				'Ignore
    
    Dim OriginalStatus As Int = Status
  
  	If Bit.AND(Status, 0xF0) <> 0xF0 Then Status = Bit.AND(Status , 0xF0)
  
	Select Status
		
		Case MidiMessage_Static.STATUS_NOTE_OFF, _
		MidiMessage_Static.STATUS_NOTE_ON , _
		MidiMessage_Static.STATUS_POLY_PRESSURE, _
		MidiMessage_Static.STATUS_CONTROL_CHANGE, _
		MidiMessage_Static.STATUS_PITCH_BEND, _
		MidiMessage_Static.STATUS_SONG_POSITION_POINTER
		Return 2

		Case MidiMessage_Static.STATUS_PROGRAM_CHANGE, _
		MidiMessage_Static.STATUS_CHANNEL_PRESSURE, _
		MidiMessage_Static.STATUS_SONG_SELECT, _
		0xF5   ' FIXME, _ unofficial bus Select.  Not In spec??
		Return 1

		Case MidiMessage_Static.STATUS_TUNE_REQUEST, _
		MidiMessage_Static.STATUS_END_OF_EXCLUSIVE, _
		MidiMessage_Static.STATUS_TIMING_CLOCK, _
		MidiMessage_Static.STATUS_START, _
		MidiMessage_Static.STATUS_CONTINUE_, _
		MidiMessage_Static.STATUS_STOP, _
		MidiMessage_Static.STATUS_ACTIVE_SENSING, _
		MidiMessage_Static.STATUS_SYSTEM_RESET
		Return 0

		Case Else
			MidiLibUtils.ThrowException("Invalid status: " + MidiLibUtils.GetAsHexStr(OriginalStatus))
    End Select
End Sub
'Sub CheckShortMessageCaller(Caller As Object) As Boolean
'	If Caller Is SMFParser OR Caller Is SequencerReceiver Then Return True
'	MidiLibUtils.ThrowException("MidiMessage : Cannot use FastShortMessage directly, use a SetShortMessage Method")
'End Sub
#End Region Short Message Subs

#Region Meta Message Subs
'Obtains a copy of the data for the meta message. The returned array of bytes does not include the Status byte (Always 0xFF) or the MetaType.
'The length of the data For the Meta Message is the length of the Array. Note that the length of the entire Message includes the status Byte 
'and the meta Message Type Byte, and therefore may be longer than the returned Array.
Public Sub getMetaData As Byte()
	CheckMeta
	Dim DataLength As Int = mLength - 2 - LengthLength
	If DataLength > 0 Then
		Dim Dest(DataLength) As Byte
		MidiLibUtils.Arraycopy(mMessage,2 + LengthLength,Dest,0,DataLength)
		Return Dest
'		Return StaticClassArrays.RunMethod("copyOfRange",Array As Object(mMessage,2 + LengthLength,DataLength))
	Else
		Return Array As Byte()
	End If
End Sub
'Get the text within this message, returns "" if there is none or the string is empty
Sub GetMetaText(ChrSet As String) As String
	Dim Text As String
	If mType = MidiMessage_Static.TYPE_METAMESSAGE Then
		If HasText Then
			Dim TextArr() As Byte = getMetaData
			'Text = BC.StringFromBytes(TextArr,ChrSet)
			Text = MidiLibUtils.StringFromBytes(TextArr,ChrSet)
			Return Text
		End If
	End If
	Return ""
End Sub
'Gets the Meta type of this message, first checks it is a valid metamessage and throws exception if not
Public Sub getMetaType As Int
	CheckMeta
	Return mMetaType
End Sub
'Sets the message parameters for a MetaMessage.
'The status is automatically set to 0xFF
'MetaType should be a valid MetaData Type
'Data should not include the Status or the MetaType
'For example: To set a message for the EndOfTrack Marker Use
' 
'<code>Dim Msg As MidiMessage
'Msg.Initialize
'Msg.setMetaMessage(0x2F,Array As Byte(),0)</code>
'Then add it to an event with the appropriate tick	
Public Sub SetMetaMessage(MetaType As Int, Data() As Byte, Length As Int)

	If MetaType > 127 Then MidiLibUtils.ThrowException("Meta type " & MetaType & " must be less than 128")

	mStatus = MidiMessage_Static.METAStatus
	mMetaType = MetaType
	mType = MidiMessage_Static.TYPE_METAMESSAGE
	
	'First compute the length of the length value
	LengthLength = 0
	Dim LengthValue As Int = Length
	
	Do While True
		LengthValue = Bit.ShiftRight(LengthValue,7)
		LengthLength = LengthLength + 1
		If LengthValue <= 0 Then Exit
	Loop
'	Log("MM LL " & LengthLength)
	'Now allocate our message array
	mLength = 2 + LengthLength + Length
	Dim mMessage(mLength) As Byte
	mMessage(0) = MidiMessage_Static.METAStatus
	mMessage(1) = MetaType
	
	'Now Compute the length representation
	Dim Buffer As Long = Bit.AND(Length,0x7F)
	LengthValue = Length

	LengthValue = Bit.ShiftRight(LengthValue,7)
	Do While LengthValue > 0
		Buffer = Bit.ShiftLeft(Buffer,8)
		Buffer = Bit.OR(Buffer,Bit.OR(Bit.AND(LengthLength,0x7),0x80))
		LengthValue = Bit.ShiftRight(LengthValue,7)
	Loop
'	Log("MM Here 1 ")
'	Log("MM Buffer " & Buffer)
	'Now store the variable length value
	Dim Index As Int = 2
	
	Do While True
		mMessage(Index) = Bit.AND(Buffer,0xFF)
		Index = Index + 1
		If Bit.AND(Buffer,0x80) = 0 Then Exit
		Buffer = Bit.ShiftRight(Buffer,8)
	Loop
'	Log("MM Index " & Index)
'	Log("MM MetaType " & MetaType)
'	Log("MM Length " & Length)
'	Log("MM DataLength " & Data.Length)
'	Log("MM MsgLength 1 " & mMessage.Length)
'	Log("MM Here 2 ")
	'Now copy the real data
	MidiLibUtils.Arraycopy(Data,0,mMessage,Index,Length)
	
End Sub
'Check if this message is a Meta Message, Throw exception if not
Private Sub CheckMeta
	If getStatus <> MidiMessage_Static.METAStatus Then MidiLibUtils.ThrowException("MidiMessage : Not a meta Message")
End Sub
Private Sub CheckSysEx
	If getStatus <> 0XF0 AND getStatus <> 0Xf7 Then MidiLibUtils.ThrowException("MidiMessage : Not a SysexMessage")
End Sub
'Returns the type of the message - One of the MidiMessage_Static Constants
'TYPE_SHORTMESSAGE, TYPEMETAMESSAGE or TYPESYSEXMESSAGE
Sub getMessageType As Int
	Return mType
End Sub
'@SLHide
Sub HasText As Boolean
	Return mMetaType > 0x00 AND mMetaType < 0x08
End Sub
'Test the message Type, returns True if this message = MidiMessage_Static.TYPE_SHORTMESSAGE, false otherwise
Sub IsShortMessage As Boolean
	Return mType = MidiMessage_Static.TYPE_SHORTMESSAGE
End Sub
'Test the message Type, returns True if this message = MidiMessage_Static.TYPE_METAMESSAGE, false otherwise
Sub IsMetaMessage As Boolean
	Return mType = MidiMessage_Static.TYPE_METAMESSAGE
End Sub
'Test the message Type, returns True if this message = MidiMessage_Static.TYPE_SYSEXMESSAGE, false otherwise
Sub IsSysexMessage As Boolean
	Return mType = MidiMessage_Static.TYPE_SYSEXMESSAGE
End Sub