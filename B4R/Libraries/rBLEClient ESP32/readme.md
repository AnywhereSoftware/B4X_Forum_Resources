### rBLEClient ESP32 by rwblinn
### 08/14/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168215/)

**B4R Library rBLEClient**  

---

  
  
**Brief  
rBLEClient** is an open-source library for connecting to or scanning Bluetooth Low Energy (BLE) peripherals.  
  

---

  
**Background**  
The **rBLEClient** library was originally developed as part of the *Maker Project RailShunt* (in progress).  
RailShunt uses LEGO® HUB No 4 and BuWizz bricks to control motorized shunting locomotives over Bluetooth Low Energy.  
During development, I needed a reliable way to:  

- Connect to specific BLE devices by MAC address.
- Send and receive data via standard GATT services and characteristics.

This library grew out of that requirement.  
Although it was built for RailShunt, it is suitable for any BLE project that needs scanning or GATT connections on ESP32.  
  

---

  
**Purpose**  

- Passive scan for advertised messages from BLE peripherals, like GVH5075, RuuviTag, Xiaomi Mi Temperature and Humidity Monitor.
- Connect & control BLE peripherals, like BuWizz2, LEGO HUB No 4, or any other device that supports GATT connection.

  

---

  
**Development Info**  
This B4R library is:  

- Using the MAC address of the BLE peripheral, standard GATT services, and characteristics UUIDs.
- Written in C++ (Arduino IDE 2.3.4 and *B4Rh2xml* tool).
- Tested with ESP-WROOM-32.
- Tested with B4R 4.00 (64-bit) and ESP32 library 3.3.0.

  

---

  
**Compatibility**  

- Supports **ESP32-based boards only** (ESP8266 and AVR not supported).
- Connects to one BLE peripheral at a time.

  

---

  
**Files**  
The *rBLEClient.zip* archive contains the library and sample projects.  
  

---

  
**Install**  
Copy the *rBLEClient* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
  

---

  
**Quick Start**  

```B4X
Sub Process_Globals  
Public Serial1 As Serial  
Private MAC As String = "aa:bb:cc:dd:ee:ff" ' Lowercase MAC address  
Private UUID_SERVICE As String = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  
Private UUID_CHARACTERISTIC As String = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  
Private Client As BLEClient  
End Sub  
  
Private Sub AppStart  
Serial1.Initialize(115200)  
Client.Initialize(MAC, UUID_SERVICE, UUID_CHARACTERISTIC, UUID_CHARACTERISTIC, "Client_NewData", "Client_Error", False)  
  
If Client.Connect Then  
    Log("Connected to device")  
    ' Example: Send data  
    Client.Write(Array As Byte(0x01, 0x02, 0x03))  
Else  
    Log("Connection failed")  
End If  
  
End Sub  
  
Sub Client_NewData(data() As Byte)  
Log("New data: ", bc.HexFromBytes(data))  
End Sub  
  
Sub Client_Error(code As Byte)  
Log("Error code: ", code)  
End Sub
```

  
  

---

  
**Functions**  
  
Initialize(MAC as String, Service As String, TxChar As String, RxChar As String, NewData As String, OnError As String, Debug As Boolean)  
Initializes the BLE client.  
**MAC** - BLE peripheral MAC address (lowercase).  
**Service** - UUID of the BLE service to connect to.  
**TxChar** - Characteristic UUID for writing (TX).  
**RxChar** - Characteristic UUID for notifications (RX). If NULL or empty, the TX characteristic is also used for RX.  
**NewData** - Callback when new data is received.  
**OnError** - Callback when an error occurs.  
**Debug** - Boolean flag for extra logging.  
  
Disconnect  
Disconnects from the connected BLE peripheral.  
  
IsConnected  
Checks the current connection status.  
**Returns** - True if connected, False otherwise.  
  
Write(data() As Byte)  
Sends a byte array to the connected BLE peripheral.  
  
