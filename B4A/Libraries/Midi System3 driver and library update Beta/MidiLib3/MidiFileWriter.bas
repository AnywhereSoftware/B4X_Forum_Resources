B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module

#IgnoreWarnings: 12
'@SLHideClass
Sub Class_Globals

	Private Const MThd_MAGIC As Int = 0x4d546864  ' 'MThd'
	Private Const MTrk_MAGIC As Int = 0x4d54726b  ' 'MTrk'
	Private Const ONE_BYTE   As Int = 1
	Private Const TWO_BYTE   As Int = 2
	Private Const SYSEX      As Int = 3
	Private Const META       As Int = 4
	Private Const ERROR      As Int = 5
	Private Const IGNORE     As Int = 6
	Private Const MIDI_TYPE_0 As Int = 0
	Private Const MIDI_TYPE_1 As Int = 1
	Private Const MASK As Int = 0x7F

	Private bufferSize As Int = 16384  ' bufferSize For write
	Private TdDos As SLDataOutputStream               ' data output stream For Track writing
	Dim Types() As Int = Array As Int(MIDI_TYPE_0,MIDI_TYPE_1)
End Sub

'Initializes the object.
'@SLHide
Public Sub Initialize

End Sub

'Obtains the file types that this provider can write.
'@SLHide
Sub MidiFileTypes As Int()
	Dim LocalArray(Types.Length) As Int
	MidiLibUtils.Arraycopy(Types,0,LocalArray,0,Types.Length)
	Return LocalArray
End Sub
'Obtains the file types that this provider can write from the Sequence specified.
'@SLHide
Sub MidiFileTypes1(Seq As MidiSequence) As Int()
	Dim TypesArray() As Int
	Dim Tracks() As MidiTrack = Seq.GetTracks
	
	If Tracks.Length = 1 Then
		TypesArray = Array As Int(MIDI_TYPE_0,MIDI_TYPE_1)
	Else
		TypesArray = Array As Int(MIDI_TYPE_1)
	End If
	
	Return TypesArray
End Sub
'Test whether the specified file type is supported
'@SLHide
Sub IsFileTypesupported(TType As Int) As Boolean
	For i = 0 To Types.Length - 1
		If TType = Types(i) Then Return True
	Next
	Return False
End Sub
'Write the sequence to the specified output stream
'@SLHide
Sub Write(Seq As MidiSequence,TType As Int, Out As OutputStream) As Int
	
	Dim BytesRead As Int
	Dim BytesWritten As Long
	
	If Not(IsFileTypesupported(TType)) Then MidiLibUtils.ThrowException("MidiFileWriter : FileType Not Supported : " & TType)
	
	Dim FileStream As InputStream = GetFileStream(TType,Seq)
	
	If FileStream = Null Then MidiLibUtils.ThrowException("MidiFileWriter : Could not write MIDI File Type : " & TType)
	
	Dim Buffer(bufferSize) As Byte
	
	BytesRead = FileStream.ReadBytes(Buffer,0,bufferSize)
	Do While BytesRead >=0
		Out.WriteBytes(Buffer,0,BytesRead)
		BytesWritten = BytesWritten + BytesRead
		BytesRead = FileStream.ReadBytes(Buffer,0,bufferSize)
	Loop
	FileStream.Close

	Return BytesWritten
End Sub
'Write the sequence to the specified file
'@SLHide
Sub WriteFile(Seq As MidiSequence,TType As Int,FilePath As String, FileName As String) As Int
	Dim Fos As OutputStream = File.OpenOutput(FilePath,FileName,False)
	Dim BytesWritten As Int = Write(Seq,TType,Fos)
	Fos.Close
	Return BytesWritten
End Sub
Private Sub GetFileStream(TType As Int,Seq As MidiSequence) As InputStream

	Dim Tracks() As MidiTrack  = Seq.getTracks
