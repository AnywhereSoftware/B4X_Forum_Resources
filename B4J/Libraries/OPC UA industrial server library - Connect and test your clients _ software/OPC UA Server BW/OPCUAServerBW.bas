B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private OPC As OPCUAServer
End Sub

Public Sub Initialize
	'Optional: Netty test, not really needed
	Try
		Dim JO As JavaObject
			JO.InitializeStatic("java.lang.Class").RunMethod("forName", Array("io.netty.channel.ChannelInitializer"))
		Log("Netty OK")
	Catch
		Log(LastException)
	End Try

	'No Authentication needed
	OPC.Initialize("OPC", "localhost", 4840, "SimplySoftware OPC UA Server", "urn:simplysoftware:opcuaserver")
	OPC.Start
	
	'Basic Authentication needed
'	OPC.SetCredentials("operator", "op123")
'	OPC.Initialize("OPC", "localhost", 4840, "SimplySoftware OPC UA Server", "urn:simplysoftware:opcuaserver")
'	OPC.Start
	
	StartMessageLoop
End Sub

Private Sub AddNodes
	Log("Adding nodes to Address Space...")

	OPC.AddVariable("MyInt", 771)
	OPC.AddVariable("MyDouble", 123.45)
	OPC.AddVariable("MyString", "B4X")
	OPC.SetVariableAccessLevel("MyString", 1, 1)
	OPC.AddVariable("MyBoolean", True)
	OPC.AddVariable("MyIDE", "B4J")
	OPC.AddVariable("MyHex", "77 77 77 2e 62 34 78 2e 63 6f 6d")

	Log("Nodes added successfully.")
End Sub

' Fired when the server has successfully started.
Private Sub OPC_ServerStarted(EndpointUrl As String)
	Log("Server started at: " & EndpointUrl)

	'Add nodes to the server ready for clients to use
	AddNodes
	
	Log("Server started at: " & EndpointUrl)

	' Add nodes to the server ready for clients to use
	AddNodes

	' Register your custom hardware controller/module here
	' Since HardwareHandler is a code module, we can pass it or a wrapper object.
	' Alternatively, you can use a class instance: Dim HW As Object = InitializeHardwareHandler
	OPC.SetHardwareController(HardwareHandler)
	Log("Hardware controller module registered successfully.")

'	'Tries to create and register the TCP hardware controller AFTER the server is started.
'	Try
'		Dim HW As Object = OPC.CreateTCPHardwareController("localhost", 9000)
'		If HW <> Null Then
'			OPC.SetHardwareController(HW)
'			Log("Hardware controller created and registered.")
'		Else
'			Log("CreateTCPHardwareController returned Null.")
'		End If
'	Catch
'		Log("Failed to create hardware controller: " & LastException)
'	End Try
End Sub

'Fired if the server fails during initialisation or startup.
Private Sub OPC_ServerFailed(Reason As String)
	Log("Server failed: " & Reason)
End Sub

'Fired when a client begins establishing a session.
Private Sub OPC_ClientConnecting(SessionId As String)
	Log("Client connecting: " & SessionId)
End Sub

'Fired when a client session becomes active.
Private Sub OPC_ClientConnected(SessionName As String)
	Log("Client connected: " & SessionName)
End Sub

'Fired when a client session is closed.
Private Sub OPC_ClientDisconnected(SessionName As String)
	Log("Client disconnected: " & SessionName)
End Sub

'Returns an error message from the server
Private Sub OPC_Error(Message As String)
	Log("Server Error: " & Message)
End Sub

' Fired when a client writes a new value to a variable
Private Sub OPC_ValueChanged(Name As String, Value As Object)
	Log("Node: " & Name & " | New Value: " & Value)
    
	' Route to your hardware handler logic
	HardwareHandler.Write(Name, Value)
End Sub

' Fired when a client reads a variable's value
Private Sub OPC_ValueRead(Name As String, Value As Object)
	Log("Node Read: " & Name & " | Current Value: " & Value)
End Sub
