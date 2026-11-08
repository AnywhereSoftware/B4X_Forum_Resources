B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Module Header
' LEGOHUBNo4Controller.bas
' Controller for LEGO Powered Up Hub No. 4 (Hub 88009).
' 
' This module implements message handling, motor control, and sensor reading
' using the LEGO Wireless Protocol (LWP3) over BLE. 
' 
' Features:
' - Send motor power commands.
' - Enable color/distance notifications (Color & Distance Sensor 880007 - Detect 6 colors and objects within 5 to 10 cm range)
' - Parse hub feedback and I/O attachment messages.
' 
' Limitations:
' - B4R does not support returning structs or objects.
' - Global Msg* types are updated by Parse functions instead.
' 
' Author: 	Robert W.B. Linn
' Date: 	2025-08-01
' License:	MIT — see LICENSE file.
#End Region

Sub Process_Globals
	' ============================================================
	' BLE UUIDs
	' ============================================================
	Public UUID_SERVICE As String          = "00001623-1212-efde-1623-785feabcd123"
	Public UUID_CHARACTERISTIC As String   = "00001624-1212-efde-1623-785feabcd123"

	' ============================================================
	' LEGO Hub Message Types (LWP3)
	' ============================================================
	Public Const MESSAGE_TYPE_HUB_PROPERTIES         As Byte = 0x01
	Public Const MESSAGE_TYPE_HUB_ACTIONS            As Byte = 0x02
	Public Const MESSAGE_TYPE_HUB_ALERTS             As Byte = 0x03
	Public Const MESSAGE_TYPE_HUB_ATTACHED_IO        As Byte = 0x04
	Public Const MESSAGE_TYPE_GENERIC_ERROR_MESSAGES As Byte = 0x05
	Public Const MESSAGE_TYPE_COMMAND_FEEDBACK       As Byte = 0x82
	Public Const MESSAGE_TYPE_PORT_INFORMATION       As Byte = 0x43
	Public Const MESSAGE_TYPE_PORT_MODE_INFORMATION  As Byte = 0x44
	Public Const MESSAGE_TYPE_PORT_VALUE_SINGLE      As Byte = 0x45
	Public Const MESSAGE_TYPE_PORT_VALUE_COMBINED    As Byte = 0x46
	Public Const MESSAGE_TYPE_PORT_VALUE_SINGLE_MODE As Byte = 0x47
	Public Const MESSAGE_TYPE_PORT_INPUT_FORMAT      As Byte = 0x48
	Public Const MESSAGE_TYPE_PORT_OUTPUT_COMMAND    As Byte = 0x81

	' ============================================================
	' IO Types
	' ============================================================
	Public IO_TYPE_TRAIN_MOTOR As Int         = 2
	Public IO_TYPE_HUB_STATUS_LIGHT As Int    = 23
	Public IO_TYPE_HUB_BATTERY_CURRENT As Int = 21
	Public IO_TYPE_HUB_BATTERY_VOLTAGE As Int = 20

	' ============================================================
	' Ports
	' ============================================================
	Public PORT_A As Byte = 0
	Public PORT_B As Byte = 1

	' ============================================================
	' Parsed Message Storage (Updated by Parse Functions)
	' - Command Feedback 5 bytes
	' - Hub Attached IO 15 bytes
	' ============================================================
	Type TMsgCommandFeedback(DataLen As Byte, HubId As Byte, MessageType As Byte, PortId As Byte, Feedback As Byte)
	Public MsgCommandFeedback As TMsgCommandFeedback
	' Indicator if the command has been successfully issued
	Public COMMAND_FEEDBACK_OK As Byte = 0x0A

	Type TMsgHubAttachedIO(DataLen As Byte, HubId As Byte, MessageType As Byte, PortId As Byte, Event As Byte, _
                           IOTypeId As Int, HWRevMajor As Byte, HWRevMinor As Byte, HWRevBugFix As Byte, HWRevBuildNo As Byte, _
                           SWRevMajor As Byte, SWRevMinor As Byte, SWRevBugFix As Byte, SWRevBuildNo As Byte)
	Public MsgHubAttachedIO As TMsgHubAttachedIO

	' ============================================================
	' Color Names
	' ============================================================
	' Array index = color ID, i.e. 0=None,1=Black...10=Cyan(Light Blue)
	' LEGO Powered Up Color Names (0-10 + 255 for unknown)
	'	-1 = No object
	'	0 = Black (LEGO:26; R:0, G:0, B:0)
	'	1 = Magenta (LEGO:124; R:144, G:31, B:118)
	'	3 = Blue (LEGO:23; R:30, G:90, B:168)
	'	4 = Turquoise (LEGO:322; R:104, G:195, B226)
	'	5 = Green (LEGO:28; R:0, G:133, B:43)
	'	7 = Yellow (LEGO:24; R:250, G:200, B:10)
	'	9 = Red (LEGO:21; R:180, G:0, B:0)
	'	10 = White (LEGO:01; R:244, G:244, B:244)
	Public LEGOColorNames() As String = Array As String( _
	    "Black", _       '0
	    "Magenta", _     '1
	    "N/A", _      	 '2
	    "Blue", _        '3
	    "Turquoise", _   '4
	    "Green", _       '5
	    "N/A", _         '6
	    "Yellow", _      '7
	    "N/A", _         '8
	    "Red", _         '9
	    "White", _       '10
		"none")			 '255

	Public LEGOIoTypeNames() As String = Array As String( _
	    "Unknown", _                               ' 0
	    "Unknown", _                               ' 1
	    "Unknown", _                               ' 2
	    "Unknown", _                               ' 3
	    "Unknown", _                               ' 4
	    "Unknown", _                               ' 5
	    "Unknown", _                               ' 6
	    "Unknown", _                               ' 7
	    "Unknown", _                               ' 8
	    "Unknown", _                               ' 9
	    "Unknown", _                               ' 10
	    "Unknown", _                               ' 11
	    "Unknown", _                               ' 12
	    "Unknown", _                               ' 13
	    "Unknown", _                               ' 14
	    "Unknown", _                               ' 15
	    "Hub (Generic)", _                         ' 16 (0x10)
	    "Unknown", _                               ' 17
	    "Unknown", _                               ' 18
	    "Unknown", _                               ' 19
	    "Internal Motor (Boost Hub motor)", _     ' 20 (0x14)
	    "Train Motor", _                           ' 21 (0x15)
	    "Lights", _                               ' 22 (0x16)
	    "Medium Linear Motor (External)", _       ' 23 (0x17)
	    "Hub (Technic Large Motor)", _             ' 24 (0x18)
	    "Technic Large Motor", _                    ' 25 (0x19)
	    "Technic XL Motor", _                       ' 26 (0x1A)
	    "Technic L Motor", _                        ' 27 (0x1B)
	    "Technic M Motor", _                        ' 28 (0x1C)
	    "Hub (Technic Medium Motor)", _             ' 29 (0x1D)
	    "SPIKE Large Motor", _                      ' 30 (0x1E)
	    "SPIKE Medium Motor", _                     ' 31 (0x1F)
	    "SPIKE Motor", _                            ' 32 (0x20)
	    "Generic Sensor", _                         ' 33 (0x21)
	    "Hub (Generic)", _                          ' 34 (0x22)
	    "Powered Up Sensor", _                      ' 35 (0x23)
	    "Hub (Powered Up Sensor)", _                ' 36 (0x24)
	    "Color & Distance Sensor (88007)", _       ' 37 (0x25)
	    "WeDo 2.0 Tilt Sensor", _                   ' 38 (0x26)
	    "SPIKE Motion/Force Sensor", _              ' 39 (0x27)
	    "SPIKE Distance Sensor", _                   ' 40 (0x28)
	    "Technic Hub", _                            ' 41 (0x29)
	    "SPIKE Hub", _                             ' 42 (0x2A)
	    "Unknown", _                               ' 43
	    "Unknown", _                               ' 44
	    "Unknown", _                               ' 45
	    "SPIKE Color Sensor", _                      ' 46 (0x2E)
	    "SPIKE Ultrasonic Sensor", _                 ' 47 (0x2F)
	    "SPIKE Force Sensor")                    ' 48 (0x30)

	' ============================================================
	' Internal settings
	' ============================================================
	Private COMMAND_DELAY As ULong = 100
	Private OUTPUT_LEVEL_DEFAULT As Byte = 1

	' Commands
	Public COMMAND_OUTPUT_LEVEL As Byte = 0x11

	' Power Levels
	Public POWER_LEVEL_FULL_BACKWARDS As Int = -127
	Public POWER_LEVEL_STOP As Int = 0
	Public POWER_LEVEL_FULL_FORWARDS As Int = 127

	' Distance
	Private DISTANCE_OUT_OF_RANGE As UInt = 9999

	' Set to true only for testing
	Private EnableDebugHex As Boolean = False    

	' Helper
	Private bc As ByteConverter	'ignore
