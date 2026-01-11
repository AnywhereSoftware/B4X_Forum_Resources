B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Module Header
' ================================================================
' File:        	DevLED.bas
' Project:     	ESP32BLELED
' Brief:       	Set/Get the state of the led ON or OFF.
' Date:        	2025-12-31
' Author:      	Robert W.B. Linn (c) 2025 MIT
' Description:	See brief.
' DeviceID: 0x01
' Sets the state to on or off (Command 0x01).
' 	Length: 3 Bytes
' 	Byte 0 Device:	0x01
' 	Byte 1 Command:	0x01 > Set
' 	Byte 2 State:	0x01 > ON or 0x00 > OFF
'	Example: Set ON = 010101
'
' Get the state (Command 0x02)
' 	Length: 2 Bytes
' 	Byte 0 Device:	0x01
' 	Byte 1 Command:	0x02 > Get
'	Returns Byte 0=ON, 1=ON
'	Example Get State = 0102 which returns like 010201 (last byte holds LED state 0 (OFF), 1 (ON).
' Hardware:		DFRobot Digital Green LED Module V2.
' ================================================================
#End Region

Private Sub Process_Globals
	Private Led As Pin
End Sub

' Initialize
' Initializes the module.
' Parameters:
'   pinnr - GPIO pin number
Public Sub Initialize(pinnr As Byte)
	Led.Initialize(pinnr, Led.MODE_OUTPUT)
	Led.DigitalWrite(False)
	Log("[DevLED.Initialize][I] OK, pin=", pinnr)
End Sub

' ------------------------------------------------
' Core hardware control (always compiled)
' ------------------------------------------------
#Region Device Control
' GetState
' Reads the current digital value.
' Parameters:
'   storeindex - Index in the global store buffer
' Returns:
'   Boolean - True if on, False otherwise
Public Sub Get As Boolean
	Return Led.DigitalRead
End Sub

' SetState
' Sets the state to on or off.
' Parameters:
'   state - Boolean.
Public Sub Set(state As Boolean)
	Led.DigitalWrite(state)
End Sub

' SetPWM
' Sets the PWM value (analog).
' Parameters:
'   value - UInt 0-255
Public Sub SetPWM(value As UInt)
	Led.AnalogWrite(value)
End Sub

' Toggle
' Toggle button state to on or off.
Public Sub Toggle()
	Dim newstate As Boolean = Not(Get)
	Set(newstate)
	Log("[DevLED.Toggle][I] newstate=", newstate)
End Sub
#End Region

' ------------------------------------------------
' BLE integration 
' ------------------------------------------------
#Region BLE Control
' ProcessBLE
' DeviceID: 0x01
' Sets the state to on or off (Command 0x01).
' 	Length: 3 Bytes
' 	Byte 0 Device:	0x01
' 	Byte 1 Command:	0x01 > Set
' 	Byte 2 State:	0x01 > ON or 0x00 > OFF
'	Example: Set ON = 010101
'
' Get the state (Command 0x02)
' 	Length: 2 Bytes
' 	Byte 0 Device:	0x01
' 	Byte 1 Command:	0x02 > Get
'	Returns Byte 0=ON, 1=ON
'	Example Get State = 0102 which returns like 010201 (last byte holds LED state 0 (OFF), 1 (ON).
'
' Parameters:
'   payload() - Payload array byte buffer.
Public Sub ProcessBLE(payload() As Byte)
	Log("[DevLED.ProcessBLE] payload=", Convert.BytesToHex(payload))
	
	Dim command As Byte = payload(1)
	Select command
		Case CommBLE.CMD_SET_STATE
			Dim value As Byte = payload(2)
			Set(IIf(value == 1, True, False))
			WriteToBLE(command, value)
		Case CommBLE.CMD_GET_STATE
			Dim state As Byte = IIf(Get, 1, 0)
			WriteToBLE(command, state)
	End Select
End Sub

' WriteToBLE
' Write to BLE the state.
' Parameters:
'	state - Byte
Public Sub WriteToBLE(command As Byte, state As Byte)
	Dim payload() As Byte = Array As Byte(CommBLE.DEV_LED, command, state)
	CommBLE.BLEServer_Write(payload)
	Log("[DevLED.WriteToBLE] payload=", Convert.BytesToHex(payload))
End Sub
#End Region
