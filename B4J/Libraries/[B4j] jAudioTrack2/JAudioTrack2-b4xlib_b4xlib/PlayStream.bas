B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
#Event: PosEvent(Pos As Long)
Sub Class_Globals
'	Private fx As JFX
	Dim SDLW As SourceDataLineWrapper
'	Private RAF As RandomAccessFile
	Private mAIS As JavaObject
	Private StopPlaying As Boolean
	Private mPause As Boolean
	Private PausePos As Long = 0
	
	Private MaxBufferSize As Int = 2048
	Private BufferSize As Int
	
	Private ReportPos As Boolean
	Private PosCallback As Object
	Private PosEventName As String
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

Public Sub AddPositionListener(Callback As Object,EventName As String)
	PosCallback = Callback
	PosEventName = EventName
	If SubExists(PosCallback,PosEventName & "_PosEvent") Then ReportPos = True
End Sub

Public Sub Start(SDL As SourceDataLineWrapper, AIS As JavaObject)
	SDLW = SDL
	mAIS = AIS
	StartDo
	
End Sub

Private Sub StartDo
	StopPlaying = False
	mPause = False
	
	Wait For(PlayDo(PausePos)) Complete (Pos As Long)
	
	If mPause Then
		PausePos = Max(0,Pos - BufferSize)
	Else
		PausePos = 0
		'Tidy up
		SDLW.Drain
		SDLW.Stop
		mAIS.RunMethod("close",Null)
	End If
	
	Log("Play finished")
End Sub

Public Sub IsRunning As Boolean
	Return SDLW.IsInitialized And SDLW.IsRunning
End Sub

Public Sub Stop
	mPause = False
	PausePos = 0
	StopPlaying = True
End Sub

Public Sub Pause
	mPause = True
	StopPlaying = True
End Sub

Public Sub Resume
	StartDo
End Sub

Public Sub IsPaused As Boolean
	Return mPause
End Sub

Private Sub PlayDo(Pos As Long) As ResumableSub			'Ignore
	Log("Playing")
	BufferSize = Min(MaxBufferSize,SDLW.getBufferSize)
	
'	mAIS.RunMethod("skip",Array(Pos))
	'File has a wav header we need to ignore
	SDLW.Start
	
	Dim Dat(BufferSize) As Byte
	
	Do While -1 <> mAIS.RunMethod("read",Array(Dat,0,BufferSize))
		SDLW.Write(Dat,0,Dat.Length)
		Pos = Pos + Dat.Length
		If ReportPos Then CallSubDelayed2(PosCallback,PosEventName & "_PosEvent",Pos)
		Sleep(0)
		If StopPlaying Then Exit
	Loop

	Return Pos
End Sub

