B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private USBSerial As USBSerialEnhanced
	Private LstDevices As ListView
	Private TxtLog As B4XView
	Private SpnPorts As Spinner
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.SetTitle(Me, "USBSerial Enhanced")

	USBSerial.Initialize("USBSerial")
	USBSerial.SetDebugLogging = True
	
	UpdateDeviceList
	'If USBSerial.GetConnectedUsbDevices.Size > 0 Then DeviceCount
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub BtnOpen_Click	
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim SelectedDevice As Map = USBSerial.GetConnectedUsbDevices.Get(0)
	Dim VID As Int = SelectedDevice.Get("VID")
	Dim PID As Int = SelectedDevice.Get("PID")

	If USBSerial.HasPermission(VID, PID) Then
		USBSerial.SelectDeviceByIndex = SpnPorts.SelectedIndex 'Default is 0
		If USBSerial.Open Then
			USBSerial.SetParameters(19200, 8, 1, 0)
			LogToScreen("Port Opened Successfully")
		Else
			LogToScreen("Open failed!")
			XUI.MsgboxAsync("Could not start communication. Please reconnect the device.", "Hardware Error")
		End If
	Else
		USBSerial.RequestPermission(VID, PID)
	End If
End Sub

Private Sub BtnClose_Click
	TxtLog.Text = ""
	USBSerial.Close
End Sub

Private Sub BtnSend_Click
	If USBSerial.IsConnected Then
		USBSerial.PrefixFraming = True
		'Define the text or number that you want to send
		Dim Message As String = $"Hello B4X Developers...${CRLF}The B4X community is great...${CRLF}"$ 'Adding CR LF (Chr(13) & Chr(10)) for line termination
		USBSerial.Write(Message.GetBytes("UTF8"))
	Else
		LogToScreen("Cannot write: USB is not connected.")
	End If
End Sub

Private Sub BtnList_Click
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim L As List = USBSerial.GetConnectedUsbDevices
	For Each m As Map In L
		LogToScreen(m)
	Next
End Sub

Private Sub BtnEncryptString_Click
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim Encoded As String = USBSerial.EncodeBase64FromString("www.b4x.com")
	LogToScreen(Encoded)
End Sub

Private Sub BtnDecryptString_Click
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim Decode As String = USBSerial.DecodeBase64ToString("d3d3LmI0eC5jb20=")
	LogToScreen(Decode)
End Sub

Private Sub BtnExtraTest_Click
	If USBSerial.IsConnected Then
		ExtraTest
	Else
		LogToScreen("Cannot write: USB is not connected.")
	End If
End Sub

Private Sub BtnClearLogs_Click
	TxtLog.Text = ""
End Sub

Private Sub USBSerial_PermissionGranted
	LogToScreen("Permission granted")
End Sub

Private Sub USBSerial_PermissionDenied
	LogToScreen("Permission Denied")
End Sub

Private Sub USBSerial_Open(Vid As Int, Pid As Int, Serial As String, PortName As String)
	LogToScreen($"Port Count: ${USBSerial.GetPortCount}"$) 'GetPortCount only works after the device is open and is for multi‑port devices
	LogToScreen($"Open: Vid: ${Vid}, Pid: ${Pid}, Serial: ${Serial}, Portname: ${PortName}"$)
End Sub

Private Sub USBSerial_Closed(Vid As Int, Pid As Int, Serial As String, PortName As String)
	LogToScreen($"Closed: Vid: ${Vid}, Pid: ${Pid}, Serial: ${Serial}, Portname: ${PortName}"$)
End Sub

Private Sub USBSerial_SentData (Data() As Byte)
	LogToScreen($"Successfully sent ${Data.Length} bytes to the device."$)
'	DataSentReceived(Data)

'	Dim s As String = BytesToString(Data, 0, Data.Length, "UTF8")
'	Dim lines() As String = Regex.Split(CRLF, s) 'Chr(13) & Chr(10)
'
'	For Each line As String In lines
'		If line.Length > 0 Then
'			LogToScreen($"Received: ${line}"$)
'		End If
'	Next
End Sub