PassiveScan(scanTimeSeconds As Int, onlyOnce As Boolean, timeoutSeconds as Int)  
Performs a passive BLE scan without connecting.  
**scanTimeSeconds** - Duration of each scan cycle.  
**onlyOnce** - If True, stops on first match.  
**timeoutSeconds** - Max scan time in seconds for onlyOnce mode.  
**Returns** - True if device found in onlyOnce mode, else False.  
  
PassiveScanOnce(timeoutSeconds As Int)  
Runs a single passive scan.  
**timeoutSeconds** - Max scan time in seconds for onlyOnce mode.  
**Returns** - True if the device is found.  
  

---

  
**Constants**  
MAX\_TIMEOUT\_SECONDS = 60  
  
Error codes  
ERROR\_NONE  
ERROR\_ALREADY\_CONNECTED  
ERROR\_DEVICE\_NOT\_FOUND  
ERROR\_CREATE\_BLE\_CLIENT  
ERROR\_FAILED\_TO\_CONNECT  
ERROR\_SERVICE\_NOT\_FOUND  
ERROR\_CHARACTERISTICS\_NOT\_FOUND  
ERROR\_CAN\_NOT\_WRITE\_VALUE  
  

---

  
**Example – Passive Scan for GVH5075**  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rBLEClient GVH5075 v20250731"  
    Public Serial1 As Serial  
  
    ' BLE -  Peripheral GVH5075  
    ' Type structure holding the sensor data.  
    Type TGVH5075 (Temperature As Float, Humidity As Float, Battery As Int)     
    Private MAC As String = "aa:bb:cc:dd:ee:ff"  ' MAC address must be in lowercase!     
    Private UUID_SERVICE As String = "494e5445-4c4c-495f-524f-434b535f4857"   ' Custom 128 bit UUID for primary service  
    Private UUID_CHARACTERISTIC  As String = "494e5445-4c4c-495f-524f-434b535f2012"  ' Command/Write characteristic (read/write/notify, write type: write request)  
    Private Client As BLEClient  
    Private GHV5075Data As TGVH5075  
    Private bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("[AppStart] ", VERSION)  
    Log("[AppStart] MAC Address=", MAC)  
  
    ' Initialize the BLE Client  
    Client.Initialize(MAC, _  
                            UUID_SERVICE, _  
                            UUID_CHARACTERISTIC, _  
                            UUID_CHARACTERISTIC, _  
                            "Client_NewData", "Client_Error", _  
                            False)  
  
    ' Example passive scan  
'    Dim scantime As Int = 60  
'    Dim timeout As Int = 90  
'    Log(Millis, "[AppStart] Starting passive scan for ", scantime, " s.")  
'    Client.PassiveScan(scantime, False, timeout)  
  
    ' Example passive scan once  
    Log("[AppStart] Starting passive scan once")  
    Dim timeout As Byte = 10  
    Dim result As Boolean = Client.passiveScanOnce(timeout)  
    If Not(result) Then  
        Log("[AppStart] GVH5075 with MAC address ", MAC, " not found.")  
    End If  
End Sub  
  
' Callback when data is received from BLE  
' For the GVH5075 the manufacturer data is received.  
' [ble_NewData] data=A4C1384C302288EC000385494900  
Sub Client_NewData(data() As Byte)  
    Log("[Client_NewData] data=", bc.HexFromBytes(data))  
    If ParseRawData(data) Then  
        Log("[Client_NewData] t=", GHV5075Data.temperature, " °C,h=",GHV5075Data.humidity," %RH,b=",GHV5075Data.battery, " %")  
    End If  
End Sub  
  
' Callback for BLE errors  
Sub Client_Error(code As Byte)  
    Log(Millis, "[Client_Error] code=", code)  
End Sub  
  