'	Dim BytesBuilt As Int = 0
	Dim HeaderLength As Int = 14
	'Dim Length As Int
	Dim TimeFormat As Int
	Dim Divtype As Float
	
	Dim TrackStream As InputStream
	Dim FStream As InputStream
	
	If TType = MIDI_TYPE_0 Then
		If Tracks.Length <> 1 Then
			Return Null
		End If
	Else
		If TType = MIDI_TYPE_1 Then
			If Tracks.Length < 1 Then
				Return Null
			Else
				If Tracks.Length = 1 Then
					TType = MIDI_TYPE_0
				Else
					If Tracks.Length > 1 Then
						TType = MIDI_TYPE_1
					Else
						Return Null
					End If
				End If
			End If
		End If
	End If
	
	' Now build the File one Track at a time
	' Note that above we made sure that MIDI_TYPE_0 only happens
	' If Tracks.length==1
	Dim TrackStreams(Tracks.Length) As InputStream
	Dim TrackCount As Int
	
	For i = 0 To Tracks.Length - 1
		TrackStreams(TrackCount) = WriteTrack(Tracks(i),TType)
		TrackCount = TrackCount + 1
	Next
	
	'Now sequence the track streams
	If TrackCount = 1 Then 
		TrackStream = TrackStreams(0)
	Else
		If TrackCount > 1 Then
			TrackStream = TrackStreams(0)
			For i = 1 To Tracks.Length - 1
				If TrackStreams(i) <> Null Then
					Dim SIS As SLSequenceInputStream
					SIS.Initialize(TrackStream,TrackStreams(i))
					'TrackStream = SIS
					TrackStream = SIS.GetObject
				End If
			Next
		Else
			MidiLibUtils.ThrowException("MidiFileWriter : invalid MIDI data in sequence")
		End If
	End If
	
	'Now Build the Header
	
	Dim Hpos As SLPipedOutputStream
	Hpos.Initialize
	Hpos.Create
	Dim Hdos As SLDataOutputStream
	'Hdos.Initialize(Hpos)
	Hdos.Initialize(Hpos.GetObject)
	
	
	Dim HeaderStream As SLPipedInputStream
	'HeaderStream.Initialize(Hpos)
	HeaderStream.Initialize
	HeaderStream.Create2(Hpos.GetObject)
	
	' Write the magic number
	Hdos.writeInt( MThd_MAGIC )
	' Write the header Length
	Hdos.writeInt( HeaderLength - 8 )
	' Write the filetype
	If(TType = MIDI_TYPE_0) Then
		Hdos.writeShort( 0 )
	Else 
	' MIDI_TYPE_1
		Hdos.writeShort( 1 )
	End If
	' Write the number of Tracks
	Hdos.writeShort(TrackCount )
	
	' Determine AND Write the timing format
	Divtype = Seq.DivisionType
	If Divtype = MidiSequence_Static.DIVTYPE_PPQ  Then
		TimeFormat = Seq.getResolution
	Else 
		If Divtype = MidiSequence_Static.DIVTYPE_SMPTE_24 Then
			TimeFormat = Bit.ShiftLeft(24,8) * -1
			TimeFormat = TimeFormat + Bit.And(Seq.getResolution, 0xFF)
		Else
			If Divtype = MidiSequence_Static.DIVTYPE_SMPTE_25 Then
				TimeFormat = Bit.ShiftLeft(25,8) * -1
				TimeFormat = TimeFormat + Bit.And(Seq.getResolution, 0xFF)
			Else 
				If Divtype = MidiSequence_Static.DIVTYPE_SMPTE_30DROP Then
					TimeFormat = Bit.ShiftLeft(29,8) * -1
					TimeFormat = TimeFormat + Bit.And(Seq.getResolution, 0xFF)
				Else 
					If( Divtype = MidiSequence_Static.DIVTYPE_SMPTE_30) Then
						TimeFormat = Bit.ShiftLeft(30,8) * -1
						TimeFormat = TimeFormat + Bit.And(Seq.getResolution, 0xFF)
					Else
						' $$jb: 04.08.99: What To really Do here?
						Return Null
					End If
				End If
			End If
		End If
	End If
	Hdos.writeShort(TimeFormat)
	' now construct an InputStream To become the FileStream
	Dim SIS As SLSequenceInputStream
	'SIS.Initialize(HeaderStream,TrackStream)
	SIS.Initialize(HeaderStream.GetObject,TrackStream)
	'FStream = SIS
	FStream = SIS.GetObject
	Hdos.Close
	'Length = BytesBuilt + HeaderLength
	Return FStream
	
End Sub
Private Sub GetSType(ByteValue As Int) As Int

	If Bit.And(ByteValue,0XF0) = 0XF0 Then
		
		Select ByteValue
		
			Case 0xF0, 0XF7
				Return SYSEX
				
			Case 0XFF
				Return META

		End Select
		
		Return IGNORE

	End If
	
	Select Bit.And(ByteValue,0XF0)
	
		Case 0X80, 0X90 ,0XA0 , 0XB0, 0XE0
			Return TWO_BYTE
			
		Case 0XC0, 0XD0
			Return ONE_BYTE
	End Select
		
	Return ERROR
	
	
End Sub
Private Sub WriteVarInt(Value As Long) As Int
	Dim Len As Int = 1
	Dim Shift As Int = 63
	'First screen out the leading zeros
	Do While Shift > 0  And Bit.And(Value,Bit.ShiftLeft(MASK,Shift)) = 0
		Shift = Shift - 7
	Loop

	Do While Shift > 0
		TdDos.WriteByte( Bit.Or( Bit.ShiftRight( Bit.And(Value, Bit.ShiftLeft(MASK,Shift)),Shift),0x80))
		Shift = Shift - 7
		Len = Len + 1
	Loop
	
	TdDos.WriteByte(Bit.And(Value,MASK))
	
	Return Len
