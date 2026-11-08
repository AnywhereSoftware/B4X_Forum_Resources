B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Project Information
'Project: BLE-TCP-Bridge Example 
'Date: 20250301
'Author: Robert W.B. Linn
'Description: The B4J application (app) connects as a client, by using a Python script, with an ESP32 running as Bluetooth Low Energy (BLE) server.
'The BLE server advertises DHT22 sensor data temperature & humidity and listens to commands send from connected clients.
'The app starts (via Shell command) the Python script bletcpbridge.py, which acts as a bridge between BLE and TCP.
'The data is passed thru the bridge and to be handled by client or BLE server. This enables to use the bridge independent client and server.
'The script connects first to the BLE server via Bluetooth.
'If the BLE connection is successful, the app connects to the Python script using a socket (communication endpoint) and initializes an asynchronous stream.
'The stream is used to handle incoming data from the bridge but also to send commands to the BLE server.
'Source: bletcpbridge.b4j, B4J 10.20 BETA #3 (64 bit)
'
'BLEServer Advertisements [B4R > BLE-TCP-Bridge > B4J] 
'6 bytes = 2 bytes T (int, NNNN) + 2 bytes H (int, NNNN) + 2 bytes I (int, NNNN) As Little
'Example 4A06 7719 8813 > t=1610 (064ª),h=6519 (1977), i=5000 (1388) (i = advertising interval)
'
'B4J Commands sent [B4J > BLE-TCP-Bridge > B4R]
'Set Traffic-Light: 2 Bytes; 1=01 RED,02  YELLOW,03 GREEN; Byte 2=00 LED OFF Or 01 ON. Example 0101 set LED RED ON.
'Set Advertising Interval: Byte 1=04; Byte2=00-3C (DEC 60). Example 0414 For interval 20 s.
'Stop BLE-TCP-Bridge: Send string stop (bytes)

'Communication Flow:
'App (B4J 10.x) <--> BLE-TCP-Bridge (Python 3.11.x) <--> BLE Server (B4R 4.x)

'Testing Hints
'In case of an error and the Python process is not properly stopped:
'netstat -ano | findstr :58001
'taskkill /PID <PID> /F
#End Region

Sub Class_Globals
	Private VERSION As String = "rBLEServer Example BLETCPBridge v20250302"
	
	Private Root As B4XView
	Private xui As XUI
	Private LabelBLEState As B4XView
	Private LabelTemperature As B4XView
	Private LabelHumidity As B4XView
	Private LabelInterval As B4XView
	Private CustomListViewLog As CustomListView
	Private ButtonReconnect As B4XView
	Private B4XSeekBarInterval As B4XSeekBar
	Private LabelSeekBarIntervalValue As B4XView
	Private ButtonIntervalSet As B4XView
	Private CheckBoxLED As B4XView

	'Shell
	Private Shl As Shell							'jShell
	
	'Python BLE-TCP-Bridge (located in the dirapp folder)
	Private BLE_TCP_BRIDGE_SCRIPT As String = "bletcpbridge.py"
	Private CMD_STOP As String = "stop"

	'Comunication
	Private ClientSocket As Socket					'jNetwork
	Private AStream As AsyncStreams					'jRandomAccessFile
	Private SERVER_IP As String = "127.0.0.1"
	Private SERVER_PORT As Int = 58001

	'Helper
	Private bc As ByteConverter						'ByteConverter
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	'UI settings
	B4XPages.SetTitle(Me, VERSION)
	LabelBLEState.Text = "Disconnected"
	ButtonReconnect.Enabled = True
	CheckBoxLED.Enabled = False

	'Start the BLE-TCP-Bridge
	RunPythonScript($"${BLE_TCP_BRIDGE_SCRIPT}"$)

	'Init the Socket
	ClientSocket.Initialize("ClientSocket")
	'ClientSocket_Connect is called in the Shell event StdErr after the bridge connects to the ESP32 via BLE
End Sub

'Close the b4xpages app. Prior closing the BLE-TCP-Bridge is stopped.
Private Sub B4XPage_CloseRequest As ResumableSub
	LogColor($"[B4XPage_CloseRequest] starting..."$, xui.Color_Red)
	Dim command() As Byte = CMD_STOP.GetBytes("UTF8")
	LogColor($"[B4XPage_CloseRequest] stopping the BLE-TCP-Bridge..."$, xui.Color_Red)
	AStream_Write(command)
	Sleep(100)
	LogColor($"[B4XPage_CloseRequest] done..."$, xui.Color_Red)
	Return True