End Sub

#Region Control
' Sets output level (mandatory before driving motors, defaul 1)
' client - BLE client
Public Sub SetOutputLevel(client As BLEClient)
	Log("[SetOutputLevel] -> 1")
	client.Write(Array As Byte(COMMAND_OUTPUT_LEVEL, OUTPUT_LEVEL_DEFAULT))
	Delay(COMMAND_DELAY)
End Sub

' Sets power level for a motor on the given port
' client - BLE client
' port - Port ID (0 = A, 1 = B)
' level - Power (-127..127)
Public Sub SetPowerLevel(client As BLEClient, port As Byte, level As Int)
	Log("[SetPowerLevel] port=", port, " level=", level)
	Dim cmd(8) As Byte = Array As Byte(0x08, 0x00, 0x81, port, 0x11, 0x51, 0x00, level)
	client.Write(cmd)
	Delay(COMMAND_DELAY)
End Sub

' Stops the motor connected to the given port
Public Sub Stop(client As BLEClient, Port As Byte)
	SetPowerLevel(client, Port, POWER_LEVEL_STOP)
End Sub
#End Region

#Region Requests
' Requests a port value (synchronous read)
Public Sub PortValueRequest(client As BLEClient, port As Byte)
	Dim request() As Byte = Array As Byte(0x03, 0x00, 0x21, port)
	client.Write(request)
