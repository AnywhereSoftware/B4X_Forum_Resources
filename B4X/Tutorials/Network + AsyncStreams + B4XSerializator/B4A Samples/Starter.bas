Type=Service
Version=6.8
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public connected As Boolean
	Private client As Socket
	Public server As ServerSocket
	Private astream As AsyncStreams
	Private const PORT As Int = 51042
	Private working As Boolean = True
End Sub

Sub Service_Create
	server.Initialize(PORT, "server")
	ListenForConnections
End Sub

Private Sub ListenForConnections
	Do While working
		server.Listen
		Wait For Server_NewConnection (Successful As Boolean, NewSocket As Socket)
		If Successful Then
			CloseExistingConnection
			client = NewSocket
			astream.InitializePrefix(client.InputStream, False, client.OutputStream, "astream")
			UpdateState(True)
		End If
	Loop
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Public Sub ConnectToServer(Host As String)
	Log("Trying to connect to: " & Host)
	CloseExistingConnection
	Dim client As Socket
	client.Initialize("client")
	client.Connect(Host, PORT, 10000)
	Wait For Client_Connected (Successful As Boolean)
	If Successful Then
		astream.InitializePrefix(client.InputStream, False, client.OutputStream, "astream")
		UpdateState (True)
	Else
		Log("Failed to connect: " & LastException)
	End If
End Sub

Public Sub Disconnect
	CloseExistingConnection
End Sub

Sub CloseExistingConnection
	If astream.IsInitialized Then astream.Close
	If client.IsInitialized Then client.Close
	UpdateState (False)
End Sub

Sub UpdateState (NewState As Boolean)
	connected = NewState
	CallSub(Main, "SetState")
End Sub

Sub AStream_Error
	UpdateState(False)
End Sub

Sub AStream_Terminated
	UpdateState(False)
End Sub

Sub AStream_NewData (Buffer() As Byte)
	CallSub2(Main, "NewData", Buffer)
End Sub

Public Sub SendData (data() As Byte)
	If connected Then astream.Write(data)
End Sub


'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
