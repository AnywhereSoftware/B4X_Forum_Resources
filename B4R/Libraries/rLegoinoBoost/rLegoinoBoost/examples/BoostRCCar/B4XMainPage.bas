B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' Class: B4XMainPage
' 

#Region Shared Files
'See https://www.b4x.com/android/forum/threads/b4x-b4xpages-add-files-in-shared-files-folder.123518/
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	' UI
	Private Root As B4XView
	Private xui As XUI
	' Communication
	Private btnSocketConnect As B4XView
	Private lblSocketConnectionState As B4XView
	Private lblBridgeConnectionState As B4XView
	Private socket As Socket					'Lib: B4J=jNetwork,B4A=Network
	Public	socketIP As String
	Public	socketPort As Int
	Public asyncStream As AsyncStreams			'Lib: B4J=jRandomAccessFile,B4A=RandomAccessFile
	' Steering
	Private btnSteerLeft As B4XView
	Private btnSteerMiddle As B4XView
	Private btnSteerRight As B4XView
	Private sldrSteer As B4XView
	Private btnCalibrate As B4XView
	Private isCalibrating As Boolean = False
	Private calibrateValue As Int = 30		' must be a positive value
	Private Const DISTANCE_MIN As Int = 50	' car stops at obstancle detected distance 50mm or lower
	' Move
	Private btnMoveBackward As B4XView
	Private btnMoveStop As B4XView
	Private btnMoveForward As B4XView
	Private sldrSpeed As B4XView
	' Sensor Info
	Private lblDistance As B4XView
	Private lblHUBVoltage As B4XView
	' Additional pages
	Public ConfigPage As B4XConfigPage
	' Data
	Private serData As B4RSerializator			'Module: B4RSerializator located in the B4X project folder
	' Timer Driving
	Private TimerDriving As Timer
	Private TIMERDRIVING_INTERVAL As Long = 1000
	Private isDriving As Boolean = False
	Private moveDirection As Byte = 1	'0=stop,1=forward,2=backward
	' Logging
	Private bc As ByteConverter
	Private debugMode As Boolean = False
	Private lvLog As ListView
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = False	' True
	' Data
	serData.Initialize
	' Timer
	TimerDriving.Initialize("TimerDriving", TIMERDRIVING_INTERVAL)
	TimerDriving.Enabled = isDriving
End Sub

'This event will be called once, before the page becomes visible.
'Add all pages
Private Sub B4XPage_Created (Root1 As B4XView)
	' Main Page - The page LayoutFile must be given direct as string and not via var or const
	Root = Root1
	Root.LoadLayout("MainPage")
	'Root.LoadLayout(Constants.MAINPAGE_ID)
	B4XPages.SetTitle(Me, Constants.VERSION)
	' MainPage Set views
	Set_Log_TextSize(12)
	lblBridgeConnectionState.Text = $"Bridge${CRLF}Disconnected"$
	lblSocketConnectionState.Text = $"WiFi${CRLF}Disconnected"$
	lblHUBVoltage.Text = $"HUB Voltage${CRLF}Unknown"$
	lblDistance.Text = $"Obstacle Distance${CRLF}Unknown"$
	' Config Page
	ConfigPage.Initialize
	B4XPages.AddPage(Constants.CONFIGPAGE_ID, ConfigPage)
	' WiFi Communication to the B4R server
	socketIP = Constants.WIFI_DEFAULT_IP
	socketPort = Constants.WIFI_DEFAULT_PORT
	socket.Initialize("socket")
	Socket_Connect(socketIP)
End Sub

#Region SOCKET
' Connect to the socket. Call sub socket_connected to init the asyncstream for handling data.
' ip - if of the B4R server socket
Private Sub Socket_Connect(ip As String)
	' Close the socket if connected
	If socket.Connected Then socket.Close
	' Connect new with the ip given
	ToLog($"Socket_Connect: WiFi connecting to Remote IP=${ip}, Port=${socketPort}"$)
	' Connect with event Socket_Connected
	If Not(socket.IsInitialized) Then
		socket.Initialize("socket")
	End If
	socket.Connect(ip, socketPort, 5000)
End Sub

