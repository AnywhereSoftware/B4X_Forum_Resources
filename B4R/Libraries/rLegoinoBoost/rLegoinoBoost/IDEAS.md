# IDEAS rLegoinoBoost

### NEW: Callback Event Enhance With TiltSensorX and TiltSensorY
Enhance the event with two parameter tx and ty:
```
//~Event: StateChangedEx (Connected As Boolean, Battery As Byte, Voltage As Double, Distance As Double, Color As Int, TiltX As Int, TiltY As Y)
typedef void (*SubVoidBoost)(bool s, Byte bl, Double vs, Double ds, Int cs, Int tx, Int ty);
```
then follow the property *lastBatteryLevel* and add TiltSensorX, int TiltSensorY accordigly.
#### Status
Not started.

### NEW: Client Control via Serial Line
There are two communication routes:
1. B4J USB Serial Line = ESP32 Mini USB Serial Line
2. ESP32 BLE = MoveHUB BLE
Communication
B4J Serial Line - AsyncStream - B4RSerializer = B4R Serial Line - AsyncStream - B4RSerializer
B4R BLE - ASyncStream = MoveHUB BLE
#### Status
20211006: Completed.

### NEW: Client Control via WiFi
Like previous but then using communication between B4J and B4R on the ESP32 via WiFi.
B4J WiFi - AsyncStreams > B4RSerializer = B4R WiFi AsyncStreams > B4RSerializer
#### Status
20211006: Completed.

### NEW: Client Control via BLE
B4J BLE - AsyncStreams > B4RSerializer = B4R WiFi AsyncStreams > B4RSerializer
#### Status
This does not work as the ESP32 BLE is used to communicate between the ESP32 and MoveHUB.
It is not possible to have two BLE connections:
1. B4J BLE > ESP32 BLE and 2. ESP32 > MoveHUB.
Need to explore if there are ESP32 having multiple BLE enabled.
20211006: ON HOLD.

### NEW: Brownout detector was triggered
In the B4R log, the message "Brownout detector was triggered" occurred.
This happens on a KeeYees ESP32.
The cause could be various, like a hardware defect, junk usb cable low power supply, clone ESP32.
Checked the pins and one of the soldered pins might not be ok.
See here for more info (as an example): https://github.com/nkolban/esp32-snippets/issues/168
#### Status
Changed the KeeYees ESP32 to an ESP32 NodeMCU Module WLAN WiFi Dev Kit C Development Board with CP2102.
No log message "Brownout detector was triggered" anymore.
20211006: Completed.
