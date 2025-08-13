B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module

#ExcludeFromDebugger: True
#IgnoreWarnings: 9,12

'@SLHideClass
Sub Class_Globals
	Private mStream As SLDataInputStream
	Private mTracks As Int
	Private Const Mtrk_MAGIC =  As Int 0x4d54726b	'Mtrk
	
	'Set to true to not allow corrupt MIDI files to be loaded
	Private STRICT_PARSER As Boolean = False
	Private DEBUG As Boolean = False
	Private TrackLength As Int = 0		'Remaining length in track
	Private TrackData() As Byte
	Private Pos As Int

End Sub

'Initializes the object.
'@SLHide
Sub Initialize(Strict As Boolean)
	STRICT_PARSER = Strict

End Sub

'@SLHide
Sub setStream(Stream As SLDataInputStream)
	mStream = Stream
End Sub

'@SLHide
Sub setTracks(Count As Int)
	mTracks = Count
End Sub

'@SLHide
Sub getTracks As Int
	Return mTracks
End Sub

Private Sub ReadUnsigned As Int
	Dim RV As Int = Bit.AND(TrackData(Pos), 0xFF)
	Pos = Pos + 1
	Return RV
End Sub

Private Sub Read(Data() As Byte)
	MidiLibUtils.Arraycopy(TrackData,Pos,Data,0,Data.Length)
	Pos = Pos + Data.Length
End Sub

Private Sub ReadVarInt As Long
	Dim Value As Long
	Dim CurrentByte As Int
	
	CurrentByte = Bit.AND(TrackData(Pos),0xFF)
	Pos = Pos + 1
	Value = Bit.AND(CurrentByte,0x7F)
	Do Until Bit.AND(CurrentByte,0x80) <> 0X80
		CurrentByte = Bit.AND(TrackData(Pos),0xFF)
		Pos = Pos + 1
		Value = Bit.ShiftLeft(Value,7) + Bit.AND(CurrentByte,0x7F)
	Loop
	Return Value
End Sub

Private Sub ReadIntFromStream As Int
	Return mStream.ReadInt
End Sub

'@SLHide
Sub NextTrack As Boolean
	Dim Magic As Int
	TrackLength = 0
	Do Until Magic = Mtrk_MAGIC	
		' $$fb 3-08-20: fix For 6: MIDI File parser breaks up on http connection
	   If (mStream.skipBytes(TrackLength) <> TrackLength) Then
	       If Not(STRICT_PARSER) Then
		   		Log("SMFParser#1 : invalid MIDI file")
	           Return False
	       Else
		        MidiLibUtils.ThrowException("SMFParser#1 : invalid MIDI file")
		   End If
	   End If
	   Magic = ReadIntFromStream
	   TrackLength = ReadIntFromStream
	Loop
	
	If Not(STRICT_PARSER) Then
	   If (TrackLength < 0) Then
	       Return False
	   End If
	End If
	' now Read Track In a Byte Array
	Dim TrackData(TrackLength) As Byte
	Try 
	   ' $$fb 3-08-20: fix For 6: MIDI File parser breaks up on http connection
	   mStream.readFully(TrackData)
	Catch 
	   If Not(STRICT_PARSER) Then
	   		Log("SMFParser#2 : invalid Track Length in MidiFile")
	       Return False
	   End If
	   MidiLibUtils.ThrowException("SMFParser#2 : invalid Track Length in MidiFile")
	End Try
	Pos = 0
	Return True
	
End Sub

Private Sub TrackFinished As Boolean
	Return Pos >= TrackLength
End Sub

'@SLHide
Sub ReadTrack(Track1 As MidiTrack)
	'Try 
		' reset current Tick To 0
		Dim Tick As Long

		' reset current status Byte To 0 (invalid value).
		' this should cause us To throw an InvalidMidiDataException If we don't
		' get a valid status Byte from the beginning of the Track.
		Dim Status As Int
		Dim EndOfTrackFound As Boolean
		Do While Not(TrackFinished) AND Not(EndOfTrackFound)
			Dim Message As MidiMessage
			Message.Initialize
		 	
			Dim Data1 As Int = -1         ' Initialize To invalid value
		 	Dim Data2 As Int

			' Each event has a Tick delay AND Then the event data.

			' first Read the delay (a variable-length Int) AND update our Tick value
			Tick = Tick + ReadVarInt

			' check For new status
			Dim ByteValue As Int = ReadUnsigned

			If (ByteValue >= 0x80) Then
				Status = ByteValue
			Else
				Data1 = ByteValue
			End If
			
			Dim S As Int = Bit.AND(Status,0xF0)
			
			If S = 0x80 OR S = 0x90 OR S = 0xA0 OR S = 0xB0 OR S = 0xE0 Then
				' two data bytes
				If Data1 = -1 Then
					Data1 = ReadUnsigned
				End If
				Data2 = ReadUnsigned
				Message.FASTShortMessage(Array As Byte(Status,Data1,Data2))

			Else
				If S = 0xC0 OR S = 0xD0 Then
					' one data Byte
					If Data1 = -1 Then Data1 = ReadUnsigned
					Message.FASTShortMessage(Array As Byte(Status,Data1))

				Else
					'If S = 0xF0 Then
						' sys-ex OR meta
						
							If Status = 0xF0 OR Status = 0xF7 Then
								' sys ex
								Dim SysexLength As Int = ReadVarInt
								Dim SysexData(SysexLength) As Byte
								Read(SysexData)
								Message.SetSysexMessage2(Status,SysexData,SysexData.length)

							Else
								If Status = 0xFF Then
									' meta
									Dim MetaType As Int = ReadUnsigned
									
									Try
										Dim MetaLength As Int = ReadVarInt
										Dim MetaData(MetaLength) As Byte
										Read(MetaData)
									Catch
										Track1.ReadError = "Meta ReadVarInt: " & LastException.Message & " Byte " & Pos & " MetaType " & MetaType & " TrkLen " & TrackLength
										If Not(STRICT_PARSER) Then
											Exit
										Else
											MidiLibUtils.ThrowException("Cannot Read File : Load another" & CRLF  & Track1.ReadError)
										End If
									End Try
									
									Message.setMetaMessage(MetaType,MetaData,MetaData.Length)
'									Dim Data As SLByteArrayBuffer
'									Data.Initialize(100)
'									Data.AppendInt(Status)
'									Data.AppendInt(MetaType)
'									Data.AppendInt(MetaLength)
'									Data.AppendByte(MetaData,0,MetaData.Length)
'									Message.FASTSetMetaMessage(Data.ToByteArray)
									' End of Track means it!
									If MetaType == 0x2F Then EndOfTrackFound = True
								Else
									MidiLibUtils.ThrowException("SMFParser#3 : Invalid status byte: " & Status)
								End If
						End If
					'End If
				End If
			End If
			Dim Event As MidiEvent
			Event.Initialize(Message, Tick)
		 	Track1.add(Event)
			'Log(Event.ToString)
		Loop ' While
		
'	Catch 
'		MidiLibUtils.ThrowException("SMFParser#5 : invalid MIDI file")
'	End Try
End Sub
