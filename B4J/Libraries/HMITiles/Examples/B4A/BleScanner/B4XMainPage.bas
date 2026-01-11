B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			Scanner
' Brief:		Example using the BLE Scanner.
' Date:			2026-01-07
' Author:		Robert W.B. Linn (c) 2026 MIT
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private VERSION As String	= "BleScanner v20260107"
	Private ABOUT As String 	= $"BleCentral (c) 2026 Robert W.B. Linn - MIT"$

	' UI
	Private xui As XUI
	Private Root As B4XView
	Private TileEventViewerAdvData As HMITileEventViewer
	Private TileButtonStartScan As HMITileButton
	Private TileButtonStopScan As HMITileButton
	Private LabelAbout As B4XView
	
	' Scanner
	' Device Name & MAC used by device found to filter
'	Private DEV_NAME As String = "GVH5075_3022"
'	Private DEV_MAC As String = "A4:C1:38:4C:30:22"
	Private Scanner As BleScanner
	
	' Helper
	Private bc As ByteConverter
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub
	
' Page created
Private Sub B4XPage_Created (Root1 As B4XView)
    Root = Root1
    Root.LoadLayout("MainPage")
	
	' UI
	B4XPages.SetTitle(Me, VERSION)
	LabelAbout.Text = ABOUT
	
	' Short delay to allow HMITiles load completion
	Sleep(1)
	TileEventViewerAdvData.CompactMode = False
	TileEventViewerAdvData.RowHeight = 130
	
	' Init the ble scanner
    Scanner.Initialize(Me, "Scanner")
    ' Request runtime permission if needed
	If Scanner.HasScanPermission Then
		Scanner.SetScanMode(Scanner.SCAN_PASSIVE)
	Else
		TileEventViewerAdvData.Insert($"No Bluetooth scan permission."$, HMITileUtils.EVENT_LEVEL_ALARM)
	End If
End Sub

Private Sub B4XPage_Background
	Scanner.StopScan
End Sub

' ================================================================
' UI
' ================================================================

Private Sub TileButtonStartScan_Click
	TileEventViewerAdvData.Insert($"Start scanning."$, HMITileUtils.EVENT_LEVEL_INFO)
	Scanner.StartScan
End Sub

Private Sub TileButtonStopScan_Click
	TileEventViewerAdvData.Insert($"Stopped scanning."$, HMITileUtils.EVENT_LEVEL_WARNING)
	Scanner.StopScan
End Sub

Private Sub TileEventViewerAdvData_ItemClick (Index As Int, Value As Object)
	Dim data As String = Value
	Log($"[TileEventViewerAdvData] ${data})"$)
End Sub

' ================================================================
' SCANNER
' ================================================================

' Device discovered event
Sub Scanner_DeviceFound (Info As Map)
    Dim name As String = Info.Get("Name")
    Dim mac As String = Info.Get("Mac")
    ' Dim rssi As Int = Info.Get("Rssi")
    Dim adv() As Byte = Info.Get("AdvData")

	If name.Length == 0 Then name = "Unknown"

	TileEventViewerAdvData.Insert($"${name}${CRLF}(${mac})${CRLF}${bc.HexFromBytes(adv)}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Sub Scanner_PermissionMissing
	TileEventViewerAdvData.Insert($"No Bluetooth scan permission."$, HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

' Permission result
Sub Activity_PermissionResult (Permission As String, Result As Boolean)
    If Result = True Then
        Scanner.StartScan
    Else
        Log("Permission denied: " & Permission)
    End If
End Sub
