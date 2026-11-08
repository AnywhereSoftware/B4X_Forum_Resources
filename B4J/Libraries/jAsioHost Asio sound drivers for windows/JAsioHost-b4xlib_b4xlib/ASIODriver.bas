B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: Event(MethodName as String, Args() as Object)
Sub Class_Globals
	Private TJO As JavaObject
	Private mCallBack As Object
	Private mEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Exit_
	
End Sub

Public Sub GetCurrentDriver As ASIODriver
	Dim Wrapper As ASIODriver
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getCurrentDriver",Null))
	Return Wrapper
End Sub

Public Sub GetName As String
	Return TJO.RunMethod("getName",Null)
End Sub

Public Sub GetAsioVersion As Int
	Return TJO.RunMethod("getAsioVersion",Null)
End Sub

Public Sub GetCurrentState As String
	Return TJO.RunMethodJO("getCurrentState",Null).RunMethod("toString",Null)
End Sub

Public Sub GetCurrentStateOrdinal As Int
	Return ASIODriver_Static.StateOrdinal(GetCurrentState)
End Sub

Public Sub GetVersion As Int
	Return TJO.RunMethod("getVersion",Null)
End Sub

Public Sub IsDriverLoaded As Boolean
	Return TJO.RunMethod("isDriverLoaded",Null)
End Sub

Public Sub OpenControlPanel
	TJO.RunMethod("openControlPanel",Null)
End Sub

Public Sub GetNumChannelsInput As Int
	Return TJO.RunMethod("getNumChannelsInput",Null)
End Sub

Public Sub GetNumChannelsOutput As Int
	Return TJO.RunMethod("getNumChannelsOutput",Null)
End Sub


'Inquires of the hardware If a specific available sample rate Is available.
'@param sampleRate  The sample rate in Hz.
'@return  True If the sample rate Is supported. False otherwise.
Public Sub CanSampleRate(SampleRate As Double) As Double
	Return TJO.RunMethod("CanSampleRate",Array(SampleRate))
End Sub
Public Sub GetSampleRate As Double
	Return TJO.RunMethod("getSampleRate",Null)
End Sub

Public Sub SetSampleRate(SampleRate As Double)
	TJO.RunMethod("SetSampleRate",Array(SampleRate))
End Sub

Public Sub GetBufferMinSize As Int
	Return TJO.RunMethod("getBufferMinSize",Null)
End Sub

Public Sub GetBufferMaxSize As Int
	Return TJO.RunMethod("getBufferMaxSize",Null)
End Sub

'Returns the preferred buffer size. The host should attempt To use this buffer size.
Public Sub GetBufferPreferredSize As Int
	Return TJO.RunMethod("getBufferPreferredSize",Null)
End Sub


'Returns the granularity at which buffer sizes may differ. Usually, the buffer size will be 
'a Power of 2; in this Case, granularity will be reported As -1, signaling possible 
'buffer sizes starting from the minimum size, increased in powers of 2 up To maximum size.
Public Sub GetBufferGranularity As Int
	Return TJO.RunMethod("getBufferGranularity",Null)
End Sub

'   * Note: As <code>getLatencyInput()</code> will also have To include the audio buffer size of the 
'   * <code>createBuffers()</code> call, the application should call this function after the buffer creation. 
'   * In the Case that the call occurs beforehand the driver should assume preferred buffer size. 
'   * @return  The input latency in samples.
Public Sub GetLatencyInput As Int
	Return TJO.RunMethod("getLatencyInput",Null)
End Sub

Public Sub GetLatencyOutput As Int
	Return TJO.RunMethod("getLatencyOutput",Null)
End Sub

Public Sub GetChannelInput(Index As Int) As AsioChannel
	Dim Wrapper As AsioChannel
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getChannelInput",Array(Index)))
	Return Wrapper
End Sub


Public Sub GetChannelOutput(Index As Int) As AsioChannel
	Dim Wrapper As AsioChannel
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getChannelOutput",Array(Index)))
	Return Wrapper
End Sub

Public Sub CreateBuffers(ChannelsToInit As List)
	Dim Set As JavaObject
	Set.InitializeNewInstance("java.util.HashSet",Array(UnwrapList(ChannelsToInit)))
	TJO.RunMethod("createBuffers",Array(Set))
End Sub

'Remove the previously created audio buffers (with <code>CreateBuffers()</code>). The active
'channels are reset; all channels become inactive.
Public Sub DisposeBuffers
	TJO.RunMethod("DisposeBuffers",Null)
End Sub

Public Sub ShutdownAndUnloadDriver
	TJO.RunMethod("shutdownAndUnloadDriver",Null)
End Sub

Public Sub Start
	TJO.RunMethod("start",Null)
End Sub

Public Sub Stop
	TJO.RunMethod("stop",Null)
End Sub

'Return the driver To a given state. If the target state Is ahead Or equal To the current state 
'Then this method has no effect.
'@param targetState  The state to which the driver should return.
'TargetState should be one of the STATE constants
Public Sub ReturnToState(TargetState As String)
	TJO.RunMethod("returnToState",Array(TargetState))
End Sub

'Provades a callback for 6 events (MethodNames) with differing arguments:
'<code>sampleRateDidChange</code> 	: SampleRate as Double
'<code>resetRequest</code> 			: None
'<code>resyncRequest</code>			: None
'<code>buffersizeChanged</code>		: BufferSize As int
'<code>latenciesChanged</code>		: InputLatency as Int, OutputLatency As int
'<code>bufferSwitch</code>			: sampleTime As Long, SamplePosition As Long, ActiveChannels As List
'Use a switch statement and retreive the arguments as needed
Public Sub AddAsioDriverListener(Callback As Object, EventName As String) As Object
	If SubExists(Callback,EventName & "_Event") Then
		mCallBack = Callback
		mEventName = EventName
		Dim O As Object = TJO.CreateEvent("com.synthbot.jasiohost.AsioDriverListener","Listener",Null)
		TJO.RunMethod("addAsioDriverListener",Array(O))
		Return O
	End If
	Return Null
End Sub

Private Sub Listener_Event (MethodName As String, Args() As Object)
'	If MethodName = "bufferSwitch" Then
'		Dim L As JavaObject
'		L.InitializeNewInstance("java.util.ArrayList",Array(Args(2)))
'		Args(2) = L
'	End If
	CallSub3(mCallBack,mEventName & "_Event",MethodName,Args)
End Sub

Public Sub RemoveAsioDriverListener(Listener As Object)
	TJO.RunMethod("removeAsioDriverListener",Array(Listener))
End Sub

Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

Public Sub GetObject As Object
	Return TJO
End Sub

Private Sub UnwrapList(L As List) As List
	Dim L1 As List
	L1.Initialize
	For Each T As Object In L
		L1.Add(CallSub(T,"GetObject"))
	Next
	Return L1
End Sub