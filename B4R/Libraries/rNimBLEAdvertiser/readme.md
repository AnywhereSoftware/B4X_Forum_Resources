### rNimBLEAdvertiser by rwblinn
### 03/27/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170697/)

**B4R Library rNimBLEAdvertiser**  

---

  
  
**Brief  
rNimBLEAdvertiser** is an open-source library providing BLE advertising functionality on ESP32 for B4R.  

---

  
  
**Purpose**  
This wrapper exposes a minimal BLE advertiser interface for B4R, allowing to:  

- advertise as a BLE peripheral manufacturer or service data.
- create own BLE devices advertising data like environment, machine, status etc..

---

  
  
**Development Info**  
This B4R library is:  

- a thin B4R NimBLE Advertiser Wrapper.
- Written in C++ (Arduino IDE 2.3.4 and *B4Rh2xml* tool).
- Depends on the platform esp32@3.3.6, NimBLE library 2.3.8.
- Tested with ESP-WROOM-32.
- Tested with B4R 4.00 (64-bit).

---

  
  
**Compatibility**  

- Supports **ESP32-based boards only** (ESP8266 and AVR not supported).

---

  
  
**Files**  
The *rNimBLEAdvertiser-NNN.zip* archive contains the library and examples.  

- Basic - Advertise 3-bytes 0x01, 0x02, 0x03
- DHT22 - Advertise DHT22 temperature & humidity data (requires the rESP32DHT library)

---

  
  
**Install**  
Copy the *rNimBLEAdvertiser* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
*Ensure* the ESP32 platform and the NimBLE library are installed using the Arduino IDE libraries manager.  

---

  
  
**Functions**  
  
Initialize(DeviceName As String)  
Initializes the BLE stack and sets the local device name.  
**DeviceName** - The name that will appear in scan responses.  
  
SetManufacturerData(Data() As Byte)  
Injects custom data into the Manufacturer Specific (0xFF) field.  
**Data** - Byte array containing the raw payload (e.g., Govee/Ruuvi format).  
  
SetServiceData(UUID As UInt, Data() As Byte)  
Injects data into a specific Service Data (0x16) field.  
**UUID** - The 16-bit Service UUID (e.g., 0x181A for Environmental Sensing).  
**Data** - The payload associated with the service.  
  
Start(DurationMS As ULong)  
Starts the BLE radio transmission.  
**DurationMS** - Total time to advertise in milliseconds (0 = infinite).  
  
Stop  
Immediately stops all BLE advertising.  
  
SetDebug(Enabled As Boolean)  
Toggles verbose Serial logging for the library.  
Enabled - True to enable debug output.  

---

  
  
**Example**  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rNimBLEAdvertiser Basic v20260327"  
    Public Serial1 As Serial  
    Private Adv As NimBLEAdvertiser  
    ' Advertise duration 0=infinite  
    Private ADV_DURATION As ULong = 0  
End Sub  
  
Sub AppStart  
    Serial1.Initialize(115200)  
    Log("[AppStart] ", VERSION)  
    ' Initialize with a name  
    Adv.Initialize("B4R-Advertiser")  
    Adv.SetDebug(True)  
    ' Start advertising  
    Adv.Start(ADV_DURATION)  
    CallSubPlus("Advertise", 100, 5)  
    Log("[AppStart] BLE advertiser started, duration=", ADV_DURATION, " (0=infinite)")  
End Sub  
  
' Advertise device name is B4R-Advertiser.  
' Data:        02010606FF58190102030F094234522D41647665727469736572  
' Format:    02 01 06: Flags (3 Bytes).  
'            06: Length of the Manufacturer block (1 Type byte + 5 data bytes).  
'            FF: Manufacturer Specific Data tag.  
'            58 19: Company ID (0x1958).  
'            01 02 03: Custom Payload bytes.  
'            0F: Length of the Name block.  
'            09: Complete Local Name tag.  
'            42 34 52…: "B4R-Advertiser" in ASCII.  
Private Sub Advertise(tag As Byte)  
    ' Create 5-bytes payload with company id as first 2 bytes followed by 3 data bytes  
    Dim Payload() As Byte = Array As Byte(0x58, 0x19, 0x01, 0x02, 0x03)  
    ' Set the payload as manufacturer data  
    Adv.SetManufacturerData(Payload)  
    Log("[Advertise] payload=", Convert.BytesToHex(Payload))  
End Sub
```

  

---

  
  
**License**  
MIT - see LICENSE file.  

---

  
  
**Credits**  

- Developers & maintainers of the [NimBLE library](https://github.com/h2zero/NimBLE-Arduino) (Apache License 2.0).

---

  
  
**Disclaimer**  

- All trademarks are property of their respective owners.