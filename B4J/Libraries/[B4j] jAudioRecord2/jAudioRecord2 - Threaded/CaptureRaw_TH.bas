B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.96
@EndOfDesignText@
Sub Class_Globals
	Private BABuffer As B4XBytesBuilder
	Private StopRecording As Boolean
	Private TDL As TargetDataLineWrapper
	Private DataSize As Int = 0
	Private RecordRunning As Boolean
	Private mAmplitudeCallBack As Object
	Private mAmplitudelEventName As String
	Private ReportAmplitude As Boolean
	Private mCallBack As Object
	Private mEventName As String
	Private TH As Thread			'Ignore
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallBack As Object,EventName As String)
	mCallBack = CallBack
	mEventName = EventName
	TH.Initialise("TH")
	
	'Initialize the bytes builder object
	BABuffer.Initialize
	
	Log("Capture RAW Initialized")
End Sub

Public Sub Start(DataLine1 As TargetDataLineWrapper, FilePath As String)
	If Not(DataLine1.IsInitialized) Then Return
	
	'Reset Flags
	StopRecording = False
	RecordRunning = False
	
	'Clear the byte buffer
	BABuffer.Clear
	
	TDL = DataLine1
	
	'Delete the file if it exists to avoid problems with Random access files
	If File.Exists(FilePath,"") Then
		File.Delete(FilePath,"")
	End If
	
	'Clear any residual data from previous recordings
	TDL.Flush
	TDL.Start
	
	'Start recording
	RecordRunning = True
'	Wait For (Recording) Complete (Size As Int)
	
	TH.Start(Me,"Recording",Null)
	
	Wait For TH_Ended(endedOK As Boolean, error As String) 'The thread has terminated. If endedOK is False error holds the reason for failure
	Log("TH Complete")
	
	'Stop recording

	TDL.Stop
	RecordRunning = False
	
	If endedOK = False Then
		Log("endedOK " & endedOK)
		Log("Error " & error)
	End If
	
	CallSubDelayed(mCallBack,mEventName & "_Complete")
End Sub

'Only really required for the demo project, but may be useful if using both capture methods
Public Sub CaptureType As String
	Return Capture_Static.CAPTURE_RAW
End Sub

'Return the recorded data buffer as a byte array
Public Sub GetBuffer As Byte()
	Return BABuffer.ToArray
End Sub

'Stop recording
Public Sub Stop
	StopRecording = True
End Sub

'Sub that performs the actual recording
Private Sub Recording			'ignore

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
		
		'Append the read bytes to the Buffer
		BABuffer.Append(RecData)
		
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
		
	Loop

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