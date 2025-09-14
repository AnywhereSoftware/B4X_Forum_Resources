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
	Private mAudioFormat As JavaObject
	Private mSampleRateInHz As Float
	Private mSampleSizeInBits As Int
	Private mChannelConfig As Int
	Private mFilePath As String
	Private mFileName As String
	
	'Play Vars
	Private mSDL As SourceDataLineWrapper
	Private ReportPos As Boolean
	Private PosCallback As Object
	Private PosEventName As String
	Private mPlayPos As Long
	Private mIsPlaying As Boolean
	Private BufferSize As Int
	Private StopPlaying As Boolean
	Private mPause As Boolean
	Private MaxBufferSize As Int = 2048
	Private mWavHeaderChunkMap As Map
	
End Sub

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
	
	Dim jFile As JavaObject
	jFile.InitializeNewInstance("java.io.File",Array(FilePath,FileName))
	
	Dim Audsys As JavaObject
	Audsys.InitializeStatic("javax.sound.sampled.AudioSystem")
	mAudioFormat = Audsys.RunMethodJO("getAudioFileFormat",Array(jFile)).RunMethod("getFormat",Null)
	
	mSampleRateInHz = mAudioFormat.RunMethod("getSampleRate",Null)
	mSampleSizeInBits = mAudioFormat.RunMethod("getSampleSizeInBits",Null)
	mChannelConfig = mAudioFormat.RunMethod("getChannels",Null)
	
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

Public Sub AddPositionListener(Callback As Object,EventName As String)
	PosCallback = Callback
	PosEventName = EventName
	If SubExists(PosCallback,PosEventName & "_PosEvent") Then ReportPos = True
End Sub

Public Sub getAudioFormat As JavaObject
	Return mAudioFormat
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
'end of the 'data' chunk in the file
Public Sub getDataChunkEnd As Long
	Return mDataChunkEnd
End Sub
Public Sub getDataChunkLength As Long
	Return mDataChunkLength
End Sub

Public Sub Read8bitAsShort(Length As Int, Position As Int) As Short()
	Dim Shorts(Length) As Short
	Dim Bytes(Length) As Byte
	mRaf.ReadBytes(Bytes,0,Length,Position)
	For i = 0 To Bytes.Length - 1
		Shorts(i) = Bytes(i)
	Next
	Return Shorts
End Sub

Public Sub Read8bitAsFloats(Length As Int, Position As Int) As Float()
	Dim Floats(Length) As Float
	Dim Bytes(Length) As Byte
	mRaf.ReadBytes(Bytes,0,Length,Position)
	For i = 0 To Bytes.Length - 1
		Floats(i) = Bytes(i)
	Next
	Return Floats
End Sub

Public Sub Read8BitAsNormalizedFloats(Length As Int, Position As Int) As Float()
	Dim Floats(Length) As Float
	Dim Bytes(Length) As Byte
	mRaf.ReadBytes(Bytes,0,Length,Position)
	Dim B As JavaObject
	B.InitializeNewInstance("java.lang.Byte",Array("0"))
	Dim BYTE_MAXVALUE As Byte = B.GetField("MAX_VALUE")
	For i = 0 To Bytes.Length - 1
		Floats(i) = Bytes(i) / BYTE_MAXVALUE
	Next
	Return Floats
End Sub

Public Sub Read8bitAsDoubles(Length As Int, Position As Int) As Double()
	Dim Doubles(Length) As Double
	Dim Bytes(Length) As Byte
	mRaf.ReadBytes(Bytes,0,Length,Position)
	For i = 0 To Bytes.Length - 1
		Doubles(i) = Bytes(i)
	Next
	Return Doubles
End Sub

'Convienience function : Returns An array of Doubles Length / 2 in length.
Public Sub Read16bitAsDoubles(Length As Int, Position As Long) As Double()
	Dim Shorts() As Short = Read16bitAsShort(Length, Position)
	Dim Doubles(Shorts.Length) As Double
	For i = 0 To Shorts.Length - 1
		Doubles(i) = Shorts(i)
	Next
	Return Doubles
End Sub

'Convienience function : Returns An array of Floats Length / 2 in length.
Public Sub Read16bitAsFloats(Length As Int, Position As Long) As Float()
	Dim Shorts() As Short = Read16bitAsShort(Length, Position)
	Dim Floats(Shorts.Length) As Float
	For i = 0 To Shorts.Length - 1
		Floats(i) = Shorts(i)
	Next
	Return Floats
End Sub

'Convienience function : Returns An array of Floats Length / 2 in length with values between - 1 and 1
Public Sub Read16bitAsNormalisedFloats(Length As Int, Position As Long) As Float()
	Dim Shorts() As Short = Read16bitAsShort(Length, Position)
	Dim S As JavaObject
	S.InitializeNewInstance("java.lang.Short",Array("0"))
	Dim SHORT_MAXVALUE As Short = S.GetField("MAX_VALUE")
	Dim Floats(Shorts.Length) As Float
	For i = 0 To Shorts.Length - 1
		Floats(i) = Shorts(i) / SHORT_MAXVALUE
	Next
	Return Floats
End Sub

'Convienience function : Returns An array of Shorts Length / 2 in length.
Public Sub Read16bitAsShort(Length As Int, Position As Long) As Short()
	Dim BC As ByteConverter
	BC.LittleEndian = True
	Dim Bytes(Length) As Byte
	mRaf.ReadBytes(Bytes,0,Length,Position)
	Return BC.ShortsFromBytes(Bytes)
End Sub