End Sub
#End Region

#Region Distance Color Sensor
'LEGO Powered Up / LWP3, the Color & Distance Sensor (88007 / 45605) supports several modes:
'- Mode 0x00 = Color
'- Mode 0x01 = Reflection
'- Mode 0x02 = Ambient light
'- Mode 0x08 = Distance

'Reliable Rules
' Distance messages → 8 bytes (Or more)
' - with 0x45 (legacy single) Or 0x47 (single‑mode)
' - Distance = 10‑bit at bytes 4+5 (Or 5+6 For 0x47)
' Color:
' Legacy 0x45 messages (5 bytes):
' - Color ID is always byte 4.
' - Simple, short format For color only.
' Single‑Mode 0x47 messages (8 bytes):
' - Byte 4 = Mode ID
' - Byte 5 = Color ID
' - Remaining bytes are padding/counters.
'
'Everything Else is either command feedback Or hub events.

' Distinguishing Color vs Distance:
' - Color mode → Mode ID = 0x00
' - Distance mode → Mode ID = 0x01
' - Use IsColor And IsDistance To correctly route the message.
		

#Region Distance
' Distance Data Format
' | Byte | Hex | Description                                                                 |
' | ---- | --- | --------------------------------------------------------------------------- |
' | 0    | 08  | **Message length** = 8 bytes (including this byte)                          |
' | 1    | 00  | **Hub ID** = 0 (LEGO hubs always send 0 here For single hub)                |
' | 2    | 45  | **Message Type** = `0x45` → port Value (Single)                             |
' | 3    | 00  | **port ID** = 0 (port A)                                                    |
' | 4    | 00  | **Value LSB** (Low byte of 10‑bit distance)                                 |
' | 5    | 02  | **Value MSB** (High byte of 10‑bit distance)                                |
' | 6    | FF  | **Notification/Checksum/Unused** (varies, often `0xFF` For distance sensor) |
' | 7    | 05  | **Additional status Or padding** (may indicate sensor update counter)       |

' How To read distance
' Distance 10‑bit value = data(4) (LSB) + data(5) (MSB << 8)
' In this Case:
' raw = 0x02 << 8 Or 0x00 = 0x0200 = 512
' distance = 512 & 0x03FF = 512
' So the measured distance is 512 units (LEGO internal scale, roughly mm).
' Notes
' - 0x45 (port Value Single) means legacy notification format For a single port.
' - data(6) And data(7) are sometimes padding Or update counters And can usually be ignored.
' - Newer hubs also send 0x47 (Single Mode) messages which include an explicit Mode ID before the value.

' Enable distance notifications
Public Sub NotifyDistance(client As BLEClient, port As Byte)
	Dim data() As Byte = Array As Byte(0x08, 0x00, 0x41, port, 0x08, 0x64, 0x00, 0x01)
	client.Write(data)
End Sub
	
