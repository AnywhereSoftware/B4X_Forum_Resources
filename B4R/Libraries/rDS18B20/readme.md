### rDS18B20 by rwblinn
### 03/30/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170705/)

**B4R Library rDS18B20**  

---

  
  
**Brief  
rDS18B20** is an open-source library for reading data from a DS18B20 temperature sensor.  
The DS18B20 is a digital temperature sensor (range ~-55 to 125°C) using the 1-Wire interface with one data pin.  

---

  
  
**Purpose**  
This library exposes a minimal interface for B4R, allowing to:  

- read DS18B20 temperature data triggering state change event.
- handle errors using the error event.

---

  
  
**Development Info**  
This B4R library is:  

- using the external Arduino libraries [OneWire](http://www.pjrc.com/teensy/td_libs_OneWire.html) (2.3.8) and [DallasTemperature](http://github.com/milesburton/Arduino-Temperature-Control-Library) (4.0.6).
- Written in C++ (Arduino IDE 2.3.8 and *B4Rh2xml* tool).
- Tested with an Arduino UNO and ESP-WROOM-32.
- Tested with B4R 4.00 (64-bit).

---

  
  
**Files**  
The *rDS18B20-NNN.zip* archive contains the library and examples.  

- Basic - Read temperature using event OnStateChanged.
- Timer - Read temperature using timer every 10 seconds.
- BLEAdvertiser - BLE advertise in regular intervals temperature data.

---

  
  
**Install**  
Copy the *rDS18B20* library folder from the ZIP into your B4R Additional Libraries folder, keeping the folder structure intact.  
*Ensure* the external Arduino libraries OneWire and DallasTemperature are installed using the Arduino IDE libraries manager.  

---

  
  
**Wiring Example**  

```B4X
VCC(+) = 5V  
DAT(out) = GPIO 4 > 4k7 Ω pull-up resistor between the 1-Wire data line and 5V power  
GND(-) = GND
```

  

---

  
  
**Functions**  
  
Initialize(Pin As Byte, Resolution As Byte, StateChangedSub As String, ErrorSub As String)  
Initializes the device.  
**Pin** - MCU pin number to connect the sensor data signal.  
**Resolution** - Resolution 9 (0.5°C), 10 (0.25°C), 11 (0.125°C), or 12 (0.0625°C, default) bits.  
**StateChangedSub** - Callback for the `StateChanged` event.  
**ErrorSub** - Callback for the `Error` event.  
  
IsInitialized As Boolean  
Check if sensor is properly initialized.  
**Returns** false if there was a failure.  
  
GetTemperature As Float  
Read temperature from DS18B20 (Celsius).  
Returns nan if there was a failure.  
  
setEventEnabled(state As Boolean)  
getEventEnabled As Boolean  
Set/Get enabled state change event.  
  
SetDebug(Enabled As Boolean)  
Toggles verbose Serial logging for the library.  
**Enabled** - True to enable debug output.  
  
**Constants**  
ADC\_RESOLUTION\_9  
ADC\_RESOLUTION\_10  
ADC\_RESOLUTION\_11  
ADC\_RESOLUTION\_12  
ERR\_INVALID\_RESOLUTION  
ERR\_NO\_SENSOR\_FOUND  

---

  
  
**Example**  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rDS18B20 Basic v20260329"  
   
    'Serial  
    Public serialLine As Serial  
    Private SERIALLINE_BAUDRATE As ULong = 115200  
  
    'Sensor  
    Private Sensor As DS18B20                   
    Private PIN_NUMBER As Byte = 4  
End Sub  
  
Private Sub AppStart  
    serialLine.Initialize(SERIALLINE_BAUDRATE)  
    Log("[AppStart] ", VERSION)  
  
    Sensor.SetDebug(True)  
  
    Sensor.Initialize(PIN_NUMBER, _  
                      Sensor.ADC_RESOLUTION_12, _  
                      "OnStateChanged", _  
                      "OnError")  
  
    If Not(Sensor.IsInitialized) Then  
        Return  
    End If  
  
    Log("[AppStart] OK")  
End Sub  
  
Private Sub OnStateChanged(t As Float)  
    Log("[OnStateChanged] t=", t)  
End Sub  
  
Private Sub OnError(code As Byte)  
    Log("[OnError][E] code=", code)  
End Sub
```

  
  
Logging Example  

```B4X
[OnStateChanged] t=19.4375  
[OnStateChanged] t=19.5000  
[OnStateChanged] t=19.5625  
[OnStateChanged] t=19.6250
```

  

---

  
  
**License**  
MIT - see LICENSE file.  

---

  
  
**Credits**  

- Developers & maintainers of the OneWire and DallasTemperature libraries (MIT License).

---

  
  
**Disclaimer**  

- All trademarks are property of their respective owners.