B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module
#IgnoreWarnings:12
'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private mDeviceList As List
	'Private FriendlyNameMap As Map
	Type MidiDeviceInfo(Name As String,Description As String,Vendor As String,Version As String,Index As Int,Driver As Int,USBDeviceType As MidiUSBDeviceType, _
	DevType As String,USBEndP As UsbEndpoint,FriendlyName As String,Transmitter As MidiTransmitter,Receiver As MidiReceiver,Module As Object)
	
	Private DefaultReceiver As MidiDeviceInfo
	
	Public Const DEVICE_TRANSMITTER As String = "tra"
	Public Const DEVICE_RECEIVER As String = "rec"
	Public Const DEVICE_SYNTH As String = "syn"
	
	Public Const DRIVER_NONE As Int = 0
	Public Const DRIVER_SYSINTERNAL As Int = 1
	Public Const DRIVER_USB As Int = 2
	Public Const DRIVER_INTERNAL As Int = 3
	
	Private mReceiverDriverMap As Map
	Private mTransmitterDriverMap As Map
	
	Private mInitialized As Boolean
	
End Sub

Sub Initialize

	DefaultReceiver.Initialize
	
	DefaultReceiver.Name = "OnBoard Receiver"
	DefaultReceiver.Description = "Android GM Midi Receiver"
	DefaultReceiver.Vendor = "Default"
	DefaultReceiver.Version = "1"
	DefaultReceiver.Index = 0
	DefaultReceiver.Driver = DRIVER_SYSINTERNAL
	DefaultReceiver.FriendlyName = "OnBoard Out"
	DefaultReceiver.DevType = DEVICE_RECEIVER
	
	mReceiverDriverMap.Initialize
	mTransmitterDriverMap.Initialize
	
	mInitialized = True
	
	BuildDeviceList
End Sub
'@SLHide
Sub getReceiverDriverMap As Map
	Return mReceiverDriverMap
End Sub
'@SLHide
Sub getTransmitterDriverMap As Map
	Return mTransmitterDriverMap
End Sub
'Returns an array of available devices
Sub getDeviceList() As MidiDeviceInfo()
	Try
		If mDeviceList.Size = 0 Then MidiLibUtils.ThrowException("MidiDevice_Static must be Initialized")
	Catch
		MidiLibUtils.ThrowException("MidiDevice_Static No Defaults Created")
	End Try
	
	Dim RetArray(mDeviceList.Size) As MidiDeviceInfo
	For I = 0 To mDeviceList.Size - 1
		RetArray(I) = mDeviceList.get(I)
	Next
	Return RetArray
End Sub

'Returns the default receiver Device
Sub GetDefaultReceiverDevice As MidiDeviceInfo
	If Not(DefaultReceiver.Receiver.IsInitialized) Then
		Dim R As MidiReceiver
		R.Initialize(DefaultReceiver)
'		DefaultReceiver.Receiver = R
	End If
	Return DefaultReceiver
End Sub

Private Sub BuildDeviceList
	mDeviceList.Initialize
	mDeviceList.Add(DefaultReceiver)
	AddUsb
End Sub
Private Sub AddUsb 
	If MidiUSBManager_Static.GetDevices Then
		For Each USBD As MidiUSBDeviceType In MidiUSBManager_Static.USBDeviceMap.Values
			AddUSBDevice(USBD)
		Next
	End If
End Sub
Sub AddUSBDevice(USBD As MidiUSBDeviceType)
	
			For Each OutEndPoint As UsbEndpoint In USBD.OutEndPointList
				Dim MDI As MidiDeviceInfo
				MDI.Initialize
				MDI.Name = USBD.Device.DeviceName
				MDI.FriendlyName = "USB Out"
				MDI.Description = USBD.Device.ProductID
				MDI.Vendor = USBD.Device.VendorID
				MDI.Version = "Unknown"
				MDI.Driver = DRIVER_USB
				MDI.UsbDeviceType = USBD
				MDI.Index = mDeviceList.Size
				MDI.DevType = DEVICE_RECEIVER
				MDI.USBEndP = OutEndPoint
				
				Dim R As MidiReceiver
				R.Initialize(MDI)
				
				mDeviceList.Add(MDI)
				
				Dim MDIList As List
				MDIList.Initialize
				MDIList.Add(MDI)
				mReceiverDriverMap.Put(MDI.USBDeviceType.Device,MDIList)
			Next
			


			For Each InEndPoint As UsbEndpoint In USBD.InEndPointList
				Dim MDI As MidiDeviceInfo
				MDI.Initialize
				MDI.Name = USBD.Device.DeviceName
				MDI.FriendlyName = "USB In"
				MDI.Description = USBD.Device.ProductID
				MDI.Vendor = USBD.Device.VendorID
				MDI.Version = "Unknown"
				MDI.Driver = DRIVER_USB
				MDI.UsbDeviceType = USBD
				MDI.Index = mDeviceList.Size
				MDI.DevType = DEVICE_TRANSMITTER
				MDI.USBEndP = InEndPoint
				
				Dim T As MidiTransmitter
				T.Initialize(MDI)

				mDeviceList.Add(MDI)
				
				Dim MDIList As List
				MDIList.Initialize
				MDIList.Add(MDI)
				mTransmitterDriverMap.Put(MDI.USBDeviceType.Device,MDIList)
			Next

