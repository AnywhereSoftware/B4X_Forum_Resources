### rBLEServer ESP32 by rwblinn
### 03/10/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/165435/)

**B4R Library rBLEServer  
  
Purpose  
rBLEServer** is an open source library to create a Bluetooth Low Energy (BLE) server.  
  
The purpose is to  

- run the BLE server on ESP32 hardware with sensors & actuators connected.
- connect a single client to read sensor data or set the state of actuator(s).

This B4R library is  

- using the UART service and single characteristic for notify, read, write.
- written in C++ (using the Arduino IDE 2.3.4 and the B4Rh2xml tool).
- tested with an ESP32 Wrover Kit and the Arduino app BLE Scanner.
- tested with B4R 4.00 (64 bit), ESP32 library 3.1.1.

**Files**  
rBLEServer.zip archive contains the library and sample project.  
  
**Install**  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Functions**  
Initialize BLE server  
Name - Name of the BLE server.  
NewDataSub - Sub to handle new data from the connected client.  
ErrorSub - Sub to log an error code.  
mtuSize - Size of the MTU between 23 (default) and 512.  

```B4X
Initialize (Name As String , NewDataSub As SubVoidArray, Error As SubSubVoidByte , mtuSize As UInt)
```

  
  
Flag check client connected  

```B4X
Connected() As Boolean
```

  
  
Write data to BLE client  
data = Array as Bytes  

```B4X
Write (data() As Byte)
```

  
  
**Constants**  
Warning and error codes  

```B4X
Byte WARNING_INVALID_MTU  
Byte ERROR_INVALID_CHARACTERISTIC  
Byte ERROR_EMPTY_DATA
```

  
  
**Events**  
NewData  
Handle new data received from the connected client.  

```B4X
NewData(buffer() as byte)
```

  
  
Error  
Handle errors BLE communication.  

```B4X
Error(code as byte)
```

  
  
**Examples**  

- Basic - Simple example to start the BLE server and send string "hello" (see below).
- InputOutput - Control traffic-light LED's via push-button or BLE server client (B4A) (see post #3).
- EnvMonitor - Read regular intervals DHT22 Temp+Hum sensor data, set display TM1637 & RGB LEDs T+H indicators, advertise serialized data to BLE server client (B4A) (see post #4).
- Home Assistant UI (HA) - Custom Integration BLE Server DHT; ESP32 advertises data to 2 entities; Listens to commands from HA to set Traffic-Light or advertisement timer-interval (see post #6).
- UI application - B4J Pages with a Python BLE-TCP-Bridge (see post #7).
- UI application - B4J Pages with PyBridge and Bleak (see post #10).

**B4R Basic Example**  
Handle new data received from the connected client. No components connected.  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private BLEServer As BLEServer  
    Private MTUSize As UInt = 100  
    Private bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart]")  
    BLEServer.Initialize("BLEServer", "BLEServer_NewData", "BLEServer_Error", MTUSize)  
    CallSubPlus("Test", 5000, 5)  
End Sub  
  
Private Sub Test(tag As Byte)  
    BLEServer_Write("hello".GetBytes)  
End Sub  
  
Private Sub BLEServer_NewData(buffer() As Byte)  
    Log("[BLEServer_NewData]buffer=",bc.HexFromBytes(buffer))  
    Log("[BLEServer_NewData]connected=",BLEServer.Connected)  
End Sub  
  
Private Sub BLEServer_Error(code As Byte)  
    Log("[BLEServer_Error]code=",code)  
    Select code  
        Case BLEServer.WARNING_INVALID_MTU  
            Log("[WARNING][Initialize] MTU out of range 23-512, set default 23.")  
        Case BLEServer.ERROR_INVALID_CHARACTERISTIC  
            Log("[ERROR][Write] failed: No valid characteristic.")  
        Case BLEServer.ERROR_INVALID_CHARACTERISTIC  
            Log("[ERROR][Write] failed: No data.")  
    End Select  
End Sub  
  
Private Sub BLEServer_Write(data() As Byte)  
    If data == Null Then  
        Log("[ERROR][BLEServer_Write] No data.")  
        Return  
    End If  
    Log("[BLEServer_Write]data=",bc.HexFromBytes(data))  
    BLEServer.Write(data)  
End Sub
```

  
  
**ToDo**  

- Explore B4J UI Application with new PyBridge instead BLE-TCP-Bridge.

**Licence**  
GNU General Public License v3.0.