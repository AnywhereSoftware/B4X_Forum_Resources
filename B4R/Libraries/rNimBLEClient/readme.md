### rNimBLEClient by rwblinn
### 03/25/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170685/)

**B4R Library rNimBLEClient**  

---

  
  
**Brief  
rNimBLEClient** is an open-source library for connecting to Bluetooth Low Energy (BLE) peripherals.  

---

  
  
**Purpose**  
Connect & control BLE peripherals, like BuWizz2, LEGO HUB No 4, or any other device that supports GATT connection.  

---

  
  
**Development Info**  
This B4R library is:  

- a thin B4R [NimBLE Client](https://github.com/h2zero/NimBLE-Arduino) Wrapper.
- Using the MAC address of the BLE peripheral, standard GATT services, and characteristics UUIDs.
- Written in C++ (Arduino IDE 2.3.4 and *B4Rh2xml* tool).
- Depends on the platform esp32@3.3.6, NimBLE library 2.3.8.
- Tested with ESP-WROOM-32.
- Tested with B4R 4.00 (64-bit).

---

  
  
**Compatibility**  

- Supports **ESP32-based boards only** (ESP8266 and AVR not supported).
- Connects to one BLE peripheral at a time.

---

  
  
**Files**  
The *rNimBLEClient-NNN.zip* archive contains the library and examples.  

---

  
  
**Install**  
Copy the *rNimBLEClient* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
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

```B4X
' Project: rNimBLEClient  
' Brief: Example to set the angle of a geekservo via BLE.  
Private Sub Process_Globals  
    Private VERSION As String = "rNimBLEClient Client v20260325"  
    Public Serial1 As Serial  
    ' BLE Client Settings  
    Private MAC() As Byte = Array As Byte(0x80,0xF3,0xDA,0x4C,0x36,0x7A)    ' Address of the server  
    Private UUID_SERVICE As String = "12345678-1234-1234-1234-1234567890ab"         
    Private UUID_TX_CHAR As String = "abcd1234-5678-1234-5678-1234567890ab"          
    Private UUID_RX_CHAR As String = "abcd1234-5678-1234-5678-1234567890ab"          
    Private Client As NimBLEClient  
    ' GPIO  
    Private ButtonPin As Pin  
    Private BUTTON_PIN_NUMBER As Byte = 5  
    ' Server Commands  
    ' BLE HubBin Frame 5-Bytes HDR ADR CMD VAL FTR  
    ' Header and footer  
    Private FRAME_LENGTH As Byte    = 5        'ignore  
    Private FRAME_HEADER As Byte = 0x19  
    Private FRAME_FOOTER As Byte = 0x58  
    ' Addresses  
    Private DEVICE_ADDRESS As Byte = 0x12  
    ' Commands  
    Private Const CMD_SET_ANGLE As Byte = 0x05  
    ' Values  
    Private Const VAL_OPEN As Byte = 0x00  
    Private Const VAL_CLOSE As Byte = 0x01  
    ' Command as HubBin frame  
    Public FRAME_CMD_OPEN() As Byte = Array As Byte(FRAME_HEADER, DEVICE_ADDRESS, CMD_SET_ANGLE, VAL_OPEN, FRAME_FOOTER)  
    Public FRAME_CMD_CLOSE() As Byte = Array As Byte(FRAME_HEADER, DEVICE_ADDRESS, CMD_SET_ANGLE, VAL_CLOSE, FRAME_FOOTER)  
    ' Barrier state  
    Private BARRIER_OPEN As Boolean = True  
    Private BARRIER_CLOSED As Boolean = False    'ignore  
    Private BarrierState As Boolean = BARRIER_OPEN  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("[AppStart] ", VERSION)  
    Log("[AppStart] MAC=", MAC)  
    ' Init GPIO  
    ButtonPin.Initialize(BUTTON_PIN_NUMBER, ButtonPin.MODE_INPUT_PULLUP)  
    ButtonPin.AddListener("OnStateChanged")  
    BarrierState = False  
    ' Init BLE client with debug  
    Client.Initialize(MAC, _  
                         UUID_SERVICE, _  
                      UUID_TX_CHAR, _  
                      UUID_RX_CHAR, _  
                         "OnNewData", "OnError", _  
                      "OnConnected", "OnDisconnected", _  
                      True)  
    ' BLE connect to server  
    Log("[AppStart] Connecting to ", Convert.BytesToHex(MAC))  
    Client.Connect  
    Log("[AppStart] Done")  
End Sub  
  
' Callback when data is received from BLE device.  
Private Sub OnNewData(data() As Byte)  
    Log("[OnNewData] data=", Convert.BytesToHex(data))  
End Sub  
  
' Callback when BLE error occurs  
Private Sub OnError(code As Byte)  
    Log("[OnError] code=", code)  
End Sub  
  
Private Sub OnConnected  
    Log("[OnConnected] OK")  
End Sub  
  
Private Sub OnDisconnected  
    Log("[OnDisconnected][W] OK")  
End Sub  
  
' OnStateChanged  
' Handle button state change.  
' Pressed: state true = 1, Released: state false = 0  
' Only the button pressed state is handled.  
Private Sub OnStateChanged(state As Boolean)  
    If Not(state) Then Return  
    BarrierState = Not(BarrierState)  
    If BarrierState == BARRIER_OPEN Then  
        Client.Write(FRAME_CMD_OPEN)  
    Else  
        Client.Write(FRAME_CMD_CLOSE)  
    End If  
    Log("[OnStateChanged] BarrierState=", BarrierState)  
    Delay(100)  
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

- Developers & maintainers of the [NimBLE library](https://github.com/h2zero/NimBLE-Arduino) (Apache License 2.0).

---

  
  
**Disclaimer**  

- LEGO® is a trademark of the LEGO Group of companies, which does not sponsor, authorize, or endorse this project.
- The Bluetooth® word mark and logos are registered trademarks owned by Bluetooth SIG, Inc.
- BuWizz is a trademark of Fortronik d.o.o.
- All trademarks are property of their respective owners.