B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' Project: 		BLEGeekServo
' Brief:		Example B4XPages application for the rESP32Servo library.
' Date:			2026-04-13
' Author:		Robert W.B. Linn (c) 2026 MIT
' Description:	Set a GeekServo position to open (90°) or close (135°) via BLE.
' Depends on:	Bleak, HMITiles, ByteConverter
' ================================================================

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

Sub Class_Globals
	Private Const VERSION 		As String = "BLEGeekServo v20260413"
	Private ABOUT 				As String = $"rESP32Servo (c) 2026 Robert W.B. Linn - MIT"$

	' UI
	Private xui 				As XUI
	Private Root 				As B4XView
	Private TileButtonConnect 	As HMITileButton
	Private TileButtonOpen 		As HMITileButton
	Private TileButtonClose 	As HMITileButton
	Private TileEventViewer 	As HMITileEventViewer
	Private LabelAbout 			As B4XView

	' BLE
	Private BleClient 			As BleClientPy
	Private IsConnected 		As Boolean

	' Device
	' BLE device (ESP32)
	Public BLE_MAC 				As String = "80:F3:DA:4C:36:7A"						
	Public BLE_DEVICE_NAME 		As String = "BLEGeekServo"							' Case sensitive, MUST MATCH name defined in B4R

	' BLE Service & Characteristics
	Public SERVICE_UUID 		As String = "12345678-1234-1234-1234-1234567890ab"	' UART
	Public CHAR_UUID_TX 		As String = "abcd1234-5678-1234-5678-1234567890ab"	' Transmit
	Public CHAR_UUID_RX 		As String = "abcd1234-5678-1234-5678-1234567890ab"	' Receive Flags read,notify,write

	' BLE
	' Frame
	Private FRAME_HEADER 		As Byte = 0x19
	Private FRAME_FOOTER 		As Byte = 0x58
	Private DEVICE_ADDRESS 		As Byte = 0x12
	Private SERVO_CMD_ANGLE 	As Byte = 0x05
	' Servo position
	Private SERVO_ANGLE_OPEN	As Byte = 0x5A  '# DEC 90
	Private SERVO_ANGLE_CLOSE 	As Byte = 0x87	'# DEC 135
	' Commands - 5-Byte Frame
	Private CMD_OPEN() 			As Byte = Array As Byte(FRAME_HEADER, DEVICE_ADDRESS, SERVO_CMD_ANGLE, SERVO_ANGLE_OPEN, FRAME_FOOTER)
	Private CMD_CLOSE() 		As Byte = Array As Byte (FRAME_HEADER, DEVICE_ADDRESS, SERVO_CMD_ANGLE, SERVO_ANGLE_CLOSE, FRAME_FOOTER)

	' Helper
	Dim bc As ByteConverter
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	' UI - additional settings
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	B4XPages.SetTitle(Me, $"${VERSION} (B4J)"$)
	B4XPages.GetNativeParent(Me).Resizable = False
	LabelAbout.Text = ABOUT

	' UI - CustomView require short sleep
	Sleep(1)
	' Add customviews
	SetTilesInitialState
	
	' Add info to the event log
	TileEventViewer.Insert($"[B4XPage_Created] ${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	
	' BLE client init objects PyBridge & Bleak
	BleClient.Initialize(Me, "Ble", BLE_MAC, SERVICE_UUID, CHAR_UUID_RX, CHAR_UUID_TX)
	Wait For (BleClient.Start) complete (result As Boolean)
	If result Then
		TileEventViewer.Insert($"[B4XPage_Created] PyBridge started, BLE initialized"$, HMITileUtils.EVENT_LEVEL_INFO)
		Sleep(1)
		TileButtonConnect_Click
	Else
		TileEventViewer.Insert($"[B4XPage_Created] Failed to start the PyBridge initialize BLE"$, HMITileUtils.EVENT_LEVEL_ALARM)
	End If
End Sub

Private Sub B4XPage_Background
	If BleClient.IsConnected Then
		Log($"[B4XPage_Background] Calling BleClient.Disconnect"$)
		BleClient.Disconnect
	End If
End Sub

' ================================================================
' UI
' ================================================================
#Region UI
' SetTilesInitialState
' Set all tiles to its initial state.
' The string "--" indicates, no value received.
Private Sub SetTilesInitialState
	TileButtonConnect.SetStateFontFontAwesome
	TileButtonConnect.State = IsConnected
	TileButtonConnectUpdate(IsConnected)
	TileButtonOpen.State = False
	TileButtonClose.State = False
	TileButtonClose.SetAlarm("Close")
End Sub

' TileButtonConnect_Click
' Connect or disconnect from the BLE device.
Private Sub TileButtonConnect_Click
	' Connect
	If Not(IsConnected) Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect] Connecting to ${BLE_MAC}"$, HMITileUtils.EVENT_LEVEL_INFO)
		' Scan and connect > see event handlebleconnect
		Wait For (BleClient.Scan) Complete (Success As Boolean)
		If Not(Success) Then
			TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_ALARM)
		End If
		Return		
	End If

	' Disconnect
	If IsConnected Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect] Disconnecting from ${BLE_MAC}"$, HMITileUtils.EVENT_LEVEL_WARNING)
		' Disconnect > see event PyBridgeDisconnected
		Wait For(BleClient.Disconnect) Complete (Success As Boolean)
		If Not(Success) Then
			TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_ALARM)
		End If
		Return	
	End If