' Handle B4R server socket connections from sub socket.connect.
' Init the asyncstream for data to from B4R to the BOOST HUB (via Bluetooth)
Private Sub Socket_Connected(Successful As Boolean)
	' ToLog($"Socket_Connected: Successful=${Successful}"$)
	If Successful Then
		#If B4A
		ToLog($"Socket_Connect: WiFi connected"$)
		#End If
		#If B4J
		ToLog($"Socket_Connect: WiFi connected, Remote IP=${socket.RemoteAddress}"$)
		#End If
		If asyncStream.IsInitialized Then asyncStream.Close
		asyncStream.Initialize(socket.InputStream, socket.OutputStream, "ASyncStream")
		lblSocketConnectionState.Text = $"WiFi${CRLF}Connected"$
		btnSocketConnect.Text = "Disconnect"
		Write_Get_Command(Boost.Command_Get_Connection_State)
	Else
		lblSocketConnectionState.Text = $"WiFi${CRLF}Disconnected"$
		btnSocketConnect.Text = "Connect"
		ToLog($"Socket_Connect: WiFi disconnected"$)
	End If
End Sub

Private Sub Socket_Disconnect	'ignore
'	ToLog($"Socket_Disconnect: WiFi disconnecting ..."$)
	If asyncStream.IsInitialized Then asyncStream.Close
	If socket.Connected Then socket.Close
	lblSocketConnectionState.Text = $"WiFi${CRLF}Disconnected"$
	btnSocketConnect.Text = "Connect"
	lblBridgeConnectionState.Text = $"Bridge${CRLF}Disconnected"$
	lblHUBVoltage.Text = $"HUB Voltage${CRLF}Unknown"$
	lblDistance.Text = $"Obstacle Distance${CRLF}Unknown"$
	ToLog($"Socket_Disconnect: WiFi disconnected"$)
End Sub

' Button to connect or disconnect to the socket
Private Sub btnSocketConnect_Click
	Log($"btnSocketConnect_Click: Initialized=${socket.IsInitialized}, Connected=${socket.Connected}, IP=${socketIP}"$)
	If socket.Connected Then
		Socket_Disconnect
	Else
		Socket_Connect(socketIP)
	End If
End Sub
#End Region

#Region ASYNCSTREAM
' Handle NewData from an Arduino coming in via the communication line.
' Parameter: Buffer as byte. The buffer needs to be converted to an array.
' The buffer must have 3 objects
Private Sub ASyncStream_NewData (Buffer() As Byte)
	If Buffer.Length == 0 Then Return
	Dim data() As Object = serData.ConvertBytesToArray(Buffer)
	If data.Length <> 3 Then Return
	If Not(debugMode) Then
		Dim data() As Object = serData.ConvertBytesToArray(Buffer)
		If data.Length <> 3 Then Return
		ToLog($"ASyncStream_NewData: ${data(0).As(String)}, ${data(1).As(String)}, ${data(2).As(String)}"$)
		' Check the received data command
		Select data(0).As(Byte)
			Case Boost.CMD_GET_CONNECTION_STATE
				' HUB Connection State Command
				lblBridgeConnectionState.Text = $"Bridge${CRLF}Disconnected"$
				' Dim State As Int = data(2)
				' If the bridge is connected to the HUB then set HUB LED color to green and update HUB voltage
				If data(2).As(Int) == 1 Then
					lblBridgeConnectionState.Text = $"Bridge${CRLF}Connected"$
					CallSubDelayed2(Me, "Write_Set_Command", Boost.Command_Get_Voltage)
					' Need to wait here till get voltage is completed
					Sleep(500)
					CallSubDelayed2(Me, "Write_Set_Command", Boost.Command_Get_Distance(Boost.PORT_D))
				End If
			Case Boost.CMD_GET_VOLTAGE
				lblHUBVoltage.Text = $"HUB Voltage${CRLF}${NumberFormat(data(2).As(Double),0,2)}V"$
			Case Boost.CMD_GET_DISTANCE
				lblDistance.Text = $"Obstacle Distance${CRLF}${NumberFormat(data(2).As(Double),0,2)}mm"$
				If moveDirection == 1 And data(2).As(Double) < DISTANCE_MIN Then btnMoveStop_Click
		End Select

	Else
		ToLog($"${bc.StringFromBytes(Buffer, "UTF-8")}"$)
	End If
End Sub

Private Sub ASyncStream_Write(cmd As Byte, port As Byte, value As Int)
	If Not(asyncStream.IsInitialized) Then Return
	Try
		' Depending command write the serialized data
		If cmd == Boost.CMD_SET_TACHOMOTOR_SPEED Then
			asyncStream.Write(serData.ConvertArrayToBytes(Array(Boost.CMD_PREFIX, cmd, port, value)))			
		End If
		If cmd == Boost.CMD_SET_LED_COLOR Then
			asyncStream.Write(serData.ConvertArrayToBytes(Array(Boost.CMD_PREFIX, cmd, value)))
		End If
		ToLog($"ASyncStream_Write: ${Boost.CMD_PREFIX}, ${cmd}, ${port}, ${value}"$)
		If cmd == Boost.CMD_SET_DEBUG_MODE Then
			debugMode = IIf(value == 0, False, True)
		End If
	Catch
		ToLog($"[ERROR] ASyncStream_Write: ${LastException}"$)
	End Try