End Sub

'Adds a transmitter to the device list
Sub RegisterTransmitter(Name As String, Description As String,FriendlyName As String,Module As Object) As MidiDeviceInfo
	
	Dim MDI As MidiDeviceInfo
	MDI.Initialize
	MDI.Name = Name
	MDI.Description = Description
	MDI.FriendlyName = FriendlyName
	MDI.Index = mDeviceList.Size
	MDI.Driver = DRIVER_INTERNAL
	MDI.Module = Module
	MDI.DevType = DEVICE_TRANSMITTER
	mDeviceList.Add(MDI)
	Dim T As MidiTransmitter
	T.Initialize(MDI)
	Return MDI
End Sub
'Adds a receiver to the device list
Sub RegisterReceiver(Name As String, Description As String,FriendlyName As String,Module As Object) As MidiDeviceInfo
	Dim MDI As MidiDeviceInfo
	MDI.Initialize
	MDI.Name = Name
	MDI.Description = Description
	MDI.FriendlyName = FriendlyName
	MDI.Index = mDeviceList.Size
	MDI.Driver = DRIVER_INTERNAL
	MDI.Module = Module
	MDI.DevType = DEVICE_RECEIVER
	mDeviceList.Add(MDI)
	Dim R As MidiReceiver
	R.Initialize(MDI)
	Return MDI
End Sub
Sub IsInitialized As Boolean
	Return mInitialized
End Sub
Sub GetDriverReceiver(MDI As MidiDeviceInfo) As MidiReceiver
	
	Select MDI.Driver
		
		Case DRIVER_SYSINTERNAL
			Dim MDIList As List = mReceiverDriverMap.get(MDI.Driver)
			If MDIList.IsInitialized Then
				'Return the receiver from the first item in the list as they are all using the same driver
				Dim ThisMDI As MidiDeviceInfo = MDIList.get(0)
				Return ThisMDI.Receiver
			Else
				Dim R As MidiReceiver
				Return R
			End If
			
		Case DRIVER_USB
			Dim MDIList As List = mReceiverDriverMap.get(MDI.USBDeviceType.Device)
			If MDIList.IsInitialized Then
				'Return the receiver from the first item in the list as they are all using the same driver
				Dim ThisMDI As MidiDeviceInfo = MDIList.get(0)
				Return ThisMDI.Receiver
			Else
				Dim R As MidiReceiver
				Return R
			End If
			
		Case DRIVER_INTERNAL
			Dim MDIList As List = mReceiverDriverMap.get(MDI.Module)
			If MDIList.IsInitialized Then
				Dim ThisMDI As MidiDeviceInfo = MDIList.get(0)
				Return ThisMDI.Receiver
			Else
				Dim R As MidiReceiver
				Return R
			End If
	End Select
	
	Dim R As MidiReceiver
	Return R
End Sub
'@SLHide
Sub AddDriverReceiver(MDI As MidiDeviceInfo)
	Select MDI.Driver
		
		Case DRIVER_SYSINTERNAL
			Dim MDIList As List = mReceiverDriverMap.get(MDI.Driver)
			If MDIList.IsInitialized Then
				'Check it's not already in the list
				If MDIList.IndexOf(MDI) = -1 Then
					MDIList.Add(MDI)
				End If
			Else
				MDIList.Initialize
				MDIList.Add(MDI)
				mReceiverDriverMap.Put(MDI.Driver,MDIList)
			End If
			
		Case DRIVER_USB
			Dim MDIList As List = mReceiverDriverMap.get(MDI.USBDeviceType.Device)
			If MDIList.IsInitialized Then
				'Check it's not already in the list
				If MDIList.IndexOf(MDI) = -1 Then
					MDIList.Add(MDI)
				End If
			Else
				MDIList.Initialize
				MDIList.Add(MDI)
				mReceiverDriverMap.Put(MDI.USBDeviceType.Device,MDIList)
			End If
			
			
		Case DRIVER_INTERNAL
			Dim MDIList As List = mReceiverDriverMap.get(MDI.Module)
			If MDIList.IsInitialized Then
				'Check it's not already in the list
				If MDIList.IndexOf(MDI) = -1 Then
					MDIList.Add(MDI)
				End If
			Else
				MDIList.Initialize
				MDIList.Add(MDI)
				mReceiverDriverMap.Put(MDI.Module,MDIList)
			End If
	End Select
