[B]B4R Library rBLEServer

Purpose
rBLEServer[/B] is an open source library to create a Bluetooth Low Energy (BLE) server.

The purpose is to
[LIST]
[*]run the BLE server on ESP32 hardware with sensors & actuators connected.
[*]connect a single client to read sensor data or set the state of actuator(s).
[/LIST]
This B4R library is
[LIST]
[*]using the UART service.
[*]written in C++ (using the Arduino IDE 2.3.4 and the B4Rh2xml tool).
[*]tested with an ESP32 Wrover Kit and the Arduino app BLE Scanner.
[*]tested with B4R 4.00 (64 bit), ESP32 library 3.1.1.
[/LIST]
[B]Files[/B]
rBLEServer.zip archive contains the library and sample project.

[B]Install[/B]
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.

[B]Functions[/B]
[U]Initialize BLE server[/U]
Name - Name of the BLE server.
NewDataSub - Sub to handle new data from the connected client.
ErrorSub - Sub to log an error code.
mtuSize - Size of the MTU between 23 (default) and 512.
[CODE=b4x]
Initialize (Name As String , NewDataSub As SubVoidArray, Error As SubSubVoidByte , mtuSize As UInt)
[/CODE]

[U]Flag check client connected[/U]
[CODE=b4x]
Connected() As Boolean
[/CODE]

[U]Write data to BLE client[/U]
data = Array as Bytes
[CODE=b4x]
Write (data() As Byte)
[/CODE]

[B]Constants[/B]
[U]Warning and error codes[/U]
[CODE=b4x]
Byte WARNING_INVALID_MTU
Byte ERROR_INVALID_CHARACTERISTIC
Byte ERROR_EMPTY_DATA   
[/CODE]

[B]Events[/B]
[U]NewData[/U]
Handle new data received from the connected client.
[CODE=b4x]NewData(buffer() as byte)[/CODE]

[U]Error[/U]
Handle errors BLE communication.
[CODE=b4x]Error(code as byte)[/CODE]

[B]Examples[/B]
[LIST]
[*]Basic - Simple example to start the BLE server and send string "hello" (see below).
[*]InputOutput - Control traffic-light LED's via push-button or BLE server client (B4A) (see post #3).
[*]EnvMonitor - Read regular intervals DHT22 Temp+Hum sensor data, set display TM1637 & RGB LEDs T+H indicators, advertise serialized data to BLE server client (B4A) (see post #4).
[/LIST]
[B]B4R Basic Example[/B]
Handle new data received from the connected client. No components connected.
[CODE=b4x]
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
    Log("[BLEServer_NewData]connected=",BLEServer.IsConnected)
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
[/CODE]

[B]To-Do[/B]
Handle multiple clients.

[B]Licence[/B]
MIT - see LICENSE.