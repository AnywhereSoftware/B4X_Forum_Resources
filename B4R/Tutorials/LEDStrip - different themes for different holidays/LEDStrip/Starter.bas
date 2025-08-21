B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.5
@EndOfDesignText@

#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Private astream As AsyncStreams
	Private socket As Socket
	Public connected As Boolean
	Private watchdog As Timer
	Private lastValueTime As Long
	Private ser As B4RSerializator
	Private IPAddress	As String
	Private BC As ByteConverter
End Sub

Sub Service_Create
	watchdog.Initialize("watchdog", 1000)
	ser.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Public  Sub Connect(IP As String)
			IPAddress = IP
			
			ReConnect
End Sub

Public Sub ReConnect			 
	If astream.IsInitialized Then
		astream.Close
	End If
	socket.Initialize("socket")
	socket.Connect(IPAddress, 51042, 30000)
End Sub

Private Sub Socket_Connected (Successful As Boolean)
	Log("Server::Socket_Connected:" &Successful)
	If Successful Then
		connected = True
		astream.InitializePrefix(socket.InputStream, False, socket.OutputStream, "astream")
		CallSub(Main, "StateChanged")
		watchdog.Enabled = True
		lastValueTime = DateTime.Now
	End If
End Sub

Public  Sub SendCmd(LedStripCmd As TLedStripCmd)
			Dim Bytes() As Byte = ser.ConvertArrayToBytes(Array(cLedStripWiFi.DEFINE_BobsCheck, LedStripCmd.CmdData, cLedStripWiFi.DEFINE_BobsCheck))
			
			Log("HexCommands[" &BC.HexFromBytes(Bytes) &"]")

				If  connected = False Then
					do  while connected = False
						ReConnect
						Sleep(2000)
					Loop
				End If
			
			astream.Write(Bytes)
End Sub

Public  Sub SendData(Leds() As byte)
			Log("SendData")
			
			If  Leds.Length = 3 Then
				If  connected = False Then
					do  while connected = False
						ReConnect
						Sleep(2000)
					Loop
				End If

				Log("Writing AStream")
				
				astream.Write(ser.ConvertArrayToBytes(Array("From B4A-LedStrip", Leds(0), Leds(1), Leds(2))))
			Else
				Log("Need 3 Leds")
			End If
End Sub
Private Sub Astream_NewData(Buffer() As Byte)
	Log("Astream_NewData")
	CallSub2(Main, "NewData", ser.ConvertBytesToArray(Buffer))
'	lastValueTime = DateTime.Now
'	astream.Write(ser.ConvertArrayToBytes(Array("Sent from B4A", DateTime.Time(DateTime.Now), True)))
End Sub

Private Sub Astream_Error
	Log("Server::Disconnected")
	connected = False
	CallSub(Main, "StateChanged")
	watchdog.Enabled = False
End Sub

Private Sub Astream_Terminated
	Astream_Error
End Sub

Private Sub Watchdog_Tick
	If DateTime.Now - lastValueTime > 10 * DateTime.TicksPerSecond Then
		Log("Watchdog closing connection.")
		If astream.IsInitialized Then astream.Close
		Astream_Error
	End If
End Sub

Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
