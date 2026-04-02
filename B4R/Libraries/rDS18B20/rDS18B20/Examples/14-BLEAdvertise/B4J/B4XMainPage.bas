B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

' Log Example:
'Server Is listening on port: 53133
'Python path: C:\Prog\B4J\libraries\Python\python\python.exe
'Call B4XPages.GetManager.LogEvents = True To enable logging B4XPages events.
'connected
'starting PyBridge v1.00
'watchdog set To 30 seconds
'Connecting To port: 53133
'scanning For device
'[BLE_DeviceFound] id=E0:8C:FE:34:B4:AE, name=B4R-DS18B20, services=[], servicedata={}
'[UpdatePanel] data=0101072700
'[DecodePayload][I] payload=0101072700
'[DecodePayload][I] t=18.31
'[UpdatePanel] t=18.31


#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BleakExample.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

'dependencies: pip install bleak
Sub Class_Globals
	Private VERSION As String = "DS18B20 BLEAdvertiser Example v20260329"
	
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private ble As Bleak
	Private ScanProgress As AnotherProgressBar
	Private lstDevices As CustomListView
	Private btnScan As B4XView
	Private btnStopScan As B4XView
	Private ScanState_Init = 0, ScanState_Not_Scanning = 1, ScanState_Scanning = 2 As Int
	Private AddressesToPanels As Map = CreateMap()
	Private AddressesToDevices As Map = CreateMap()
	Public ddd1 As DDD
	Private Clients As List
	
	' B4R-DS18B20 Settings
	Private DEVICE_NAME As String = "B4R-DS18B20"
	Private DEVICE_MAC As String = "E0:8C:FE:34:B4:AE"	'ignore
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	ddd1.Initialize
	xui.RegisterDesignerClass(ddd1)
	
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, VERSION)
	
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	SetScanState(ScanState_Init)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	SetScanState(ScanState_Not_Scanning)
	ble.Initialize(Me, "ble", Py)
	Clients.Initialize

	btnScan_Click
End Sub

Private Sub BLE_DeviceFound  (Device As BleakDevice)
	' Log($"[BLE_DeviceFound] id=${Device.DeviceId}, name=${Device.Name}, services=${Device.ServiceUUIDS}, servicedata=${Device.ServiceData}"$)
	'If AddressesToPanels.ContainsKey(Device.DeviceId) = False Then
	' Add B4R-DS18B20 only
	If Device.Name <> Null Then
		If Device.Name == DEVICE_NAME Then
			Log($"[BLE_DeviceFound] id=${Device.DeviceId}, name=${Device.Name}, services=${Device.ServiceUUIDS}, servicedata=${Device.ServiceData}"$)
			' Update list
			Dim pnl As B4XView = xui.CreatePanel("")
			pnl.SetLayoutAnimated(0, 0, 0, lstDevices.AsView.Width, 205dip)
			pnl.LoadLayout("DeviceListItem")
			lstDevices.Clear
			AddressesToPanels.Put(Device.DeviceId, pnl)
			lstDevices.Add(pnl, "")
			AddressesToDevices.Remove(Device.DeviceId)
			AddressesToDevices.Put(Device.DeviceId, Device)
			UpdatePanel(AddressesToPanels.Get(Device.DeviceId), Device)

			' btnStopScan_Click
			' Log($"[BLE_DeviceFound] scan stopped"$)
		End If
	End If
	'End If
End Sub

Private Sub BytesMapToString(map As Map, Title As String) As String	'ignore
	Dim sb As StringBuilder
	sb.Initialize
	If map.Size > 0 Then
		sb.Append(Title).Append(CRLF)
		For Each key As Object In map.Keys
			Dim b() As Byte = map.Get(key)
			sb.Append($"${key}: ${BytesToString(b, 0, b.Length, "ASCII")}"$).Append(CRLF)
		Next
	End If
	Return sb.ToString
End Sub