' Distance = 8-byte message (0x45 legacy or 0x47 single-mode)
Public Sub IsDistance(data() As Byte) As Boolean
    If data.Length >= 8 Then
        Dim msgType As Byte = data(2)
        Return msgType = MESSAGE_TYPE_PORT_VALUE_SINGLE Or msgType = MESSAGE_TYPE_PORT_VALUE_SINGLE_MODE
    End If
    Return False
End Sub

' Extract 10-bit distance (0-1023)
' Return 0-1023 or 9999 in case out of range
Public Sub GetDistance(data() As Byte) As UInt
	If data.Length < 6 Then Return -1
	Dim msgType As Byte = data(2)
	Dim raw As UInt

	If msgType = MESSAGE_TYPE_PORT_VALUE_SINGLE_MODE Then
		raw = Bit.Or(data(5), Bit.ShiftLeft(data(6), 8))
	Else
		raw = Bit.Or(data(4), Bit.ShiftLeft(data(5), 8))
	End If

	' Check raw 16-bit value before masking to 10 bits
	If raw > 1023 Then
		' Log("[GetDistance] Out of Range raw=", raw)
		Return DISTANCE_OUT_OF_RANGE
	End If
	' Clip 10-bit distance and handle overflow
	Return Bit.And(raw, 1023)
End Sub
#End Region

#Region Color
' Color Data Example (legacy 5‑byte message)
' | Byte | Hex | Description                                            |
' | ---- | --- | ------------------------------------------------------ |
' | 0    | 05  | **Message length** = 5 bytes (including this byte)     |
' | 1    | 00  | **Hub ID** = 0 (always 0 For a single hub)             |
' | 2    | 45  | **Message Type** = `0x45` → Port Value (Single)        |
' | 3    | 00  | **Port ID** = 0 (Port A)                               |
' | 4    | 07  | **Color ID** = 7 → Brown (from `LEGOColorNames` Array) |
'
' Color Mapping
' 0 = None      5 = Red
' 1 = Black     6 = White
' 2 = Blue      7 = Brown
' 3 = Green     8 = Orange
' 4 = Yellow    9 = Purple
' 10 = Cyan		255 = Unknown

' Color data Example (Single‑Mode 8‑byte message)
' | Byte | Hex | Description                                          |
' | ---- | --- | ---------------------------------------------------- |
' | 0    | 08  | **Message length** = 8 bytes                         |
' | 1    | 00  | **Hub ID** = 0                                       |
' | 2    | 47  | **Message Type** = `0x47` → Port Value (Single‑Mode) |
' | 3    | 00  | **Port ID** = 0 (Port A)                             |
' | 4    | 00  | **Mode ID** = 0x00 (Color Mode)                      |
' | 5    | 07  | **Color ID** = 7 → Brown                             |
' | 6    | 00  | **Reserved/unused** (can be ignored)                 |
' | 7    | 01  | **Update counter / checksum** (varies)               |

' Enable color notifications
Public Sub NotifyColor(client As BLEClient, port As Byte)
	Dim data() As Byte = Array As Byte(0x08, 0x00, 0x41, port, 0x00, 0x64, 0x00, 0x01)
	client.Write(data)
End Sub

' Color = exactly 5-byte message with 0x45
Public Sub IsColor(data() As Byte) As Boolean
	Return data.Length = 5 And data(2) = MESSAGE_TYPE_PORT_VALUE_SINGLE
End Sub

' For future use if also want to check for color detection for 8‑byte 0x47
'Public Sub IsColor5(data() As Byte) As Boolean
'	Return data.Length = 5 And data(2) = MESSAGE_TYPE_PORT_VALUE_SINGLE
'End Sub
'
'Public Sub IsColor8(data() As Byte) As Boolean
'    If data.Length >= 8 And data(2) = MESSAGE_TYPE_PORT_VALUE_SINGLE_MODE And data(4) = 0x00 Then Return True
'    Return False
'End Sub

' Extract color ID (byte 4)
Public Sub GetColor(data() As Byte) As Byte
	If data.Length < 5 Then Return 0
	Return data(4)
End Sub

' Color name lookup
Public Sub GetColorName(colorId As Byte) As String
	If colorId = 255 Then Return "Unknown"
	If colorId >= 0 And colorId <= 10 Then
		Return LEGOColorNames(colorId)
	Else
		Return "Invalid"
	End If
End Sub
#End Region

