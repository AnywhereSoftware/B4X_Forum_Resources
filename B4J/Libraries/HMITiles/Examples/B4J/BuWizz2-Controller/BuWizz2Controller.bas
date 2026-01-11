B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	BuWizz2Controller.bas
' Brief:    	Control the BuWizz2 Brick.
' Date:			2026-01-05
' Author:		Robert W.B. Linn (c) 2025-2026 MIT
' Description:	BuWizz 2.0 Ludicrous (http://buwizz.com/shop/1-buwizz-2/) is a remote control & battery in one brick, compatible with all LEGO® Power Functions motors and lights.
'				Run a LEGO® Power Functions motor connected to port 1 of the BuWizz2 brick.
'				Connection is made using the brick MAC address.
'				Handle notifications with the event NewData
'				BLE name BuWizz with alias BuWizz2. If brick is turned on, the green light flashed. When connected the green light is in steady state
'
' Hints:		If not connected first time, then try again. It happens that in cases 1 or 2 tries are required.
'				Android writes must be WRITE_TYPE_DEFAULT (write with response), otherwise the BuWizz ignores the command.
'
' Motor Speed:	0x81 (-127): Full backwards, 0x00 (0): Stop, 0x7F (127): Full forwards
' ================================================================
#End Region

Sub Class_Globals
	Public Logging As Boolean = True
	
	' UUIDs - MUST BE LOWERCASE
	' BLE device (ESP32 Plus)
	Public BLE_MAC As String 			= "50:FA:AB:38:A6:1A"						' BuWizz2 MAC address
	Public BLE_DEVICE_NAME As String 	= "BuWizz2"									' Case sensitive

	' BLE Service & Characteristics BuWizz V2
	Public SERVICE_UUID As String 		= "4e050000-74fb-4481-88b3-9919b1676e93"	' BuWizz2 service UUID
	Public CHAR_UUID_RX  As String		= "000092d1-0000-1000-8000-00805f9b34fb" 	' Control characteristic UUID Flags read,notify,write
	Public CHAR_UUID_TX  As String		= "000092d1-0000-1000-8000-00805f9b34fb" 	' Control characteristic UUID Flags read,notify,write
	
	' BuWizz type populated from notification data
	' Do not define pins, arrays
	Type TBuWizz2Status (StatusFlags As Byte, _
				         BatteryVoltage As Float, _          	'V
						 OutputVoltage As Float, _           	'V
						 Motor1Current As Byte, _       		'A
						 Motor2Current As Byte, _       		'A
						 Motor3Current As Byte, _       		'A
						 Motor4Current As Byte, _       		'A
						 PowerLevel As Byte, _ 	            	'0=disabled, 1=slow, 2=Normal, 3=Fast, 4=LDCRS
						 Temperature As Int, _            		'C
						 AccX As Int, AccY As Int, AccZ As Int)	'12-Bit signed accelerometer values
	Public BuWizz2Status As TBuWizz2Status

	' Ports
	Public PORT_0 As Byte = 0
	Public PORT_1 As Byte = 1
	Public PORT_2 As Byte = 2
	Public PORT_3 As Byte = 3

	' RailBuzz
	' Private CMD_DELAY As Long = 100
	Private OUTPUT_LEVEL_DEFAULT As Byte = 1

	' Commands
	Public CMD_OUTPUT_LEVEL As Byte = 0x11
	Public CMD_POWER_LEVEL As Byte = 0x10

	' Power Level
	Public POWER_LEVEL_FULL_BACKWARDS As Int = -127
	Public POWER_LEVEL_STOP As Int = 0
	Public POWER_LEVEL_FULL_FORWARDS As Int = 127

	' Speed
	Public SPEED_OFFSET As Int = 51
	Public SPEED_MIN As Int = 0	'51
	Public SPEED_MAX As Int = 127	'100
	Public DIRECTION_STP As Int = 0
	Public DIRECTION_FWD As Int = 1
	Public DIRECTION_BCK As Int = 2

	' Class Vars
	Private mMainpage As B4XMainPage

	' Helper
	Private bc As ByteConverter
End Sub

'Initializes the object.
Public Sub Initialize(mainpage As B4XMainPage)
	mMainpage = mainpage
