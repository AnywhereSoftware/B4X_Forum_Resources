B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Class Header
' File:			ESP32BLELED
' Brief:		Android client controlling an LED connected to an ESP32 via BLE using commands.
' Date:			202601-06
' Author:		Robert W.B. Linn (c) 2025 MIT
' Description:	This B4A application (app) connects as a client with an ESP32 running as Bluetooth Low Energy (BLE) server.
'				Turn ESP32 LED ON: send 3 bytes 010101 (deviceid, commandid, state)
'				Turn ESP32 LED OFF: send 3 bytes 010100 (deviceid, commandid, state)
'				Request ESP32 LED STATE: send 2 bytes 0102 (deviceid, commandid), ESP32 returns 3 bytes: 010201 (deviceid, commandid, state 00 or 01).
' Software: 	B4A 13.40(64 bit), Java JDK 19, Android Platform Tools 36.
' Libraries:	BleCentral 1.00, Phone 2.60, RunTimePermissions 1.20, HMITiles 1.40, ByteConverter 1.10
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Sub Class_Globals
	Private VERSION As String	= "ESP32BLELED v20260106"
	Private ABOUT As String 	= $"HMITiles (c) 2025-2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private Root As B4XView
	Private xui As XUI
	Private TileListCommands As HMITileList
	Private TileEventViewer As HMITileEventViewer
	Private LabelAbout As B4XView
	Private LabelConnected As B4XView

	' BLE
	Private BLE_MAC As String = "F8:B3:B7:7C:4E:BE"
	Private Ble As BleClient
	Private IsConnected As Boolean = False
	Private Commands As BLECommands

	' Helper
	Private bc As ByteConverter
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
	LabelConnected.Text = "Disconnected"
	LabelConnected.TextColor = HMITileUtils.COLOR_TEXT_WARNING

	' CustomView require short sleep
	Sleep(1)
	' Add the list of commands
	' Initialize Command List
	Commands.Initialize
	TileListCommandsAddAll
	TileEventViewer.Insert($"${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	
	' BLE
	Ble.Initialize(Me, "BLE")
	Ble.setWriteMode(Ble.WRITE_NO_RESPONSE)
End Sub

Private Sub B4XPage_Background
	Ble.Disconnect
End Sub

' ================================================================
' BLE
' ================================================================

Public Sub Connect
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
			Return
		End If
	Next

	' Check if BLE is powered on
	If Ble.IsBluetoothOn = False Then
		TileEventViewer.Insert("[Connect] BLE not powered on.", HMITileUtils.EVENT_LEVEL_ALARM)
		Return
	End If

	' Connect to the brick
	TileEventViewer.Insert("[Connect] Connecting...", HMITileUtils.EVENT_LEVEL_INFO)
	Ble.Connect( _
        BLE_MAC, _
        BLEConstants.SERVICE_UUID, _
        BLEConstants.CHAR_UUID_TX)
End Sub

' ================================================================
' Events BleGattManager
' ================================================================

Sub BLE_Connected
	IsConnected = True
	TileEventViewer.Insert("[Connect] Connected", HMITileUtils.EVENT_LEVEL_INFO)
	LabelConnected.Text = "Connected"
End Sub

Sub BLE_ConnectionFailed
	IsConnected = False
	TileEventViewer.Insert("[Connect] Connection failed", HMITileUtils.EVENT_LEVEL_ALARM)
	LabelConnected.Text = "Disconnected"
End Sub

Sub BLE_Disconnected
	IsConnected = False
	TileEventViewer.Insert("[Connect] Disconnected", HMITileUtils.EVENT_LEVEL_WARNING)
	LabelConnected.Text = "Disconnected"
End Sub

Sub BLE_DeviceNotFound
	IsConnected = False
	TileEventViewer.Insert("[Connect] Device not found", HMITileUtils.EVENT_LEVEL_ALARM)
	LabelConnected.Text = "Disconnected"
End Sub

Sub BLE_DataReceived (Data() As Byte)
	TileEventViewer.Insert($"[DataReceived] ${bc.HexFromBytes(Data)}"$, HMITileUtils.EVENT_LEVEL_INFO)
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

#Region TileList
' TileListCommandsAddAll
' Add all commands from the commands list.
Private Sub TileListCommandsAddAll
	For Each command As TCommand In Commands.ListCommands
		TileListCommands.Add(command.Name, command.Description, command)
	Next
End Sub

' TileListCommands_ItemClick
' Execute selected command. 
' The first commands are system commands to connect/disconnect to/from device.
Private Sub TileListCommands_ItemClick (Index As Int, Value As Object)
	Dim command As TCommand = Value
	' Check if the commands list is initialized
	If command.IsInitialized Then
		' Handle system commands first
		If command.DeviceId == BLEConstants.DEV_SYSTEM Then

			' BLE Connect - see also HandleBLEConnect
			If command.Value(0) = BLEConstants.STATE_ON Then
				If Not(IsConnected) Then
					TileEventViewer.Insert($"[TileListCommands_ItemClick] Connecting... ${BLEConstants.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)
					Connect
				End If
			End If

			' BLE Disconnect - see also HandleBLEConnect
			If command.Value(0) = BLEConstants.STATE_OFF Then
				If IsConnected Then
					TileEventViewer.Insert($"[TileListCommands_ItemClick] Disconnecting... ${BLEConstants.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)
					Ble.Write(Commands.BuildPayload(Commands.ListCommands.Get(3)))
					Sleep(1)
					Ble.Disconnect
				End If
			End If
			Return
		End If
		
		' Handle device commands
		If IsConnected Then
			Ble.Write(Commands.BuildPayload(command))
			TileEventViewer.Insert($"[TileListCommands_ItemClick] Command succesful ${command.Name}"$, HMITileUtils.EVENT_LEVEL_INFO)
		Else
			TileEventViewer.Insert($"[TileListCommands_ItemClick] Command failed, BLE not connected."$, HMITileUtils.EVENT_LEVEL_ALARM)
			Return
		End If
	End If
End Sub
#End Region

