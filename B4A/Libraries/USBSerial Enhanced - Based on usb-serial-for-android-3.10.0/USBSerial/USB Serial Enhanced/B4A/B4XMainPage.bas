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
	Private ReceiveBuffer As StringBuilder
	Private LstDevices As ListView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	ReceiveBuffer.Initialize

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
		USBSerial.DevicePort = 0
		If USBSerial.Open Then
			USBSerial.SetParameters(115200, 8, 1, 0)
		End If
	Else
		Log("Cannot open: permission not granted yet.")
	End If
End Sub

Private Sub BtnClose_Click
	USBSerial.Close
End Sub

Private Sub BtnSend_Click
	If USBSerial.IsConnected Then
		' Define the text you want to send
		Dim Message As String = "Hello B4X Developers" & Chr(13) & Chr(10) ' Adding CR LF for line termination

		' Convert the string to a Byte Array
		Dim Data() As Byte = Message.GetBytes("UTF8")
		USBSerial.Write(Data)
	Else
		Log("Cannot write: USB is not connected.")
	End If
End Sub

Private Sub BtnList_Click
	Dim L As List = USBSerial.GetConnectedUsbDevices
	For Each m As Map In L
		Log(m)
	Next
End Sub

Private Sub USBSerial_PermissionGranted
	Log("Permission granted")

'	USBSerial.DevicePort = 0
'
'	If USBSerial.Open Then
'		USBSerial.SetParameters(115200, 8, 1, 0)
'	Else
'		Log("Open failed after permission granted.")
'	End If
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
	Log("Successfully sent " & Data.Length & " bytes to the device.")
'	Log(BytesToString(Data, 0, Data.Length, "UTF8"))
End Sub

Private Sub USBSerial_NewData (Data() As Byte)	
	' Convert raw bytes to text
	Dim Chunk As String = BytesToString(Data, 0, Data.Length, "UTF8")
    
	' Append to buffer
	ReceiveBuffer.Append(Chunk)
    
	' Process all complete CRLF-terminated lines
	Do While ReceiveBuffer.ToString.Contains(Chr(13) & Chr(10))
		Dim Full As String = ReceiveBuffer.ToString
		Dim Idx As Int = Full.IndexOf(Chr(13) & Chr(10))
        
		' Extract the complete line (without CRLF)
		Dim Line As String = Full.SubString2(0, Idx)
        
		' Remove processed part from buffer
		ReceiveBuffer.Remove(0, Idx + 2)   ' +2 removes CRLF
        
		' Log the reconstructed message
		Log("Received: " & Line)
	Loop
End Sub

Sub USBSerial_DeviceAttached(VID As Int, PID As Int, Class As Int, Product As String, Manufacturer As String, Serial As String)
	Log($"Device Attached: VID=${VID}, PID=${PID}, Class=${Class}, Product=${Product}, Manufacturer=${Manufacturer}, Serial=${Serial}"$)

	' Find the device in the list
	Dim Devices As List = USBSerial.GetConnectedUsbDevices
	For Each d As Map In Devices
		If d.Get("VID").As(Int) = VID And d.Get("PID").As(Int) = PID Then
			' Check permission
			If USBSerial.HasPermission(VID, PID) Then
				Log("Permission already granted.")
			Else
				Log("Requesting USB permission...")
				USBSerial.RequestPermission(VID, PID)
			End If

		End If
	Next

	UpdateDeviceList
End Sub

Private Sub USBSerial_DeviceDetached(Vid As Int, Pid As Int, Class As Int, Product As String, Manufacturer As String, Serial As String)
'	Log($"Detached: VID=${Vid}, PID=${Pid}"$)
    Log($"Detached Detached: VID=${Vid}, PID=${Pid}, Class=${Class}, Product=${Product}, Manufacturer=${Manufacturer}, Serial=${Serial}"$)	
	
	If USBSerial.GetConnectedUsbDevices.Size = 0 Then USBSerial.Close

	UpdateDeviceList
End Sub

Private Sub USBSerial_Error (Message As String)
	Log(Message)
End Sub

Sub UpdateDeviceList
	Dim L As List = USBSerial.GetConnectedUsbDevices
	LstDevices.Clear

	For Each m As Map In L
		LstDevices.SingleLineLayout.Label.TextSize = 18
		LstDevices.SingleLineLayout.Label.TextColor = Colors.Black
		LstDevices.AddSingleLine($"VID=${m.Get("VID")} PID=${m.Get("PID")} Class=${m.Get("Class")}"$)
	Next
End Sub