End Sub

#Region Control
' Set output level = mandatory befor driving motors
' Write 2 bytes:
'	Byte 1 = 0x11
'	Byte 2 = output level with low: 1, medium: 2, high: 3, ludicrous: 4
' level - default 1
Public Sub SetOutputLevel
	Dim cmd() As Byte = Array As Byte(CMD_OUTPUT_LEVEL, OUTPUT_LEVEL_DEFAULT)
	If Logging Then 
		Log($"[SetOutputLevel] cmd=${Convert.HexFromBytes(cmd)}, level=${CMD_OUTPUT_LEVEL}, leveldefault=${OUTPUT_LEVEL_DEFAULT}"$)
	End If
	mMainpage.Write(cmd)
End Sub

' Set power level for a port.
' Write 6 bytes:
'	Byte 1 = 0x10
'	Byte 2 = 7 bit signed channel 1 output value
'	Byte 3 = 7 bit signed channel 2 output value
'	Byte 4 = 7 bit signed channel 3 output value
'	Byte 5 = 7 bit signed channel 4 output value
'	Byte 6 = 0x00
' port - 0-3
' level -127 - 127
Public Sub SetPowerLevel(port As Byte, level As Int)
	' Set mandatory output level
	SetOutputLevel

	' Define the command as byte array
	Dim cmd() As Byte = Array As Byte(CMD_POWER_LEVEL, 0, 0, 0, 0, 0x00)
	If Logging Then
		Log($"[SetPowerLevel] cmd=${Convert.HexFromBytes(cmd)}, port=${port}, level=${level}"$)
	End If

	' Set the port level for bytes 1 (=port 1 with index 0) to 4 (=port 4 with index 3)
	cmd(1 + port) = level
	' Write the command
	mMainpage.Write(cmd)
End Sub

' Stop the motor connected to port.
Public Sub Stop(port As Byte)
	SetPowerLevel(port, POWER_LEVEL_STOP)
End Sub
#End Region

' Get the battery voltage from the notification data.
Public Sub GetBatteryVoltage(data() As Byte) As Float
	ParseNotification(data)
	Return BuWizz2Status.BatteryVoltage
End Sub

#Region Parse Notification Message
' //
' BuWizz2 notification message data 
' //
' Data example:		00 18 52 2B 02 00 00 00 01 18 96 FD 21 FF E2 BD FF 00 00 00
'					0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19
' Data length:		20 bytes
' Byte 0 (1):		Command (0x00)
' Byte 1 (1):		Status flags bit mapped 7-0.
'					7   = unused
'					6   = USB connection status (1=cable connected)
'					5   = Battery charging status (1=battery charging, 0=battery full or not charging)
'					3-4 = Battery level status (0=empty, motors disabled; 1=low; 2=medium; 3=full)
'					2-1 = unused
'					0   = error (overcurrent, overtemperature...)
' Byte 2 (1):		Battery voltage (3 V + value * 0,01 V) - range 3,00 V - 4,27 V. Example: 0x00=3.00 V, 0x7F=4.27 V
' Byte 3 (1):		Output (motor) voltage (4 V + value * 0,05 V) - range 4,00 V - 16,75 V
' Byte 4-7 (4):		Motor currents, 8-Bit value per motor output (value * 0,033 A) - range 0 - 8,5 A
' Byte 8 (1):		Current Power level 0-4:
'					0 = Power disabled (default value after start or BLE disconnect)
'					1 = Slow
'					2 = Normal
'					3 = Fast
'					4 = LDCRS
' Byte 9 (1):		Microcontroller temperature (°C)
' Byte 10-11 (2):	Accelerometer x-axis value (left-aligned 12-Bit signed value, 12 mg/digit)
' Byte 12-13 (2):	Accelerometer y-axis value (left-aligned 12-Bit signed value, 12 mg/digit)
' Byte 14-15 (2):   Accelerometer z-axis value (left-aligned 12-Bit signed value, 12 mg/digit)
' Example <code>
' Callback when data is received from BLE
'Sub ble_NewData(data() As Byte)
'	Log("[ble_NewData] data=", bc.HexFromBytes(data))
'   BuWizz2.ParseNotification(data)
'End Sub
' </code>
Public Sub ParseNotification(data() As Byte) As Boolean
	If Logging Then Log($"[ParseNotification] Data received bytes=${data.length},hex=${bc.HexFromBytes(data)}"$)

	' Check the data length
	If data.Length <> 20 Then
		Log("$[ParseNotification] Invalid data received. Expected 40 bytes. Got ${data.length}"$)
		Return False ' Sanity check
	End If

	' Check command byte
	If data(0) <> 0x00 Then
		Log("$[ParseNotification] Unexpected command byte: ${bc.HexFromBytes(Array As Byte(data(0)))}"$)
		Return False
	End If

	' Byte 0 = Command 0x00 fixed
	' Byte 1 = Status
	BuWizz2Status.StatusFlags = data(1)
	
	' Byte 2 = Battery Voltage
	BuWizz2Status.BatteryVoltage = 3 + (data(2).As(Int) * 0.01)
	If Logging Then Log("$[ParseNotification] BatteryVoltage=${BuWizz2Status.BatteryVoltage}V,hex=${bc.HexFromBytes(Array As Byte(data(2)))}"$)
	
