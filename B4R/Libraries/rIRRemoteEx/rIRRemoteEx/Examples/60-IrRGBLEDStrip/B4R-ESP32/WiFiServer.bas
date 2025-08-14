B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=1.19
@EndOfDesignText@
'File:		WiFiServer.bas
'Reference:	https://www.b4x.com/android/forum/threads/ethernet-server-socket.67211/

Sub Process_Globals
	' WiFi
	Private wifi_server As WiFiServerSocket
	' Server IP
	Private Const SERVERIP() As Byte = Array As Byte(192, 168, 1, 90)
	'Server Port
	Private Const SERVER_PORT As Byte = 80
	
	' Conversion
	Private bc As ByteConverter
	Private Astream As AsyncStreams	
	
	' Option disconnect with default 1 (=do disconnect after channel set)
	Private Const DEFAULT_DISCONNECT As Byte = 1
	
	Private Const ULONG_MAX As ULong = 4294967295
End Sub

' Init the server and start listening - do not use Log() here
Public Sub Start
	RunNative("SetIP", SERVERIP)
	wifi_server.Initialize(SERVER_PORT, "Server_NewConnection")	
	wifi_server.Listen
End Sub

' Handle new client connection - calls AStream_NewData to parse the HTTP command.
Private Sub Server_NewConnection (NewSocket As WiFiSocket)
	Log("[Server_NewConnection ] remoteip=", NewSocket.RemoteIp)
	Astream.Initialize(NewSocket.Stream, "AStream_NewData", "AStream_Error")
End Sub

' Handle new data received. Need to parse the buffer starting with GET:
' [AStream_NewData]*START*GET /address=61184&command=3&disconnect=1 HTTP/1.1 Host: 192.168.1.89 User-Agent: Mozilla/5.0 (Windows NT 10.0;*END*
' The HTTP GET command is parsed to get the mandatory arguments channel,value and optional disconnect.
' If the channel,value data is ok, the dmx channel is set.
' There is always an HTTP response to the client either with the arguments channel... or [ERROR] if GET command is invalid
Private Sub AStream_NewData (Buffer() As Byte)
	Log("[AStream_NewData] *START*", bc.StringFromBytes(Buffer),"*END*")

	' Check if there is data
	If Buffer.Length == 0 Then Return
	
	' Split the received data buffer using space to get the arguments starting with /channel
	For Each s() As Byte In bc.Split(Buffer, " ")
		' Does the string contains /address which must be the first argument
		If bc.IndexOf(s, "/address") <> -1 Then

			' Get the arguments channel=N&value=N (start at index 1 to avoid the first separator /)
			' address=61184&command=3&disconnect=0
			' Split the args by &
			Dim args() As Byte = bc.SubString(s, 1)

			' Define the arguments to be assigned
			Dim address As ULong = 0
			Dim command As ULong = 0
			Dim disconnect As Byte = DEFAULT_DISCONNECT

			' Split the arguments by & and loop over to assign the value
			Dim i As Int = 1
			For Each arg() As Byte In bc.split(args , "&")
				Select i
					Case 1
						address = GetArgValue(arg)
					Case 2
						command = GetArgValue(arg)
					Case 3
						disconnect = GetArgValue(arg)
				End Select
				i = i + 1
			Next
			
			' Log("[AStream_NewData]address=", address, ",command=",command, ",disconnect=",disconnect)
			' Check if the mandatory arguments are ok
			If address <> ULONG_MAX And command <> ULONG_MAX Then
				' Mandatory arguments are valid

				' Submit the IR command
				Main.SendCommand(address, command)

				' Send HTTP response to the client
				Astream.Write("HTTP/1.1 200").Write(CRLF)
				Astream.Write("Content-Type: text/html").Write(CRLF).Write(CRLF)
				' Astream.Write("<script>setTimeout(function(){location.href=""http://192.168.NNN.NNN""} , 20000);</script>")
				Astream.Write("address:").Write(NumberFormat(address,0,0).GetBytes())
				Astream.Write(",command:").Write(NumberFormat(command,0,0).GetBytes())
				Astream.Write(",disconnect:").Write(NumberFormat(disconnect,0,0).GetBytes())
			Else
				' Mandatory arguments are invalid
				Log("[ERROR]HTTP Command invalid. Check:", args)
				Astream.Write("HTTP/1.1 200").Write(CRLF)
				Astream.Write("Content-Type: text/html").Write(CRLF).Write(CRLF)
				Astream.Write("[ERROR]HTTP Command invalid. Check:").Write(args)
			End If
	
			' Close the connection if flag set
			If disconnect == 1 Then
				CallSubPlus("CloseConnection", 200, 0)
			End If

		End If
	Next
End Sub

Private Sub AStream_Error
	'Log("[AStream_Error]Disconnected")
	'Need to use listen
	wifi_server.Listen
End Sub

Private Sub ConnectNetwork(unused As Byte)	'ignore
	Main.ConnectToNetwork
End Sub

Private Sub CloseConnection(unused As Byte)
	If wifi_server.Socket.Connected Then
		Log("[CloseConnection] closing")
		wifi_server.Socket.Stream.Flush
		wifi_server.Socket.Close
		Main.esp_connected = False
	End If
End Sub

'Helpers

' Get the arg value as ULongfrom argument string, i.e. address=61184
Private Sub GetArgValue(arg() As Byte) As ULong
	' Log("[GetArgValue]",arg)

	' Split the arg using = as separator
	Dim valuestr As String
	Dim value As ULong = ULONG_MAX
	Dim i As Int = 0
	For Each ba() As Byte In bc.split(arg , "=")
		' Get the value as array entry 2 (index 1)
		If i == 1 Then
			' Check if there is a value
			If ba.Length > 0 Then
				valuestr = bc.StringFromBytes(ba)
				value = valuestr.As(ULong)
			End If
		End If
		i = i + 1
	Next
	Return value
End Sub

#Region Helper

#End Region

'Inline C used to set fix ip
#if C
void SetIP(B4R::Object* o) {
	B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);
	IPAddress ip(ByteFromArray(b, 0),ByteFromArray(b, 1) , ByteFromArray(b, 2), ByteFromArray(b, 3));  
	IPAddress gateway(192, 168, 1, 1);
	IPAddress subnet(255, 255, 255, 0);
	WiFi.config(ip, gateway, subnet);
}
#end if  

