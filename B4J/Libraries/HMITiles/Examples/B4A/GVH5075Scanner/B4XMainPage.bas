B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			GVH5075Scanner
' Brief:		Example using the BLE Scanner for a GHV5075 device.
' Date:			2026-01-08
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	BleCentral 1.00, HMITiles v1.43
' Description:	The GVH5075 is a wireless Bluetooth Low Energy (BLE) sensor node.
'				Current readings temperature & humidity & battery health are send every 2 seconds.
'				Scanning for data is done only once (can be turned off).
'				HMITiles are used to display selective data.
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
#End Region

Sub Class_Globals
	Private VERSION As String	= "GVH5075 Scanner Example v20260109"
	Private ABOUT As String 	= $"BleCentral BleScanner (c) 2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private xui As XUI
	Private Root As B4XView
	Private TileButtonScan As HMITileButton
	Private TileReadoutConfortState As HMITileReadout
	Private TileReadoutSensorData As HMITileReadout
	Private TileSensorTemperature As HMITileSensor
	Private TileSensorHumidity As HMITileSensor
	Private TileSensorBattery As HMITileSensor
	Private TileEventViewerLog As HMITileEventViewer
	Private CheckBoxScanOnce As B4XView
	Private EditTextMacAddress As B4XView
	Private LabelAbout As B4XView
	
	' Scanner
	' Device Name & MAC used by device found to filter
	Private GVH_NAME As String	= "GVH5075"
	Private DEV_NAME As String	= "GVH5075_3022"
	Private DEV_MAC As String	= "A4:C1:38:4C:30:22"
	Private Scanner As BleScanner
	Private IsScanning As Boolean = False
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub
	
' Page created
Private Sub B4XPage_Created (Root1 As B4XView)
    Root = Root1
    Root.LoadLayout("MainPage")

	' UI Settings
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	B4XPages.SetTitle(Me, VERSION)
	LabelAbout.Text = ABOUT
	CheckBoxScanOnce.Checked = True
	EditTextMacAddress.Text = DEV_MAC
	
	' Short delay to allow HMITiles load completion
	Sleep(1)
	' Add customviews
	SetTilesInitialState

	' Init the ble scanner
	Scanner.Initialize(Me, "Scanner")
	' Request runtime permission if needed
	If Scanner.HasScanPermission Then
		Scanner.SetScanMode(Scanner.SCAN_PASSIVE)
	Else
		TileEventViewerLog.Insert($"No Bluetooth scan permission."$, HMITileUtils.EVENT_LEVEL_ALARM)
		Return
	End If
End Sub

Private Sub B4XPage_Background
	Scanner.StopScan
End Sub

' ================================================================
' UI
' ================================================================

#Region SetTilesInitialState
' SetTilesInitialState
' Set all tiles to its initial state.
' The string "--" indicates, no value received.
Private Sub SetTilesInitialState
	TileButtonScan.SetStateFontFontAwesome
	TileButtonScanUpdate(IsScanning)
	TileReadoutSensorData.Title = GVH_NAME
	TileEventViewerLog.CompactMode = False
	TileEventViewerLog.Insert($"${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileEventViewerLog.Insert($"Device ${DEV_NAME} (${DEV_MAC})"$, HMITileUtils.EVENT_LEVEL_INFO)
	' TileEventViewerLog.RowHeight = 130
End Sub
#End Region

#Region TileButtonScan
' TileButtonScan_Click
' Scan or stop scanning.
Private Sub TileButtonScan_Click
	If Not(IsScanning) Then
		' StartScan
		IsScanning = True
		TileEventViewerLog.Insert($"Start scanning"$, HMITileUtils.EVENT_LEVEL_INFO)
		Scanner.StartScan
	Else
		' StopScan
		IsScanning = False
		TileEventViewerLog.Insert($"Stop scanning"$, HMITileUtils.EVENT_LEVEL_INFO)
		Scanner.StopScan
	End If
	TileButtonScanUpdate(IsScanning)
End Sub

' Update the button UI color & text.
Private Sub TileButtonScanUpdate(scanning As Boolean)
	' If Not(TileButtonScan.IsInitialized) Then Return
	TileButtonScan.State = scanning
	TileButtonScan.StateText = IIf(scanning, Chr(0xF252), Chr(0xF011))
End Sub
#End Region

Private Sub CheckBoxScanOnce_CheckedChange(Checked As Boolean)
	' No action
End Sub

Private Sub TileEventViewerLog_ItemClick (Index As Int, Value As Object)
	Log($"[TileEventViewerLog] ${Value}"$)
End Sub

' ================================================================
' SCANNER
' ================================================================

' Scanner_DeviceFound 
' Device discovered event.
' Parameters:
'	Info - Map with device info including advertised payload.
Sub Scanner_DeviceFound (Info As Map)
	' Get the device properties
    Dim name As String	= Info.Get("Name")
    Dim mac As String	= Info.Get("Mac")
    Dim rssi As Int		= Info.Get("Rssi")
    Dim adv() As Byte	= Info.Get("AdvData")

	' Check if target device found
	If mac = EditTextMacAddress.Text Then

		TileEventViewerLog.Insert($"[Scanner_DeviceFound] ${name} ${mac} RSSI=${rssi}"$, HMITileUtils.EVENT_LEVEL_INFO)
		TileEventViewerLog.Insert($"[Scanner_DeviceFound] advdata:${CRLF}${HMITileUtils.ByteConv.HexFromBytes(adv)}"$, HMITileUtils.EVENT_LEVEL_INFO)

        ' Parse advertisement bytes
		Dim data As TGVH5075AdvData = GVH5075Parser.Parse(adv)

		' Tile Updates
		TileReadoutSensorData.Value		= $"${Round(data.Temperature)} °C"$
		TileReadoutSensorData.Unit 		= $"${Round(data.Humidity)} %RH / ${Round(data.BatteryPct)} %"$
		
		TileSensorTemperature.Value		= Round(data.Temperature)
		TileSensorHumidity.Value 		= Round(data.Humidity)
		TileSensorBattery.Value 		= Round(data.BatteryPct)
		TileSensorBattery.Icon			= HMITileUtils.SetBatteryStateIcon(data.BatteryPct)
		TileReadoutConfortState.Value	= HMITileUtils.SetComfortState(data.Temperature, data.Humidity)

		' Check if scanning only once
		If CheckBoxScanOnce.Checked Then
			TileButtonScan_Click
		End If
	End If
End Sub
