Type=StaticCode
Version=2
ModulesStructureVersion=1
B4R=true
@EndOfDesignText@

Sub Process_Globals
	Private Astream As AsyncStreams	
	Private server As WiFiServerSocket
End Sub

Public Sub Start
	Log("StartAP: ", Main.WiFi.StartAccessPoint("esp"))
	Log("My AP ip: ", Main.WiFi.AccessPointIp)
	Log("My local ip: ", Main.WiFi.LocalIp)
	server.Initialize(51042, "server_NewConnection")
	server.Listen
End Sub

Private Sub Server_NewConnection (NewSocket As WiFiSocket)
	Log("New connection")
	Astream.InitializePrefix(NewSocket.Stream, False, "astream_NewData", "astream_Error")
	Dim StoredLength As Byte = Main.GetStoredDataLength
	If StoredLength > 0 Then
		Astream.Write(Array As Byte(1))
		Astream.Write(Main.eeprom.ReadBytes(2, StoredLength))
	Else
		Astream.Write(Array As Byte(0))
	End If
End Sub

Private Sub Astream_NewData (Buffer() As Byte)
	Main.SaveNetworkDetails(Buffer)
	
End Sub


Private Sub AStream_Error
	Log("Disconnected")
	server.Socket.Close
	server.Listen
End Sub