Private Sub UpdatePanel(pnl As B4XView, device As BleakDevice)
	Dim lblName As B4XView = ddd1.GetViewByName(pnl, "lblName")
	Dim txtOther As B4XView = ddd1.GetViewByName(pnl, "txtOther")

	lblName.Text = device.DeviceId
	If device.Name <> "" Then lblName.Text = lblName.Text & $" (${device.Name})"$

	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"Discovered time $Time{DateTime.Now}"$).Append(CRLF)
	sb.Append("RSSI: ").Append(device.RSSI).Append(CRLF)

	' sb.Append(BytesMapToString(device.ManufacturerData, "Manufacturer data"))
	Dim m As Map 		= device.ManufacturerData	' Example {6488=[B@3b90a525}
	' First two bytes of Manufacturer Data are always the Bluetooth Company ID (little-endian).
	' 58 19 > ble uses little-endian, so the Company ID Is: 0x1958 > Convert To decimal: 0x1958 = 6488
	Dim data() As Byte	= m.Get(6488)
	Log($"[UpdatePanel] data=${Convert.HexFromBytes(data)}"$)
	Dim t As Float = DecodePayload(data)
	Log($"[UpdatePanel] t=${NumberFormat(t,2,3)}"$)
	sb.Append("t: ").Append(NumberFormat(t,2,3)).Append(CRLF)
	txtOther.Text = sb.ToString
End Sub

Private Sub SetScanState(State As Int)
	ScanProgress.Visible = State = ScanState_Scanning
	btnStopScan.Enabled = State = ScanState_Scanning
	btnScan.Enabled = State = ScanState_Not_Scanning
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

Private Sub btnStopScan_Click
	ble.StopScan
	SetScanState(ScanState_Not_Scanning)
End Sub

Private Sub btnScan_Click
	AddressesToDevices.Clear
	AddressesToPanels.Clear
	lstDevices.Clear
	Wait For (ble.Scan(Null)) Complete (Success As Boolean)
	If Success Then
		Log("scanning for device")
		SetScanState(ScanState_Scanning)
	Else
		Log(Py.PyLastException)
	End If
End Sub

Public Sub ParseErrorMessage(Raw As String) As String
	Dim m As Matcher = Regex.Matcher("\(([^)]+)\) - Method: [^.]+\.[^:]+:(.*)$", Raw)
	Dim msg As String = Raw
	If m.Find Then
		msg = m.Group(1)
		If m.Group(2).Trim <> "" Then
			msg = msg & " - " & m.Group(2)
		End If
	End If
	Return msg
End Sub

Public Sub ListToString (props As List) As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each p As String In props
		sb.Append(p).Append(", ")
	Next
	If sb.Length > 0 Then sb.Remove(sb.Length - 2, sb.Length)
	Return sb.ToString
End Sub


' DecodePayload
' Data example:	01 01 06 78 00
'				1  2  3  4  5
' Data length:	5 bytes
' Byte 1 (1):	Protocol Header
' Byte 2 (1):	Model Header
' Byte 3-4 (2): Temperature (INT16, big endian, °C * 100)
' Byte 5 (1):	Padding
Private Sub DecodePayload(payload() As Byte) As Float
	Log($"[DecodePayload][I] payload=${Convert.HexFromBytes(payload)}"$)

	If payload.Length < 5 Then
		Log("[DecodePayload][E] Payload too short!")
		Return Null
	End If

	' Rebuild signed INT16 temperature
	Dim raw As Int = _
        Bit.Or( _
            Bit.ShiftLeft(Bit.And(payload(2),0xFF),8), _
            Bit.And(payload(3),0xFF) _
        )

	' Sign correction
	If raw > 32767 Then raw = raw - 65536

	Dim temp As Float = raw / 100.0

	Log($"[DecodePayload][I] t=${NumberFormat(temp,1,2)}"$)
	
	Return temp
End Sub
#End Region
