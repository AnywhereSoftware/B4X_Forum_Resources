B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			RuuviTagScanner
' Brief:		Example using the BLE Scanner for a RuuviTag device.
' Date:			2026-01-09
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	BleCentral 1.00, HMITiles v1.43
' Description:	The RuuviTag is a wireless Bluetooth Low Energy (BLE) sensor node
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
	Private VERSION As String	= "RuuviTagScanner Example v20260109"
	Private ABOUT As String 	= $"BleCentral BleScanner (c) 2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private xui As XUI
	Private Root As B4XView
	Private TileButtonScan As HMITileButton
	Private TileReadoutConfortState As HMITileReadout
	Private TileReadoutSensorData As HMITileReadout
	Private TileSensorTemperature As HMITileSensor
	Private TileSensorHumidity As HMITileSensor
	Private TileSensorPressure As HMITileSensor
	Private TileSensorBattery As HMITileSensor
	Private TileSensorMovementCounter As HMITileSensor
	Private TileSensorTimeStamp As HMITileSensor
	Private TileSensorAccelerationX As HMITileSensor
	Private TileSensorAccelerationY As HMITileSensor
	Private TileSensorAccelerationZ As HMITileSensor	
	Private TileEventViewerLog As HMITileEventViewer
	Private CheckBoxScanOnce As B4XView
	Private LabelAbout As B4XView
	Private EditTextMacAddress As B4XView
	
	' Scanner
	' Device Name & MAC used by device found to filter
	Private DEV_NAME As String		= "RuuviTag"
	Private DEV_MAC As String		= "F7:6F:D8:27:B7:8D"
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

	TileReadoutSensorData.Title = DEV_NAME

	TileEventViewerLog.CompactMode = False
	TileEventViewerLog.Insert($"${VERSION}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileEventViewerLog.Insert($"Device ${DEV_NAME} (${DEV_MAC})"$, HMITileUtils.EVENT_LEVEL_INFO)
	' Increase row height if want to see full advertised data
	' TileEventViewerLog.RowHeight = 130
End Sub
#End Region

#Region TileButtonScan
' TileButtonScan_Click
' Scan or stop scanning.
Private Sub TileButtonScan_Click
	If Not(IsScanning) Then
		If EditTextMacAddress.Text.Length == 0 Then
			TileEventViewerLog.Insert($"Start scanning - MAC address missing"$, HMITileUtils.EVENT_LEVEL_ALARM)
			Return			
		End If
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
    Dim name As String	= Info.Get("Name")
    Dim mac As String	= Info.Get("Mac")
    Dim rssi As Int		= Info.Get("Rssi")
    Dim adv() As Byte	= Info.Get("AdvData")

	' Parse advertised data from the target device set by the MAC address
	If mac = EditTextMacAddress.Text Then

		TileEventViewerLog.Insert($"[Scanner_DeviceFound] ${name} ${mac} RSSI=${rssi}"$, HMITileUtils.EVENT_LEVEL_INFO)
		
		' Check if there is advertised data
		If adv.Length > 0 Then
			TileEventViewerLog.Insert($"[Scanner_DeviceFound] advdata:${CRLF}${HMITileUtils.ByteConv.HexFromBytes(adv)}"$, HMITileUtils.EVENT_LEVEL_INFO)

			' Parse advertisement bytes
			Dim advdata As TRuuviTagAdvData = RuuviTagParser.ParseAdvData(adv)
			If Not(advdata.IsInitialized) Then Return
			' Tile Updates
			TileReadoutSensorData.Value 	= $"${NumberFormat(advdata.Temperature,1,1)} °C"$
			TileReadoutSensorData.Unit 		= $"${Round(advdata.Humidity)} %RH / ${advdata.BatteryPct} %"$
			TileSensorTemperature.Value		= NumberFormat(advdata.Temperature,1,1)
			TileSensorHumidity.Value 		= Round(advdata.Humidity)
			TileSensorPressure.Value		= Round(advdata.Pressure)
			TileSensorBattery.Value 		= $"${advdata.BatteryPct} % ${advdata.BatteryVoltage} V"$
			TileSensorBattery.Unit 			= ""
			TileSensorBattery.Icon			= HMITileUtils.SetBatteryStateIcon(advdata.BatteryPct)
			TileSensorMovementCounter.Value = advdata.MovementCounter
			TileReadoutConfortState.Value	= HMITileUtils.SetComfortState(advdata.Temperature, advdata.Humidity)
			TileSensorTimeStamp.Value		= advdata.TimeStampTimeHourMin
			TileSensorAccelerationX.Value	= advdata.AccelerationX
			TileSensorAccelerationY.Value	= advdata.AccelerationY
			TileSensorAccelerationZ.Value	= advdata.AccelerationZ
		Else
			TileEventViewerLog.Insert($"[Scanner_DeviceFound] No advertised data"$, HMITileUtils.EVENT_LEVEL_WARNING)
		End If

		' Check if scanning only once
		If CheckBoxScanOnce.Checked Then
			TileButtonScan_Click
		End If
	End If
End Sub

'Sub Scanner_PermissionMissing
'	Log("Scan permission missing")
'End Sub
'
'' Permission result
'Sub Activity_PermissionResult (Permission As String, Result As Boolean)
'    If Result = True Then
'        Scanner.StartScan
'    Else
'        Log("Permission denied: " & Permission)
'    End If
'End Sub
