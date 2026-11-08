B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private fServer As ServerSocket
	Private fAsyncStream As AsyncStreams
	Private fisConnected As Boolean=False
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	fServer.Initialize(51040,"server")
	Do While True
		fServer.Listen
		wait for server_newconnection(aSuccessfull As Boolean,	aNEwSocket As Socket)
		If aSuccessfull Then
			If fAsyncStream.IsInitialized Then
				fAsyncStream.Close
			End If
			fAsyncStream.InitializePrefix(aNEwSocket.InputStream,True,aNEwSocket.OutputStream,"stream")
			setState(True)
		End If
	Loop
End Sub

private Sub setState(aIsConnected As Boolean)
	fisConnected=aIsConnected
End Sub

public Sub getState As Boolean
	Return fisConnected
End Sub

Private Sub stream_newData(aBuffer() As Byte)
	Log("stream_newdata")
	Dim ser As B4XSerializator
	Dim m As TMessage
	m=ser.ConvertBytesToObject(aBuffer)
	Select Case m.fCommand
		Case "prefDialog"
			Dim b(1) As Byte=Array As Byte(0)
			CallSub2(Main,"showPrefDialog",m)
			fAsyncStream.Write(b)
	End Select
End Sub

Private Sub stream_Terminated
	setState(False)
End Sub

Private Sub	stream_error
	stream_Terminated
End Sub

public Sub getMyWifiIp As String
	Return fServer.GetMyWifiIP
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
