### rNimBLEServer by rwblinn
### 03/25/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170686/)

**B4R Library rNimBLEServer**  

---

  
  
**Brief  
rNimBLEServer** is an open-source library with BLE server functionality on ESP32 for B4R.  

---

  
  
**Purpose**  
This wrapper exposes a minimal BLE server interface for B4R, allowing:  

- Advertising a BLE service
- Receiving data from clients (Write)
- Sending notifications to clients
- Handling connection lifecycle events

Designed to mirror rNimBLEClient for consistency.  

---

  
  
**Development Info**  
This B4R library is:  

- a thin B4R [NimBLE Server](https://github.com/h2zero/NimBLE-Arduino) Wrapper.
- Using the MAC address of the BLE peripheral, standard GATT services, and characteristics UUIDs.
- Written in C++ (Arduino IDE 2.3.4 and *B4Rh2xml* tool).
- Depends on the platform esp32@3.3.6, NimBLE library 2.3.8.
- Tested with ESP-WROOM-32.
- Tested with B4R 4.00 (64-bit).

---

  
  
**Compatibility**  

- Supports **ESP32-based boards only** (ESP8266 and AVR not supported).
- Handles one BLE peripheral at a time.

---

  
  
**Files**  
The *rNimBLEServer-NNN.zip* archive contains the library and examples.  
  

---

  
**Install**  
Copy the *rNimBLEServer* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
*Ensure* the ESP32 platform and the NimBLE library are installed using the Arduino IDE libraries manager.  
  

---

  
**Functions**  
  
Initialize(MAC() as Byte, Service As String, TxChar As String, RxChar As String, NewData As String, OnError As String, , OnConnected As String, OnDisconnected As String, Debug As Boolean)  
Initializes the BLE client.  
**MAC** - BLE peripheral MAC address.  
**Service** - UUID of the BLE service to connect to.  
**TxChar** - Characteristic UUID for writing (TX).  
**RxChar** - Characteristic UUID for notifications (RX). If NULL or empty, the TX characteristic is also used for RX.  
**NewData** - Callback when new data is received.  
**OnError** - Callback when an error occurs.  
**OnConnected** - Callback when a client connects.  
**OnDisconnected** - Callback when a client disconnects.  
**Debug** - Boolean flag for extra logging.  
  
bool Connect  
Starts the connection process and service discovery.  
**Returns** - True if successfully connected and characteristics found.  
  
Disconnect  
Terminates an existing connection and cleans up resources.  
  
IsConnected  
Checks the current connection status.  
**Returns** - True if connected, False otherwise.  
  
Write(data() As Byte)  
Sends a byte array to the connected BLE peripheral.  
  
Error codes  
ERROR\_CREATE\_BLE\_CLIENT = 1  
ERROR\_FAILED\_TO\_CONNECT = 2  
ERROR\_SERVICE\_NOT\_FOUND = 3  
ERROR\_CHARACTERISTICS\_NOT\_FOUND = 4  
  

---

  
  
**Example**  
Start the BLE server, await client connection, listen to new data and log.  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rNimBLEServer Basic v20260325"  
    Public Serial1 As Serial  
    Private BleServer As NimBLEServer  
End Sub  
  
Sub AppStart  
    Serial1.Initialize(115200)  
    Log("[AppStart] ", VERSION)  
    ' Init the BLE server  
    BleServer.Initialize( _  
        "B4RCustomBLEServer", _  
        "12345678-1234-1234-1234-1234567890ab", _  
        "abcd1234-5678-1234-5678-1234567890ab", _  
        "OnConnected", _  
        "OnDisconnected", _  
        "OnWrite", _  
        True)  
    BleServer.Start  
    Log("[AppStart] BLE Server started")  
End Sub  
  
Sub OnConnected  
    Log("[OnConnected] Client connected")  
End Sub  
  
Sub OnDisconnected  
    Log("[OnDisconnected][W] Client disconnected")  
End Sub  
  
' Handle data received from connected client  
' Example: [OnWrite] RX:5 1912050058  
Sub OnWrite (Buffer() As Byte)  
    Log("[OnWrite] RX:", Buffer.Length, " ", Convert.BytesToHex(Buffer))  
    ' Take any action  
    ' …  
End Sub
```

  
  

---

  
  
**Troubleshooting**  

- If connect fails, check that the peripheral is powered and advertising.
- Some devices stop advertising once connected; reset the device if necessary.
- Ensure MAC address and UUIDs are correct.

  

---

  
**License**  
MIT License – see LICENSE file.  

---

  
  
**Credits**  

- Developers & maintainers of the [NimBLE library](https://github.com/h2zero/NimBLE-Arduino) (Apache License 2.0)

---

  
  
**Disclaimer**  

- The Bluetooth® word mark and logos are registered trademarks owned by Bluetooth SIG, Inc.
- All trademarks are property of their respective owners.