B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module

'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private mManager As UsbManager
	
	Private mUSBDeviceMap As Map
	Type MidiUSBDeviceType(Interface As UsbInterface,Device As UsbDevice,Connection As UsbDeviceConnection, _
	InEndPointList As List, OutEndPointList As List)
	
	Private ThisDevice As MidiUSBDeviceType
	Private CalledFromIntent As Boolean
	Private mUSBAvailable As Boolean								'Ignore
	Private mInitialized As Boolean
End Sub
Sub Initialize
	If mInitialized Then Return
	mManager.Initialize
	mInitialized = True
End Sub
Public Sub IsInitialized As Boolean
	Return mInitialized
End Sub
Sub NewDevice As MidiUSBDeviceType
	Dim ND As MidiUSBDeviceType
	ND.Initialize
	ND.InEndPointList.Initialize
	ND.OutEndPointList.Initialize
	Return ND
End Sub
'Get attached USB devices
Sub GetDevices As Boolean
	
	mUSBDeviceMap.Initialize
	Dim USBDevices() As UsbDevice
	USBDevices = mManager.GetDevices

	'Iterate over devices and find the correct one
	For i = 0 To USBDevices.Length - 1
		Dim ThisDevice As MidiUSBDeviceType = NewDevice
		ThisDevice.Device = USBDevices(i)
		
		'Check if the interface is the one we want
		GetInterface(ThisDevice.Device)
	Next

	'If not initialized (didn't find a suitable device)
	If USBDeviceMap.Size = 0 Then 
		Log("USB Midi Devices not found.")
		Return False
	End If
	ThisDevice = Null
	Return True
End Sub
Sub GetInterface(ud As UsbDevice) As Boolean
	CalledFromIntent = False
	If ThisDevice = Null Or Not(ThisDevice.IsInitialized) Then
		CalledFromIntent = True
		Dim ThisDevice As MidiUSBDeviceType = NewDevice
		ThisDevice.Device = ud
	End If
	Dim Found As Boolean
	'Iterate over interfaces
	For a = 0 To ThisDevice.Device.InterfaceCount - 1
	 Dim inter As UsbInterface
	 inter = ThisDevice.Device.GetInterface(a)
	 'Is it a midi USB device?
	 If inter.InterfaceClass = 1 And inter.InterfaceSubclass = 3 Then
	 	Found = True
	    'Found our device and interface
	    ThisDevice.Interface = inter
	    'Find correct endpoints
	    For b = 0 To ThisDevice.Interface.EndpointCount - 1
	       Dim endpoint As UsbEndpoint
	       endpoint = ThisDevice.Interface.GetEndpoint(b)
	       If endpoint.Type = mManager.USB_ENDPOINT_XFER_BULK Then
	          If endpoint.Direction = mManager.USB_DIR_IN Then 
	             ThisDevice.InEndPointList.Add(endpoint)
	          Else If endpoint.Direction = mManager.USB_DIR_OUT Then
	             ThisDevice.OutEndPointList.Add(endpoint)
	          End If
	       End If
	    Next
	 End If
	Next
	If Found Then
		If Not(CalledFromIntent) Then
			'Check we have permission to use the device
			If mManager.HasPermission(ThisDevice.Device) = False Then
				mManager.RequestPermission(ThisDevice.Device)
				If mManager.HasPermission(ThisDevice.Device) = False Then 
					ToastMessageShow("Permission not granted",False)
					ThisDevice = Null
					Return False
				End If
			End If
		End If
		'Get the mConnection
		ThisDevice.Connection = mManager.OpenDevice(ThisDevice.Device, ThisDevice.Interface, True)
		If ThisDevice.Connection.IsInitialized Then
			mUSBAvailable = True
			mUSBDeviceMap.Put(ThisDevice.Device,ThisDevice)
			If CalledFromIntent Then MidiDevice_Static.AddUSBDevice(ThisDevice)
			ThisDevice = Null
			Return True
		Else
			Log("mConnection Failed")
			mUSBAvailable = False
			ThisDevice = Null
			Return False
		End If
	End If
	'Return result
	ThisDevice = Null
	Return Found
End Sub
Public Sub OutEndPointList(Device As UsbDevice) As List
	Dim USBD As MidiUSBDeviceType =  USBDeviceMap.get(Device)
	Return USBD.OutEndPointList
End Sub
Public Sub OutEndPoint(Device As UsbDevice) As Int
	Dim USBD As MidiUSBDeviceType =  USBDeviceMap.get(Device)
	Return USBD.OutEndPointList.Get(0)
End Sub
Public Sub InEndPointList(Device As UsbDevice) As List
	Dim USBD As MidiUSBDeviceType =  USBDeviceMap.get(Device)
	Return USBD.InEndPointList
End Sub
Public Sub InEndPoint(Device As UsbDevice) As Int
	Dim USBD As MidiUSBDeviceType =  USBDeviceMap.get(Device)
	Return USBD.InEndPointList.Get(0)
End Sub
Public Sub Connection(Device As UsbDevice) As UsbDeviceConnection
	Dim USBD As MidiUSBDeviceType =  USBDeviceMap.get(Device)
	Return USBD.Connection
End Sub
Public Sub Interface(Device As UsbDevice) As UsbInterface
	Dim USBD As MidiUSBDeviceType =  USBDeviceMap.get(Device)
	Return USBD.Interface
End Sub
Public Sub GetUSBAvailable As Boolean
	Return mUSBAvailable
End Sub
Public Sub SetUSBAvailable(Avail As Boolean)
	mUSBAvailable = Avail
End Sub
Sub USBDeviceMap As Map
	Return mUSBDeviceMap
End Sub
Public Sub RemoveUSBDevice(ud As UsbDevice) As MidiDeviceInfo
	
	If Not(MidiDevice_Static.IsInitialized) Then Return Null
	For Each MDI As MidiDeviceInfo In MidiDevice_Static.getDeviceList
		
		If MDI.Driver <> MidiDevice_Static.DRIVER_USB Then Continue
		If MDI.USBDeviceType.Device = ud Then
		
			Select MDI.DevType
			
				Case MidiDevice_Static.DEVICE_RECEIVER
		
					MidiDevice_Static.RemoveDriverReceiver(MDI,True)
					
					
				Case MidiDevice_Static.DEVICE_TRANSMITTER
		
					MidiDevice_Static.RemoveDriverTransmitter(MDI,True)
			End Select
			
			'Close the connection for this device
'			Dim ConnJO As JavaObject = MDI.USBDeviceType.Connection
'			Log(ConnJO)
'			ConnJO = ConnJO.GetField("connection")
'			ConnJO.RunMethod("close",Null)
			
'			Dim R As Reflector
'			R.Target = MDI.USBDeviceType.Connection
'			Dim ConnJO As JavaObject = R.GetField("connection")
'			ConnJO.RunMethod("close",Null)
		End If
		
		mUSBDeviceMap.Remove(MDI.USBDeviceType.Device)
	Next
	
	
	If mUSBDeviceMap.Size = 0 Then mUSBAvailable = False
	Return MDI
End Sub