#Region Parsers
' Returns the message type from raw data using byte array index 3 (2)
' data() - Notification byte array
Public Sub GetMessageType(data() As Byte) As Byte
	If data.Length >= 3 Then Return data(2)
	Return 0x00
End Sub

' Parse port output command feedback [0x82] (5 bytes)
' Normally with feedback from 1 (one) port the message size is 5 Bytes. 
' If feedback from more ports, the message size is increased 2 bytes For Each additional port.
' Allows users To keep track of one Or more buffering 1-bytes queue And the progress of requested Port Output Command(s) (0x81). 
' Immediate commands discarding the executing And/Or the buffered command(s) are also flagged.
' 0x81 Port Output Command progress And buffering status
' 
' LEGOHUBNo4 notification short are ACK messages for the last command sent — standard behavior.
' LEGOHUBNo4 notification short parse raw data hex string as byte array
' Data example:		05 00 82 00 0A
' 					0  1  2  3  4
' Data length:		5 bytes ith Common Header of 3 Bytes
' Byte 0 (1):		Data length = 5 bytes (excluding this byte)
' Byte 1 (1):		Hub ID (not used by LEGO)
' Byte 2 (1):		Message Type. 0x82 = port output command feedback. 0x05 = HUB generic error.
' Byte 3 (1):		Port ID. Port 0x00 = port A, 0x01 = port B
' Byte 4 (1):		Feedback. 0x0A = Command Completed
' 
' Data example if no motor or sensor is connected to the given port, i.e. 1 in this case.
' 05 00 05 81 06
' The message type (byte 3) is 0x05 which means HUB generic error.
' Data example sending command to port 1 (B)
' 05 00 82 01 0A
'
' return - True if parsed successfully
Public Sub ParseRawDataCommandFeedback(data() As Byte) As Boolean
	If data.Length < 5 Then Return False
	MsgCommandFeedback.DataLen = data(0)
	MsgCommandFeedback.HubId = data(1)
	MsgCommandFeedback.MessageType = data(2)
	MsgCommandFeedback.PortId = data(3)
	MsgCommandFeedback.Feedback = data(4)
	Return True
End Sub

' Parse Hub Attached I/O message [0x04] (15 bytes)
' LEGOHUBNo4 notification long parse raw data hex string as byte array
' Data example:		0F 00 04 32 01 17 00 00 00 00 10 00 00 00 10
' 					0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
' Payload:                         0  1  2  3  4  5  6  7  8  9
' Data length:		15 bytes (0x0F).
' Byte 0 (1):		Message data length (0x0F is 15 bytes).
' Byte 1 (1):		Hub ID (Always 0x00 for single-hub use).
' Byte 2 (1):		Message Type (0x04 is port value single Notification). See below table. 
' Byte 3 (1):		Port ID (0x32) = 50 (decimal) Port A = Motor Port (could also be 0x3C for a sensor). 
' Byte 4 (1):		IO de- and attachment events (0x00 - 0x02)
' Byte 5-6 (2):		IO type ID. Only byte 5 is used, byte 6 is 0. TRAIN_MOTOR=2,HUB_STATUS_LIGHT=23,HUB_BATTERY_CURRENT=21,HUB_BATTERY_VOLTAGE=20
' Byte 7 (1):		Hardware Revision Major
' Byte 8 (1):		Hardware Revision Mainor
' Byte 9 (1):		Hardware Revision BugFix
' Byte 10 (1):		Hardware Revision Build No
' Byte 11 (1):		Software Revision Major
' Byte 12 (1):		Software Revision Minor
' Byte 13 (1):		Software Revision BugFix
' Byte 14(1):		Software Revision Build No
' 
' Message Type Code Description
' 0x01	Hub Properties	
' 0x04	Hub Actions / Port Input Format	
' 0x45	Port Value (single)	
' 0x82	Port Output Command Feedback
'
' return - True if parsed successfully
Public Sub ParseRawDataHubAttachedIO(data() As Byte) As Boolean
	If data.Length < 15 Then Return False
	MsgHubAttachedIO.DataLen = data(0)
	MsgHubAttachedIO.HubId = data(1)
	MsgHubAttachedIO.MessageType = data(2)
	MsgHubAttachedIO.PortId = data(3)
	MsgHubAttachedIO.Event = data(4)
	MsgHubAttachedIO.IOTypeId = data(5)
	MsgHubAttachedIO.HWRevMajor = data(7)
	MsgHubAttachedIO.HWRevMinor = data(8)
	MsgHubAttachedIO.HWRevBugFix = data(9)
	MsgHubAttachedIO.HWRevBuildNo = data(10)
	MsgHubAttachedIO.SWRevMajor = data(11)
	MsgHubAttachedIO.SWRevMinor = data(12)
	MsgHubAttachedIO.SWRevBugFix = data(13)
	MsgHubAttachedIO.SWRevBuildNo = data(14)
	Return True
