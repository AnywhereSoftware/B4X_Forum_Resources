B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			Hub2Controller
' Brief:		Control the Hub2 brick using BLE with flag WRITE_WITH_RESPONSE.
' Date:			2026-01-06
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	BleGattManager, HMITiles
' Description:	This class enables to control the Hub2 brick:
'				- SetOutputLevel
'				- SetPowerLevel
' Usage:		Set brick MAC address (BLE_MAC)
'				Turn the brick on > green light is flashing
'				Connect > green light stops flashing
'				Control brick by setting speed, change direction, stop
'				Disconnect > brick stops, green light starts flashing
' Hints:		Obtain MAC adress with a tool like BLE Scanner.
'				Brick is listed as HUB NO.4.
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BLEExample.zip
#End Region

Private Sub Class_Globals
	Private Const VERSION As String = "Lego HUB NO.4 Controller v20260106"
	Private ABOUT As String 		= $"BleGattManager (c) 2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private Root As B4XView
	Private xui As XUI
	
	' Tiles
	Private TileButtonConnect As HMITileButton
	Private TileEventViewer As HMITileEventViewer
	Private TileSeekBarSpeed As HMITileSeekBar
	Private TileReadoutSpeed As HMITileReadout
	Private TileSelectDirection As HMITileSelect
	Private LabelAbout As Label

	' Hub2 - BLE & Controller
	Private BLE_MAC As String = "90:84:2B:C2:67:E8"
	Private HubBle As BleGattManager
	Private IsConnected As Boolean = False
	Private Hub As LegoHubNo4Controller
	Private Port As Byte = 0
	
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
	' Load layout case sensitive
	Root.LoadLayout("MainPage")

	' UI - Additional settings
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	B4XPages.SetTitle(Me, $"${VERSION} (B4A)"$)
	LabelAbout.Text = ABOUT

	' CustomView require short sleep
	Sleep(1)

	' Add customviews
	SetTilesInitialState
	
	' Add info to the event log
	TileEventViewer.Insert($"[B4XPage_Created] ${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileEventViewer.Insert($"[B4XPage_Created] BLE disconnected"$, HMITileUtils.EVENT_LEVEL_WARNING)

	' Initialize Hub BLE & Controller
	Hub.Initialize(Me, "Hub")
	HubBle.Initialize(Me, "Hub")
	HubBle.setWriteMode(HubBle.WRITE_NO_RESPONSE)
End Sub

Private Sub B4XPage_Background
	HubBle.Disconnect
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
	If HubBle.IsBluetoothOn = False Then
		TileEventViewer.Insert("[Connect] BLE not powered on.", HMITileUtils.EVENT_LEVEL_ALARM)
		Return
	End If

	' Connect to the brick
	TileEventViewer.Insert("[Connect] Connecting...", HMITileUtils.EVENT_LEVEL_INFO)
	HubBle.Connect( _
        BLE_MAC, _
        Hub.SERVICE_UUID, _
        Hub.CHAR_UUID_TX)
End Sub

' ================================================================
' Events BleGattManager
' ================================================================

Sub Hub_Connected
	TileButtonConnectUpdate(IsConnected)
	TileEventViewer.Insert("[Connect] Connected", HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Sub Hub_ConnectionFailed
	IsConnected = False
	SetTilesInitialState
	TileEventViewer.Insert("[Connect] Connection failed", HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

Sub Hub_Disconnected
	IsConnected = False
	SetTilesInitialState
	TileEventViewer.Insert("[Connect] Disconnected", HMITileUtils.EVENT_LEVEL_WARNING)
End Sub

Sub Hub_DeviceNotFound
	IsConnected = False
	SetTilesInitialState
	TileEventViewer.Insert("[Connect] Hub device not found", HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

Sub Hub_DataReceived (Data() As Byte)
	TileEventViewer.Insert($"[DataReceived] ${bc.HexFromBytes(Data)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' Events Hub2 Controller
' ================================================================

Sub Hub_Write(data() As Byte)
	HubBle.Write(data)
End Sub

' ================================================================
' UI
' ================================================================

#Region SetTilesInitialState
' SetTilesInitialState
' Set all tiles to its initial state.
' The string "--" indicates, no value received.
Private Sub SetTilesInitialState
	TileButtonConnect.SetStateFontFontAwesome
	TileButtonConnectUpdate(IsConnected)
	
	TileSelectDirection.AddAll(Array As String("STP", "FWD", "BCK"))
	TileSelectDirection.SelectedIndex = 0
	
	TileSeekBarSpeed.Value = 0
	TileReadoutSpeed.Value = 0
End Sub
#End Region

#Region TileButtonConnect
' TileButtonConnect_Click
' Connect or disconnect from the BLE device.
Private Sub TileButtonConnect_Click
	' Connect
	If Not(IsConnected) Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect_Click] Connecting to ${Hub.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)

		HubBle.Connect( _
		    	Hub.BLE_MAC, _
		    	Hub.SERVICE_UUID, _
		    	Hub.CHAR_UUID_TX )
		IsConnected = True
'		TileButtonConnectUpdate(IsConnected)
		Return
	End If

	' Disconnect
	If IsConnected Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect_Click] Disconnecting from ${Hub.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_WARNING)
		HubBle.Disconnect
		IsConnected = False
		TileButtonConnectUpdate(IsConnected)
		Return
	End If
End Sub

' Update the button UI color & text.
Private Sub TileButtonConnectUpdate(state As Boolean)
	If Not(TileButtonConnect.IsInitialized) Then Return
	TileButtonConnect.State = state
	TileButtonConnect.StateText = IIf(state, Chr(0xF0C1), Chr(0xF127))
End Sub
#End Region

#Region TileSelectDirection
Private Sub TileSelectDirection_ValueChanged (Value As Object)
	If IsConnected Then
		' Stop first
		Hub.SetPowerLevel(Port, 0)
		' Set speed
		SetSpeed
	End If
End Sub
#End Region

#Region TileSeekBarSpeed
Private Sub TileSeekBarSpeed_ValueChanged (Value As Int)
	If Value > 0 And TileSelectDirection.SelectedIndex == Hub.DIRECTION_STP Then
		TileSelectDirection.SelectedIndex = Hub.DIRECTION_FWD
	End If
	SetSpeed
	TileEventViewer.Insert($"[TileSeekBarSpeed_ValueChanged] speed=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region

' ================================================================
' Brick Control
' ================================================================

#Region Brick Control
#Region Speed
' Set the speed and the direction.
' Slider value: > 50 direction forward, < 50 direction backwards.
Private Sub SetSpeed
	Dim speed As Float = 0

	' Determine direction
	Select TileSelectDirection.SelectedIndex
		Case Hub.DIRECTION_STP
			speed = 0
			TileSeekBarSpeed.Value = 0
			' Set the power level for the BuWizz2 controller
			Hub.SetPowerLevel(Port, speed)
		Case Hub.DIRECTION_FWD
			' Stop first
			Hub.SetPowerLevel(Port, 0)
			Sleep(10)
			If TileSeekBarSpeed.Value > 0 Then
				speed = Convert.MapRange(TileSeekBarSpeed.Value + Hub.SPEED_OFFSET, 0, 100 + Hub.SPEED_OFFSET, Hub.SPEED_MIN, Hub.SPEED_MAX)
			Else
				speed = 0
			End If
			' Set the power level for the BuWizz2 controller
			Hub.SetPowerLevel(Port, speed)
		Case Hub.DIRECTION_BCK
			' Stop first
			Hub.SetPowerLevel(Port, 0)
			Sleep(10)
			If TileSeekBarSpeed.Value > 0 Then
				speed = Convert.MapRange(TileSeekBarSpeed.Value + Hub.SPEED_OFFSET, 0, 100 + Hub.SPEED_OFFSET, Hub.SPEED_MIN, Hub.SPEED_MAX)
				speed = speed * -1
			Else
				speed = 0
			End If
			' Set the power level for the BuWizz2 controller
			Hub.SetPowerLevel(Port, speed)
	End Select

	TileReadoutSpeed.Value = NumberFormat(TileSeekBarSpeed.Value,0,0)
	' TileTrendSpeed.Add(TileSeekBarSpeed.Value)
	
	' Log
	Dim msg As String = $"[SetSpeed] sliderspeed=${NumberFormat(TileSeekBarSpeed.Value,0,0)},speed=${NumberFormat(Abs(speed),0,0)},dir=${TileSelectDirection.Selected}"$
	' Gimmick
	If TileSeekBarSpeed.Value >= 80 Then
		TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_ALARM)
		TileReadoutSpeed.SetStyleAlarm
	else if TileSeekBarSpeed.Value >= 65 Then
		TileReadoutSpeed.SetStyleWarning
		TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_WARNING)
	Else
		TileReadoutSpeed.SetStyleNormal
		TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_INFO)
	End If
End Sub
#End Region
