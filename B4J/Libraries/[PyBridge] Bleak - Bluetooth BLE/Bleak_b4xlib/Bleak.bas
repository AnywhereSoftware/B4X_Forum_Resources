B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.12
@EndOfDesignText@
#Event: DeviceFound  (Device as BleakDevice)
#Event: DeviceDisconnected  (DeviceId As String)
#Event: CharNotify (Notification As BleakNotification)
Sub Class_Globals
	Public Py As PyBridge
	Private scanner As PyWrapper
	Private mCallback As Object
	Private mEventName As String
	Type BleakDevice (Name As String, DeviceId As String, RSSI As Int, _
		ServiceUUIDS As List, ManufacturerData As Map, ServiceData As Map, TXPower As Int, BLEDevice As PyWrapper)
	
	Private BleakModule As PyWrapper
	Private Clients As List
	Private mIsScanning As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String, Bridge As PyBridge)
	mCallback = Callback
	mEventName = EventName
	Py = Bridge
	BleakModule = Py.ImportModule("bleak")
	Clients.Initialize
	Py.RunNoArgsCode($"
import asyncio
from bleak import BleakScanner
def scanner_callback(device, data):
	slot = bridge_instance.store_python_object(device)
	bridge_instance.raise_event("DeviceFound", {"address": device.address, "name": device.name,
		"rssi": data.rssi,
		"service_uuids": data.service_uuids,
	 	"mfg_data": data.manufacturer_data,
		"service_data": data.service_data, "tx": data.tx_power, "device_slot": slot})
def disconnect_callback(client):
	bridge_instance.raise_event("DeviceDisconnected", {"device": client.address})

def create_notify_callback(client_address, char):
	def callback(_ , data):
		bridge_instance.raise_event("CharNotify", {"client": client_address, "char_address": char.uuid, "data": data})
	return callback

"$)
	Py.SetEventMapping("DeviceFound", Me, "Py")
	Py.SetEventMapping("DeviceDisconnected", Me, "Py")
	Py.SetEventMapping("CharNotify", Me, "Py")
End Sub

'Enables debug logging.
Public Sub EnableDebugLogging As PyWrapper
	Dim Code As String = $"
import logging
import bleak
def EnableDebugLogging ():
	logging.basicConfig(level=logging.DEBUG)
	bleak_logger = logging.getLogger("bleak")
	bleak_logger.setLevel(logging.DEBUG)
"$
	Return Py.RunCode("EnableDebugLogging", Array(), Code)
End Sub

Private Sub Py_DeviceFound (Args As Map)
	CallSub2(mCallback, mEventName & "_devicefound", CreateBleakDevice(Args))
End Sub

Private Sub Py_DeviceDisconnected (Args As Map)
	CallSub2(mCallback, mEventName & "_devicedisconnected", Args.Get("device"))
End Sub

Private Sub Py_CharNotify(Args As Map)
	Dim n As BleakNotification
	n.Initialize
	n.CharacteristicUUID = Args.Get("char_address")
	n.ClientUUID = Args.Get("client")
	n.Value = Args.Get("data")
	CallSub2(mCallback, mEventName & "_CharNotify", n)
End Sub

'Scans for peripherals. Continues scanning until StopScan is called. Similar to scanning with AllowDuplicates = True in B4A.
'The DeviceFound event will be raised with each discovered device.
'ServiceUUIDs - optional list of services. Only devices advertising these services will be discovered.
'<code>Wait For (ble.Scan(Null)) Complete (Success As Boolean)</code>
Public Sub Scan (ServiceUUIDs As List) As ResumableSub
	StopScan
	scanner = BleakModule.Run("BleakScanner").Arg(Py.GetMember("scanner_callback"))
	If Initialized(ServiceUUIDs) Then scanner = scanner.Arg(ServiceUUIDs)
	Wait For (scanner.RunAwait("start", Null, Null)) Complete (Result As PyWrapper)
	If Result.IsSuccess Then mIsScanning = True
	Return InternalReturnSuccessFlag(Result)
End Sub

'Returns True if scanning.
Public Sub getIsScanning As Boolean
	Return mIsScanning
End Sub

'Stops scanning.
Public Sub StopScan
	mIsScanning = False
	If Initialized(scanner) Then
		scanner.RunAwait("stop", Null, Null)
	End If
	scanner = Null
End Sub


Private Sub CreateBleakDevice(Args As Map) As BleakDevice
	Dim t1 As BleakDevice
	t1.Initialize
	t1.Name = IIFNull(Args.Get("name"), "")
	t1.DeviceId = Args.Get("address")
	t1.RSSI = IIFNull(Args.Get("rssi"), -1)
	t1.ServiceUUIDS = Args.Get("service_uuids")
	t1.ManufacturerData = Args.Get("mfg_data")
	t1.ServiceData = Args.Get("service_data")
	t1.TXPower = IIFNull(Args.Get("tx"), 0)
	t1.BLEDevice = Py.Bridge.Run("get_and_remove_object").Arg(Args.Get("device_slot"))
	Return t1
End Sub

Private Sub IIFNull (o As Object, Defaultvalue As Object) As Object
	If o = Null Then Return Defaultvalue
	Return o
End Sub

'Internal method.
Public Sub InternalReturnSuccessFlag (Result As PyWrapper) As Boolean
	If Result.IsSuccess = False Then Py.PyLastException = Result.ErrorMessage
	Return Result.IsSuccess
End Sub

'Creates a client object that manages the connection to a single peripheral.
Public Sub CreateClient (Device As BleakDevice) As BleakClient
	Dim c As BleakClient
	c.Initialize(mCallback, mEventName, Device, Me)
	Return c
End Sub

