### ArduinoBLE GATT - Peripheral & Central in one by Peter Simpson
### 01/23/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170070/)

Hello everyone,  
This has been a long time coming, but B4R now has an ArduinoBLE library supporting both Peripheral and Central roles.  
  
**Please note:**  
The Peripheral and Central code examples are deliberately comprehensive. I’ve aimed to cover how to use key features so that most questions are already answered in these two examples. Please read and study them carefully before diving in.  
  
I originally wrapped a basic version of this [ArduinoBLE](https://github.com/arduino-libraries/ArduinoBLE) library a couple of years ago, with only limited Peripheral features for my own use. After [USER=40947]@rwblinn[/USER]’s post last week, I decided to revive the project. I scrapped the old code and re‑wrapped the entire library from the ground up, adding as many logical and useful functions as possible for the B4X community.  
  
**About this library:  
rArduinoBLE** is a modern, high‑performance Bluetooth Low Energy wrapper for B4R, built on top of the official ArduinoBLE framework. It brings BLE Peripheral and Central capabilities to ESP32, Arduino Nano 33 BLE, plus much more compatible microcontrollers, while keeping the API simple, predictable, and fully aligned with B4X coding conventions (I hope).  
  
This library exposes the standard BLE feature set:  

- Create services and characteristics with any combination of Read, Write, Write Without Response, Notify, and Indicate
- Advertise custom services with local name, device name, and appearance
- Detect writes reliably and read incoming data safely using an isolated internal buffer
- Send notifications or indications to subscribed centrals
- Scan for remote devices, connect, discover attributes, read/write characteristics, and manage subscriptions in Central mode

The library is designed with stability and developer‑friendliness in mind. Each characteristic maintains its own dedicated memory buffer, ensuring that incoming data is preserved safely for the B4R runtime. This library makes configuration and usage straightforward even in complex BLE projects.  
  
Developing robust BLE foundation for ESP32 or Arduino BLE boards, sensors, controllers, scanners, or multi‑service GATT devices. This library will reliably help you to create your native B4R solution.  
  
**Note:** Remember to first install ArduinoBLE in your Arduino IDE.  
  
**B4R library tab:**  
![](https://www.b4x.com/android/forum/attachments/169521)  
  
**rArduinoBLE  
  
Author:** Peter Simpson  
**Version:** 1.10  

- **BLEDescriptor**
*Represents a BLE Descriptor, used to provide extra metadata like human-readable names.*

- **Functions:**

- **Initialize** (UUID As String, Data As String)
*Initialises a descriptor.  
 UUID: Typically "2901" for Characteristic User Description.  
 Data: The text value (e.g., "Pressure Sensor").*
- **BLEDevice**
*Represents a remote BLE device discovered during a scan.*

- **Functions:**

- **Address** As String
*Returns the MAC address of the remote device (e.g., "AA:BB:CC:DD:EE:FF").*- **CanSubscribe** (ServiceUUID As String, CharUUID As String) As Bool
*Checks if the remote characteristic supports notifications or indications.*- **Connect** As Bool
*Attempts to connect to the remote device.   
 Returns True if the connection was successful.*- **Connected** As Bool
*Checks the connection status. Returns True if currently connected.*- **Disconnect**
*Terminates the active connection with the remote device.*- **DiscoverAttributes** As Bool
*Queries the remote device for its services and characteristics.   
 This must be called and return True before attempting to Read or Write.*- **LocalName** As String
*Returns the advertised name of the remote device.   
 May return an empty string if the device does not broadcast a name.*- **ManufacturerData** As Byte()
*Returns the raw manufacturer data bytes from the advertisement packet.*- **ReadCharacteristic** (ServiceUUID As String, CharUUID As String) As Byte()
*Reads data from a remote characteristic.   
 ServiceUUID: The Service UUID.   
 CharUUID: The Characteristic UUID.   
 Returns an ArrayByte containing the data, or Null if the read failed.*- **ReadDescriptor** (ServiceUUID As String, CharUUID As String, DescriptorUUID As String) As Byte()
*Reads a specific descriptor from a characteristic (e.g., "2901" for User Description).  
 Returns an ArrayByte containing the descriptor data.*- **RSSI** As Int
*Returns the Received Signal Strength Indicator.   
 Typically ranges from -100 (weak) to -30 (strong).*- **Subscribe** (ServiceUUID As String, CharUUID As String) As Bool
*Subscribes to notifications/indications for a remote characteristic.*- **Unsubscribe** (ServiceUUID As String, CharUUID As String) As Bool
*Stops notifications/indications for a remote characteristic.*- **WriteCharacteristic** (ServiceUUID As String, CharUUID As String, Data As Byte())
*Writes data to a characteristic on the remote device.   
 ServiceUUID: The 128-bit or 16-bit Service UUID.   
 CharUUID: The Characteristic UUID to target.   
 Data: The ArrayByte containing the payload.*
- **BLEMaster**
*The main controller for Bluetooth Low Energy.   
 Supports both Peripheral mode (broadcasting services) and Central mode (scanning for remote devices).*

- **Fields:**

- **Appearance** As Int
*Sets the 16-bit appearance value for the device.  
 — SOME OF THESE CODES BELOW, MAY NOT BE RECOGNISED ON YOUR DEVICE. —.  
 Unknown (0x0000), Phone (0x0040), Computer (0x0080), Watch (Generic) (0x00C0), Watch: Sports Watch (0x00C1),   
 Clock (0x0100), Display (0x0140), Remote Control (0x0180), Eye-glasses (0x01C0), Tag (0x0200), Keyring (0x0240),   
 Media Player (0x0280), Barcode Scanner (0x02C0), Thermometer (Generic) (0x0300), Thermometer: Ear (0x0301),   
 Heart Rate Sensor (Generic) (0x0340), Heart Rate Sensor: Belt (0x0341), Blood Pressure (Generic) (0x0380),   
 Blood Pressure: Arm (0x0381), Blood Pressure: Wrist (0x0382), Human Interface Device (HID) (0x03C0),   
 HID: Keyboard (0x03C1), HID: Mouse (0x03C2), HID: Joystick (0x03C3), HID: Gamepad (0x03C4),   
 HID: Digitizer Tablet (0x03C5), HID: Card Reader (0x03C6), HID: Digital Pen (0x03C7), HID: Barcode Scanner (0x03C8).*- **DeviceName** As String
*Sets or gets the device name (GATT service name) seen after connection.*- **LocalName** As String
*Sets or gets the local name that the device will broadcast.*
- **Functions:**

- **AddBatteryService** (InitialLevel As Int)
*Adds the standard Bluetooth Battery Service (0x180F) with a single level characteristic (0x2A19).  
 InitialLevel: The starting battery percentage (0-100).*- **AddDeviceInformationService** (ManufacturerName As String, ModelNumber As String, SerialNumber As String)
*Adds the standard Device Information Service (0x180A).  
 ManufacturerName: String identifying the manufacturer.  
 ModelNumber: String identifying the model.  
 SerialNumber: String identifying the serial number.*- **AddService** (Service As B4R::B4RLocalService\*)
*Adds a local service to the peripheral.   
 Service: The LocalService object which must contain at least one characteristic.*- **Advertise**
*Starts broadcasting BLE advertisement packets.   
 This makes the device visible to other BLE centrals (like smartphones).*- **Available** As B4R::B4RBLEDevice\*
*Checks for discovered devices during an active scan.   
 Returns a BLEDevice object if a device was found, or Null if no new devices are available.*- **Begin** As Bool
*Initialises the BLE radio hardware.   
 Returns True if the radio was successfully started.   
 Ensure your board supports BLE (e.g., ESP32, Arduino Nano 33 BLE).*- **HexFromBytes** (Data As Byte()) As String
*Converts a byte array into a Hexadecimal string.  
 Ideal for viewing raw Manufacturer Data or UUIDs.*- **Poll**
*Handles underlying BLE stack events.   
 In Peripheral mode, this should be called frequently within a loop to maintain connections.*- **Scan**
*Starts scanning for nearby BLE peripheral devices.   
 Use the Available method to retrieve discovered devices.*- **SetAdvertisedService** (Service As B4R::B4RLocalService\*)
*Sets the primary service UUID to be broadcast in the advertisement packet.   
 Service: The service that scanning central devices will see before connecting.*- **SetAppearance** (Value As Int)
*Alternative method to set the appearance value via a function call.*- **SetBatteryLevel** (Level As Int)
*Updates the battery level characteristic.   
 Level: The current battery percentage (0-100).*- **SetManufacturerData** (Data As Byte())
*Sets custom manufacturer data in the advertising packet.   
 Data: Array of bytes containing your custom manufacturer information.*- **StopScan**
*Stops the current scanning operation to save power or prepare for connection.*- **StringFromBytes** (Data As Byte()) As String
*Converts a byte array directly into a String within the library.  
 Useful for reading characteristic values.*- **SubStringHex** (Data As Byte(), Start As Int, Length As Int) As String
*Extracts a portion of a byte array as a Hex String.*- **SubStringText** (Data As Byte(), Start As Int, Length As Int) As String
*Extracts a portion of a byte array as a String.*
- **LocalCharacteristic**
*Represents a data point hosted on your device that centrals can interact with.*

- **Functions:**

- **AddDescriptor** (Descriptor As B4R::B4RBLEDescriptor\*)
*Adds a descriptor to this characteristic. Call this before adding the characteristic to a service.*- **GetValue** As Byte()
*Returns the most recent value written to this characteristic by a connected central device.*- **Initialize** (UUID As String, Properties As Byte, Size As Int)
*Initialises the characteristic.   
 UUID: The unique identifier for this data point.   
 Properties: Supported bits.  
 1 = Read  
 2 = Write  
 4 = Write Without Response  
 8 = Notify  
 16 = Indicate  
 Combined Properties: Common examples.  
 3 = Read + Write (1 + 2)  
 6 = Write + Write Without Response (2 + 4)  
 7 = Read + Write + Write Without Response (1 + 2 + 4)  
 15 = Read + Write + Write Without Response + Notify (1 + 2 + 4 + 8)  
 Size: The maximum data size in bytes for the value buffer.*- **SetValue** (Data As Byte())
*Updates the value stored in this characteristic.   
 Centrals will see this updated value on their next read or notification.*- **Subscribed** As Bool
*Returns True if the remote central device has subscribed to notifications or indications for this characteristic.*- **UUID** As String
*Returns the UUID string assigned to this characteristic during initialisation.*- **Written** As Bool
*Checks if a remote central device has written a new value to this characteristic since this method was last checked.*
- **LocalService**
*Represents a BLE service hosted by your ESP32/Arduino.*

- **Functions:**

- **AddCharacteristic** (Characteristic As B4R::B4RLocalCharacteristic\*)
*Adds a characteristic to this service.   
 Call this before adding the service to the BLEMaster.*- **Initialize** (UUID As String)
*Initialises the service.   
 UUID: The unique identifier for this service (e.g., "180F" for Battery Service).*
[HEADING=2]**[SIZE=5]BLE Library Compatibility Table[/SIZE]**[/HEADING]  
[TABLE]  
[TR]  
[TH]Board / Family[/TH]  
[TH]BLE hardware[/TH]  
[TH]ArduinoBLE compatible[/TH]  
[TH]Works with this library[/TH]  
[TH]Notes[/TH]  
[/TR]  
[TR]  
[TD]**Arduino Nano 33 BLE**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Fully supported (nRF52840)[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Nano 33 BLE Sense**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Fully supported[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Nano 33 BLE Sense Rev2**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Fully supported[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Edge Control**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Uses same BLE stack[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Portenta H7 (mbed)**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Works in mbed mode[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Nicla Sense ME**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Fully supported[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Nicla Vision**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Fully supported[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Nicla Voice**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]Fully supported[/TD]  
[/TR]  
[TR]  
[TD]**ESP32 DevKit V1 (DOIT)**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]**100% Working - Tested by myself**[/TD]  
[/TR]  
[TR]  
[TD]**ESP32-WROOM-32**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]**100% Working - Tested by myself**[/TD]  
[/TR]  
[TR]  
[TD]**ESP32-WROVER**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]**100% Working - Tested by myself**[/TD]  
[/TR]  
[TR]  
[TD]**ESP32-S3**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]BLE 5.0 capable[/TD]  
[/TR]  
[TR]  
[TD]**ESP32-C6**[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]✔[/TD]  
[TD]**100% Working - Tested by myself**[/TD]  
[/TR]  
[TR]  
[TD]**Nano RP2040 Connect**[/TD]  
[TD]✔[/TD]  
[TD]⚠ Partial[/TD]  
[TD]⚠ Works but slower[/TD]  
[TD]BLE via NINA module[/TD]  
[/TR]  
[TR]  
[TD]**Portenta X8**[/TD]  
[TD]✔[/TD]  
[TD]⚠ Partial[/TD]  
[TD]⚠ Works in Arduino mode[/TD]  
[TD]Not recommended for timing‑critical BLE[/TD]  
[/TR]  
[TR]  
[TD]**ESP32-S2**[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]No BLE hardware - Add HM‑10[/TD]  
[/TR]  
[TR]  
[TD]**ESP8266**[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]No BLE hardware - Add HM‑10[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Uno / Mega / Leonardo**[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]**100% Working using HM-10 - Tested by myself**[/TD]  
[/TR]  
[TR]  
[TD]**Arduino Due**[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]No BLE hardware - Add HM‑10[/TD]  
[/TR]  
[TR]  
[TD]**Teensy 3.x / 4.x**[/TD]  
[TD]✔[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]Uses different BLE stack[/TD]  
[/TR]  
[TR]  
[TD]**Adafruit nRF52 boards**[/TD]  
[TD]✔[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]Use Bluefruit, not ArduinoBLE[/TD]  
[/TR]  
[TR]  
[TD]**STM32 boards**[/TD]  
[TD]✔[/TD]  
[TD]❌[/TD]  
[TD]❌[/TD]  
[TD]Use STM32BLE, not ArduinoBLE[/TD]  
[/TR]  
[/TABLE]  
  
Android app interacting with a ESP32-WROOM running ArduinoBLE.  
You can now set the battery services, generic access and device/manufacturer informations.  
![](https://www.b4x.com/android/forum/attachments/169515)![](https://www.b4x.com/android/forum/attachments/169516)![](https://www.b4x.com/android/forum/attachments/169517)  
  
**Update: V1.10**  

- Added Descriptor Support
- Added Battery Service
- Added Manufacturer Data
- Added Device Info Service
- Added HexFromBytes
- Added SubStringText
- Added SubStringHex
- Added UUID to LocalCharacteristic - Makes it easier to filter Local Characteristics
- Added Subscribe (to notification) - Removed the subscriptions Sub, use Dev.Subscribe
- Added Unsubscribe (from notification) - Removed the subscriptions Sub, use Dev.Unsubscribe
- Added StringFromBytes - You can now use Dev.StringFromBytes, BC library not necessary

D = 16 + 16 + 16  
  
**Enjoy…**