B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Type WavHeaderType(StartPos As Long, Length As Long)
	Private mRaf As RandomAccessFile
	Private mDataChunkStart As Long
	Private mDataChunkEnd As Long
	Private mDataChunkLength As Long
	Private mLengthInFrames As Int
	Private mFrameLength As Int
	Private mDuration As Long
	Private mSampleRateInHz As Float
	Private mSampleSizeInBits As Int
	Private mChannelConfig As Int
	Private mFilePath As String
	Private mFileName As String
	Private mWavHeaderChunkMap As Map
	
	'To store the current play pos for the file used by the Mixer
	Private mPlayPos As Long
End Sub

#If Version
	v0.1
		Initial Release
	V0.11
		Made WavHeaderChunkMap available after initialization
		Fix for edge case where fmt is not the first chunk.
#End If

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(FilePath As String,FileName As String) As Boolean
	mFilePath = FilePath
	mFileName = FileName
	
	mRaf.Initialize(FilePath,FileName,True)
	mWavHeaderChunkMap.Initialize
	
	If ReadWavHeaderChunks(mRaf,mWavHeaderChunkMap) = False Then
		Log("Invalid header format")
		Return False
	End If
	
	Dim data As WavHeaderType = mWavHeaderChunkMap.Get("data")
	If data.IsInitialized Then
		mFrameLength = (mChannelConfig * (mSampleSizeInBits / 8))
		mDataChunkStart = data.StartPos
		mDataChunkLength = data.Length
		mDataChunkEnd = mDataChunkStart + data.Length
		mDuration = (mDataChunkLength) / (mSampleRateInHz * mFrameLength)
		mLengthInFrames = (mDataChunkLength) / mFrameLength
	End If
	
	Return True
End Sub

Public Sub getWavHeaderChunkMap As Map
	Return mWavHeaderChunkMap
End Sub

Public Sub getSampleRateInHz As Float
	Return mSampleRateInHz
End Sub

Public Sub getSamplesizeInBits As Int
	Return mSampleSizeInBits
End Sub

Public Sub getChannelConfig As Int
	Return mChannelConfig
End Sub

Public Sub getFilePath As String
	Return mFilePath
End Sub

Public Sub getFileName As String
	Return mFileName
End Sub

'Track Duration in Seconds
Public Sub getDuration As Long
	Return mDuration
End Sub

'Track Duration in milliSeconds
Public Sub getDuration_ms As Long
	Return mDuration * 1000
End Sub

Public Sub getLengthInFrames As Int
	Return mLengthInFrames
End Sub

Public Sub getFrameLength As Int
	Return mFrameLength
End Sub

'Get the underlying RandomAccessFile
Public Sub getRandomAccessFile As RandomAccessFile
	Return mRaf
End Sub

'Start of the 'data' chunk in the file
Public Sub getDataChunkStart As Long
	Return mDataChunkStart
End Sub
'Length of the data chunk
Public Sub getDataChunkLength As Long
	Return mDataChunkLength
End Sub
'End of the 'data' chunk in the file
Public Sub getDataChunkEnd As Long
	Return mDataChunkEnd
End Sub

Public Sub getDataBytes As Byte()
	Dim Buffer(mDataChunkEnd - mDataChunkStart) As Byte
	mRaf.ReadBytes(Buffer,0,Buffer.Length,mDataChunkStart)
	Return Buffer
End Sub

Public Sub getDataShorts As Short()
	Dim BC As ByteConverter
	Dim Bytes() As Byte = getDataBytes
	Return BC.ShortsFromBytes(Bytes)
End Sub

Public Sub getDataDoubles As Double()
	Dim ShortBuffer() As Short = getDataShorts
	Dim DoubleBuffer(ShortBuffer .Length) As Double
	For i = 0 To ShortBuffer.Length - 1
		DoubleBuffer(i) = ShortBuffer(i)
	Next
	Return DoubleBuffer
End Sub

Public Sub getPlayPos As Long
	Return mPlayPos
End Sub
Public Sub setPlayPos(Pos As Long)
	mPlayPos = Pos
End Sub

'Close the RandomAccessFile
Public Sub Close
	mRaf.close
End Sub

