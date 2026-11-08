[B]B4R Library rNimBLEServer[/B]
[HR][/HR]

[B]Brief
rNimBLEServer[/B] is an open-source library provides resource-efficient BLE server functionality on ESP32 for B4R.

[HR][/HR]

[B]Purpose[/B]
* This wrapper exposes a minimal BLE server interface for B4R, allowing:
 * - Advertising a BLE service
 * - Receiving data from clients (Write)
 * - Sending notifications to clients
 * - Handling connection lifecycle events
 
Designed to mirror rNimBLEClient for consistency.


[HR][/HR]

[B]Development Info[/B]
This B4R library is:
[LIST]
[*]a thin B4R NimBLE Server Wrapper.
[*]Using the MAC address of the BLE peripheral, standard GATT services, and characteristics UUIDs.
[*]Written in C++ (Arduino IDE 2.3.4 and [I]B4Rh2xml[/I] tool).
[*]Depends on the platform esp32@3.3.6, NimBLE library 2.3.8.
[*]Tested with ESP-WROOM-32.
[*]Tested with B4R 4.00 (64-bit)
[/LIST]

[HR][/HR]
[B]Compatibility[/B]
[LIST]
[*]Supports [B]ESP32-based boards only[/B] (ESP8266 and AVR not supported).
[*]Handles one BLE peripheral at a time.
[/LIST]

[HR][/HR]
[B]Files[/B]
The [I]rNimBLEServer.zip[/I] archive contains the library and examples.

[HR][/HR]
[B]Install[/B]
Copy the [I]rNimBLEServer[/I] library folder from the ZIP into your B4R [B]Additional Libraries[/B] folder, keeping the folder structure intact.
[I]Ensure[/I] the ESP32 platform and the NimBLE library are installed using the Arduino IDE libraries manager.

[HR][/HR]
[B]Functions[/B]

[U]Initialize(MAC() as Byte, Service As String, TxChar As String, RxChar As String, NewData As String, OnError As String, , OnConnected As String, OnDisconnected As String, Debug As Boolean)[/U]
Initializes the BLE client.
[B]MAC[/B] - BLE peripheral MAC address.
[B]Service[/B] - UUID of the BLE service to connect to.
[B]TxChar[/B] - Characteristic UUID for writing (TX).
[B]RxChar[/B] - Characteristic UUID for notifications (RX). If NULL or empty, the TX characteristic is also used for RX.
[B]NewData[/B] - Callback when new data is received.
[B]OnError[/B] - Callback when an error occurs.
[B]OnConnected[/B] - Callback when a client connects.
[B]OnDisconnected[/B] - Callback when a client disconnects.
[B]Debug[/B] - Boolean flag for extra logging.

[U]bool Connect[/U]
Starts the connection process and service discovery.
[B]Returns[/B] - True if successfully connected and characteristics found.

[U]Disconnect[/U]
Terminates an existing connection and cleans up resources.

[U]IsConnected[/U]
Checks the current connection status.
[B]Returns[/B] - True if connected, False otherwise.

[U]Write(data() As Byte)[/U]
Sends a byte array to the connected BLE peripheral.


[HR][/HR]

[U]Error codes[/U]
ERROR_CREATE_BLE_CLIENT = 1
ERROR_FAILED_TO_CONNECT = 2
ERROR_SERVICE_NOT_FOUND = 3
ERROR_CHARACTERISTICS_NOT_FOUND = 4

[HR][/HR]

[B]Example[/B]
Start the BLE server, await client connection, listen to new data and log.
[CODE=b4x]
Sub Process_Globals
	Private VERSION As String = "rNimBLEServer Basic v20260325"
    Public Serial1 As Serial
	Private BleServer As NimBLEServer
End Sub

Sub AppStart
	Serial1.Initialize(115200)
	Log("[AppStart][I] ", VERSION)
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
	Log("[AppStart][I] BLE Server started")
End Sub

Sub OnConnected
	Log("[OnConnected][I] Client connected")
End Sub

Sub OnDisconnected
	Log("[OnDisconnected][W] Client disconnected")
End Sub

' Handle data received from connected client
' Example: [OnWrite][I] RX:5 1912050058
Sub OnWrite (Buffer() As Byte)
	Log("[OnWrite][I] RX:", Buffer.Length, " ", Convert.BytesToHex(Buffer))
	' Take any action
	' ...
End Sub
[/CODE]

[HR][/HR]

[B]Troubleshooting[/B]
[LIST]
[*]If connect fails, check that the peripheral is powered and advertising.
[*]Some devices stop advertising once connected; reset the device if necessary.
[*]Ensure MAC address and UUIDs are correct.
[/LIST]

[HR][/HR]
[B]License[/B]
MIT License – see LICENSE file.

[HR][/HR]

[B]Credits[/B]
[LIST]
[*]Developers & maintainers of the NimBLE library [https://github.com/h2zero/NimBLE-Arduino] (Apache License 2.0).
[/LIST]

[HR][/HR]

[B]Disclaimer[/B]
[LIST]
[*]LEGO® is a trademark of the LEGO Group of companies, which does not sponsor, authorize, or endorse this project.
[*]The Bluetooth® word mark and logos are registered trademarks owned by Bluetooth SIG, Inc.
[*]BuWizz is a trademark of Fortronik d.o.o.
[*]All trademarks are property of their respective owners.
[/LIST]