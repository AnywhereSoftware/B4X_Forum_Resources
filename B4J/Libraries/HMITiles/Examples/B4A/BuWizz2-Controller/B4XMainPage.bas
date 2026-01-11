B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			BuWizz2Controller
' Brief:		Control the BuWizz2 brick using BLE with flag WRITE_WITH_RESPONSE.
' Date:			2026-01-06
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	BleGattManager, HMITiles
' Description:	This class enables to control the BuWizz2 brick:
'				- SetOutputLevel
'				- SetPowerLevel
' Usage:		Set brick MAC address (BLE_MAC)
'				Turn the brick on > green light is flashing
'				Connect > green light stops flashing
'				Control brick by setting speed, change direction, stop
'				Disconnect > brick stops, green light starts flashing
' Hints:		Obtain MAC adress with a tool like BLE Scanner.
'				Brick is listed as BuWizz with alias BuWizz2.
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BLEExample.zip
#End Region

Private Sub Class_Globals
	Private Const VERSION As String = "BuWizz2 Controller v20260106"
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

	' BuWizz2 - BLE & Controller
	Private BLE_MAC As String = "50:FA:AB:38:A6:1A"		' BuWizz2 MAC address
	Private BuWizzBle As BleGattManager
	Private IsConnected As Boolean = False
	Private BuWizz As BuWizz2Controller
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

	' Initialize BuWizz2 Brick BLE & Controller
	BuWizz.Initialize(Me, "BuWizz")
	BuWizzBle.Initialize(Me, "BuWizz")
	BuWizzBle.setWriteMode(BuWizzBle.WRITE_WITH_RESPONSE)
End Sub

Private Sub B4XPage_Background
	BuWizzBle.Disconnect
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
	If BuWizzBle.IsBluetoothOn = False Then
		TileEventViewer.Insert("[Connect] BLE not powered on.", HMITileUtils.EVENT_LEVEL_ALARM)
		Return
	End If

	' Connect to the brick
	TileEventViewer.Insert("[Connect] Connecting...", HMITileUtils.EVENT_LEVEL_INFO)
	BuWizzBle.Connect( _
        BLE_MAC, _
        BuWizz.SERVICE_UUID, _
        BuWizz.CHAR_UUID_TX)
End Sub

' ================================================================
' Events BleGattManager
' ================================================================

Sub BuWizz_Connected
	TileButtonConnectUpdate(IsConnected)
	TileEventViewer.Insert("[Connect] Connected", HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Sub BuWizz_ConnectionFailed
	IsConnected = False
	TileButtonConnectUpdate(IsConnected)
	SetTilesInitialState
	TileEventViewer.Insert("[Connect] Connection failed", HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

Sub BuWizz_Disconnected
	IsConnected = False
	TileButtonConnectUpdate(IsConnected)
	SetTilesInitialState
	TileEventViewer.Insert("[Connect] Disconnected", HMITileUtils.EVENT_LEVEL_WARNING)
End Sub

Sub BuWizz_DeviceNotFound
	IsConnected = False
	TileButtonConnectUpdate(IsConnected)
	SetTilesInitialState
	TileEventViewer.Insert("[Connect] BuWizz device not found", HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

Sub BuWizz_DataReceived (Data() As Byte)
	TileEventViewer.Insert($"[DataReceived] ${bc.HexFromBytes(Data)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' Events BuWizz2 Controller
' ================================================================

Sub BuWizz_Write(data() As Byte)
	BuWizzBle.Write(data)
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
		TileEventViewer.Insert($"[TileButtonConnect_Click] Connecting to ${BuWizz.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)

		BuWizzBle.Connect( _
		    	BuWizz.BLE_MAC, _
		    	BuWizz.SERVICE_UUID, _
		    	BuWizz.CHAR_UUID_TX )
		IsConnected = True
		Return
	End If

	' Disconnect
	If IsConnected Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect_Click] Disconnecting from ${BuWizz.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_WARNING)
		BuWizzBle.Disconnect
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
		BuWizz.SetPowerLevel(Port, 0)
		' Set speed
		SetSpeed
	End If
End Sub
#End Region

#Region TileSeekBarSpeed
Private Sub TileSeekBarSpeed_ValueChanged (Value As Int)
	If Value > 0 And TileSelectDirection.SelectedIndex == BuWizz.DIRECTION_STP Then
		TileSelectDirection.SelectedIndex = BuWizz.DIRECTION_FWD
	End If
	SetSpeed
	TileEventViewer.Insert($"[TileSeekBarSpeed_ValueChanged] speed=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region

' ================================================================
' Brick Control
' ================================================================

#Region Brick Control
' Set the speed and the direction.
' Slider value: > 50 direction forward, < 50 direction backwards.
Private Sub SetSpeed
	Dim speed As Float = 0

	' Determine direction
	Select TileSelectDirection.SelectedIndex
		Case 0
			speed = 0
			TileSeekBarSpeed.Value = 0
			TileReadoutSpeed.Value = NumberFormat(speed, 0, 0)
		Case 1
			If TileSeekBarSpeed.Value > 0 Then
				speed = Convert.MapRange(TileSeekBarSpeed.Value + BuWizz.SPEED_OFFSET, 0, 100 + BuWizz.SPEED_OFFSET, BuWizz.SPEED_MIN, BuWizz.SPEED_MAX)
			Else
				speed = 0
			End If
			TileReadoutSpeed.Value = NumberFormat(TileSeekBarSpeed.Value, 0, 0)
		Case 2
			If TileSeekBarSpeed.Value > 0 Then
				speed = Convert.MapRange(TileSeekBarSpeed.Value + BuWizz.SPEED_OFFSET, 0, 100 + BuWizz.SPEED_OFFSET, BuWizz.SPEED_MIN, BuWizz.SPEED_MAX)
				speed = speed * -1
			Else
				speed = 0
			End If
			TileReadoutSpeed.Value = NumberFormat(TileSeekBarSpeed.Value, 0, 0)
	End Select
	
	' Set the power level for the BuWizz2 controller
	BuWizz.SetPowerLevel(Port, speed)
	
	' Gimmick
	If TileReadoutSpeed.Value > 90 Then
		TileReadoutSpeed.SetStyleAlarm
	else if TileReadoutSpeed.Value > 70 Then
		TileReadoutSpeed.SetStyleWarning
	Else
		TileReadoutSpeed.SetStyleNormal
	End If

	' Log
	Dim msg As String = $"[SetSpeed] sliderspeed=${NumberFormat(TileSeekBarSpeed.Value,0,0)},speed=${NumberFormat(Abs(speed),0,0)},dir=${TileSelectDirection.Selected}"$
	TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region
