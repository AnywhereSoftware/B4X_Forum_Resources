B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.3
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
#Region BLE
	' BLE device (ESP32)
	Public BLE_MAC As String 			= "F8:B3:B7:7C:4E:BE"								' Case sensitive, MUST MATCH name defined in B4R
	Public BLE_DEVICE_NAME As String 	= "ESP32BLELED"								' Case sensitive, MUST MATCH name defined in B4R

	' BLE Service & Characteristics
	Public SERVICE_UUID As String 		= "6e400001-b5a3-f393-e0a9-e50e24dcca9e"	' UART
	Public CHAR_UUID_TX As String 		= "6e400002-b5a3-f393-e0a9-e50e24dcca9e"	' Transmit
	Public CHAR_UUID_RX As String 		= "6e400003-b5a3-f393-e0a9-e50e24dcca9e"	' Receive Flags read,notify,write

#End Region

#Region Device IDs
	' Devices (as defined in B4R firmware)
	Public DEV_LED As Byte 				= 0x01
	Public DEV_SYSTEM As Int			= 0xFF
#End Region

#Region Command IDs	
	' Commands (as defined in B4R firmware)
	Public CMD_SET_STATE As Byte 		= 0x01
	Public CMD_GET_STATE As Byte 		= 0x02
	Public CMD_SET_COLOR As Byte 		= 0x01
	Public CMD_GET_COLOR As Byte 		= 0x02
	Public CMD_SET_VALUE As Byte 		= 0x03
	Public CMD_GET_VALUE As Byte 		= 0x04
	Public CMD_CUSTOM_ACTION As Byte	= 0x05
#End Region

#Region Device States
	Public STATE_OFF As Byte 			= 0x00
	Public STATE_ON As Byte 			= 0x01
#End Region
	
#Region Device Actions
	Public ACTION_CLOSE As Byte 		= 0x00
	Public ACTION_OPEN As Byte 			= 0x01
#End Region
End Sub