End Sub

Private Sub B4XPage_Background
	'NOT USED
End Sub

#Region UI
'Reconnect to the BLE-TCP-Bridge.
Private Sub ButtonReconnect_Click
	If Not(ClientSocket.Connected) Then
		ClientSocket_Connect
	End If
End Sub

'Handle LED checkbox changes to set the RED LED state.
Private Sub CheckBoxLED_CheckedChange(Checked As Boolean)
	SetLED(Checked)
End Sub

'Set the RED LED on the ESP32 by writing 2 bytes.
'Command: 0x010x00|0x01 = 01 for the command, 00 or 01 for the LED state.
Private Sub SetLED(state As Boolean)
	Dim command() As Byte = IIf(state, Array As Byte(0x01, 0x01), Array As Byte(0x01, 0x00) )
	If ClientSocket.Connected Then
		AStream_Write(command)
		CustomListViewLog_Insert($"${DateTime.time(DateTime.now)} :: Set LED state to ${IIf(state,"ON","OFF")}"$)
	End If
End Sub

'Set the BLEServer advertising interval.
'Command: 0x040x00-0C = 04 for the command, 00-3C for the interval 0-60 s.
Private Sub ButtonIntervalSet_Click
	Dim command(2) As Byte
	command(0) = 0x04
	command(1) = IntToByte(B4XSeekBarInterval.Value)
	If ClientSocket.Connected Then
		AStream_Write(command)
		CustomListViewLog_Insert($"[B4XSeekBarInterval_ValueChanged] value=${B4XSeekBarInterval.Value}, hex=${bc.HexFromBytes(command)}"$)
	End If
End Sub

'Change the interval. Click set to change on the BLEServer.
Private Sub B4XSeekBarInterval_ValueChanged (Value As Int)
	LabelSeekBarIntervalValue.Text = $"${Value} s."$
End Sub

'Insert logentry at first position.
Private Sub CustomListViewLog_Insert(item As String)
	CustomListViewLog.InsertAt(0, CustomListViewLog_CreateItem(item), "")
	'CustomListViewLog.Add(CustomListViewLog_CreateItem(item), "")
End Sub

'Create logentry item.
Sub CustomListViewLog_CreateItem(item As String) As Pane
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.Color = xui.Color_White
	pnl.SetLayoutAnimated(0, 0, 0, CustomListViewLog.AsView.Width, 30dip)
	Dim lbl As B4XView = XUIViewsUtils.CreateLabel
	lbl.Text = item
	lbl.SetTextAlignment("CENTER", "LEFT")
	lbl.Font = xui.CreateDefaultBoldFont(14)
	pnl.AddView(lbl, 0, 0, CustomListViewLog.AsView.Width, 30dip)
	Return pnl
End Sub
#End Region

#Region Shell
'Run the python script using the shell.
Public Sub RunPythonScript(script As String)
	Log("[RunPythonScript] Starting ${script}")

	Log("[RunPythonScript] Init Shell with script")
	Shl.Initialize("shl", "python", Array(script))
	Shl.WorkingDirectory = File.DirApp

	'Run script with disabled timeout but with output events.
	'The event StdErr is used to check if the bridge has connected to the BLE device.
	'If the app is closed, the script is stopped (see B4XPage_CloseRequest)
	Log("[RunPythonScript] Run Python script ${script} with output events")
	Shl.RunWithOutputEvents(-1)
	CustomListViewLog_Insert($"[BLE-TCP-Bridge] Waiting for BLE connection"$)
End Sub

'Handle shell completion.
Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Log($"[shl_ProcessCompleted] Success=${Success}, ExitCode=${ExitCode}, StdOut=${StdOut}, StdErr=${StdErr}"$)
End Sub

'Handle shell output event stdout.
'The python script sends JSON structured messages to stdout.
Sub shl_StdOut (Buffer() As Byte, Length As Int)
    'Log($"[Stdout] ${BytesToString(Buffer, 0, Length, "UTF8")}"$)
	Dim j As JSONParser

	'Try to parse message received from bridge process
	Try
		j.Initialize(BytesToString(Buffer, 0, Length, "UTF8"))
		Dim m As Map = j.NextObject

		'Event connect sucessful then connect to the BLE-TCP-Bridge
		'[Stdout] {"event": "connect", "message": "BLE-TCP-Bridge successfully connected", "status": 1}
		If m.Get("event") == "connect" Then
			Dim status As Int = m.Get("status")
			If status == 1 Then
				ClientSocket_Connect
			End If
		End If		
	Catch
		Log($"[Stdout][INFO]${LastException}"$)
	End Try