Private Sub USBSerial_NewData (Data() As Byte)
'	LogToScreen($"Successfully received ${Data.Length} bytes from the device."$)
	DataSentReceived(Data)

'	Dim s As String = BytesToString(Data, 0, Data.Length, "UTF8")
'	Dim lines() As String = Regex.Split(CRLF, s) ''Chr(13) & Chr(10)
	'
'	For Each line As String In lines
'		If line.Length > 0 Then
'			LogToScreen($"Received: ${line}"$)
'		End If
'	Next
End Sub

Private Sub DataSentReceived (Data() As Byte)
	Dim s As String = BytesToString(Data, 0, Data.Length, "UTF8")
	Dim lines() As String = Regex.Split(CRLF, s) 'Chr(13) & Chr(10)

	For Each line As String In lines
		If line.Length > 0 Then
			LogToScreen($"Received: ${line}"$)
		End If
	Next
End Sub

Private Sub USBSerial_Error (Message As String)
	LogToScreen(Message)
End Sub

Public Sub UpdateDeviceList
	SpnPorts.Clear
	LstDevices.Clear

	Dim L As List = USBSerial.GetConnectedUsbDevices

	For Each m As Map In L
		LstDevices.SingleLineLayout.Label.TextSize = 18
		LstDevices.SingleLineLayout.Label.TextColor = Colors.Black
		LstDevices.AddSingleLine($"VID=${m.Get("VID")} PID=${m.Get("PID")} Class=${m.Get("Class")}"$)
	Next

	For Each DeviceMap As Map In USBSerial.RefreshDevices
		Dim VID As Int = DeviceMap.Get("VID")
		Dim PID As Int = DeviceMap.Get("PID")
		Dim Manufacturer As String = DeviceMap.Get("Manufacturer")
		Dim Product As String = DeviceMap.Get("Product")
		Dim Serial As String = DeviceMap.Get("Serial")

		LogToScreen($"Found Device: ${Manufacturer} ${Product} (VID: ${VID}, PID: ${PID}, Serial: ${Serial})"$)
	Next

	If USBSerial.GetConnectedUsbDevices.Size > 0 Then DeviceCount
End Sub

Private Sub DeviceCount
	SpnPorts.Clear
	

	Dim PortCount As Int = USBSerial.GetSerialDeviceCount
	Dim PortCount As Int = USBSerial.EnumerateDevices.Size
	'Add ports values to the spinner.			
	For i = 0 To PortCount - 1
		SpnPorts.Add(i)
	Next
	
	'--------------------------------------------------------------------

	'Map custom IDs examples
'	USBSerial.AddCustomDevice(6790, 29987, "Ch34xSerialDriver")
'	USBSerial.AddCustomDevice(4292, 60000, "Cp21xxSerialDriver")


'	'UNCOMMANT ALL THE LINES BELOW FOR MORE DEVICE/PORT COUNT INFORMATION 
'
'	'Get the list of all hardware connected to the hub/phone
'	Dim DeviceList As List = USBSerial.GetConnectedUsbDevices
'
'	LogToScreen($"Found ${DeviceList.Size} physical devices."$)
'
'	'Loop through every device found
'	For i = 0 To DeviceList.Size - 1	
'		'Select the current device in the loop
'		USBSerial.SelectDeviceByIndex = i
'
'		'Get the ports for this specific device
'		LogToScreen($"Device ${i} has ${PortCount} port(s):"$)
'
'		'Loop through the ports of this specific device
'		For j = 0 To PortCount - 1
'			Dim PName As String = USBSerial.GetPortName(j)
'			LogToScreen($" -> Port ${j}: ${PName}"$)
'		Next
'	Next
End Sub