End Sub

' Update the button UI color & text.
Private Sub TileButtonConnectUpdate(state As Boolean)
	If Not(TileButtonConnect.IsInitialized) Then Return
	TileButtonConnect.StateText = IIf(state, Chr(0xF0C1), Chr(0xF127))
End Sub

Private Sub TileButtonOpen_Click
	BleWrite(CMD_OPEN)
	TileEventViewer.Insert($"[TileButtonOpen] Set ${bc.HexFromBytes(CMD_OPEN)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileButtonClose_Click
	BleWrite(CMD_CLOSE)
	TileEventViewer.Insert($"[TileButtonClose] Set ${bc.HexFromBytes(CMD_OPEN)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileEventViewer_ItemClick (Index As Int, Value As Object)
	Log($"[TileEventViewer] index=${Index}, value=${Value}"$)
End Sub
#End Region

' ================================================================
' PyBridge API
' ================================================================
#Region PyBridgeAPI
' These subs are triggered by the BLEMgr pybridge events
Public Sub PyBridgeDisconnected
	IsConnected = False
	' TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_WARNING)
	TileButtonConnectUpdate(IsConnected)
	SetTilesInitialState
End Sub
#End Region

' ================================================================
' PyBridge LifeCycle Events
' ================================================================
#Region PyBridgeLifeCycleEvents
' Ble_PyBridgeStarted
Private Sub Ble_PyBridgeStarted
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' Ble_PyBridgeStartFailed
Private Sub Ble_PyBridgeStartFailed
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_WARNING)
End Sub

' Ble_PyDisconnected
Private Sub Ble_PyDisconnected
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_WARNING)
End Sub

'' Ble_PyBridgeKillProcess
'Private Sub Ble_PyBridgeKillProcess
'	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_INFO)
'End Sub
#End Region

' ================================================================
' BLE LifeCycle Events
' ================================================================
#Region BleLifeCycleEvents
' Ble_Connected
Private Sub Ble_Connected
	IsConnected = True
	TileButtonConnectUpdate(IsConnected)
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' Ble_Disconnect
Private Sub Ble_Disconnected
	IsConnected = False
	TileButtonConnectUpdate(IsConnected)
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_WARNING)
End Sub

' Ble_ConnectionFailed 
Private Sub Ble_ConnectionFailed
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_WARNING)
End Sub

' Ble_DeviceNotFound
Private Sub Ble_DeviceNotFound
	IsConnected = False
	TileButtonConnect.State = IsConnected
	TileButtonConnectUpdate(IsConnected)
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_WARNING)
End Sub
#End Region

' ================================================================
' BLE Error Events (one generic event for PyBridge & Ble)
' ================================================================
#Region BleErrorEvents
' Ble_Error
Private Sub Ble_Error
	TileEventViewer.Insert(BleClient.LastMsg, HMITileUtils.EVENT_LEVEL_WARNING)
End Sub
#End Region

' ================================================================
' BLE Data Events
' ================================================================
#Region BleDataEvents
' Ble_CharNotify
' Process the data received from BLE notify.
' Get the device id as first byte and then parse the data according device byte pattern.
' Parameters:
'	data Byte Array - Response from the BLE device
Private Sub Ble_CharNotify(payload() As Byte)
	Dim item As String = $"[Ble_CharNotify] value=${bc.HexFromBytes(payload)}"$
	TileEventViewer.Insert(item, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region

' ================================================================
' BLE Write
' ================================================================
#Region BleWrite
' Ble_Write
' Write data to the connected device
' Turn ESP32 LED ON: send 3 bytes 010101 (deviceid, commandid, state)
' Turn ESP32 LED OFF: send 3 bytes 010100 (deviceid, commandid, state)
' Request ESP32 LED STATE: send 2 bytes 0102 (deviceid, commandid), ESP32 returns 3 bytes: 010201 (deviceid, commandid, state 00 or 01).
Private Sub BleWrite(data() As Byte)
	If BleClient.IsConnected Then
		BleClient.Write(data)		
	End If
End Sub
#End Region

' ================================================================
' Helper
' ================================================================
#Region Helper
Public Sub SetStateTextOnOff(state As Boolean) As String
	Return IIf(state, "ON", "OFF")
End Sub
#End Region
