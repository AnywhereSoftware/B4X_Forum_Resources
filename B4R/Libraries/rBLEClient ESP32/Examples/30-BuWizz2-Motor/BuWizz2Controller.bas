B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Module Header
' File:			BuWizz2Controller.bas
' Project:		rBLEClient
' Brief:		BuWizz2 example for the B4R Library rBLEClient.
'				BuWizz 2.0 Ludicrous (http://buwizz.com/shop/1-buwizz-2/) is a remote control & battery in one brick, compatible with all LEGO® Power Functions motors and lights.
'				Run a LEGO® Power Functions motor connected to port 1 of the BuWizz2 brick.
'				Connection is made using the brick MAC address.
'				Handle notifications with the event NewData
'				BLE name BuWizz with alias BuWizz2. If brick is turned on, the green light flashed. When connected the green light is in steady state
'
' Hints:		If not connected first time, then try again. It happens that in cases 1 or 2 tries are required.
'
' Motor Speed:	0x81 (-127): Full backwards, 0x00 (0): Stop, 0x7F (127): Full forwards
#End Region

Sub Process_Globals
	
	Public Logging As Boolean = False
	
	' UUIDs
	Public UUID_SERVICE As String 			= "4e050000-74fb-4481-88b3-9919b1676e93"	' BuWizz2 service UUID
	Public UUID_CHARACTERISTIC  As String	= "000092d1-0000-1000-8000-00805f9b34fb" 	' Control characteristic UUID
	
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

	Private CMD_DELAY As ULong = 100
	Private OUTPUT_LEVEL_DEFAULT As Byte = 1

	' Commands
	Public CMD_OUTPUT_LEVEL As Byte = 0x11
	Public CMD_POWER_LEVEL As Byte = 0x10

	' Power Level
	Public POWER_LEVEL_FULL_BACKWARDS As Int = -127
	Public POWER_LEVEL_STOP As Int = 0
	Public POWER_LEVEL_FULL_FORWARDS As Int = 127

	' Helper
	Private bc As ByteConverter
End Sub

#Region Control
' Set output level = mandatory befor driving motors
' level - default 1
Public Sub SetOutputLevel(client As BLEClient)
	If Logging Then Log("[SetOutputLevel] Set output level to 1 with command 0x11")
	client.Write(Array As Byte(CMD_OUTPUT_LEVEL, OUTPUT_LEVEL_DEFAULT))
	Delay(CMD_DELAY)
End Sub

' Set power level for a port.
' port - 0-3
' level -127 - 127
Public Sub SetPowerLevel(client As BLEClient, port As Byte, level As Int)
	If Logging Then Log("[SetPowerLevel] Set port ", port, " to level ", level)

	' Set mandatory output level
	SetOutputLevel(client)

	' Define the command as byte array
	Dim CMD() As Byte = Array As Byte(CMD_POWER_LEVEL, 0, 0, 0, 0, 0x00)
	' Set the port level for bytes 1 (=port 1 with index 0) to 4 (=port 4 with index 3)
	CMD(1 + port) = level
	' Write the command
	client.Write(CMD)
	Delay(CMD_DELAY)
End Sub

' Stop the motor connected to port.
Public Sub Stop(client As BLEClient, port As Byte)
	SetPowerLevel(client, port, POWER_LEVEL_STOP)
End Sub
#End Region

' Get the battery voltage from the notification data.
Public Sub GetBatteryVoltage(data() As Byte) As Float
	ParseNotification(data)
	Delay(100)
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
	If Logging Then Log("[ParseNotification] Data received bytes=", data.length,",hex=",bc.HexFromBytes(data))

	' Check the data length
	If data.Length <> 20 Then
		Log("[ParseNotification] Invalid data received. Expected 40 bytes. Got ", data.length)
		Return False ' Sanity check
	End If

	' Check command byte
	If data(0) <> 0x00 Then
		Log("[ParseNotification] Unexpected command byte: ", bc.HexFromBytes(Array As Byte(data(0))))
		Return False
	End If

	' Byte 0 = Command 0x00 fixed
	' Byte 1 = Status
	BuWizz2Status.StatusFlags = data(1)
	
	' Byte 2 = Battery Voltage
	BuWizz2Status.BatteryVoltage = 3 + (data(2).As(UInt) * 0.01)
	If Logging Then Log("[ParseNotification] BatteryVoltage=", BuWizz2Status.BatteryVoltage," V", ",hex=",bc.HexFromBytes(Array As Byte(data(2))))
	
	' Byte 3 = Output Motor Voltage
	BuWizz2Status.OutputVoltage = 4 + (data(3).As(UInt) * 0.05)
	If Logging Then Log("[ParseNotification] OutputVoltage=", BuWizz2Status.OutputVoltage," V", ",hex=",bc.HexFromBytes(Array As Byte(data(3))))
	
	' Byte 4 = Motor Current 1
	BuWizz2Status.Motor1Current = (data(4) * 0.033)
	If Logging Then Log("[ParseNotification] Motor1Current=", BuWizz2Status.Motor1Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(4))))
	
	' Byte 5 = Motor Current 2
	BuWizz2Status.Motor2Current = (data(5) * 0.033)
	If Logging Then Log("[ParseNotification] Motor2Current=", BuWizz2Status.Motor2Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(5))))
	
	' Byte 6 = Motor Current 3
	BuWizz2Status.Motor3Current = (data(6) * 0.033)
	If Logging Then Log("[ParseNotification] Motor3Current=", BuWizz2Status.Motor3Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(6))))
	
	' Byte 7 = Motor Current 4
	BuWizz2Status.Motor4Current = (data(7) * 0.033)
	If Logging Then Log("[ParseNotification] Motor4Current=", BuWizz2Status.Motor4Current," A", ",hex=",bc.HexFromBytes(Array As Byte(data(7))))
	
	' Byte 8 = Power Level
	BuWizz2Status.PowerLevel = data(8)
	If Logging Then Log("[ParseNotification] PowerLevel=", BuWizz2Status.PowerLevel,"", ",hex=",bc.HexFromBytes(Array As Byte(data(8))))
	
	' Byte 9 = MicroController temperature
	BuWizz2Status.Temperature = data(9)
	If Logging Then Log("[ParseNotification] Temperature=", BuWizz2Status.Temperature," C", ",hex=",bc.HexFromBytes(Array As Byte(data(9))))
	
	' Byte 10,11,12 = AccX,Y,Z
	BuWizz2Status.AccX = data(10)
	If Logging Then Log("[ParseNotification] AccX=", BuWizz2Status.AccX,"", ",hex=",bc.HexFromBytes(Array As Byte(data(10))))
	BuWizz2Status.AccY = data(11)
	If Logging Then Log("[ParseNotification] AccY=", BuWizz2Status.AccY,"", ",hex=",bc.HexFromBytes(Array As Byte(data(11))))
	BuWizz2Status.AccZ = data(12)
	If Logging Then Log("[ParseNotification] AccZ=", BuWizz2Status.AccZ,"", ",hex=",bc.HexFromBytes(Array As Byte(data(12))))

	Return True
End Sub

' Test parsing notification data
Private Sub TestParseNotification	'ignore
	Dim testData() As Byte = Array As Byte( _
        0x00, 0x01, 0xC8, 0x32, 0x10, 0x11, 0x12, 0x13, 0x64, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
	ParseNotification(testData)
End Sub
#End Region