' GVH5075 parse raw data hex string as byte array.  
' Data example:        A4 C1 38 4C 30 22 88 EC 00 03 85 49 49 00  
'                    0  1  2  3  4  5  6  7  8  9  10 11 12 13  
' Data length:        14 bytes  
' Byte 0-5 (6):        MAC Address A4:C1:38:4C:30:22. Matches the pattern of a BLE MAC address. Many devices broadcast their MAC or parts of it.  
' Byte 6-7 (2):        Manufacturer Key EC88 as little endian  
' Byte 8-13 (6):    Sensor data 00 03 85 49 49 00  
' Sensor Data Calculation  
' Byte 8-11 (4):    The temp+hum are calculated from the first 4 bytes:  
'                    The data bytes 0-4 = HEX 00 03 85 49 > DEC 230729  
'                    temperature = 230729 / 10000 = 23.1 °C (Round, 1)  
'                    humidity    = 230729 % 1000 = 729 / 10 = 72.9 %RH  
' Byte 12 (1):        battery     = data byte 5 = 49 > DEC 49%  
Sub ParseRawData(data() As Byte) As Boolean  
    ' Check data length  
    If data.Length < 14 Then  
        Log("[ParseRawData][ERROR] Invalid data length: ",  data.Length, " (expect 14)")  
        Return False  
    End If  
     
    ' Define the temp + hum data array 4 bytes  
    Dim temphumdata(4) As Byte  
  
    ' Copy 4 bytes from the data array  
    bc.ArrayCopy2(data, 8, temphumdata, 0, 4)  
  
    ' Convert 4 bytes to long  
    Dim temphum As Long = NumConv.FourBytesToLong(temphumdata)  
  
    ' Calculate temp + hum  
    GHV5075Data.Temperature = temphum / 10000  
    GHV5075Data.Humidity    = (temphum Mod 1000) / 10  
     
    ' Set battery value  
    GHV5075Data.Battery     = data(12)  
     
    'Log(Millis, "[ParseRawData] t=", GHV5075Data.temperature, ",h=",GHV5075Data.humidity,",b=",GHV5075Data.battery)  
    Return True  
End Sub
```

  
  

---

  
**Example – Control LEGO HUB No 4**  

```B4X
Sub Process_Globals  
Public Serial1 As Serial  
Private bc As ByteConverter  
Private Client As BLEClient  
Private MAC As String = "aa:bb:cc:dd:ee:ff" ' LEGO HUB MAC address (lowercase)  
Private UUID_SERVICE As String = "00001623-1212-efde-1623-785feabcd123"  
Private UUID_CHARACTERISTIC As String = "00001624-1212-efde-1623-785feabcd123"  
End Sub  
  
Private Sub AppStart  
Serial1.Initialize(115200)  
Client.Initialize(MAC, UUID_SERVICE, UUID_CHARACTERISTIC, UUID_CHARACTERISTIC, "Client_NewData", "Client_Error", True)  
  
If Client.Connect Then  
    Log("Connected to LEGO HUB")  
    ' Example: Turn on motor A at speed 50  
    Client.Write(Array As Byte(&H81, &H00, &H11, &H51, &H00, &H32))  
Else  
    Log("Failed to connect to LEGO HUB")  
End If  
  
End Sub  
  
Sub Client_NewData(data() As Byte)  
Log("Received data: ", bc.HexFromBytes(data))  
End Sub  
  
Sub Client_Error(code As Byte)  
Log("Error code: ", code)  
End Sub
```

  
  

---

  
**Hints**  
  
MAC Address  
Obtainable via BLE scanner apps (e.g., BLE Scanner for Android). Must be lowercase.  
  
UUID  
Can be found via:  

- Manufacturer documentation
- BLE scanner apps
- Reverse-engineering / AI tools

  

---

  
**Troubleshooting**  

- If Connect fails, check that the peripheral is powered and advertising.
- Some devices stop advertising once connected; reset the device if necessary.
- Ensure MAC address and UUIDs are correct.

  

---

  
**License**  
MIT License – see LICENSE file.  
  

---

  
**Disclaimer**  

- LEGO® is a trademark of the LEGO Group of companies, which does not sponsor, authorize, or endorse this project.
- The Bluetooth® word mark and logos are registered trademarks owned by Bluetooth SIG, Inc.
- BuWizz is a trademark of Fortronik d.o.o.
- All trademarks are property of their respective owners.