'Parse the wav file header and find the start and end positions for each chunk.
'Returns false if a data chunk is not found.
Public Sub ReadWavHeaderChunks(Raf As RandomAccessFile, M As Map) As Boolean
	
	Try
		If M.IsInitialized = False Then M.Initialize
		Dim Bytes(4) As Byte
		Dim Pos As Long = 0
		Dim DataFound As Boolean
		Dim StartPos As Long
		Dim Length As Int
		Dim BC As ByteConverter
		BC.LittleEndian = True
	
		If Raf.ReadBytes(Bytes,0,4,Pos) <= 0 Then Return False
		Dim Name As String = BytesToString(Bytes,0,4,"UTF-8")
		If Name.ToLowerCase <> "riff" Then Return False
		Pos = Pos + 4
		StartPos = Pos
		Length = Raf.ReadInt(Pos)
		M.Put(Name,CreateWavHeaderType(StartPos,Length))
	
	
		'First subchunk will always be at byte 12.
		Pos = 12
		Do While True
			If Raf.ReadBytes(Bytes,0,4,Pos) <= 0 Then Exit
			Dim Name As String = BytesToString(Bytes,0,4,"UTF8")
			If Name.ToLowerCase = "data" Then DataFound = True
			If Name.ToLowerCase = "list" Then
				Dim LPos As Long = Pos + 8
				If Raf.ReadBytes(Bytes,0,4,LPos) <= 0 Then Return False
				Dim ListName As String = BytesToString(Bytes,0,4,"UTF-8")
				Name = Name & "-" & ListName
			End If
			Pos = Pos + 4
			If Raf.ReadBytes(Bytes,0,4,Pos) <= 0 Then Exit
			Length = BC.IntsFromBytes(Bytes)(0)
			Pos = Pos + 4
			StartPos = Pos
			If Length = 0 Then Exit
			M.Put(Name,CreateWavHeaderType(StartPos,Length))
			Pos = Pos + Length
		Loop
		
		Dim FmtChunk As WavHeaderType = M.Get("fmt ")
		
		'Get the file format while we are here
		Pos = FmtChunk.StartPos + 2															'22 Number of channels
	
		Dim ConvertBuffer(2) As Byte
		Raf.ReadBytes(ConvertBuffer,0,2,Pos)
		mChannelConfig = BC.ShortsFromBytes(ConvertBuffer)(0)
	
		Pos = Pos + 2															'24 SampleRate
		Dim ConvertBuffer(4) As Byte
		Raf.ReadBytes(ConvertBuffer,0,4,Pos)
		mSampleRateInHz = BC.IntsFromBytes(ConvertBuffer)(0)
	
		Pos = Pos + 10															'34 Bits per sample
		Dim ConvertBuffer(2) As Byte
		Raf.ReadBytes(ConvertBuffer,0,2,Pos)
		mSampleSizeInBits = BC.ShortsFromBytes(ConvertBuffer)(0)
	
		If DataFound Then Return True
		Return False
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

Public Sub ReadListData(Raf As RandomAccessFile, ListName As String,MSource As Map, MResult As Map, Chrset As String) As Boolean
	If ListName.Contains("-") = False Then ListName = "list-" & ListName
	Dim Name, Content As String
	Dim Length As Int
	Dim BC As ByteConverter
	BC.LittleEndian = True
	
	For Each Key As String In MSource.Keys
		If Key.ToLowerCase = ListName.ToLowerCase Then
			Dim data As WavHeaderType = MSource.Get(Key)
			Dim Pos As Long = data.StartPos
			Pos = Pos + 4
			Do While Pos < data.StartPos + data.Length
				Dim Bytes(4) As Byte
				If Raf.ReadBytes(Bytes,0,4,Pos) <= 0 Then Return False
				Name = BytesToString(Bytes,0,4,Chrset)
				Pos = Pos + 4
				If Raf.ReadBytes(Bytes,0,4,Pos) <= 0 Then Return False
				Length = BC.IntsFromBytes(Bytes)(0)
				Pos = Pos  + 4
				Dim Bytes(Length) As Byte
				If Raf.ReadBytes(Bytes,0,Length,Pos) <= 0 Then Return False
				Content = BytesToString(Bytes,0,Length,Chrset)
				Pos = Pos + Length
				MResult.Put(Name,Content)
			Loop
		End If
	Next
	If MResult.Size = 0 Then Return False
	Return True
End Sub

Private Sub CreateWavHeaderType (StartPos As Long, Length As Long) As WavHeaderType
	Dim t1 As WavHeaderType
	t1.Initialize
	t1.StartPos = StartPos
	t1.Length = Length
	Return t1
End Sub


'Get/Set the millisecond play position
Public Sub getMillisecondPosition As Long
	Return mPlayPos / (mSampleRateInHz * mChannelConfig * (mSampleSizeInBits / 8)) * 1000
End Sub

Public Sub setMillisecondPosition(mSeconds As Long)
	Dim NewPos As Long = Floor((mSeconds / 1000) * mSampleRateInHz * mChannelConfig) * (mSampleSizeInBits / 8)
	mPlayPos = NewPos
End Sub
