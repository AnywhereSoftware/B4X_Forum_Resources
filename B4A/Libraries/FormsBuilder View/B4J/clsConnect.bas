B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private fSocket As Socket
	Private fAsyncStrream As AsyncStreams
	Private fIsConnected As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	setState(False)
End Sub

'show if connected to the B4A's device or not
public Sub setState(aIsConnected As Boolean)
	fIsConnected=aIsConnected
End Sub

'show if connected to the B4A's device or not
public Sub getState As Boolean
	Return fIsConnected
End Sub

'connect to the b4a's device
public Sub connect(aip As String)As ResumableSub
	setState(False)
	disconnect
	fSocket.Initialize("socket")
	fSocket.Connect(aip,51040,0)
	wait for socket_connected(aSuccessfull As Boolean)
	If aSuccessfull Then
		setState(True)
		fAsyncStrream.InitializePrefix(fSocket.InputStream,True,fSocket.OutputStream,"stream")
	End If
	Return fIsConnected
End Sub

public Sub disconnect
	If fAsyncStrream.IsInitialized Then
		fAsyncStrream.Close
	End If
	If fSocket.IsInitialized Then
		fSocket.Close
	End If
End Sub

private Sub stream_newData(aBuffer() As Byte)
	CallSub(Main,"prefdialog_terminated")
End Sub

Private Sub stream_Terminated
	setState(False)
End Sub

Private Sub	stream_error
	stream_Terminated
End Sub

'send message (cs) to the b4A device if connected
Sub sendPrefDialog(aJson As String,aWidth As String,aHeight As String)
	If fIsConnected Then
		Dim ser As B4XSerializator
		Dim m As TMessage
		m.Initialize
		m.fCommand="prefDialog"
		m.fJSon=aJson
		m.fWidth=aWidth
		m.fHeight=aHeight
		Dim b() As Byte=ser.ConvertObjectToBytes(m)
		fAsyncStrream.write(b)
	End If
End Sub