End Sub

Private Sub ASyncStream_Error
	ToLog($"ASyncStream_Error: ${LastException}"$)
End Sub

Private Sub ASyncStream_Terminated
	ToLog($"ASyncStream_Terminated$""$$)
End Sub

' Asynstream write a get command using serialized data.
' A get command returns from the ESP32 3 objects: cmd, name, value
' Example: Write_Get_Command(Boost.Command_Get_ConnectionState)
Public Sub Write_Get_Command(data() As Object)
	If Not(asyncStream.IsInitialized) Then Return
	Try
		asyncStream.Write(serData.ConvertArrayToBytes(data))
		ToLog($"Write_Get_Command: Objects=${data.length}, Data=${ObjectsToString(data)}"$)
	Catch
		ToLog($"[ERROR] Write_Set_Command: ${LastException}"$)
	End Try
End Sub

' Asynstream write a set command using serialized data.
' Example: Write_Set_Command(Boost.CMD_SET_TACHOMOTOR_SPEED, 0, 20)
Public Sub Write_Set_Command(data() As Object)
	If Not(asyncStream.IsInitialized) Then Return
	ToLog($"Write_Set_Command: Objects=${data.length}, Data=${ObjectsToString(data)}"$)
	Try
		asyncStream.Write(serData.ConvertArrayToBytes(data))			 
	Catch
		ToLog($"[ERROR] Write_Set_Command: ${LastException}"$)
	End Try
End Sub

' Asynstream write a set command using serialized data.
' Example: Write_Set_Command(Boost.CMD_SET_TACHOMOTOR_SPEED, 0, 20)
Public Sub Write_Set_Command3(cmd As Byte, port As Byte, value As Int)
	If Not(asyncStream.IsInitialized) Then Return
	ToLog($"Write_Set_Command3: ${cmd} (0x${bc.HexFromBytes(Array As Byte(cmd))}), port: ${port}, value: ${value}"$)
	Try
		Select cmd
			Case Boost.CMD_SET_ABSOLUTE_MOTOR_POSITION
				asyncStream.Write(serData.ConvertArrayToBytes(Array(Boost.CMD_PREFIX, cmd, port, 100, value)))
			Case Else
				asyncStream.Write(serData.ConvertArrayToBytes(Array(Boost.CMD_PREFIX, cmd, port, value)))			 
		End Select
	Catch
		ToLog($"[ERROR] Write_Set_Command: ${cmd} - ${LastException}"$)
	End Try
End Sub
#End Region

#Region CONFIGPAGE
Private Sub btnConfigPage_Click
	B4XPages.ShowPage(Constants.CONFIGPAGE_ID)
	' xui.MsgboxAsync("Hello world!", "B4X")
End Sub
#End Region

#Region BASECAR
Private Sub TimerDriving_Tick
	If isDriving Then
		' Write_Set_Command(Boost.Distance(Boost.PORT_D))		
	End If
End Sub

Private Sub Set_TimerDriving(speed As Double)
	isDriving = (speed <> 0)
	TimerDriving.Enabled = isDriving
End Sub

#If B4A
Private Sub sldrSpeed_ValueChanged (Value As Int, UserChanged As Boolean)
	Select  moveDirection
		Case 0
			btnMoveStop_Click
		Case 1
			btnMoveForward_Click
		Case 2
			btnMoveBackward_Click
	End Select
End Sub
#End If

#If B4J
Private Sub sldrSpeed_ValueChange (Value As Double)
	Select  moveDirection
		Case 0
			btnMoveStop_Click
		Case 1
			btnMoveForward_Click
		Case 2
			btnMoveBackward_Click
	End Select
End Sub
#End If

Private Sub btnMoveForward_Click
	moveDirection = 1
	#if B4A
	Dim speed As Double = sldrSpeed.As(SeekBar).Value * -1
	#End If
	#if B4J
	Dim speed As Double = sldrSpeed.As(Slider).Value * -1
	#End If
	Write_Set_Command(Boost.Command_Move_Forward(Boost.PORT_AB, speed))
	Set_TimerDriving(speed)
End Sub

Private Sub btnMoveBackward_Click
	moveDirection = 2
	#if B4A
	Dim speed As Double = sldrSpeed.As(SeekBar).Value
	#End If
	#if B4J
	Dim speed As Double = sldrSpeed.As(Slider).Value
	#End If
	Write_Set_Command(Boost.Command_Move_Backward(Boost.PORT_AB, speed))
	Set_TimerDriving(speed)
End Sub

Private Sub btnMoveStop_Click
	moveDirection = 0
	Write_Set_Command(Boost.Command_Move_Stop(Boost.PORT_AB))
	Set_TimerDriving(0)
End Sub

Private Sub btnSteerRight_Click
	#If B4A
	sldrSteer.As(SeekBar).Value = sldrSteer.As(SeekBar).Value + 5
	#End If
	#If B4J
	sldrSteer.As(Slider).Value = sldrSteer.As(Slider).Value + 5
	#End If
End Sub

Private Sub btnSteerMiddle_Click
	#If B4A
	sldrSteer.As(SeekBar).Value = 45 ' - calibrateValue
	#End If
	#If B4J
	sldrSteer.As(Slider).Value = 45 ' - calibrateValue
	#End If
End Sub

Private Sub btnSteerLeft_Click
	#If B4A
	sldrSteer.As(SeekBar).Value = sldrSteer.As(SeekBar).Value - 5
	#End If
	#If B4J
	sldrSteer.As(Slider).Value = sldrSteer.As(Slider).Value - 5
	#End If
End Sub

#If B4A
Private Sub sldrSteer_ValueChanged (Value As Int, UserChanged As Boolean)
	Dim motorposition As Int = Value.As(Int) - calibrateValue
	' 0 = LEFT, 90 = RIGHT needs conversion 90 = LEFT, 0 = RIGHT
	motorposition = motorposition * -1
	If Not(isCalibrating) Then
		Write_Set_Command(Boost.Command_Motor_Position(Boost.PORT_C, motorposition))
	Else
		isCalibrating = False
	End If
End Sub
#End If

#If B4J
Private Sub sldrSteer_ValueChange (Value As Double)
	' Convert value 0 - 90 to -45 .. 0 .. 45
	' BUT need to handle offset of the middle position. Example:
	' sliderposition -30 (middle) is 0° motor position.
	' The abs offset is 30 + 45 = 75, means range -75 .. -30 .. +15 equals slider 0 .. 45 .. 90
	' slider 45 = 45 - 75 = -30
	Dim motorposition As Int = Value.As(Int) - calibrateValue
	' 0 = LEFT, 90 = RIGHT needs conversion 90 = LEFT, 0 = RIGHT
	motorposition = motorposition * -1
	If Not(isCalibrating) Then
		Write_Set_Command(Boost.Command_Motor_Position(Boost.PORT_C, motorposition))
	Else
		isCalibrating = False
	End If
End Sub
#End If

Private Sub btnCalibrate_Click
	' Option via library method
	Write_Set_Command(Boost.Command_Motor_Calibrate(Boost.PORT_C))
	Return
'	' Get the actual slider position used to reset the middle position
'	calibrateValue = Abs(sldrSteer.As(Slider).Value) + 45
'	' Set the flag calibrating
'	isCalibrating = True
'	' Set the steer to the middle position		
'	btnSteerMiddle_Click
End Sub


#End Region

#Region HELPERS
Public Sub ObjectsToString(data() As Object) As String
	Dim sb As StringBuilder
	Dim str As String
	sb.Initialize
	For Each s As String In data
		sb.Append(s)
		sb.Append(", ")
	Next
	str = sb.ToString.trim
	If str.EndsWith(",") Then str = str.SubString2(0, str.LastIndexOf(","))
	Return str
End Sub

Private Sub ToLog(msg As String)
	If Not(lvLog.IsInitialized) Then Return
	msg = $"${DateTime.Time(DateTime.Now)} ${msg}"$
	#If B4A
	lvLog.AddSingleLine(msg)
	' lvLog.ScrollTo(0)
	#End If
	#If B4J
	lvLog.Items.InsertAt(0, msg)
	lvLog.ScrollTo(0)
	#End If
	Log(msg)
End Sub

Private Sub Set_Log_TextSize(value As Int)
	#If B4A
	Dim Label1 As Label
	Label1 = lvLog.SingleLineLayout.Label
	Label1.TextSize = value
	Label1.TextColor = Colors.Black
	#End If
End Sub
#End Region