Private Sub ExtraTest
	USBSerial.Close 'Need to be closed before setting UseAsyncMode to False
	USBSerial.UseAsyncMode = False 'Disables _NewData event from firing
	USBSerial.Open 'Can now open again
	Sleep(25)

	USBSerial.Write("Hello Peter".GetBytes("UTF8"))
	Sleep(25)

	Dim Data(64) As Byte	
	Dim Count As Int = USBSerial.ReadBlocking(Data, 500)
	If Count > 0 Then 'Read and display the converted data in the logs. _NewData event not needed.
		LogToScreen("HEX: " & USBSerial.BytesToHex(Data, 0, Count))
	Else
		LogToScreen("No data received")
	End If

	USBSerial.Close 'Need to be closed before setting UseAsyncMode to true
	USBSerial.UseAsyncMode = True 'Enables _NewData event to fire.
	USBSerial.Open 'Can now open again
	Sleep(25)

	'--------------------------------------------------------------------
	
	Try
		USBSerial.PurgeHwBuffers(True, True)
		LogToScreen("Hardware buffers purged")
	Catch
		LogToScreen(LastException)
	End Try

	'--------------------------------------------------------------------

	Dim f As Float = 123.45
	Dim b() As Byte = USBSerial.FloatToBytes(f)
	LogToScreen("Float as bytes: " & USBSerial.BytesToHex(b, 0, b.Length))

	'--------------------------------------------------------------------

	Dim b() As Byte = Array As Byte(0x41, 0xBE, 0x00, 0x00)
	Dim f As Float = USBSerial.BytesToFloat(b)
	LogToScreen("Float value: " & f)

	'--------------------------------------------------------------------

	Dim value As Int = 12345
	Dim b() As Byte = USBSerial.Int32ToBytes(value)
	LogToScreen("Int32 bytes: " & USBSerial.BytesToHex(b, 0, b.Length))

	'--------------------------------------------------------------------

	Dim b() As Byte = Array As Byte(0x00, 0x01, 0xE2, 0x40)
	Dim value As Int = USBSerial.BytesToInt32(b)
	LogToScreen("Int32 value: " & value)

	'--------------------------------------------------------------------

	Dim high As Int = 0x1234
	Dim low As Int = 0xABCD
	Dim combined As Int = USBSerial.CombineTo32Bit(high, low)
	LogToScreen("Combined: " & NumberFormat(combined, 1, 0))

	'--------------------------------------------------------------------

	Dim high As Int = 0x1234
	Dim low As Int = 0xABCD
	Dim f As Float = USBSerial.GetFloat32(high, low)
	LogToScreen("Float32: " & f)

	'--------------------------------------------------------------------

	Dim original As Int = 0x12345678
	Dim swapped As Int = USBSerial.Swap32BitEndianness(original)
	LogToScreen("Swapped: " & Bit.ToHexString(swapped))

	'--------------------------------------------------------------------

	Dim b() As Byte = Array As Byte(16, 32, 64, 128, 255)
	Dim hex As String = USBSerial.BytesToHex(b, 0, b.Length)
	LogToScreen("Hex: " & hex)

	'--------------------------------------------------------------------

	Dim hex As String = "10204080FF"
	Dim b() As Byte = USBSerial.HexToBytes(hex)
	LogToScreen($"Values signed: ${b(0)}, ${b(1)}, ${b(2)}, ${b(3)}, ${b(4)}"$)
	LogToScreen($"Values unsigned: ${Bit.And(b(0), 0xFF)}, ${Bit.And(b(1), 0xFF)}, ${Bit.And(b(2), 0xFF)}, ${Bit.And(b(3), 0xFF)}, ${Bit.And(b(4), 0xFF)}"$)
End Sub

'DISPLAY MESSAGES IN THE ON-SCREEN LOG AND SYSTEM LOG
Public Sub LogToScreen(Msg As Object)
	Log(Msg)
	TxtLog.Text = TxtLog.Text & Msg & CRLF
	TxtLog.SelectionStart = TxtLog.Text.Length
End Sub
