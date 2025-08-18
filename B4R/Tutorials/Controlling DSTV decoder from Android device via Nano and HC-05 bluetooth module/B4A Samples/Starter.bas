B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Private serial As Serial
	Private admin As BluetoothAdmin
	Private ast As AsyncStreamsText
	Public connected As Boolean
	Public connecting As Boolean
End Sub

Sub Service_Create
	serial.Initialize("serial")
	admin.Initialize("admin")
End Sub

Public Sub Connect
	admin.StartDiscovery
	connecting = True
	CallSub(Main, "SetState")
End Sub

Private Sub admin_DeviceFound (Name As String, MacAddress As String)
	Log($"Device found: ${Name}"$)
	If Name = "HC-05" Then
		Log("Trying to connect...")
		admin.CancelDiscovery
		serial.Connect(MacAddress)
	End If
End Sub

Private Sub admin_DiscoveryFinished
	connecting = False
End Sub

Private Sub Serial_Connected (Success As Boolean)
	If Success Then
		If ast.IsInitialized Then ast.Close
		ast.Initialize(Me, "Ast", serial.InputStream, serial.OutputStream)
		Log("Connected")
		connected = True
		
	Else
		Log(LastException)
	End If
	connecting = False
	CallSub(Main, "SetState")
End Sub

Public Sub SendMessage(msg() As Byte)
	ast.astreams.Write(msg) 'sending bytes, not text
End Sub

Private Sub ast_NewText (Text As String)
	CallSub2(Main, "MessageFromDevice", Text)
End Sub

Private Sub ast_Terminated
	connected = False
	CallSub(Main, "SetState")
End Sub

Sub ast_Close
	ast.Close
	connected = False
	CallSub(Main, "SetState")
End Sub


Sub Service_Start (StartingIntent As Intent)

End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
