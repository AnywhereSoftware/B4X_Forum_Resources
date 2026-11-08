B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
Sub Class_Globals
	
	Private SDL As JavaObject
	Private Ready As Boolean
	Private LLCallback As Object
	Private LLEventName As String

End Sub

'Pass Null for DataLineInfo to use the default DataLine
Public Sub Initialize(OutDevice As Object)
	Ready = False
	SDL = OutDevice
	Ready = SDL.IsInitialized
	
	If Ready Then
		SDL.RunMethod("open",Null)
		
		'Testing only Show if target data line has available controls
'		Dim Controls() As Object = SDL.RunMethod("getControls",Null)
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
	Dim O As Object = SDL.CreateEvent("javax.sound.sampled.LineListener","LineListener",Null)
	SDL.RunMethod("addLineListener",Array(O))
	Return O
End Sub

Public Sub RemoveLineListener(Listener As Object)
	SDL.RunMethod("removeLineListener",Array(Listener))
End Sub

Private Sub LineListener_Event (MethodName As String, Args() As Object)
	CallSubDelayed2(LLCallback,LLEventName & "_Event",Args(0).As(JavaObject).RunMethod("toString",Null))
End Sub


Public Sub getBufferSize As Int
	If Not(Ready) Then Return 0
	Return SDL.RunMethod("getBufferSize",Null)
End Sub

Public Sub Start
	If Not(Ready) Then Return
	SDL.RunMethod("start",Null)
End Sub

'Count of bytes available to be processed
Public Sub Available As Int
	If Not(Ready) Then Return 0
	Return SDL.RunMethod("available",Null)
End Sub

Public Sub Stop
	If Not(Ready) Then Return
	SDL.RunMethod("stop",Null)
End Sub

Public Sub IsReady As Boolean
	Return Ready
End Sub

Public Sub Close
	If Not(Ready) Then Return
	SDL.RunMethod("close",Null)
End Sub

Public Sub Write(Data() As Byte,Offset As Int, Len As Int)
	If Not(Ready) Then Return
	SDL.RunMethod("write",Array(Data,Offset,Len))
End Sub

'Blocking method that processes and discards all of the available data before returning
Public Sub Drain
	If Not(Ready) Then Return
	SDL.RunMethod("drain",Null)
End Sub

'Flus remaining data in the receive buffer
Public Sub Flush
	If Not(Ready) Then Return
	SDL.RunMethod("flush",Null)
End Sub

Public Sub IsRunning As Boolean
	If Not(Ready) Then Return False
	Return SDL.IsInitialized And SDL.RunMethod("isRunning",Null)
End Sub

Public Sub getSourceDataLine As JavaObject
	Return SDL
End Sub