End Sub

'Handle shell output event stderr.
Sub shl_StdErr (Buffer() As Byte, Length As Int)
	'TODO: Improve error handling
End Sub
#End Region

#Region Socket
'Connect to the BLE-TCP-Bridge.
Sub ClientSocket_Connect
	Dim statemsg As String
	Log($"[ClientSocket_Connect] Connecting to ${SERVER_IP}:${SERVER_PORT}"$)

	'Connect to the the server
	ClientSocket.Connect(SERVER_IP, SERVER_PORT, 0)

	'Wait for successful connection to init the asyncstream	
	Wait For (ClientSocket) ClientSocket_Connected (Successful As Boolean)
	If Successful Then
		AStream.Initialize(ClientSocket.InputStream, ClientSocket.OutputStream, "AStream")
	End If

	'Update UI
	statemsg = IIf(Successful, "Connected", "Disconnected")
	CallSubDelayed2(Me, "SetLabelBLEState", statemsg)
	CheckBoxLED.Enabled = ClientSocket.connected
	Log($"[ClientSocket_Connect] ${statemsg}"$)
End Sub

Sub SetLabelBLEState(msg As String)
	LabelBLEState.Text = msg
End Sub

'Sub ClientSocket_Connected (Successful As Boolean)
'NOT NEEDED because using wait for in connect
'End Sub

'Handle new data from the BLEServer.
Sub AStream_NewData( Buffer() As Byte )
	Log($"[AStream_NewData] buffer=${bc.HexFromBytes(Buffer)}, len=${Buffer.Length}"$)
	
	'Convert rawdata to data (little-endian)
	Dim temperature As Float = IntFromBytes(Buffer(1),Buffer(0)) / 100
	Dim humidity As Float = IntFromBytes(Buffer(3),Buffer(2)) / 100
	Dim interval As Short = IntFromBytes(Buffer(5),Buffer(4)) / 1000

	'Update UI	
	LabelTemperature.Text = $"${temperature} °C"$
	LabelHumidity.Text = $"${humidity} %RH"$
	LabelInterval.Text = $"Advertising interval"$

	'Check interval changed to update the seekbar
	If interval <> B4XSeekBarInterval.Value Then
		B4XSeekBarInterval.Value = interval
		LabelSeekBarIntervalValue.Text = $"${interval} s"$
	End If

	CustomListViewLog_Insert($"${DateTime.time(DateTime.now)} :: ${temperature} °C, ${humidity} %RH, ${interval} s"$)
End Sub

'Write command to the BLEServer via the BLE-TCP-Bridge
Sub AStream_Write(command() As Byte)
	LogColor($"[AStream_Write] command=${bc.HexFromBytes(command)}"$, xui.Color_Blue)
	If ClientSocket.Connected Then
		AStream.Write(command)		
	End If
End Sub

Sub AStream_Error
	Log("[AStream_Error] " & LastException.Message )
End Sub

Sub AStream_Terminated
	Log("[AStream_Terminated]")
End Sub
#End Region

#Region Helper
'Iterate over map keys and values.
Public Sub PrintMap(m As Map)
	For Each key As String In m.Keys
		Dim value As String = m.Get(key)
		Log($"key: ${key}, value: ${value}"$)
	Next
End Sub

'Convert 2 bytes to an int.
'Ensure to set endian right.
Public Sub IntFromBytes(b1 As Byte, b2 As Byte) As Int
	Dim hex As String = bc.HexFromBytes(Array As Byte(b1,b2))
	Dim result As Int = Bit.ParseInt(hex, 16)
	'Log($"[IntFromBytes] hex=${hex}, int=${result}"$)
	Return result
End Sub

'Convert int 0-255 to 1 byte.
Public Sub IntToByte(value As Int) As Byte
	If value >= 0 And value <= 255 Then
		Dim result As Byte = value
	End If
	'Log($"[IntToBytes] int=${value}, hex=${bc.HexFromBytes(Array As Byte(result))}"$)
	Return result
End Sub
#End Region
