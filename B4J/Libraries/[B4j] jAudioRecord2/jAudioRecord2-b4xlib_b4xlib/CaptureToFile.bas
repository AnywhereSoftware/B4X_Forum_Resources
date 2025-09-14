B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
Sub Class_Globals
	Private OutFile As RandomAccessFile
	Private StopRecording As Boolean
	Private TDL As TargetDataLineWrapper
	Private DataSize As Int = 0
	Private RecordRunning As Boolean
	Private mAmplitudeCallBack As Object
	Private mAmplitudelEventName As String
	Private ReportAmplitude As Boolean
	Private mCallBack As Object
	Private mEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallBack As Object,EventName As String)
	mCallBack = CallBack
	mEventName = EventName

	Log("Capture File Initialized")	
End Sub

Public Sub Start(DataLine1 As TargetDataLineWrapper, FilePath As String)
	If Not(DataLine1.IsInitialized) Then Return
	
	'Reset Flags
	StopRecording = False
	RecordRunning = False
	
	TDL = DataLine1
	
	'Delete the file if it exists to avoid problems with Random access files
	If File.Exists(File.GetFileParent(FilePath),File.GetName(FilePath)) Then
		Log("Delete " & File.Delete(File.GetFileParent(FilePath),File.GetName(FilePath)))
	End If
	
	'Initialize the output file
	OutFile.Initialize2(FilePath,"",False,True)
	
	'Write the Wave file header
	WriteWavHeader

	TDL.Flush
	TDL.Start
	
	'Start recording
	RecordRunning = True
	Wait For (Recording) Complete (Resp As Boolean)
	
	'Stop recording
	TDL.Stop
	RecordRunning = False

	'Finish writing the WAVE Header
	UpdateHeader
	
	CallSubDelayed(mCallBack,mEventName & "_Complete")
End Sub

'Only really required for the demo project, but may be useful if using both capture methods
Public Sub CaptureType As String
	Return Capture_Static.CAPTURE_FILE
End Sub

'Stop recording
Public Sub Stop
	 StopRecording = True
End Sub

'Returns an empty array as the RecordFile capture method does not maintain a buffer.
'But is required for the demo implementation to avoid a method not found error.
Public Sub GetBuffer As Byte()
	Return Array As Byte()
End Sub

'Sub that performs the actual recording
Private Sub Recording As ResumableSub		'Ignore

	'ReSet the data size
	DataSize = 0
	Dim BytesRead As Int = 0
	Dim RecDataSize As Int = TDL.BufferSize / 5
	
	Log("Recording...")
	'Do the recording
	Do While True
		'Array in which the captured data is returned
		Dim RecData(RecDataSize) As Byte
		
		'Read at most RecDataSize bytes into RecData byte array
		BytesRead = TDL.Read(RecData,0,RecData.Length)
		
		'Write the read bytes to the file
		OutFile.WriteBytes(RecData,0,BytesRead,44 + DataSize)
		
		'Update the toao byte count
		DataSize = DataSize + BytesRead
		
		'Example only code ----------------------------
		If ReportAmplitude Then
			Dim Sum As Int
			For i = 0 To 480 Step 2			'Approx 5ms worth of data (depending on the sample rate)
				Sum=Sum+(RecData(i)*256)+RecData(i+1)
			Next
			CallSubDelayed2(Me,"ShowAmplitude",Sum)
		End If
		'---------------------------
		
		'Exit if the stoprecording flag is set
		If StopRecording Then
			Exit
		End If
		
		'Sleep to avoid locking the gui
		Sleep(0)
	Loop

	Return True
End Sub

'Is this method currently recording
Public Sub IsRecording As Boolean
	Return RecordRunning
End Sub

'This is an example only and has no specific units
Private Sub ShowAmplitude(Sum As Int)		'ignore
	Sum=Sum/240+(32767/2)
	CallSubDelayed2(mAmplitudeCallBack, mAmplitudelEventName & "_Amplitude",Sum)
End Sub

'Add a listener for the amplitude calculation to be returned to the calling class or module
Public Sub AddAmplitudeListener(CallBack As Object, EventName As String)
	mAmplitudeCallBack = CallBack
	mAmplitudelEventName = EventName
	
	If SubExists(mAmplitudeCallBack,mAmplitudelEventName & "_Amplitude") Then ReportAmplitude = True
End Sub

'Create Wav file header with dummy length values
Private Sub WriteWavHeader
	
	Dim AudioFormat As JavaObject = TDL.TargetDataLine.RunMethod("getFormat",Null)
	
	
	Dim ChannelConfig As Int  = AudioFormat.RunMethod("getChannels",Null)
	Dim SampleRateInHz As Float = AudioFormat.RunMethod("getSampleRate",Null)
	Dim SampleSizeInBits As Int = AudioFormat.RunMethod("getSampleSizeInBits",Null)

	Dim Pos,IntLen,ShLen As Int
	Pos=0
	IntLen=4
	ShLen=2
	Dim Msg As String = "RIFF"
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos)					'Pos = 0
	Pos=Pos+IntLen
	OutFile.WriteInt(0,Pos)														'Pos = 4 - Final size not yet known
	Pos=Pos+IntLen
	Msg = "WAVE"
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos)    				'Pos = 8
	Pos=Pos+IntLen
	Msg = "fmt "
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos)					'Pos = 12
	Pos=Pos+IntLen
	OutFile.WriteInt(16,Pos)													'Pos = 16 Sub chunk size 16 for PCM
	Pos=Pos+IntLen
	OutFile.WriteShort(1,Pos)													'Pos = 20 Audio Format, 1 for PCM
	Pos=Pos+ShLen
	OutFile.WriteShort(ChannelConfig,Pos)										'Pos = 22 No of Channels
	Pos=Pos+ShLen
	OutFile.WriteInt(SampleRateInHz,Pos)										'Pos = 24
	Pos=Pos+IntLen
	OutFile.WriteInt(SampleRateInHz * SampleSizeInBits * ChannelConfig / 8,Pos)	'pos = 28 Byte Rate
	Pos=Pos+IntLen
	OutFile.WriteShort(ChannelConfig * SampleSizeInBits / 8,Pos)				'Pos = 32 Block align, NumberOfChannels*BitsPerSample/8
	Pos=Pos+ShLen
	OutFile.WriteShort(SampleSizeInBits,Pos)									'Pos = 34 BitsPerSample
	Pos=Pos+ShLen
	Msg = "data"
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos) 					'Pos = 36
	Pos=Pos+IntLen
	OutFile.WriteInt(0,Pos)														'Pos = 40 Data chunk size (Not yet known)
	
End Sub

'replace the dummy length values once recording is completed.
Private Sub UpdateHeader
	Log("UpdateHeader DataSize " & DataSize)
	OutFile.WriteInt(36 + DataSize, 4)											'Pos = 4	Overwrite Final size
	OutFile.WriteInt(DataSize, 40)												'Pos = 40	Overwrite Data chumk size
	OutFile.Flush
	OutFile.Close
End Sub