B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Module Header
' ================================================================
' File:         CommBLE.bas
' Project:      make-homekit32
' Brief:        Handle BLE communication. BLE sevice name HomeKit32.
'				UART service & characteristics.
' Date:         2025-12-06
' Author:       Robert W.W. Linn (c) 2025 MIT
' Dependencies: rWiFiManager, rBLEServer, rGlobalStoreEx
' Description:	Communication layer for message routing via MQTT.
' ================================================================
#End Region

Private Sub Process_Globals
	
	' Devices
	Public DEV_LED As Byte 				= 0x01
	Public DEV_SYSTEM As Byte			= 0xFF
	
	' Commands
	Public CMD_SET_STATE As Byte 		= 0x01
	Public CMD_GET_STATE As Byte 		= 0x02
	Public CMD_SET_COLOR As Byte 		= 0x01
	Public CMD_GET_COLOR As Byte 		= 0x02
	Public CMD_SET_VALUE As Byte 		= 0x03
	Public CMD_GET_VALUE As Byte 		= 0x04
	Public CMD_CUSTOM_ACTION As Byte	= 0x05
	
	' BLE ESP32 Plus BLE Peripheral + GATT Server
	Private BLE_SERVER_NAME As String 	= "ESP32BLELED"	'ignore
	Private BLEServer As BLEServer						'ignore
	Private MTUSize As UInt = BLEServer.MTU_SIZE_MIN	'ignore
End Sub

' Initialize
' Initializes BLE
Public Sub Initialize
	Log("[CommBLE.Initialize]")
	BLEServer.Initialize(BLE_SERVER_NAME, "BLEServer_NewData", "BLEServer_Error", MTUSize)
	Log("[CommBLE.Initialize] Done, mtusize=", MTUSize)
End Sub

' Handle new data received from connected client.
' Data format: [DeviceID][Command][Payload...]
' Parameters:
' 	buffer - Byte array holding the data send by the client
Private Sub BLEServer_NewData(buffer() As Byte)
	Log("[CommBLE.BLEServer_NewData] buffer HEX=", Convert.BytesToHex(buffer))

	' Check buffer lenght. Expect at least 2.
	If buffer.Length < 2 Then Return
	
	' Dispatch to handler
	BLEDispatch(buffer)
End Sub

 'Handle BLE server error.
' Log the error to the B4R IDE, but could also use an LED
' Parameters:
'	code - BLE server error code
Private Sub BLEServer_Error(code As Byte)
	Log("[CommBLE.BLEServer_Error] code=",code)
	Select code
		Case BLEServer.WARNING_INVALID_MTU
			Log("[CommBLE.BLEServer_Error][WARNING] Initialize MTU out of range 23-512, default is set (23).")
		Case BLEServer.ERROR_INVALID_CHARACTERISTIC
			Log("[CommBLE.BLEServer_Error][ERROR] Write failed: No valid characteristic.")
		Case BLEServer.ERROR_EMPTY_DATA
			Log("[CommBLE.BLEServer_Error][ERROR] Write failed: No data.")
	End Select
End Sub

' Write data to the connected client.
' Parameters:
' 	data - Byte array containing data fo the connected client
Public Sub BLEServer_Write(data() As Byte)
	If data == Null Then
		Log("[ERROR][CommBLE.BLEServer_Write] No data.")
		Return
	End If
	Log("[CommBLE.BLEServer_Write] data=", Convert.ByteConv.HexFromBytes(data))
	BLEServer.Write(data)
End Sub

' Dispatch BLE message to the relevant device handler.
' [DeviceID][CommandID][Data...]
' Notes:
'	Buttons not used - see MenuHandler
' Parameters:
'	deviceid - Byte Device ID as defined in the constants.
Private Sub BLEDispatch(payload() As Byte)
	' Get the device id
	Dim deviceid As Byte = payload(0)

	Log("[CommBLE.BLEDispatch] deviceid=",deviceid)
	Select deviceid
		Case 0
			' Reserved
		Case DEV_LED
			DevLED.ProcessBLE(payload)
		Case DEV_SYSTEM
			' DevSystem.ProcessBLE(GlobalStoreHandler.Index)
		Case Else
			'
	End Select
End Sub