End Sub
'@SLHide
Sub AddDriverTransmitter(MDI As MidiDeviceInfo)
	Select MDI.Driver
		
		Case DRIVER_SYSINTERNAL
			Dim MDIList As List = mTransmitterDriverMap.get(MDI.Driver)
			If MDIList.IsInitialized Then
				'Check it's not already in the list
				If MDIList.IndexOf(MDI) = -1 Then
					MDIList.Add(MDI)
				End If
			Else
				MDIList.Initialize
				MDIList.Add(MDI)
				mTransmitterDriverMap.Put(MDI.Driver,MDIList)
			End If
			
		Case DRIVER_USB
			Dim MDIList As List = mTransmitterDriverMap.get(MDI.USBDeviceType.Device)
			If MDIList.IsInitialized Then
				'Check it's not already in the list
				If MDIList.IndexOf(MDI) = -1 Then
					MDIList.Add(MDI)
				End If
			Else
				MDIList.Initialize
				MDIList.Add(MDI)
				mTransmitterDriverMap.Put(MDI.USBDeviceType.Device,MDIList)
			End If
			
		Case DRIVER_INTERNAL
			Dim MDIList As List = mTransmitterDriverMap.get(MDI.Module)
			If MDIList.IsInitialized Then
				'Check it's not already in the list
				If MDIList.IndexOf(MDI) = -1 Then
					MDIList.Add(MDI)
				End If
			Else
				MDIList.Initialize
				MDIList.Add(MDI)
				mTransmitterDriverMap.Put(MDI.Module,MDIList)
			End If
	End Select
End Sub
'@SLHide
Sub RemoveDriverReceiver(MDI As MidiDeviceInfo,RemoveIfLast As Boolean)

	Dim MDIList As List
	Dim Pos As Int
	Select MDI.Driver
		
		Case DRIVER_SYSINTERNAL
			 MDIList = mReceiverDriverMap.get(MDI.Driver)
			If MDIList.IsInitialized Then
				 Pos = MDIList.IndexOf(MDI)
				If  Pos > -1 Then
					MDIList.RemoveAt(Pos)
				End If
			End If
			
		Case DRIVER_USB
			MDIList = mReceiverDriverMap.get(MDI.USBDeviceType.Device)
			If MDIList.IsInitialized Then
				 Pos = MDIList.IndexOf(MDI)
				If  Pos > -1 Then
					MDIList.RemoveAt(Pos)
				End If
			End If
			
		Case DRIVER_INTERNAL
			MDIList = mReceiverDriverMap.get(MDI.Module)
			Pos = MDIList.IndexOf(MDI)
			If  Pos > -1 Then
				MDIList.RemoveAt(Pos)
			End If
			
	End Select
	'We should stop the MidiReceiver if it's not being used 
	'(currently applies to the SysInternal driver and possibly ModuleInternalDriver if user implements it,
	'but dealt with by the receiver / user Module class)
	If RemoveIfLast AND MDIList.IsInitialized AND MDIList.Size = 0 Then 
		If MDI.Receiver.IsRunning Then MDI.Receiver.Stop
		'If it's a USB Device then that will no longer be available
		If MDI.Driver = DRIVER_USB Then 
			Dim Pos As Int = mDeviceList.IndexOf(MDI)
			If Pos > -1 Then mDeviceList.RemoveAt(Pos)
		End If
	End If

End Sub
'@SLHide
Sub RemoveDriverTransmitter(MDI As MidiDeviceInfo,RemoveIfLast As Boolean)
	
	Dim MDIList As List
	Dim Pos As Int
	Select MDI.Driver
		
		Case DRIVER_SYSINTERNAL
			 MDIList = mTransmitterDriverMap.get(MDI.Driver)
			If MDIList.IsInitialized Then
				 Pos = MDIList.IndexOf(MDI)
				If  Pos > -1 Then
					MDIList.RemoveAt(Pos)
				End If
			End If
			
		Case DRIVER_USB
			MDIList = mTransmitterDriverMap.get(MDI.USBDeviceType.Device)
			If MDIList.IsInitialized Then
				 Pos = MDIList.IndexOf(MDI)
				If  Pos > -1 Then
					MDIList.RemoveAt(Pos)
				End If
			End If
			
		Case DRIVER_INTERNAL
			MDIList = mTransmitterDriverMap.get(MDI.Module)
			Pos = MDIList.IndexOf(MDI)
			If  Pos > -1 Then
				MDIList.RemoveAt(Pos)
			End If
			
	End Select
	'We should stop the MidiTransmitter if it's not being used 
	'(currently applies to the USB driver and possibly ModuleInternalDriver if user implements it,
	'but dealt with by the receiver / user Module class)
	If RemoveIfLast AND MDIList.IsInitialized AND MDIList.Size = 0 Then 
		If MDI.Transmitter.IsRunning Then MDI.Transmitter.Stop
		'If it's a USB Device then that will no longer be available
		If MDI.Driver = DRIVER_USB Then mDeviceList.RemoveAt(mDeviceList.IndexOf(MDI))
		'MDI.Receiver = Null
	End If
	
End Sub