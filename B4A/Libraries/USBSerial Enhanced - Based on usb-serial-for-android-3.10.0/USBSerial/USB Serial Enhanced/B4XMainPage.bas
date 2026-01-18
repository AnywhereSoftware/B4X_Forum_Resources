B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

'https://github.com/mik3y/usb-serial-For-android

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private USBSerial As USBSerialEnhanced
	Private LstDevices As ListView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	USBSerial.Initialize("USBSerial")
	USBSerial.SetDebugLogging = True
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub BtnOpen_Click	
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim SelectedDevice As Map = USBSerial.GetConnectedUsbDevices.Get(0)
	Dim VID As Int = SelectedDevice.Get("VID")
	Dim PID As Int = SelectedDevice.Get("PID")

	If USBSerial.HasPermission(VID, PID) Then
		USBSerial.SelectDeviceByIndex = 0
   
		If USBSerial.Open Then
			USBSerial.SetParameters(115200, 8, 1, 0)
			Log("Port Opened Successfully")
		Else
			Log("Open failed!")
			XUI.MsgboxAsync("Could not start communication. Please reconnect the device.", "Hardware Error")
		End If
	Else
		USBSerial.RequestPermission(VID, PID)
	End If
End Sub

Private Sub BtnClose_Click
	USBSerial.Close
End Sub

Private Sub BtnSend_Click
	If USBSerial.IsConnected Then
		'Define the text or number that you want to send
		Dim Message As String = $"Hello B4X Developers...${Chr(13)}${Chr(10)}The B4X community is great...${Chr(13)}${Chr(10)}"$ 'Adding CR LF for line termination
		USBSerial.Write(Message.GetBytes("UTF8"))
	Else
		Log("Cannot write: USB is not connected.")
	End If
End Sub

Private Sub BtnList_Click
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim L As List = USBSerial.GetConnectedUsbDevices
	For Each m As Map In L
		Log(m)
	Next
End Sub

Private Sub BtnEncryptString_Click
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim Encoded As String = USBSerial.EncodeBase64FromString("www.b4x.com")
	Log(Encoded)
End Sub

Private Sub BtnDecryptString_Click
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then Return

	Dim Decode As String = USBSerial.DecodeBase64ToString("d3d3LmI0eC5jb20=")
	Log(Decode)
End Sub

Private Sub BtnExtraTest_Click
	If USBSerial.IsConnected Then
		ExtraTest
	Else
		Log("Cannot write: USB is not connected.")
	End If
End Sub

Private Sub USBSerial_PermissionGranted
	Log("Permission granted")
End Sub

Private Sub USBSerial_PermissionDenied
	Log("Permission Denied")
End Sub

Private Sub USBSerial_Open(Vid As Int, Pid As Int, Serial As String, PortName As String)
	Log($"Open: Vid: ${Vid}, Pid: ${Pid}, Serial: ${Serial}, Portname: ${PortName}"$)
End Sub

Private Sub USBSerial_Closed(Vid As Int, Pid As Int, Serial As String, PortName As String)
	Log($"Closed: Vid: ${Vid}, Pid: ${Pid}, Serial: ${Serial}, Portname: ${PortName}"$)
End Sub

Private Sub USBSerial_SentData (Data() As Byte)
	Log($"Successfully sent ${Data.Length} bytes to the device."$)
'	Log(BytesToString(Data, 0, Data.Length, "UTF8"))
End Sub

Private Sub USBSerial_NewData (Data() As Byte)
	Dim s As String = BytesToString(Data, 0, Data.Length, "UTF8")
	Dim lines() As String = Regex.Split(Chr(13) & Chr(10), s)

	For Each line As String In lines
		If line.Length > 0 Then
			Log($"Received: ${line}"$)
		End If
	Next
End Sub

Private Sub USBSerial_Error (Message As String)
	Log(Message)
End Sub