End Sub

'	Dim id As Int = 37 ' example IOTypeID from BLE event
Public Sub GetIOTypeName(id As Byte) As String
	Dim result As String
	If id >= 0 And id < LEGOIoTypeNames.Length Then
    	result = LEGOIoTypeNames(id)
	Else
    	result = "Unknown"
	End If
	Return result
End Sub
#End Region

#Region Callback Logger
' ----------------------------------------------------------
' LEGO Hub Notification Message Logger
' Handles all incoming BLE notifications from the LEGO Hub.
'
' Supports:
'   - Distance (Mode 0x01)
'   - Color (Mode 0x00)
'   - Port Command Feedback (0x82)
'   - Hub Attached I/O events (0x04)
'
' Usage example in Client_NewData:
'   Sub Client_NewData(data() As Byte)
'       LEGOHUBNo4Controller.MessageLogger(data)
'   End Sub
' ----------------------------------------------------------
Public Sub MessageLogger(data() As Byte)
	Dim msgType As Byte = GetMessageType(data)
    
	' Optional debug logging
	If EnableDebugHex Then
		Log("[Client_NewData] len=", data.Length)
		Log("[Client_NewData] raw=", bc.HexFromBytes(data))
	End If

	Select msgType

		' ===== Sensor Data (Distance / Color) =====
		Case MESSAGE_TYPE_PORT_VALUE_SINGLE, _
             MESSAGE_TYPE_PORT_VALUE_SINGLE_MODE

			' Unified raw log for debugging
			Log("[Sensor] raw=", BytesToHex(data), ", length=", data.length)

			' --- Distance detection (Mode 0x01) ---
			If IsDistance(data) Then
				Dim dist As UInt = GetDistance(data)
				If dist == DISTANCE_OUT_OF_RANGE Then
					Log("[Distance] Out of Range")
				Else
					Log("[Distance] dist=", dist, " units")
				End If
			End If

			' --- Color detection (Mode 0x00) ---
			If IsColor(data) Then
				Dim color As Byte = GetColor(data)
				Log("[Color] color=", color, " / ", GetColorName(color))
			End If

			' ===== Port Command Feedback (0x82) =====
		Case MESSAGE_TYPE_COMMAND_FEEDBACK
			If ParseRawDataCommandFeedback(data) Then
				Log("[CommandFeedback] hubid=",    OneByteToHex(MsgCommandFeedback.HubId), _
                    " portid=",   OneByteToHex(MsgCommandFeedback.PortId), _
                    " feedback=", OneByteToHex(MsgCommandFeedback.Feedback), _
                    " status=", IIf(MsgCommandFeedback.Feedback == COMMAND_FEEDBACK_OK, "OK", "ERROR"))
			End If

			' ===== Hub Attached I/O (0x04) =====
		Case MESSAGE_TYPE_HUB_ATTACHED_IO
			If ParseRawDataHubAttachedIO(data) Then
				Log("[HubAttachedIO] event=",      OneByteToHex(MsgHubAttachedIO.Event), _
                    " iotypeid=",  MsgHubAttachedIO.IOTypeId, " ", GetIOTypeName(MsgHubAttachedIO.IOTypeId), _
                    " hwrev=", OneByteToHex(MsgHubAttachedIO.HWRevMajor), ".", _
                               OneByteToHex(MsgHubAttachedIO.HWRevMinor))
			End If

			' ===== Unknown / Generic Error =====
		Case Else
			Log("[Unknown] msgType=", OneByteToHex(msgType), _
                " IsError=", IIf(msgType == MESSAGE_TYPE_GENERIC_ERROR_MESSAGES, "YES", "NO"))
	End Select
End Sub
#End Region

#Region Helper
' Convert single byte to HEX string.
Public Sub OneByteToHex(b As Byte) As String
	Return bc.HexFromBytes(Array As Byte(b))
End Sub

' Convert byte array to string.
Public Sub BytesToHex(b() As Byte) As String
	Return bc.HexFromBytes(b)
End Sub
#End Region