'	' Byte 3 = Output Motor Voltage
'	BuWizz2Status.OutputVoltage = 4 + (data(3).As(UInt) * 0.05)
'	If Logging Then Log("[ParseNotification] OutputVoltage=", BuWizz2Status.OutputVoltage," V", ",hex=",bc.HexFromBytes(Array As Byte(data(3))))
'	
'	' Byte 4 = Motor Current 1
'	BuWizz2Status.Motor1Current = (data(4) * 0.033)
'	If Logging Then Log("[ParseNotification] Motor1Current=", BuWizz2Status.Motor1Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(4))))
'	
'	' Byte 5 = Motor Current 2
'	BuWizz2Status.Motor2Current = (data(5) * 0.033)
'	If Logging Then Log("[ParseNotification] Motor2Current=", BuWizz2Status.Motor2Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(5))))
'	
'	' Byte 6 = Motor Current 3
'	BuWizz2Status.Motor3Current = (data(6) * 0.033)
'	If Logging Then Log("[ParseNotification] Motor3Current=", BuWizz2Status.Motor3Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(6))))
'	
'	' Byte 7 = Motor Current 4
'	BuWizz2Status.Motor4Current = (data(7) * 0.033)
'	If Logging Then Log("[ParseNotification] Motor4Current=", BuWizz2Status.Motor4Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(7))))
'	
'	' Byte 8 = Power Level
'	BuWizz2Status.PowerLevel = data(8)
'	If Logging Then Log("[ParseNotification] PowerLevel=", BuWizz2Status.PowerLevel,"", ",hex=",bc.HexFromBytes(Array As Byte(data(8))))
'	
'	' Byte 9 = MicroController temperature
'	BuWizz2Status.Temperature = data(9)
'	If Logging Then Log("[ParseNotification] Temperature=", BuWizz2Status.Temperature," C", ",hex=",bc.HexFromBytes(Array As Byte(data(9))))
'	
'	' Byte 10,11,12 = AccX,Y,Z
'	BuWizz2Status.AccX = data(10)
'	If Logging Then Log("[ParseNotification] AccX=", BuWizz2Status.AccX,"", ",hex=",bc.HexFromBytes(Array As Byte(data(10))))
'	BuWizz2Status.AccY = data(11)
'	If Logging Then Log("[ParseNotification] AccY=", BuWizz2Status.AccY,"", ",hex=",bc.HexFromBytes(Array As Byte(data(11))))
'	BuWizz2Status.AccZ = data(12)
'	If Logging Then Log("[ParseNotification] AccZ=", BuWizz2Status.AccZ,"", ",hex=",bc.HexFromBytes(Array As Byte(data(12))))

	Return True
End Sub

' Test parsing notification data
Private Sub TestParseNotification	'ignore
	Dim testData() As Byte = Array As Byte( _
        0x00, 0x01, 0xC8, 0x32, 0x10, 0x11, 0x12, 0x13, 0x64, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
	ParseNotification(testData)
End Sub
#End Region
