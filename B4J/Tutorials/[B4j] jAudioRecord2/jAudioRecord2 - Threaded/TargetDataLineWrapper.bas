B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
Sub Class_Globals
	Private TDL As JavaObject
	Private Ready As Boolean
	Private LLCallback As Object
	Private LLEventName As String

End Sub

Public Sub Initialize(InDevice As Object)
	
	Ready = False

	TDL = InDevice
	Ready = TDL.IsInitialized
	Log("Ready " & Ready)
	If Ready Then
		'Open the data line
		TDL.RunMethod("open",Null)
		
		'Testing only Show if target data line has available controls
'		Dim Controls() As Object = TDL.RunMethod("getControls",Null)
'		Log("Control count " & Controls.Length)
'		For Each Control As JavaObject In Controls
'			Log(Control.RunMethod("toString",Null))
'		Next
	End If
End Sub

'Add a Listener to the TargetDataLine so we can get events for Start, Stop etc.
Public Sub AddLineListener(CallBack As Object,EventName As String) As Object
	If Not(Ready) Then Return Null
	LLCallback = CallBack
	LLEventName = EventName
	Dim O As Object = TDL.CreateEvent("javax.sound.sampled.LineListener","LineListener",Null)
	TDL.RunMethod("addLineListener",Array(O))
	Return O
End Sub

Private Sub LineListener_Event (MethodName As String, Args() As Object)
	CallSubDelayed2(LLCallback,LLEventName & "_Event",Args(0).As(JavaObject).RunMethod("toString",Null))
End Sub

Public Sub RemoveLineListener(Listener As Object)
	TDL.RunMethod("removeLineListener",Array(Listener))
End Sub

Public Sub getBufferSize As Int
	If Not(Ready) Then Return 0
	Return TDL.RunMethod("getBufferSize",Null)
End Sub

Public Sub Start
	If Not(Ready) Then Return
	TDL.RunMethod("start",Null)
End Sub

'Count of bytes available to be processed
Public Sub Available As Int
	If Not(Ready) Then Return 0
	Return TDL.RunMethod("available",Null)
End Sub

Public Sub Stop
	If Not(Ready) Then Return
	TDL.RunMethod("stop",Null)
End Sub

Public Sub IsReady As Boolean
	Return Ready
End Sub

Public Sub Close
	If Not(Ready) Then Return
	TDL.RunMethod("close",Null)
End Sub

'Reads data from the TargetDataLine, it requests len bytes which are stored in data
' off = offset into Array data
' Returns the actual number of bytes read
Public Sub Read(Data() As Byte,Offset As Int, Len As Int) As Int
	If Not(Ready) Then Return -1
	Return TDL.RunMethod("read",Array(Data,Offset,Len))
End Sub

'Blocking method that processes and discards all of the available data before returning
Public Sub Drain
	If Not(Ready) Then Return
	TDL.RunMethod("drain",Null)
End Sub

'Flus remaining data in the receive buffer
Public Sub Flush
	If Not(Ready) Then Return
	TDL.RunMethod("flush",Null)
End Sub

Public Sub IsRunning As Boolean
	If Not(Ready) Then Return False
	Return TDL.IsInitialized And TDL.RunMethod("isRunning",Null)
End Sub

Public Sub getTargetDataLine As JavaObject
	Return TDL
End Sub