Public Sub UpdateDeviceList
	Dim L As List = USBSerial.GetConnectedUsbDevices
	LstDevices.Clear

	For Each m As Map In L
		LstDevices.SingleLineLayout.Label.TextSize = 18
		LstDevices.SingleLineLayout.Label.TextColor = Colors.Black
		LstDevices.AddSingleLine($"VID=${m.Get("VID")} PID=${m.Get("PID")} Class=${m.Get("Class")}"$)
	Next
End Sub

Sub ExtraTest
	USBSerial.Close 'Need to be closed before setting UseAsyncMode to False
	USBSerial.UseAsyncMode = False 'Disables _NewData event from firing
	USBSerial.Open 'Can now open again
	Sleep(25)

	USBSerial.Write("Hello Peter".GetBytes("UTF8"))
	Sleep(25)

	Dim Data(64) As Byte	
	Dim Count As Int = USBSerial.ReadBlocking(Data, 500)
	If Count > 0 Then 'Read and display the converted data in the logs. _NewData event not needed.
		Log("HEX: " & USBSerial.BytesToHex(Data, 0, Count))
	Else
		Log("No data received")
	End If

	USBSerial.Close 'Need to be closed before setting UseAsyncMode to true
	USBSerial.UseAsyncMode = True 'Enables _NewData event to fire.
	USBSerial.Open 'Can now open again
	Sleep(25)

	'--------------------------------------------------------------------
	
	Try
		USBSerial.PurgeHwBuffers(True, True)
		Log("Hardware buffers purged")
	Catch
		Log(LastException)
	End Try

	'--------------------------------------------------------------------

	Dim f As Float = 123.45
	Dim b() As Byte = USBSerial.FloatToBytes(f)
	Log("Float as bytes: " & USBSerial.BytesToHex(b, 0, b.Length))

	'--------------------------------------------------------------------

	Dim b() As Byte = Array As Byte(0x41, 0xBE, 0x00, 0x00)
	Dim f As Float = USBSerial.BytesToFloat(b)
	Log("Float value: " & f)

	'--------------------------------------------------------------------

	Dim value As Int = 12345
	Dim b() As Byte = USBSerial.Int32ToBytes(value)
	Log("Int32 bytes: " & USBSerial.BytesToHex(b, 0, b.Length))

	'--------------------------------------------------------------------

	Dim b() As Byte = Array As Byte(0x00, 0x01, 0xE2, 0x40)
	Dim value As Int = USBSerial.BytesToInt32(b)
	Log("Int32 value: " & value)

	'--------------------------------------------------------------------

	Dim high As Int = 0x1234
	Dim low As Int = 0xABCD
	Dim combined As Int = USBSerial.CombineTo32Bit(high, low)
	Log("Combined: " & NumberFormat(combined, 1, 0))

	'--------------------------------------------------------------------

	Dim high As Int = 0x1234
	Dim low As Int = 0xABCD
	Dim f As Float = USBSerial.GetFloat32(high, low)
	Log("Float32: " & f)

	'--------------------------------------------------------------------

	Dim original As Int = 0x12345678
	Dim swapped As Int = USBSerial.Swap32BitEndianness(original)
	Log("Swapped: " & Bit.ToHexString(swapped))

	'--------------------------------------------------------------------

	Dim b() As Byte = Array As Byte(16, 32, 64, 128, 255)
	Dim hex As String = USBSerial.BytesToHex(b, 0, b.Length)
	Log("Hex: " & hex)

	'--------------------------------------------------------------------

	Dim hex As String = "10204080FF"
	Dim b() As Byte = USBSerial.HexToBytes(hex)
	Log($"Values signed: ${b(0)}, ${b(1)}, ${b(2)}, ${b(3)}, ${b(4)}"$)
	Log($"Values unsigned: ${Bit.And(b(0), 0xFF)}, ${Bit.And(b(1), 0xFF)}, ${Bit.And(b(2), 0xFF)}, ${Bit.And(b(3), 0xFF)}, ${Bit.And(b(4), 0xFF)}"$)
End Sub
