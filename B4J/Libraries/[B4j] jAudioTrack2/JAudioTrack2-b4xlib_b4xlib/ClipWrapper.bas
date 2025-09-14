B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Event(Name As String)
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private TJO As JavaObject
	
	Dim LLCallback As Object
	Dim LLEventName As String
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub
'Class is a subclass with no constructor, we need to set the object on which JavaObject will operate.
Public Sub SetObject(Target As Object)
	TJO = Target
End Sub

'
' Clip Methods
'

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Obtains the media length in sample frames.
Public Sub GetFrameLength As Int
	Return TJO.RunMethod("getFrameLength",Null)
End Sub
'Obtains the media duration in microseconds
Public Sub GetMicrosecondLength As Long
	Return TJO.RunMethod("getMicrosecondLength",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Starts looping playback from the current position.
Public Sub Loop_(Count As Int)
	TJO.RunMethod("loop",Array As Object(Count))
End Sub
'Opens the clip, meaning that it should acquire any required system resources and become operational.
Public Sub Open(AudioFormat As JavaObject, Data() As Byte, Offset As Int, BufferSize As Int)
	TJO.RunMethod("open",Array As Object(AudioFormat, Data, Offset, BufferSize))
End Sub
'Opens the clip with the format and audio data present in the provided audio input stream.
Public Sub Open2(AudioInputStream As JavaObject)
	TJO.RunMethod("open",Array As Object(AudioInputStream))
End Sub
'Sets the media position in sample frames.
Public Sub SetFramePosition(Frames As Int)
	TJO.RunMethod("setFramePosition",Array As Object(Frames))
End Sub
'Sets the first and last sample frames that will be played in the loop.
Public Sub SetLoopPoints(StartPoint As Int, EndPoint As Int)
	TJO.RunMethod("setLoopPoints",Array As Object(StartPoint, EndPoint))
End Sub
'Sets the media position in microseconds.
Public Sub SetMicrosecondPosition(Microseconds As Long)
	TJO.RunMethod("setMicrosecondPosition",Array As Object(Microseconds))
End Sub


'
'DataLine Methods
'

'Obtains the number of bytes of data currently available to the application for processing in the data line's internal buffer.
Public Sub Available As Int
	Return TJO.RunMethod("available",Null)
End Sub
'Drains queued data from the line by continuing data I/O until the data line's internal buffer has been emptied.
Public Sub Drain
	TJO.RunMethod("drain",Null)
End Sub
'Flushes queued data from the line.
Public Sub Flush
	TJO.RunMethod("flush",Null)
End Sub
'Obtains the maximum number of bytes of data that will fit in the data line's internal buffer.
Public Sub GetBufferSize As Int
	Return TJO.RunMethod("getBufferSize",Null)
End Sub
'Obtains the current format (encoding, sample rate, number of channels, etc.) of the data line's audio data.
Public Sub GetFormat As JavaObject
	Return TJO.RunMethod("getFormat",Null)
End Sub
'Obtains the current position in the audio data, in sample frames.
Public Sub GetFramePosition As Int
	Return TJO.RunMethod("getFramePosition",Null)
End Sub
'Obtains the current volume level for the line.
Public Sub GetLevel As Float
	Return TJO.RunMethod("getLevel",Null)
End Sub
'Obtains the current position in the audio data, in sample frames.
Public Sub GetLongFramePosition As Long
	Return TJO.RunMethod("getLongFramePosition",Null)
End Sub
'Obtains the current position in the audio data, in microseconds.
Public Sub GetMicrosecondPosition As Long
	Return TJO.RunMethod("getMicrosecondPosition",Null)
End Sub
'Indicates whether the line is engaging in active I/O (such as playback or capture).
Public Sub IsActive As Boolean
	Return TJO.RunMethod("isActive",Null)
End Sub
'Indicates whether the line is running.
Public Sub IsRunning As Boolean
	Return TJO.RunMethod("isRunning",Null)
End Sub
'Allows a line to engage in data I/O.
Public Sub Start
	TJO.RunMethod("start",Null)
End Sub
'Stops the line.
Public Sub Stop
	TJO.RunMethod("stop",Null)
End Sub


'
'Line Methods
'


'Adds a listener to this line.
'Replace "FullClassName" with the full name of the listener class in B4a, or the EventHandler in B4j
Public Sub AddLineListener(Callback As Object, EventName As String) As Object
	LLCallback = Callback
	LLEventName = EventName
	
	Dim EventObject As Object = TJO.CreateEventFromUI("javax.sound.sampled.LineListener", "Listener0" ,Null)
	TJO.RunMethod("addLineListener",Array As Object(EventObject))
	Return EventObject
End Sub

Private Sub Listener0_Event(MethodName As String,Args() As Object)
	Dim JO As JavaObject = Args(0)
	Dim Name As String = JO.RunMethod("toString",Null)
	If SubExists(LLCallback, LLEventName & "_Event") Then CallSub2(LLCallback, LLEventName & "_Event",Name)
End Sub

Public Sub RemoveLineListener(Listener As Object) As Boolean
	Try
		TJO.RunMethod("removeLineListener",Array(Listener))
		Return True
	Catch
		Log(LastException)
	End Try
	
	Return False
End Sub

'Closes the line, indicating that any system resources in use by the line can be released.
Public Sub Close
	TJO.RunMethod("close",Null)
End Sub
'Obtains a control of the specified type, if there is any.
Public Sub GetControl(Control As JavaObject) As JavaObject
	Return TJO.RunMethod("getControl",Array As Object(Control))
End Sub
'Obtains the set of controls associated with this line.
Public Sub GetControls As Object()
	Return TJO.RunMethod("getControls",Null)
End Sub
'Obtains the Line.Info object describing this line.
Public Sub GetLineInfo As JavaObject
	  Return TJO.RunMethod("getLineInfo",Null)
End Sub
'Indicates whether the line supports a control of the specified type.
Public Sub IsControlSupported(Control As JavaObject) As Boolean
	Return TJO.RunMethod("isControlSupported",Array As Object(Control))
End Sub
'Indicates whether the line is open, meaning that it has reserved system resources and is operational, although it might not currently be playing or capturing sound.
Public Sub IsOpen As Boolean
	Return TJO.RunMethod("isOpen",Null)
End Sub
