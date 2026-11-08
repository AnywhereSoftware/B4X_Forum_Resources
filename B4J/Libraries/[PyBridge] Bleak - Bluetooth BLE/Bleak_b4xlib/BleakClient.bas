B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.12
@EndOfDesignText@
Sub Class_Globals
	Public py As PyBridge 'ignore
	Public mDevice As BleakDevice
	Public client As PyWrapper
	Private mBleak As Bleak
	Type BleakService(Description As String, UUID As String, Characteristics As List, Handle As Int)
	Type BleakCharacteristic(Description As String, UUID As String, Handle As Int, Properties As List)
	Type BleakNotification (ClientUUID As String, CharacteristicUUID As String, Value() As Byte)
	Private mServices As Map
	Public TimeoutMs As Int = 10000
End Sub

'Don't use. Call Bleak.CreateClient instead.
Public Sub Initialize (Callback As Object, EventName As String, device As BleakDevice, Bleak1 As Bleak)
	mDevice = device
	mBleak = Bleak1
	py = mBleak.Py
	client = py.ImportModule("bleak").Run("BleakClient").Arg(device.BLEDevice).Arg(py.GetMember("disconnect_callback"))
	mServices.Initialize
End Sub

'Returns a Map with the services UUIDs as keys and BleakService objects as values.
Public Sub getServices As Map
	Return mServices
End Sub

'Tries to connect to the peripheral. TimeoutMs sets the timeout. Default value is 10000 (10 seconds).
'<code>Wait For (client.Connect) Complete (Success As Boolean)</code>
Public Sub Connect As ResumableSub
	mServices.Clear
	Dim code As String = $"
import asyncio
async def connect_with_timeout(client, timeout):
	return await asyncio.wait_for(client.connect(), timeout)
"$
	Wait For (py.RunCodeAwait("connect_with_timeout", Array(client, TimeoutMs / 1000), code)) Complete (Result As PyWrapper)
	If Result.IsSuccess Then
		Wait For (ExtractServices.Fetch) Complete (RawServices As PyWrapper)
		For Each o() As Object In RawServices.Value.As(List)
			Dim ServiceHandle As Int = o(0)
			Dim ServiceUUID As String = o(1)
			Dim ServiceDescription As String = o(2)
			Dim RawChars As List = o(3)
			Dim service As BleakService = CreateBleakService(ServiceDescription, ServiceUUID, ServiceHandle)
			For Each c() As Object In RawChars
				service.Characteristics.Add(CreateBleakCharacteristic(c(1), c(2), c(0), c(3)))
			Next
			mServices.Put(service.UUID, service)
		Next
	End If
	Return mBleak.InternalReturnSuccessFlag(Result)
End Sub



'Tries to read the value of a characteristic. If Result.IsSuccess is true then Result.Value will be an array of bytes with the read data.
'<code>Wait For (mClient.ReadChar(uuid)) Complete (Result As PyWrapper)</code>
Public Sub ReadChar(CharacteristicAddress As String) As ResumableSub
	Wait For (client.RunAwait("read_gatt_char", Array(CharacteristicAddress), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Disconnects the client.
Public Sub Disconnect As ResumableSub
	Wait For (client.RunAwait("disconnect", Null, Null)) Complete (Result As PyWrapper)
	Return mBleak.InternalReturnSuccessFlag(Result)
End Sub

'Subscribes for notifications. Result.IsSuccess will be true if successful.
'<code>Wait For (mClient.SetNotify(uuid)) Complete (Result As PyWrapper)</code>
Public Sub SetNotify(CharacteristicAddress As String) As ResumableSub
	Dim chara As PyWrapper = client.GetField("services").Run("get_characteristic").Arg(CharacteristicAddress)
	Dim callback As PyWrapper = py.GetMember("create_notify_callback").Call.Arg(mDevice.DeviceId).Arg(chara)
	Wait For (client.RunAwait("start_notify", Array(chara, callback), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

'Tries to write to the characteristic. The "with response" flag is set automatically based on the characteristic flags.
'<code>Dim rs As Object = mClient.Write(uuid, "abcde".GetBytes("UTF8"))
'Wait For (rs) Complete (Result As PyWrapper)</code>
Public Sub Write(CharacteristicAddress As String, Data() As Byte) As ResumableSub
	Wait For (client.RunAwait("write_gatt_char", Array(CharacteristicAddress, Data), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub
'Same as Write, with an explicit value for the "write response".
Public Sub WriteWithResponse(CharacteristicAddress As String, Data() As Byte, WithResponse As Boolean) As ResumableSub
	Wait For (client.RunAwait("write_gatt_char", Array(CharacteristicAddress, Data, WithResponse), Null)) Complete (Result As PyWrapper)
	Return Result
End Sub

Private Sub ExtractServices As PyWrapper
	Dim Code As String = $"
def ExtractServices (client):
	services = []
	for service in client.services.services.values():
		chars = [(c.handle, c.description, c.uuid, c.properties) for c in service.characteristics]
		services.append((service.handle, service.uuid, service.description, chars))
	return services
"$
	Return py.RunCode("ExtractServices", Array(client), Code)
End Sub

Private Sub CreateBleakCharacteristic (Description As String, UUID As String, Handle As Int, Properties As List) As BleakCharacteristic
	Dim t1 As BleakCharacteristic
	t1.Initialize
	t1.Description = Description
	t1.UUID = UUID
	t1.Handle = Handle
	t1.Properties = Properties
	Return t1
End Sub

Private Sub CreateBleakService (Description As String, UUID As String, Handle As Int) As BleakService
	Dim t1 As BleakService
	t1.Initialize
	t1.Description = Description
	t1.UUID = UUID
	t1.Characteristics.Initialize
	t1.Handle = Handle
	Return t1
End Sub