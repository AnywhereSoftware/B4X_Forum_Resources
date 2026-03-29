# Example Custom

## Overview
ESP32 BLE Client (client) sends 5-bytes to the ESP32 BLE Server (server).
The server data received is used to set the position open/close of an GeekServo with LEGO technic arm.

## Data Format
The BLE server processes a 5-byte command received from any connected client via BLE.
This is the 5-byte protocol, called HubBin, from the author's HubController project.
```
Byte 1 = Header 	- 0x19 (Fix)
Byte 2 = Address	- 0x12
Byte 3 = Command	- 0x05
Byte 4 = Value		- 0x00 or 0x01 or a value between 0x5A (DEC 90) and 0x87 (DEC 135)
Byte 5 = Footer 	- 0x58 (Fix)
```

## Example
Set angle direct:
```
Servo Pos Close:	1912058758
Servo Pos Open:		1912055A58
```

Set Open or Close
```
Servo Pos Close:	1912050058
Servo Pos Open:		1912050158
```

