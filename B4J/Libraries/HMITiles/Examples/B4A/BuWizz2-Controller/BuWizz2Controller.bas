B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' ================================================================
' File:			BuWizz2Controller
' Brief:		Control the BuWizz2 brick using BLE with flag WRITE_WITH_RESPONSE.
' Date:			2026-01-06
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	BleGattManager
' Description:	This class enables to control the BuWizz2 brick:
'				- SetOutputLevel
'				- SetPowerLevel
' ================================================================

Sub Class_Globals
	' Class globals
	Public Debug As Boolean = False

	' BLE
	Public BLE_MAC As String 			= "50:FA:AB:38:A6:1A"						' BuWizz2 MAC address
	Public BLE_DEVICE_NAME As String 	= "BuWizz2"									' Case sensitive

	' BLE Service & Characteristics BuWizz V2
	Public SERVICE_UUID As String 		= "4e050000-74fb-4481-88b3-9919b1676e93"	' BuWizz2 service UUID
	Public CHAR_UUID_RX  As String		= "000092d1-0000-1000-8000-00805f9b34fb" 	' Control characteristic UUID Flags read,notify,write
	Public CHAR_UUID_TX  As String		= "000092d1-0000-1000-8000-00805f9b34fb" 	' Control characteristic UUID Flags read,notify,write

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

	' Class locals
	' Events
	Private mCallback  As Object
	Private mEventName As String
End Sub

'Initializes the object.
Public Sub Initialize(Target As Object, EventName As String)
	' ToLog($"Initialize - target=${Target}, eventname=${EventName}"$)
	mCallback = Target
	mEventName = EventName
End Sub

' Set output level = mandatory befor driving motors
' Write 2 bytes:
'	Byte 1 = 0x11
'	Byte 2 = output level with low: 1, medium: 2, high: 3, ludicrous: 4
' level - default 1
Public Sub SetOutputLevel
	Dim cmd() As Byte = Array As Byte(CMD_OUTPUT_LEVEL, OUTPUT_LEVEL_DEFAULT)
	ToLog($"SetOutputLevel - cmd=${Convert.HexFromBytes(cmd)}, level=${CMD_OUTPUT_LEVEL}, leveldefault=${OUTPUT_LEVEL_DEFAULT}"$)
	CallSubDelayed2(mCallback, mEventName & "_Write", cmd)
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
	ToLog($"SetPowerLevel - cmd=${Convert.HexFromBytes(cmd)}, port=${port}, level=${level}"$)

	' Set the port level for bytes 1 (=port 1 with index 0) to 4 (=port 4 with index 3)
	cmd(1 + port) = level
	' Write the command
	CallSubDelayed2(mCallback, mEventName & "_Write", cmd)
End Sub

' Stop the motor connected to port.
Public Sub Stop(port As Byte)
	SetPowerLevel(port, POWER_LEVEL_STOP)
End Sub

' Helper
Private Sub ToLog(msg As String)
	If Debug Then
		Log($"[BuWizz2Controller] ${msg}"$)
	End If
End Sub