Public Sub getDataBytes As Byte()
	Dim Buffer(mDataChunkEnd - mDataChunkStart) As Byte
	mRaf.ReadBytes(Buffer,0,Buffer.Length,mDataChunkStart)
	Return Buffer
End Sub

Public Sub getDataShorts As Short()
	Dim BC As ByteConverter
	BC.LittleEndian = True
	Dim Bytes() As Byte = getDataBytes
	Return BC.ShortsFromBytes(Bytes)
End Sub

Public Sub getDataDoubles As Double()
	Dim ShortBuffer() As Short = getDataShorts
	Dim DoubleBuffer(ShortBuffer.Length) As Double
	For i = 0 To ShortBuffer.Length - 1
		DoubleBuffer(i) = ShortBuffer(i)
	Next
	Return DoubleBuffer
End Sub

'Is playing currently paused
Public Sub IsPaused As Boolean
	Return mPause
End Sub

'Is the SourceDataLine Running
Public Sub IsRunning As Boolean
	Return mSDL.IsInitialized And mSDL.IsRunning
End Sub

'Is the WavRandomAccessFile playing
Public Sub IsPlaying As Boolean
	Return mIsPlaying
End Sub

Public Sub getPlayPos As Long
	Return mPlayPos
End Sub
Public Sub setPlayPos(Pos As Long)
	mPlayPos = Pos
End Sub


'Pause playback
Public Sub Pause
	mPause = True
	StopPlaying = False
End Sub

'Stop playback
Public Sub Stop
	mPause = False
	StopPlaying = True
End Sub

'Resume after pause
Public Sub Resume
	mPause = False
	StopPlaying = False
	StartDo
End Sub


'Close the RandomAccessFile
Public Sub Close
	mRaf.close
End Sub

'Parse the waf file header and find the start and end positions for each chunk.
'Returns false if a data chunk is not found.
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
	
	
		'Get the file format while we are here
		Pos = 22															'Number of channels
	
		Dim ConvertBuffer(2) As Byte
		Raf.ReadBytes(ConvertBuffer,0,2,Pos)
		mChannelConfig = BC.ShortsFromBytes(ConvertBuffer)(0)
	
		Pos = 24															'SampleRate
		Dim ConvertBuffer(4) As Byte
		Raf.ReadBytes(ConvertBuffer,0,4,Pos)
		mSampleRateInHz = BC.IntsFromBytes(ConvertBuffer)(0)
	
		Pos = 34															'Bits per sample
		Dim ConvertBuffer(2) As Byte
		Raf.ReadBytes(ConvertBuffer,0,2,Pos)
		mSampleSizeInBits = BC.ShortsFromBytes(ConvertBuffer)(0)
	
	
		'First subchunk will always be at byte 12.
		Pos = 12
		Do While True
			If Raf.ReadBytes(Bytes,0,4,Pos) <= 0 Then Exit
			Dim Name As String = BytesToString(Bytes,0,4,"UTF-8")
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

'Start playing
Public Sub Start(SDL As SourceDataLineWrapper)
	mSDL = SDL
	StopPlaying = False
	mPause = False
	StartDo
End Sub

'Sub that does the actual work to play the file
Private Sub StartDo 		'Ignore
	Log("Playing")
	mIsPlaying = True
	
	'Required library
	Dim BC As ByteConverter
	BC.LittleEndian = True
	
	'Working buffer size
	BufferSize = Min(MaxBufferSize,mSDL.getBufferSize)
	
	'Start the source data line
	mSDL.Start

	'Working buffer
	Dim Dat(BufferSize) As Byte
	Dim ThisBufferSize As Int
	

	Do While True
		'Maximum length of the last buffer read from each track
				
		'Avoid reading past the end of the Data Chunk in case the Data Chunk is not the last chunk in the file.
		ThisBufferSize = Max(0, Min(BufferSize , mDataChunkEnd - mPlayPos))
			
		mRaf.ReadBytes(Dat,0,ThisBufferSize, mDataChunkStart + mPlayPos)
			
		'Play position for each track
		mPlayPos = mPlayPos + Dat.Length
			
			
		'Report current position if requested
		If ReportPos Then CallSubDelayed2(PosCallback,PosEventName & "_PosEvent",mPlayPos)
		
		'Convert the mixed MixBuffer to bytes and write it to the SourceDataLine
		mSDL.Write(Dat,0,Dat.Length)
		
		'Exit if flag is set
		If StopPlaying Or mPause Then Exit
		
		'Will occur when RandomAccess file is exhausted.
		If Dat.Length = 0 Then Exit

		'Free up the gui
		Sleep(0)
	Loop
	
	Log("Stopped")
	
	If StopPlaying Or Dat.Length = 0 Then
		'Reset play position to beginning
		mPlayPos = 0
		
		'Report current position if requested.
		If ReportPos Then CallSubDelayed2(PosCallback,PosEventName & "_PosEvent",mPlayPos)
	End If
	
	'Stop and clear the Source Data Line
	mSDL.Stop
	mSDL.Drain
	mSDL.flush
	
	'Reset the playing flag
	mIsPlaying = False
End Sub

'Get/Set the millisecond play position
Public Sub getMillisecondPosition As Long
	Return mPlayPos / (mSampleRateInHz * mChannelConfig * (mSampleSizeInBits / 8)) * 1000
End Sub

Public Sub setMillisecondPosition(mSeconds As Long)
	Dim NewPos As Long = Floor((mSeconds / 1000) * mSampleRateInHz * mChannelConfig) * (mSampleSizeInBits / 8)
	mPlayPos = NewPos
End Sub
