### BLE2PeripheralEnhanced2 - BLE2Peripheral with multiple services by CaptKronos
### 03/14/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/162080/)

**BLE2PeripheralEnhanced2**  
  
BLE2PeripheralEnhanced2 is an update to Peter Simpson's [BLE2PeripheralEnhanced](https://www.b4x.com/android/forum/threads/customise-your-ble-gatt-service-with-ble-peripheral-2-enhanced.158056/) library, which itself was an update to Erel's [BLE2Periphera](https://www.b4x.com/android/forum/threads/ble-peripheral.84051)l library. My main addition is to allow for an arbitrary number of services to be defined. I won't duplicate the explanations that can be found in those posts.  
  
The library is backwards compatible with Erel's original library with the one exception that the Write command now has to specify the characteristic being written to. So in Erel's original demo project, the two instances of:  

```B4X
peripheral.Write(Null, Data)
```

  
need to be changed to:  

```B4X
peripheral.Write(Null, Peripheral.UUID("1001"), Data)
```

  
(.UUID is a helper function to convert a short form UUID to its long form.)  
  
The main change to Peter's library is that his functions: CreatePrimaryServiceUUID, CreateCharacteristicUUIDs, SetCharacteristicReadValues have been replaced with:  

```B4X
CreateUUIDs (UUIDs As Map, CharacteristicsReadValues As Map) As Boolean
```

  
  
UUIDs is a map defining the services and their characteristics. The specification of each characteristic is identical to Peter's approach. The optional characteristic read values are now defined in a map.  
  
As an example, to create BLE standards compliant heart rate and battery services:  

```B4X
    Dim UUIDs, readValues As Map  
    Dim characteristicsHR, characteristicsBattery As List  
    UUIDs.Initialize  
    readValues.Initialize  
    characteristicsHR.Initialize  
    characteristicsHR.AddAll(Array As String(Peripheral.UUID("2a37") & ",True,False,True"))  
    UUIDs.Put(Peripheral.UUID("180d"), characteristicsHR)  
    characteristicsBattery.Initialize  
    characteristicsBattery.Add(Peripheral.UUID("2a19") & ",True,False,True")  
    UUIDs.Put(Peripheral.UUID("180f"), characteristicsBattery)  
    readValues.Put(Peripheral.UUID("2a37"), "0") 'a default heart rate of 0bps  
    Dim allgood As Boolean=Peripheral.CreateUUIDs(UUIDs, readValues)
```

  
  
Using an app like BLE Scanner, you should find that your app is exposing the two standard services:  
  
![](https://www.b4x.com/android/forum/attachments/155446)  
  
Note that calling CreateUUIDs overwrites the default service, i.e. the one presented in Erel's original post. If you need the default service in addition to new ones, add that service and characteristics to the UUIDs map before passing it to CreateUUIDs, as follows:  
  

```B4X
    Dim characteristicsDefault As List  
    characteristicsDefault.Initialize  
    characteristicsDefault.AddAll(Array As String(Peripheral.UUID("1001") & ",True,False,True", Peripheral.UUID("1002") & ",False,True,False"))  
    UUIDs.Put(Peripheral.UUID("0001"), characteristicsDefault)
```

  
  
I have also added a few new capabilities that may be useful: UUID (already mentioned above), logging (selected in the Initialize2 method) and an optional white list specifying devices that can connect to your services, AllowedAddresses.  
  
  
  
**Ble2PeripheralEnhanced2  
  
Author:** CaptKronos  
**Version:** 1.0  

- **Ble2PeripheralEnhanced2**
*Allows to configure the device as a BLE peripheral device. Other central devices can connect to this device.  
 Only supported by some devices running Android 5+. Make sure to check IsPeripheralSupported property.  
 Based on Peter Simpson's BLE2PeripheralEnhanced library, which itself was based on Erel's BLE2Peripheral library.*

- **Events:**

- **ConnectionStatus** (DeviceId As String, ConnectionState As Integer)
- **NewData** (DeviceId As String, Data() As Byte)
- **NewData2** (DeviceId As String, Data() As Byte, CharacteristicUUID As String, DataAsStr As String, DataAsHex As String, DataAsBin As String)
- **Start** (Success As Boolean)
- **Subscribe** (DeviceId As String)
- **Unsubscribe** (DeviceId As String)

- **Fields:**

- **GetCharacteristicUUID** As String
- **GetDataAsBinary** As String
- **GetDataAsString** As String

- **Functions:**

- **Close**
*Always call close to ensure the BLE services are properly closed down*- **CreateUUIDs** (UUIDs As Map, CharacteristicsReadValues As Map) As Boolean
*UUIDs - defines the Primary Service UUIDs (the map keys) and a list of strings specifying the corresponding Characteristic UUIDs and properties (the map values). Each Characteristic should be formatted as a CSV string consisting of: UUID (String), Read (Boolean), Write (Boolean), Notify (Boolean)  
 CharacteristicsReadValues - sets the default read value for the characteristics. The map keys are the characteristic UUIDs and the keys' values are the default read values. If there are no default values, pass null.  
 Example: to create a heart rate service with a heart rate measurement characteristic:  
 CharacteristicsList.AddAll(Array As String(Peripheral.UUID("2a37") & ",True,False,True"))  
 UUIDsMap.Put(Peripheral.UUID("180d"), CharacteristicsList)   
 ReadValuesMap.Put(Peripheral.UUID("2a37"), "0") 'initial heart rate of 0 bps  
 Dim success As Boolean=Peripheral.CreateUUIDs(UUIDsMap, ReadValuesMap)*- **GetDataAsHexadecimal** (UseCommas As Boolean) As String
*Retrieves the latest received data formatted as hex.  
 If UseCommas=true, separate bytes with commas*- **Initialize** (EventName As String, Ble As BleManager2)
*Initializes the object.*- **Initialize2** (EventName As String, Ble As BleManager2, logging As Boolean)
*Initializes the object and logging.*- **Start** (Name As String)
*Starts advertising. The name will be set as the device Bluetooth name. Pass an empty string to keep the current name.  
 The Start event will be raised.*- **Start2** (Name As String, Settings As android.bluetooth.le.AdvertiseSettings)
*Similar to Start. Allows overriding the default settings.*- **UUID** (ShortName As String) As String
*Converts a short form UUID to its long form  
 UUID("0001") -> "00000001-0000-1000-8000-00805f9b34fb"*- **Write** (Centrals As List, UUID As String, Data As Byte()) As Boolean
*Writes data to subscribed devices of the characteristic with specified UUID.  
 Centrals - Target devices. Pass Null to send to all subscribed devices.  
 Returns true on success, false on failure which probably means UUID couldn't be found.  
 Warning - Unless you have changed the MTU size (e.g. manager.RequestMtu(50) [Manager As BleManager2]), only the first 20 bytes will be sent.*
- **Properties:**

- **AllowedAddresses** As java.util.ArrayList [write only]
*If set, limits connections to devices with addresses on the provided list  
 Example:  
 AllowedAddressesList.Addall(Array As String("7B:47:33:23:E2:FE", "7A:79:16:F5:49:E5" ))  
 Peripheral.AllowedAddresses=AllowedAddressesList*- **IsPeripheralSupported** As Boolean [read only]
*Checks whether peripheral mode is supported.*- **ManufacturerData** As Map
*Gets or sets the manufacturer specific data that will be advertised.  
 Each item in the map should have a positive int number as the key and an array of bytes as the value.*- **MultipleConnections** As Boolean [write only]
*If false, only one device can connect at a time. (Default is true).*
**Change log**  
1.00 Initial release  
1.01 Fixed crash when UUID with upper case characters or any non-existing characteristic is passed to the Write function.  
[INDENT]Write function now returns a boolean to indicate success/failure.[/INDENT]