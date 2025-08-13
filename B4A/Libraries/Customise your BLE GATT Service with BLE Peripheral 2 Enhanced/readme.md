### Customise your BLE GATT Service with BLE Peripheral 2 Enhanced by Peter Simpson
### 02/11/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/158056/)

Hello All,  
First I want to say thank you to the B4X developers that reached out to me via PM and to others that I spoke to, you all know who you are ?  
  
As you are all well aware I personally do not touch Java, I only started learning java so that I could enhance Erel's current BlePeripheral2 library which was just too limited for a clients project. I can't believe that I'm saying this, but I have actually enjoyed learning some Java and I will continue to do so ?  
  
**About BlePeripheral2Enhanced library.**  
Using this library, you can create your own custom BLE GATT Service or emulate manufacturer hardware if you know the service UUID and characteristics UUIDs.  
  
I've added the following features to the original BlePeripheral2 V1.12 library which I've renamed to BlePeripheral2Enhanced V1.5.  

- Create a custom primary service with your own unique UUID
- Create multiple characteristics with your own unique UUIDs under the primary service UUID
- Characteristics can be set to either Read and Write, just Read or just Write
- Set the default value for Read or Read Only characteristics
- Set notifications on a per characteristic basis
- Return the sending central characteristic UUID
- Return the received data as String, Hexadecimal or Binary

I have not removed or changed any of Erel's original code for creating a service with characteristics. If you switch to using this library, UUIDs 0001, 1001, 1002 and descriptor 2902 will still work as they did previously with no changes necessary. If need be you can create your own custom service with custom characteristics by calling **CreatePrimaryServiceUUID** and **CreateCharacteristicUUIDs** after you have Initialized the BlePeripheral2Enhanced library. Optionally, you can use **SetCharacteristicReadValues** to establish default values for Read or Read-Only characteristics.  
  
**BLE2PeripheralEnhanced  
  
Author:   
Version:** 1.53  

- **BlePeripheral2Enhanced**
*Allows to configure the device as a BLE peripheral device. Other central devices can connect to this device.  
 Only supported by some devices running Android 5+. Make sure to check IsPeripheralSupported property.*

- **Events:**

- **ConnectionStatus** (DeviceId As String, ConnectionState As String)
- **NewData** (DeviceId As String, Data() As Byte)
- **NewData2** (DeviceId As String, Data() As Byte, CharacteristicUUID As String, DataAsStr As String, DataAsHex As String, DataAsBin As String)
- **Start** (Success As Boolean)
- **Subscribe** (CentralId As String)
- **Unsubscribe** (CentralId As String)

- **Fields:**

- **CreateCharacteristicUUIDs** As List
*Create a list of custom characteristic UUIDs with Read/Write permissions and Notify.  
 Usage: CharacteristicUUID As String, Read As Boolean, Write As Boolean, Notify As Boolean.  
 Example: CreateCharacteristicUUIDs("CharacteristicUUID,Read,Write,Notify", "CharacteristicUUID,Read,Write,Notify", …)*- **CreatePrimaryServiceUUID** As String
*Create the primary service UUID.  
 The primary service UUID must be created before adding your custom characteristic UUIDs.*- **GetCharacteristicUUID** As String
*Returns the characteristic UUID that sent the data.*- **GetDataAsBinary** As String
*Returns the characteristic data that was sent.  
 Converts the data from bytes to binary.*- **GetDataAsString** As String
*Returns the characteristic data that was sent.  
 Converts the data from bytes to string.*- **MultipleConnections** As Boolean
*Enable or disable multiple central devices to connect simultaneously.*- **SetCharacteristicReadValues** As List
*Set the default read value for characteristics via the characteristic UUIDs.  
 Usage: CharacteristicUUID As String, ReadValue As String.  
 Example: SetCharacteristicReadValues("CharacteristicUUID,ReadValue", "CharacteristicUUID,ReadValue", …)*
- **Functions:**

- **Close**
- **GetDataAsHexadecimal** (CommaSeparated As Boolean) As String
*Returns the characteristic data that was sent.  
 Converts the data from bytes to hexadecimal.  
 CommaSeparated: True includes commas, False removes commas.*- **Initialize** (EventName As String, Ble As BleManager2)
*Initializes the object.*- **Start** (Name As String)
*Starts advertising. The name will be set as the device Bluetooth name. Pass an empty string to keep the current name.  
 The Start event will be raised.*- **Start2** (Name As String, Settings As android.bluetooth.le.AdvertiseSettings)
*Similar to Start. Allows overriding the default settings.*- **Write** (Centrals As List, Data As Byte())
*Writes data to subscribed devices.  
 Centrals - Target devices. Pass Null to send to all subscribed devices.*
- **Properties:**

- **IsPeripheralSupported** As Boolean [read only]
*Checks whether peripheral mode is supported.*- **ManufacturerData** As Map
*Gets or sets the manufacturer specific data that will be advertised.  
 Each item in the map should have a positive int number as the key and an array of bytes as the value.*
  
**BLE GATT primary service with multiple custom characteristics, created using only 2 lines of code in B4A.  
  
Highlighted the B4A custom BLE GATT primary service.  
![](https://www.b4x.com/android/forum/attachments/149916)  
  
7 custom characteristics added to the BLE GATT primary service.   
Highlighted the Read-Only characteristic value set using SetCharacteristicReadValues.**  
![](https://www.b4x.com/android/forum/attachments/149915)  
  
**B4A GATT Service** scanned using BLE Scanner app.  
  
**Update: V1.50**  

- Set targetSdkVersion to 33
- Added RuntimePermissions to the main activity
- Added permissions to the manifest
- Moved the code from the starter service to the new MonitorBLEPeripheral service

**Update: V1.51**  

- Updated IsPeripheralSupported property
- Updated peripheral example

**Update: V1.52**  

- Added field SetCharacteristicReadValues (See post #14 below)
- Replaced **Tilde(~)** with **Comma(,)** as a separator (You will need to update **CreateCharacteristicUUIDs**) with commas
- CreateCharacteristicUUIDs is now defined as a list and not as a string array
- Updated peripheral example

**Update: V1.53**  

- Added event ConnectionStatus - This even fires whenever a remote central device connects or disconnects to the peripheral service (See post #18 below)
- Added field MultipleConnections - Allows for limiting central device connections to only a single connection at any one time (See post #18 below)
- Updated peripheral example

D = 13+13, 3+3, 20+20, 15+15, 5+5, 14+14, 33+26  
  
  
**Enjoy…**