End Sub
Private Sub WriteTrack(TTrack As MidiTrack,TType As Int) As InputStream													'ignore


	Dim BytesWritten As Int
	Dim Size As Int = TTrack.Size
	Dim ThPos As SLPipedOutputStream
	ThPos.Initialize
	ThPos.Create
	Dim THDos As SLDataOutputStream
	'THDos.Initialize(ThPos)
	THDos.Initialize(ThPos.GetObject)
	Dim THPis As SLPipedInputStream
'	THPis.Initialize
	'THPis.Initialize1(ThPos)
	THPis.Initialize
	THPis.Create2(ThPos.GetObject)
	
	Dim TdBos As SLByteArrayOutputStream
	TdBos.Initialize
	TdBos.Create
	Dim TdDos As SLDataOutputStream
	'TdDos.Initialize(TdBos)
	TdDos.Initialize(TdBos.GetObject)
	Dim TdBis As SLByteArrayInputStream

	
	Dim CurrentTick As Long
	Dim DeltaTick As Long
	Dim EventTick As Long
	Dim RunningStatus As Int = -1
	
	'Write Each Event in the track
	Dim i As Int
	For i = 0 To Size - 1
		Dim Event As MidiEvent = TTrack.Get(i)
		
		'LogColor(Event.ToString,Colors.Blue)
		
		Dim Status As Int
		Dim EventType As Int
		'Dim MetaType As Int
		Dim Data1,Data2 As Int
		'Dim Length As Int
		Dim Data() As Byte
		Dim Message As MidiMessage
		
		EventTick = Event.Tick
		DeltaTick = EventTick - CurrentTick
		CurrentTick = EventTick
		
		'Get the Status byte
		
		Status = Event.Message.Status
		EventType = GetSType(Status)
		Message = Event.Message
		
		
		
		If EventType = ONE_BYTE Then
				
				Data1 = Message.ShortMessageData1
				BytesWritten = BytesWritten + WriteVarInt(DeltaTick)
				
				If Status <> RunningStatus Then
					RunningStatus = Status
					TdDos.WriteByte(Status)
					BytesWritten = BytesWritten + 1
				End If
				
				TdDos.WriteByte(Data1)
				BytesWritten = BytesWritten + 1
				
		Else
			If EventType = TWO_BYTE Then
				
				Data1 = Message.ShortMessageData1
				Data2 = Message.ShortMessageData2
'				Log("MFW DT " & DeltaTick)
				BytesWritten = BytesWritten + WriteVarInt(DeltaTick)
				
				If Status <> RunningStatus Then
					RunningStatus = Status
					TdDos.WriteByte(Status)
					BytesWritten = BytesWritten + 1
				End If
				
				TdDos.WriteByte(Data1)
				BytesWritten = BytesWritten + 1
				TdDos.WriteByte(Data2)
				BytesWritten = BytesWritten + 1
				
			Else
				If EventType = SYSEX Then
					Data = Message.SysexData
					
					BytesWritten = BytesWritten + WriteVarInt(DeltaTick)
					
					'Always write Status for Sysex
					RunningStatus = Status
					TdDos.WriteByte(Message.Status)
					BytesWritten = BytesWritten + 1
					
					'Write the data length
					BytesWritten = BytesWritten + WriteVarInt((Data.Length))
					
					
					'Now write the rest of the message
					TdDos.Write2(Data,0,Data.Length)
					BytesWritten = BytesWritten + Data.Length
				
				Else
					If EventType = META Then
						
						Data = Message.getMessage
'						Log("MFW Tick " & DeltaTick)
'						Dim BEf As Int = BytesWritten
						BytesWritten = BytesWritten + WriteVarInt(DeltaTick)
'						Log("MFW BW " & (BytesWritten - BEf))
						RunningStatus = Status
						TdDos.Write2(Data,0,Data.Length)
						BytesWritten = BytesWritten + Data.Length
				
						
					Else
						MidiLibUtils.ThrowException("MidiFileWriter : internal file writer error")
					End If
				End If
			End If
		End If
		
	Next
	
	'Build the track header
	THDos.WriteInt(MTrk_MAGIC)
	THDos.WriteInt(BytesWritten)
	BytesWritten = BytesWritten + 8
	
	'Sequence Them
	'TdBis.Initialize(TdBos.ToByteArray)
	TdBis.Initialize
	TdBis.Create(TdBos.ToByteArray)
	Dim FStream As SLSequenceInputStream
	'FStream.Initialize(THPis,TdBis)
	FStream.Initialize(THPis.GetObject,TdBis.GetObject)
	THDos.Close
	TdDos.Close
	
	'Return FStream
	Return FStream.GetObject

End Sub
