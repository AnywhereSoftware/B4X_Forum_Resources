B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Class Header
' File:			LegoHUBNo4Controller
' Brief:		B4J Client controlling a Lego HUB No4 Brick via BLE using HMI tiles.
' Date:			2026-01-06
' Author:		Robert W.B. Linn (c) 2025-2026 MIT
' Description:	This B4J Application connects As a BLE Central (GATT Client)
'				To an ESP32 running B4R firmware acting As a BLE Peripheral (GATT Server).
'    			The ESP32 BLE Peripheral advertises DHT22 temperature And humidity data
'    			and listens For commands written by connected BLE Centrals.
'
'    			In the B4J VERSION, BLE communication Is performed through a PyBridge
'    			process that uses the Bleak library. The PyBridge handles BLE operations
'    			and forwards data between the B4J client And the ESP32 BLE Peripheral.
'
'				ESP32 = BLE Peripheral + GATT Server
'				B4J = BLE Central + GATT Client
'
' Hardware:		Acer NITRO 5, 15,6-inch (39.6 cm), 1920 x 1080 px, Windows 11
'				Acer V3-771G, 17.6-inch (44.7 cm), 1600 x 900 px, Ubuntu
' Software: 	B4J 10.30 (64 bit), Java JDK 19
' Libraries:	B4J: PyBridge 1.00, Bleak 1.02, ByteConverter 1.10, HMITiles 1.43
'				Min versions to include.
' Bleak:		Install:
'				Set python path under Tools: C:\Prog\B4J\Libraries\Python\python\python.exe
'				Open global Python shell: ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe
'				From folder C:\Prog\B4J\Libraries\Python\Notebooks> run: pip install bleak
'				https://www.b4x.com/android/forum/threads/pybridge-bleak-bluetooth-ble.165982/
' Notes:		Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'				Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'				Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'				Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'				ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BLEExample.zip
#End Region

