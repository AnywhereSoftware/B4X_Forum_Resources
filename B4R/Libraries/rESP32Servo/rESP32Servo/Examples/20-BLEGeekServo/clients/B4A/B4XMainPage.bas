B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Class Header
' ================================================================
' Project: 		BLEGeekServo
' Brief:		Example B4XPages application for the rESP32Servo library.
' Date:			2026-04-13
' Author:		Robert W.B. Linn (c) 2026 MIT
' Description:	Set a GeekServo position to open (90°) or close (135°) via BLE.
' Depends on:	Bleak, HMITiles, ByteConverter
' Software: 	B4A 13.40 (64 bit), Java JDK 19, Android Platform Tools 36.
' Libraries:	Phone 2.60, RunTimePermissions 1.20, HMITiles 1.43, ByteConverter 1.10
' ================================================================
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Sub Class_Globals
	Private Const VERSION 		As String = "BLEGeekServo v20260413"
	Private ABOUT 				As String = $"rESP32Servo (c) 2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private Root 				As B4XView
	Private xui 				As XUI
	Private TileButtonConnect 	As HMITileButton
	Private TileButtonOpen 		As HMITileButton
	Private TileButtonClose 	As HMITileButton
	Private TileEventViewer 	As HMITileEventViewer
	Private LabelAbout 			As B4XView

	' Device
	Private Ble As BleClient
	Private IsConnected As Boolean = False
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

#Region B4XPages
Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("mainpage")

	' UI
	B4XPages.SetTitle(Me, VERSION)
	LabelAbout.Text = ABOUT
	LabelAbout.TextColor = HMITileUtils.COLOR_TEXT_WARNING

	' UI - CustomView require short sleep
	Sleep(1)
	' Add customviews
	SetTilesInitialState
	
	' Add info to the event log
	TileEventViewer.Insert($"${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	
	' BLE
	Ble.Initialize(Me, "BLE")
	Ble.SetWriteMode(Ble.WRITE_NO_RESPONSE)
	Ble.SetMTUSize(128)
	TileEventViewer.Insert($"MTU size changed to ${Ble.GetMTUSize}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub B4XPage_Background
	Ble.Disconnect
End Sub

' ================================================================
' BLE
' ================================================================

Public Sub Connect As ResumableSub
	' Ensure to add permission to manifest ACCESS_FINE_LOCATION, BLUETOOTH_SCAN, BLUETOOTH_CONNECT)
	Dim rp As RuntimePermissions
	Dim Permissions As List
	Dim phone As Phone

	If phone.SdkVersion >= 31 Then
		Permissions = Array("android.permission.BLUETOOTH_SCAN", "android.permission.BLUETOOTH_CONNECT", rp.PERMISSION_ACCESS_FINE_LOCATION)
	Else
		Permissions = Array(rp.PERMISSION_ACCESS_FINE_LOCATION)
	End If
	For Each per As String In Permissions
		rp.CheckAndRequest(per)
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			ToastMessageShow("No permission: " & Permission, True)
			Return False
		End If
	Next

	' Check if BLE is powered on
	If Ble.IsBluetoothOn = False Then
		TileEventViewer.Insert("[Connect] BLE not powered on.", HMITileUtils.EVENT_LEVEL_ALARM)
		Return False
	End If

	' Connect to the brick
	TileEventViewer.Insert("[Connect] Connecting...", HMITileUtils.EVENT_LEVEL_INFO)
	Ble.Connect( _
        BLE_MAC, _
        SERVICE_UUID, _
        CHAR_UUID_TX, _ 
		CHAR_UUID_RX)
	Return True
End Sub

' ================================================================
' Events BleGattManager
' ================================================================

Sub BLE_Connected
	IsConnected = True
	TileEventViewer.Insert("[BLE_Connect] OK", HMITileUtils.EVENT_LEVEL_INFO)
	TileButtonConnect.StateText = IIf(IsConnected, Chr(0xF0C1), Chr(0xF127))
End Sub

Sub BLE_ConnectionFailed (cause As String, msg As String)
	IsConnected = False
	TileEventViewer.Insert($"[BLE_ConnectionFailed] ${cause}, ${msg}"$, HMITileUtils.EVENT_LEVEL_ALARM)
	TileButtonConnect.StateText = IIf(IsConnected, Chr(0xF0C1), Chr(0xF127))
End Sub

Sub BLE_Disconnected
	IsConnected = False
	TileEventViewer.Insert("[BLE_Disconnected] OK", HMITileUtils.EVENT_LEVEL_WARNING)
	TileButtonConnect.StateText = IIf(IsConnected, Chr(0xF0C1), Chr(0xF127))
End Sub

Sub BLE_DeviceNotFound
	IsConnected = False
	TileEventViewer.Insert("[BLE_DeviceNotFound] ", HMITileUtils.EVENT_LEVEL_ALARM)
	TileButtonConnect.StateText = IIf(IsConnected, Chr(0xF0C1), Chr(0xF127))
End Sub

Sub BLE_DataReceived (Data() As Byte)
	TileEventViewer.Insert($"[BLE_DataReceived] ${bc.HexFromBytes(Data)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' Events Controller
' ================================================================

Sub BLE_Write(data() As Byte)
	Ble.Write(data)
End Sub

' ================================================================
' UI
' ================================================================

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
		Wait For (Connect) Complete (Success As Boolean)
		If Not(Success) Then
		End If
		Return
	End If

	' Disconnect
	If IsConnected Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect] Disconnecting from ${BLE_MAC}"$, HMITileUtils.EVENT_LEVEL_WARNING)
		' Disconnect > see event PyBridgeDisconnected
		Wait For(Ble.Disconnect) Complete (Success As Boolean)
		Return
	End If
End Sub

' Update the button UI color & text.
Private Sub TileButtonConnectUpdate(state As Boolean)
	If Not(TileButtonConnect.IsInitialized) Then Return
	TileButtonConnect.StateText = IIf(state, Chr(0xF0C1), Chr(0xF127))
End Sub

Private Sub TileButtonOpen_Click
	Ble.Write(CMD_OPEN)
	TileEventViewer.Insert($"[TileButtonOpen] Set ${bc.HexFromBytes(CMD_OPEN)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileButtonClose_Click
	Ble.Write(CMD_CLOSE)
	TileEventViewer.Insert($"[TileButtonClose] Set ${bc.HexFromBytes(CMD_OPEN)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileEventViewer_ItemClick (Index As Int, Value As Object)
	Log($"[TileEventViewer] index=${Index}, value=${Value}"$)
End Sub

