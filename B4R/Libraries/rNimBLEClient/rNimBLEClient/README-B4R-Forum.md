[B]B4R Library rNimBLEClient[/B]
[HR][/HR]

[B]Brief
rNimBLEClient[/B] is an open-source library for connecting to or scanning Bluetooth Low Energy (BLE) peripherals.

[HR][/HR]

[B]Purpose[/B]
[LIST]
[*]Connect & control BLE peripherals, like BuWizz2, LEGO HUB No 4, or any other device that supports GATT connection.
[/LIST]

[HR][/HR]

[B]Development Info[/B]
This B4R library is:
[LIST]
[*]a thin B4R NimBLE Client Wrapper [https://github.com/h2zero/NimBLE-Arduino].
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
[*]Connects to one BLE peripheral at a time.
[/LIST]

[HR][/HR]
[B]Files[/B]
The [I]rNimBLEClient.zip[/I] archive contains the library and examples.

[HR][/HR]
[B]Install[/B]
Copy the [I]rNimBLEClient[/I] library folder from the ZIP into your B4R [B]Additional Libraries[/B] folder, keeping the folder structure intact.
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
[CODE=b4x]
' Project:		rNimBLEClient
' Brief:		Example to set the angle of a geekservo via BLE.
Private Sub Process_Globals
	Private VERSION 			As String = "rNimBLEClient Client v20260325"
	Public Serial1 				As Serial
	' BLE Client Settings
	Private MAC() 				As Byte = Array As Byte(0x80,0xF3,0xDA,0x4C,0x36,0x7A)	' Address of the server
	Private UUID_SERVICE 		As String = "12345678-1234-1234-1234-1234567890ab"		
	Private UUID_TX_CHAR  		As String = "abcd1234-5678-1234-5678-1234567890ab" 		
	Private UUID_RX_CHAR		As String = "abcd1234-5678-1234-5678-1234567890ab" 		
    Private Client As NimBLEClient
	' GPIO
	Private ButtonPin 			As Pin
	Private BUTTON_PIN_NIMBER 	As Byte = 5
	' Server Commands
	' BLE HubBin Frame 5-Bytes HDR ADR CMD VAL FTR
	' Header and footer
	Private FRAME_LENGTH 		As Byte	= 5		'ignore
	Private FRAME_HEADER 		As Byte = 0x19
	Private FRAME_FOOTER 		As Byte = 0x58
	' Addresses
	Private DEVICE_ADDRESS		As Byte = 0x12
	' Commands
	Private Const CMD_SET_ANGLE	As Byte = 0x05
	' Values
	Private Const VAL_OPEN		As Byte = 0x00
	Private Const VAL_CLOSE  	As Byte = 0x01
	' Command as HubBin frame
	Public FRAME_CMD_OPEN() 	As Byte = Array As Byte(FRAME_HEADER, DEVICE_ADDRESS, CMD_SET_ANGLE, VAL_OPEN, FRAME_FOOTER)
	Public FRAME_CMD_CLOSE() 	As Byte = Array As Byte(FRAME_HEADER, DEVICE_ADDRESS, CMD_SET_ANGLE, VAL_CLOSE, FRAME_FOOTER)
	' Barrier state
	Private BARRIER_OPEN 		As Boolean = True
	Private BARRIER_CLOSED 		As Boolean = False	'ignore
	Private BarrierState 		As Boolean = BARRIER_OPEN
End Sub

Private Sub AppStart
    Serial1.Initialize(115200)
    Log("[AppStart] ", VERSION)
	Log("[AppStart] MAC=", MAC)
	' Init GPIO
	ButtonPin.Initialize(BUTTON_PIN_NIMBER, ButtonPin.MODE_INPUT_PULLUP)
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
	Log("[OnConnected][I] OK")
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