Private Sub Class_Globals
	Private Const VERSION As String	= "Lego HUB No4 Controller v20260106"
	Private ABOUT As String			= $"HMITiles (c) 2025-2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private Root As B4XView
	Private xui As XUI
	
	' Tiles
	Private TileButtonConnect As HMITileButton
	Private TileEventViewer As HMITileEventViewer
	Private TileSeekBarSpeed As HMITileSeekBar
	Private TileSelectDirection As HMITileSelect
	Private TileTrendSpeed As HMITileTrend
	Private LabelAbout As Label

	' BLE
	Public BLEMgr As BLEManager
	Private IsConnected As Boolean = False

	' LegoHUBNo4
	Private Hub As LEGOHUBNo4Controller
	Private Port As Byte = 0
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

	' UI additional settings
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	#if B4A
	B4XPages.SetTitle(Me, $"${VERSION} (B4A)"$)
	#End If
	#if B4J
	B4XPages.SetTitle(Me, $"${VERSION} (B4J)"$)
	B4XPages.GetNativeParent(Me).Resizable = False
	#End If
	LabelAbout.Text = ABOUT

	' CustomView require short sleep
	Sleep(1)
	' Add customviews
	SetTilesInitialState
	
	' Add info to the event log
	TileEventViewer.Insert($"[B4XPage_Created] ${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileEventViewer.Insert($"[B4XPage_Created] BLE disconnected"$, HMITileUtils.EVENT_LEVEL_WARNING)

	' Init LegoHubNo4Controller
	Hub.Initialize(Me, "HUB")

	' Init scan timer - enabled false, is set to true after BLE connected
	#if B4A
	BLEScanTimer.Initialize("BleScanTimer", BLE_SCAN_TIMER_INTERVAL)
	BLEScanTimer.Enabled = False
	#end if

	' BLE Manager Initialize	
	BLEMgr.Initialize(B4XPages.GetPage("MainPage"), _ 
					  Hub.BLE_MAC, _ 
					  Hub.SERVICE_UUID, _ 
					  Hub.CHAR_UUID_RX, _ 
					  Hub.CHAR_UUID_TX)
	BLEMgr.Logging = False
	Wait For (BLEMgr.Start) complete (result As Boolean)
	If result Then
		TileEventViewer.Insert($"[B4XPage_Created] PyBridge started, BLE initialized"$, HMITileUtils.EVENT_LEVEL_INFO)
	Else
		TileEventViewer.Insert($"[B4XPage_Created] Failed to start the PyBridge initialize BLE"$, HMITileUtils.EVENT_LEVEL_ALARM)
	End If
End Sub

Private Sub B4XPage_Background
	#if B4A
	BLEMgr.Disconnect
	#End If
	#if B4J
	BLEMgr.PyBridgeKillProcess
	#End If
End Sub

' These subs are triggered by the BLEMgr pybridge events
#if B4J
Public Sub PyBridgeDisconnected
	IsConnected = False
	TileEventViewer.Insert($"[PyBridgeDisconnected] ${"Disconnected"}"$, HMITileUtils.EVENT_LEVEL_WARNING)
	TileButtonConnectUpdate(IsConnected)
	SetTilesInitialState
End Sub
#End If

' ================================================================
' Events Hub Controller
' ================================================================

Sub Hub_Write(data() As Byte)
	Write(data)
End Sub

' ================================================================
' B4J BLE MANAGER
' ================================================================
#Region B4J-BLE-MANAGER
' HandleBLEConnect
' Set the connect button state.
' Parameters:
'	state Boolean - True connected else disconnected
Public Sub HandleBLEConnect(state As Boolean)
	If state Then
		TileEventViewer.Insert($"[HandleBLEConnect] ${"Connected"} to ${Hub.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)
	Else
		TileEventViewer.Insert($"[HandleBLEConnect] ${"Disconnected"} from ${Hub.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_ALARM)
	End If
	IsConnected = state
	TileButtonConnectUpdate(IsConnected)
End Sub

' HandleBLENotification
' Process the data received from BLE notify.
' Get the device id as first byte and then parse the data according device byte pattern.
' Parameters:
'	data Byte Array - Response from the BLE device
Public Sub HandleBLENotification(payload() As Byte)
'	Dim item As String = $"[HandleBLENotification] value=${Convert.ByteConv.HexFromBytes(payload)}"$
End Sub

Public Sub Write(data() As Byte)
	BLEMgr.Write(data)
End Sub
#End Region

' ================================================================
' BLE PROCESS DATA
' ================================================================

#Region BLE Process Data
Private Sub ProcessBLE(payload() As Byte)	'ignore
	TileEventViewer.Insert($"[ProcessBLE] ${Convert.HexFromBytes(payload)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region

' ================================================================
' UI
' ================================================================

' SetTilesInitialState
' Set all tiles to its initial state.
' The string "--" indicates, no value received.
Private Sub SetTilesInitialState
	' Log($"w=${Root.Width}, h=${Root.Height}"$)
	
	TileButtonConnect.SetStateFontFontAwesome
	TileButtonConnectUpdate(IsConnected)
	
	TileSelectDirection.AddAll(Array As String("STP", "FWD", "BCK"))
	TileSelectDirection.SelectedIndex = 0
	
	TileSeekBarSpeed.Interval = 5
	TileSeekBarSpeed.Value = 0
End Sub

#Region TileButtonConnect_Click
' TileButtonConnect_Click
' Connect or disconnect from the BLE device.
Private Sub TileButtonConnect_Click
	' Connect
	If Not(IsConnected) Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect_Click] Connecting to ${Hub.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_INFO)
		' Scan and connect > see event handlebleconnect
		Wait For (BLEMgr.Scan) Complete (Success As Boolean)
		If Not(Success) Then
			TileEventViewer.Insert(BLEMgr.LastMsg, HMITileUtils.EVENT_LEVEL_ALARM)
		End If
		Return		
	End If

	' Disconnect
	If IsConnected Then
		TileButtonConnect.StateText = Chr(0xF252)
		TileEventViewer.Insert($"[TileButtonConnect_Click] Disconnecting from ${Hub.BLE_DEVICE_NAME}"$, HMITileUtils.EVENT_LEVEL_WARNING)
		' Disconnect > see event PyBridgeDisconnected
		Wait For(BLEMgr.Disconnect) Complete (Success As Boolean)
		If Not(Success) Then
			TileEventViewer.Insert(BLEMgr.LastMsg, HMITileUtils.EVENT_LEVEL_ALARM)
		End If
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

#Region TileSeekBarSpeed
Private Sub TileSeekBarSpeed_ValueChanged (Value As Int)
	If Value > 0 And TileSelectDirection.SelectedIndex == Hub.DIRECTION_STP Then
		TileSelectDirection.SelectedIndex = Hub.DIRECTION_FWD
	End If
	SetSpeed
	TileEventViewer.Insert($"[TileSeekBarSpeed_ValueChanged] speed=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
#End Region

#Region TileEventViewer/Info
#if B4J
Private Sub TileEventViewer_Click(EventData As MouseEvent)
	Log(BLEMgr.LastMsg)
End Sub
#end if

Private Sub TileEventViewer_ItemClick (Index As Int, Value As Object)
	
End Sub
#End Region


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
	
	TileTrendSpeed.Add(TileSeekBarSpeed.Value)
	
	' Log	
	Dim msg As String = $"[SetSpeed] sliderspeed=${NumberFormat(TileSeekBarSpeed.Value,0,0)},speed=${NumberFormat(Abs(speed),0,0)},dir=${TileSelectDirection.Selected}"$
	' Gimmick
	If TileSeekBarSpeed.Value >= 80 Then
		TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_ALARM)
	else if TileSeekBarSpeed.Value >= 65 Then
		TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_WARNING)
	Else
		TileEventViewer.Insert(msg, HMITileUtils.EVENT_LEVEL_INFO)
	End If
End Sub
#End Region

Private Sub TileSelectDirection_ValueChanged (Value As Object)
	If IsConnected Then
		SetSpeed	
	End If
End Sub
